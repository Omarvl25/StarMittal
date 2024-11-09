-- Tabla Proveedores
SELECT
    id_proveedor,
    nombre,
    direccion,
    JSON_ARRAY(telefono) AS telefono
FROM proveedores
FOR JSON PATH
