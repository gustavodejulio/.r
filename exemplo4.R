##########################################################
####### Teste de Hip�tese #######
## AED - Capitulo 04 - Prof. M�iron Chaves ####
###########################################################
#Copie este c�digo, cole no seu R e execute para ver os resultados
rm(list = ls()) #Limpa mem�ria do R

########## Avaliando a normalidade de uma vari�vel aleat�ria #############################
set.seed(10)

#Gera v.a. que segue distribui��o normal com n = 70, m�dia = 40 e desvio padr�o = 8
va_normal <- rnorm(n = 70, mean = 25, sd = 8)

#Gera v.a. que segue uma distribui��o F (n�o normal) com n = 15, 2 graus de liberdade no numerados e 10 graus de liberdade no denominador
va_nao_normal <- rf(n =15, df1 =2, df2 = 10)

#Visualize o histograma das vari�veis geradas
#Observe como os dados se distribuem em torno do valor m�dio na va normal
hist(va_normal)

#Observe como os dados n�o se distribuem em torno de um valor m�dio exibindo padr�o assim�trico
hist(va_nao_normal)

# Visualize o QQ-Plot
# Observe como os pontos de dados seguem a linha reta qq norm da va normal
qqnorm(va_normal)
qqline(va_normal) #Este comando � para adicionar a linha

# Observe como os pontos de dados n�o seguem a linha reta na va n�o normal
qqnorm(va_nao_normal)
qqline(va_nao_normal) #Este comando � para adicionar a linha

# Vamos aplicar o teste de hip�teses Shapiro Wilk. O teste funciona sob as hip�teses
# H0: A vari�vel segue uma distribui��o normal
# H1: A vari�vel n�o segue uma distribui��o normal
# Fixe um n�vel de signific�ncia alfa e analise o p valor (p-value) do Shapiro Wilk
#Se o p-value for menor que alfa a hip�tese nula deve ser rejeitada
shapiro.test(va_normal)
shapiro.test(va_nao_normal)

################ Teste t para diferen�a de m�dias (duas amostras independentes) ################
#Iremos simular o exemplo da apostila
#Iremos testar se:
# H0: As vendas na posi��o A s�o iguais as Vendas na Posi��o B
# H1: As vendas na posi��o A s�o diferentes das vendas na posi��o B
rm(list = ls()) #Limpa objetos da mem�ria do R
mu1 <- 150.1 #Armazena as m�dia de vendas na posi��o A
mu2 <- 182.1 #Armazena as m�dia de vendas na posi��o B
s1 <- 17 #Armazena o desvio padr�o das vendas na posi��o A
s2 <- 19.2 #Armazena o desvio padr�o das vendas na posi��o B
n1 <- 25 #Armazena a quantidade observa��es registradas para de vendas na posi��o A
n2 <- 30 #Armazena a quantidade observa��es registradas para de vendas na posi��o B
#Calcula nossa estat�stica de teste. Que � o t calculado
t <- (mu1 - mu2) / sqrt( s1^2/n1 + s2^2/n2)
t #Visualize o valor de t calculado
#Calcula os graus de liberdade da estat�stica de teste
gl <- (s1^2/n1 + s2^2/n2)^2 /( (s1^2/n1)^2 / (n1-1) + (s2^2/n2)^2 / (n2-1) )
gl #Visualize a quantidade de graus de liberdade
#Obtem o quantil (t cr�tico) para uma distribui��o t com gl graus de liberdade. A um alfa de 5%
quantil <- qt(0.975,df = gl)
quantil #Visualize o t cr�tico
#Esse � o aspecto de uma distribui��o t com n=53 observa��es e com n - 1 graus de 
plot(density(rt(n = 53,df = gl)),xlim = c(-7,7)) 
#Observe onde est�o os valores cr�ticos que acabamos de encontrar
abline(v = quantil,col = 'blue',lwd = 2)
abline(v = -quantil,col = 'blue',lwd = 2)
abline(v = t, col = 'red')# Observe como o tcalculado � muito menor que o tcr�tico. Est� na regi�o de rejei��o
#Obtendo o valor p
#P(Tcalculado > Tcritico)
2*pt(q = t, df = gl)
#Agora vamos realizar o mesmo teste de hip�tese utilizando a fun��o nativa do R t.test()
vendas_A <- rnorm(n= 25, mean = 150.1, sd = 17)
vendas_B <- rnorm(n = 30, mean = 182.1, sd = 19.2)
#Observe no output desta fun��o, que ela j� nos da tudo pronto, t calculado e valor p
t.test(vendas_A,vendas_B, alternative = 'two.sided')
#Esse � o aspecto de uma distribui��o t com n observa��es e com n - 1 graus de liberdade
n <- 1000
plot(density(rt(n = n,df = n-1))) 
#Altere o valor de n de 5 em 5 observe que a medida que os graus de liberdade aumenta a distribui��o se aproxima da normal. 
#Como os valores s�o gerados aleatoriamente poderemos ter curvas diferentes para um mesmo valor de n, mas a 
#medida que n cresce o comportamento sim�trico tende a estabilizar.

