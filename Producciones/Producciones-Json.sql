-- Tabla Producciones
SELECT
    id_produccion,
    id_producto,
    FORMAT(fecha_produccion, 'yyyy-MM-dd') AS fecha_produccion,
    cantidad_producida
FROM producciones
FOR JSON PATH 
