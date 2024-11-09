-- Tabla Produccion Empleados 
SELECT
    id_produccion,
    id_empleado
FROM produccion_empleados
FOR JSON PATH
