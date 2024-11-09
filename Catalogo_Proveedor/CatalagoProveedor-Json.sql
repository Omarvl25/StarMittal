-- Tabla Catalago Proveedor
SELECT
    id_catalogo_proveedor,
    id_proveedor,
    id_producto
FROM catalogo_proveedor
FOR JSON PATH
