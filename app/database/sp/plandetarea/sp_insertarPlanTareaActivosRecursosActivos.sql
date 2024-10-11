USE SIGEMAPRE;

DELIMITER ;

DROP PROCEDURE IF EXISTS `insertarPlanDeTareas`
DELIMITER $$
CREATE PROCEDURE `insertarPlanDeTareas`(
	IN _descripcion VARCHAR(30),
    IN _borrador BOOLEAN
)
BEGIN
    INSERT INTO plandetareas (descripcion, borrador)
    VALUES (_descripcion, _borrador);
    
    SELECT MAX(idplantarea) as id from plandetareas;
END $$
DELIMITER ;

-- CALL insertarPlanDeTareas('Mantenimiento SIS');
-- select * from tareas;
-- *******************************************************************************

DROP PROCEDURE IF EXISTS `insertarTarea`
DELIMITER $$
CREATE PROCEDURE `insertarTarea`(
    IN _idplantarea INT,
    IN _idtipo_prioridad INT,
    IN _descripcion VARCHAR(200),
    IN _fecha_inicio DATETIME,
    IN _fecha_vencimiento DATETIME,
    IN _cant_intervalo INT,
    IN _frecuencia VARCHAR(10),
    IN _idestado INT
)
BEGIN
    INSERT INTO tareas (
        idplantarea, idtipo_prioridad, descripcion,
        fecha_inicio, fecha_vencimiento, cant_intervalo, frecuencia, idestado
    )
    VALUES (
        _idplantarea, _idtipo_prioridad, _descripcion,
        _fecha_inicio, _fecha_vencimiento, _cant_intervalo, _frecuencia, _idestado
    );
    
    SELECT MAX(idtarea) as id from tareas;
END $$
DELIMITER ;

-- CALL insertarTarea(
--    1,  -- idplantarea (supongamos que es 1)
--    2,  -- idtipo_prioridad (supongamos que es 2)
--    'Revisión de Ventilador', '02:00:00', '2024-10-01 08:00:00', 
--    '2024-10-31 17:00:00', 3, 'Mensual', 1
-- );

 
-- *******************************************************************************
DROP PROCEDURE IF EXISTS `insertarRecursoPorTarea`
DELIMITER $$
CREATE PROCEDURE `insertarRecursoPorTarea`(
    IN _idrecurso INT,
    IN _idtarea INT,
    IN _cantidad SMALLINT
)
BEGIN
    INSERT INTO recursos_vinculados_tarea (idrecurso, idtarea, cantidad)
    VALUES (_idrecurso, _idtarea, _cantidad);
    
    SELECT MAX(idrecurso_vinculado) as id FROM recursos_vinculados_tarea;
END $$
DELIMITER ;

-- CALL insertarRecursoPorTarea(1, 1, 10);  -- idrecurso 1, idtarea 1, cantidad 10
-- ********************************************************************

DROP PROCEDURE IF EXISTS `insertarActivoPorTarea`
DELIMITER $$
CREATE PROCEDURE `insertarActivoPorTarea`(
    IN _idactivo INT,
    IN _idtarea INT
)
BEGIN
    INSERT INTO activos_vinculados_tarea (idactivo, idtarea)
    VALUES (_idactivo, _idtarea);
    
    SELECT MAX(idactivo_vinculado) as id from activos_vinculados_tarea;
END $$
DELIMITER ;

-- CALL insertarActivoPorTarea(4, 30);  -- idactivo 1, idtarea 1
-- select * from activos_vinculados_tarea;

-- *********************************************************************

-- FUTUROS PROCEDIMIENTOS ALMACENADOS CUANDO SE REGISTRE UN RECURSO AHI SE TENDRA QUE ASIGNAR AL ID CATEGORIA 
