create database ecommerce;
use ecommerce;
-- Eliminar las tablas si ya existían (para evitar conflictos)
DROP TABLE IF EXISTS detalle_ventas;
DROP TABLE IF EXISTS ventas;
DROP TABLE IF EXISTS empleados;
DROP TABLE IF EXISTS clientes;
DROP TABLE IF EXISTS productos;
DROP TABLE IF EXISTS categorias;
DROP TABLE IF EXISTS usuarios;
DROP TABLE IF EXISTS roles;
#creacion de las tablas
-- Crear la tabla roles
CREATE TABLE roles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

-- Crear la tabla usuarios con nombres y apellidos desagregados
CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombres VARCHAR(50) NOT NULL,
    apellidos VARCHAR(50) NOT NULL,
    direccion VARCHAR(150),
    telefono VARCHAR(20),
    correo VARCHAR(100) NOT NULL UNIQUE,
    contraseña VARCHAR(255) NOT NULL,
    rol_id INT NOT NULL,
    FOREIGN KEY (rol_id) REFERENCES roles(id)
);

-- Crear la tabla clientes sin la columna nombre
CREATE TABLE clientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tipo_ciente VARCHAR(20),
    usuario_id INT NOT NULL,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);

-- Crear la tabla empleados sin la columna nombre
CREATE TABLE empleados (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cargo VARCHAR(50),
    salario DECIMAL(10, 2),
    usuario_id INT NOT NULL,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);

-- Crear la tabla categorias
CREATE TABLE categorias (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

-- Crear la tabla productos
CREATE TABLE productos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    precio DECIMAL(10, 2),
    stock INT,
	descripcion TEXT,
    categoria_id INT,
    FOREIGN KEY (categoria_id) REFERENCES categorias(id)
);

-- Crear la tabla ventas
CREATE TABLE ventas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    fecha DATE NOT NULL,
    total DECIMAL(10, 2),
    cliente_id INT NOT NULL,
    empleado_id INT NOT NULL,
    FOREIGN KEY (cliente_id) REFERENCES clientes(id),
    FOREIGN KEY (empleado_id) REFERENCES empleados(id)
);

-- Crear la tabla detalle_ventas
CREATE TABLE detalle_ventas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    venta_id INT NOT NULL,
    producto_id INT NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10, 2),
    FOREIGN KEY (venta_id) REFERENCES ventas(id),
    FOREIGN KEY (producto_id) REFERENCES productos(id)
);
-- Insertar datos en la tabla roles
INSERT INTO roles (nombre) VALUES
('Administrador'),
('Vendedor'),
('Cliente'),
('Gerente'),
('Supervisor'),
('Contador'),
('Cajero');

-- Insertar datos en la tabla usuarios
INSERT INTO usuarios (nombres, apellidos, direccion, telefono, correo, contraseña, rol_id) VALUES
('Juan', 'Pérez', 'Calle Falsa 123', '0991234567', 'juan@mail.com', 'abc123', 1),
('Ana', 'Gómez', 'Av. Siempre Viva 456', '0987654321', 'ana@mail.com', 'abc456', 2),
('Carlos', 'López', 'Callejón del Sol 789', '0998765432', 'carlos@mail.com', 'abc789', 3),
('Lucía', 'Martínez', 'Plaza Norte', '0976543210', 'lucia@mail.com', 'abc987', 4),
('Pedro', 'Fernández', 'Barrio Central', '0965432109', 'pedro@mail.com', 'abc654', 5),
('Laura', 'Ortega', 'Residencial San Luis', '0954321098', 'laura@mail.com', 'abc321', 6),
('Diego', 'Vargas', 'Urbanización La Pradera', '0943210987', 'diego@mail.com', 'abc000', 7);

-- Insertar datos en la tabla clientes
INSERT INTO clientes (tipo_ciente, usuario_id) VALUES
('Frecuente', 3),
('Nuevo', 1),
('Frecuente', 4),
('Nuevo', 2),
('Corporativo', 5),
('Frecuente', 6),
('Corporativo', 7);

-- Insertar datos en la tabla empleados
INSERT INTO empleados (cargo, salario, usuario_id) VALUES
('Vendedor', 1200.00, 2),
('Gerente', 3000.00, 4),
('Supervisor', 1800.00, 5),
('Cajero', 1000.00, 7),
('Contador', 2500.00, 6),
('Vendedor', 1200.00, 3),
('Cajero', 1000.00, 1);

