USE SIGEMAPRE;

DROP PROCEDURE IF EXISTS `verificarPlanInconcluso`
DELIMITER $$
CREATE PROCEDURE `verificarPlanInconcluso`(IN _idplantarea INT)
BEGIN
	SELECT 
        pt.idplantarea, 
        pt.descripcion, 
        pt.borrador,
        COUNT(t.idtarea) AS cantidad_tareas,
        COUNT(a.idactivo) AS cantidad_activos
    FROM plandetareas pt
    LEFT JOIN tareas t ON pt.idplantarea = t.idplantarea
    LEFT JOIN activos_vinculados_tarea a ON t.idtarea = a.idtarea
    WHERE pt.idplantarea = _idplantarea
    GROUP BY pt.idplantarea, pt.descripcion;
END $$


DROP PROCEDURE IF EXISTS `verificarOrdenInconclusa`
DELIMITER //
CREATE PROCEDURE `verificarOrdenInconclusa`
(
	IN _idorden_trabajo INT
)
BEGIN
	SELECT
		*
        FROM odt ODT
        LEFT JOIN diagnosticos DIA ON DIA.idorden_trabajo = ODT.idorden_trabajo
        WHERE ODT.idorden_trabajo = 21 AND ODT.borrador = 1;
	
END //