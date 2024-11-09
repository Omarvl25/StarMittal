-- Tabla Productos
SELECT
    id_producto,
    nombre_producto,
    id_categoria
FROM productos
FOR JSON PATH
