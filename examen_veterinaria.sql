-- =====================================================
-- CREACIÓN DE BASE DE DATOS
-- =====================================================
DROP DATABASE sistema_venta;
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE;

SET SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE SCHEMA IF NOT EXISTS `sistema_venta`
DEFAULT CHARACTER SET utf8;

USE `sistema_venta`;

-- =====================================================
-- TABLA MASCOTA
-- =====================================================

CREATE TABLE IF NOT EXISTS `mascota` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `nombre` VARCHAR(45) NOT NULL,
    `especie` VARCHAR(45) NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB;


-- =====================================================
-- TABLA PROPIETARIO
-- =====================================================

CREATE TABLE IF NOT EXISTS `propietario` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `nombre` VARCHAR(45) NOT NULL,
    `apellido` VARCHAR(45) NOT NULL,
    `telefono` VARCHAR(45) NOT NULL,
    `mascota_fk` INT NOT NULL,

    PRIMARY KEY (`id`),

    CONSTRAINT `fk_propietario_mascota`
        FOREIGN KEY (`mascota_fk`)
        REFERENCES `mascota` (`id`)
        ON DELETE NO ACTION
        ON UPDATE CASCADE
) ENGINE = InnoDB;


-- =====================================================
-- TABLA VETERINARIO
-- =====================================================

CREATE TABLE IF NOT EXISTS `veterinario` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `especialidad` VARCHAR(45) NOT NULL,
    `nombre` VARCHAR(45) NOT NULL,
    `telefono` VARCHAR(45) NOT NULL,

    PRIMARY KEY (`id`)
) ENGINE = InnoDB;


-- =====================================================
-- TABLA DETALLE CONSULTA
-- =====================================================

CREATE TABLE IF NOT EXISTS `detalle_consulta` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `motivo` VARCHAR(100) NOT NULL,
    `mascota_fk` INT NOT NULL,
    `cantidad` INT NOT NULL DEFAULT 1,

    PRIMARY KEY (`id`),

    CONSTRAINT `fk_detalle_consulta_mascota`
        FOREIGN KEY (`mascota_fk`)
        REFERENCES `mascota` (`id`)
        ON DELETE NO ACTION
        ON UPDATE CASCADE
) ENGINE = InnoDB;


-- =====================================================
-- TABLA CONSULTA
-- =====================================================

CREATE TABLE IF NOT EXISTS `consulta` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `mascota_fk` INT NOT NULL,
    `fecha` DATE NOT NULL,
    `veterinario_fk` INT NOT NULL,
    `detalle_consulta_fk` INT NOT NULL,

    PRIMARY KEY (`id`),

    CONSTRAINT `fk_consulta_mascota`
        FOREIGN KEY (`mascota_fk`)
        REFERENCES `mascota` (`id`)
        ON DELETE NO ACTION
        ON UPDATE CASCADE,

    CONSTRAINT `fk_consulta_veterinario`
        FOREIGN KEY (`veterinario_fk`)
        REFERENCES `veterinario` (`id`)
        ON DELETE NO ACTION
        ON UPDATE CASCADE,

    CONSTRAINT `fk_consulta_detalle`
        FOREIGN KEY (`detalle_consulta_fk`)
        REFERENCES `detalle_consulta` (`id`)
        ON DELETE NO ACTION
        ON UPDATE CASCADE
) ENGINE = InnoDB;


-- =====================================================
-- TABLA TRATAMIENTO
-- =====================================================

CREATE TABLE IF NOT EXISTS `tratamiento` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `nombre` VARCHAR(45) NOT NULL,
    `costo` DECIMAL(10,2) NOT NULL,

    PRIMARY KEY (`id`)
) ENGINE = InnoDB;


-- =====================================================
-- RESTAURAR CONFIGURACIÓN
-- =====================================================

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;



-- =====================================================
-- INSERTAR MASCOTAS
-- =====================================================

INSERT INTO mascota (nombre, especie) VALUES
('Max', 'Perro'),
('Luna', 'Gato'),
('Rocky', 'Perro'),
('Nala', 'Gato'),
('Toby', 'Perro'),
('Coco', 'Conejo');


-- =====================================================
-- INSERTAR PROPIETARIOS
-- =====================================================

INSERT INTO propietario 
(nombre, apellido, telefono, mascota_fk) VALUES
('Juan', 'Perez', '3001234567', 1),
('Maria', 'Gomez', '3012345678', 2),
('Carlos', 'Rodriguez', '3023456789', 3),
('Laura', 'Martinez', '3034567890', 4),
('Andres', 'Torres', '3045678901', 5),
('Sofia', 'Ramirez', '3056789012', 6);


-- =====================================================
-- INSERTAR VETERINARIOS
-- =====================================================

INSERT INTO veterinario 
(especialidad, nombre, telefono) VALUES
('Medicina general', 'Dr. Alejandro Ruiz', '3101234567'),
('Dermatologia', 'Dra. Carolina Lopez', '3112345678'),
('Cirugia', 'Dr. Felipe Castro', '3123456789'),
('Oftalmologia', 'Dra. Valentina Silva', '3134567890'),
('Cardiologia', 'Dr. Sebastian Moreno', '3145678901');


