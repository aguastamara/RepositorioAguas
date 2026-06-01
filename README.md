# 📘 Agenda de Citas – Base de Datos MySQL

Este repositorio contiene el script **agenda_citas_db.sql**, diseñado para crear una base de datos de gestión de citas en **MySQL** utilizando **phpMyAdmin**.

---

## 🎯 Objetivo
Permitir a los estudiantes importar y comprender la estructura de una base de datos relacional con tres tablas principales: **clientes**, **servicios** y **reservas**.

---

## 🧩 Pasos para importar el archivo en phpMyAdmin

1. Ingrese a **phpMyAdmin** desde su navegador.  
2. Seleccione la opción **Importar** en el menú superior.  
3. Haga clic en **Seleccionar archivo** y cargue `agenda_citas_db.sql`.  
4. Presione **Continuar** para ejecutar el script.  
5. Verifique que se haya creado la base de datos `agenda_citas_db` con sus tablas.

---

## 🧱 Estructura de la base de datos

### Tabla `clientes`
- id_cliente (PK)  
- nombre  
- apellido  
- email  
- telefono  
- password_hash  
- fecha_registro  
- estado  

### Tabla `servicios`
- id_servicio (PK)  
- nombre  
- descripcion  
- duracion_minutos  
- precio  
- estado  

### Tabla `reservas`
- id_reserva (PK)  
- id_cliente (FK → clientes.id_cliente)  
- id_servicio (FK → servicios.id_servicio)  
- fecha_reserva  
- hora_reserva  
- estado  
- notas  
- fecha_creacion  

---

## 🔗 Relaciones
- Un **cliente** puede tener muchas **reservas**.  
- Un **servicio** puede estar en muchas **reservas**.  
- Cada **reserva** pertenece a un cliente y a un servicio específico.  

---

## 🧮 Ejemplos de consultas

```sql
-- Ver todos los clientes registrados
SELECT * FROM clientes;

-- Ver todas las reservas confirmadas
SELECT * FROM reservas WHERE estado = 'confirmada';

-- Consultar las reservas de un cliente específico
SELECT r.id_reserva, s.nombre AS servicio, r.fecha_reserva, r.hora_reserva
FROM reservas r
JOIN servicios s ON r.id_servicio = s.id_servicio
WHERE r.id_cliente = 1;

