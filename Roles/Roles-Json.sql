-- Tabla Roles 
    SELECT 
        id_rol,
        nombre_rol
    FROM roles
    FOR JSON PATH;