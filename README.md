Para la descarga masiva de líneas litorales se usa el algoritmo CoastSat diseñado por Kilian Vos (https://github.com/kvos/CoastSat), rutina creada en Jupyter. Las instrucciones de descarga y procesamiento de líneas se encuentran detalladas dentro de su repositorio, pero es necesario remarcar algunos detalles

RECOMENDACIONES
Idealmente, que el área de estudio sea demarcada en Google Earth, exportándolo en KML y posteriormente transformarlo a GeoJSON El algoritmo en teoría es capaz de leer archivos KML, pero en el caso personal no funcionó. Revisar rutina de R para cambiar de formato.

Por último, al momento de definir el área de estudio, se debe acotar lo que mas se pueda la playa a descargar, producto que la presencia de objetos/formas tales como edificaciones, humedales de marisma, lagunas artificiales, y otros cuerpos de agua; generarán una extracción errónea en las líneas de costa al momento de filtrar.

Luego, ubicar archivo GeoJSON en carpeta "examples" de CoastSat, y en carpeta "data" agregar una carpeta con el nombre del área de interés

Posterior definir parámetros como rango de fechas, misiones a seleccionar, escena de Sentinel-2 para no repetir imágenes, proyección, etc

IMPORTANTE!! Leer cada línea y descripción de celdas que tiene el algoritmo para un mejor entendimiento de este.

CASO ESPECIAL: Para playas muy pequeñas, modificar en la celda 1.3.2 Shoreline extraction el parámetro 'min_lenght_sl', si no el algoritmo no detectará la línea de costa por sus dimensiones

IMPORTANTE!! PT2. Al momento de finalizar la descarga de las líneas de costa en la tercera celda del punto 1.3.3 Batch shoreline detection, descargar el archivo en formato puntos (points) y líneas (lines). Dentro de la celda hay un comentario del autor donde se especifica la opción para elegir el formato de descarga. Una vez descargado un archivo, la celda pasa de asterisco a número, en ese momento se debe cambiar al segundo formato y correr nuevamente la celda. Ambos formatos se guardarán en la carpeta.
