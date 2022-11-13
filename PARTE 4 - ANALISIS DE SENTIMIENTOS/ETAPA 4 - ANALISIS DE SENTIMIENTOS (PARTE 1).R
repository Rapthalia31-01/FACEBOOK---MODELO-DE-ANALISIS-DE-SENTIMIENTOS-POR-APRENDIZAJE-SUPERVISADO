## TEMA: APLICACIÓN DE TÉCNICAS DE MINERÍA DE DATOS PARA EL ANÁLISIS DE SENTIMIENTOS EN REDES SOCIALES ORIENTADO A LA PERCEPCIÓN DE LOS USUARIOS ECUATORIANOS SOBRE EL COVID-19
# AUTORAS: MACIAS MERA VANESSA Y PICO PATIÑO ANGELINE

##############################################################################################################################
########## FASE ANÁLISIS DE SENTIMIENTOS POR ALGORITMOS DE CLASIFICACIÓN / APRENDIZAJE AUTOMÁTICO  ###########################
##############################################################################################################################

# establecer directorio de trabajo
covid <- read.csv("C:/TRABAJO DE TITULACION 2022/FACEBOOK - MODELO DE ANALISIS DE SENTIMIENTOS POR APRENDIZAJE SUPERVISADO/PARTE 3 - TRANSFORMACION DE DATOS/EN RSTUDIO/resultado_etapa3.csv", sep = ",")
covid <- covid$text
# cargar librerías
# if(!require(Rstem)) install_url("http://cran.r-project.org/src/contrib/Archive/Rstem/Rstem_0.4-1.tar.gz")
# if(!require(sentiment)) install_url("http://cran.r-project.org/src/contrib/Archive/sentiment/sentiment_0.2.tar.gz")

# 1) MODELO DE CLASIFICACIÓN NAIVE BAYES CON LA LIBRERÍA SENTIMENT
??classify_emotion

# ALGORITMO NAIVE BAYES
# El análisis de sentimiento es el proceso de determinar si un escrito es positivo, negativo o neutral. También se conoce como minería de opiniones, derivando la opinión o actitud de un hablante. 
# Con un tamaño de datos cada vez mayor, ya no es factible leer el texto manualmente y comprender la emoción. En su lugar, se utiliza un algoritmo que extrae emociones de miles de documentos de texto en segundos.
# Si tenemos un conjunto de datos de entrenamiento, se puede usar un clasificador como Naive Bayes para clasificar las revisiones de texto. Se usó NB para lograr lo mismo.

# EMOCIONES  
  
# Como se describe en la ayuda, esta función clasifica emociones (e.g. anger, disgust, fear, joy, sadness, surprise) de una serie de textos
covid_class_emo <- classify_emotion(covid, algorithm="bayes", prior=1.0)
# La función nos retorna 7 columnas: anger, disgust, fear, joy, sadness, surprise y best_fit para cada fila del documento
head(covid_class_emo)

# Sustuir el nombre de las emociones en ingles a español

covid_class_emo[covid_class_emo == 'anger'] <- 'Enfado'
covid_class_emo[covid_class_emo == 'fear'] <- 'Miedo'
covid_class_emo[covid_class_emo == 'joy'] <- 'Alegria'
covid_class_emo[covid_class_emo == 'sadness'] <- 'Tristeza'
covid_class_emo[covid_class_emo == 'SURPRISE'] <- 'Sorpresa'
covid_class_emo[covid_class_emo == 'DISGUST'] <- 'Asco'

# Ahora lo que vamos a hacer es crear una variable denominada "emotion" en la que guardemos los resultados que ha obtenido el algoritmo de forma ordenada. La que según el algoritmo encaja mejor (BEST_FIT) la guardamos
emotion <- covid_class_emo[, 7]

# sustituir NA por "desconocido"
emotion[is.na(emotion)] <- "Neutral"
table(emotion, useNA = "ifany")

# POLARIDAD

# Ejecutamos la función de clasificación de polaridad
covid_class_pol <- classify_polarity(covid, algorithm="bayes")
head(covid_class_pol, 5)

covid_class_pol[covid_class_pol == 'negative'] <- 'Negativo'
covid_class_pol[covid_class_pol == 'neutral'] <- 'Neutral'
covid_class_pol[covid_class_pol == 'positive'] <- 'Positivo'

# Ahora guardamos con la variable polarity los resultados obtenidos de la columna "BEST_FIT". 
# Esto nos permitirá conocer hacia donde se inclina la balanza, bien hacia comentarios positivos o negativos
polarity <- covid_class_pol[, 4]
head(polarity)
# En una tabla
table(polarity, useNA = 'ifany')

# Podemos recopilar la información en un dataframe por si más adelante queremos utilizarlo. Lo clasificamos en texto, emoción y polaridad.

covid_sentiment_dataframe <- data.frame(text=covid, emotion=emotion, stringsAsFactors=FALSE)
head(covid_sentiment_dataframe, 5)

covid_polarity_dataframe <- data.frame(text=covid, polarity=polarity, stringsAsFactors=FALSE)
head(covid_sentiment_dataframe, 5)

