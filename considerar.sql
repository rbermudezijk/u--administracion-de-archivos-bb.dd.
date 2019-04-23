--
-- Manejo de carpetas
--
DROP TABLE sa__carpetas;
CREATE TABLE IF NOT EXISTS sa__carpetas(
    id_carpeta       INT UNSIGNED AUTO_INCREMENT, -- sis
    id_propietario   INT UNSIGNED NOT NULL,       -- sis.
    id_carpeta_padre INT UNSIGNED,                -- |url.web
    ubicacion        VARCHAR(200) DEFAULT '/',    -- |url.web
    nombre           VARCHAR(100) NOT NULL,       -- b.web
    __insercion      DATETIME DEFAULT CURRENT_TIMESTAMP,
    __actualizacion  DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY(id_carpeta),
    CONSTRAINT propietario_de_carpeta
        FOREIGN KEY(id_propietario)
        REFERENCES lca__llaves(id_llave)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
	CONSTRAINT carpeta_padre
        FOREIGN KEY(id_carpeta_padre)
        REFERENCES sa__carpetas(id_carpeta)
	    ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT carpeta_unica
        UNIQUE(id_propietario, ubicacion, nombre)
) Engine = InnoDB DEFAULT CHARSET='utf8';


DROP TABLE sa__archivos;
CREATE TABLE IF NOT EXISTS sa__archivos(
    id_archivo       INT UNSIGNED AUTO_INCREMENT, -- sis
    id_propietario   INT UNSIGNED NOT NULL,       -- sis.
    -- id_carpeta_padre INT UNSIGNED,                -- |url.web
    nombre     VARCHAR(100) NOT NULL,             -- b.web
    extension  VARCHAR(10)  NOT NULL,             -- b.web
    tipo_mime  VARCHAR(30)  NOT NULL,             -- b.web
    ubicacion  VARCHAR(200) DEFAULT '/',          -- |url.web <-> sis
	__insercion      DATETIME DEFAULT CURRENT_TIMESTAMP,
    __actualizacion  DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY(id_archivo),
    CONSTRAINT propietario_de_archivos
        FOREIGN KEY(id_propietario)
        REFERENCES lca__llaves(id_llave)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
--    CONSTRAINT carpeta_contenedora
--        FOREIGN KEY(id_carpeta_padre)
--        REFERENCES sa__carpetas(id_carpeta)
--        ON DELETE CASCADE,
    CONSTRAINT archivo_unico
        UNIQUE(id_propietario, ubicacion, nombre)
) Engine = InnoDB DEFAULT CHARSET='utf8';