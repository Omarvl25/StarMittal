CREATE OR REPLACE PROCEDURE registrar_venta2(
    _id_cliente INT,
    _id_empleado INT,
    _productos JSON
)
LANGUAGE plpgsql
AS $$
DECLARE
    numero_venta INT;
    producto RECORD;
    total NUMERIC := 0; -- Variable para almacenar el total
BEGIN
    -- Verificar la existencia del cliente
    IF NOT EXISTS (SELECT 1 FROM clientes WHERE id_cliente = _id_cliente) THEN
        RAISE EXCEPTION 'Error: El cliente con ID % no existe.', _id_cliente;
    END IF;

    -- Verificar la existencia del empleado
    IF NOT EXISTS (SELECT 1 FROM empleados WHERE id_empleado = _id_empleado) THEN
        RAISE EXCEPTION 'Error: El empleado con ID % no existe.', _id_empleado;
    END IF;

    -- Calcular el total de la venta
    FOR producto IN SELECT * FROM json_to_recordset(_productos) AS (
        id_producto INT,
        cantidad INT,
        precio_unitario NUMERIC
    ) LOOP
        total := total + (producto.cantidad * producto.precio_unitario);
    END LOOP;

    -- Registrar la venta con un id_sucursal fijo
    INSERT INTO ventas(id_cliente, id_empleado, fecha_venta, total, id_sucursal)
    VALUES (_id_cliente, _id_empleado, CURRENT_DATE, total, 1) -- Asume que la sucursal tiene el ID 1
    RETURNING id_venta INTO numero_venta;

    -- Procesar los productos e insertar en detalle_ventas
    FOR producto IN SELECT * FROM json_to_recordset(_productos) AS (
        id_producto INT,
        cantidad INT,
        precio_unitario NUMERIC
    ) LOOP
        -- Verificar la existencia del producto
        IF NOT EXISTS (SELECT 1 FROM productos WHERE id_producto = producto.id_producto) THEN
            RAISE EXCEPTION 'Error: El producto con ID % no existe.', producto.id_producto;
        END IF;

        -- Insertar en detalle_ventas
        INSERT INTO detalle_ventas(id_venta, id_producto, cantidad, precio_unitario)
        VALUES (
            numero_venta,
            producto.id_producto,
            producto.cantidad,
            producto.precio_unitario
        );

        -- Actualizar inventario usando la columna correcta
        UPDATE inventarios
        SET cantidad = cantidad - producto.cantidad
        WHERE id_producto = producto.id_producto;

        -- Verificar inventario negativo
        IF (SELECT cantidad FROM inventarios WHERE id_producto = producto.id_producto) < 0 THEN
            RAISE EXCEPTION 'Error: No hay suficiente inventario para el producto %', producto.id_producto;
        END IF;
    END LOOP;

    RAISE NOTICE 'Venta registrada exitosamente con número: %', numero_venta;
END;
$$;





CALL registrar_venta2(
   3 , -- ID del cliente
    1, -- ID del empleado
    '[{"id_producto": 1, "cantidad": 1, "precio_unitario": 100}, {"id_producto": 1, "cantidad": 1, "precio_unitario": 100}]' -- JSON con productos
);

SELECT * FROM ventas;

SELECT * FROM detalle_ventas;


SELECT * FROM inventarios 