-- Insertar datos en la tabla categorias
INSERT INTO categorias (nombre) VALUES
('Electrónica'),
('Ropa'),
('Alimentos'),
('Muebles'),
('Juguetes'),
('Libros'),
('Herramientas');

-- Insertar datos en la tabla productos
INSERT INTO productos (nombre, precio, stock, descripcion, categoria_id) VALUES
('Televisor 42"', 450.00, 20, 'Smart TV Full HD', 1),
('Camiseta Algodón', 15.00, 50, 'Talla M', 2),
('Galletas Chocolate', 2.50, 100, 'Paquete de 300g', 3),
('Sofá 3 Plazas', 550.00, 10, 'Color Gris', 4),
('Lego City', 40.00, 30, 'Set de construcción', 5),
('Novela Ficción', 12.00, 20, 'Best seller', 6),
('Taladro Inalámbrico', 75.00, 15, 'Incluye batería recargable', 7);

-- Insertar datos en la tabla ventas
INSERT INTO ventas (fecha, total, cliente_id, empleado_id) VALUES
('2024-10-01', 450.00, 1, 2),
('2024-10-02', 30.00, 2, 3),
('2024-10-03', 75.00, 3, 4),
('2024-10-04', 120.00, 4, 5),
('2024-10-05', 600.00, 5, 6),
('2024-10-06', 15.00, 6, 7),
('2024-10-07', 300.00, 7, 2);

-- Insertar datos en la tabla detalle_ventas
INSERT INTO detalle_ventas (venta_id, producto_id, cantidad, precio_unitario) VALUES
(1, 1, 1, 450.00),
(2, 2, 2, 15.00),
(3, 3, 10, 2.50),
(4, 4, 1, 550.00),
(5, 5, 2, 40.00),
(6, 6, 3, 12.00),
(7, 7, 1, 75.00);


select * from categorias;
select * from productos; -- Erick Nuñez
select * from clientes;
select * from empleados;
select * from roles;
select * from usuarios;
select * from ventas;
select * from detalle_ventas;
-- Cambiar el tipo de dato en la tabla ventas, la columna fecha tiene el tipo de dato date y cambiarlo por timestamp.
alter table ventas
modify column fecha timestamp;
select * from ventas;

-- Seleccionar clientes de tipo frecuente
select * from clientes
Where tipo_ciente = 'Frecuente';
-- Seleccionar usuarios cullo apellido se 'Perez'
select * from usuarios
Where apellidos = 'Perez'; -- Erick Nuñez
-- Listar todos los empleados con salario mayor a 1500
SELECT * FROM empleados
WHERE salario > 1500.00;
-- Seleccionar productos con stock menor a 20
SELECT * FROM productos
WHERE stock < 20;
-- Listar todas las ventas con un total mayor a 100
SELECT * FROM ventas -- Erick Nuñez
WHERE total > 100;
-- Obtener empleados que tengan un salario mayor a 2000 y cuyo cargo no sea 'Cajero'
select * from empleados
Where salario > 2000 and cargo != 'Cajero';
-- Seleccionar clientes que sean de tipo 'Frecuente' o 'Corporativo'
select * from clientes
Where tipo_ciente = 'Frecuente' or tipo_ciente = 'Corporativo';
-- Obtener productos cuyo nombre sea igual a 'Camiseta Algodón' y su precio sea menor a 20
select * from productos
Where nombre = 'Camiseta Algodon' and precio < 20;
-- Listar ventas que tengan un total diferente de 100 y donde el cliente sea el usuario con ID 3
select * from ventas
where total != 100 and cliente_id = 3;
select nombre, precio from productos
Where precio between 20.00 and 100.00;
-- Obtener todos los empleados que tengan un salario menor a 1500 o sean 'Gerente'
select * from empleados
Where salario <= 1500 or cargo = 'Gerente';
-- Obtener todas las categorías cuyo nombre comienza con 'E':
SELECT * FROM categorias
WHERE nombre LIKE 'E%'; -- Buscar al inicio de una palabra
-- Erick Nuñez
SELECT * FROM categorias
WHERE nombre LIKE '%a'; -- Buscar al final de una palabra

-- Seleccionar usuarios cuyos nombres comienzan con J
SELECT * FROM usuarios
WHERE nombres LIKE 'J%'; 

