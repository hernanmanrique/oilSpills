#Load libraries
library(tidyverse)
library(raster)
library(readxl) 
library(sf)
library(ggsn)
library(grateful)
(.packages())
search()
objects(2) #el 1 siempre es para el global environment

#Map 1. Oil spills in Peru################
##Loading Peruvian deps map##############
setwd(r'(C:\Users\u0126759\Desktop\Data\GIS\Peru\GIS\Departamentos)')
dir()
depas <- read_sf("DEPARTAMENTOS.shp")
crs(depas) #ID["EPSG",4326]] 

##Loading oil blocks###########
setwd(r'(C:\Users\u0126759\Desktop\Data\GIS\Peru\GIS\Oil\lotes_petroleros\shape)')
dir()
blocks <- read_sf("Lotes de Contrato (Nov 2017).shp")
crs(blocks)
plot(st_geometry(blocks), lwd = 1, col="grey",
     add=TRUE)

##Loading native communities##############
setwd(r'(C:\Users\u0126759\Desktop\Data\GIS\Peru\GIS\Comunidades nativas IBC)')
dir()
comunidades <- read_sf("comunidades_nativas.shp")
crs(comunidades)
comunidades <- sf::st_transform(comunidades, 4236) ; crs(comunidades)
plot(st_geometry(comunidades), add=TRUE, col="green") #Source: IBC-SICNA

##Loading ONP pipeline shp###############
setwd(r'(C:\Users\u0126759\Desktop\HM\Scholar shit\Becas\AL\CIES\CIES 2018\Insumos y materiales\Bases de datos de derrames\TRABAJANDO CIES GIS\ONP Shape)')
dir()
onp <- read_sf("onp.shp")
crs(onp)
plot(st_geometry(onp), lwd = 3, add=TRUE)


##Loading Oil spills 18s###########
setwd(r'(C:\Users\u0126759\Desktop\HM\Scholar shit\Becas\AL\CIES\CIES 2018\Insumos y materiales\GIS\Proyecto Derrames\Derrames)')
dir()
oil18 <- read_sf("Ptos_Derrames_Loreto.shp")
crs(oil18) #EPSG 32718... we gotta change it
oil18_4326 <- sf::st_transform(oil18, 4236)
plot(st_geometry(oil18_4326), col = 2, lwd =0.5,  pch = 16, add=TRUE) #pch 16 es punto con relleno cubierto

compareCRS(depas, oil18_4326)   #TRUE, both have EPSG4326

##Loading Oil spills 17s########
setwd(r'(C:\Users\u0126759\Desktop\HM\Scholar shit\Becas\AL\CIES\CIES 2018\Insumos y materiales\Bases de datos de derrames\TRABAJANDO CIES GIS)')
dir()
oil17 <- read_sf("Derrames_17s.shp")
crs(oil17)
oil17_4326 <- sf::st_transform(oil17, 4326)
crs(oil17_4326)
plot(st_geometry(oil17_4326), col = 2, lwd =0.5, pch=16, add=TRUE) 


#Final ggplot map with scalebar###########

#NOTE::::::::::::::::::: The following two maps are the same: the first one was produced before 14/09, the 2nd one is a modification after 14/09
#Before 14th September::::::::::

#Mapa 90% listo (falta legend, and if possible moving the north sign up)
ggplot(data = depas) +
  #layers ()
  geom_sf(alpha=0) +
  geom_sf(data=comunidades, col="#00B81F", aes(fill="#00B81F"))+
  geom_sf(data=onp, size = 1, aes(fill = "ONP"))+
  geom_sf(data=blocks, col=gray(.1), alpha=0.7)+  
  geom_sf(data=oil17_4326, col="darkred")+  
  geom_sf(data=oil18_4326, col="darkred")+
  #scalebar
  ggsn::scalebar(depas, dist = 200, dist_unit = "km",
                 transform = TRUE, st.size=2.5, 
                 location= "bottomleft", 
                 anchor = c(x=-82, y=-18))+
  #north arrow
  north(depas, symbol=3, y.min=0, scale=0.1, 
        anchor=c(x=-69, y=0.5))+ #cool anchor argument
  #limits
  coord_sf(ylim=c(-18,0))+
  #labels
  labs(x="", y="") +
  #theme
  theme_bw() +
  theme(legend.position = "none") + #I can work on legends later 
  annotate("text", x = -74.1, y = -4.65, label = "LORETO", size=3)

