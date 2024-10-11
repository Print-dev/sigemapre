/*
SQLyog Ultimate v12.5.1 (64 bit)
MySQL - 10.4.32-MariaDB : Database - sigemapre
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`sigemapre` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;

USE `sigemapre`;

/*Table structure for table `activos` */

DROP TABLE IF EXISTS `activos`;

CREATE TABLE `activos` (
  `idactivo` int(11) NOT NULL AUTO_INCREMENT,
  `idcategoria` int(11) NOT NULL,
  `idmarca` int(11) NOT NULL,
  `modelo` varchar(60) DEFAULT NULL,
  `cod_identificacion` char(40) NOT NULL,
  `fecha_adquisicion` date NOT NULL,
  `descripcion` varchar(200) NOT NULL,
  `especificaciones` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`especificaciones`)),
  `idestado` int(11) NOT NULL,
  PRIMARY KEY (`idactivo`),
  KEY `fkidcategoria_act` (`idcategoria`),
  KEY `fkidmarca` (`idmarca`),
  KEY `fkidestado6` (`idestado`),
  CONSTRAINT `fkidcategoria_act` FOREIGN KEY (`idcategoria`) REFERENCES `categorias` (`idcategoria`),
  CONSTRAINT `fkidestado6` FOREIGN KEY (`idestado`) REFERENCES `estados` (`idestado`),
  CONSTRAINT `fkidmarca` FOREIGN KEY (`idmarca`) REFERENCES `marcas` (`idmarca`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `activos` */

insert  into `activos`(`idactivo`,`idcategoria`,`idmarca`,`modelo`,`cod_identificacion`,`fecha_adquisicion`,`descripcion`,`especificaciones`,`idestado`) values 
(1,1,1,'Monitor 4K','MON123','2024-10-11','Monitor LG de 27 pulgadas','{\"resolucion\":\"3840x2160\"}',5),
(2,2,2,'Teclado Mecánico','TEC123','2024-10-11','Teclado mecánico HP','{\"tipo\":\"mecánico\", \"conectividad\":\"inalámbrico\"}',5),
(3,3,4,'Compresor Industrial','COMP123','2024-10-11','Compresor Caterpillar de 10HP','{\"potencia\":\"10HP\"}',2),
(4,4,5,'Camión de Carga Hyundai','CAM123','2024-10-11','Camión de carga pesada Hyundai','{\"capacidad\":\"10 toneladas\"}',2),
(5,1,2,'L3110','IMP123','2024-10-11','Impresora HP L3110','{\"capacidad\":\"200 kilogramos\"}',5);

/*Table structure for table `activos_vinculados_tarea` */

DROP TABLE IF EXISTS `activos_vinculados_tarea`;

CREATE TABLE `activos_vinculados_tarea` (
  `idactivo_vinculado` int(11) NOT NULL AUTO_INCREMENT,
  `idtarea` int(11) NOT NULL,
  `idactivo` int(11) NOT NULL,
  `create_at` datetime NOT NULL DEFAULT current_timestamp(),
  `update_at` datetime DEFAULT NULL,
  PRIMARY KEY (`idactivo_vinculado`),
  KEY `fk_idtarea5` (`idtarea`),
  KEY `fk_idactivo3` (`idactivo`),
  CONSTRAINT `fk_idactivo3` FOREIGN KEY (`idactivo`) REFERENCES `activos` (`idactivo`),
  CONSTRAINT `fk_idtarea5` FOREIGN KEY (`idtarea`) REFERENCES `tareas` (`idtarea`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `activos_vinculados_tarea` */

insert  into `activos_vinculados_tarea`(`idactivo_vinculado`,`idtarea`,`idactivo`,`create_at`,`update_at`) values 
(1,1,5,'2024-10-11 13:38:27',NULL);

/*Table structure for table `categorias` */

DROP TABLE IF EXISTS `categorias`;

CREATE TABLE `categorias` (
  `idcategoria` int(11) NOT NULL AUTO_INCREMENT,
  `categoria` varchar(60) NOT NULL,
  PRIMARY KEY (`idcategoria`),
  UNIQUE KEY `uk_categoria` (`categoria`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `categorias` */

insert  into `categorias`(`idcategoria`,`categoria`) values 
(1,'Electrónica'),
(2,'Herramientas Manuales'),
(4,'Maquinaria Pesada'),
(5,'Transporte'),
(3,'Vehículos de Reparto');

/*Table structure for table `detalle_odt` */

DROP TABLE IF EXISTS `detalle_odt`;

CREATE TABLE `detalle_odt` (
  `iddetalleodt` int(11) NOT NULL AUTO_INCREMENT,
  `idorden_trabajo` int(11) NOT NULL,
  `fecha_inicial` datetime NOT NULL DEFAULT current_timestamp(),
  `fecha_final` datetime DEFAULT NULL,
  `tiempo_ejecucion` time DEFAULT NULL,
  `clasificacion` int(11) DEFAULT NULL,
  PRIMARY KEY (`iddetalleodt`),
  KEY `fk_orden_trabajo2` (`idorden_trabajo`),
  KEY `fk_clasificacion` (`clasificacion`),
  CONSTRAINT `fk_clasificacion` FOREIGN KEY (`clasificacion`) REFERENCES `estados` (`idestado`),
  CONSTRAINT `fk_orden_trabajo2` FOREIGN KEY (`idorden_trabajo`) REFERENCES `odt` (`idorden_trabajo`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `detalle_odt` */

/*Table structure for table `detalle_recurso` */

DROP TABLE IF EXISTS `detalle_recurso`;

CREATE TABLE `detalle_recurso` (
  `iddetalle_recurso` int(11) NOT NULL AUTO_INCREMENT,
  `idrecurso` int(11) NOT NULL,
  `stock_total` int(11) NOT NULL,
  `en_uso` int(11) NOT NULL,
  `en_reparacion` int(11) NOT NULL,
  `fuera_de_uso` int(11) NOT NULL,
  `create_at` datetime NOT NULL DEFAULT current_timestamp(),
  `update_at` datetime DEFAULT NULL,
  `idestado` int(11) NOT NULL,
  PRIMARY KEY (`iddetalle_recurso`),
  KEY `fk_idrecurso3` (`idrecurso`),
  KEY `fk_idestado4` (`idestado`),
  CONSTRAINT `fk_idestado4` FOREIGN KEY (`idestado`) REFERENCES `estados` (`idestado`),
  CONSTRAINT `fk_idrecurso3` FOREIGN KEY (`idrecurso`) REFERENCES `recursos` (`idrecurso`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `detalle_recurso` */

insert  into `detalle_recurso`(`iddetalle_recurso`,`idrecurso`,`stock_total`,`en_uso`,`en_reparacion`,`fuera_de_uso`,`create_at`,`update_at`,`idestado`) values 
(1,4,40,10,0,3,'2024-10-11 13:38:27',NULL,1),
(2,5,50,5,0,0,'2024-10-11 13:38:27',NULL,1),
(3,2,100,20,0,0,'2024-10-11 13:38:27',NULL,1),
(4,1,30,5,2,0,'2024-10-11 13:38:27',NULL,1),
(5,3,200,50,0,10,'2024-10-11 13:38:27',NULL,1);

/*Table structure for table `diagnosticos` */

DROP TABLE IF EXISTS `diagnosticos`;

CREATE TABLE `diagnosticos` (
  `iddiagnostico` int(11) NOT NULL AUTO_INCREMENT,
  `idorden_trabajo` int(11) NOT NULL,
  `idtipo_diagnostico` int(11) NOT NULL,
  `diagnostico` varchar(300) NOT NULL,
  PRIMARY KEY (`iddiagnostico`),
  KEY `fk_idorden_trabajo3` (`idorden_trabajo`),
  KEY `fk_idtipo_diagnostico` (`idtipo_diagnostico`),
  CONSTRAINT `fk_idorden_trabajo3` FOREIGN KEY (`idorden_trabajo`) REFERENCES `odt` (`idorden_trabajo`) ON DELETE CASCADE,
  CONSTRAINT `fk_idtipo_diagnostico` FOREIGN KEY (`idtipo_diagnostico`) REFERENCES `tipo_diagnosticos` (`idtipo_diagnostico`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `diagnosticos` */

/*Table structure for table `estados` */

DROP TABLE IF EXISTS `estados`;

CREATE TABLE `estados` (
  `idestado` int(11) NOT NULL AUTO_INCREMENT,
  `estado` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`idestado`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `estados` */

insert  into `estados`(`idestado`,`estado`) values 
(1,'pendiente'),
(2,'proceso'),
(3,'revision'),
(4,'finalizado'),
(5,'activo'),
(6,'en mantenimiento'),
(7,'baja'),
(8,'en uso'),
(9,'en proceso'),
(10,'aprobado'),
(11,'rechazado'),
(12,'asignado'),
(13,'no asignado'),
(14,'disponible'),
(15,'agotado'),
(16,'sin tomar'),
(17,'vencido'),
(18,'exitoso'),
(19,'atrasado'),
(20,'disponible'),
(21,'ocupado');

/*Table structure for table `evidencias_diagnostico` */

DROP TABLE IF EXISTS `evidencias_diagnostico`;

CREATE TABLE `evidencias_diagnostico` (
  `idevidencias_diagnostico` int(11) NOT NULL AUTO_INCREMENT,
  `iddiagnostico` int(11) NOT NULL,
  `evidencia` varchar(100) NOT NULL,
  PRIMARY KEY (`idevidencias_diagnostico`),
  KEY `fk_iddiagnostico` (`iddiagnostico`),
  CONSTRAINT `fk_iddiagnostico` FOREIGN KEY (`iddiagnostico`) REFERENCES `diagnosticos` (`iddiagnostico`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `evidencias_diagnostico` */

/*Table structure for table `historial_estado_odt` */

DROP TABLE IF EXISTS `historial_estado_odt`;

CREATE TABLE `historial_estado_odt` (
  `idhistorial` int(11) NOT NULL AUTO_INCREMENT,
  `idorden_trabajo` int(11) NOT NULL,
  `estado_anterior` int(11) DEFAULT NULL,
  `estado_nuevo` int(11) NOT NULL,
  `comentario` text DEFAULT NULL,
  `fecha_cambio` datetime DEFAULT current_timestamp(),
  `devuelto` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`idhistorial`),
  KEY `fk_idorden_trabajo` (`idorden_trabajo`),
  KEY `fk_idestado5` (`estado_anterior`),
  KEY `fk_idestado6` (`estado_nuevo`),
  CONSTRAINT `fk_idestado5` FOREIGN KEY (`estado_anterior`) REFERENCES `estados` (`idestado`),
  CONSTRAINT `fk_idestado6` FOREIGN KEY (`estado_nuevo`) REFERENCES `estados` (`idestado`),
  CONSTRAINT `fk_idorden_trabajo` FOREIGN KEY (`idorden_trabajo`) REFERENCES `odt` (`idorden_trabajo`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `historial_estado_odt` */

/*Table structure for table `marcas` */

DROP TABLE IF EXISTS `marcas`;

CREATE TABLE `marcas` (
  `idmarca` int(11) NOT NULL AUTO_INCREMENT,
  `marca` varchar(80) NOT NULL,
  PRIMARY KEY (`idmarca`),
  UNIQUE KEY `uk_marca` (`marca`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `marcas` */

insert  into `marcas`(`idmarca`,`marca`) values 
(8,'ABB'),
(4,'Caterpillar'),
(5,'Einhell'),
(7,'FenWick'),
(2,'HP'),
(6,'Hyundai'),
(1,'LG'),
(3,'Nissan');

/*Table structure for table `odt` */

DROP TABLE IF EXISTS `odt`;

CREATE TABLE `odt` (
  `idorden_trabajo` int(11) NOT NULL AUTO_INCREMENT,
  `idtarea` int(11) NOT NULL,
  `creado_por` int(11) NOT NULL,
  `idestado` int(11) NOT NULL DEFAULT 2,
  `borrador` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`idorden_trabajo`),
  KEY `fk_idtarea2` (`idtarea`),
  KEY `fk_creado_por` (`creado_por`),
  KEY `fk_idestado3` (`idestado`),
  CONSTRAINT `fk_creado_por` FOREIGN KEY (`creado_por`) REFERENCES `usuarios` (`idusuario`),
  CONSTRAINT `fk_idestado3` FOREIGN KEY (`idestado`) REFERENCES `estados` (`idestado`),
  CONSTRAINT `fk_idtarea2` FOREIGN KEY (`idtarea`) REFERENCES `tareas` (`idtarea`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `odt` */

/*Table structure for table `permisos` */

DROP TABLE IF EXISTS `permisos`;

CREATE TABLE `permisos` (
  `idpermiso` int(11) NOT NULL AUTO_INCREMENT,
  `idrol` int(11) NOT NULL,
  `permiso` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`permiso`)),
  PRIMARY KEY (`idpermiso`),
  KEY `fk_idrol` (`idrol`),
  CONSTRAINT `fk_idrol` FOREIGN KEY (`idrol`) REFERENCES `roles` (`idrol`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `permisos` */

insert  into `permisos`(`idpermiso`,`idrol`,`permiso`) values 
(1,2,'{\"activos\":{\"asignarActivo\":{\"read\":true,\"create\":true,\"update\":false,\"delete\":false}},\"ODT\":{\"read\":true,\"create\":true,\"update\":false,\"delete\":false},\"planTarea\":{\"read\":true,\"create\":false,\"update\":false,\"delete\":false},\"bajaActivo\":{\"read\":true,\"create\":true,\"update\":false,\"delete\":false},\"usuarios\":{\"ListaUsuario\":{\"read\":false,\"create\":false,\"update\":false,\"delete\":false},\"PermisoRol\":{\"read\":false,\"create\":false,\"update\":false,\"delete\":false}}}'),
(2,1,'{\"activos\":{\"asignarActivo\":{\"read\":true,\"create\":true,\"update\":true,\"delete\":true}},\"ODT\":{\"read\":true,\"create\":true,\"update\":true,\"delete\":false},\"PlanTarea\":{\"read\":true,\"create\":true,\"update\":false,\"delete\":false},\"BajaActivo\":{\"read\":true,\"create\":true,\"update\":true,\"delete\":false},\"usuarios\":{\"ListaUsuario\":{\"read\":true,\"create\": true,\"update\":true,\"delete\":true},\"PermisoRol\":{ \"read\":true,\"create\": true, \"update\":true, \"delete\":true}}}');

/*Table structure for table `personas` */

DROP TABLE IF EXISTS `personas`;

CREATE TABLE `personas` (
  `idpersona` int(11) NOT NULL AUTO_INCREMENT,
  `idtipodoc` int(11) NOT NULL,
  `num_doc` varchar(50) NOT NULL,
  `apellidos` varchar(100) NOT NULL,
  `nombres` varchar(100) NOT NULL,
  `genero` char(1) NOT NULL,
  `telefono` char(9) NOT NULL,
  `nacionalidad` varchar(50) NOT NULL,
  PRIMARY KEY (`idpersona`),
  UNIQUE KEY `uk_telefono` (`telefono`),
  UNIQUE KEY `uk_num_doc` (`num_doc`),
  KEY `fk_idtipodoc` (`idtipodoc`),
  CONSTRAINT `fk_idtipodoc` FOREIGN KEY (`idtipodoc`) REFERENCES `tipo_doc` (`idtipodoc`),
  CONSTRAINT `chk_genero` CHECK (`genero` in ('M','F'))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `personas` */

insert  into `personas`(`idpersona`,`idtipodoc`,`num_doc`,`apellidos`,`nombres`,`genero`,`telefono`,`nacionalidad`) values 
(1,1,'12345678','González','Juan','M','987654321','Peruano'),
(2,2,'A1234567','Smith','Anna','F','987654322','Chilena'),
(3,2,'EX123456','Martínez','Carlos','M','987654323','Colombiano'),
(4,1,'72754752','Avalos Romero','Royer Alexis','M','936439633','Peruano'),
(5,1,'72754751','Avalos Romero','Pedro Aldair','M','995213305','Peruano');

/*Table structure for table `plandetareas` */

DROP TABLE IF EXISTS `plandetareas`;

CREATE TABLE `plandetareas` (
  `idplantarea` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(30) NOT NULL,
  `create_at` datetime NOT NULL DEFAULT current_timestamp(),
  `update_at` datetime DEFAULT NULL,
  `borrador` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`idplantarea`),
  UNIQUE KEY `uk_descripcion_plan` (`descripcion`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `plandetareas` */

insert  into `plandetareas`(`idplantarea`,`descripcion`,`create_at`,`update_at`,`borrador`) values 
(1,'mantenimiento de impresora','2024-10-11 13:38:27',NULL,NULL);

/*Table structure for table `proveedores` */

DROP TABLE IF EXISTS `proveedores`;

CREATE TABLE `proveedores` (
  `idproveedor` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(80) NOT NULL,
  `telefono` char(9) NOT NULL,
  PRIMARY KEY (`idproveedor`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `proveedores` */

insert  into `proveedores`(`idproveedor`,`nombre`,`telefono`) values 
(1,'Proveedor 1','123456789'),
(2,'Proveedor 2','987654321'),
(3,'Proveedor 3','112233445');

/*Table structure for table `proveedores_vinculados_recurso` */

DROP TABLE IF EXISTS `proveedores_vinculados_recurso`;

CREATE TABLE `proveedores_vinculados_recurso` (
  `idproveedor_vinculado` int(11) NOT NULL AUTO_INCREMENT,
  `idrecurso` int(11) NOT NULL,
  `idproveedor` int(11) NOT NULL,
  PRIMARY KEY (`idproveedor_vinculado`),
  KEY `fk_idrecurso_pvr` (`idrecurso`),
  KEY `fk_idproveedor_pvr` (`idproveedor`),
  CONSTRAINT `fk_idproveedor_pvr` FOREIGN KEY (`idproveedor`) REFERENCES `proveedores` (`idproveedor`),
  CONSTRAINT `fk_idrecurso_pvr` FOREIGN KEY (`idrecurso`) REFERENCES `recursos` (`idrecurso`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `proveedores_vinculados_recurso` */

insert  into `proveedores_vinculados_recurso`(`idproveedor_vinculado`,`idrecurso`,`idproveedor`) values 
(1,1,1),
(2,2,1),
(3,3,2),
(4,4,3),
(5,5,2),
(6,6,3),
(7,7,2),
(8,8,1),
(9,9,2),
(10,10,3);

/*Table structure for table `recursos` */

DROP TABLE IF EXISTS `recursos`;

CREATE TABLE `recursos` (
  `idrecurso` int(11) NOT NULL AUTO_INCREMENT,
  `idcategoria` int(11) NOT NULL,
  `nombre` varchar(80) NOT NULL,
  `costo` decimal(7,2) NOT NULL,
  `descartable` tinyint(1) NOT NULL,
  `create_at` datetime NOT NULL DEFAULT current_timestamp(),
  `update_at` datetime DEFAULT NULL,
  PRIMARY KEY (`idrecurso`),
  KEY `fk_idcategoria_recurso2` (`idcategoria`),
  CONSTRAINT `fk_idcategoria_recurso2` FOREIGN KEY (`idcategoria`) REFERENCES `categorias` (`idcategoria`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `recursos` */

insert  into `recursos`(`idrecurso`,`idcategoria`,`nombre`,`costo`,`descartable`,`create_at`,`update_at`) values 
(1,1,'Cable poder',350.00,0,'2024-10-11 13:38:27',NULL),
(2,1,'Caja de tinta',80.00,1,'2024-10-11 13:38:27',NULL),
(3,1,'Placa Afox 800',40.00,1,'2024-10-11 13:38:27',NULL),
(4,2,'Compresor Industrial',1200.00,0,'2024-10-11 13:38:27',NULL),
(5,2,'Tornillo de banco',150.00,0,'2024-10-11 13:38:27',NULL),
(6,3,'Equipo de Soldadura',600.00,0,'2024-10-11 13:38:27',NULL),
(7,3,'Mascarilla Protectora',20.00,1,'2024-10-11 13:38:27',NULL),
(8,4,'Martillo Neumático',450.00,0,'2024-10-11 13:38:27',NULL),
(9,5,'Camión de Carga',25000.00,0,'2024-10-11 13:38:27',NULL),
(10,5,'Motocicleta',1500.00,0,'2024-10-11 13:38:27',NULL);

/*Table structure for table `recursos_vinculados_tarea` */

DROP TABLE IF EXISTS `recursos_vinculados_tarea`;

CREATE TABLE `recursos_vinculados_tarea` (
  `idrecurso_vinculado` int(11) NOT NULL AUTO_INCREMENT,
  `idrecurso` int(11) NOT NULL,
  `idtarea` int(11) NOT NULL,
  `cantidad` smallint(6) NOT NULL,
  `create_at` datetime NOT NULL DEFAULT current_timestamp(),
  `update_at` datetime DEFAULT NULL,
  PRIMARY KEY (`idrecurso_vinculado`),
  KEY `fk_idrecursos` (`idrecurso`),
  KEY `fk_idtarea3` (`idtarea`),
  CONSTRAINT `fk_idrecursos` FOREIGN KEY (`idrecurso`) REFERENCES `recursos` (`idrecurso`),
  CONSTRAINT `fk_idtarea3` FOREIGN KEY (`idtarea`) REFERENCES `tareas` (`idtarea`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `recursos_vinculados_tarea` */

/*Table structure for table `responsables_asignados_odt` */

DROP TABLE IF EXISTS `responsables_asignados_odt`;

CREATE TABLE `responsables_asignados_odt` (
  `idresponsable_asignado` int(11) NOT NULL AUTO_INCREMENT,
  `idorden_trabajo` int(11) NOT NULL,
  `idresponsable` int(11) NOT NULL,
  PRIMARY KEY (`idresponsable_asignado`),
  KEY `fk_idodt` (`idorden_trabajo`),
  KEY `fk_idresponsable` (`idresponsable`),
  CONSTRAINT `fk_idodt` FOREIGN KEY (`idorden_trabajo`) REFERENCES `odt` (`idorden_trabajo`) ON DELETE CASCADE,
  CONSTRAINT `fk_idresponsable` FOREIGN KEY (`idresponsable`) REFERENCES `usuarios` (`idusuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `responsables_asignados_odt` */

/*Table structure for table `roles` */

DROP TABLE IF EXISTS `roles`;

CREATE TABLE `roles` (
  `idrol` int(11) NOT NULL AUTO_INCREMENT,
  `rol` varchar(20) NOT NULL,
  PRIMARY KEY (`idrol`),
  UNIQUE KEY `uk_rol` (`rol`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `roles` */

insert  into `roles`(`idrol`,`rol`) values 
(1,'administrador'),
(2,'usuario');

/*Table structure for table `tareas` */

DROP TABLE IF EXISTS `tareas`;

CREATE TABLE `tareas` (
  `idtarea` int(11) NOT NULL AUTO_INCREMENT,
  `idplantarea` int(11) NOT NULL,
  `idtipo_prioridad` int(11) NOT NULL,
  `descripcion` varchar(200) NOT NULL,
  `fecha_inicio` datetime NOT NULL,
  `fecha_vencimiento` datetime NOT NULL,
  `cant_intervalo` int(11) NOT NULL,
  `frecuencia` varchar(10) NOT NULL,
  `idestado` int(11) NOT NULL,
  `create_at` datetime NOT NULL DEFAULT current_timestamp(),
  `update_at` datetime DEFAULT NULL,
  PRIMARY KEY (`idtarea`),
  UNIQUE KEY `fk_descripcion_tarea` (`descripcion`),
  KEY `fk_idplantarea` (`idplantarea`),
  KEY `fk_idtipo_prioridad` (`idtipo_prioridad`),
  KEY `fk_idestado2` (`idestado`),
  CONSTRAINT `fk_idestado2` FOREIGN KEY (`idestado`) REFERENCES `estados` (`idestado`),
  CONSTRAINT `fk_idplantarea` FOREIGN KEY (`idplantarea`) REFERENCES `plandetareas` (`idplantarea`) ON DELETE CASCADE,
  CONSTRAINT `fk_idtipo_prioridad` FOREIGN KEY (`idtipo_prioridad`) REFERENCES `tipo_prioridades` (`idtipo_prioridad`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `tareas` */

insert  into `tareas`(`idtarea`,`idplantarea`,`idtipo_prioridad`,`descripcion`,`fecha_inicio`,`fecha_vencimiento`,`cant_intervalo`,`frecuencia`,`idestado`,`create_at`,`update_at`) values 
(1,1,3,'llenado de tinta color rojo','0000-00-00 00:00:00','0000-00-00 00:00:00',1,'mensual',1,'2024-10-11 13:38:27',NULL);

/*Table structure for table `tipo_diagnosticos` */

DROP TABLE IF EXISTS `tipo_diagnosticos`;

CREATE TABLE `tipo_diagnosticos` (
  `idtipo_diagnostico` int(11) NOT NULL AUTO_INCREMENT,
  `tipo_diagnostico` varchar(30) NOT NULL,
  PRIMARY KEY (`idtipo_diagnostico`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `tipo_diagnosticos` */

insert  into `tipo_diagnosticos`(`idtipo_diagnostico`,`tipo_diagnostico`) values 
(1,'entrada'),
(2,'salida');

/*Table structure for table `tipo_doc` */

DROP TABLE IF EXISTS `tipo_doc`;

CREATE TABLE `tipo_doc` (
  `idtipodoc` int(11) NOT NULL AUTO_INCREMENT,
  `tipodoc` varchar(50) NOT NULL,
  PRIMARY KEY (`idtipodoc`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `tipo_doc` */

insert  into `tipo_doc`(`idtipodoc`,`tipodoc`) values 
(1,'DNI'),
(2,'Carnet de Extranjería');

/*Table structure for table `tipo_prioridades` */

DROP TABLE IF EXISTS `tipo_prioridades`;

CREATE TABLE `tipo_prioridades` (
  `idtipo_prioridad` int(11) NOT NULL AUTO_INCREMENT,
  `tipo_prioridad` varchar(10) NOT NULL,
  PRIMARY KEY (`idtipo_prioridad`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `tipo_prioridades` */

insert  into `tipo_prioridades`(`idtipo_prioridad`,`tipo_prioridad`) values 
(1,'baja'),
(2,'media'),
(3,'alta'),
(4,'urgente');

/*Table structure for table `usuarios` */

DROP TABLE IF EXISTS `usuarios`;

CREATE TABLE `usuarios` (
  `idusuario` int(11) NOT NULL AUTO_INCREMENT,
  `idpersona` int(11) NOT NULL,
  `idrol` int(11) NOT NULL,
  `usuario` varchar(120) NOT NULL,
  `contrasena` varchar(120) NOT NULL,
  `estado` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`idusuario`),
  UNIQUE KEY `uk_idpersonaUser` (`idpersona`,`usuario`),
  KEY `fk_rol` (`idrol`),
  CONSTRAINT `fk_persona` FOREIGN KEY (`idpersona`) REFERENCES `personas` (`idpersona`),
  CONSTRAINT `fk_rol` FOREIGN KEY (`idrol`) REFERENCES `roles` (`idrol`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `usuarios` */

insert  into `usuarios`(`idusuario`,`idpersona`,`idrol`,`usuario`,`contrasena`,`estado`) values 
(1,1,1,'j.gonzalez','$2y$10$kbJVca650dDJl8p5VeYsp.UPnopaRDH6HApAVTC.fqQp/54uj0Ld2',1),
(2,2,2,'a.smith','$2y$10$gNGni4OBLXh0IacQ/FH3Ou88C18NFstrdJ4K0.kKvkGlhMDC9EWXO',1),
(3,3,2,'c.martinez','contrasena3',1),
(4,4,2,'r.avalos','$2y$10$VrxeMCQteaNdX6LwxoZEYevp8BCwKTpIKTVebChbXcxnNX7BTIFaW',1),
(5,5,1,'p.avalos','$2y$10$j1KccY6Iex7h19WR0pfMpumhp.dsjJkBCcFUbtVwbPCHw7hECJNyW',1);

/* Procedure structure for procedure `actualizarActivoPorTarea` */

/*!50003 DROP PROCEDURE IF EXISTS  `actualizarActivoPorTarea` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizarActivoPorTarea`(
    IN _idactivo_vinculado INT, 
    IN _idactivo INT, 
    IN _idtarea INT)
BEGIN
    UPDATE activos_vinculados_tarea 
    SET idactivo = _idactivo, 
        idtarea = _idtarea, 
        update_at = NOW()
    WHERE idactivo_vinculado = _idactivo_vinculado;
END */$$
DELIMITER ;

/* Procedure structure for procedure `actualizarBorradorOdt` */

/*!50003 DROP PROCEDURE IF EXISTS  `actualizarBorradorOdt` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizarBorradorOdt`(
	IN _idorden_trabajo INT,
	IN _borrador INT
)
BEGIN
	UPDATE odt SET
    borrador = _borrador
    WHERE idorden_trabajo = _idorden_trabajo;
END */$$
DELIMITER ;

/* Procedure structure for procedure `actualizarDetalleRecurso` */

/*!50003 DROP PROCEDURE IF EXISTS  `actualizarDetalleRecurso` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizarDetalleRecurso`(
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
END */$$
DELIMITER ;

/* Procedure structure for procedure `actualizarPlanDeTareas` */

/*!50003 DROP PROCEDURE IF EXISTS  `actualizarPlanDeTareas` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizarPlanDeTareas`(
    IN _idplantarea INT, 
    IN _borrador BOOLEAN)
BEGIN
    UPDATE plandetareas 
    SET borrador = _borrador, 
        update_at = NOW()
    WHERE idplantarea = _idplantarea;
END */$$
DELIMITER ;

/* Procedure structure for procedure `actualizarRecursoPorTarea` */

/*!50003 DROP PROCEDURE IF EXISTS  `actualizarRecursoPorTarea` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizarRecursoPorTarea`(
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
END */$$
DELIMITER ;

/* Procedure structure for procedure `actualizarTarea` */

/*!50003 DROP PROCEDURE IF EXISTS  `actualizarTarea` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizarTarea`(
    IN _idtarea INT,
    IN _idtipo_prioridad INT,
    IN _descripcion VARCHAR(200), 
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
        fecha_inicio = _fecha_inicio,
        fecha_vencimiento = _fecha_vencimiento,
        cant_intervalo = _cant_intervalo, 
        frecuencia = _frecuencia,
        idestado = _idestado, 
        update_at = NOW()
    WHERE idtarea = _idtarea;
    
    SELECT MAX(idtarea) as id FROM tareas;
END */$$
DELIMITER ;

/* Procedure structure for procedure `asignarResponsablesODT` */

/*!50003 DROP PROCEDURE IF EXISTS  `asignarResponsablesODT` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `asignarResponsablesODT`(
	IN _idorden_trabajo INT,
    IN _idresponsable	INT
)
BEGIN
	INSERT INTO responsables_asignados_odt (idorden_trabajo, idresponsable)
		VALUES (_idorden_trabajo, _idresponsable);
END */$$
DELIMITER ;

/* Procedure structure for procedure `eliminarActivosVinculadosTarea` */

/*!50003 DROP PROCEDURE IF EXISTS  `eliminarActivosVinculadosTarea` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminarActivosVinculadosTarea`(IN _idactivovinculado INT)
BEGIN
	DELETE FROM activos_vinculados_tarea WHERE idactivo_vinculado = _idactivovinculado;
END */$$
DELIMITER ;

/* Procedure structure for procedure `eliminarOdt` */

/*!50003 DROP PROCEDURE IF EXISTS  `eliminarOdt` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminarOdt`(IN _idorden_trabajo INT)
BEGIN
	DELETE FROM odt WHERE idorden_trabajo = _idorden_trabajo;
END */$$
DELIMITER ;

/* Procedure structure for procedure `eliminarPlanDeTarea` */

/*!50003 DROP PROCEDURE IF EXISTS  `eliminarPlanDeTarea` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminarPlanDeTarea`(IN _idplantarea INT)
BEGIN
	DELETE FROM plandetareas WHERE idplantarea = _idplantarea;
END */$$
DELIMITER ;

/* Procedure structure for procedure `eliminarRecursosVinculadosTarea` */

/*!50003 DROP PROCEDURE IF EXISTS  `eliminarRecursosVinculadosTarea` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminarRecursosVinculadosTarea`(IN _idrecursovinculado INT)
BEGIN
	DELETE FROM recursos_vinculados_tarea WHERE idrecurso_vinculado = _idrecursovinculado;
END */$$
DELIMITER ;

/* Procedure structure for procedure `eliminarResponsableOdt` */

/*!50003 DROP PROCEDURE IF EXISTS  `eliminarResponsableOdt` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminarResponsableOdt`(
	IN _idresponsable_asignado INT
)
BEGIN
	DELETE FROM responsables_asignados_odt WHERE idresponsable_asignado = _idresponsable_asignado;
END */$$
DELIMITER ;

/* Procedure structure for procedure `eliminarTarea` */

/*!50003 DROP PROCEDURE IF EXISTS  `eliminarTarea` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminarTarea`(IN _idtarea INT)
BEGIN
	DELETE FROM tareas WHERE idtarea = _idtarea;
END */$$
DELIMITER ;

/* Procedure structure for procedure `insertarActivoPorTarea` */

/*!50003 DROP PROCEDURE IF EXISTS  `insertarActivoPorTarea` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `insertarActivoPorTarea`(
    IN _idactivo INT,
    IN _idtarea INT
)
BEGIN
    INSERT INTO activos_vinculados_tarea (idactivo, idtarea)
    VALUES (_idactivo, _idtarea);
    
    SELECT MAX(idactivo_vinculado) as id from activos_vinculados_tarea;
END */$$
DELIMITER ;

/* Procedure structure for procedure `insertarPlanDeTareas` */

/*!50003 DROP PROCEDURE IF EXISTS  `insertarPlanDeTareas` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `insertarPlanDeTareas`(
	IN _descripcion VARCHAR(30),
    IN _borrador BOOLEAN
)
BEGIN
    INSERT INTO plandetareas (descripcion, borrador)
    VALUES (_descripcion, _borrador);
    
    SELECT MAX(idplantarea) as id from plandetareas;
END */$$
DELIMITER ;

/* Procedure structure for procedure `insertarRecursoPorTarea` */

/*!50003 DROP PROCEDURE IF EXISTS  `insertarRecursoPorTarea` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `insertarRecursoPorTarea`(
    IN _idrecurso INT,
    IN _idtarea INT,
    IN _cantidad SMALLINT
)
BEGIN
    INSERT INTO recursos_vinculados_tarea (idrecurso, idtarea, cantidad)
    VALUES (_idrecurso, _idtarea, _cantidad);
    
    SELECT MAX(idrecurso_vinculado) as id FROM recursos_vinculados_tarea;
END */$$
DELIMITER ;

/* Procedure structure for procedure `insertarTarea` */

/*!50003 DROP PROCEDURE IF EXISTS  `insertarTarea` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `insertarTarea`(
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
END */$$
DELIMITER ;

/* Procedure structure for procedure `listarActivosPorTareaYPlan` */

/*!50003 DROP PROCEDURE IF EXISTS  `listarActivosPorTareaYPlan` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `listarActivosPorTareaYPlan`(IN p_idplantarea INT)
BEGIN
  -- Listar todos los activos vinculados a cada tarea del plan de tareas
  SELECT 
	avt.idactivo_vinculado,
    pt.descripcion AS descripcion_plan,
    t.idtarea,
    t.descripcion AS descripcion_tarea,
    a.idactivo,
    a.descripcion
  FROM
    plandetareas pt
    INNER JOIN tareas t ON pt.idplantarea = t.idplantarea
    INNER JOIN activos_vinculados_tarea avt ON t.idtarea = avt.idtarea
    INNER JOIN activos a ON avt.idactivo = a.idactivo
  WHERE
    pt.idplantarea = p_idplantarea;
END */$$
DELIMITER ;

/* Procedure structure for procedure `obtenerActivos` */

/*!50003 DROP PROCEDURE IF EXISTS  `obtenerActivos` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `obtenerActivos`(
	IN _idcategoria	INT
)
BEGIN
	SELECT ACT.idactivo, ACT.descripcion as activo, ACT.cod_identificacion ,CAT.categoria, SUB.subcategoria, MAR.marca, ACT.modelo FROM activos ACT 
    INNER JOIN subcategorias SUB ON SUB.idsubcategoria = ACT.idsubcategoria
    INNER JOIN categorias CAT ON SUB.idcategoria = CAT.idcategoria
    INNER JOIN marcas MAR ON ACT.idmarca = MAR.idmarca
    WHERE CAT.idcategoria = _idcategoria
    ORDER BY ACT.idactivo DESC;
END */$$
DELIMITER ;

/* Procedure structure for procedure `obtenerActivosPorTarea` */

/*!50003 DROP PROCEDURE IF EXISTS  `obtenerActivosPorTarea` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `obtenerActivosPorTarea`(IN _idtarea INT)
BEGIN
	SELECT ACTV.idactivo_vinculado, SCAT.subcategoria, MAR.marca, ACT.modelo FROM activos_vinculados_tarea ACTV
    INNER JOIN activos ACT ON ACTV.idactivo = ACT.idactivo
    INNER JOIN subcategorias SCAT ON ACT.idsubcategoria = SCAT.idsubcategoria
    INNER JOIN marcas MAR ON ACT.idmarca = MAR.idmarca
    WHERE ACTV.idtarea = _idtarea;
END */$$
DELIMITER ;

/* Procedure structure for procedure `obtenerEvidenciasDiagnostico` */

/*!50003 DROP PROCEDURE IF EXISTS  `obtenerEvidenciasDiagnostico` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `obtenerEvidenciasDiagnostico`( 
	IN _iddiagnostico INT
)
BEGIN
	SELECT * FROM evidencias_diagnostico WHERE iddiagnostico = _iddiagnostico;
END */$$
DELIMITER ;

/* Procedure structure for procedure `obtenerPlantareasDetalles` */

/*!50003 DROP PROCEDURE IF EXISTS  `obtenerPlantareasDetalles` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `obtenerPlantareasDetalles`()
BEGIN 
SELECT PT.idplantarea, 
       PT.descripcion, 
       COUNT(DISTINCT TAR.idtarea) AS tareas_totales, 
       COUNT(DISTINCT AV.idactivo_vinculado) AS activos_vinculados, 
       PT.borrador 
FROM plandetareas PT
LEFT JOIN tareas TAR ON TAR.idplantarea = PT.idplantarea
LEFT JOIN activos_vinculados_tarea AV ON AV.idtarea = TAR.idtarea
GROUP BY PT.idplantarea, PT.descripcion, PT.borrador
ORDER BY PT.idplantarea DESC;
END */$$
DELIMITER ;

/* Procedure structure for procedure `obtenerRecursos` */

/*!50003 DROP PROCEDURE IF EXISTS  `obtenerRecursos` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `obtenerRecursos`(
)
BEGIN 
	SELECT 
		RE.idrecurso, RE.nombre as recurso, RE.costo, DR.stock_total
	FROM detalle_recurso DR
	INNER JOIN recursos RE ON DR.idrecurso = RE.idrecurso
	INNER JOIN proveedores_vinculados_recurso PVR ON RE.idrecurso = PVR.idrecurso
    INNER JOIN proveedores PRO ON PVR.idproveedor = PRO.idproveedor
    GROUP BY RE.idrecurso, RE.nombre, RE.costo, DR.stock_total;
END */$$
DELIMITER ;

/* Procedure structure for procedure `obtenerRecursosPorTarea` */

/*!50003 DROP PROCEDURE IF EXISTS  `obtenerRecursosPorTarea` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `obtenerRecursosPorTarea`(IN _idtarea INT)
BEGIN
	select RVT.idrecurso_vinculado ,RVT.idrecurso, RVT.idtarea, RVT.cantidad, RE.nombre, RE.costo from recursos_vinculados_tarea RVT
    INNER JOIN recursos RE ON RVT.idrecurso = RE.idrecurso
    WHERE RVT.idtarea = _idtarea;
END */$$
DELIMITER ;

/* Procedure structure for procedure `obtenerResponsablesPorOdt` */

/*!50003 DROP PROCEDURE IF EXISTS  `obtenerResponsablesPorOdt` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `obtenerResponsablesPorOdt`(
	IN _idorden_trabajo INT
)
BEGIN
	SELECT 
		RA.idresponsable_asignado, RA.idorden_trabajo, RA.idresponsable,
        USU.usuario
		FROM responsables_asignados_odt RA
	INNER JOIN usuarios USU ON USU.idusuario = RA.idresponsable
    WHERE idorden_trabajo = _idorden_trabajo;
END */$$
DELIMITER ;

/* Procedure structure for procedure `obtenerTareaDeOdtGenerada` */

/*!50003 DROP PROCEDURE IF EXISTS  `obtenerTareaDeOdtGenerada` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `obtenerTareaDeOdtGenerada`(
	IN _idodt INT
)
BEGIN 
	SELECT 
		ODT.idorden_trabajo,
        PT.descripcion as plantarea,
		TAR.descripcion as tarea,
        TAR.idtarea as idtarea,
        ACT.descripcion as activo
		from odt ODT
        INNER JOIN tareas TAR ON TAR.idtarea = ODT.idtarea
        INNER JOIN activos_vinculados_tarea AVT ON AVT.idtarea = TAR.idtarea
        INNER JOIN activos ACT ON ACT.idactivo = AVT.idactivo
        INNER JOIN plandetareas PT ON PT.idplantarea = TAR.idplantarea
        INNER JOIN usuarios USU ON USU.idusuario = ODT.creado_por
        INNER JOIN estados EST ON EST.idestado = ODT.idestado
        WHERE ODT.idorden_trabajo = _idodt;
END */$$
DELIMITER ;

/* Procedure structure for procedure `obtenerTareaPorId` */

/*!50003 DROP PROCEDURE IF EXISTS  `obtenerTareaPorId` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `obtenerTareaPorId`(IN _idtarea INT)
BEGIN
	SELECT * FROM tareas WHERE idtarea = _idtarea;
END */$$
DELIMITER ;

/* Procedure structure for procedure `obtenerTareas` */

/*!50003 DROP PROCEDURE IF EXISTS  `obtenerTareas` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `obtenerTareas`()
BEGIN
	SELECT 
		TAR.idtarea,
		PT.descripcion as plantarea,
		TAR.descripcion,
        TAR.fecha_inicio,
        TAR.fecha_vencimiento,
        ACT.descripcion as activo,
        TP.tipo_prioridad as prioridad,
        EST.estado
        FROM tareas TAR
        INNER JOIN plandetareas PT ON PT.idplantarea = TAR.idplantarea
        INNER JOIN activos_vinculados_tarea AVT ON AVT.idtarea = TAR.idtarea
        INNER JOIN activos ACT ON ACT.idactivo = AVT.idactivo
        INNER JOIN tipo_prioridades TP ON TP.idtipo_prioridad = TAR.idtipo_prioridad
        INNER JOIN estados EST ON EST.idestado = TAR.idestado;
END */$$
DELIMITER ;

/* Procedure structure for procedure `obtenerTareasOdt` */

/*!50003 DROP PROCEDURE IF EXISTS  `obtenerTareasOdt` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `obtenerTareasOdt`(
	IN _borrador boolean
)
BEGIN 
    SELECT 
        ODT.idorden_trabajo,
        -- Concatenar los nombres y apellidos de los responsables
        GROUP_CONCAT(CONCAT(PERRES.nombres, ' ', PERRES.apellidos) SEPARATOR ', ') AS responsables,
        TAR.descripcion AS tarea,
        TAR.fecha_inicio,
        TAR.fecha_vencimiento,
        CONCAT(PERCRE.nombres, ' ', PERCRE.apellidos) AS creador,
        TAR.idtarea AS idtarea,
        ACT.descripcion AS activo,
        EST.estado,
        DODT.clasificacion
    FROM odt ODT
    INNER JOIN responsables_asignados_odt RA ON RA.idorden_trabajo = ODT.idorden_trabajo
    INNER JOIN usuarios USURES ON USURES.idusuario = RA.idresponsable
    INNER JOIN personas PERRES ON PERRES.idpersona = USURES.idpersona
    INNER JOIN usuarios USUCRE ON USUCRE.idusuario = ODT.creado_por
    INNER JOIN personas PERCRE ON PERCRE.idpersona = USUCRE.idpersona
    INNER JOIN tareas TAR ON TAR.idtarea = ODT.idtarea
    INNER JOIN activos_vinculados_tarea AVT ON AVT.idtarea = TAR.idtarea
    INNER JOIN activos ACT ON ACT.idactivo = AVT.idactivo
    INNER JOIN plandetareas PT ON PT.idplantarea = TAR.idplantarea
    INNER JOIN estados EST ON EST.idestado = ODT.idestado
    LEFT JOIN detalle_odt DODT ON DODT.clasificacion = EST.idestado 
    WHERE ODT.borrador = _borrador
    GROUP BY ODT.idorden_trabajo, TAR.descripcion, TAR.fecha_inicio, TAR.fecha_vencimiento, PERCRE.nombres, PERCRE.apellidos, TAR.idtarea, ACT.descripcion, EST.estado;
END */$$
DELIMITER ;

/* Procedure structure for procedure `obtenerTareasPorEstado` */

/*!50003 DROP PROCEDURE IF EXISTS  `obtenerTareasPorEstado` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `obtenerTareasPorEstado`(
	IN _idestado INT
)
BEGIN
	SELECT 
		TAR.descripcion,
        TAR.fecha_inicio,
        TAR.fecha_vencimiento,
        ACT.descripcion as activo,
        TP.tipo_prioridad,
        EST.estado
        FROM tareas TAR
        INNER JOIN plandetareas PT ON PT.idplantarea = TAR.idplantarea
        LEFT JOIN activos_vinculados_tarea AVT ON AVT.idtarea = TAR.idtarea
        LEFT JOIN activos ACT ON ACT.idactivo = AVT.idactivo
        LEFT JOIN tipo_prioridades TP ON TP.idtipo_prioridad = TAR.idtipo_prioridad
        LEFT JOIN estados EST ON EST.idestado = TAR.idestado
        WHERE EST.idestado = _idestado;
END */$$
DELIMITER ;

/* Procedure structure for procedure `obtenerTareasPorPlanTarea` */

/*!50003 DROP PROCEDURE IF EXISTS  `obtenerTareasPorPlanTarea` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `obtenerTareasPorPlanTarea`(IN _idplantarea INT)
BEGIN
	SELECT TAR.idtarea, PT.descripcion as plan_tarea, TP.tipo_prioridad, TAR.descripcion, TAR.cant_intervalo, TAR.frecuencia ,ES.estado FROM tareas TAR
    INNER JOIN plandetareas PT ON TAR.idplantarea = PT.idplantarea -- quitar esta linea luego pq no es necesario mostrar el plan de tareas al que pertenece
    INNER JOIN tipo_prioridades TP ON TAR.idtipo_prioridad = TP.idtipo_prioridad
    INNER JOIN estados ES ON TAR.idestado = ES.idestado
    WHERE TAR.idplantarea = _idplantarea ORDER BY TAR.idtarea DESC;
END */$$
DELIMITER ;

/* Procedure structure for procedure `obtenerUnActivoVinculadoAtarea` */

/*!50003 DROP PROCEDURE IF EXISTS  `obtenerUnActivoVinculadoAtarea` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `obtenerUnActivoVinculadoAtarea`(IN _idactivo_vinculado INT)
BEGIN
	SELECT AVT.idactivo_vinculado, AVT.idactivo, AVT.idtarea, ACT.descripcion ,SUB.subcategoria FROM activos_vinculados_tarea AVT
    INNER JOIN activos ACT ON AVT.idactivo = ACT.idactivo
    INNER JOIN subcategorias SUB ON ACT.idsubcategoria = SUB.idsubcategoria
    where AVT.idactivo_vinculado = _idactivo_vinculado;
END */$$
DELIMITER ;

/* Procedure structure for procedure `obtenerUsuario` */

/*!50003 DROP PROCEDURE IF EXISTS  `obtenerUsuario` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `obtenerUsuario`(
	IN _idusuario INT
)
BEGIN
	SELECT  * FROM usuarios WHERE idusuario = _idusuario;
END */$$
DELIMITER ;

/* Procedure structure for procedure `registrarDiagnostico` */

/*!50003 DROP PROCEDURE IF EXISTS  `registrarDiagnostico` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `registrarDiagnostico`(
	OUT _iddiagnostico INT,
	IN _idorden_trabajo INT,
    IN _idtipo_diagnostico INT,
    IN _diagnostico VARCHAR(300)
)
BEGIN
	-- Declaracion de variables
	DECLARE existe_error INT DEFAULT 0;
    
    -- Manejador de excepciones
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
		BEGIN
        SET existe_error = 1;
        END;
        
	INSERT INTO diagnosticos (idorden_trabajo, idtipo_diagnostico, diagnostico)
		VALUES (_idorden_trabajo, _idtipo_diagnostico, _diagnostico);
        
	IF existe_error = 1 THEN
		SET _iddiagnostico = -1;
	ELSE
        SET _iddiagnostico = LAST_INSERT_ID();
    END IF;
END */$$
DELIMITER ;

/* Procedure structure for procedure `registrarEvidenciaDiagnostico` */

/*!50003 DROP PROCEDURE IF EXISTS  `registrarEvidenciaDiagnostico` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `registrarEvidenciaDiagnostico`(
	IN _iddiagnostico INT,
    IN _evidencia VARCHAR(100)
)
BEGIN
	INSERT INTO evidencias_diagnostico (iddiagnostico, evidencia)
		VALUES (_iddiagnostico, _evidencia);
END */$$
DELIMITER ;

/* Procedure structure for procedure `registrarHistorial` */

/*!50003 DROP PROCEDURE IF EXISTS  `registrarHistorial` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `registrarHistorial`(
	IN _idorden_trabajo INT,
    IN _estado_anterior INT,
    IN _estado_nuevo 	INT,
    IN _comentario		TEXT,
    IN _devuelto		BOOLEAN
)
BEGIN
	INSERT INTO historial_estado_odt (_idorden_trabajo, _estado_anterior, _estado_nuevo, _comentario, _devuelto)	
		VALUES (_idorden_trabajo, _estado_anterior, _estado_nuevo, _comentario, NULLIF(_devuelto, ""));
END */$$
DELIMITER ;

/* Procedure structure for procedure `registrar_odt` */

/*!50003 DROP PROCEDURE IF EXISTS  `registrar_odt` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `registrar_odt`(
	IN _idtarea INT,
    IN _creado_por INT
)
BEGIN
	INSERT INTO odt (idtarea, creado_por)
		VALUES (_idtarea, _creado_por);
        
	SELECT MAX(idorden_trabajo) as id from odt;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_user_login` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_user_login` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_user_login`(
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
END */$$
DELIMITER ;

/* Procedure structure for procedure `verificarOrdenInconclusa` */

/*!50003 DROP PROCEDURE IF EXISTS  `verificarOrdenInconclusa` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `verificarOrdenInconclusa`(
	IN _idorden_trabajo INT
)
BEGIN
	SELECT
		*
        FROM odt ODT
        LEFT JOIN diagnosticos DIA ON DIA.idorden_trabajo = ODT.idorden_trabajo
        WHERE ODT.idorden_trabajo = 21 AND ODT.borrador = 1;
	
END */$$
DELIMITER ;

/* Procedure structure for procedure `verificarPlanInconcluso` */

/*!50003 DROP PROCEDURE IF EXISTS  `verificarPlanInconcluso` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `verificarPlanInconcluso`(IN _idplantarea INT)
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
END */$$
DELIMITER ;

/*Table structure for table `v_personas` */

DROP TABLE IF EXISTS `v_personas`;

/*!50001 DROP VIEW IF EXISTS `v_personas` */;
/*!50001 DROP TABLE IF EXISTS `v_personas` */;

/*!50001 CREATE TABLE  `v_personas`(
 `idpersona` int(11) ,
 `idtipodoc` int(11) ,
 `num_doc` varchar(50) ,
 `apellidos` varchar(100) ,
 `nombres` varchar(100) ,
 `genero` char(1) ,
 `telefono` char(9) ,
 `nacionalidad` varchar(50) 
)*/;

/*Table structure for table `v_usuarios` */

DROP TABLE IF EXISTS `v_usuarios`;

/*!50001 DROP VIEW IF EXISTS `v_usuarios` */;
/*!50001 DROP TABLE IF EXISTS `v_usuarios` */;

/*!50001 CREATE TABLE  `v_usuarios`(
 `idusuario` int(11) ,
 `usuario` varchar(120) ,
 `estado` tinyint(1) ,
 `rol` varchar(20) 
)*/;

/*View structure for view v_personas */

/*!50001 DROP TABLE IF EXISTS `v_personas` */;
/*!50001 DROP VIEW IF EXISTS `v_personas` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_personas` AS select `personas`.`idpersona` AS `idpersona`,`personas`.`idtipodoc` AS `idtipodoc`,`personas`.`num_doc` AS `num_doc`,`personas`.`apellidos` AS `apellidos`,`personas`.`nombres` AS `nombres`,`personas`.`genero` AS `genero`,`personas`.`telefono` AS `telefono`,`personas`.`nacionalidad` AS `nacionalidad` from `personas` */;

/*View structure for view v_usuarios */

/*!50001 DROP TABLE IF EXISTS `v_usuarios` */;
/*!50001 DROP VIEW IF EXISTS `v_usuarios` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_usuarios` AS select `us`.`idusuario` AS `idusuario`,`us`.`usuario` AS `usuario`,`us`.`estado` AS `estado`,`ro`.`rol` AS `rol` from (`usuarios` `us` left join `roles` `ro` on(`us`.`idrol` = `ro`.`idrol`)) */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
