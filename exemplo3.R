###########################################################
####### Intervalo de Confian�a #######
## AED - Capitulo 03 - Prof. M�iron Chaves ####
###########################################################
#Copie este c�digo, cole no seu R e execute para ver os resultados
########## Intervalo de confian�a para m�dia amostral pela distribui��o Normal Padr�o #############################
# Obter o intervalo de confian�a para uma vari�vel cuja m�dia = 30, desvio padr�o = 7,31 e n = 30
#Temos que definir o n�vel de confian�a do nosso intervalo.
#Podemos obter o valor do quantil para o n�vel de confian�a desejado com a fun��o qnorm()
#O quantil na distribui��o normal padr�o para 95% de confian�a
ic <- 0.95
alfa <- 1-ic
1-(alfa/2)
qnorm(0.975)

#Vamos armazenar os valores em objetos
media <- 30
desvio_padrao_populacional <- 7.31
n <- 30
quantil_95 <- qnorm(0.975)

#Aplicando a f�rmula vista na apostila fica:
Limite_Superior <- 30+quantil_95*(desvio_padrao_populacional/sqrt(n))
Limite_Inferior <- 30-quantil_95*(desvio_padrao_populacional/sqrt(n))
paste("Com 95% de confian�a, podemos afirmar que a m�dia varia entre",Limite_Inferior," e ",Limite_Superior)

####################### Intervalo de confian�a para a m�dia amostral pela distribui��o t de Student ############
#A teoria nos diz para utilizar a distribui��o t de Student quando n�o soubermos o desvio padr�o populacional.
#Vamos assumir que o desvio padr�o que temos � obtido a partir da amostra
#Vamos armazenar os valores em objetos
media <- 30

desvio_padrao_amostral <- 7.31
n <- 30
quantil_95_t <- qt(0.975,df = n-1)

#Aplicando a f�rmula vista na apostila fica:
Limite_Superior_t <- 30+quantil_95_t*(desvio_padrao_amostral/sqrt(n))
Limite_Inferior_t <- 30-quantil_95_t*(desvio_padrao_amostral/sqrt(n))
paste("Com 95% de confian�a, podemos afirmar que a m�dia varia entre",Limite_Inferior_t," e ",Limite_Superior_t)

#Supondo que nossa vari�vel j� esteja em um data frame aqui no R, tem um comando para fornecer o intervalo de confian�a de forma bem mais f�cil
#Vamos gerar com o comando rnorm() uma vari�vel aleatoria com m�dia 30, desvio padr�o 7,31 e n = 30
va <- rnorm(n = 30, mean = 30, sd = 7.31)

#Vamos visualizar a va gerada
hist(va)

#Calculando o intervalo de 95% de confian�a com a distribui��o t de Student
#com a fun�ao t.test()
IC <-t.test(va, conf.level = 0.95)
IC$conf.int 
#Pronto, j� temos o intervalo de confian�a para m�dia. Beeem mais f�cil assim :)

####################### Intervalo de confian�a para a propor��o ############
#Utilizando o exemplo da apostila, onde calculamos o intervalo para propor��o onde
# 138 de n = 500 clientes realizaram a devolu��o do produto
#Vamos armazenar os valores em objetos
devolucoes <- 138
n <- 500
quantil_95 <-qnorm(0.975)
proporcao_devolucoes <- devolucoes/n

#Aplicando a f�rmula vista na apostila fica:
Limite_Superior_prop <- proporcao_devolucoes + quantil_95 * sqrt(proporcao_devolucoes*(1-proporcao_devolucoes)/n)
Limite_Inferior_prop <- proporcao_devolucoes - quantil_95 * sqrt(proporcao_devolucoes*(1-proporcao_devolucoes)/n)
paste("Com 95% de confian�a, podemos afirmar que a propor��o varia entre",Limite_Inferior_prop," e ",Limite_Superior_prop)

#Podemos obter o intervalo de confian�a para propor��o mais f�cil pela fun��o prop.test()
IC_proporcao <- prop.test(x = 138, n = 500, conf.level = 0.95)
IC_proporcao$conf.int

############### Intervalo de confian�a para m�dia via Bootstrap ############
#Vamos gerar uma va seguindo uma distribui��o qui-quadrado
va <- rchisq(n = 60, df = 3)
#Observe o qu�o assim�trica � a va
hist(va)
#Inicializa variaveis
medias <- c() #Essa vari�vel � um vetor para armazenar a m�dia de cada subamostra 
bootstrap
R <- 1000 #Numero de subamostras extra�das para gerar a distribui��o amostral de m�dias bootstrap
for (i in 1:R) { 
  #Realiza uma subamostragem aleat�ria com reposi��o da va
  reamostra <- sample(va, size = 50, replace = T) 
  #Armazena a m�dia da subamostra 
  medias[i] <- mean(reamostra) 
}

#Distribuicao das m�dias das subamostras (distribui��o amostral da m�dia da va)
hist(medias)

#Observe que mesmo a vari�vel original n�o seguindo uma distribui��o normal, o Teorema Central do Limite
#nos garante que a distribui��o das m�dias ser� normal se n � suficientemente grande
#A partir das m�dias geradas, precisamos achar dois valores, o que corta a cauda inferior
#e o que corta a cauda superior da distribui��o. Lembrando que ela � sim�trica
#Caso o intervalo desejado seja de 95% de confian�a, temos que ordenar essa distribui��o
#do menor valor para o maior e achar o valor que deixar� 2,5% dos dados para tr�s e o
#valor que deixar� 97,5% para tr�s
(1-0.95)/2
1-(1-0.95)/2

#Visualize o intervalo de confian�a via bootstrap
quantile( medias, probs = c(0.025,0.975))

#Vamos realizar mais um experimento
#Geraremos uma va com m�dia = 30 e desvio padr�o amostral =7.31 e n = 30
va <- rnorm(n = 30, mean = 30, sd = 7.31)

#Iremos calcular o intervalo de confian�a usando o Bootstrap e tamb�m com a distribui��o
# t de Student. Compararemos os resultados.
#Inicializa variavel para armazenar as m�dias de cada subamostra
medias <- c()
R <- 10000 #Numero de subamostras extra�das para gerar a distribui��o amostral de m�dias bootstrap
for (i in 1:R) { 
  #Realiza uma subamostragem aleat�ria com reposi��o da va
  reamostra <- sample(va, size = 20, replace = T) 
  #Armazena a m�dia da subamostra 
  medias[i] <- mean(reamostra) 
}
#Distribuicao das m�dias das subamostras (distribui��o amostral da m�dia da va)
hist(medias)

#Limites inferior e superior do intervalo pelo bootstrap
quantile( medias, probs = c(0.025,0.975))

#Limites inferior e superior do intervalo via t de Student
IC<-t.test(va, conf.level = 0.95)
IC$conf.int

