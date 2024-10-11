USE SIGEMAPRE;

INSERT INTO TIPO_DOC (tipodoc) VALUES 
('DNI'),
('Carnet de Extranjería');

INSERT INTO PERSONAS (idtipodoc, num_doc, apellidos, nombres, genero, telefono, nacionalidad) VALUES 
(1, '12345678', 'González', 'Juan', 'M', '987654321', 'Peruano'),
(2, 'A1234567', 'Smith', 'Anna', 'F', '987654322', 'Chilena'),
(2, 'EX123456', 'Martínez', 'Carlos', 'M', '987654323', 'Colombiano'),
(1, '72754752', 'Avalos Romero', 'Royer Alexis', 'M', '936439633','Peruano'),
(1, '72754751', 'Avalos Romero', 'Pedro Aldair', 'M', '995213305','Peruano');


INSERT INTO ROLES (rol) VALUES 
('administrador'),
('usuario');

INSERT INTO USUARIOS (idpersona, idrol, usuario, contrasena) VALUES 
(1, 1, 'j.gonzalez', '$2y$10$kbJVca650dDJl8p5VeYsp.UPnopaRDH6HApAVTC.fqQp/54uj0Ld2'),
(2, 2, 'a.smith', '$2y$10$gNGni4OBLXh0IacQ/FH3Ou88C18NFstrdJ4K0.kKvkGlhMDC9EWXO'),
(3, 2, 'c.martinez', 'contrasena3'),
(4, 2, 'r.avalos', '$2y$10$VrxeMCQteaNdX6LwxoZEYevp8BCwKTpIKTVebChbXcxnNX7BTIFaW'),
(5, 1, 'p.avalos', '$2y$10$j1KccY6Iex7h19WR0pfMpumhp.dsjJkBCcFUbtVwbPCHw7hECJNyW');



UPDATE usuarios SET contrasena = '$2y$10$gNGni4OBLXh0IacQ/FH3Ou88C18NFstrdJ4K0.kKvkGlhMDC9EWXO'
WHERE idusuario=2;

INSERT INTO permisos(idrol, permiso)
VALUES
    (2, '{"activos":{"asignarActivo":{"read":true,"create":true,"update":false,"delete":false}},"ODT":{"read":true,"create":true,"update":false,"delete":false},"planTarea":{"read":true,"create":false,"update":false,"delete":false},"bajaActivo":{"read":true,"create":true,"update":false,"delete":false},"usuarios":{"ListaUsuario":{"read":false,"create":false,"update":false,"delete":false},"PermisoRol":{"read":false,"create":false,"update":false,"delete":false}}}'),
    (1, '{"activos":{"asignarActivo":{"read":true,"create":true,"update":true,"delete":true}},"ODT":{"read":true,"create":true,"update":true,"delete":false},"PlanTarea":{"read":true,"create":true,"update":false,"delete":false},"BajaActivo":{"read":true,"create":true,"update":true,"delete":false},"Usuarios":{"read":true,"create":true,"update":true,"delete":true}}');

UPDATE permisos set permiso ='{"activos":{"asignarActivo":{"read":true,"create":true,"update":true,"delete":true}},"ODT":{"read":true,"create":true,"update":true,"delete":false},"PlanTarea":{"read":true,"create":true,"update":false,"delete":false},"BajaActivo":{"read":true,"create":true,"update":true,"delete":false},"usuarios":{"ListaUsuario":{"read":true,"create": true,"update":true,"delete":true},"PermisoRol":{ "read":true,"create": true, "update":true, "delete":true}}}'
WHERE idpermiso=2;


INSERT INTO categorias(categoria)
VALUES
    ('Electrónica'),
    ('Herramientas Manuales'),
    ('Vehículos de Reparto'),
    ('Maquinaria Pesada'),
    ('Transporte');

-- INSERT INTO subcategorias(idcategoria, subcategoria)
-- VALUES
--    (1, 'Monitor'),
--    (1, 'Teclado'),
 --   (1, 'Mouse'),
--    (2, 'Compresor'),
--    (2, 'Tornillo de banco'),
--    (4, 'Equipo de Corte'),
--    (4, 'Equipo de Soldadura'),
--    (5, 'Motocicleta'),
--    (5, 'Camión de Carga'),
 --   (1, 'Impresora');



INSERT INTO marcas(marca)
	VALUES
		('LG'),
		('HP'),
		('Nissan'),
		('Caterpillar'),
		('Einhell'),
		('Hyundai'),
		('FenWick'),
		('ABB');
	


-- INSERCIONES ROYER
INSERT INTO estados (estado) values 
		('pendiente'),
        ('proceso'),
        ('revision'),
        ('finalizado'),
        ('activo'),
        ('en mantenimiento'),
        ('baja'),
        ('en uso'),
        ('en proceso'),
        ('aprobado'),
        ('rechazado'),
        ('asignado'),
        ('no asignado'),
        ('disponible'),
        ('agotado'),
        ('sin tomar'),
        ('vencido'),
        ('exitoso'),
        ('atrasado'),      
        ('disponible'),
        ('ocupado');
	
select * from estados;
	
-- select * from subcategorias;

