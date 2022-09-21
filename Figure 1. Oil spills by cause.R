#Load libraries
library(tidyverse)
library(readxl) 
library(grateful)
(.packages())
search()
objects(2) #el 1 siempre es para el global environment


#Figure 1. Oil spills by cause#######################
#Set wd, check files and import data
setwd(r'(C:\Users\u0126759\Desktop\HM\Scholar shit\Papers\1. Ongoing\Oil spill and environmental justice con JC\2022\Setiembre (tras revisión)\version-control\oilSpills\data)')
dir()
causes <- read_excel("Figure1-spillsByCause.xlsx")
head(causes)

#Plot causes
causes %>% 
  ggplot(aes(x=Year, y=Spills, fill=Cause)) +
  geom_line(aes(linetype=Cause)) + #line type
  ggtitle("Oil spills by cause, 2000-2019") +
  scale_x_continuous(limits=c(2000, 2019), breaks = seq(2000, 2019, 2))+
  theme_bw() +
  theme(plot.title = element_text(size = 11, face = "bold"),
        legend.text=element_text(size=7),
        legend.title=element_text(size=8),
        legend.position = "bottom",
        axis.title = element_text(size = 9)) +
  labs(y = "Number of oil spills") 
  


