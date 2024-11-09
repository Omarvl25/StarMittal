-- Tabla Categorias
SELECT
    id_categoria,
    nombre_categoria
FROM categorias 
FOR JSON PATH;
