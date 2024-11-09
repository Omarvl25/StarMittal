-- Tabla Clientes
SELECT
    id_cliente,
    nombre,
    direccion,
    JSON_ARRAY(telefono) AS telefono,
    correo_electronico,
    descuento
FROM clientes
FOR JSON PATH
