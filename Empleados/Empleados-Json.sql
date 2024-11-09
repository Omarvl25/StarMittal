-- Tabla Empleados
SELECT
    id_empleado,
    nombre,
    id_rol,
    id_turno,
    id_sucursal
FROM empleados
FOR JSON PATH 
