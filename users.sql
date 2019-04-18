CREATE USER 'ms-administracion-de-archivos'@localhost
IDENTIFIED BY 'ms-administracion-de-archivos-1234';

GRANT ALL PRIVILEGES ON ms_administracion_de_archivos.*
TO 'ms-administracion-de-archivos'@localhost;