#After 14th September (we're adding legend with fill)
##

ggplot(data = depas) +
  #layers ()
  geom_sf(alpha=0) +
  geom_sf(data=comunidades, fill = "#00BC59", color = "black")+  #THIS IS THE WAY! Fill for inside, color for borders
  geom_sf(data=onp, size = 1, aes(fill = "ONP"))+
  geom_sf(data=blocks, col=gray(.1), alpha=0.7)+  
  geom_sf(data=oil17_4326, col="darkred")+  
  geom_sf(data=oil18_4326, col="darkred")+
  #scalebar
  ggsn::scalebar(depas, dist = 200, dist_unit = "km",
                 transform = TRUE, st.size=2.5, 
                 location= "bottomleft", 
                 anchor = c(x=-82, y=-18))+
  #north arrow
  north(depas, symbol=3, y.min=0, scale=0.1, 
        anchor=c(x=-69, y=0.5))+ #cool anchor argument
  #limits
  coord_sf(ylim=c(-18,0))+
  #labels
  labs(x="", y="") +
  #theme
  theme_bw() +
  theme(legend.position = "none") + #I can work on legends later 
  annotate("text", x = -74.1, y = -4.75, label = "LORETO", size=3) 



#New trial with ggspatial::annotation_north_arrow##################


ggplot(data = depas) +
  #layers ()
  geom_sf(alpha=0) +
  geom_sf(data=comunidades, fill = "#00BC59", color = "black")+  #THIS IS THE WAY! Fill for inside, color for borders
  geom_sf(data=onp, size = 1, aes(fill = "ONP"))+
  geom_sf(data=blocks, col=gray(.1), alpha=0.7)+  
  geom_sf(data=oil17_4326, col="darkred")+  
  geom_sf(data=oil18_4326, col="darkred")+
  #scalebar
  ggsn::scalebar(depas, dist = 200, dist_unit = "km",
                 transform = TRUE, st.size=2.5, 
                 location= "bottomleft", 
                 anchor = c(x=-82, y=-18))+
  #north arrow
  ggspatial::annotation_north_arrow(
    location = "tr", which_north = "true",
    pad_x = unit(0.1, "in"), pad_y = unit(0.1, "in"),
    style = ggspatial::north_arrow_nautical(
      fill = c("grey40", "white"),
      line_col = "grey20",
      text_family = "ArcherPro Book"
    )) +
  #limits
  coord_sf(ylim=c(-18,0))+
  #labels
  labs(x="", y="") +
  #theme
  theme_bw() +
  theme(legend.position = "none") + #I can work on legends later 
  annotate("text", x = -74.1, y = -4.75, label = "LORETO", size=3) 



#north arrow




#SOLO FALTA AGREGAR LA LEYENDAAAAA... LO HAREMOS A MANO PUES

#How to add a legend?
#See: https://stackoverflow.com/questions/18394391/custom-legend-for-multiple-layer-ggplot
#Supporting R script for multiple legends in:  C:\Users\u0126759\Desktop\HM\Scholar shit\Papers\1. Ongoing\Oil spill and environmental justice con JC\2022\Julio\Data, graphs & maps
      #& Perf.R
# map1 <- ggplot(data = depas) +
#   #layers ()
#   geom_sf(alpha=0) +
#   geom_sf(data=onp, size = 1, aes(fill = "ONP"))+
#   geom_sf(data=blocks)+  
#   geom_sf(data=oil17_4326, aes(color="black"))+  
#   geom_sf(data=oil18_4326)+
#   #scalebar
#   ggsn::scalebar(depas, dist = 200, dist_unit = "km",
#                  transform = TRUE, st.size=3, location= "bottomleft")+
#   #north arrow
#   north(depas, symbol=15, y.min=0.7, scale=0.1)+
#   #limits
#   coord_sf(ylim=c(-18,0))+
#   #labels
#   labs(x="", y="") + 
#   #theme
#   theme_bw()  +
#   #legend
#   scale_colour_manual(values =c('black'='black'), labels = 'Oil spills')+
#   theme(legend.title=element_blank(),
#         legend.position = "bottom")  


