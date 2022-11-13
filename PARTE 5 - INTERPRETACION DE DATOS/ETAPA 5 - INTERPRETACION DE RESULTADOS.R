# TEMA: APLICACIÓN DE TÉCNICAS DE MINERÍA DE DATOS PARA EL ANÁLISIS DE SENTIMIENTOS EN REDES SOCIALES ORIENTADO A LA PERCEPCIÓN DE LOS USUARIOS ECUATORIANOS SOBRE EL COVID-19
# AUTORAS: MACIAS MERA VANESSA Y PICO PATIÑO ANGELINE

###########################################################################################################
################################### FASE INTERPRETACION DE RESULTADOS #####################################
###########################################################################################################

# GRÁFICAS

# ASOCIACION DE PALABRAS #
# Exportar un gráfico a png
png(filename = "C:/TRABAJO DE TITULACION 2022/FACEBOOK - MODELO DE ANALISIS DE SENTIMIENTOS POR APRENDIZAJE SUPERVISADO/PARTE 5 - INTERPRETACION DE DATOS/Rplot_AsociacionDePalabras_FB.png", width = 800, height = 600)

ggplot(asociaciones_df, aes(correlacion, palabra)) + 
  geom_point(size = 3) + 
  theme_classic()

# Para cerrar el dispositivo gráfico que hemos elegido
dev.off() 

# NUBE DE PALABRAS #
# Exportar un gráfico a png
png(filename = "C:/TRABAJO DE TITULACION 2022/FACEBOOK - MODELO DE ANALISIS DE SENTIMIENTOS POR APRENDIZAJE SUPERVISADO/PARTE 5 - INTERPRETACION DE DATOS/Rplot_NubeDePalabras_FB.png", width = 800, height = 600)

# Cada vez que ejecute la función le mostrará diferentes resultados, para evitarlo si así se desea, puede fijar un estado inicial para generar números aleatorios que utiliza la función wordcloud
set.seed(1234)
# Función para graficar la frecuencia de palabras, el tamaño de la palabra graficada será proporcional a la frecuencia de la misma. Esta función grafica las palabras en word con sus respectivas frecuencias freq, sólo usará las palabras que como mínimo tenga una frecuencia mínima min.freq, la cantidad de palabras en graficadas es igual a maxwords, las posiciones podrán ser aleatorias o no, dependiendo del valor de random.order, los colores estan dados en forma de lista en colors
wordcloud(words = d$word, freq = d$freq, min.freq = 1,
          max.words=100, random.order=FALSE, rot.per=0.35, 
          colors=brewer.pal(8, "Dark2"))
# Para cerrar el dispositivo gráfico que hemos elegido
dev.off() 

# HISTOGRAMA DE FRECUENCIAS DE PALABRAS #

# Exportar un gráfico a png
png(filename = "C:/TRABAJO DE TITULACION 2022/FACEBOOK - MODELO DE ANALISIS DE SENTIMIENTOS POR APRENDIZAJE SUPERVISADO/PARTE 5 - INTERPRETACION DE DATOS/Rplot_HistogramaFrecuenciaPalabras_FB.png", width = 800, height = 600)

barplot(d[1:10,]$freq, las = 2, names.arg = d[1:10,]$word,        
        col =heat.colors(10), main ="FRECUENCIA DE PALABRAS EN COMENTARIOS DE FACEBOOK SOBRE EL COVID19 DURANTE EL 2020", xlab = "Palabra", ylab = "Frecuencia", cex.names=0.8)

# Para cerrar el dispositivo gráfico que hemos elegido
dev.off() 

# BARRAS DE EMOCIONES #

# Exportar un gráfico a png
png(filename = "C:/TRABAJO DE TITULACION 2022/FACEBOOK - MODELO DE ANALISIS DE SENTIMIENTOS POR APRENDIZAJE SUPERVISADO/PARTE 5 - INTERPRETACION DE DATOS/Rplot_BarraEmociones_FB.png", width = 800, height = 600)

ggplot(covid_sentiment_dataframe, aes(x=emotion)) + geom_bar(aes(y=..count.., fill=emotion)) +
  scale_fill_brewer(palette="Dark2") +
  ggtitle("Sentimientos en los comentarios de Facebook de usuarios ecuatorianos", subtitle = "SOBRE EL COVID19 EN EL AÑO 2020") +
  theme(legend.position="right", plot.title = element_text(size=12, face='bold')) + ylab("Número de comentarios") + xlab("Tipos de emoción")

# Para cerrar el dispositivo gráfico que hemos elegido
dev.off() 

# BARRAS DE POLARIDAD #

# Exportar un gráfico a png
png(filename = "C:/TRABAJO DE TITULACION 2022/FACEBOOK - MODELO DE ANALISIS DE SENTIMIENTOS POR APRENDIZAJE SUPERVISADO/PARTE 5 - INTERPRETACION DE DATOS/Rplot_BarraPolaridad_FB.png", width = 800, height = 600)

ggplot(covid_polarity_dataframe, aes(x=polarity)) +
  geom_bar(aes(y=..count.., fill=polarity)) +
  scale_fill_brewer(palette="RdYlBu") +
  ggtitle("Valoración positiva, neutral o negativa de los comentarios de Facebook", subtitle = " de usuarios ecuatorianos SOBRE EL COVID19 EN EL AÑO 2020") +
  theme(legend.position="bottom", plot.title = element_text(size=11, face='bold')) + ylab("Número de Tweets") + xlab("Tipos de polaridad")

# Para cerrar el dispositivo gráfico que hemos elegido
dev.off() 
