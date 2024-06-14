
  ##ELIMINAR LINEAS MAL GENERADAS, EQUIPARAR CON PUNTOS
  
  library(sf)
  library(dplyr)
  
  # Cargar los archivos GeoJSON
  lineas <- st_read("ruta-archivo_lineas.geojson")
  puntos <- st_read("ruta_archivo_puntos.geojson")
  
  # Obtener las fechas únicas en el archivo de líneas
  fechas_lineas <- unique(lineas$date)
  
  # Filtrar las entidades de puntos que tienen una fecha presente en el archivo de líneas
  puntos_actualizados <- puntos %>%
    filter(date %in% fechas_lineas)
  
  # Función para extraer la fecha en el formato dd-mm-yyyy
  extraer_fecha <- function(fecha_hora) {
    fecha <- as.Date(fecha_hora, format = "%Y/%m/%d %H:%M:%S")
    return(format(fecha, "%d-%m-%Y"))
  }
  
  #Agregar columna con el formato deseado
  
  puntos_actualizados <- puntos_actualizados %>%
    mutate(fecha = extraer_fecha(date))
  
  #Individualizar archivo de puntos de multiparte a monoparte
  puntos_actualizados_singlepart <- st_cast(puntos_actualizados,"POINT")
  
  #Guardar archivo posterior a individualización
  st_write(puntos_actualizados_singlepart,"ruta_nuevo_archivo_puntos.geojson")
  
  print(head(puntos_actualizados_singlepart))

###############################################################################################

