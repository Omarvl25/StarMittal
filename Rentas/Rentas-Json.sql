-- Tabla Renta con DetalleRentas
SELECT
    id_renta,
    id_cliente,
    fecha_inicio_renta,
    fecha_fin_renta,
    (
        SELECT
            id_detalle_renta,
            id_producto,
            cantidad,
            precio_unitario,
            descuento,
            anticipo
        FROM detalle_rentas
        WHERE detalle_rentas.id_renta = rentas.id_renta
        FOR JSON PATH
    ) AS detalle_rentas
FROM rentas
FOR JSON PATH
