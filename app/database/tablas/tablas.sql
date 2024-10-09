DROP DATABASE IF exists `SIGEMAPRE`;
CREATE DATABASE SIGEMAPRE;
USE SIGEMAPRE;

CREATE TABLE tipo_doc
(
  idtipodoc   int auto_increment primary key,
  tipodoc     varchar(50) not null
)ENGINE=INNODB;


CREATE TABLE personas
(
	idpersona     int auto_increment  primary key,
	idtipodoc     int                 not null,
	num_doc       varchar(50)         not null,
	apellidos     varchar(100)        not null,
	nombres	      varchar(100)        not null,
	genero        char(1)             not null,
	telefono      char(9)		      not null,
	nacionalidad  varchar(50)         not null,
	constraint    uk_telefono         UNIQUE(telefono),
	constraint    uk_num_doc          UNIQUE(num_doc),
	constraint    fk_idtipodoc        foreign key (idtipodoc) references TIPO_DOC (idtipodoc),
	constraint    chk_genero          CHECK(genero IN('M', 'F'))
)ENGINE=INNODB;


CREATE TABLE roles
(
  idrol		int auto_increment primary key,
  rol 		varchar(20)	not null,
  CONSTRAINT uk_rol UNIQUE(rol)
)ENGINE=INNODB;

CREATE TABLE permisos
(
	idpermiso 	INT AUTO_INCREMENT PRIMARY KEY,
    idrol		INT NOT NULL,
    permiso  	JSON NOT NULL,
    CONSTRAINT fk_idrol FOREIGN KEY(idrol) REFERENCES roles(idrol)
)ENGINE=INNODB;


CREATE TABLE usuarios
(
  idusuario		int auto_increment primary key,
  idpersona	  	int not null,
  idrol		    int not null,
  usuario     	varchar(120) not null,
  contrasena 	varchar(120) not null,
  estado	  	bool default 1,
  CONSTRAINT fk_persona FOREIGN KEY (idpersona) REFERENCES PERSONAS(idpersona),
  CONSTRAINT fk_rol FOREIGN KEY (idrol) REFERENCES roles (idrol),
  CONSTRAINT uk_idpersonaUser UNIQUE(idpersona,usuario)
)ENGINE=INNODB;

CREATE TABLE categorias
(
	idcategoria		INT AUTO_INCREMENT PRIMARY KEY,
    categoria		VARCHAR(60) NOT NULL,	-- UK
    CONSTRAINT uk_categoria UNIQUE(categoria)
)ENGINE=INNODB;

CREATE TABLE subcategorias
(
	idsubcategoria	INT AUTO_INCREMENT PRIMARY KEY,
    idcategoria		INT NOT NULL,
    subcategoria	VARCHAR(60) NOT NULL,	-- UK
    CONSTRAINT uk_subcategoria UNIQUE(subcategoria),
    CONSTRAINT fk_categoria FOREIGN KEY (idcategoria) REFERENCES categorias (idcategoria) ON DELETE CASCADE
)ENGINE=INNODB;

CREATE TABLE marcas
(
	idmarca		INT AUTO_INCREMENT PRIMARY KEY,
    marca		VARCHAR(80) NOT NULL, 	-- UK
    CONSTRAINT uk_marca UNIQUE(marca)
)ENGINE=INNODB;

-- ROYER TABLAS ******************************

CREATE TABLE tipo_estados
(
	idtipo_estado	int	auto_increment primary key,
    tipo_estado		varchar(30)
)ENGINE=INNODB;

CREATE TABLE estados
(
	idestado		int	auto_increment primary key,
    idtipo_estado	int	not null,
    estado			varchar(30),
	constraint fkidtipo_estado	foreign key (idtipo_estado) references tipo_estados (idtipo_estado)
)ENGINE=INNODB;



CREATE TABLE activos
(
	idactivo			INT AUTO_INCREMENT PRIMARY KEY,
    idsubcategoria		INT 		NOT NULL,
    idmarca				INT 		NOT NULL,
    modelo				VARCHAR(60) NULL,
    cod_identificacion	CHAR(40) 	NOT NULL,
    fecha_adquisicion	DATE 		NOT NULL,
    descripcion			VARCHAR(200) NOT NULL,
    especificaciones	JSON 		NOT NULL,
    idestado			int			not null,	
    CONSTRAINT fkidsubcategoria FOREIGN KEY (idsubcategoria) REFERENCES subcategorias(idsubcategoria),
    CONSTRAINT fkidmarca	 FOREIGN KEY (idmarca)	REFERENCES marcas(idmarca),
    CONSTRAINT fkidestado6	 foreign key (idestado) references estados (idestado)
    -- CONSTRAINT chkfecha_ad	 CHECK (fecha_aquisicion>=NOW())
)ENGINE=INNODB;

