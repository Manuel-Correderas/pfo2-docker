CREATE DATABASE IF NOT EXISTS pfo2_db;
USE pfo2_db;

CREATE TABLE IF NOT EXISTS alumnos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(50),
  carrera VARCHAR(50)
);

INSERT INTO alumnos (nombre, carrera) VALUES
('Manuel Correderas', 'Software'),
('Daniel Coria', 'Software'),
('María Nazar','Software');
