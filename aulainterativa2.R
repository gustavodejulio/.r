########################################################################################
#             Aula 2 - Regressao Linear para Series Temporais            #
#                       Prof. Máiron Chaves                                                #
########################################################################################

#Caso a biblioteca não esteja instalada na maquina de voces, utilizar o comando: install.packages()
install.packages('forecast')
###################### Carrega Bibliotecas ###############################################
library(dplyr)  #Permite manipular dados com instrucoes semelhantes ao SQL
library(forecast)  #Diversas ferramentas para trabalhar com Séries Temporais
##########################################################################################

vendas_produto_A <- c(797, 842, 852, 863, 892, 895, 925, 929, 927, 923, 919, 875, 
                      893, 940, 981, 1001, 1002, 999, 1029, 1036, 1052, 1054, 1054, 
                      1031)


Vendas_Produto_A <- ts(vendas_produto_A,
                       frequency = 12,
                       start = c(2018,1))

#Visualiza série temporal e autocorrelações
ggtsdisplay(Vendas_Produto_A)

#Visualiza estatísticas descritivas
summary(Vendas_Produto_A)

aux <- decompose(Vendas_Produto_A,type = 'multiplicative')
plot(aux$figure, type = 'b', pch =  16)
#Mes vs ano
seasonplot(Vendas_Produto_A,12,
           col=rainbow(12),
           year.labels=TRUE,
           type = "o",
           pch = 16);grid()

#Ajusta modelo linear por Mínimos Quadrados 
modelo <- tslm(formula = Vendas_Produto_A ~
                 trend +
                 season) 
summary(modelo)

plot(Vendas_Produto_A,type = 'b',col = 'black',pch = 16)

lines(modelo$fitted.values,
      col = "blue",
      type ="b",
      pch =16)
legend("topleft", c("Vendas","Previsoes"),
       col=c("black",'blue'), lty=c(1,1),bty="n", cex=0.6, lwd=2)

accuracy(Vendas_Produto_A, modelo$fitted.values)

predicoes <- forecast(modelo, h = 12)
plot(predicoes)

predicoes

modelo <- hw(Vendas_Produto_A)


diretorio_e_arquivo <- paste(diretorio,"/ForestModelTreined.RData",sep = "")

save(modelo,file = diretorio_e_arquivo)
load("c:/model.RData")


predict(modelo, newdata = novos_dados)