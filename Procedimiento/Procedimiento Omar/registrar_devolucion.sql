CREATE OR REPLACE PROCEDURE registrar_devolucion(
    _id_renta INT -- ID de la renta que se está devolviendo
)
LANGUAGE plpgsql
AS $$
DECLARE
    maquina_id INT; -- Cambié el nombre de la variable para evitar ambigüedad
BEGIN
    -- Verificar que la renta existe
    IF NOT EXISTS (SELECT 1 FROM rentas WHERE id_renta = _id_renta) THEN
        RAISE EXCEPTION 'Error: No existe una renta con el ID %.', _id_renta;
    END IF;

    -- Obtener el ID de la máquina asociada a la renta
    SELECT r.id_maquina INTO maquina_id
    FROM rentas r
    WHERE r.id_renta = _id_renta;

    -- Verificar que la máquina está actualmente no disponible
    IF NOT EXISTS (SELECT 1 FROM maquinas WHERE id_maquina = maquina_id AND disponible = FALSE) THEN
        RAISE EXCEPTION 'Error: La máquina con ID % ya está disponible o no está asociada a esta renta.', maquina_id;
    END IF;

    -- Marcar la máquina como disponible
    UPDATE maquinas
    SET disponible = TRUE
    WHERE id_maquina = maquina_id;

    -- Notificación de éxito
    RAISE NOTICE 'Devolución registrada exitosamente. La máquina con ID % está ahora disponible.', maquina_id;
END;
$$;



CALL registrar_devolucion(7);
