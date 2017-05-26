CREATE DATABASE  IF NOT EXISTS `nearshore` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `nearshore`;
-- MySQL dump 10.13  Distrib 5.7.12, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: nearshore
-- ------------------------------------------------------
-- Server version	5.7.17-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `aplicacion`
--

DROP TABLE IF EXISTS `aplicacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `aplicacion` (
  `Csi_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Id_Dominio` int(11) DEFAULT NULL,
  `Ptb_Id` varchar(45) DEFAULT NULL,
  `Descripcion_Corta` varchar(200) DEFAULT NULL,
  `Descripcion_Larga` varchar(2000) DEFAULT NULL,
  `Id_L1` int(11) DEFAULT NULL,
  `Id_L2` int(11) DEFAULT NULL,
  `Id_L3` int(11) DEFAULT NULL,
  `Id_Plat1` int(11) DEFAULT NULL,
  `Id_Plat2` int(11) DEFAULT NULL,
  `Id_Plat3` int(11) DEFAULT NULL,
  `Comentarios` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`Csi_Id`),
  KEY `fk_CatDominio_Aplicacion_idx` (`Id_Dominio`),
  KEY `fk_CatProveedor_Aplicacion_idx` (`Id_L1`),
  KEY `fk_CatProveedor_Aplicacion_idx1` (`Id_L2`),
  KEY `fk_CatProveedor_Aplicacion_L3_idx` (`Id_L3`),
  KEY `fk_CatPlataforma_Aplicacion_Id_Plat1_idx` (`Id_Plat1`),
  KEY `fk_CatPlataforma_Aplicacion_Id_Plat2_idx` (`Id_Plat2`),
  KEY `fk_CatPlataforma_Aplicacion_Id_Plat3_idx` (`Id_Plat3`),
  CONSTRAINT `fk_CAT_DOMINIO_APLICACION` FOREIGN KEY (`Id_Dominio`) REFERENCES `cat_dominio` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_CAT_PLATAFORMA_APLICACION_Id_Plat1` FOREIGN KEY (`Id_Plat1`) REFERENCES `cat_plataforma` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_CAT_PLATAFORMA_APLICACION_Id_Plat2` FOREIGN KEY (`Id_Plat2`) REFERENCES `cat_plataforma` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_CAT_PROVEEDOR_APICACION_Id_L1` FOREIGN KEY (`Id_L1`) REFERENCES `cat_proveedor` (`Id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `fk_CAT_PROVEEDOR_APICACION_Id_L2` FOREIGN KEY (`Id_L2`) REFERENCES `cat_proveedor` (`Id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `fk_CAT_PROVEEDOR_APICACION_Id_L3` FOREIGN KEY (`Id_L3`) REFERENCES `cat_proveedor` (`Id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `fk_CAT_PROVEEDOR_APICACION_Id_Plat3` FOREIGN KEY (`Id_Plat3`) REFERENCES `cat_plataforma` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aplicacion`
--

LOCK TABLES `aplicacion` WRITE;
/*!40000 ALTER TABLE `aplicacion` DISABLE KEYS */;
INSERT INTO `aplicacion` VALUES (1,1,'1','Nearshore','Aplicación del catálogo de proveedores',1,2,4,1,2,1,'Sin comentarios.'),(2,5,'23','Microservicios Nearshoe','Microservicios de la aplicación de proveedores Banamex.',1,1,2,1,2,3,'Dsarrollado.'),(3,5,'22','Microservicios V2 Nearshore','Segunda versión de microservicios para aplicación de proveedores.',1,2,2,1,2,3,'En desarrollo.'),(4,5,'2','SW BANAMEX ELECTRONIC DEPOSIT OF CHECKS','Software used for cash deposit and endowments administration (SEF) and for remote check deposit (DEB) into customers\' accounts. The access will allow the user to do inquiries regarding DEB/SEF customers\' information.',1,2,4,1,2,1,'Desarrollado.');
/*!40000 ALTER TABLE `aplicacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aplicacion_proveedor`
--

DROP TABLE IF EXISTS `aplicacion_proveedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `aplicacion_proveedor` (
  `Id_Aplicacion_Proveedor` int(11) NOT NULL AUTO_INCREMENT,
  `Id_Proveedor` int(11) NOT NULL,
  `Csi_Id` int(11) NOT NULL,
  `L1_Primario` int(11) DEFAULT NULL,
  `L1_Backup` int(11) DEFAULT NULL,
  `L2_Primario` int(11) DEFAULT NULL,
  `L2_Backup` int(11) DEFAULT NULL,
  `L3_Primario` int(11) DEFAULT NULL,
  `L3_Backup` int(11) DEFAULT NULL,
  PRIMARY KEY (`Id_Aplicacion_Proveedor`,`Id_Proveedor`,`Csi_Id`),
  KEY `fk_APLICACION_APLICACION_PROVEEDOR_idx` (`Csi_Id`),
  KEY `fk_RECURSO_PROVEEDOR_APLICACION_PROVEEDOR_idx` (`L1_Primario`),
  KEY `fk_RECURSO_PROVEEDOR_APLICACION_PROVEEDOR_1_idx` (`L1_Backup`),
  KEY `fk_RECURSO_PROVEEDOR_APLICACION_PROVEEDOR_2_idx` (`L2_Primario`),
  KEY `fk_RECURSO_PROVEEDOR_APLICACION_PROVEEDOR_3_idx` (`L2_Backup`),
  KEY `fk_RECURSO_PROVEEDOR_APLICACION_PROVEEDOR_4_idx` (`L3_Primario`),
  KEY `fk_RECURSO_PROVEEDOR_APLICACION_PROVEEDOR_5_idx` (`L3_Backup`),
  KEY `fk_CAT_PROVEEDOR_APLICACION_PROVEEDOR` (`Id_Proveedor`),
  CONSTRAINT `fk_APLICACION_APLICACION_PROVEEDOR` FOREIGN KEY (`Csi_Id`) REFERENCES `aplicacion` (`Csi_Id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `fk_CAT_PROVEEDOR_APLICACION_PROVEEDOR` FOREIGN KEY (`Id_Proveedor`) REFERENCES `cat_proveedor` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_RECURSO_PROVEEDOR_APLICACION_PROVEEDOR` FOREIGN KEY (`L1_Primario`) REFERENCES `recurso_proveedor` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_RECURSO_PROVEEDOR_APLICACION_PROVEEDOR_1` FOREIGN KEY (`L1_Backup`) REFERENCES `recurso_proveedor` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_RECURSO_PROVEEDOR_APLICACION_PROVEEDOR_2` FOREIGN KEY (`L2_Primario`) REFERENCES `recurso_proveedor` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_RECURSO_PROVEEDOR_APLICACION_PROVEEDOR_3` FOREIGN KEY (`L2_Backup`) REFERENCES `recurso_proveedor` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_RECURSO_PROVEEDOR_APLICACION_PROVEEDOR_4` FOREIGN KEY (`L3_Primario`) REFERENCES `recurso_proveedor` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_RECURSO_PROVEEDOR_APLICACION_PROVEEDOR_5` FOREIGN KEY (`L3_Backup`) REFERENCES `recurso_proveedor` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aplicacion_proveedor`
--

LOCK TABLES `aplicacion_proveedor` WRITE;
/*!40000 ALTER TABLE `aplicacion_proveedor` DISABLE KEYS */;
INSERT INTO `aplicacion_proveedor` VALUES (1,1,1,1,4,1,3,2,1),(2,4,2,4,2,4,3,4,4);
/*!40000 ALTER TABLE `aplicacion_proveedor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cat_ciudad`
--

DROP TABLE IF EXISTS `cat_ciudad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cat_ciudad` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Id_Pais` int(11) DEFAULT NULL,
  `Descripcion` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `fk_CatPais_CatCiudad_idx` (`Id_Pais`),
  CONSTRAINT `fk_CAT_PAIS_CAT_CIUDAD` FOREIGN KEY (`Id_Pais`) REFERENCES `cat_pais` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cat_ciudad`
--

LOCK TABLES `cat_ciudad` WRITE;
/*!40000 ALTER TABLE `cat_ciudad` DISABLE KEYS */;
INSERT INTO `cat_ciudad` VALUES (5,1,'CDMX'),(6,1,'Monterrey'),(7,1,'Guadalajara'),(8,4,'Japón');
/*!40000 ALTER TABLE `cat_ciudad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cat_dominio`
--

DROP TABLE IF EXISTS `cat_dominio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cat_dominio` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Descripcion` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cat_dominio`
--

LOCK TABLES `cat_dominio` WRITE;
/*!40000 ALTER TABLE `cat_dominio` DISABLE KEYS */;
INSERT INTO `cat_dominio` VALUES (1,'FrontEnd'),(2,'Digital'),(3,'Canales Digitales'),(4,'Canales Tradicionales'),(5,'Middleware'),(6,'Seguros');
/*!40000 ALTER TABLE `cat_dominio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cat_pais`
--

DROP TABLE IF EXISTS `cat_pais`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cat_pais` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Descripcion` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cat_pais`
--

LOCK TABLES `cat_pais` WRITE;
/*!40000 ALTER TABLE `cat_pais` DISABLE KEYS */;
INSERT INTO `cat_pais` VALUES (1,'México'),(2,'Estados Unidos'),(3,'Colombia'),(4,'Japón');
/*!40000 ALTER TABLE `cat_pais` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cat_perfil`
--

DROP TABLE IF EXISTS `cat_perfil`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cat_perfil` (
  `Id_Perfil` int(11) NOT NULL AUTO_INCREMENT,
  `Descripcion` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`Id_Perfil`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cat_perfil`
--

LOCK TABLES `cat_perfil` WRITE;
/*!40000 ALTER TABLE `cat_perfil` DISABLE KEYS */;
INSERT INTO `cat_perfil` VALUES (1,'Super Administrador'),(2,'Administrador'),(3,'Backup'),(4,'Lectura');
/*!40000 ALTER TABLE `cat_perfil` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cat_plataforma`
--

DROP TABLE IF EXISTS `cat_plataforma`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cat_plataforma` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Descripcion` varchar(2000) DEFAULT NULL,
  `Comentarios` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cat_plataforma`
--

LOCK TABLES `cat_plataforma` WRITE;
/*!40000 ALTER TABLE `cat_plataforma` DISABLE KEYS */;
INSERT INTO `cat_plataforma` VALUES (1,'Plataforma 1','No hay comentarios.'),(2,'Plataforma 2','Sin comentarios.'),(3,'Plataforma 3','Sin comentarios.'),(4,'Java','S/C'),(5,'AngularJS','S/C'),(6,'MySQL','S/C');
/*!40000 ALTER TABLE `cat_plataforma` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cat_proveedor`
--

DROP TABLE IF EXISTS `cat_proveedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cat_proveedor` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Descripcion` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cat_proveedor`
--

LOCK TABLES `cat_proveedor` WRITE;
/*!40000 ALTER TABLE `cat_proveedor` DISABLE KEYS */;
INSERT INTO `cat_proveedor` VALUES (1,'Anzen'),(2,'IBM'),(3,'Nasoft'),(4,'Wipro'),(5,'Softeeck'),(6,'TCS'),(7,'Tech Test');
/*!40000 ALTER TABLE `cat_proveedor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cat_puesto_proveedor`
--

DROP TABLE IF EXISTS `cat_puesto_proveedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cat_puesto_proveedor` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Descripcion` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cat_puesto_proveedor`
--

LOCK TABLES `cat_puesto_proveedor` WRITE;
/*!40000 ALTER TABLE `cat_puesto_proveedor` DISABLE KEYS */;
INSERT INTO `cat_puesto_proveedor` VALUES (1,'Analista'),(2,'Contacto principal con Banamex'),(3,'Delivery Manager'),(4,'Project Manager'),(5,'Project Lead'),(6,'Proceso OnBoarding'),(7,'Programador'),(8,'Account Manager'),(9,'Desarrollador Java'),(10,'Desarrollador'),(11,'Technical Lead'),(12,'Desarrollador FrontEnd'),(13,'Tester'),(14,'Aplication Service Delivery Manager'),(15,'SCRUM Master');
/*!40000 ALTER TABLE `cat_puesto_proveedor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cat_puestociti`
--

DROP TABLE IF EXISTS `cat_puestociti`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cat_puestociti` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Descripcion` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cat_puestociti`
--

LOCK TABLES `cat_puestociti` WRITE;
/*!40000 ALTER TABLE `cat_puestociti` DISABLE KEYS */;
INSERT INTO `cat_puestociti` VALUES (1,'Analista'),(2,'Lider'),(3,'Gerente'),(4,'Desarrollador'),(5,'Director');
/*!40000 ALTER TABLE `cat_puestociti` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recurso_citi`
--

DROP TABLE IF EXISTS `recurso_citi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recurso_citi` (
  `Soe_Id` varchar(7) NOT NULL,
  `Apellido_Paterno` varchar(45) DEFAULT NULL,
  `Apellido_Materno` varchar(45) DEFAULT NULL,
  `Primer_Nombre` varchar(45) DEFAULT NULL,
  `Segundo_Nombre` varchar(45) DEFAULT '',
  `Id_Dominio` int(11) DEFAULT NULL,
  `Id_Puesto` int(11) DEFAULT NULL,
  `Id_Ciudad` int(11) DEFAULT NULL,
  `Ext` varchar(10) DEFAULT NULL,
  `Movil` varchar(10) DEFAULT NULL,
  `Telefono` varchar(10) DEFAULT NULL,
  `Email` varchar(60) DEFAULT NULL,
  `Id_ReportaA` varchar(7) DEFAULT NULL,
  `Comentarios` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`Soe_Id`),
  KEY `fk_CatDominio_RecursoCiti_Dominio_idx` (`Id_Dominio`),
  KEY `fk_CatpuestoCiti_IdPuesto_idx` (`Id_Puesto`),
  KEY `fk_CatCiudad_Id_Ciudad_idx` (`Id_Ciudad`),
  KEY `fk_RecursoCiti_RecursoCiti_idx` (`Id_ReportaA`),
  CONSTRAINT `fk_CAT_CIUDAD_RECURSO_CITI` FOREIGN KEY (`Id_Ciudad`) REFERENCES `cat_ciudad` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_CAT_DOMINIO_RECURSO_CITI` FOREIGN KEY (`Id_Dominio`) REFERENCES `cat_dominio` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_CAT_PUESTOCITI_RECURSO_CITI` FOREIGN KEY (`Id_Puesto`) REFERENCES `cat_puestociti` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_RECURSO_CITIi_RECURSO_CITI` FOREIGN KEY (`Id_ReportaA`) REFERENCES `recurso_citi` (`Soe_Id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recurso_citi`
--

LOCK TABLES `recurso_citi` WRITE;
/*!40000 ALTER TABLE `recurso_citi` DISABLE KEYS */;
INSERT INTO `recurso_citi` VALUES ('GC37337','Flores','Rodriguez','Josefina','',6,5,5,'12345','339876543','1212345678','josefina.flores@citibanamex.com',NULL,'Usa mucho el pacman'),('JP12345','Perez','Perez','Juan','',1,1,5,'23456','5586978566',NULL,'juan.perezperez@citi.com','JP12345','Es Analista.'),('RS23323','Arrollo','Luna','Alberto','',2,2,5,'12234','5520708798',NULL,'rodolfo.sanvicenteatilano@citi.com','RS23323','Se reporta asi mismo.');
/*!40000 ALTER TABLE `recurso_citi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recurso_proveedor`
--

DROP TABLE IF EXISTS `recurso_proveedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recurso_proveedor` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Id_Proveedor` int(11) NOT NULL,
  `Clave_Empleado` int(11) NOT NULL,
  `Apellido_Paterno` varchar(45) DEFAULT NULL,
  `Apellido_Materno` varchar(45) DEFAULT NULL,
  `Primer_Nombre` varchar(45) DEFAULT NULL,
  `Segundo_Nombre` varchar(45) DEFAULT '',
  `Id_Ciudad` int(11) DEFAULT NULL,
  `Movil_Personal` varchar(10) DEFAULT NULL,
  `Telefono_Particular` varchar(10) DEFAULT NULL,
  `Email_Personal` varchar(60) DEFAULT NULL,
  `Id_Puesto` int(11) DEFAULT NULL,
  `Id_Reporta_A` int(11) DEFAULT NULL,
  `Telefono_Proveedor` varchar(10) DEFAULT NULL,
  `Ext_Proveedor` varchar(10) DEFAULT NULL,
  `Email_Proveedor` varchar(60) DEFAULT NULL,
  `Soe_Id` varchar(7) DEFAULT NULL,
  `Ext_Citi` varchar(10) DEFAULT NULL,
  `Email_Citi` varchar(60) DEFAULT NULL,
  `Comentarios` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `Clave_Empleado_UNIQUE` (`Clave_Empleado`),
  KEY `fk_CAT_PROVEEDOR_RECURSOS_PROVEEDOR_idx` (`Id_Proveedor`),
  KEY `fk_CAT_CIUDAD_RECURSOS_PROVEEDOR_idx` (`Id_Ciudad`),
  KEY `fk_CAT_PUESTO_PROVEEDOR_RECURSOS_PROVEEDOR_idx` (`Id_Puesto`),
  CONSTRAINT `fk_CAT_CIUDAD_RECURSO_PROVEEDOR` FOREIGN KEY (`Id_Ciudad`) REFERENCES `cat_ciudad` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_CAT_PROVEEDOR_RECURSO_PROVEEDOR` FOREIGN KEY (`Id_Proveedor`) REFERENCES `cat_proveedor` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_CAT_PUESTO_PROVEEDOR_RECURSO_PROVEEDOR` FOREIGN KEY (`Id_Puesto`) REFERENCES `cat_puesto_proveedor` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recurso_proveedor`
--

LOCK TABLES `recurso_proveedor` WRITE;
/*!40000 ALTER TABLE `recurso_proveedor` DISABLE KEYS */;
INSERT INTO `recurso_proveedor` VALUES (1,1,10004057,'Cauich','Lemus','Gerardo','',5,'5512345678',NULL,'gcauich@anzen.com.mx',3,10003328,'22334455','2323','gcauich@anzen.com.mx','GC37337',NULL,'gerardo.cauichlemus@citibanamex.com','Usa mucho el pacman en sus comentarios. :v'),(2,1,10003328,'San Vicente','Atilano','Rodolfo','',5,'5520708798',NULL,'rodolof@gmail.com',1,10003328,'22334455','2323','rsanvicente@anzen.com.mx','RS23233','1111','rodolfo.sanvicenteatilano@citi.com','Sin comentarios.'),(3,1,10004934,'Junco','Lozano','Jose','Luis',5,'5511446688',NULL,'junco@gmail.com',3,10003328,'22334455','2323','jjunco@anzen.com',NULL,NULL,NULL,'sin comentarios.'),(4,1,10004623,'Ramirez','Morales','David ','Jesus',5,'5561327653',NULL,'david@gmail.com',2,10003328,'22334455','2323','dramirez@anzen.com',NULL,NULL,NULL,':v'),(5,1,10004542,'Valles','Garcia','Dionisio','Javier',5,'4929051270','3341606007','dionisio@gmail.com',4,10003328,'22334455','2324','dvalles@anzen.com.mx','DV06619','','dionisio.javier.vallesgarcia@citibanamex.com',NULL),(6,1,30000012,'Castelan','Silva','Jose','Alfredo',5,NULL,NULL,'jose@gmail.com',9,10003328,'22334455','2322','jcastelan@anzen.com.mx',NULL,NULL,NULL,NULL),(7,1,10003364,'Claudio','Ramirez','Octavio','',5,'5561234995','','octavio@hotmail.com',11,10003328,'22334455','1122','oclaudio@anzen.com.mx','OC37210',NULL,'octavio.clauidoramirez@citi.com',NULL),(8,1,10003638,'Coronel ','Cruz','Miguel ','Angel ',5,'5528613618',NULL,'miguelyahoo.com',10,10003328,'22334455','1234','mcoronel@anzen.com.mx','MC67168',NULL,'miguel.angel.coronelcruz@citibanamex.com',NULL),(9,1,30000007,'Cruz ','Hernandez','Jesus','',5,NULL,NULL,'jesusqgmail.com',10,10003328,'22334455',NULL,'jesuscruz@anzen.com.mx','JC35998',NULL,'jesus1.cruzhernandez@citi.com',NULL),(10,1,10004545,'Cruz ','Ramirez','Isai ','',5,NULL,NULL,'isai@hotmail.com',10,10003328,'22334455',NULL,'icruz@anzen.com.mx','IC14344',NULL,'isaia.cruzramirez@citi.com',NULL),(11,1,10003687,'De la Rosa ','Bonilla ','Mayetzi ','',5,'5523346566','5522260575','mayetzi@outlook.com',11,10003328,'22334455',NULL,'mdelarosa@anzen.com.mx','MD97674',NULL,'mayetzi.delarosabonilla@banamex.com',NULL),(12,1,10003484,'Dominguez','Garcia','Victor','Manuel',5,'5518299093',NULL,'victor@gmail.com',11,10003328,'22334455',NULL,'vdominguez@anzen.com.mx','VD96207',NULL,'victor.manuel.dominguezgarcia@citi.com',NULL),(13,1,10003629,'Flores','Zamora','Guillermo','',7,NULL,'3341606000','g.zamora@gmail.com',10,10003328,'22334455',NULL,'guillermoflores@anzen.com.mx','GF58868',NULL,'guillermo.floreszamora@citibanamex.com',NULL),(14,1,10003397,'Franco','Tellez','Michel','Geovanni',5,NULL,NULL,'michel@yahoo.com.mx',13,10003355,'22334455',NULL,'mfranco@anzen.com.mx','MF37396',NULL,'michel.giovanni.francotellez@citibanamex.com',NULL),(15,1,10003919,'Jasso','Zaragoza','Adriana','Victoria',5,NULL,NULL,'adriana@gmail.com',10,10003354,'22334455',NULL,'ajasso@anzen.com.mx',NULL,NULL,NULL,NULL),(16,1,10003453,'Garduño ','Cruz','Erika','Viridiana',5,'5538562953','5522260563','erika@gmail.com',14,10003354,'22334455',NULL,'egarduno@anzen.com.mx','EG37380',NULL,'erika.viridiana.garduñocruz@banamex.com',NULL),(17,4,10003358,'Srinivasan','Perez','Vadivel','',5,'9924234234',NULL,'vadi@gmail.com',10,11111111,'88888888',NULL,'srinivasan.vadivel@wipro.com',NULL,NULL,NULL,NULL),(18,4,12930405,'Algo','Algo','Param','',5,'9923423133',NULL,'param@gmail.com',3,11111111,'88888888',NULL,'param@wipro.com',NULL,NULL,NULL,NULL),(19,4,21232134,'apellido','segundoAp','Kupurash','',5,'9923423423',NULL,'kupu@gmail.com',9,11111111,'88888888',NULL,'kupurash@wipro.com',NULL,NULL,NULL,NULL),(20,4,11111111,'qwerty','qwertyu','Satish','',5,'9923652443',NULL,'satish@gmail.com',4,11111111,'88888888',NULL,'satish@wipro.com',NULL,NULL,NULL,NULL),(21,4,23476873,'asdfg','asdfgh','Atul','',5,'9923651423',NULL,'atul@gmail.com',15,11111111,'88888888',NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `recurso_proveedor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recursociti_aplicacion`
--

DROP TABLE IF EXISTS `recursociti_aplicacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recursociti_aplicacion` (
  `idRecursoCiti` varchar(7) NOT NULL,
  `idAplicacion` int(11) NOT NULL,
  PRIMARY KEY (`idRecursoCiti`,`idAplicacion`),
  KEY `fk_recursociti_aplicacion_aplicacion1_idx` (`idAplicacion`),
  CONSTRAINT `fk_recursociti_aplicacion_aplicacion1` FOREIGN KEY (`idAplicacion`) REFERENCES `aplicacion` (`Csi_Id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_recursociti_aplicacion_recurso_citi` FOREIGN KEY (`idRecursoCiti`) REFERENCES `recurso_citi` (`Soe_Id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recursociti_aplicacion`
--

LOCK TABLES `recursociti_aplicacion` WRITE;
/*!40000 ALTER TABLE `recursociti_aplicacion` DISABLE KEYS */;
INSERT INTO `recursociti_aplicacion` VALUES ('GC37337',1),('JP12345',1),('RS23323',1),('GC37337',2),('RS23323',3);
/*!40000 ALTER TABLE `recursociti_aplicacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recursoproveedor_aplicacion`
--

DROP TABLE IF EXISTS `recursoproveedor_aplicacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recursoproveedor_aplicacion` (
  `idRecursoProveedor` int(11) NOT NULL,
  `idAplicacion` int(11) NOT NULL,
  PRIMARY KEY (`idRecursoProveedor`,`idAplicacion`),
  KEY `fk_recursoproveedor_aplicacion_aplicacion1_idx` (`idAplicacion`),
  CONSTRAINT `fk_recursoproveedor_aplicacion_aplicacion1` FOREIGN KEY (`idAplicacion`) REFERENCES `aplicacion` (`Csi_Id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `fk_recursoproveedor_aplicacion_recurso_proveedor` FOREIGN KEY (`idRecursoProveedor`) REFERENCES `recurso_proveedor` (`Id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recursoproveedor_aplicacion`
--

LOCK TABLES `recursoproveedor_aplicacion` WRITE;
/*!40000 ALTER TABLE `recursoproveedor_aplicacion` DISABLE KEYS */;
INSERT INTO `recursoproveedor_aplicacion` VALUES (1,1),(2,1),(3,1),(4,1),(2,2),(3,2),(4,2);
/*!40000 ALTER TABLE `recursoproveedor_aplicacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuario` (
  `Email` varchar(60) NOT NULL,
  `Primer_Nombre` varchar(45) DEFAULT NULL,
  `Segundo_Nombre` varchar(45) DEFAULT '',
  `Apellido_Paterno` varchar(45) DEFAULT NULL,
  `ApellidoMaterno` varchar(45) DEFAULT NULL,
  `Clave` varchar(45) DEFAULT NULL,
  `Id_Perfil` int(11) DEFAULT NULL,
  `Activo` tinyint(1) DEFAULT NULL,
  `Dominios` varchar(2000) DEFAULT NULL,
  `Proveedores` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`Email`),
  KEY `fk_CAT_PERFIL_USUARIO_idx` (`Id_Perfil`),
  CONSTRAINT `fk_CAT_PERFIL_USUARIO` FOREIGN KEY (`Id_Perfil`) REFERENCES `cat_perfil` (`Id_Perfil`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES ('kdk@ksk.cpom','Hector','','Lozoya','Perez','1234',1,1,'Canales Digitales','Banamex'),('qwerty1@anzen.com','Julio','','Contreras','Carrillo','1234',2,1,'Canales Digitales','Anzen'),('qwerty2@anzen.com','Sergio','','Santana','Martinez','1234',3,1,'Canales Digitales','Anzen'),('qwerty3@wipro.com','Isaac','','Vargas','Gonzales','1234',2,1,'Canales Digitales','Wipro'),('qwerty4@wipro.com','Ammulu','','Addhanki','Addhanki','1234',2,1,'Canales Digitales','Wipro'),('qwerty@gmail.com','Deibid','','Ramirez','Morales','1234',1,1,'Canales Digitales','Anzen');
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'nearshore'
--
/*!50003 DROP PROCEDURE IF EXISTS `paginationUsersAccessToApplication` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `paginationUsersAccessToApplication`(IN StartIndex INT,IN Count INT)
BEGIN
DECLARE LowerBound INT;
DECLARE UpperBound INT;
DECLARE rownum INT;
SET LowerBound = ((StartIndex - 1) * Count) + 1;
SET UpperBound = ((StartIndex - 1) * Count) + Count;

SELECT (select ceiling(count(*)/Count) from USUARIO u join CAT_PERFIL p on u.Id_Perfil=p.Id_Perfil) as pages,
        Email, 
        concat(Primer_Nombre,' ',Segundo_Nombre,' ',Apellido_Paterno,' ',ApellidoMaterno) as nombre,
        Clave,
        Activo,
        Dominios,
        Proveedores,
		Id_Perfil,
        Descripcion
  from (SELECT *, @rownum := @rownum + 1 AS rank 
		from (SELECT u.Email, 
                    u.Primer_Nombre, 
                    u.Segundo_Nombre,
					u.Apellido_Paterno, 
                    u.ApellidoMaterno, 
                    u.Clave,
                    u.Activo,
                    u.Dominios,
                    u.Proveedores,
					p.Id_Perfil,
                    p.Descripcion FROM USUARIO u join CAT_PERFIL p on u.Id_Perfil=p.Id_Perfil
				) d, (SELECT @rownum  := 0) r ) m
WHERE rank >= LowerBound and rank <= UpperBound;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-05-26 18:41:48
