CREATE DATABASE IF NOT EXISTS ms_administracion_de_archivos;
use ms_administracion_de_archivos;

CREATE TABLE IF NOT EXISTS lca__llaves(
    id_llave        INT UNSIGNED AUTO_INCREMENT,
    llave           VARCHAR(256) UNIQUE,
    __insercion     DATETIME DEFAULT CURRENT_TIMESTAMP,
    __actualizacion DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY(id_llave)
) ENGINE=INNODB DEFAULT CHARSET='utf8';

CREATE TABLE IF NOT EXISTS lca__ip_permitidas(
    id_ip           INT UNSIGNED AUTO_INCREMENT,
    id_llave        INT UNSIGNED NOT NULL,
    ip              VARCHAR(100) NOT NULL,
    __insercion     DATETIME DEFAULT CURRENT_TIMESTAMP,
    __actualizacion DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY(id_ip),
    CONSTRAINT bloqueo_por_ip
        FOREIGN KEY (id_llave)
        REFERENCES lca__llaves(id_llave)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) Engine=InnoDB DEFAULT CHARSET='utf8';

CREATE TABLE sa__carpetas(
    id_carpeta       INT UNSIGNED AUTO_INCREMENT,
    id_propietario   INT UNSIGNED NOT NULL,
    nombre           VARCHAR(100),
    __insercion      DATETIME DEFAULT CURRENT_TIMESTAMP,
    __actualizacion  DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY(id_carpeta),
    CONSTRAINT propietario_de_carpeta
        FOREIGN KEY(id_propietario)
        REFERENCES lca__llaves(id_llave)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT carpeta_unica
        UNIQUE(id_propietario, nombre)
) Engine = InnoDB DEFAULT CHARSET='utf8';

CREATE TABLE sa__archivos(
    id_archivo INT UNSIGNED AUTO_INCREMENT,
    id_llave   INT UNSIGNED NOT NULL,
    id_carpeta INT UNSIGNED,
    nombre     VARCHAR(100) NOT NULL,
    extension  VARCHAR(20)  NOT NULL,
    tipo_mime  VARCHAR(100) NOT NULL,
    PRIMARY KEY(id_archivo),
    CONSTRAINT propietario_de_archivos
        FOREIGN KEY(id_llave)
        REFERENCES lca__llaves(id_llave)
        ON DELETE CASCADE
        ON UPDATE CASCADE
    CONSTRAINT carpeta_contenedora
        FOREIGN KEY(id_carpeta)
        REFERENCES carpeta(id_carpeta)
        ON DELETE CASCADE
    CONSTRAINT archivo_unico
        UNIQUE(id_carpeta, nombre)
) Engine = InnoDB DEFAULT CHARSET='utf8';