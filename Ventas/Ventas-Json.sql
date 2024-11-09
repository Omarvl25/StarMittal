-- Tabla Ventas con DetalleVentas
SELECT
    id_venta,
    FORMAT(fecha_venta, 'yyyy-MM-dd') AS fecha_venta,
    id_cliente,
    total,
    tipo_venta,
    tipo_pago,
    id_empleado,
    (
        SELECT
            id_detalle_venta,
            id_producto,
            cantidad,
            precio_unitario,
            descuento,
            numero_serie
        FROM detalle_ventas
        WHERE detalle_ventas.id_venta = ventas.id_venta
        FOR JSON PATH
    ) AS detalle_ventas
FROM ventas
FOR JSON PATH 
