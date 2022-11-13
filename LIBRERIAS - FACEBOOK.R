# TEMA: APLICACIÓN DE TÉCNICAS DE MINERÍA DE DATOS PARA EL ANÁLISIS DE SENTIMIENTOS EN REDES SOCIALES ORIENTADO A LA PERCEPCIÓN DE LOS USUARIOS ECUATORIANOS SOBRE EL COVID-19
# AUTORAS: MACIAS MERA VANESSA Y PICO PATIÑO ANGELINE

########################################################################################################
################################### DESCARGAR E IMPORTAR LIBRERÍAS #####################################
########################################################################################################

#Para la correcta instalacion de Rtools es requisito
#tener instalado la libreria devtools
require("devtools")
#Sentencia para instalar libreria desde consola
install.packages("Rtools")
#Sentencia para instalar la libreria Rstem desde el repositorio de R
install_url("http://cran.r-project.org/src/contrib/Archive/Rstem/Rstem_0.4-1.tar.gz")
#Sentencia para instalar la libreria sentimient desde el repositorio de R
install_url("http://cran.r-project.org/src/contrib/Archive/sentiment/sentiment_0.2.tar.gz")

# LAS DEMÁS LIBRERÍAS SE DESCARGAN MANUALMENTE EN PACKAGES Y CLIC EN INSTALL + "NOMBRE DE LA LIBRERÍA A INSTALAR"
# O cada uno de los paquetes o librerías se se cargan deben estar previamente instalados con la función install.packages("nombre del paquete o librería")

library(tidyverse);library(textcat);library(ggplot2);library(tm);library(SnowballC);library(wordcloud); 
library(dplyr);library(rpart);library(rpart.plot);library(randomForest);library(caret);library(streamR);
library(nnet);library(Metrics);library(treemapify);library(lubridate);library(rtweet);library(httpuv)
library(gganimate);library(gifski);library(av);library(gapminder);library(readr);library(stringr);library(purrr);
library(textclean);library(qdapRegex);library(stopwords);library(Rstem);library(sentiment);library(gridExtra);
library(qdap);library(RColorBrewer);library(tidytext);library(tidyr);library(reshape2);library(lexicon);
library(textdata);library(syuzhet);library(quanteda);library(quanteda.textplots);library(readtext);library(ggrepel);
library(ggplot2);library(textstem);library(ROAuth);library(base64enc);library(rjson);library(ndjson);library(RCurl);
library(e1071);library(DT)