use SIGEMAPRE;

DROP PROCEDURE IF EXISTS `asignarResponsables`
DELIMITER //
CREATE PROCEDURE `asignarResponsables`
(
	OUT _idresponsable_asignado INT,
	IN _idorden_trabajo INT,
    IN _idresponsable INT
)
BEGIN
	-- Declaracion de variables
	DECLARE existe_error INT DEFAULT 0;
    
    -- Manejador de excepciones
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
		BEGIN
        SET existe_error = 1;
        END;
	INSERT INTO responsables_asignados (idorden_trabajo, idresponsable) values
		(_idorden_trabajo, _idresponsable);
        
	IF existe_error = 1 THEN
		SET _idresponsable_asignado = -1;
	ELSE
        SET _idresponsable_asignado = LAST_INSERT_ID();
    END IF;
END