################ Teste t para diferen�a de m�dias (duas amostras dependentes) ################
#Iremos simular o exemplo da apostila
# H0: O peso m�dio ap�s a dieta � igual ao peso m�dio antes da dieta
# H1: O peso m�dio ap�s a dieta � menor do que o peso m�dio antes da dieta
rm(list = ls()) #Limpa mem�ria do R
#Iremos utilizar uma biblioteca adicional para gerar valores aleat�rios que sigam uma distribui��o normal entre um intervalo de valor para simular os pesos
#A biblioteca chama 'truncnorm'. Basta instalar com o comando abaixo 
install.packages("truncnorm")
#Uma vez instalada n�o h� mais necessidade de instalar novamente. Basta carregar com o comando library()

library(truncnorm)
set.seed(100)
#Gera uma amostra aleat�ria, seguindo uma distribui��o normal cujo valor m�nimo � 100 e o valor m�ximo � 140.
#O valor de n=20, m�dia = 123 e desvio padr�o 18
#Com essa v.a. iremos simular os pesos dos indiv�duos antes da dieta
antes_da_dieta <- rtruncnorm(n=20, a=100, b=140, mean=123, sd=18)

#Gera uma amostra aleat�ria, seguindo uma distribui��o normal cujo valor m�nimo � 110 e o valor m�ximo � 130.
#O valor de n=20, m�dia = 110 e desvio padr�o 28
#Com essa v.a. iremos simular os pesos dos indiv�duos ap�s a dieta
depois_da_dieta <- rtruncnorm(n=20, a=110, b=130, mean=110, sd=28)

#Calcula a diferen�a depois da dieta e antes da dieta, para cada indiv�duo
diferenca <- depois_da_dieta-antes_da_dieta 
diferenca
#Visualiza a distribuicao da diferen�a de pesos
hist(diferenca)
shapiro.test(diferenca) #Avalie a normalidade da distribui��o da diferen�a
#Aplica test t com os seguintes argumentos
t.test(depois_da_dieta,antes_da_dieta,
       paired = TRUE, #Pareado
       alternative = "less", #Unilateral a esquerda
       conf.level = 0.9 #90 porcento de confian�a
) 
#O comando t.test() acima nos da tudo que precisamos para executar e concluir o teste. Mas a t�tulo de conhecimento, podemos realizar o teste passo a passo
#Calcula a m�dia das diferen�as
media <- mean(diferenca)

#Desvio padr�o das diferen�as
desvio_padrao <- sd(diferenca)

#Quantidade de indiv�duos
n <- 20

#Obtem o t calculado
t_calculado <- media / (desvio_padrao/sqrt(n))

#Obtem o valor p para o t calculado com n - 1 graus de liberdade. 
pt(q = t_calculado, df = n-1) 

