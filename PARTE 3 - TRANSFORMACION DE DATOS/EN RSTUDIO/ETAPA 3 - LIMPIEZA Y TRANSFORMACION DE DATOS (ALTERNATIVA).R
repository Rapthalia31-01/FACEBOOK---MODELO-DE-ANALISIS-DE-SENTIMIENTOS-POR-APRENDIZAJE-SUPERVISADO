## TEMA: APLICACIÓN DE TÉCNICAS DE MINERÍA DE DATOS PARA EL ANÁLISIS DE SENTIMIENTOS EN REDES SOCIALES ORIENTADO A LA PERCEPCIÓN DE LOS USUARIOS ECUATORIANOS SOBRE EL COVID-19
# AUTORAS: MACIAS MERA VANESSA Y PICO PATIÑO ANGELINE
 
##############################################################################################################################
################################### FASE LIMPIEZA DE DATOS Y TRANSFORMACIÓN ALTERNATIVA  #####################################
##############################################################################################################################

# IMPORTAR CONJUNTO DE DATOS CON EL COMANDO READ

data_covidFB <- read_csv("C:/TRABAJO DE TITULACION 2022/FACEBOOK - MODELO DE ANALISIS DE SENTIMIENTOS POR APRENDIZAJE SUPERVISADO/PARTE 3 - TRANSFORMACION DE DATOS/EN OPEN REFINE/data_covidFB.csv")
View(data_covidFB)

data_covidFB$message<- iconv(data_covidFB$message, "UTF-8", "ASCII//TRANSLIT", sub="")  #caracteres especiales
X <- data_covidFB$message


# crear corpus
X <- Corpus(VectorSource(X))
inspect(X[1:5])

# LIMPIEZA

x1 <- tm_map(X, tolower)
x1 <- tm_map(x1, removeNumbers)
x1 <- tm_map(x1, removePunctuation)
x1 <- tm_map(x1, removeWords, stopwords("spanish"))
toSpace <- content_transformer(function (x , pattern ) gsub(pattern, " ", x))
x1 <- tm_map(x1, toSpace, "http\\S+\\s*")
x1 <- tm_map(x1, toSpace, "http[[:alnum:]]*")
x1 <- tm_map(x1, toSpace, "#\\S+")
x1 <- tm_map(x1, toSpace, "@\\S+")
x1 <- tm_map(x1, toSpace, "[[:cntrl:]]")
x1 <- tm_map(x1, toSpace, "[[:punct:]]+")
x1 <- tm_map(x1, toSpace, "\\d")

x1 <- tm_map(x1, removeWords, c("una", "por", "sobre", "sus", "que", "para", "como", "con", "los", "las", "user", "mas", "en", "para", "uv", "mmmmm npi", "k", "uide", "url",
                                "url", "ano", "solo", "ser", "estan", "dio", "asi", "pued", "aqui", "nueva", "dos", "frent", "rightarrow", "trave", "despu", "tras", "part", "cada", 
                                "hace", "tambien", "hace", "arrowdown", "hacer", "conoc", "sera", "meno", "tener", "primer", "aun", "dice", "ver", "mientra", "sigu", "luego", "lune", 
                                "arrowforward", "whitecheckmark", "tan", "call", "sobr", "est", "van"))  
x1 <- tm_map(x1, stripWhitespace)

# Remueve emojis
x1<-tm_map(x1, content_transformer(gsub), pattern="\\W",replace=" ")

# Elimina URL
removeURL <- function(x) gsub("http[^[:space:]]*", " ", x)
mydata <- tm_map(x1, content_transformer(removeURL))

# Lematización
x1 <- lemmatize_words(x1)

inspect (x1[1:5])

#Se exportan los datos en formato csv
write.csv(x1,"C:/TRABAJO DE TITULACION 2022/FACEBOOK - MODELO DE ANALISIS DE SENTIMIENTOS POR APRENDIZAJE SUPERVISADO/PARTE 3 - TRANSFORMACION DE DATOS/EN RSTUDIO/resultado_etapa3.csv")

# Crea una matriz de terminos y que se almacena como tdm
tdm <-TermDocumentMatrix(x1)
m <- as.matrix(tdm)
v <- sort(rowSums(m),decreasing=TRUE)
d <- data.frame(word = names(v),freq=v)
head(d, 10)

d[d == 'salusted'] <- 'salud'


# ASOCIACION DE PALABRAS
# A traves de la función findAssocs (del paquete tm) encontraremos las asociaciones para cada una de las palabras
# PalabrasRelacionadas <- findAssocs(tdm, terms = findFreqTerms(tdm, lowfreq = 50), corlimit = 0.25) # Fijando una asociacion mínima de 0.25
PalabrasRelacionadas <- findAssocs(tdm, terms = c("muerte","covid" ), corlimit = 0.25) 
PalabrasRelacionadas

# GRAFICA DE ASOCIACION DE PALABRAS
asociaciones_df <- list_vect2df(PalabrasRelacionadas, col2 = "palabra", col3 = "correlacion")
ggplot(asociaciones_df, aes(correlacion, palabra)) + 
  geom_point(size = 3) + 
  theme_classic()

#Se exportan los datos en formato csv
write.csv(d,"C:/TRABAJO DE TITULACION 2022/FACEBOOK - MODELO DE ANALISIS DE SENTIMIENTOS POR APRENDIZAJE SUPERVISADO/PARTE 3 - TRANSFORMACION DE DATOS/EN RSTUDIO/FrecuenciadePalabras.csv")

# NUBE DE PALABRAS

wordcloud(words = d$word, freq = d$freq, min.freq = 1,
          max.words=100, random.order=FALSE, rot.per=0.35, 
          colors=brewer.pal(8, "Dark2"))

# GRÁFICO DE FRECUENCIA DE PALBRAS
barplot(d[1:10,]$freq, las = 2, names.arg = d[1:10,]$word,        
        col =heat.colors(10), main ="FRECUENCIA DE PALABRAS", xlab = "Palabra", ylab = "Frecuencia", cex.names=0.8)