CREATE TABLE plandetareas
(
	idplantarea		int			auto_increment primary key,
    descripcion		varchar(30)	not null,
    idcategoria		int			not null,
    create_at		datetime	not null default now(),
    update_at		datetime	null,
	borrador		boolean     null,
    CONSTRAINT fk_idcateogoria_plan foreign key (idcategoria) references categorias (idcategoria) ON DELETE CASCADE,
    CONSTRAINT uk_descripcion_plan UNIQUE(descripcion)
)ENGINE=INNODB; -- CHECK

CREATE TABLE tipo_prioridades
(
	idtipo_prioridad	int	auto_increment primary key,
    tipo_prioridad		varchar(10)	not null
)ENGINE=INNODB;

CREATE TABLE tareas
(
	idtarea				int	 			auto_increment 				primary key,
    idplantarea			int				not null,
    idtipo_prioridad	int 			not null,
    descripcion			varchar(200)	not null,
    tiempo_estimado		time			not null,
    fecha_inicio		datetime		not null,
    fecha_vencimiento	datetime		not null,
    cant_intervalo		int				not null,
    frecuencia			varchar(10)		not null,
    idestado			int				not null,
    create_at			datetime		not null default now(),
    update_at			datetime		null,
    CONSTRAINT	fk_idplantarea		foreign key (idplantarea) 		REFERENCES plandetareas (idplantarea) ON DELETE CASCADE,
    CONSTRAINT	fk_idtipo_prioridad	foreign key (idtipo_prioridad) 	REFERENCES tipo_prioridades (idtipo_prioridad),
    CONSTRAINT	fk_idestado2		foreign key (idestado)			REFERENCES estados (idestado),
    CONSTRAINT	fk_descripcion_tarea 		unique(descripcion)
)ENGINE=INNODB;

CREATE TABLE odt
(
	idorden_trabajo		int		auto_increment		primary key,
    idtarea				int	 	not null,
    creado_por			int		not null,
    idestado			int		not null default 2,
    borrador 			boolean null default true,
    CONSTRAINT 			fk_idtarea2					FOREIGN KEY (idtarea)					REFERENCES tareas 	(idtarea),
    CONSTRAINT			fk_creado_por				foreign key (creado_por) 				REFERENCES usuarios	(idusuario),
    CONSTRAINT			fk_idestado3				FOREIGN KEY	(idestado)					REFERENCES estados	(idestado)
)ENGINE=INNODB;	

CREATE TABLE tipo_diagnosticos
(
	idtipo_diagnostico		int auto_increment primary key,
    tipo_diagnostico		varchar(30)			not null
)ENGINE=INNODB;

CREATE TABLE diagnosticos
(
	iddiagnostico		int	auto_increment primary key,
    idorden_trabajo		int	not null,
	idtipo_diagnostico	int	not null,
    diagnostico			varchar(300)	not null,
    CONSTRAINT			fk_idorden_trabajo3		foreign key (idorden_trabajo)	references odt (idorden_trabajo) ON DELETE CASCADE,
    CONSTRAINT			fk_idtipo_diagnostico	foreign key (idtipo_diagnostico) references tipo_diagnosticos (idtipo_diagnostico)
)ENGINE=INNODB;

CREATE TABLE evidencias_diagnostico
(
	idevidencias_diagnostico	int	auto_increment primary key,
    iddiagnostico				int not null,
    evidencia					varchar(100)	not null,
	CONSTRAINT 					fk_iddiagnostico	foreign key (iddiagnostico) references diagnosticos (iddiagnostico) ON DELETE CASCADE
)ENGINE=INNODB;	


CREATE TABLE responsables_asignados
(
	idresponsable_asignado			int								auto_increment 			primary key,
	idorden_trabajo					int not null,
    idresponsable					int	not null,
	CONSTRAINT 	fk_idodt			foreign key (idorden_trabajo)	REFERENCES odt 			(idorden_trabajo) ON DELETE CASCADE,
    CONSTRAINT	fk_idresponsable	foreign key (idresponsable) 	REFERENCES usuarios 	(idusuario)
)ENGINE=INNODB;