#Podemos tamb�m obter o t cr�tico para uma distribui��o t com 19 (n-1=20-1) graus de liberdade ao n�vel de confian�a de 90%

tcr�tico_teste_t_pareado <- -qt(p = 0.9, df = 19) #Devido ao teste ser unilateral a esquerda a distribui��o t ser sim�trica, nossa estat�stica de teste ser� negativa
#Observe que o t calculado � maior que o t critico. Como estamos em um teste unilateral a esquerda o t calculado
#estar� fora da regi�o de rejei��o caso seja maior que o t cr�tico
t_calculado < tcr�tico_teste_t_pareado

?t.test #Maiores informa��es sobre o comando t.test()

################ Teste Qui-Quadrado para associa��o entre vari�veis categ�ricas ################
#Iremos simular o exemplo da apostila
# H0: O fato do cliente estar ou n�o com crian�a n�o tem rela��o com o fato de comprar ou n�o comprar
# H1: O fato do cliente estar ou n�o com crian�a tem rela��o com fato de comprar ou n�o comprar
rm(list = ls())
#Vamos gerar um data frame contendo os dados da pesquisa
dados <- data.frame(
  
  Cliente = c("Adulto_com_Crianca", "Adulto_com_Crianca", "Adulto_com_Crianca",
              
              "Adulto", "Adulto", "Adulto", "Adulto_com_Crianca", "Adulto_com_Crianca",
              
              "Adulto_com_Crianca", "Adulto_com_Crianca", "Adulto_com_Crianca",
              
              "Adulto_com_Crianca", "Adulto_com_Crianca", "Adulto_com_Crianca",
              
              "Adulto_com_Crianca", "Adulto_com_Crianca", "Adulto_com_Crianca",
              
              "Adulto_com_Crianca", "Adulto_com_Crianca", "Adulto_com_Crianca",
              
              "Adulto_com_Crianca", "Adulto_com_Crianca", "Adulto_com_Crianca",

              "Adulto_com_Crianca", "Adulto", "Adulto", "Adulto", "Adulto",
              
              "Adulto_com_Crianca", "Adulto_com_Crianca", "Adulto_com_Crianca",
              
              "Adulto_com_Crianca", "Adulto", "Adulto_com_Crianca", "Adulto",
              
              "Adulto", "Adulto_com_Crianca", "Adulto_com_Crianca", 
              "Adulto_com_Crianca",
              
              "Adulto", "Adulto_com_Crianca", "Adulto", "Adulto", "Adulto",
              
              "Adulto","Adulto","Adulto","Adulto","Adulto","Adulto"),
  
  Comprou = c("N�o_Comprou", "N�o_Comprou", "N�o_Comprou", "N�o_Comprou",
              
              "N�o_Comprou", "N�o_Comprou", "Comprou", "Comprou", "Comprou",
              
              "Comprou", "Comprou", "Comprou", "Comprou", "Comprou", "Comprou",
              
              "Comprou", "Comprou", "Comprou", "Comprou", "Comprou", "Comprou",

              "Comprou", "Comprou", "Comprou", "N�o_Comprou", "N�o_Comprou",
              
              "N�o_Comprou", "N�o_Comprou", "Comprou", "N�o_Comprou", "Comprou",
              
              "Comprou", "N�o_Comprou", "N�o_Comprou", "N�o_Comprou", 
              "N�o_Comprou",
              
              "N�o_Comprou", "Comprou", "Comprou", "N�o_Comprou", "N�o_Comprou",
              
              "N�o_Comprou", "N�o_Comprou", "N�o_Comprou", 
              "Comprou","Comprou","Comprou","Comprou","Comprou","Comprou")
  
)
#Visualiza o conjunto de dados
View(dados)
#Gera tabela de contig�ncia 2x2
tabela <- table(dados$Cliente,dados$Comprou)
tabela
barplot(tabela)

