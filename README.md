Para la descarga masiva de líneas litorales se usa el algoritmo CoastSat diseñado por Kilian Vos (https://github.com/kvos/CoastSat), rutina creada en Jupyter. Las instrucciones de descarga y procesamiento de líneas se encuentran detalladas dentro de su repositorio, pero es necesario remarcar algunos detalles:

RECOMENDACIONES:

Idealmente, que el área de estudio sea demarcada en Google Earth, exportándolo en KML y posteriormente transformarlo a GeoJSON. El algoritmo en teoría es capaz de leer archivos KML, pero en el caso personal no funcionó. Revisar rutina de R para cambiar de formato.

Por último, al momento de definir el área de estudio, se debe acotar lo que mas se pueda la playa a descargar, producto que la presencia de objetos/formas tales como edificaciones, humedales de marisma, lagunas artificiales, y otros cuerpos de agua; generarán una extracción errónea en las líneas de costa al momento de filtrar. Por lo mismo, es sumamente importante que las líneas que se vayan generando no sean interrumpidas o no tengan vacíos entre sí

Luego, ubicar archivo GeoJSON en carpeta "examples" de CoastSat, y en carpeta "data" agregar una carpeta con el nombre del área de interés.

![image](https://github.com/MONCOSTA/shorelineprocessing/assets/166852064/e936abbb-a197-45ed-96a3-c7129e748fc6)

![image](https://github.com/MONCOSTA/shorelineprocessing/assets/166852064/9fab77b2-ab00-43d8-836a-8e00a31217a7)



Posterior definir parámetros como rango de fechas, misiones a seleccionar, escena de Sentinel-2 para no repetir imágenes, proyección, etc (para mas detalles, revisar Github de CoastSat).

IMPORTANTE!! Leer cada línea y descripción de celdas que tiene el algoritmo para un mejor entendimiento de este. Muchas funciones son vitales para que la extracción de líneas se haga de forma más simple, automatizada, y sin muchos errores.

CASO ESPECIAL: Para playas muy pequeñas, modificar en la celda 1.3.2 Shoreline extraction el parámetro 'min_lenght_sl', si no el algoritmo no detectará la línea de costa por sus dimensiones. En "min_beach_area" también se puede ajustar la dimensión de la playa en lo que respecta a superficie.

![image](https://github.com/MONCOSTA/shorelineprocessing/assets/166852064/e14dcdc3-39ce-4217-9a00-1759afdbc1bc)



IMPORTANTE!! PT2. Al momento de finalizar la descarga de las líneas de costa en la tercera celda del punto 1.3.3 Batch shoreline detection, descargar el archivo en formato puntos (points) y líneas (lines). Dentro de la celda hay un comentario del autor donde se especifica la opción para elegir el formato de descarga. Una vez descargado un archivo, la celda pasa de asterisco a número, en ese momento se debe cambiar al segundo formato y correr nuevamente la celda. Ambos formatos se guardarán en la carpeta.

![image](https://github.com/MONCOSTA/shorelineprocessing/assets/166852064/0946e8a6-42e3-4fc3-bdb6-79677a580b12)


Se debe prestar atención al archivo GeoJSON de líneas ya que debe ser corregido, esto ya que el algoritmo inicialmente va elaborando puntos donde existe el cambio entre el mar y la costa (agua vs suelo firme), y el algoritmo da la opción al final (ver imagen anterior) de exportarlo también en líneas. Al exportarlo en líneas, realiza una unión de los puntos que están asociados a una línea de costa.

Cuando estos puntos presentan interrupciones, se tienden a generar arcos al momento de unirlos, por lo cual deben ser eliminados. Es sumamente importante registrar cuales líneas se eliminan ya que en el archivo de puntos deben ser también eliminados. Siempre mantener la misma información entre los puntos y líneas, es estrictamente importante para los siguientes procesos.

![image](https://github.com/MONCOSTA/shorelineprocessing/assets/166852064/1d0eac95-e389-42f8-a044-05114b41f993)

En la imagen, se observa una cantidad considerable de arcos en las líneas, donde ya no es viable eliminarlos ya que altera la representatividad de la muestra. Por ello se deben tener en consideración las recomendaciones escritas al inicio de este documento.

El script de procesamiento de lineas actúa por carpeta, es decir, de una carpeta toma todos los archivos vectoriales para modificar el mismo archivo, y generar otros archivos vectoriales correspondientes a las lineas de costa de invierno y verano.

También se debe considerar el procesamiento de los archivos en formato puntos. Dicho código requiere como elemento de entrada el de líneas de costa (ya con sus líneas corregidas) y el original en formato puntos. Este script individualiza cada punto y añade un campo de fecha en formato dia-mes-año.
Como actúa de forma individual, se debe ingresar manualmente la ruta donde están los archivos de entrada y también de salida. Para mayores detalles, revisar script asociado al procesamiento de puntos

Todo el post proceso se puede resumir en el siguiente diagrama de flujo:

![flujo_sds](https://github.com/MONCOSTA/shorelineprocessing/assets/166852064/ec7bd8fd-075c-449e-8020-9a1b70b9145e)


Los códigos necesarios están subidos en el repositorio.
