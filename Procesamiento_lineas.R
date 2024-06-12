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

library(sf)
library(lubridate)
library(dplyr)

# Función para extraer la fecha en el formato dd-mm-yyyy
extraer_fecha <- function(fecha_hora) {
  fechaDSAS <- as.Date(fecha_hora, format = "%Y/%m/%d %H:%M:%S")
  return(format(fechaDSAS, "%d-%m-%Y"))
}

# Ruta de la carpeta que contiene los archivos shapefile
ruta_carpeta <- "C:/Users/joaquin.valenzuela/Documents/shp/Testing"

# Obtener la lista de archivos en la carpeta
archivos <- list.files(path = ruta_carpeta, pattern = "\\.shp$", full.names = TRUE)

# Iterar sobre cada archivo para agregar formato de fechas en plataforma eomapping
for (archivo in archivos) {
  # Obtener el nombre de la capa del archivo .shp
  capas <- st_layers(archivo)
  nombre_capa <- capas$name[1]  # Suponemos que solo hay una capa
  
  # Cargar el shapefile sin el archivo .shx
  shapefile <- st_read(dsn = archivo, layer = nombre_capa, quiet = TRUE)
  
  # Verificar si tiene una columna 'date' con el formato dado
  if ("date" %in% colnames(shapefile)) {
    # Extraer la fecha en el formato deseado y agregarla en una nueva columna
    shapefile$fecha <- extraer_fecha(shapefile$date)
  }
  
  # Eliminar las columnas 'eomapping' y 'date' si existen
  shapefile <- shapefile[, !(colnames(shapefile) %in% c("eomapping", "date"))]
  
  # Guardar el shapefile modificado
  st_write(shapefile, dsn = archivo, delete_dsn = TRUE)
}

# Crear directorio para las líneas de estación
dir.create(file.path(ruta_carpeta, "LINEAS_ESTACION"), showWarnings = FALSE)

# Iterar en archivos de la carpeta de entrada
for (archivo in archivos) {
  # Cargar shapefiles
  gdf <- st_read(archivo)
  
  # Convertir la columna de fecha a formato de fecha
  gdf$fecha <- dmy(gdf$fecha) # En esta línea se usa dmy() para el formato de día-mes-año
  
  # Filtrar por estación de invierno (solsticio de invierno a equinoccio de primavera)
  gdf_invierno <- gdf %>% filter((month(fecha) == 6 & day(fecha) >= 21) |
                                   (month(fecha) %in% 7:8) |
                                   (month(fecha) == 9 & day(fecha) <= 21))
  
  # Filtrar por estación de verano (solsticio de verano a equinoccio de otoño)
  gdf_verano <- gdf %>% filter((month(fecha) == 12 & day(fecha) >= 21) | 
                                 (month(fecha) %in% 1:2) | 
                                 (month(fecha) == 3 & day(fecha) <= 21))
  
  # Añadir la columna 'uncy' con valor 1
  gdf_invierno$uncy <- 1
  gdf_verano$uncy <- 1
  
  # Obtener el nombre base del archivo sin la extensión
  nombre_base <- tools::file_path_sans_ext(basename(archivo))
  
  # Agregar sufijo y escribir los archivos shapefile
  st_write(gdf_invierno, paste0(ruta_carpeta, "/LINEAS_ESTACION/", nombre_base, "_invierno.shp"))
  st_write(gdf_verano, paste0(ruta_carpeta, "/LINEAS_ESTACION/", nombre_base, "_verano.shp"))
}
