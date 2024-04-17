
# Instala las librerías si no están instaladas
if (!requireNamespace("sf", quietly = TRUE)) {
  install.packages("sf")
}
if (!requireNamespace("dplyr", quietly = TRUE)) {
  install.packages("dplyr")
}
if (!requireNamespace("lubridate", quietly = TRUE)) {
  install.packages("lubridate")
}

# Carga las librerías necesarias
library(sf)
library(dplyr)
library(lubridate)

# Cargar el archivo shapefile
gdf <- st_read("C:/Users/joaquin.valenzuela/Documents/shp/Ohiggins/Lineas/Punta_de_lobos.shp")

# Convertir la columna de fecha a formato de fecha
gdf$date <- mdy(gdf$fechadsas)  # Ajusta el nombre de la columna según corresponda

# Filtrar por estación de invierno (desde el 21 de junio hasta el 21 de septiembre)
gdf_invierno <- gdf %>% filter((month(date) == 6 & day(date) >= 21) | 
                                 (month(date) %in% 7:8) | 
                                 (month(date) == 9 & day(date) <= 21))

# Filtrar por estación de verano (desde el 21 de diciembre hasta el 21 de marzo)
gdf_verano <- gdf %>% filter((month(date) == 12 & day(date) >= 21) | 
                               (month(date) %in% 1:2) | 
                               (month(date) == 3 & day(date) <= 21))

# Guardar los archivos shapefile separados por estación
st_write(gdf_invierno, "C:/Users/joaquin.valenzuela/Documents/shp/Ohiggins/Area_2/LINEAS ESTACION/3_PUNTA_DE_LOBOS/PUNTA_DE_LOBOS_INVIERNO.shp")
st_write(gdf_verano, "C:/Users/joaquin.valenzuela/Documents/shp/Ohiggins/Area_2/LINEAS ESTACION/3_PUNTA_DE_LOBOS/PUNTA_DE_LOBOS_VERANO.shp")


