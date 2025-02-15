###########################################################
####### Distribui��es de Probabilidades #######
## AED - Capitulo 02 - Prof. M�iron Chaves ####
###########################################################
#Copie este c�digo, cole no seu R e execute para ver os resultados
################################
#### DISTRIBUI��O BINOMIAL ####
################################

# Exemplo: Definindo como sucesso o cliente comprar, e supondo que a probabilidade de sucesso � 50%.

# Ao passar 10 clientes em nossa loja, qual a probabilidade de realizarmos 2 vendas?
#Ou seja, queremos encontrar a probabilidade de dois sucessos, em dez tentativas.Cuja probabilidade de sucesso
# em cada tentativa � 50%
dbinom (x = 2, size = 10, prob = 0.5) * 100

#Onde:
# x � o n�mero de sucessos,
# size � o n�mero de tentativas,
# prob � a probabilidade de sucesso em cada tentativa
# A fun��o a seguir gera quantidades aleat�rias de sucesso oriundos de uma 
#quantidade (size) de tentativas dada a probabilidade (prob) de sucesso.
# � �til para realizar experimentos. Podemos simular qual a frequencia esperada de vendas a cada dez clientes ?
#Ainda mantendo a probabilidade de sucesso (cliente comprar) de 50%
va_binomial <- rbinom(n = 100, size=10, prob=0.5)

#Onde:
# n � a quantidade de vezes que o experimento deve ser repetido
# size � o n�mero de tentativas a cada experimento
# prob � o n�mero de sucesso em cada uma das tentativas
hist(va_binomial) # A maior barra no histograma representa a quantidade esperada de vendas
#Ajuste o parametro n para 1000 e plote o histograma, observe como a distribui��o binomial se aproxima da normal
# Podemos tamb�m querer a probabilidade de que at� dois clientes comprem. 

#Ao inv�s de saber a probabilidade de exatos dois comprarem.
#A probabilidade de at� dois clientes comprarem �:
#(probabilidade de nenhum cliente comprar) + (probabilidade de um cliente comprar) + probabilidade de dois cliente comprarem)
#Formalizando: P(X<=2) = P(X=0) + P(X=1) + P(X=2)
pbinom(q = 2,size = 10, prob = 0.5)

#A probabilidade de que at� dois clientes comprem ao entrarem dez clientes, � de 5,48%

##################################
#### DISTRIBUI��O GEOM�TRICA ####
##################################
#Exemplo: Definindo como sucesso o cliente comprar, e supondo que a probabilidade de sucesso � 50%.
#Qual a probabilidade da primeira venda ocorrer quando o quinto cliente entrar na loja?
dgeom(x = 5, prob = 0.5)

#Onde:
# x � o n�mero de tentativas
# prob � a probabilidade de sucessos
# Podemos utilizar a mesma fun��o para nos dar a probabilidade do sucesso ocorrer na primeira tentativa,
#Segunda tentativa, terceira tentativa ... at� a d�cima tentativa.

va_geometrica <- dgeom(x = 1:10, prob = 0.5)
va_geometrica
plot(va_geometrica) #Veja como as probabilidades v�o diminuindo. A probabilidade de sucesso de 50% � relativamente alta,
#ent�o � muito provavel que o sucesso ocorra logo nas primeiras tentativas
# Podemos utilizar a distribui��o geom�trica acumulada para saber qual a probabilidade do primeiro sucesso
#ocorrer na primeira tentativa OU na segunda tentativa OU na terceira tentativa
#Formalizando, queremos: P(X<=3)
va_geometrica_acumulada <- pgeom(0:3, prob = 0.5)
plot(va_geometrica_acumulada)

#########################################
#### DISTRIBUI��O BINOMIAL NEGATIVA ####
#########################################
# Exemplo: Definindo como sucesso o cliente comprar, e supondo que a probabilidade de sucesso � 50%.
#Qual a probabilidade de ter que entrar 8 clientes at� que a segunda venda ocorra?
dnbinom(x=2, size = 8, prob = 0.50)

#Onde:
# x � o n�mero de sucessos
# size � a quantidade de tentativos
# prob � a probabilidade de sucesso

#########################################
#### DISTRIBUI��O POISSON ####
#########################################
# Exemplo: Uma loja recebe em m�dia, 6 (????) clientes por minuto. Qual a probabilidade de que 5(x) clientes
#entrem em um minuto?
dpois(x= 5,lambda = 6)
#Onde:
# x � a quantidade a ser testada
# lambda � a taxa m�dia de ocorr�cia do evento em um determinado per�odo de intervalo de tempo ou espa�o
# Podemos utilizar a mesma funcao para obter a probabilidade de entrar um cliente, dois clientes... quinze clientes
va_poison <- dpois(x = 1:15, lambda = 6)
plot(va_poison)

