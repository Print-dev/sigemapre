USE SIGEMAPRE;

DROP PROCEDURE IF EXISTS `registrar_odt`
DELIMITER //
CREATE PROCEDURE `registrar_odt`
(
	IN _idtarea INT,
    IN _creado_por INT
)
BEGIN
	INSERT INTO odt (idtarea, creado_por)
		VALUES (_idtarea, _creado_por);
        
	SELECT MAX(idorden_trabajo) as id from odt;
END //


DROP PROCEDURE IF EXISTS `registrarDiagnostico`
DELIMITER //
CREATE PROCEDURE `registrarDiagnostico`
(
	IN _idorden_trabajo INT,
    IN _idtipo_diagnostico INT,
    IN _diagnostico VARCHAR(300),
    IN _evidencias JSON
)
BEGIN
	INSERT INTO diagnosticos (idorden_trabajo, idtipo_diagnostico, diagnostico, evidencias)
		VALUES (_idorden_trabajo, _idtipo_diagnostico, _diagnostico, _evidencias);
END //

CALL registrarDiagnostico(20,1,'desde mysql', '{"e1":"img.jpg","e2":"img2.jpg", "e3":"img3.jpg"}')

DROP PROCEDURE IF EXISTS `asignarResponsablesODT`
DELIMITER //
CREATE PROCEDURE `asignarResponsablesODT`
(
	IN _idorden_trabajo INT,
    IN _idresponsable	INT
)
BEGIN
	INSERT INTO responsables_asignados (idorden_trabajo, idresponsable)
		VALUES (_idorden_trabajo, _idresponsable);
END //

DROP PROCEDURE IF EXISTS `registrarHistorial`
DELIMITER //
CREATE PROCEDURE `registrarHistorial`
(
	IN _idorden_trabajo INT,
    IN _estado_anterior INT,
    IN _estado_nuevo 	INT,
    IN _comentario		TEXT,
    IN _devuelto		BOOLEAN
)
BEGIN
	INSERT INTO historial_estado_odt (_idorden_trabajo, _estado_anterior, _estado_nuevo, _comentario, _devuelto)	
		VALUES (_idorden_trabajo, _estado_anterior, _estado_nuevo, _comentario, NULLIF(_devuelto, ""));
END //
