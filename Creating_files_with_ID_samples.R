#Creating several vectors based on a database

library(readxl)
library(dplyr)
dir()

#import the dattabase
TAB <- read_xlsx("ancestralidade_k8.xlsx", sheet = "ANCESTRALIDADE_K8", col_names = T)


lista_pop <- c ('LWK', 'ESN', 'YRI', 'MSL', 'GWD', 
                'ACB', 'ASW', 'CLM', 'MXL', 'PUR', 'PEL',
                'TSI', 'IBS', 'GBR', 'CEU', 'FIN',
                'PJL', 'GIH', 'ITU', 'STU', 'BEB',
                'CDX', 'KHV', 'CHS', 'CHB', 'JPT')

  
  
  for (i in lista_pop) {
    df <- TAB %>%
      select(POP, ID) %>% #Select Columns 
      filter(POP == i)#Select line
    
    print(i)
    
    #named the new database 
    namefile <- paste( i, ".txt", sep = "") 
    assign(namefile, df)
    print(namefile)
    
    #Salve the new database
    write.table(df$ID, file = namefile, sep = "/t",   row.names = FALSE,col.names = FALSE,  quote = FALSE) #Salvando a lista em formato txt, sem nome do linhas e colunas com aspas
    
    
  }