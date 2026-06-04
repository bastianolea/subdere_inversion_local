Descarga todas las planillas Excel con proyectos de inversión local desde el sitio [Portal Ciudadano de Inversión Local](http://inversionmunicipal.subdere.gov.cl/) de Subdere.


## Web scraping

Los datos se obtienen usando web scraping para automatizar un navegador web que navega la página y presiona los botones de descarga. De esta manera se pueden obtener los datos de todas las regiones actualizadas al día con ejecutar un sólo script.

`scraping.R` abre una sesión de Firefox usando el paquete `RSelenium` y navega por la página de Subdere para descargar las planillas Excel de cada región. Los archivos descargados aparecen en tu carpeta de descargas, y deben ser movidos a `datos/original`

## Procesamiento

El script `procesar.R` lee todos los archivos Excel descargados y los une, los procesa y los guarda en formato Parquet en `datos/datos_subdere.parquet`.
