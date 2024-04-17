# Instala los paquetes si no los tienes instalados
#install.packages("sf")
#install.packages("dplyr")

# Carga las librerías
library(sf)
library(dplyr)

# Carga los shapefiles
archivo1 <- st_read("ruta_playa_1.shp")
archivo2 <- st_read("ruta_playa_2.shp")
archivo3 <- st_read("ruta_playa_3.shp")
archivo4 <- st_read("ruta_playa_4.shp")
archivo5 <- st_read("ruta_playa_5.shp")

#.. dependerá de la cantidad de secciones en que se dividió la playa


# Convertir la columna de fecha a un formato adecuado
## Modificar según la cantidad de archivos que se tengan a unir
todos <- rbind(archivo1, archivo2, archivo3, archivo4, archivo5)
todos$date <- as.POSIXct(gsub("\\..*", "", todos$date), format = "%Y/%m/%d %H:%M:%S")

# Identificar las fechas comunes entre todos los tramos de la playa
fechas_comunes <- Reduce(intersect, lapply(list(archivo1$date, archivo2$date, archivo3$date, archivo4$date, archivo5$date), as.POSIXct))

print("Fechas comunes:")
print(fechas_comunes)

# Filtrar los datos para quedarnos solo con las fechas comunes
coincidentes <- todos[todos$date %in% fechas_comunes, ]

# Verificar el tamaño del objeto coincidentes
print("Número de entidades después del filtrado:")
print(nrow(coincidentes))

# Unir los shapefiles de los tramos de la playa en las fechas comunes
unidos <- st_union(coincidentes)

# Guardar el resultado como un nuevo shapefile
st_write(unidos, "ruta_playa_final.shp")