# GRÁFICA DE BARRAS DE EMOCIONES 

ggplot(covid_sentiment_dataframe, aes(x=emotion)) + geom_bar(aes(y=..count.., fill=emotion)) +
  scale_fill_brewer(palette="Dark2") +
  ggtitle("Sentimientos en los comentarios de Facebook de usuarios ecuatorianos", subtitle = "SOBRE EL COVID19 EN EL AÑO 2020") +
  theme(legend.position="right", plot.title = element_text(size=12, face='bold')) + ylab("Número de comentarios") + xlab("Tipos de emoción")


# GRÁFICA DE BARRAS DE PORALIDAD 
ggplot(covid_polarity_dataframe, aes(x=polarity)) +
  geom_bar(aes(y=..count.., fill=polarity)) +
  scale_fill_brewer(palette="RdYlBu") +
  ggtitle("Valoración positiva, neutral o negativa de los comentarios de Facebook", subtitle = " de usuarios ecuatorianos SOBRE EL COVID19 EN EL AÑO 2020") +
  theme(legend.position="bottom", plot.title = element_text(size=11, face='bold')) + ylab("Número de Tweets") + xlab("Tipos de polaridad")


#Se exportan los datos en formato csv

write.csv(covid_sentiment_dataframe,"C:/TRABAJO DE TITULACION 2022/FACEBOOK - MODELO DE ANALISIS DE SENTIMIENTOS POR APRENDIZAJE SUPERVISADO/PARTE 4 - ANALISIS DE SENTIMIENTOS/data_sentimiento.csv")
write.csv(covid_polarity_dataframe,"C:/TRABAJO DE TITULACION 2022/FACEBOOK - MODELO DE ANALISIS DE SENTIMIENTOS POR APRENDIZAJE SUPERVISADO/PARTE 4 - ANALISIS DE SENTIMIENTOS/data_polarizado.csv")

# 2) MODELO DE CLASIFICACIÓN NAIVE BAYES CON LA LIBRERÍA e1071

# La libreria e1071 tiene una función útil, naiveBayes(), para construir modelos de este tipo

# PREPARACIÓN DE DATOS

# establecer directorio de trabajo
covid_polarity_dataframe <- read_csv("C:/TRABAJO DE TITULACION 2022/FACEBOOK - MODELO DE ANALISIS DE SENTIMIENTOS POR APRENDIZAJE SUPERVISADO/PARTE 4 - ANALISIS DE SENTIMIENTOS/data_polarizado.csv")
View(covid_polarity_dataframe)

corpus0 <- iconv(covid_polarity_dataframe$text, to = "UTF-8")
# crear corpus
corpus <- Corpus(VectorSource(corpus0))
# crear matriz de términos
datadtm = DocumentTermMatrix(corpus)
dim(datadtm)

# Ahora podemos trabajar con nuestro modelo sin dificultades y de manera efectiva
# Preparando el DTM
dataset <- as.data.frame(as.matrix(datadtm))
colnames(dataset) <- make.names(colnames(dataset))
dataset$polarity <- covid_polarity_dataframe$polarity
str(dataset$polarity)
# convertir la columna polarity en factor
dataset$polarity <- as.factor(dataset$polarity)

# Dividir los datos en conjuntos de datos Train & Test

# generamos tabla entrenamiento y prueba aleatoriamente
set.seed(222)
# training 80% y testing 20%
split = sample(2,nrow(dataset),prob = c(0.8,0.2),replace = TRUE)
train_set = dataset[split == 1,]
test_set = dataset[split == 2,]
train_set[4:6,57:59]
test_set[4:6,57:59]

# Comparar la proporción de los conjuntos de entrenamiento y prueba con el conjunto de datos, para confirmar que son iguales
prop.table(table(train_set$polarity))
prop.table(table(test_set$polarity))

# CLASIFICADOR NAIVE BAYES 

# Model Training
# Vamos a crear un objeto que contenga un clasificador NaiveBayes que pueda ser utilizado para hacer predicciones
nb_classifier <- naiveBayes(polarity ~., data=train_set, laplace = 1)
nb_classifier

# Predict train
# Para hacer predicciones con nuestro modelo usamos la función predict() de base
# Validando la capacidad de prediccion del set de entrenamiento
nb_predict1 <- predict(nb_classifier, newdata=train_set, type = 'class')
accuracy(nb_predict1,train_set$polarity)

# Model Testing
# Esta función nos pide un modelo y datos nuevos, que en nuestro caso son el set de prueba
nb_pred <- predict(nb_classifier, newdata = test_set, "class")
nb_pred

# Model Evaluation
# Utilizaremos el clasificador para predecir la naturaleza de los comentarios en el dataset de test, y posteriormente 
# comparar las etiquetas generadas con las etiquetas reales.

# Para analizar qué tanto éxito hemos tenido, creamos una matriz de confusión usando la función confusionMatrix() de caret
# Con esta matriz podremos analizar la precisión de nuestras predicciones y algunas medidas de ajuste
confusionMatrix(table(nb_pred,test_set$polarity))