INSERT INTO activos(idcategoria, idmarca, modelo, cod_identificacion, fecha_adquisicion, descripcion, especificaciones, idestado)
VALUES
    (1, 1, 'Monitor 4K', 'MON123', NOW(), 'Monitor LG de 27 pulgadas', '{"resolucion":"3840x2160"}', 5),
    (2, 2, 'Teclado Mecánico', 'TEC123', NOW(), 'Teclado mecánico HP', '{"tipo":"mecánico", "conectividad":"inalámbrico"}', 5),
    (3, 4, 'Compresor Industrial', 'COMP123', NOW(), 'Compresor Caterpillar de 10HP', '{"potencia":"10HP"}', 2),
    (4, 5, 'Camión de Carga Hyundai', 'CAM123', NOW(), 'Camión de carga pesada Hyundai', '{"capacidad":"10 toneladas"}', 2);    


INSERT INTO tipo_prioridades (tipo_prioridad) values ('baja'),('media'),('alta'),('urgente');

-- INSERT INTO plandetareas (descripcion, idcategoria ,borrador) values ('plan de mtto laptop', 1,null); 

-- INSERT INTO tareas (idplantarea, idtipo_prioridad, descripcion, tiempo_estimado, fecha_inicio, fecha_vencimiento, cant_intervalo, frecuencia, idestado) 
-- values (1, 3, 'remover polvo', '00:05:00', '2024-09-18', '2024-09-20','5', 'mes', 1),
-- (1, 2, 'revision de bateria', '00:10:00', '2024-09-20', '2024-09-30','2', 'mes', 1);

INSERT INTO proveedores (nombre, telefono)
VALUES 
('Proveedor 1', '123456789'),
('Proveedor 2', '987654321'),
('Proveedor 3', '112233445');
-- TAREAS, RECURSOS A TAREAS Y ACTIVOS A TAREAS
-- INSERT INTO tipos_recursos (tiporecurso, idprovedor)
-- VALUES 
-- ('Herramientas',1),
-- ('Equipos de Protección',2),
-- ('Materiales de Construcción',3),
-- ('Suministros Médicos',3);


select * from recursos;
INSERT INTO recursos (idcategoria, nombre, costo, descartable)
VALUES 
(1, 'Cable poder', 350.00, FALSE),
(1, 'Caja de tinta', 80.00, TRUE),
(1, 'Placa Afox 800', 40.00, TRUE),
(2, 'Compresor Industrial', 1200.00, FALSE),
(2, 'Tornillo de banco', 150.00, FALSE),
(3, 'Equipo de Soldadura', 600.00, FALSE),
(3, 'Mascarilla Protectora', 20.00, TRUE),
(4, 'Martillo Neumático', 450.00, FALSE),
(5, 'Camión de Carga', 25000.00, FALSE),
(5, 'Motocicleta', 1500.00, FALSE);


INSERT INTO proveedores_vinculados_recurso (idrecurso, idproveedor)
VALUES 
(1, 1),
(2, 1), 
(3, 2),
(4, 3),
(5, 2),
(6, 3),
(7, 2),
(8, 1),
(9, 2),
(10, 3);

INSERT INTO detalle_recurso (idrecurso, stock_total, en_uso, en_reparacion, fuera_de_uso, idestado)
VALUES 
(4, 40, 10, 0, 3, 1),  -- Taladro
(5, 50, 5, 0, 0, 1),   -- Destornillador
(2, 100, 20, 0, 0, 1), -- Casco de Seguridad
(1, 30, 5, 2, 0, 1),   -- Taladro
(3, 200, 50, 0, 10, 1);-- Cemento


-- INSERT INTO recursos_vinculados_tarea (idrecurso, idtarea, cantidad)
-- VALUES 
-- (4, 1, 1),
-- (5, 1, 1);  -- Taladro vinculado a la tarea 1

-- INSERT INTO activos_vinculados_tarea (idactivo, idtarea)
-- VALUES 
-- (1, 2),  -- Activo 1 vinculado a la tarea 1
-- (2, 1);  -- Activo 2 vinculado a la tarea 1



-- INSERT INTO responsables_asignados_odt (idorden_trabajo, idresponsable)
-- VALUES 
-- ()


-- AQUI EMPIEZA LAS INSERCIONES PARA HACER LA ORDEN DE TRABAJO

INSERT INTO tipo_diagnosticos (tipo_diagnostico) VALUES ('entrada'), ('salida');

-- INSERT INTO odt (idtarea, creado_por) VALUES (2, 4); -- POR DEFECTO TRAERA EL ESTADO 'EN PROCESO' -- NECESARIO

-- INSERT INTO diagnosticos (idorden_trabajo, idtipo_diagnostico, diagnostico) values (1, 1, 'laptop levenmente dañada por las lluvias');
-- INSERT INTO evidencias_diagnostico (iddiagnostico, evidencia) values (1, 'yo.jpg');
-- DELETE FROM plandetareas where idplantarea = 1;
-- select * from plandetareas;
-- INSERT INTO responsables_asignados_odt (idorden_trabajo, idresponsable) values  -- NECESARIO
	-- (1, 4),
    -- (1, 5);
    
-- INSERT INTO historial_estado_odt (idorden_trabajo, estado_nuevo, comentario) values (1, 2, 'esto apenas sea mediodia');

-- AQUI TERMINA

-- AQUI EMPIEZA LAS INSERCIONES PARA HACER LOS DETALLES DE UNA ORDEN DE TRABAJO CAUNO SE EJECUTEN 
-- ME QUEDE ACA.