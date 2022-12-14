## TEMA: APLICACI?N DE T?CNICAS DE MINER?A DE DATOS PARA EL AN?LISIS DE SENTIMIENTOS EN REDES SOCIALES ORIENTADO A LA PERCEPCI?N DE LOS USUARIOS ECUATORIANOS SOBRE EL COVID-19
# AUTORAS: MACIAS MERA VANESSA Y PICO PATI?O ANGELINE

##############################################################################################################################
########## FASE AN?LISIS DE SENTIMIENTOS POR ALGORITMOS DE CLASIFICACI?N / APRENDIZAJE AUTOM?TICO  ###########################
##############################################################################################################################

# OTROS MODELOS DE CLASIFICACI?N: 
#Algoritmo ?rboles de Decisi?n
#Algoritmo Bosques Aleatorios
#Algoritmo Regresi?n log?stica Multinomial

# a)Decision Tree

# Model Training
# Para entrenar el modelo, usaremos la funci?n rpart del paquete rpart. Una vez que el modelo est? entrenado, 
# probaremos usando la funci?n de predicci?n
dt_classifier <- rpart(polarity ~ ., data= train_set, method="class", minbucket= 25)
dt_classifier 

# Predict train
# Validando la capacidad de prediccion
dt_predict1 <- predict(dt_classifier, newdata=train_set, type="class")
accuracy(dt_predict1,train_set$polarity)

# Model Testing
# Predicci?n de los resultados del conjunto de pruebas
dt_pred = predict(dt_classifier, newdata=test_set, type="class")
dt_pred

# Model Evaluation
# Matriz de confusion resultante
confusionMatrix(table(dt_pred,test_set$polarity))

# b) Random Forest Model

# Model Training
# Para entrenar el modelo, usaremos la funci?n randomForest del paquete randomForest
rf_classifier = randomForest(polarity ~., data=train_set, ntree = 20)
rf_classifier

# Predict train
# Validando la capacidad de prediccion
rf_predict1 <- predict(rf_classifier, newdata=train_set, type="class")
accuracy(rf_predict1,train_set$polarity)

# Model Testing
# Predicci?n de los resultados del conjunto de pruebas
rf_pred = predict(rf_classifier,  test_set,"class")

# Model Evaluation
# Matriz de confusion resultante
confusionMatrix(table(rf_pred, test_set$polarity))

# c) Multinomial Logistic Regression

# Model Training
# Para entrenar el modelo, usaremos la funci?n multinom del paquete nnet
lg_classifier <- multinom(polarity ~., data=train_set, MaxNWts =5130)
lg_classifier

# Predict train
# Validando la capacidad de prediccion
lg_predict1 <- predict(lg_classifier, newdata=train_set, type="class")
accuracy(lg_predict1,train_set$polarity)

# Model Testing
# Predicci?n de los resultados del conjunto de pruebas
lg_pred <- predict(lg_classifier, newdata = test_set, "class")

# Model Evaluation
# Matriz de confusion resultante
confusionMatrix(table(lg_pred,test_set$polarity))
