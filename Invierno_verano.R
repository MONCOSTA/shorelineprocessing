library(sf)
library(dplyr)

# Ruta al archivo shapefile
ruta_archivo <- "C:/Users/joaquin.valenzuela/Documents/shp/Valparaiso/DSAS/Por_agregar/TUNQUEN.shp"

# Cargar el archivo shapefile
datos_sf <- st_read(ruta_archivo)

# Aplicar la operación para extraer la fecha
datos_sf <- datos_sf %>%
  mutate(fecha = as.Date(sub("^(\\d{4}/\\d{2}/\\d{2}).*", "\\1", date), format = "%Y/%m/%d"))

# Filtrar por estación de invierno (desde el 21 de junio hasta el 21 de septiembre)
gdf_invierno <- datos_sf %>% filter((month(fecha) == 6 & day(fecha) >= 21) | 
                                      (month(fecha) %in% 7:8) | 
                                      (month(fecha) == 9 & day(fecha) <= 21))

# Crear una nueva columna con el formato deseado (mes/día/año)
gdf_invierno$fecha_formato <- format(gdf_invierno$fecha, "%m/%d/%Y")

# Guardar el archivo shapefile de invierno
st_write(gdf_invierno, "C:/Users/joaquin.valenzuela/Documents/shp/Valparaiso/DSAS/Por_agregar/Estacion/TUNQUEN_INVIERNO.shp")

# Filtrar por estación de verano (desde el 21 de diciembre hasta el 21 de marzo)
gdf_verano <- datos_sf %>% filter((month(fecha) == 12 & day(fecha) >= 21) | 
                                    (month(fecha) %in% 1:2) | 
                                    (month(fecha) == 3 & day(fecha) <= 21))

# Crear una nueva columna con el formato deseado (mes/día/año)
gdf_verano$fecha_formato <- format(gdf_verano$fecha, "%m/%d/%Y")

# Guardar el archivo shapefile de verano
st_write(gdf_verano, "C:/Users/joaquin.valenzuela/Documents/shp/Valparaiso/DSAS/Por_agregar/Estacion/TUNQUEN_VERANO.shp")
