#Load libraries
library(tidyverse)
library(readxl) 
library(sf)
library(ggsn)
library(raster)
library(grateful)
(.packages())
search()
objects(2) #el 1 siempre es para el global environment


#Figure 1. Oil spills by cause#######################
#Set wd, check files and import data
setwd(r'(C:\Users\u0126759\Desktop\HM\Scholar shit\Papers\1. Ongoing\Oil spill and environmental justice con JC\2022\Julio & Setiembre\Data, graphs & maps)')
dir()
causes <- read_excel("oxfam_long.xlsx")
head(causes)

#Plot causes
causes %>% 
  ggplot(aes(x=Year, y=Spills, fill=Cause)) +
  geom_line(aes(linetype=Cause)) + #line type
  ggtitle("Oil Spills by cause, 2000-2019") +
  scale_x_continuous(limits=c(2000, 2019), breaks = seq(2000, 2019, 2))+
  theme(plot.title = element_text(size = 12, face = "bold"),
        legend.position = "bottom") +
  labs(y = "Number of oil spills") 

causes %>% group_by(Year) %>% summarize(Cause)
