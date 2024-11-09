-- Tabla Sucursales 
SELECT
    id_sucursal,
    nombre,
    direccion,
    JSON_ARRAY(telefono) AS telefono
FROM sucursales
FOR JSON PATH