-- =====================================================
-- INSERTAR DETALLE CONSULTA
-- =====================================================

INSERT INTO detalle_consulta 
(motivo, mascota_fk, cantidad) VALUES
('Revision general', 1, 1),
('Problemas en la piel', 2, 1),
('Dolor abdominal', 3, 1),
('Problemas en los ojos', 4, 1),
('Vacunacion', 5, 1),
('Revision general', 6, 1),
('Perdida de apetito', 1, 1),
('Problemas digestivos', 3, 1);


-- =====================================================
-- INSERTAR CONSULTAS
-- =====================================================

INSERT INTO consulta 
(mascota_fk, fecha, veterinario_fk, detalle_consulta_fk) VALUES
(1, '2026-08-01', 1, 1),
(2, '2026-08-03', 2, 2),
(3, '2026-08-05', 3, 3),
(4, '2026-08-07', 4, 4),
(5, '2026-08-10', 1, 5),
(6, '2026-08-12', 1, 6),
(1, '2026-08-15', 1, 7),
(3, '2026-08-20', 1, 8);


-- =====================================================
-- INSERTAR TRATAMIENTOS
-- =====================================================

INSERT INTO tratamiento 
(nombre, costo) VALUES
('Vacunacion', 35000.00),
('Desparasitacion', 25000.00),
('Limpieza dental', 80000.00),
('Tratamiento dermatologico', 65000.00),
('Cirugia menor', 150000.00),
('Tratamiento digestivo', 55000.00),
('Tratamiento oftalmologico', 70000.00),
('Control general', 30000.00);

-- =====================================================
-- INSERTAR MASCOTAS
-- =====================================================

INSERT INTO mascota (nombre, especie) VALUES
('Max', 'Perro'),
('Luna', 'Gato'),
('Rocky', 'Perro'),
('Nala', 'Gato'),
('Toby', 'Perro'),
('Coco', 'Conejo');


-- =====================================================
-- INSERTAR PROPIETARIOS
-- =====================================================

INSERT INTO propietario 
(nombre, apellido, telefono, mascota_fk) VALUES
('Juan', 'Perez', '3001234567', 1),
('Maria', 'Gomez', '3012345678', 2),
('Carlos', 'Rodriguez', '3023456789', 3),
('Laura', 'Martinez', '3034567890', 4),
('Andres', 'Torres', '3045678901', 5),
('Sofia', 'Ramirez', '3056789012', 6);


-- =====================================================
-- INSERTAR VETERINARIOS
-- =====================================================

INSERT INTO veterinario 
(especialidad, nombre, telefono) VALUES
('Medicina general', 'Dr. Alejandro Ruiz', '3101234567'),
('Dermatologia', 'Dra. Carolina Lopez', '3112345678'),
('Cirugia', 'Dr. Felipe Castro', '3123456789'),
('Oftalmologia', 'Dra. Valentina Silva', '3134567890'),
('Cardiologia', 'Dr. Sebastian Moreno', '3145678901');


-- =====================================================
-- INSERTAR DETALLE CONSULTA
-- =====================================================

INSERT INTO detalle_consulta 
(motivo, mascota_fk, cantidad) VALUES
('Revision general', 1, 1),
('Problemas en la piel', 2, 1),
('Dolor abdominal', 3, 1),
('Problemas en los ojos', 4, 1),
('Vacunacion', 5, 1),
('Revision general', 6, 1),
('Perdida de apetito', 1, 1),
('Problemas digestivos', 3, 1);


-- =====================================================
-- INSERTAR CONSULTAS
-- =====================================================

INSERT INTO consulta 
(mascota_fk, fecha, veterinario_fk, detalle_consulta_fk) VALUES
(1, '2026-08-01', 1, 1),
(2, '2026-08-03', 2, 2),
(3, '2026-08-05', 3, 3),
(4, '2026-08-07', 4, 4),
(5, '2026-08-10', 1, 5),
(6, '2026-08-12', 1, 6),
(1, '2026-08-15', 1, 7),
(3, '2026-08-20', 1, 8);


-- =====================================================
-- INSERTAR TRATAMIENTOS
-- =====================================================

INSERT INTO tratamiento 
(nombre, costo) VALUES
('Vacunacion', 35000.00),
('Desparasitacion', 25000.00),
('Limpieza dental', 80000.00),
('Tratamiento dermatologico', 65000.00),
('Cirugia menor', 150000.00),
('Tratamiento digestivo', 55000.00),
('Tratamiento oftalmologico', 70000.00),
('Control general', 30000.00);


select nombre, especialidad from veterinario;

SELECT mascota.nombre AS nombre_mascota, mascota.especie, CONCAT(propietario.nombre, ' ', propietario.apellido) AS propietario FROM mascota INNER JOIN propietario ON mascota.id = propietario.mascota_fk;