#O valor cr�ticico para uma distribui��o qui-quadrado com (linhas-1)*(colunas-1)=1 grau de liberdade ao n�vel de confian�a de 95%
qchisq(p=0.95,df = 1)
#O valor p unilateral fica
1-pchisq(q=10.728,df=1) #Mesmo que o n�vel de confian�a fosse 99%, ainda ter�amos evid�ncias para rejeitar H0
#Assim como fizemos no test t, podemos usar um comando direto no R para realizar o teste qui-quadrado chisq.test()
teste<-chisq.test(tabela,correct = F)
teste
#Visualiza valores observados. Que nada mais � do que a tabela original
teste$observed
#Visualiza valores esperados
teste$expected
?chisq.test #Maiores informa��es sobre o comando chisq.test()

################ ANOVA ##########################
# Vamos utilizar o exemplo da apostila
#H0: N�o h� diferen�a no valor m�dio gasto com bebidas em nenhuma das popula��es
#H1: H� diferen�a no valor m�dio gasto com bebidas em pelo menos uma das popula��es
rm(list = ls())
#Gera um data frame contendo os dados da pesquisa
dados_anova <- data.frame(Gastos = c(174.770021661909, 161.329206619394, 
                                     153.679900850863, 163.790338797433, 141.363480335882, 
                                     175.351592994046, 
                                     185.793398289321, 184.720273514352, 163.400459287948, 
                                     170.202462740626, 
                                     150.8549565713, 167.583106239899, 140.190492201897, 
                                     157.440088617225, 
                                     171.596654773339, 138.885665257324, 147.942698809323, 
                                     9.87474262516482, 
                                     50.5645554670016, 14.2586307887884, 8.5061846804934, 
                                     25.0875496696788, 
                                     17.0661987504312, 41.3867417301938, 20.8113941426179, 
                                     60.1224674502026, 
                                     35.5154028285664, 23.7622285692359, 34.6086119259266, 
                                     30.4321086925016, 
                                     27.8188980544904, 37.4729772794009, 30.7229538650678, 
                                     48.0452539322412, 
                                     78.9197865324734, 42.4926762466659, 8.81227865272712, 
                                     39.5751781629677, 
                                     37.1329656327517, 15.8016718071775, 5.74735216885902, 
                                     38.684069121093, 
                                     30.9398891106907, 34.7370783113952, 13.2630510987537, 
                                     19.6212096123791, 
                                     16.716945267481, 24.4037922212213, 4.63398786180773, 
                                     32.9436217626275, 
                                     21.511905851158, 31.4997283634204, 26.6610570873775, 
                                     34.6304034101472, 
                                     16.2704826042681, 11.2323425300881, 18.023244405391, 
                                     15.4790632095655, 
                                     8.25633422881043, 27.9053307974433, 72.3298402892867, 
                                     4.7263338963663, 
                                     14.4153129255327, 41.2234268777169, 50.5684226296565, 
                                     19.8344282661234, 
                                     8.81306901471397, 19.5112436004646, 55.6251926080436, 
                                     16.7592556127806, 
                                     20.3176176298076, 31.2073058210955, 17.0613250010048, 
                                     47.8590627884627, 
                                     2.59778754862417, 35.9470130480825, 2.39404093355522, 
                                     9.38425601777391, 
                                     25.2455048267186, 16.1960287769175, 43.530118783298, 
                                     32.7250288712979, 
                                     5.43268078364765, 44.5365791890593, 32.9831443965413, 
                                     28.2104605365607, 
                                     3.18609515001209, 14.3698142789208, 39.9617218607622, 
                                     50.564581262513, 
                                     10.4634451365926, 36.4842442182048, 13.1330189654278, 
                                     8.93702642184252, 
                                     12.1501174131844, 22.2552757873296, 15.1407470062459, 
                                     11.7525513477354, 
                                     16.2990775324815, 24.4627568806115, 2.87916580644454, 
                                     44.5453919973285, 
                                     38.0393535792355, 32.1985589022666, 0.357075783631849, 
                                     22.0703974352325, 
                                     50.7486034030794, 18.604230207709, 5.83122133978906, 
                                     19.9252025339318, 
                                     6.8366108202567, 27.5834177510951, 41.9303025963975, 
                                     3.077799353254,
                                     28.0507001837521, 33.0042729903, 50.7366690908169, 
                                     30.1697285113061, 
                                     6.53184416916073, 7.53469171526227, 5.49225229796712, 
                                     9.53198727121377, 
                                     6.59266645551752, 19.8423174628847, 0.781567028951091, 
                                     22.1605754480815, 
                                     5.90830712162365, 54.3457453874529, 33.3341495203441, 
                                     37.2034845899045
), Estado_Civil = c("solteiros", "solteiros", "solteiros", "solteiros", 
                    "solteiros", "solteiros", "solteiros", "solteiros", "solteiros", 
                    "solteiros", "solteiros", "solteiros", "solteiros", "solteiros", 
                    "solteiros", "solteiros", "solteiros", "Casados", "Casados", 
                    "Casados", "Casados", "Casados", "Casados", "Casados", "Casados", 
                    "Casados", "Casados", "Casados", "Casados", "Casados", "Casados", 
                    "Casados", "Casados", "Casados", "Casados", "Casados", "Casados", 
                    "Casados", "Casados", "Casados", "Casados", "Casados", "Casados", 
                    "Casados", "Casados", "Casados", "Casados", "Casados", "Casados", 
                    "Casados", "Casados", "Casados", "Casados", "Casados", "Casados", 
                    "Casados", "Casados", "Casados", "Casados", "Casados", "Casados", 
                    "Casados", "Casados", "Casados", "Casados", "Casados", "Casados", 
                    "Casados", "Casados", "Casados", "Casados", "Casados", "Casados", 
                    "Casados", "Casados", "Casados", "Casados", "Casados", "Casados", 
                    "Casados", "Casados", "Casados", "Casados", "Casados", "Casados", 
                    "Casados", "Casados", "Casados", "Casados", "Casados", "Casados", 
                    "Casados", "Casados", "Casados", "Casados", "Casados", "Casados", 
                    "Casados", "Casados", "Casados", "Casados", "Casados", "Casados", 
                    "Casados", "Casados", "Casados", "Casados", "Casados", "Casados", 
                    "Casados", "Casados", "Casados", "Casados", "Casados", "Casados", 
                    "Divorciados", "Divorciados", "Divorciados", "Divorciados", "Divorciados", 
                    "Divorciados", "Divorciados", "Divorciados", "Divorciados", "Divorciados", 
                    "Divorciados", "Divorciados", "Divorciados", "Divorciados", "Divorciados"))
#Visualiza o conjunto de dados
View(dados_anova)
#Podemos utilizar os recursos de visualiza��o da biblioteca ggplot2 para visualizar a distribui��o dos gastos nas popula��es
install.packages("ggplot2")
library(ggplot2)
ggplot(data = dados_anova, aes(x = Gastos, fill = Estado_Civil)) + geom_density(alpha=0.4) + xlim(-50,300)
#� bastante comum tamb�m analisarmos a variabilidade nas distintas popula��es com uso de boxplot
boxplot(dados_anova$Gastos ~ dados_anova$Estado_Civil)
#Com o comando aov(), o R gera a tabela da ANOVA completa
anova <- aov(Gastos~ #Vari�vel resposta
               Estado_Civil, #Fator que queremos testar se exerce influencia na vari�vel resposta
             data = dados_anova)
#Visualize a tabela da ANOVA. Observe o F calculado e o valor p ( Pr > F)
summary(anova)
# O valor p � praticamente zero. Mesmo que nosso n�vel de confian�a fosse 99,9% ainda ter�amos evid�ncias para rejeitar H0