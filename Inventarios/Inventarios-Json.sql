-- Tabla Inventarios
SELECT
    id_inventario,
    id_producto,
    cantidad,
    minimo_stock,
    maximo_stock,
    punto_reorden
FROM inventarios
FOR JSON PATH
