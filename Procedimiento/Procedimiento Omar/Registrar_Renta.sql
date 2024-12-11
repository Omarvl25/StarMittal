
------------------------------
----Omar Vega--
CREATE OR REPLACE PROCEDURE registrar_renta(
    _id_cliente INT,
    _id_empleado INT,
    _id_maquina INT,
    _dias INT,
    _costo_diario NUMERIC
)
LANGUAGE plpgsql
AS $$
DECLARE
    numero_renta INT; -- Para almacenar el ID de la renta
    subtotal NUMERIC; -- Para almacenar el cálculo del subtotal
BEGIN
    -- Verificar existencia del cliente
    IF NOT EXISTS (SELECT 1 FROM clientes WHERE id_cliente = _id_cliente) THEN
        RAISE EXCEPTION 'Error: El cliente con ID % no existe.', _id_cliente;
    END IF;

    -- Verificar existencia del empleado
    IF NOT EXISTS (SELECT 1 FROM empleados WHERE id_empleado = _id_empleado) THEN
        RAISE EXCEPTION 'Error: El empleado con ID % no existe.', _id_empleado;
    END IF;

    -- Verificar disponibilidad de la máquina
    IF NOT EXISTS (SELECT 1 FROM maquinas WHERE id_maquina = _id_maquina AND disponible = TRUE) THEN
        RAISE EXCEPTION 'Error: La máquina con ID % no está disponible.', _id_maquina;
    END IF;

    -- Calcular el subtotal
    subtotal := _dias * _costo_diario;

    -- Registrar la renta
    INSERT INTO rentas(id_cliente, id_empleado, id_maquina, dias_renta, costo_diario, subtotal, fecha_renta)
    VALUES (_id_cliente, _id_empleado, _id_maquina, _dias, _costo_diario, subtotal, CURRENT_DATE)
    RETURNING id_renta INTO numero_renta;

    -- Marcar la máquina como no disponible
    UPDATE maquinas
    SET disponible = FALSE
    WHERE id_maquina = _id_maquina;

    -- Notificación de éxito
    RAISE NOTICE 'Renta registrada exitosamente con número: %', numero_renta;
END;
$$;

-- Prueba del procedimiento
CALL registrar_renta(
    2, -- ID del cliente
    2, -- ID del empleado
    2, -- ID de la máquina
    1, -- Días de renta
    750 -- Costo diario
);



SELECT * FROM rentas;
SELECT * FROM maquinas WHERE id_maquina =2;
SELECT * FROM clientes WHERE id_cliente =2;
SELECT * FROM empleados WHERE id_empleado = 2;











