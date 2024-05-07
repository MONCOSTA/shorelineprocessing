library(sf)

##ESTA RUTINA SE APLICA TANTO PARA LAS LINEAS COMO LOS PUNTOS


# Función para extraer la fecha en el formato dd-mm-yyyy
extraer_fecha <- function(fecha_hora) {
  fecha <- as.Date(fecha_hora, format = "%Y/%m/%d %H:%M:%S")
  return(format(fecha, "%d-%m-%Y"))
}

# Ruta de la carpeta que contiene los archivos shapefile
ruta_carpeta <- "C:/Users/joaquin.valenzuela/Documents/shp/Ohiggins/Puntos"

# Obtener la lista de archivos en la carpeta
archivos <- list.files(path = ruta_carpeta, pattern = "\\.shp$", full.names = TRUE)

# Iterar sobre cada archivo
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
    
    # Guardar el shapefile modificado
    st_write(shapefile, dsn = archivo, delete_dsn = TRUE)
  }
}




