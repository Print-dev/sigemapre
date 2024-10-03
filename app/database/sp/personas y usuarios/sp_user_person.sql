USE SIGEMAPRE;

-- PERSONA
CREATE VIEW v_personas AS
	SELECT * FROM personas;
    
-- USUARIO
CREATE VIEW v_usuarios AS
	SELECT
    US.idusuario,
    US.usuario,
    RO.rol
    FROM usuarios US
    LEFT JOIN roles RO ON US.idrol = RO.idrol;

SELECT*FROM v_usuarios;
