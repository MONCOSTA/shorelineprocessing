# Instala las librerías si no están instaladas
if (!requireNamespace("sf", quietly = TRUE)) {
  install.packages("sf")
}

# Carga la librería necesaria
library(sf)

# Ruta al archivo KML de entrada y salida
ruta_kml <- "C:/Users/joaquin.valenzuela/Documents/CoastSat kmz/kml/Vina.kml"
ruta_geojson <- "C:/Users/joaquin.valenzuela/Documents/CoastSat kmz/geojson/Vina.geojson"

# Lee el archivo KML
datos_kml <- st_read(dsn = ruta_kml)

# Convierte a GeoJSON
st_write(datos_kml, dsn = ruta_geojson, driver = "GeoJSON")