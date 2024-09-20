#======================================================
# Calculo da frequencia dos Diplotiplos em cada populaçao
#=======================================================
#
# (C) Copyright 2023, by LGH and Contributors.
#
# 
#-----------------
#  Stargazer 
#-----------------
#
# Original Author: Fernanda Soares
# Contributor(s):  Caique Manóchio 
# Updated by (and date): Caique Manochio 20/09/2024
#
# Dependencies:   , R
#
# Command line:	

library(readxl)
library(dplyr)
library(adegenet)

#importando o arquivo
data <-read_xlsx(file.choose(),sheet = "Diplotipos", col_names = TRUE)

#pegando o nome das populações
lista <- data$POP
lista <- unique(lista)
lista_pop <- c ( "PUR", "CLM", "PEL",
                 "MXL", "CHOPCCAS", "CUSCO",
                 "IQUITOS", "MATZES", "MOCHES",
                 "TRUJILLO", "UROS")


#exlcuindo o asterisco
data[] <- lapply(data, function(x) gsub("[/*]", "", x))
#criando uma coluna com diplotipo
data$geno <- apply(data[ ,3:4], 1, paste, collapse = ' ')

#calculando a frequencia 
#Usamos a plodia como um para contar o diplotipo
for (i in lista_pop) {
  print(i)
  df_temporario <- data %>%
    select(POP, geno) %>%
    filter(POP == i)#Seleciona as linhas
  
  pop_genind <- df2genind(X = df_temporario, sep = ' ', ploidy = 1, ncode = 2)#converte o banco de dados que temos em genind 
  pop_genpop <- genind2genpop(pop_genind)#converte o genind em genpop 
  freq <- makefreq (pop_genpop, quiet = FALSE, missing = NA, truenames = TRUE)#calcula a frequencia da populaçao
  #Cria um objeto que armazena a frequencia e recebe o nome da pop
  nome_df <- paste("freq_", i, sep = "") 
  assign(nome_df, freq)
  
}

#Criando um tabela com os resultados

lista_dataframes <- c('freq_PUR', 'freq_CLM', 'freq_PEL', 
                      'freq_MXL', 'freq_CHOPCCAS', 'freq_CUSCO', 
                      'freq_IQUITOS', 'freq_MATZES', 'freq_MOCHES', 
                      'freq_TRUJILLO', 'freq_UROS')

#converter os freq de matriz para dataframe

for (nome_matriz in lista_dataframes) {
  assign(nome_matriz, as.data.frame(get(nome_matriz)))
}



#criação do dataframe final, que soma todos os dataframes
df_final <- data.frame(teste = character(length(lista_dataframes)), 
                       pos = numeric(length(lista_dataframes)))
#adicionando os nomes de cada população, 26 linhas
df_final$nome_df <- lista_dataframes

lista <- list(freq_PUR, freq_CLM, freq_PEL, 
              freq_MXL, freq_CHOPCCAS, freq_CUSCO, 
              freq_IQUITOS, freq_MATZES, freq_MOCHES, 
              freq_TRUJILLO, freq_UROS)

#criando um vetor com o nome das colunas de todos os dataframe 
number <- 1
for (i  in lista) {
  
  nome_coluna <- colnames(i)
  print(nome_coluna)
  nome_vetor <- paste("col_", number, sep = "") 
  assign(nome_vetor, nome_coluna)
  number <- number + 1
  
  
}


#juntando esses nomes
col_nomes_juntos <- c(col_1, col_2, col_3, col_4,
                      col_5, col_6, col_7, col_8,
                      col_9, col_10, col_11)
#excluindo os nome duplicados 
col_nomes_juntos_sem_repeticao <- unique(col_nomes_juntos)
print(col_nomes_juntos_sem_repeticao)

geno_columns <- col_nomes_juntos_sem_repeticao
#criação do dataframe final, gerando um banco de dados novo no final
for (i in 1:length(lista_dataframes)) {
  for (col in geno_columns) {
    print(col_nomes_juntos_sem_repeticao)
    print(col)
    if (col %in% colnames(get(lista_dataframes[i]))) {  #If usado pra verificar se a dataframe possui aquela coluna.
      df_final[[col]][i] <- get(lista_dataframes[i])[[col]]#Coluna existe se atribui o valor dessa coluna no df_final
    } else { #Se não tiver a coluna atribui o valor de 0 
      df_final[[col]][i] <- 0
    }
  }
}
write.table(df_final, "diplotipos_freq.txt", sep = "\t", row.names = FALSE, col.names = TRUE, quote = FALSE)
