library(sf)
library(dplyr)

# Cargar los archivos GeoJSON
lineas <- st_read("C:/Users/joaquin.valenzuela/Desktop/CoastSat-master/data/Tanume/Tanume_output_lines.geojson")
puntos <- st_read("C:/Users/joaquin.valenzuela/Desktop/CoastSat-master/data/Tanume/Tanume_output_points.geojson")

# Obtener las fechas únicas en el archivo de líneas
fechas_lineas <- unique(lineas$date)

# Filtrar las entidades de puntos que tienen una fecha presente en el archivo de líneas
puntos_actualizados <- puntos %>%
  filter(date %in% fechas_lineas)

# Guardar los archivos GeoJSON actualizados
st_write(puntos_actualizados, "C:/Users/joaquin.valenzuela/Desktop/CoastSat-master/data/Tanume/Tanume_output_points2.geojson")
