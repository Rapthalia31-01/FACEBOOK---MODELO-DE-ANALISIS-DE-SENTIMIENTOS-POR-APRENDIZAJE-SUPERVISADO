## TEMA: APLICACIÓN DE TÉCNICAS DE MINERÍA DE DATOS PARA EL ANÁLISIS DE SENTIMIENTOS EN REDES SOCIALES ORIENTADO A LA PERCEPCIÓN DE LOS USUARIOS ECUATORIANOS SOBRE EL COVID-19
# AUTORAS: MACIAS MERA VANESSA Y PICO PATIÑO ANGELINE

##############################################################################################################################
########## FASE ANÁLISIS DE SENTIMIENTOS POR ALGORITMOS DE CLASIFICACIÓN / APRENDIZAJE AUTOMÁTICO  ###########################
##############################################################################################################################

# OTROS MODELOS DE CLASIFICACIÓN: 
#Algoritmo Árboles de Decisión
#Algoritmo Bosques Aleatorios
#Algoritmo Regresión logística Multinomial

# a)Decision Tree

# Model Training
# Para entrenar el modelo, usaremos la función rpart del paquete rpart. Una vez que el modelo esté entrenado, 
# probaremos usando la función de predicción
dt_classifier <- rpart(polarity ~ ., data= train_set, method="class", minbucket= 25)
dt_classifier 

# Predict train
# Validando la capacidad de prediccion
dt_predict1 <- predict(dt_classifier, newdata=train_set, type="class")
accuracy(dt_predict1,train_set$polarity)

# Model Testing
# Predicción de los resultados del conjunto de pruebas
dt_pred = predict(dt_classifier, newdata=test_set, type="class")
dt_pred

# Model Evaluation
# Matriz de confusion resultante
confusionMatrix(table(dt_pred,test_set$polarity))

# b) Random Forest Model

# Model Training
# Para entrenar el modelo, usaremos la función randomForest del paquete randomForest
rf_classifier = randomForest(polarity ~., data=train_set, ntree = 20)
rf_classifier

# Predict train
# Validando la capacidad de prediccion
rf_predict1 <- predict(rf_classifier, newdata=train_set, type="class")
accuracy(rf_predict1,train_set$polarity)

# Model Testing
# Predicción de los resultados del conjunto de pruebas
rf_pred = predict(rf_classifier,  test_set,"class")

# Model Evaluation
# Matriz de confusion resultante
confusionMatrix(table(rf_pred, test_set$polarity))

# c) Multinomial Logistic Regression

# Model Training
# Para entrenar el modelo, usaremos la función multinom del paquete nnet
lg_classifier <- multinom(polarity ~., data=train_set, MaxNWts =5130)
lg_classifier

# Predict train
# Validando la capacidad de prediccion
lg_predict1 <- predict(lg_classifier, newdata=train_set, type="class")
accuracy(lg_predict1,train_set$polarity)

# Model Testing
# Predicción de los resultados del conjunto de pruebas
lg_pred <- predict(lg_classifier, newdata = test_set, "class")

# Model Evaluation
# Matriz de confusion resultante
confusionMatrix(table(lg_pred,test_set$polarity))
