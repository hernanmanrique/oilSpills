#Map 2. Oil spills and clusters of oil pollution###############

#Load libraries
library(tidyverse)
library(raster)
library(readxl) 
library(sf)
library(grateful)
library(ggspatial)
library(ggsn)
(.packages())



##Loading ROI
setwd(r'(C:\Users\u0126759\Desktop\Data\GIS\Peru\GIS\Departamentos\Departamentos específicos)')
dir()
loreto <- read_sf("Loreto_provs.shp") ; loreto <- st_geometry(loreto)
crs(loreto) #ID["EPSG",4326]] 
plot(loreto)

##Loading oil blocks###########
setwd(r'(C:\Users\u0126759\Desktop\Data\GIS\Peru\GIS\Oil\lotes_petroleros\shape)')
dir()
blocks <- read_sf("Lotes de Contrato (Nov 2017).shp")
crs(blocks)

#Intersection (only blocks in Loreto)
sf_use_s2(FALSE)
loreto_blocks <- st_intersection(blocks, loreto)
plot(st_geometry(loreto_blocks), add=TRUE, color="dark grey")
     
##Loading native communities##############
setwd(r'(C:\Users\u0126759\Desktop\Data\GIS\Peru\GIS\Comunidades nativas IBC)')
dir()
comunidades <- read_sf("comunidades_nativas.shp")
crs(comunidades)
comunidades <- sf::st_transform(comunidades, 4326) ; crs(comunidades)

#Intersection (only communities from Loreto)
sf_use_s2(FALSE)
comunidades_loreto <- st_intersection(comunidades, loreto)
comunidades_loreto <- st_geometry(comunidades_loreto)
plot(comunidades_loreto, add=TRUE, col="green") #Source: IBC-SICNA
 
 ##Loading ONP pipeline shp###############
setwd(r'(C:\Users\u0126759\Desktop\HM\Scholar shit\Becas\AL\CIES\CIES 2018\Insumos y materiales\Bases de datos de derrames\TRABAJANDO CIES GIS\ONP Shape)')
dir()
onp <- read_sf("onp.shp")
crs(onp)

#Intesection (ONP in Loreto)
sf_use_s2(FALSE)
onp_loreto <- st_intersection(onp, loreto)
plot(st_geometry(onp_loreto), lwd = 3, add=TRUE)
 
##Loading Oil spills Loreto###########
setwd(r'(C:\Users\u0126759\Desktop\HM\Scholar shit\Becas\AL\CIES\CIES 2018\Insumos y materiales\GIS\Proyecto Derrames\Derrames)')
dir()
oil <- read_sf("Ptos_Derrames_Loreto.shp")
crs(oil) #EPSG 32718... we gotta change it
oil_4326 <- sf::st_transform(oil, 4236) ; crs(oil_4326)
plot(st_geometry(oil_4326), col = 2, lwd =0.5,  pch = 16, add=TRUE) #pch 16 es punto con relleno cubierto
 
 
#Final ggplot map with scalebar###########
ggplot(data = loreto) +
  #layers ()
  geom_sf(alpha=0) +
  geom_sf(data=comunidades_loreto, fill = "#00BC59", color = "black")+  #THIS IS THE WAY! Fill for inside, color for borders
  geom_sf(data=onp_loreto, size = 1.5)+
  geom_sf(data=loreto_blocks, col=gray(.4), alpha=0.7)+  
  geom_sf(data=oil_4326, col="darkred")+  
  #theme
  theme(legend.position = "none") + #I can work on legends later 
  theme_bw() +
  #labels
  labs(x="", y="") +
  #Annotations
  annotate("text", x = -76.3, y = -1.75, label = "Block 192", size=3)+
  #FALTA PONER NOTA BLOCK 8 annotate("text", x = -76.0, y = -3.94, label = "Block\n8", size=2.7) 
  #limits
  coord_sf(ylim=c(-9,0))+
  #scalebar
  annotation_scale()+ #before we tried it with  ggsn::scalebar BUT FAILED MISERABLY
  #north arrow
  ggspatial::annotation_north_arrow(
    location = "tr", which_north = "true",
    pad_x = unit(0.4, "in"), pad_y = unit(0.1, "in"),
    style = ggspatial::north_arrow_nautical(
      fill = c("grey40", "white"),
      line_col = "grey20",
      text_family = "ArcherPro Book"
    ))   #BEFORE I TRIED TO USE A NORTH ARROW FROM GGSN, BUT I ALWAYS ENCOUNTERED PROBLEMS:
  # north(comunidades_loreto)
  #       , location="topright", symbol = 3, scale=0.4) #I still get this error:
# Warning messages:
# 1: In min(data$long) : no non-missing arguments to min; returning Inf
# 2: In max(data$long) : no non-missing arguments to max; returning -Inf
# 3: In min(data$lat) : no non-missing arguments to min; returning Inf
# 4: In max(data$lat) : no non-missing arguments to max; returning -Inf
#NO CAMBIAR.... CAMBIAR NORTH ARROW SIZE MANUALMENTE THEN

#WE'LL ONLY USE GGSPATIAL FROM NOW ON