# Observe que os valores se distribuiem simetricamente en tormo de seis, use acontece porque o paramentro
#lambda � a m�dia (e tamb�m o desvio padr�o) da distribui��o de Poisson
# Tamb�m podemos obter a probabilidade acumulada de at� 5 clientes entrarem na loja em um minuto
#Formalizando, queremos: P(X<=5)
va_poison <- ppois(1:5, lambda = 6)
plot(va_poison)

#########################################
#### DISTRIBUI��O NORMAL ####
#########################################
# Exemplo: Suponha que a distribui��o dos sal�rios dos funcion�rios de uma empresa sigam uma distribui��o
#normal com m�dia ????=2.500 e desvio padr�o ??= 170.
# Ao selecionar aleatoriamente um indiv�duo dessa popula��o, qual a probabilidade de ter sal�rio entre
#2.400 e 2.600 ?
# Precisamos achar a probabilidade do indiv�duo ter um sal�rio de at� 2.600 e subtrair pela probabilidade do
#indiv�duo ter o sal�rio at� 2.400
#P(X<=2600)
probabilidade_ate_2600 <- pnorm(q = 2600, mean = 2500, sd =170 )

#P(X<=2400)
probabilidade_ate_2400 <- pnorm(q = 2400, mean = 2500, sd =170 )

#P(X<=2600) - P(X<=2400)
probabilidade_ate_2600 - probabilidade_ate_2400

#Podemos gerar 100 n�meros aleat�rios para uma distribui��o normal com m�dia 2500 e desvio padr�o 170
va_normal <- rnorm(n = 1000, mean = 2500,sd = 170)
hist(va_normal)

#########################################
#### DISTRIBUI��O NORMAL PADR�O ####
#########################################
# O comando scale() padroniza uma vari�vel aleat�ria.
#Ao aplicar o comando na vari�vel va_normal que acabmos de criar, ela ficar� com m�dia zero e desvio padr�o unit�rio
va_normal_padrao <- scale(va_normal)
hist(va_normal_padrao)

# Exemplo: Suponha que a distribui��o dos sal�rios dos funcion�rios de uma empresa sigam uma distribui��o
#normal com m�dia ????=2.500 e desvio padr�o ??= 170.
# Ao selecionar aleatoriamente um indiv�duo dessa popula��o, qual a probabilidade de ter
#sal�rio acima de 2.600 ?
#Padroniza��o
z <- (2600-2500)/170
pnorm(z, mean = 0, sd = 1)
#ou simplesmente
pnorm(z)
#Podemos tamb�m visualizar onde est� o nosso valor Z em rela��o a m�dia
plot(density(scale(va_normal))) #Plota curva de densidade
abline(v = 0,col = 'blue') #Gera uma linha sobre m�dia, que � zero pois padronizamos a distribui��o
abline(v = 0.58,col = 'red') #Gera uma linha sobre o valor z obtido

#########################################
#### DISTRIBUI��O F ####
#########################################
#Gerando uma amostra aleat�ria de 1000 n�mero seguindo uma distribui��o F
va_f <- rf( n= 1000, df1 = 5 , df2 = 33 )

# Onde:
# n � a quantidade de n�meros a ser gerado
# df1 � o primeiro grau de liberidade
# df2 � o segundo grau de liberdade
hist(va_f)

#V� aumentando os graus de liberdade e observe como a distribui��o se aproxima da normal
#Informa��o Extra: Uma distribui��o F � a raz�o entre duas chi-quadrado

#########################################
#### DISTRIBUI��O T ####
#########################################
#Gera uma amostra aleat�ria de 1000 n�meros seguindo uma distribui��o T
va_t <- rt(1000, df = 2)
hist(va_t)

#Observe que a distribui��o t, assim como a normal padr�o, � centrada no zero
#V� aumentando o grau de liberdade e observando o comportamento do histograma

#########################################
#### DISTRIBUI��O QUI-QUADRADO ####
#########################################
#Gera uma amostra aleat�ria de 1000 n�meros seguindo uma distribui��o quiquadrado
va_QuiQuadrado <- rchisq(1000,df = 3)
hist(va_QuiQuadrado)