CREATE TABLE historial_mantenimiento
(
	idhistorial_mant	int	auto_increment primary key,
    idorden_trabajo		int	not null,
    CONSTRAINT			fkidorden_trabajo	FOREIGN KEY (idorden_trabajo)	REFERENCES odt (idorden_trabajo) ON DELETE CASCADE
)ENGINE=INNODB; 

CREATE TABLE proveedores
(
	idproveedor			int				auto_increment primary key,
    nombre				varchar(80)		not null,
    telefono			char(9)			not null
)ENGINE=INNODB;


CREATE TABLE recursos
(
	idrecurso			int				auto_increment	primary key,
    idcategoria			int				not null,
    nombre				varchar(80)		not null,
    costo				decimal(7,2)	not null,
    descartable			boolean			not null,
    create_at			datetime		not null		default now(),
    update_at			datetime		null,
    CONSTRAINT			fk_idcategoria_recurso2 foreign key (idcategoria) references categorias (idcategoria) ON DELETE CASCADE
)ENGINE=INNODB;


CREATE TABLE proveedores_vinculados_recurso
(
	idproveedor_vinculado		int					auto_increment primary key,
    idrecurso					int					not null,
    idproveedor					int					not null,
    CONSTRAINT 					fk_idrecurso_pvr 	foreign key (idrecurso) 	references recursos (idrecurso),
    CONSTRAINT					fk_idproveedor_pvr	foreign key (idproveedor) 	references proveedores (idproveedor)
)ENGINE=INNODB;


CREATE TABLE recursos_vinculados_tarea
(
	idrecurso_vinculado	int				auto_increment	primary key,
    idrecurso			int				not null,
    idtarea				int				not null,
    cantidad			smallint		not null,
    create_at			datetime		not null default now(),
    update_at			datetime		null,
    CONSTRAINT			fk_idrecursos	FOREIGN KEY (idrecurso) REFERENCES 	recursos 	(idrecurso),
    CONSTRAINT			fk_idtarea3		FOREIGN KEY (idtarea)	REFERENCES	tareas		(idtarea) ON DELETE CASCADE
)ENGINE=INNODB;

CREATE TABLE activos_vinculados_tarea
(
	idactivo_vinculado	int			auto_increment primary key,
    idtarea				int 		not null,
    idactivo			int 		not null,
    create_at			datetime	not null default now(),
    update_at			datetime	null,
    CONSTRAINT fk_idtarea5		foreign key (idtarea) references tareas (idtarea) ON DELETE CASCADE,
    CONSTRAINT fk_idactivo3		FOREIGN KEY (idactivo) REFERENCES activos (idactivo) 
)ENGINE=INNODB;

-- ALTER TABLE activos_vinculados ADD `idtarea` INT NOT NULL AFTER `idplantarea`;

CREATE TABLE detalle_recurso
(
	iddetalle_recurso	int			auto_increment 		primary key,
    idrecurso			int			not null,
    stock_total			int			not null,
    en_uso				int			not null, 
    en_reparacion		int 		not null,
    fuera_de_uso		int			not null,
    create_at			datetime 	not null default now(),
    update_at			datetime	null,
    idestado			int			not null,
    CONSTRAINT	fk_idrecurso3	foreign key (idrecurso) references recursos (idrecurso),
    CONSTRAINT	fk_idestado4	foreign key (idestado) 	references estados 	(idestado)
)ENGINE=INNODB;

CREATE TABLE detalle_odt
(
	iddetalleodt		int 		auto_increment 		primary key,
    idorden_trabajo		int			not null,
    fecha_inicial		datetime	not null default now(),
    fecha_final 		datetime	null,
    tiempo_ejecucion	time		null,
    clasificacion		int			null,
	CONSTRAINT			fk_orden_trabajo2	foreign key (idorden_trabajo) references odt (idorden_trabajo) ON DELETE CASCADE,
    CONSTRAINT			fk_clasificacion	foreign key (clasificacion) references estados (idestado)
)ENGINE=INNODB;

CREATE TABLE historial_estado_odt
(
	idhistorial			int			auto_increment		primary key,
    idorden_trabajo		int			not null,
    estado_anterior		int			null,
    estado_nuevo		int			not null,
    comentario			text 		null,
    fecha_cambio		datetime	null default now(),
    devuelto			boolean		null,
    CONSTRAINT 			fk_idorden_trabajo	foreign key (idorden_trabajo) references odt (idorden_trabajo) ON DELETE CASCADE,
    CONSTRAINT 			fk_idestado5		foreign key (estado_anterior) references estados (idestado),
    CONSTRAINT 			fk_idestado6		foreign key (estado_nuevo) references estados (idestado)
)ENGINE=INNODB;