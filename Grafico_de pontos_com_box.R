library(ggrepel)
library(ggplot2)
library(readxl)
library(tidyverse)
library(gridExtra)
library(ggpubr)
cyp2c19 <- read_xlsx(file.choose(), sheet = "INPUT_PARA_GRAFICO") 

#Adicionando uma nova coluna com os continentes
cyp2c19["CONT"]<- c('Africanos', 'Africanos', 'Africanos', 'Africanos', 'Africanos', 
                  'Miscigenados', 'Miscigenados', 'Miscigenados', 'Miscigenados', 'Miscigenados', 'Miscigenados', 
                  'Europeus', 'Europeus', 'Europeus', 'Europeus', 'Europeus', 
                  'Sul Asiático', 'Sul Asiático', 'Sul Asiático', 'Sul Asiático', 'Sul Asiático', 
                  'Leste Asiático', 'Leste Asiático', 'Leste Asiático', 'Leste Asiático', 'Leste Asiático')


paleta_cores_cont <- c("green4", "blue1",  "#E43F6F", "#422040", "#E57A44")
vetor_cont <- c('Africanos', 'Miscigenados', 'Europeus', 'Sul Asiático', 'Leste Asiático')

#Para que todos label apareça mesmo se tiver overlap
options(ggrepel.max.overlaps = Inf)

#Graficos para cada rs 

cyp2c19_NAT_2 <- ggplot(cyp2c19, aes(as.numeric(NAT), as.numeric(geno.02), #dados que serão utilizados para fazer o grafico
                                       label = POP, color = CONT)) +  #label separa pelas populações e color colori pelos continentes 
  geom_point(shape = 19, size = 9) + #adiciona os pontos, shape é forma dos pontos e size o tamanho 
  geom_label_repel(box.padding = 0.5, size = 8,  show.legend = FALSE ) + #adicona a caixa do label. size o tamanho fonte na box e show.legend tira essa legenda  
  labs(y = "Frequência do *2", #modificar legendo do eixo y
       x = "Ancestralidade Nativo Americana", #modificar legendo do eixo x
       color = "Regiões", #vai modificar legenda da legenda
       shape = 19,
       title = "Ancestralidade Nativo Americana x Frequência do *2") +
  theme_classic() +
  theme(axis.title.y = element_text(size = 15, #para fazer mudanças nas legendas e eixo y
                                    margin = margin(r = 14)),#funçao que explica como os elementos que nao sao os dados sao representados
        axis.title.x = element_text(size = 15, 
                                    margin = margin(t = 15)),#para fazer mudanças nas legendas e eixo y
        legend.title = element_text(face = "bold", size = 14), #colaca o legenda em negrito e muda o tamanho da fonte
        title = element_text(size = 14, 
                             face = "bold",
                             margin = margin(b = 15)),
        plot.title = element_text(hjust = 0.5),
        axis.text = element_text(size = 14)) +
  scale_color_manual(values = paleta_cores_cont,
                     breaks = vetor_cont)