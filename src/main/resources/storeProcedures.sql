/*COPIAS Y EJECUTAR EL CODIGO CONSECUTIVAMENTE*/
CREATE DATABASE ventas;
USE ventas;

CREATE TABLE clientes (
                          codigo INT AUTO_INCREMENT PRIMARY KEY,
                          nombre VARCHAR(255),
                          apellido VARCHAR(255),
                          email VARCHAR(255),
                          telefono VARCHAR(15),
                          fechaRegistro DATE
);

ALTER TABLE clientes
    ADD totalCompras DECIMAL(10, 2);



/*PROCEDURES*/
CREATE PROCEDURE AgregarCliente(
    IN p_nombre VARCHAR(255),
    IN p_apellido VARCHAR(255),
    IN p_email VARCHAR(255),
    IN p_telefono VARCHAR(15),
    IN p_fechaRegistro DATE,
    IN p_totalCompras DECIMAL(10,2)
)
BEGIN
INSERT INTO clientes (nombre, apellido, email, telefono, fechaRegistro,totalCompras)
VALUES (p_nombre, p_apellido, p_email, p_telefono, p_fechaRegistro,p_totalCompras);
END;


CREATE PROCEDURE ActualizarCliente(
    IN p_codigo INT,
    IN p_nombre VARCHAR(255),
    IN p_apellido VARCHAR(255),
    IN p_email VARCHAR(255),
    IN p_telefono VARCHAR(15),
    IN p_fechaRegistro DATE,
    IN p_totalCompras DECIMAL(10,2)
)
BEGIN
UPDATE clientes
SET
    nombre = p_nombre,
    apellido = p_apellido,
    email = p_email,
    telefono = p_telefono,
    fechaRegistro = p_fechaRegistro,
    totalCompras=p_totalCompras
WHERE codigo = p_codigo;
END;



CREATE PROCEDURE BuscarCliente(
    IN filtro VARCHAR(255)
)
BEGIN
SELECT * FROM clientes
WHERE codigo LIKE CONCAT('%', filtro, '%')
   OR nombre LIKE CONCAT('%', filtro, '%')
   OR apellido LIKE CONCAT('%', filtro, '%');
END;



CREATE PROCEDURE BuscarClientePorCodigo(IN codigoCliente INT)
BEGIN
SELECT * FROM clientes WHERE codigo = codigoCliente;
END;




CREATE PROCEDURE EliminarClientePorCodigo(IN p_codigo INT)
BEGIN
DELETE FROM clientes WHERE codigo = p_codigo;
END ;




CREATE PROCEDURE ListarClientes()
BEGIN
SELECT * FROM clientes;
END;