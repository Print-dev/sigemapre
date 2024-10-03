USE SIGEMAPRE;

DROP PROCEDURE IF EXISTS `sp_user_login`
DELIMITER $$
CREATE PROCEDURE `sp_user_login`
(
	IN _usuario VARCHAR(120)
)
BEGIN
	SELECT
    US.idusuario,
    CONCAT(PE.apellidos, ' ', PE.nombres) datos,
    US.usuario,
    RO.rol,
    US.contrasena,
    US.estado
    FROM usuarios US
    LEFT JOIN personas PE ON US.idpersona = PE.idpersona
    LEFT JOIN roles RO ON US.idrol = RO.idrol
    WHERE usuario=_usuario;
END $$

SELECT PE.idpermiso, ROL.rol, PE.permiso FROM permisos PE
INNER JOIN roles ROL ON PE.idrol = ROL.idrol WHERE ROL.rol='usuario';

CALL sp_user_login ('r.avalos');
select * from activos;