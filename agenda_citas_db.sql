-- ============================================================
-- CREACIÓN DE BASE DE DATOS: agenda_citas_db
-- ============================================================
-- Se crea la base de datos solo si no existe.
-- utf8mb4 permite usar caracteres especiales y emojis.
CREATE DATABASE IF NOT EXISTS `agenda_citas_db`
  DEFAULT CHARACTER SET utf8mb4
  COLLATE utf8mb4_general_ci;

-- Activamos el uso de la base de datos
USE `agenda_citas_db`;

-- ============================================================
-- TABLA: clientes
-- ============================================================
-- Aquí se guardan los datos de las personas que usan el sistema.
CREATE TABLE `clientes` (
  `id_cliente` INT(11) NOT NULL AUTO_INCREMENT, -- Identificador único
  `nombre` VARCHAR(100) NOT NULL,               -- Nombre del cliente
  `apellido` VARCHAR(100) NOT NULL,             -- Apellido del cliente
  `email` VARCHAR(120) NOT NULL,                -- Correo electrónico (único)
  `telefono` VARCHAR(20) NOT NULL,              -- Número de teléfono
  `password_hash` VARCHAR(255) DEFAULT NULL,    -- Contraseña encriptada
  `fecha_registro` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP(), -- Fecha de registro automático
  `estado` ENUM('activo','inactivo') DEFAULT 'activo', -- Estado del cliente
  PRIMARY KEY (`id_cliente`),                   -- Llave primaria
  UNIQUE KEY `email` (`email`),                 -- Evita correos duplicados
  KEY `idx_clientes_email` (`email`)            -- Índice para búsquedas rápidas por email
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Ejemplo de inserción de un cliente
INSERT INTO `clientes` (`nombre`, `apellido`, `email`, `telefono`, `password_hash`, `estado`)
VALUES ('CARLOS MARIO', 'TORRES MARTINEZ', 'camatoma@gmail.com', '3123730629',
        '$2y$10$pAf9Ep0xsydOp0vCPCnsc.XN6ROrLsi7T0VpHyuefCILO/f4PP23e', 'activo');

-- ============================================================
-- TABLA: servicios
-- ============================================================
-- Aquí se registran los servicios disponibles (peluquería, salud, mecánica, etc.)
CREATE TABLE `servicios` (
  `id_servicio` INT(11) NOT NULL AUTO_INCREMENT, -- Identificador único
  `nombre` VARCHAR(100) NOT NULL,                -- Nombre del servicio
  `descripcion` TEXT DEFAULT NULL,               -- Descripción del servicio
  `duracion_minutos` INT(11) NOT NULL,           -- Duración estimada en minutos
  `precio` DECIMAL(8,2) NOT NULL,                -- Precio con 2 decimales
  `estado` ENUM('activo','inactivo') DEFAULT 'activo', -- Estado del servicio
  PRIMARY KEY (`id_servicio`)                    -- Llave primaria
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Ejemplo de inserción de servicios
INSERT INTO `servicios` (`nombre`, `descripcion`, `duracion_minutos`, `precio`, `estado`) VALUES
('Corte Cabello', 'Corte de cabello profesional', 30, 25.00, 'activo'),
('Afeitado', 'Afeitado tradicional con navaja', 20, 15.00, 'activo'),
('Tintura', 'Tintura de cabello', 60, 40.00, 'activo'),
('Cambio de Aceite', 'Cambio de aceite para vehículos', 45, 35.00, 'activo'),
('Revisión General', 'Consulta médica general', 30, 50.00, 'activo'),
('Vacunación', 'Servicio de vacunación', 15, 20.00, 'activo');

-- ============================================================
-- TABLA: reservas
-- ============================================================
-- Aquí se guardan las citas o reservas hechas por los clientes.
CREATE TABLE `reservas` (
  `id_reserva` INT(11) NOT NULL AUTO_INCREMENT, -- Identificador único
  `id_cliente` INT(11) NOT NULL,                -- Relación con cliente
  `id_servicio` INT(11) NOT NULL,               -- Relación con servicio
  `fecha_reserva` DATE NOT NULL,                -- Fecha de la cita
  `hora_reserva` TIME NOT NULL,                 -- Hora de la cita
  `estado` ENUM('confirmada','pendiente','cancelada','completada') DEFAULT 'confirmada', -- Estado de la cita
  `notas` TEXT DEFAULT NULL,                    -- Observaciones adicionales
  `fecha_creacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP(), -- Fecha de creación automática
  PRIMARY KEY (`id_reserva`),                   -- Llave primaria
  UNIQUE KEY `unique_reserva_servicio_hora` (`id_servicio`,`fecha_reserva`,`hora_reserva`), -- Evita duplicar citas en mismo servicio y hora
  KEY `idx_reservas_cliente` (`id_cliente`),    -- Índice para buscar reservas por cliente
  KEY `idx_reservas_fecha` (`fecha_reserva`),   -- Índice para buscar reservas por fecha
  CONSTRAINT `reservas_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id_cliente`) ON DELETE CASCADE,
  CONSTRAINT `reservas_ibfk_2` FOREIGN KEY (`id_servicio`) REFERENCES `servicios` (`id_servicio`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Ejemplo de inserción de una reserva
INSERT INTO `reservas` (`id_cliente`, `id_servicio`, `fecha_reserva`, `hora_reserva`, `estado`)
VALUES (1, 1, '2026-05-16', '10:30:00', 'confirmada');
