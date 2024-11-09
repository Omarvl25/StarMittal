-- Tabla Turnos
SELECT  
    id_turno,
    hora_inicio,
    hora_fin
FROM turnos
FOR JSON PATH; 