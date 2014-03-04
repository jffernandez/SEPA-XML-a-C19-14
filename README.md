SEPA-XML-a-C19-14
=================

Script para convertir el fichero SEPA XML a Cuaderno 19-14

Tener que tener en cuenta que la transformación no abarcará todos los casos posibles, simplemente se hizo teniendo en cuenta un caso particular. Se comparte por si a alguien más le puede resultar de utilidad.

Solamente tiene en cuenta un acreedor y una sola fecha de presentación por XML, aunque el Cuaderno 19-14 permite varios.
Prestar atención a los caracteres no admitidos en los ficheros de CSB (solamente se están filtrando "Ñ" y "Ç")

Se comparten dos ficheros:
  - SEPA-C19-14.xsl<br/>
      Contiene la transformación XSL necesaria para convertir el fichero XML de SEPA en el fichero de texto C19-14

  - Convertir SEPA XML a C19-14.bat<br/>
      Es el script que buscará todos los archivos .xml en la ruta que se indique ("C:\Remesas\disco\") y ejecuta la transformación, generando un .dat para cada .xml

El archivo .bat tiene una ruta fija que debe ser adaptada: "C:\Remesas\disco\"

Es necesario añadir a la carpeta en donde se guarden estos dos ficheros un ejecutable que se encargue de la transformación. En el ejemplo he empleado XSLTransform que lo podéis encontrar en  http://zoomicon.com/tranXform/tools/XSLTransform/ y también lo he probado con Instant Saxon (http://sourceforge.net/projects/saxon/files/instant%20saxon/6.5.3/). El que me ha dado problemas ha sido: http://www.microsoft.com/en-us/download/details.aspx?id=21714

Una vez obtenido el ejecutable para lanzar la transformación, debe ajustarse el .bat para que realice la llamada correcta.
