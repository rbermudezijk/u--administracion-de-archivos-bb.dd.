CREATE DATABASE IF NOT EXISTS ms_administracion_de_archivos;
USE ms_administracion_de_archivos;

CREATE TABLE IF NOT EXISTS lca__llaves(
    id_llave        INT UNSIGNED AUTO_INCREMENT,
	llave           VARCHAR(156) UNIQUE NOT NULL,
    propietario     VARCHAR(100),
    __insercion     DATETIME DEFAULT CURRENT_TIMESTAMP,
    __actualizacion DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY(id_llave)
) ENGINE=INNODB DEFAULT CHARSET='utf8';

CREATE TABLE IF NOT EXISTS sa__archivos(
    id_archivo       INT UNSIGNED AUTO_INCREMENT,
    id_propietario   INT UNSIGNED NOT NULL,
    nombre     VARCHAR(100) NOT NULL,
    extension  VARCHAR(10)  NOT NULL,
    tipo_mime  VARCHAR(30)  NOT NULL,
    ubicacion  VARCHAR(200) DEFAULT '/',
	__insercion      DATETIME DEFAULT CURRENT_TIMESTAMP,
    __actualizacion  DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY(id_archivo),
    CONSTRAINT propietario_de_archivos
        FOREIGN KEY(id_propietario)
        REFERENCES lca__llaves(id_llave)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT archivo_unico
        UNIQUE(id_propietario, ubicacion, nombre)
) Engine = InnoDB DEFAULT CHARSET='utf8';

CREATE USER 'usuario'@'dominio'
IDENTIFIED BY 'contraseña-1234';

GRANT ALL PRIVILEGES ON ms_administracion_de_archivos.*
TO 'usuario'@'dominio';

select * from mysql.user;
insert into lca__llaves(llave, propietario) values(sha2('aplicacion-app:aplicacion-password', 256), 'Aplicacion S.A. de C.V.');