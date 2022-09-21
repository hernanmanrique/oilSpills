#Map 3. Cuninico Oil Spill and Downstream Affected Communities

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

loreto
loreto_geometry <- st_geometry(loreto)
loreto_cropped <- st_crop(loreto,xmin = -75.17, xmax = -75.36, ymin= -4.73, ymax=-4.84)
plot(loreto_cropped)

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
comunidades_loreto <- st_intersection(comunidades, loreto_cropped)
comunidades_loreto <- st_geometry(loreto_cropped)
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


