USE SIGEMAPRE;

DROP PROCEDURE `actualizarPlanDeTareas`
DELIMITER $$
CREATE PROCEDURE actualizarPlanDeTareas(
    IN _idplantarea INT, 
    IN _descripcion VARCHAR(30), 
    IN _borrador BOOLEAN)
BEGIN
    UPDATE plandetareas 
    SET descripcion = _descripcion, 
        borrador = _borrador, 
        update_at = NOW()
    WHERE idplantarea = _idplantarea;
END $$
DELIMITER ;

-- ***************************************************************

DELIMITER $$
CREATE PROCEDURE actualizarTarea(
    IN _idtarea INT,
    IN _idtipo_prioridad INT,
    IN _descripcion VARCHAR(200), 
    IN _tiempo_estimado TIME, 
    IN _fecha_inicio DATETIME,
    IN _fecha_vencimiento DATETIME, 
    IN _cant_intervalo INT, 
    IN _frecuencia VARCHAR(10), 
    IN _idestado INT)
BEGIN
    UPDATE tareas 
    SET 
		idtipo_prioridad = _idtipo_prioridad,
		descripcion = _descripcion,
        tiempo_estimado = _tiempo_estimado, 
        fecha_inicio = _fecha_inicio,
        fecha_vencimiento = _fecha_vencimiento,
        cant_intervalo = _cant_intervalo, 
        frecuencia = _frecuencia,
        idestado = _idestado, 
        update_at = NOW()
    WHERE idtarea = _idtarea;
    
    SELECT MAX(idtarea) as id FROM tareas;
END $$


-- CALL actualizarTarea(52,2, 'linkin park', '', '', '', 2, 'mes', 15);
-- select * from tareas;
-- ********************************************************************

DELIMITER $$
CREATE PROCEDURE actualizarRecursoPorTarea(
    IN _idrecurso_vinculado INT, 
    IN _idrecurso INT, 
    IN _idtarea INT, 
    IN _cantidad INT)
BEGIN
    UPDATE recursos_vinculados_tarea 
    SET idrecurso = _idrecurso, 
        idtarea = _idtarea, 
        cantidad = _cantidad, 
        update_at = NOW()
    WHERE idrecurso_vinculado = _idrecurso_vinculado;
END $$
DELIMITER ;

-- call actualizarRecursoPorTarea(14, 5, 14, 69);
-- *******************************************************************

DELIMITER $$
CREATE PROCEDURE actualizarActivoPorTarea(
    IN _idactivo_vinculado INT, 
    IN _idactivo INT, 
    IN _idtarea INT)
BEGIN
    UPDATE activos_vinculados_tarea 
    SET idactivo = _idactivo, 
        idtarea = _idtarea, 
        update_at = NOW()
    WHERE idactivo_vinculado = _idactivo_vinculado;
END $$
DELIMITER ;

-- *******************************************************************

DELIMITER $$
CREATE PROCEDURE actualizarDetalleRecurso(
    IN _iddetalle_recurso INT, 
    IN _stock_total INT, 
    IN _en_uso INT, 
    IN _en_reparacion INT, 
    IN _idestado INT)
BEGIN
    UPDATE detalle_recurso 
    SET stock_total = _stock_total, 
        en_uso = _en_uso, 
        en_reparacion = _en_reparacion,
        idestado = _idestado, 
        update_at = NOW()
    WHERE iddetalle_recurso = _iddetalle_recurso;
END $$
DELIMITER ;