-- Listar productos cuyo nombre contiene la palabra
SELECT * FROM productos
WHERE nombre LIKE 'Camiseta%';

-- Obtener categorías cuyos nombres terminan con 's':
SELECT * FROM categorias
WHERE nombre LIKE '%s';
-- Seleccionar empleados cuyos cargos comienzan con 'C' 
select * from empleados
where cargo like 'C%'; -- Erick Nuñez
-- Listar clientes cuyo tipo contiene la letra 'e'
select * from clientes
where tipo_ciente like '%e%';
-- Obtener usuarios cuyos correos electrónicos contienen 'gmail'
-- uso de update 
update usuarios set correo = 'juan@gmail.com'
where id = 1;
update usuarios set correo = 'ana@gmail.com'
where id = 2;
SELECT * FROM usuarios
WHERE correo LIKE '%gmail.com%';
select * from usuarios;
-- Seleccionar productos cuyos precios son menores a 50 y cuyo nombre contiene 'Juego':
SELECT * FROM productos
WHERE precio < 50.00 AND nombre LIKE '%Juego%';
-- Obtener usuarios que tienen 'a' en cualquier parte de sus apellidos
select * from usuarios
where apellidos like '%a%'; -- Erick Nuñez
-- Seleccionar productos cuyo nombre tiene exactamente 9 caracteres
SELECT * FROM productos
WHERE nombre LIKE '_________';  
-- Seleccionar todos los roles que sean 'Administrador', 'Cliente' o 'Vendedor'
SELECT * FROM roles
WHERE nombre IN ('Administrador', 'Cliente', 'Vendedor');
-- Seleccionar empleados que tengan un salario específico de 1500, 2000 o 2500
SELECT * FROM empleados
WHERE salario IN (1500,2000,2500);
-- Listar ventas realizadas por los clientes con ID 1, 2 o 3
SELECT * FROM clientes
WHERE id IN (1,2,3);
-- Obtener usuarios que tienen el apellido 'Pérez' o 'Gómez'
select * from usuarios
Where apellidos = 'Pérez' or apellidos = 'Gómez'; -- Erick Nuñez
-- Obtener todas las ventas en las que el total es 100, 200 o 300
select * from ventas
Where total in (100, 200,300);
-- Seleccionar empleados cuyo cargo es 'Gerente' o 'Asistente':
SELECT * FROM empleados
WHERE cargo IN ('Gerente', 'Asistente');
-- Listar clientes cuyo tipo de cliente es 'Frecuente' o 'Ocasional'
select * from clientes
Where tipo_ciente in ('Frecuente', 'Ocasional'); -- Erick Nuñez
-- Parte D del taller
-- Erick Nuñez
-- Contar la cantidad de usuarios por rol:
SELECT rol_id, COUNT(*) AS cantidad_usuarios
FROM usuarios
GROUP BY rol_id;
-- Obtener el total de ventas realizadas por cada cliente:
SELECT cliente_id, SUM(total) AS total_ventas
FROM ventas
GROUP BY cliente_id
ORDER BY total_ventas DESC;
-- Listar la cantidad de productos en cada categoría:
SELECT categoria_id, COUNT(*) AS cantidad_productos
FROM productos
GROUP BY categoria_id
ORDER BY cantidad_productos DESC;
 -- Obtener el salario promedio de los empleados por cargo:
SELECT cargo, AVG(salario) AS salario_promedio
FROM empleados
GROUP BY cargo
ORDER BY salario_promedio DESC;
-- Contar la cantidad de ventas realizadas en cada fecha:
SELECT fecha, COUNT(*) AS cantidad_ventas
FROM ventas -- Erick Nuñez
GROUP BY fecha
ORDER BY fecha DESC;
-- Listar los productos con su stock total agrupados por nombre:
SELECT nombre, SUM(stock) AS total_stock
FROM productos
GROUP BY nombre
ORDER BY total_stock DESC;
-- Contar la cantidad de clientes por tipo de cliente:
SELECT tipo_ciente, COUNT(*) AS cantidad_clientes
FROM clientes
GROUP BY tipo_ciente
ORDER BY cantidad_clientes DESC;
-- Obtener el precio máximo de productos por categoría:
SELECT categoria_id, MAX(precio) AS precio_maximo
FROM productos -- Erick Nuñez
GROUP BY categoria_id
ORDER BY precio_maximo DESC;

