CREATE DATABASE  IF NOT EXISTS `nearshore` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `nearshore`;
-- MySQL dump 10.13  Distrib 5.7.12, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: nearshore2
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
-- Table structure for table `APLICACION`
--

DROP TABLE IF EXISTS `APLICACION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `APLICACION` (
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
  CONSTRAINT `fk_CAT_DOMINIO_APLICACION` FOREIGN KEY (`Id_Dominio`) REFERENCES `CAT_DOMINIO` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_CAT_PLATAFORMA_APLICACION_Id_Plat1` FOREIGN KEY (`Id_Plat1`) REFERENCES `CAT_PLATAFORMA` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_CAT_PLATAFORMA_APLICACION_Id_Plat2` FOREIGN KEY (`Id_Plat2`) REFERENCES `CAT_PLATAFORMA` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_CAT_PROVEEDOR_APICACION_Id_L1` FOREIGN KEY (`Id_L1`) REFERENCES `CAT_PROVEEDOR` (`Id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `fk_CAT_PROVEEDOR_APICACION_Id_L2` FOREIGN KEY (`Id_L2`) REFERENCES `CAT_PROVEEDOR` (`Id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `fk_CAT_PROVEEDOR_APICACION_Id_L3` FOREIGN KEY (`Id_L3`) REFERENCES `CAT_PROVEEDOR` (`Id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `fk_CAT_PROVEEDOR_APICACION_Id_Plat3` FOREIGN KEY (`Id_Plat3`) REFERENCES `CAT_PLATAFORMA` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `APLICACION`
--

LOCK TABLES `APLICACION` WRITE;
/*!40000 ALTER TABLE `APLICACION` DISABLE KEYS */;
INSERT INTO `APLICACION` (`Csi_Id`, `Id_Dominio`, `Ptb_Id`, `Descripcion_Corta`, `Descripcion_Larga`, `Id_L1`, `Id_L2`, `Id_L3`, `Id_Plat1`, `Id_Plat2`, `Id_Plat3`, `Comentarios`) VALUES (1,1,'1','Nearshore','Aplicación del catálogo de proveedores',1,2,4,1,2,1,'Sin comentarios.'),(2,5,'23','Microservicios Nearshoe','Microservicios de la aplicación de proveedores Banamex.',1,1,2,1,2,3,'Dsarrollado.'),(3,5,'22','Microservicios V2 Nearshore','Segunda versión de microservicios para aplicación de proveedores.',1,2,2,1,2,3,'En desarrollo.'),(4,1,'12','Backbase','FrontEnd with Backbase framework.',1,2,3,4,5,3,'No hay comentarios'),(5,1,'12','Backbase','FrontEnd with Backbase framework.',1,2,3,4,5,3,'No hay comentarios');
/*!40000 ALTER TABLE `APLICACION` ENABLE KEYS */;
UNLOCK TABLES;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `nearshore`.`aplicacion_AFTER_INSERT` AFTER INSERT ON APLICACION FOR EACH ROW
BEGIN
	INSERT INTO L1APLICACION (idAplicacionCiti)
    SELECT NEW.Csi_id FROM APLICACION WHERE Csi_id = NEW.Csi_id;
    INSERT INTO L2APLICACION (idAplicacionCiti)
    SELECT NEW.Csi_id FROM APLICACION WHERE Csi_id = NEW.Csi_id;
    INSERT INTO L3APLICACION (idAplicacionCiti)
    SELECT NEW.Csi_id FROM APLICACION WHERE Csi_id = NEW.Csi_id;
    INSERT INTO APLICACION_PROVEEDOR (Csi_Id, Id_Proveedor, nivel)
    SELECT NEW.Csi_Id, NEW.Id_L1,1 FROM APLICACION WHERE Csi_Id = NEW.Csi_Id;
    INSERT INTO APLICACION_PROVEEDOR (Csi_Id, Id_Proveedor, nivel)
    SELECT NEW.Csi_Id, NEW.Id_L2,2 FROM APLICACION WHERE Csi_Id = NEW.Csi_Id;
    INSERT INTO APLICACION_PROVEEDOR (Csi_Id, Id_Proveedor, nivel)
    SELECT NEW.Csi_Id, NEW.Id_L3,3 FROM APLICACION WHERE Csi_Id = NEW.Csi_Id;
END */;;
DELIMITER ;

/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `nearshore`.`aplicacion_AFTER_UPDATE` AFTER UPDATE ON `APLICACION` FOR EACH ROW
BEGIN
    DECLARE _L1 INT(11);
    DECLARE _idProv INT(11);
	SELECT Csi_Id FROM APLICACION WHERE Id_L1=NEW.Id_L1 INTO _L1;
    IF NEW.Id_L1 <> OLD.Id_L1 THEN
		SELECT Id_L1 FROM APLICACION WHERE Id_L1 = NEW.Id_L1 INTO _idProv;
		UPDATE L1APLICACION SET idResponsableRProveedor = null,idBackupRProveedor = null,
			idLiderRProveedor = null, idProjectManagerRProveedor = null,
            idDeliveryManagerRProveedor = null WHERE idAplicacionCiti=_L1;
		UPDATE RECURSOPROVEEDOR_APLICACION SET idRecursoProveedor = null WHERE idAplicacion = _L1 AND nivel = 1;
        UPDATE APLICACION_PROVEEDOR SET Id_Proveedor = _idProv WHERE Csi_Id = _L1 AND nivel = 1;
    END IF;
	IF NEW.Id_L2 <> OLD.Id_L2 THEN
		SELECT Id_L2 FROM APLICACION WHERE Id_L2 = NEW.Id_L2 INTO _idProv;
		UPDATE L2APLICACION SET idResponsableRProveedor = null,idBackupRProveedor = null,
			idLiderRProveedor = null, idProjectManagerRProveedor = null,
            idDeliveryManagerRProveedor = null WHERE idAplicacionCiti=_L1;
		UPDATE RECURSOPROVEEDOR_APLICACION SET idRecursoProveedor = null WHERE idAplicacion = _L1 AND nivel = 2;
        UPDATE APLICACION_PROVEEDOR SET Id_Proveedor = _idProv WHERE Csi_Id = _L1 AND nivel = 2;
    END IF;
    IF NEW.Id_L3 <> OLD.Id_L3 THEN
		SELECT Id_L3 FROM APLICACION WHERE Id_L3 = NEW.Id_L3 INTO _idProv;
		UPDATE L3APLICACION SET idResponsableRProveedor = null,idBackupRProveedor = null,
			idLiderRProveedor = null, idProjectManagerRProveedor = null,
            idDeliveryManagerRProveedor = null WHERE idAplicacionCiti=_L1;
		UPDATE RECURSOPROVEEDOR_APLICACION SET idRecursoProveedor = null WHERE idAplicacion = _L1 AND nivel = 3;
        UPDATE APLICACION_PROVEEDOR SET Id_Proveedor = _idProv WHERE Csi_Id = _L1 AND nivel = 3;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
--
-- Table structure for table `APLICACION_PROVEEDOR`
--

DROP TABLE IF EXISTS `APLICACION_PROVEEDOR`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `APLICACION_PROVEEDOR` (
   `Csi_Id` int(11) NOT NULL,
   `Id_Proveedor` int(11) NOT NULL,
   `nivel` tinyint(1) NOT NULL,
   PRIMARY KEY (`nivel`,`Csi_Id`),
   KEY `fk_aplicacion_proveedor_aplicacion1_idx` (`Csi_Id`),
   KEY `fk_aplicacion_proveedor_cat_proveedor1_idx` (`Id_Proveedor`),
   CONSTRAINT `fk_aplicacion_proveedor_aplicacion1` FOREIGN KEY (`Csi_Id`) REFERENCES `APLICACION` (`Csi_Id`) ON DELETE CASCADE ON UPDATE NO ACTION,
   CONSTRAINT `fk_aplicacion_proveedor_cat_proveedor1` FOREIGN KEY (`Id_Proveedor`) REFERENCES `CAT_PROVEEDOR` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
 
 /*CREATE TABLE `APLICACION_PROVEEDOR` (
   `Csi_Id` int(11) NOT NULL,
   `Id_Proveedor` int(11) NOT NULL,
   `nivel` tinyint(1) NOT NULL,
   KEY `fk_aplicacion_proveedor_aplicacion1_idx` (`Csi_Id`),
   KEY `fk_aplicacion_proveedor_cat_proveedor1_idx` (`Id_Proveedor`),
   CONSTRAINT `fk_aplicacion_proveedor_aplicacion1` FOREIGN KEY (`Csi_Id`) REFERENCES `APLICACION` (`Csi_Id`) ON DELETE CASCADE ON UPDATE NO ACTION,
   CONSTRAINT `fk_aplicacion_proveedor_cat_proveedor1` FOREIGN KEY (`Id_Proveedor`) REFERENCES `CAT_PROVEEDOR` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8;*/

--
-- Dumping data for table `APLICACION_PROVEEDOR`
--

LOCK TABLES `APLICACION_PROVEEDOR` WRITE;
/*!40000 ALTER TABLE `APLICACION_PROVEEDOR` DISABLE KEYS */;
INSERT INTO `APLICACION_PROVEEDOR` (`Id_Proveedor`, `Csi_Id`) VALUES (1,1),(2,4);
/*!40000 ALTER TABLE `APLICACION_PROVEEDOR` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CAT_CIUDAD`
--

DROP TABLE IF EXISTS `CAT_CIUDAD`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CAT_CIUDAD` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Id_Pais` int(11) DEFAULT NULL,
  `Descripcion` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `fk_CatPais_CatCiudad_idx` (`Id_Pais`),
  CONSTRAINT `fk_CAT_PAIS_CAT_CIUDAD` FOREIGN KEY (`Id_Pais`) REFERENCES `CAT_PAIS` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CAT_CIUDAD`
--

LOCK TABLES `CAT_CIUDAD` WRITE;
/*!40000 ALTER TABLE `CAT_CIUDAD` DISABLE KEYS */;
INSERT INTO `CAT_CIUDAD` (`Id`, `Id_Pais`, `Descripcion`) VALUES (5,1,'CDMX'),(6,1,'Monterrey'),(7,1,'Guadalajara'),(8,4,'Japón');
/*!40000 ALTER TABLE `CAT_CIUDAD` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CAT_DOMINIO`
--

DROP TABLE IF EXISTS `CAT_DOMINIO`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CAT_DOMINIO` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Descripcion` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CAT_DOMINIO`
--

LOCK TABLES `CAT_DOMINIO` WRITE;
/*!40000 ALTER TABLE `CAT_DOMINIO` DISABLE KEYS */;
INSERT INTO `CAT_DOMINIO` (`Id`, `Descripcion`) VALUES (1,'FrontEnd'),(2,'Digital'),(3,'Canales Digitales'),(4,'Canales Tradicionales'),(5,'Middleware'),(6,'Seguros');
/*!40000 ALTER TABLE `CAT_DOMINIO` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CAT_PAIS`
--

DROP TABLE IF EXISTS `CAT_PAIS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CAT_PAIS` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Descripcion` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CAT_PAIS`
--

LOCK TABLES `CAT_PAIS` WRITE;
/*!40000 ALTER TABLE `CAT_PAIS` DISABLE KEYS */;
INSERT INTO `CAT_PAIS` (`Id`, `Descripcion`) VALUES (1,'México'),(2,'Estados Unidos'),(3,'Colombia'),(4,'Japón');
/*!40000 ALTER TABLE `CAT_PAIS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CAT_PERFIL`
--

DROP TABLE IF EXISTS `CAT_PERFIL`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CAT_PERFIL` (
  `Id_Perfil` int(11) NOT NULL AUTO_INCREMENT,
  `Descripcion` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`Id_Perfil`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CAT_PERFIL`
--

LOCK TABLES `CAT_PERFIL` WRITE;
/*!40000 ALTER TABLE `CAT_PERFIL` DISABLE KEYS */;
INSERT INTO `CAT_PERFIL` (`Id_Perfil`, `Descripcion`) VALUES (1,'Super Administrador'),(2,'Administrador'),(3,'Backup'),(4,'Lectura');
/*!40000 ALTER TABLE `CAT_PERFIL` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CAT_PLATAFORMA`
--

DROP TABLE IF EXISTS `CAT_PLATAFORMA`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CAT_PLATAFORMA` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Descripcion` varchar(2000) DEFAULT NULL,
  `Comentarios` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CAT_PLATAFORMA`
--

LOCK TABLES `CAT_PLATAFORMA` WRITE;
/*!40000 ALTER TABLE `CAT_PLATAFORMA` DISABLE KEYS */;
INSERT INTO `CAT_PLATAFORMA` (`Id`, `Descripcion`, `Comentarios`) VALUES (1,'Plataforma 1','No hay comentarios.'),(2,'Plataforma 2','Sin comentarios.'),(3,'Plataforma 3','Sin comentarios.'),(4,'Java','S/C'),(5,'AngularJS','S/C'),(6,'MySQL','S/C');
/*!40000 ALTER TABLE `CAT_PLATAFORMA` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CAT_PROVEEDOR`
--

DROP TABLE IF EXISTS `CAT_PROVEEDOR`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CAT_PROVEEDOR` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Descripcion` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CAT_PROVEEDOR`
--

LOCK TABLES `CAT_PROVEEDOR` WRITE;
/*!40000 ALTER TABLE `CAT_PROVEEDOR` DISABLE KEYS */;
INSERT INTO `CAT_PROVEEDOR` (`Id`, `Descripcion`) VALUES (1,'Anzen'),(2,'IBM'),(3,'Nasoft'),(4,'Wipro'),(5,'Softeeck'),(6,'TCS'),(7,'Tech Test');
/*!40000 ALTER TABLE `CAT_PROVEEDOR` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CAT_PUESTO_PROVEEDOR`
--

DROP TABLE IF EXISTS `CAT_PUESTO_PROVEEDOR`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CAT_PUESTO_PROVEEDOR` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Descripcion` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CAT_PUESTO_PROVEEDOR`
--

LOCK TABLES `CAT_PUESTO_PROVEEDOR` WRITE;
/*!40000 ALTER TABLE `CAT_PUESTO_PROVEEDOR` DISABLE KEYS */;
INSERT INTO `CAT_PUESTO_PROVEEDOR` (`Id`, `Descripcion`) VALUES (1,'Analista'),(2,'Contacto principal con Banamex'),(3,'Delivery Manager'),(4,'Project Manager'),(5,'Project Lead'),(6,'Proceso OnBoarding'),(7,'Programador'),(8,'Account Manager'),(9,'Desarrollador Java'),(10,'Desarrollador'),(11,'Technical Lead'),(12,'Desarrollador FrontEnd'),(13,'Tester'),(14,'Aplication Service Delivery Manager'),(15,'SCRUM Master');
/*!40000 ALTER TABLE `CAT_PUESTO_PROVEEDOR` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CAT_PUESTOCITI`
--

DROP TABLE IF EXISTS `CAT_PUESTOCITI`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CAT_PUESTOCITI` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Descripcion` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CAT_PUESTOCITI`
--

LOCK TABLES `CAT_PUESTOCITI` WRITE;
/*!40000 ALTER TABLE `CAT_PUESTOCITI` DISABLE KEYS */;
INSERT INTO `CAT_PUESTOCITI` (`Id`, `Descripcion`) VALUES (1,'Analista'),(2,'Lider'),(3,'Gerente'),(4,'Desarrollador'),(5,'Director');
/*!40000 ALTER TABLE `CAT_PUESTOCITI` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `detailsl1application`
--

DROP TABLE IF EXISTS `detailsl1application`;
/*!50001 DROP VIEW IF EXISTS `detailsl1application`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `detailsl1application` AS SELECT 
 1 AS `idApp`,
 1 AS `dominio`,
 1 AS `L1`,
 1 AS `analista_bnmx`,
 1 AS `ext_analista_bnmx`,
 1 AS `celular_analista_bnmx`,
 1 AS `email_analista_bnmx`,
 1 AS `lider_bnmx`,
 1 AS `ext_lider_bnmx`,
 1 AS `celular_lider_bnmx`,
 1 AS `email_lider_bnmx`,
 1 AS `gerente_bnmx`,
 1 AS `ext_gerente_bnmx`,
 1 AS `celular_gerente_bnmx`,
 1 AS `email_gerente_bnmx`,
 1 AS `proveedor`,
 1 AS `responsable_prov`,
 1 AS `ext_responsable_banamex_prov`,
 1 AS `lada_cel_responsable_prov`,
 1 AS `cel_responsable_prov`,
 1 AS `email_responsable_bnmx_prov`,
 1 AS `lada_otro_responsable_prov`,
 1 AS `tel_otro_responsable_prov`,
 1 AS `email_responsable_prov`,
 1 AS `backup_prov`,
 1 AS `ext_backup_banamex_prov`,
 1 AS `lada_cel_backup_prov`,
 1 AS `cel_backup_prov`,
 1 AS `email_backup_bnmx_prov`,
 1 AS `lada_otro_backup_prov`,
 1 AS `tel_otro_backup_prov`,
 1 AS `email_backup_prov`,
 1 AS `lider_prov`,
 1 AS `ext_lider_banamex_prov`,
 1 AS `lada_cel_lider_prov`,
 1 AS `cel_lider_prov`,
 1 AS `email_lider_bnmx_prov`,
 1 AS `lada_otro_lider_prov`,
 1 AS `tel_otro_lider_prov`,
 1 AS `email_lider_prov`,
 1 AS `p_manager_prov`,
 1 AS `ext_p_manager_banamex_prov`,
 1 AS `lada_cel_p_manager_prov`,
 1 AS `cel_p_manager_prov`,
 1 AS `email_p_manager_bnmx_prov`,
 1 AS `lada_otro_p_manager_prov`,
 1 AS `tel_otro_p_manager_prov`,
 1 AS `email_p_manager_prov`,
 1 AS `d_manager_prov`,
 1 AS `ext_d_manager_banamex_prov`,
 1 AS `lada_cel_d_manager_prov`,
 1 AS `cel_d_manager_prov`,
 1 AS `email_d_manager_bnmx_prov`,
 1 AS `lada_otro_d_manager_prov`,
 1 AS `tel_otro_d_manager_prov`,
 1 AS `email_d_manager_prov`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `detailsl2application`
--

DROP TABLE IF EXISTS `detailsl2application`;
/*!50001 DROP VIEW IF EXISTS `detailsl2application`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `detailsl2application` AS SELECT 
 1 AS `idApp`,
 1 AS `dominio`,
 1 AS `L2`,
 1 AS `analista_bnmx`,
 1 AS `ext_analista_bnmx`,
 1 AS `celular_analista_bnmx`,
 1 AS `email_analista_bnmx`,
 1 AS `lider_bnmx`,
 1 AS `ext_lider_bnmx`,
 1 AS `celular_lider_bnmx`,
 1 AS `email_lider_bnmx`,
 1 AS `gerente_bnmx`,
 1 AS `ext_gerente_bnmx`,
 1 AS `celular_gerente_bnmx`,
 1 AS `email_gerente_bnmx`,
 1 AS `proveedor`,
 1 AS `responsable_prov`,
 1 AS `ext_responsable_banamex_prov`,
 1 AS `lada_cel_responsable_prov`,
 1 AS `cel_responsable_prov`,
 1 AS `email_responsable_bnmx_prov`,
 1 AS `lada_otro_responsable_prov`,
 1 AS `tel_otro_responsable_prov`,
 1 AS `email_responsable_prov`,
 1 AS `backup_prov`,
 1 AS `ext_backup_banamex_prov`,
 1 AS `lada_cel_backup_prov`,
 1 AS `cel_backup_prov`,
 1 AS `email_backup_bnmx_prov`,
 1 AS `lada_otro_backup_prov`,
 1 AS `tel_otro_backup_prov`,
 1 AS `email_backup_prov`,
 1 AS `lider_prov`,
 1 AS `ext_lider_banamex_prov`,
 1 AS `lada_cel_lider_prov`,
 1 AS `cel_lider_prov`,
 1 AS `email_lider_bnmx_prov`,
 1 AS `lada_otro_lider_prov`,
 1 AS `tel_otro_lider_prov`,
 1 AS `email_lider_prov`,
 1 AS `p_manager_prov`,
 1 AS `ext_p_manager_banamex_prov`,
 1 AS `lada_cel_p_manager_prov`,
 1 AS `cel_p_manager_prov`,
 1 AS `email_p_manager_bnmx_prov`,
 1 AS `lada_otro_p_manager_prov`,
 1 AS `tel_otro_p_manager_prov`,
 1 AS `email_p_manager_prov`,
 1 AS `d_manager_prov`,
 1 AS `ext_d_manager_banamex_prov`,
 1 AS `lada_cel_d_manager_prov`,
 1 AS `cel_d_manager_prov`,
 1 AS `email_d_manager_bnmx_prov`,
 1 AS `lada_otro_d_manager_prov`,
 1 AS `tel_otro_d_manager_prov`,
 1 AS `email_d_manager_prov`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `detailsl3application`
--

DROP TABLE IF EXISTS `detailsl3application`;
/*!50001 DROP VIEW IF EXISTS `detailsl3application`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `detailsl3application` AS SELECT 
 1 AS `idApp`,
 1 AS `dominio`,
 1 AS `L3`,
 1 AS `analista_bnmx`,
 1 AS `ext_analista_bnmx`,
 1 AS `celular_analista_bnmx`,
 1 AS `email_analista_bnmx`,
 1 AS `lider_bnmx`,
 1 AS `ext_lider_bnmx`,
 1 AS `celular_lider_bnmx`,
 1 AS `email_lider_bnmx`,
 1 AS `gerente_bnmx`,
 1 AS `ext_gerente_bnmx`,
 1 AS `celular_gerente_bnmx`,
 1 AS `email_gerente_bnmx`,
 1 AS `proveedor`,
 1 AS `responsable_prov`,
 1 AS `ext_responsable_banamex_prov`,
 1 AS `lada_cel_responsable_prov`,
 1 AS `cel_responsable_prov`,
 1 AS `email_responsable_bnmx_prov`,
 1 AS `lada_otro_responsable_prov`,
 1 AS `tel_otro_responsable_prov`,
 1 AS `email_responsable_prov`,
 1 AS `backup_prov`,
 1 AS `ext_backup_banamex_prov`,
 1 AS `lada_cel_backup_prov`,
 1 AS `cel_backup_prov`,
 1 AS `email_backup_bnmx_prov`,
 1 AS `lada_otro_backup_prov`,
 1 AS `tel_otro_backup_prov`,
 1 AS `email_backup_prov`,
 1 AS `lider_prov`,
 1 AS `ext_lider_banamex_prov`,
 1 AS `lada_cel_lider_prov`,
 1 AS `cel_lider_prov`,
 1 AS `email_lider_bnmx_prov`,
 1 AS `lada_otro_lider_prov`,
 1 AS `tel_otro_lider_prov`,
 1 AS `email_lider_prov`,
 1 AS `p_manager_prov`,
 1 AS `ext_p_manager_banamex_prov`,
 1 AS `lada_cel_p_manager_prov`,
 1 AS `cel_p_manager_prov`,
 1 AS `email_p_manager_bnmx_prov`,
 1 AS `lada_otro_p_manager_prov`,
 1 AS `tel_otro_p_manager_prov`,
 1 AS `email_p_manager_prov`,
 1 AS `d_manager_prov`,
 1 AS `ext_d_manager_banamex_prov`,
 1 AS `lada_cel_d_manager_prov`,
 1 AS `cel_d_manager_prov`,
 1 AS `email_d_manager_bnmx_prov`,
 1 AS `lada_otro_d_manager_prov`,
 1 AS `tel_otro_d_manager_prov`,
 1 AS `email_d_manager_prov`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `L1APLICACION`
--

DROP TABLE IF EXISTS `L1APLICACION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `L1APLICACION` (
   `idAplicacionCiti` int(11) NOT NULL,
   `idAnalistaRCiti` varchar(7) DEFAULT NULL,
   `idLiderRCiti` varchar(7) DEFAULT NULL,
   `idGerenteRCiti` varchar(7) DEFAULT NULL,
   `idResponsableRProveedor` int(11) DEFAULT NULL,
   `idBackupRProveedor` int(11) DEFAULT NULL,
   `idLiderRProveedor` int(11) DEFAULT NULL,
   `idProjectManagerRProveedor` int(11) DEFAULT NULL,
   `idDeliveryManagerRProveedor` int(11) DEFAULT NULL,
   PRIMARY KEY (`idAplicacionCiti`),
   KEY `fk_L1Aplicacion_recurso_proveedor1_idx` (`idResponsableRProveedor`),
   KEY `fk_L1Aplicacion_recurso_citi1_idx` (`idAnalistaRCiti`),
   KEY `fk_L1Aplicacion_recurso_citi2_idx` (`idLiderRCiti`),
   KEY `fk_L1Aplicacion_recurso_citi3_idx` (`idGerenteRCiti`),
   KEY `fk_L1Aplicacion_recurso_proveedor2_idx` (`idBackupRProveedor`),
   KEY `fk_L1Aplicacion_recurso_proveedor3_idx` (`idLiderRProveedor`),
   KEY `fk_L1Aplicacion_recurso_proveedor4_idx` (`idProjectManagerRProveedor`),
   KEY `fk_L1Aplicacion_recurso_proveedor5_idx` (`idDeliveryManagerRProveedor`),
   CONSTRAINT `fk_L1Aplicacion_aplicacion` FOREIGN KEY (`idAplicacionCiti`) REFERENCES `APLICACION` (`Csi_Id`) ON DELETE CASCADE ON UPDATE NO ACTION
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40000 ALTER TABLE `l1aplicacion` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `nearshore`.`l1aplicacion_AFTER_INSERT` AFTER INSERT ON L1APLICACION FOR EACH ROW
BEGIN
	INSERT INTO RECURSOPROVEEDOR_APLICACION (idAplicacion, descripcion, nivel)
    SELECT idAplicacionCiti,'Responsable',1 FROM L1APLICACION WHERE idAplicacionCiti = NEW.idAplicacionCiti;
    
    INSERT INTO RECURSOPROVEEDOR_APLICACION (idAplicacion, descripcion, nivel)
    SELECT idAplicacionCiti,'Backup',1 FROM L1APLICACION WHERE idAplicacionCiti = NEW.idAplicacionCiti;
    
    INSERT INTO RECURSOPROVEEDOR_APLICACION (idAplicacion, descripcion, nivel)
    SELECT idAplicacionCiti,'Lider',1 FROM L1APLICACION WHERE idAplicacionCiti = NEW.idAplicacionCiti;
    
    INSERT INTO RECURSOPROVEEDOR_APLICACION (idAplicacion, descripcion, nivel)
    SELECT idAplicacionCiti,'ProjectManager',1 FROM L1APLICACION WHERE idAplicacionCiti = NEW.idAplicacionCiti;
    
    INSERT INTO RECURSOPROVEEDOR_APLICACION (idAplicacion, descripcion, nivel)
    SELECT idAplicacionCiti,'DeliveryManager',1 FROM L1APLICACION WHERE idAplicacionCiti = NEW.idAplicacionCiti;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `nearshore`.`l1aplicacion_AFTER_UPDATE` AFTER UPDATE ON `L1APLICACION` FOR EACH ROW
BEGIN	
	DECLARE my_resp VARCHAR(16);
    DECLARE id_app INT(11);
	SELECT idResponsableRProveedor,idAplicacionCiti FROM L1APLICACION WHERE idResponsableRProveedor=NEW.idResponsableRProveedor INTO
	my_resp,id_app;
	UPDATE RECURSOPROVEEDOR_APLICACION SET idRecursoProveedor= (SELECT idResponsableRProveedor FROM L1APLICACION WHERE idResponsableRProveedor=NEW.idResponsableRProveedor) 
    where descripcion='Responsable' and nivel=1 and idAplicacion=id_app;
    
    SELECT idResponsableRProveedor,idAplicacionCiti FROM L1APLICACION WHERE idResponsableRProveedor=NEW.idResponsableRProveedor INTO
	my_resp,id_app;
	UPDATE RECURSOPROVEEDOR_APLICACION SET idRecursoProveedor= (SELECT idBackupRProveedor FROM L1APLICACION WHERE idBackupRProveedor=NEW.idBackupRProveedor) 
    where descripcion='Backup' and nivel=1 and idAplicacion=id_app;
    
    SELECT idResponsableRProveedor,idAplicacionCiti FROM L1APLICACION WHERE idResponsableRProveedor=NEW.idResponsableRProveedor INTO
	my_resp,id_app;
	UPDATE RECURSOPROVEEDOR_APLICACION SET idRecursoProveedor= (SELECT idLiderRProveedor FROM L1APLICACION WHERE idLiderRProveedor=NEW.idLiderRProveedor) 
    where descripcion='Lider' and nivel=1 and idAplicacion=id_app;
    
    SELECT idResponsableRProveedor,idAplicacionCiti FROM L1APLICACION WHERE idResponsableRProveedor=NEW.idResponsableRProveedor INTO
	my_resp,id_app;
	UPDATE RECURSOPROVEEDOR_APLICACION SET idRecursoProveedor= (SELECT idProjectManagerRProveedor FROM L1APLICACION WHERE idProjectManagerRProveedor=NEW.idProjectManagerRProveedor) 
    where descripcion='ProjectManager' and nivel=1 and idAplicacion=id_app;
    
    SELECT idResponsableRProveedor,idAplicacionCiti FROM L1APLICACION WHERE idResponsableRProveedor=NEW.idResponsableRProveedor INTO
	my_resp,id_app;
	UPDATE RECURSOPROVEEDOR_APLICACION SET idRecursoProveedor= (SELECT idDeliveryManagerRProveedor FROM L1APLICACION WHERE idDeliveryManagerRProveedor=NEW.idDeliveryManagerRProveedor) 
    where descripcion='DeliveryManager' and nivel=1 and idAplicacion=id_app;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `L2APLICACION`
--

DROP TABLE IF EXISTS `L2APLICACION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `L2APLICACION` (
   `idAplicacionCiti` int(11) NOT NULL,
   `idAnalistaRCiti` varchar(7) DEFAULT NULL,
   `idLiderRCiti` varchar(7) DEFAULT NULL,
   `idGerenteRCiti` varchar(7) DEFAULT NULL,
   `idResponsableRProveedor` int(11) DEFAULT NULL,
   `idBackupRProveedor` int(11) DEFAULT NULL,
   `idLiderRProveedor` int(11) DEFAULT NULL,
   `idProjectManagerRProveedor` int(11) DEFAULT NULL,
   `idDeliveryManagerRProveedor` int(11) DEFAULT NULL,
   PRIMARY KEY (`idAplicacionCiti`),
   CONSTRAINT `fk_L2Aplicacion_aplicacion1` FOREIGN KEY (`idAplicacionCiti`) REFERENCES `APLICACION` (`Csi_Id`) ON DELETE CASCADE ON UPDATE NO ACTION
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `L2APLICACION`
--

LOCK TABLES `L2APLICACION` WRITE;
/*!40000 ALTER TABLE `L2APLICACION` DISABLE KEYS */;
/*!40000 ALTER TABLE `L2APLICACION` ENABLE KEYS */;
UNLOCK TABLES;
/*!40000 ALTER TABLE `l2aplicacion` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `nearshore`.`l2aplicacion_AFTER_INSERT` AFTER INSERT ON `L2APLICACION` FOR EACH ROW
BEGIN
	INSERT INTO RECURSOPROVEEDOR_APLICACION (idAplicacion, descripcion, nivel)
    SELECT idAplicacionCiti,'Responsable',2 FROM L1APLICACION WHERE idAplicacionCiti = NEW.idAplicacionCiti;
    
    INSERT INTO RECURSOPROVEEDOR_APLICACION (idAplicacion, descripcion, nivel)
    SELECT idAplicacionCiti,'Backup',2 FROM L1APLICACION WHERE idAplicacionCiti = NEW.idAplicacionCiti;
    
    INSERT INTO RECURSOPROVEEDOR_APLICACION (idAplicacion, descripcion, nivel)
    SELECT idAplicacionCiti,'Lider',2 FROM L1APLICACION WHERE idAplicacionCiti = NEW.idAplicacionCiti;
    
    INSERT INTO RECURSOPROVEEDOR_APLICACION (idAplicacion, descripcion, nivel)
    SELECT idAplicacionCiti,'ProjectManager',2 FROM L1APLICACION WHERE idAplicacionCiti = NEW.idAplicacionCiti;
    
    INSERT INTO RECURSOPROVEEDOR_APLICACION (idAplicacion, descripcion, nivel)
    SELECT idAplicacionCiti,'DeliveryManager',2 FROM L1APLICACION WHERE idAplicacionCiti = NEW.idAplicacionCiti;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `nearshore`.`l2aplicacion_AFTER_UPDATE` AFTER UPDATE ON `L2APLICACION` FOR EACH ROW
BEGIN
	DECLARE my_resp VARCHAR(16);
    DECLARE id_app INT(11);
	SELECT idResponsableRProveedor,idAplicacionCiti FROM L2APLICACION WHERE idResponsableRProveedor=NEW.idResponsableRProveedor INTO
	my_resp,id_app;
	UPDATE RECURSOPROVEEDOR_APLICACION SET idRecursoProveedor= (SELECT idResponsableRProveedor FROM L2APLICACION WHERE idResponsableRProveedor=NEW.idResponsableRProveedor) 
    where descripcion='Responsable' and nivel=2 and idAplicacion=id_app;
    
    SELECT idResponsableRProveedor,idAplicacionCiti FROM L2APLICACION WHERE idResponsableRProveedor=NEW.idResponsableRProveedor INTO
	my_resp,id_app;
	UPDATE RECURSOPROVEEDOR_APLICACION SET idRecursoProveedor= (SELECT idBackupRProveedor FROM L2APLICACION WHERE idBackupRProveedor=NEW.idBackupRProveedor) 
    where descripcion='Backup' and nivel=2 and idAplicacion=id_app;
    
    SELECT idResponsableRProveedor,idAplicacionCiti FROM L2APLICACION WHERE idResponsableRProveedor=NEW.idResponsableRProveedor INTO
	my_resp,id_app;
	UPDATE RECURSOPROVEEDOR_APLICACION SET idRecursoProveedor= (SELECT idLiderRProveedor FROM L2APLICACION WHERE idLiderRProveedor=NEW.idLiderRProveedor) 
    where descripcion='Lider' and nivel=2 and idAplicacion=id_app;
    
    SELECT idResponsableRProveedor,idAplicacionCiti FROM L2APLICACION WHERE idResponsableRProveedor=NEW.idResponsableRProveedor INTO
	my_resp,id_app;
	UPDATE RECURSOPROVEEDOR_APLICACION SET idRecursoProveedor= (SELECT idProjectManagerRProveedor FROM L2APLICACION WHERE idProjectManagerRProveedor=NEW.idProjectManagerRProveedor) 
    where descripcion='ProjectManager' and nivel=2 and idAplicacion=id_app;
    
    SELECT idResponsableRProveedor,idAplicacionCiti FROM L2APLICACION WHERE idResponsableRProveedor=NEW.idResponsableRProveedor INTO
	my_resp,id_app;
	UPDATE RECURSOPROVEEDOR_APLICACION SET idRecursoProveedor= (SELECT idDeliveryManagerRProveedor FROM L2APLICACION WHERE idDeliveryManagerRProveedor=NEW.idDeliveryManagerRProveedor) 
    where descripcion='DeliveryManager' and nivel=2 and idAplicacion=id_app;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
--
-- Table structure for table `L3APLICACION`
--

DROP TABLE IF EXISTS `L3APLICACION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `L3APLICACION` (
   `idAplicacionCiti` int(11) NOT NULL,
   `idAnalistaRCiti` varchar(7) DEFAULT NULL,
   `idLiderRCiti` varchar(7) DEFAULT NULL,
   `idGerenteRCiti` varchar(7) DEFAULT NULL,
   `idResponsableRProveedor` int(11) DEFAULT NULL,
   `idBackupRProveedor` int(11) DEFAULT NULL,
   `idLiderRProveedor` int(11) DEFAULT NULL,
   `idProjectManagerRProveedor` int(11) DEFAULT NULL,
   `idDeliveryManagerRProveedor` int(11) DEFAULT NULL,
   PRIMARY KEY (`idAplicacionCiti`),
   CONSTRAINT `fk_L3Aplicacion_aplicacion1` FOREIGN KEY (`idAplicacionCiti`) REFERENCES `APLICACION` (`Csi_Id`) ON DELETE CASCADE ON UPDATE NO ACTION
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `L3APLICACION`
--

LOCK TABLES `L3APLICACION` WRITE;
/*!40000 ALTER TABLE `L3APLICACION` DISABLE KEYS */;
/*!40000 ALTER TABLE `L3APLICACION` ENABLE KEYS */;
UNLOCK TABLES;
/*!40000 ALTER TABLE `l3aplicacion` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `nearshore`.`l3aplicacion_AFTER_INSERT` AFTER INSERT ON `L3APLICACION` FOR EACH ROW
BEGIN
	INSERT INTO RECURSOPROVEEDOR_APLICACION (idAplicacion, descripcion, nivel)
    SELECT idAplicacionCiti,'Responsable',3 FROM L1APLICACION WHERE idAplicacionCiti = NEW.idAplicacionCiti;
    
    INSERT INTO RECURSOPROVEEDOR_APLICACION (idAplicacion, descripcion, nivel)
    SELECT idAplicacionCiti,'Backup',3 FROM L1APLICACION WHERE idAplicacionCiti = NEW.idAplicacionCiti;
    
    INSERT INTO RECURSOPROVEEDOR_APLICACION (idAplicacion, descripcion, nivel)
    SELECT idAplicacionCiti,'Lider',3 FROM L1APLICACION WHERE idAplicacionCiti = NEW.idAplicacionCiti;
    
    INSERT INTO RECURSOPROVEEDOR_APLICACION (idAplicacion, descripcion, nivel)
    SELECT idAplicacionCiti,'ProjectManager',3 FROM L1APLICACION WHERE idAplicacionCiti = NEW.idAplicacionCiti;
    
    INSERT INTO RECURSOPROVEEDOR_APLICACION (idAplicacion, descripcion, nivel)
    SELECT idAplicacionCiti,'DeliveryManager',3 FROM L1APLICACION WHERE idAplicacionCiti = NEW.idAplicacionCiti;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `nearshore`.`l3aplicacion_AFTER_UPDATE` AFTER UPDATE ON `L3APLICACION` FOR EACH ROW
BEGIN
	DECLARE my_resp VARCHAR(16);
    DECLARE id_app INT(11);
	SELECT idResponsableRProveedor,idAplicacionCiti FROM L3APLICACION WHERE idResponsableRProveedor=NEW.idResponsableRProveedor INTO
	my_resp,id_app;
	UPDATE RECURSOPROVEEDOR_APLICACION SET idRecursoProveedor= (SELECT idResponsableRProveedor FROM L3APLICACION WHERE idResponsableRProveedor=NEW.idResponsableRProveedor) 
    where descripcion='Responsable' and nivel=3 and idAplicacion=id_app;
    
    SELECT idResponsableRProveedor,idAplicacionCiti FROM L3APLICACION WHERE idResponsableRProveedor=NEW.idResponsableRProveedor INTO
	my_resp,id_app;
	UPDATE RECURSOPROVEEDOR_APLICACION SET idRecursoProveedor= (SELECT idBackupRProveedor FROM L3APLICACION WHERE idBackupRProveedor=NEW.idBackupRProveedor) 
    where descripcion='Backup' and nivel=3 and idAplicacion=id_app;
    
    SELECT idResponsableRProveedor,idAplicacionCiti FROM L3APLICACION WHERE idResponsableRProveedor=NEW.idResponsableRProveedor INTO
	my_resp,id_app;
	UPDATE RECURSOPROVEEDOR_APLICACION SET idRecursoProveedor= (SELECT idLiderRProveedor FROM L3APLICACION WHERE idLiderRProveedor=NEW.idLiderRProveedor) 
    where descripcion='Lider' and nivel=3 and idAplicacion=id_app;
    
    SELECT idResponsableRProveedor,idAplicacionCiti FROM L3APLICACION WHERE idResponsableRProveedor=NEW.idResponsableRProveedor INTO
	my_resp,id_app;
	UPDATE RECURSOPROVEEDOR_APLICACION SET idRecursoProveedor= (SELECT idProjectManagerRProveedor FROM L3APLICACION WHERE idProjectManagerRProveedor=NEW.idProjectManagerRProveedor) 
    where descripcion='ProjectManager' and nivel=3 and idAplicacion=id_app;
    
    SELECT idResponsableRProveedor,idAplicacionCiti FROM L3APLICACION WHERE idResponsableRProveedor=NEW.idResponsableRProveedor INTO
	my_resp,id_app;
	UPDATE RECURSOPROVEEDOR_APLICACION SET idRecursoProveedor= (SELECT idDeliveryManagerRProveedor FROM L3APLICACION WHERE idDeliveryManagerRProveedor=NEW.idDeliveryManagerRProveedor) 
    where descripcion='DeliveryManager' and nivel=3 and idAplicacion=id_app;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
--
-- Table structure for table `RECURSO_CITI`
--

DROP TABLE IF EXISTS `RECURSO_CITI`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `RECURSO_CITI` (
  `Soe_Id` varchar(7) NOT NULL,
  `Apellido_Paterno` varchar(45) NOT NULL,
  `Apellido_Materno` varchar(45) DEFAULT NULL,
  `Primer_Nombre` varchar(45) NOT NULL,
  `Segundo_Nombre` varchar(45) DEFAULT '',
  `Id_Dominio` int(11) DEFAULT NULL,
  `Id_Puesto` int(11) DEFAULT NULL,
  `Id_Ciudad` int(11) DEFAULT NULL,
  `Ext` varchar(10) DEFAULT '',
  `Movil` varchar(10) DEFAULT '',
  `Telefono` varchar(10) DEFAULT '',
  `Email` varchar(60) DEFAULT '',
  `Id_ReportaA` varchar(7) DEFAULT NULL,
  `Comentarios` varchar(2000) DEFAULT '',
  PRIMARY KEY (`Soe_Id`),
  KEY `fk_CatDominio_RecursoCiti_Dominio_idx` (`Id_Dominio`),
  KEY `fk_CatpuestoCiti_IdPuesto_idx` (`Id_Puesto`),
  KEY `fk_CatCiudad_Id_Ciudad_idx` (`Id_Ciudad`),
  KEY `fk_RecursoCiti_RecursoCiti_idx` (`Id_ReportaA`),
  CONSTRAINT `fk_CAT_CIUDAD_RECURSO_CITI` FOREIGN KEY (`Id_Ciudad`) REFERENCES `CAT_CIUDAD` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_CAT_DOMINIO_RECURSO_CITI` FOREIGN KEY (`Id_Dominio`) REFERENCES `CAT_DOMINIO` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_CAT_PUESTOCITI_RECURSO_CITI` FOREIGN KEY (`Id_Puesto`) REFERENCES `CAT_PUESTOCITI` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_RECURSO_CITIi_RECURSO_CITI` FOREIGN KEY (`Id_ReportaA`) REFERENCES `RECURSO_CITI` (`Soe_Id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RECURSO_CITI`
--

LOCK TABLES `RECURSO_CITI` WRITE;
/*!40000 ALTER TABLE `RECURSO_CITI` DISABLE KEYS */;
INSERT INTO `RECURSO_CITI` (`Soe_Id`, `Apellido_Paterno`, `Apellido_Materno`, `Primer_Nombre`, `Segundo_Nombre`, `Id_Dominio`, `Id_Puesto`, `Id_Ciudad`, `Ext`, `Movil`, `Telefono`, `Email`, `Id_ReportaA`, `Comentarios`) VALUES ('GC37337','Flores','Rodriguez','Josefina','',6,5,5,'12345','339876543','1212345678','josefina.flores@citibanamex.com',NULL,'Usa mucho el pacman'),('JP12345','Perez','Perez','Juan','',1,1,5,'23456','5586978566',NULL,'juan.perezperez@citi.com','JP12345','Es Analista.'),('RS23323','Arrollo','Luna','Alberto','',2,2,5,'12234','5520708798',NULL,'rodolfo.sanvicenteatilano@citi.com','RS23323','Se reporta asi mismo.');
/*!40000 ALTER TABLE `RECURSO_CITI` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RECURSO_PROVEEDOR`
--

DROP TABLE IF EXISTS `RECURSO_PROVEEDOR`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `RECURSO_PROVEEDOR` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Id_Proveedor` int(11) NOT NULL,
  `Clave_Empleado` int(11) NOT NULL,
  `Apellido_Paterno` varchar(45) NOT NULL,
  `Apellido_Materno` varchar(45) DEFAULT '',
  `Primer_Nombre` varchar(45) NOT NULL,
  `Segundo_Nombre` varchar(45) DEFAULT '',
  `LD_celular` varchar(3) DEFAULT '',
  `Movil_Personal` varchar(8) DEFAULT '',
  `LD_particular` varchar(3) DEFAULT '',
  `Telefono_Particular` varchar(8) DEFAULT '',
  `Email_Personal` varchar(60) DEFAULT '',
  `Id_Puesto` int(11) DEFAULT NULL,
  `Id_Ciudad` int(11) DEFAULT NULL,
  `LD_Proveedor` varchar(3) DEFAULT '',
  `Telefono_Proveedor` varchar(8) DEFAULT '',
  `Ext_Proveedor` varchar(10) DEFAULT '',
  `Email_Proveedor` varchar(60) DEFAULT '',
  `Soe_Id` varchar(7) DEFAULT '',
  `LD_Citi` varchar(3) DEFAULT '',
  `Telefono_citi` varchar(10) DEFAULT '',
  `Ext_Citi` varchar(10) DEFAULT '',
  `Email_Citi` varchar(60) DEFAULT '',
  `Id_Reporta_A` int(11) DEFAULT NULL,
  `Comentarios` varchar(2000) DEFAULT '',
  PRIMARY KEY (`Id`),
  UNIQUE KEY `Clave_Empleado_UNIQUE` (`Clave_Empleado`),
  KEY `fk_CAT_PROVEEDOR_RECURSOS_PROVEEDOR_idx` (`Id_Proveedor`),
  KEY `fk_CAT_CIUDAD_RECURSOS_PROVEEDOR_idx` (`Id_Ciudad`),
  KEY `fk_CAT_PUESTO_PROVEEDOR_RECURSOS_PROVEEDOR_idx` (`Id_Puesto`),
  CONSTRAINT `fk_CAT_CIUDAD_RECURSO_PROVEEDOR` FOREIGN KEY (`Id_Ciudad`) REFERENCES `CAT_CIUDAD` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_CAT_PROVEEDOR_RECURSO_PROVEEDOR` FOREIGN KEY (`Id_Proveedor`) REFERENCES `CAT_PROVEEDOR` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_CAT_PUESTO_PROVEEDOR_RECURSO_PROVEEDOR` FOREIGN KEY (`Id_Puesto`) REFERENCES `CAT_PUESTO_PROVEEDOR` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RECURSO_PROVEEDOR`
--

LOCK TABLES `RECURSO_PROVEEDOR` WRITE;
/*!40000 ALTER TABLE `RECURSO_PROVEEDOR` DISABLE KEYS */;
INSERT INTO `RECURSO_PROVEEDOR` (`Id`, `Id_Proveedor`, `Clave_Empleado`, `Apellido_Paterno`, `Apellido_Materno`, `Primer_Nombre`, `Segundo_Nombre`, `LD_celular`, `Movil_Personal`, `LD_particular`, `Telefono_Particular`, `Email_Personal`, `Id_Puesto`, `Id_Ciudad`, `LD_Proveedor`, `Telefono_Proveedor`, `Ext_Proveedor`, `Email_Proveedor`, `Soe_Id`, `LD_Citi`, `Telefono_citi`, `Ext_Citi`, `Email_Citi`, `Id_Reporta_A`, `Comentarios`) VALUES (1,1,10004057,'Cauich','Lemus','Gerardo','','55','12345678','','','gcauich@anzen.com.mx',3,5,'','22334455','2323','gcauich@anzen.com.mx','GC37337','','','','gerardo.cauichlemus@citibanamex.com',10003328,'Usa mucho el pacman en sus comentarios. :v'),(2,1,10003328,'San Vicente','Atilano','Rodolfo','','55','20708798','','','rodolof@gmail.com',1,5,'','22334455','2323','rsanvicente@anzen.com.mx','RS23233','','','1111','rodolfo.sanvicenteatilano@citi.com',10003328,'Sin comentarios.'),(3,1,10004934,'Junco','Lozano','Jose','Luis','55','11446688','','','junco@gmail.com',3,5,'','22334455','2323','jjunco@anzen.com','','','','','',10003328,'sin comentarios.'),(4,1,10004623,'Ramirez','Morales','David ','Jesus','55','61327653','','','david@gmail.com',2,5,'','22334455','2323','dramirez@anzen.com','','','','','',10003328,':v'),(5,1,10004542,'Valles','Garcia','Dionisio','Javier','49','29051270','33','41606007','dionisio@gmail.com',4,5,'','22334455','2324','dvalles@anzen.com.mx','DV06619','','','','dionisio.javier.vallesgarcia@citibanamex.com',10003328,''),(6,1,30000012,'Castelan','Silva','Jose','Alfredo','','','','','jose@gmail.com',9,5,'','22334455','2322','jcastelan@anzen.com.mx','','','','','',10003328,' '),(7,1,10003364,'Claudio','Ramirez','Octavio','','55','61234995','','','octavio@hotmail.com',11,5,'','22334455','1122','oclaudio@anzen.com.mx','OC37210','','','','octavio.clauidoramirez@citi.com',10003328,' '),(8,1,10003638,'Coronel ','Cruz','Miguel ','Angel ','55','28613618','','','miguelyahoo.com',10,5,'','22334455','1234','mcoronel@anzen.com.mx','MC67168','','','','miguel.angel.coronelcruz@citibanamex.com',10003328,' '),(9,1,30000007,'Cruz ','Hernandez','Jesus','','','','','','jesusqgmail.com',10,5,'','22334455','','jesuscruz@anzen.com.mx','JC35998','',' ','','jesus1.cruzhernandez@citi.com',10003328,' '),(10,1,10004545,'Cruz ','Ramirez','Isai ','','','','','','isai@hotmail.com',10,5,'','22334455','','icruz@anzen.com.mx','IC14344','',' ','','isaia.cruzramirez@citi.com',10003328,' '),(11,1,10003687,'De la Rosa ','Bonilla ','Mayetzi ','','55','23346566','23','22260575','mayetzi@outlook.com',11,5,'','22334455','','mdelarosa@anzen.com.mx','MD97674','',' ','','mayetzi.delarosabonilla@banamex.com',10003328,'  '),(12,1,10003484,'Dominguez','Garcia','Victor','Manuel','55','18299093','','','victor@gmail.com',11,5,'','22334455','','vdominguez@anzen.com.mx','VD96207','',' ','','victor.manuel.dominguezgarcia@citi.com',10003328,' '),(13,1,10003629,'Flores','Zamora','Guillermo','','','','33','41606000','g.zamora@gmail.com',10,7,'','22334455','','guillermoflores@anzen.com.mx','GF58868','',' ','','guillermo.floreszamora@citibanamex.com',10003328,' '),(14,1,10003397,'Franco','Tellez','Michel','Geovanni','','','','','michel@yahoo.com.mx',13,5,'','22334455','','mfranco@anzen.com.mx','MF37396','','',' ','michel.giovanni.francotellez@citibanamex.com',10003355,' '),(15,1,10003919,'Jasso','Zaragoza','Adriana','Victoria','','','','','adriana@gmail.com',10,5,'','22334455','','ajasso@anzen.com.mx','','','',' ','',10003354,' '),(16,1,10003453,'Garduño ','Cruz','Erika','Viridiana','55','38562953','22','22260563','erika@gmail.com',14,5,'','22334455','','egarduno@anzen.com.mx','EG37380','','','','erika.viridiana.garduñocruz@banamex.com',10003354,'  '),(17,4,10003358,'Srinivasan','Perez','Vadivel','','99','24234234','','','vadi@gmail.com',10,5,'','88888888','','srinivasan.vadivel@wipro.com','','','','','',11111111,' '),(18,4,12930405,'Algo','Algo','Param','','99','23423133','','','param@gmail.com',3,5,'','88888888','','param@wipro.com','','','','','',11111111,' '),(19,4,21232134,'apellido','segundoAp','Kupurash','','99','23423423','','','kupu@gmail.com',9,5,'','88888888','','kupurash@wipro.com','','','','','',11111111,' '),(20,4,11111111,'qwerty','qwertyu','Satish','','99','23652443','','','satish@gmail.com',4,5,'','88888888','','satish@wipro.com','','','','','',11111111,' '),(21,4,23476873,'asdfg','asdfgh','Atul','','99','23651423','','','atul@gmail.com',15,5,'','88888888','','','','','','','',11111111,' ');
/*!40000 ALTER TABLE `RECURSO_PROVEEDOR` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RECURSOCITI_APLICACION`
--

DROP TABLE IF EXISTS `RECURSOCITI_APLICACION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `RECURSOCITI_APLICACION` (
  `idRecursoCiti` varchar(7) NOT NULL,
  `idAplicacion` int(11) NOT NULL,
  PRIMARY KEY (`idRecursoCiti`,`idAplicacion`),
  KEY `fk_recursociti_aplicacion_aplicacion1_idx` (`idAplicacion`),
  CONSTRAINT `fk_recursociti_aplicacion_aplicacion1` FOREIGN KEY (`idAplicacion`) REFERENCES `APLICACION` (`Csi_Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_recursociti_aplicacion_recurso_citi` FOREIGN KEY (`idRecursoCiti`) REFERENCES `RECURSO_CITI` (`Soe_Id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RECURSOCITI_APLICACION`
--

LOCK TABLES `RECURSOCITI_APLICACION` WRITE;
/*!40000 ALTER TABLE `RECURSOCITI_APLICACION` DISABLE KEYS */;
INSERT INTO `RECURSOCITI_APLICACION` (`idRecursoCiti`, `idAplicacion`) VALUES ('GC37337',1),('JP12345',1),('RS23323',1),('GC37337',2),('RS23323',3);
/*!40000 ALTER TABLE `RECURSOCITI_APLICACION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RECURSOPROVEEDOR_APLICACION`
--

DROP TABLE IF EXISTS `RECURSOPROVEEDOR_APLICACION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `RECURSOPROVEEDOR_APLICACION` (
  `idRecursoProveedor` int(11) DEFAULT NULL,
   `idAplicacion` int(11) NOT NULL,
   `descripcion` varchar(16) NOT NULL,
   `nivel` tinyint(1) NOT NULL,
   PRIMARY KEY (`idAplicacion`,`descripcion`,`nivel`),
   CONSTRAINT `fk_recursoproveedor_aplicacion_aplicacion1_idx` FOREIGN KEY (`idAplicacion`) REFERENCES `APLICACION` (`Csi_Id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RECURSOPROVEEDOR_APLICACION`
--

LOCK TABLES `RECURSOPROVEEDOR_APLICACION` WRITE;
/*!40000 ALTER TABLE `RECURSOPROVEEDOR_APLICACION` DISABLE KEYS */;
INSERT INTO `RECURSOPROVEEDOR_APLICACION` (`idRecursoProveedor`, `idAplicacion`) VALUES (1,1),(2,1),(3,1),(4,1),(2,2),(3,2),(4,2);
/*!40000 ALTER TABLE `RECURSOPROVEEDOR_APLICACION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USUARIO`
--

DROP TABLE IF EXISTS `USUARIO`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `USUARIO` (
  `Id_Usuarios` int(11) NOT NULL AUTO_INCREMENT,
  `Email` varchar(60) NOT NULL,
  `Primer_Nombre` varchar(45) NOT NULL,
  `Segundo_Nombre` varchar(45) DEFAULT '',
  `Apellido_Paterno` varchar(45) NOT NULL,
  `ApellidoMaterno` varchar(45) DEFAULT '',
  `Clave` varchar(45) NOT NULL,
  `Id_Perfil` int(11) DEFAULT NULL,
  `Activo` tinyint(1) DEFAULT NULL,
  `Dominios` varchar(50) DEFAULT '',
  `Proveedores` varchar(50) DEFAULT '',
  PRIMARY KEY (`Id_Usuarios`),
  UNIQUE KEY `Email_UNIQUE` (`Email`),
  KEY `fk_CAT_PERFIL_USUARIO_idx` (`Id_Perfil`),
  CONSTRAINT `fk_CAT_PERFIL_USUARIO` FOREIGN KEY (`Id_Perfil`) REFERENCES `CAT_PERFIL` (`Id_Perfil`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USUARIO`
--

LOCK TABLES `USUARIO` WRITE;
/*!40000 ALTER TABLE `USUARIO` DISABLE KEYS */;
INSERT INTO `USUARIO` (`Id_Usuarios`, `Email`, `Primer_Nombre`, `Segundo_Nombre`, `Apellido_Paterno`, `ApellidoMaterno`, `Clave`, `Id_Perfil`, `Activo`, `Dominios`, `Proveedores`) VALUES (1,'kdk@ksk.cpom','Hector','','Lozoya','Perez','1234',1,1,'Canales Digitales','Banamex'),(2,'qwerty@gmail.com','Deibid','','Ramirez','Morales','1234',1,1,'Canales Digitales','Anzen'),(3,'qwerty1@anzen.com','Julio','','Contreras','Carrillo','1234',2,1,'Canales Digitales','Anzen'),(4,'qwerty2@anzen.com','Sergio','','Santana','Martinez','1234',3,1,'Canales Digitales','Anzen'),(5,'qwerty3@wipro.com','Isaac','','Vargas','Gonzales','1234',2,1,'Canales Digitales','Wipro'),(6,'qwerty4@wipro.com','Ammulu','','Addhanki','Addhanki','1234',2,1,'Canales Digitales','Wipro'),(9,'ptovar@anzen.com.mx','Pablo','Pablo','Tovar','Castrejón','1700000012',3,1,'5','1');
/*!40000 ALTER TABLE `USUARIO` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'nearshore2'
--

--
-- Dumping routines for database 'nearshore2'
--
/*!50003 DROP PROCEDURE IF EXISTS `paginationAllEmployesDomain` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `paginationAllEmployesDomain`(IN StartIndex INT,IN Count INT)
BEGIN
DECLARE LowerBound INT;
DECLARE UpperBound INT;
DECLARE rownum INT;
SET LowerBound = ((StartIndex - 1) * Count) + 1;
SET UpperBound = ((StartIndex - 1) * Count) + Count;

SELECT  (SELECT ceiling(count(*)/Count) FROM RECURSO_CITI RC INNER JOIN CAT_PUESTOCITI PC INNER JOIN CAT_DOMINIO D WHERE RC.Id_Puesto = PC.Id AND D.Id = RC.Id_Dominio) as pages,
        Soe_Id,
		concat( Primer_Nombre,' ', Segundo_Nombre, ' ', Apellido_Paterno, ' ', Apellido_Materno) as nombre,
		puesto,
        dominio,
        Id_Dominio
  FROM (SELECT *, @rownum := @rownum + 1 AS rank 
		FROM (SELECT 
				RC.Soe_Id,
                RC.Primer_Nombre, 
                RC.Segundo_Nombre,
                RC.Apellido_Paterno,
                RC.Apellido_Materno,
                PC.Descripcion as puesto,
                D.Descripcion as dominio,
                RC.Id_Dominio
				FROM RECURSO_CITI RC INNER JOIN 
                CAT_PUESTOCITI PC INNER JOIN 
                CAT_DOMINIO D 
                WHERE RC.Id_Puesto = PC.Id AND 
                D.Id = RC.Id_Dominio
				) d, (SELECT @rownum  := 0) r ) m
WHERE rank >= LowerBound AND rank <= UpperBound;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `paginationAplicationPerDomain` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `paginationAplicationPerDomain`(IN StartIndex INT,IN Count INT, IN _prov INT)
BEGIN
DECLARE LowerBound INT;
DECLARE UpperBound INT;
DECLARE rownum INT;
SET LowerBound = ((StartIndex - 1) * Count) + 1;
SET UpperBound = ((StartIndex - 1) * Count) + Count;

IF _prov = 0 THEN
		SELECT  (select count(distinct (aplic.CSI_ID))
					FROM 
					APLICACION aplic INNER JOIN 
					CAT_DOMINIO D
					WHERE 
					aplic.Id_Dominio = D.Id) as total,
			(select ceiling(count(distinct (aplic.CSI_ID))/Count) FROM 
					APLICACION aplic INNER JOIN 
					CAT_DOMINIO D
					WHERE 
					aplic.Id_Dominio = D.Id) as pages,
			CSI_ID,
			Descripcion_Corta,
			dominio
	  from (SELECT *, @rownum := @rownum + 1 AS rank 
			from (SELECT 
					distinct (aplic.CSI_ID),
					aplic.Descripcion_Corta,
					D.Descripcion as dominio 
					FROM 
					APLICACION aplic INNER JOIN 
					CAT_DOMINIO D
					WHERE 
					aplic.Id_Dominio = D.Id
					) d, (SELECT @rownum  := 0) r ) m
	WHERE rank >= LowerBound and rank <= UpperBound;
ELSE
	SELECT  (select count(distinct (aplic.CSI_ID))
                FROM 
                APLICACION aplic INNER JOIN 
                CAT_DOMINIO D  INNER JOIN APLICACION_PROVEEDOR AP ON
                AP.Csi_Id = aplic.Csi_Id
                WHERE 
                aplic.Id_Dominio = D.Id
                AND AP.Id_Proveedor = _prov) as total,
		(select ceiling(count(distinct (aplic.CSI_ID))/Count) FROM 
                APLICACION aplic INNER JOIN 
                CAT_DOMINIO D  INNER JOIN APLICACION_PROVEEDOR AP ON
                AP.Csi_Id = aplic.Csi_Id
                WHERE 
                aplic.Id_Dominio = D.Id
                AND AP.Id_Proveedor = _prov) as pages,
        CSI_ID,
        Descripcion_Corta,
        dominio
  from (SELECT *, @rownum := @rownum + 1 AS rank 
		from (SELECT 
				distinct (aplic.CSI_ID),
                aplic.Descripcion_Corta,
                D.Descripcion as dominio 
                FROM 
                APLICACION aplic INNER JOIN 
                CAT_DOMINIO D  INNER JOIN APLICACION_PROVEEDOR AP ON
                AP.Csi_Id = aplic.Csi_Id
                WHERE 
                aplic.Id_Dominio = D.Id
                AND AP.Id_Proveedor = _prov
				) d, (SELECT @rownum  := 0) r ) m
WHERE rank >= LowerBound and rank <= UpperBound;
END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `paginationAplicationPerIdDomain` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `paginationAplicationPerIdDomain`(IN StartIndex INT,IN Count INT, IN _Domain INT, IN _prov INT)
BEGIN
DECLARE LowerBound INT;
DECLARE UpperBound INT;
DECLARE rownum INT;
SET LowerBound = ((StartIndex - 1) * Count) + 1;
SET UpperBound = ((StartIndex - 1) * Count) + Count;

	IF _prov = 0 THEN
		SELECT  (SELECT count(*) FROM APLICACION aplic INNER JOIN CAT_DOMINIO D WHERE aplic.Id_Dominio = D.Id AND aplic.Id_Dominio = _Domain) as total,
				(SELECT ceiling(count(*)/Count) FROM APLICACION aplic INNER JOIN CAT_DOMINIO D WHERE aplic.Id_Dominio = D.Id AND aplic.Id_Dominio = _Domain) as pages,
				CSI_ID,
				Descripcion_Corta
		  FROM (SELECT *, @rownum := @rownum + 1 AS rank 
				FROM (SELECT 
						aplic.CSI_ID,
						aplic.Descripcion_Corta 
						FROM 
						APLICACION aplic INNER JOIN 
						CAT_DOMINIO D 
						WHERE 
						aplic.Id_Dominio = D.Id AND 
						aplic.Id_Dominio = _Domain
						) d, (SELECT @rownum  := 0) r ) m
		WHERE rank >= LowerBound AND rank <= UpperBound;
	ELSE
		SELECT  (SELECT count(distinct(aplic.CSI_ID)) FROM APLICACION aplic INNER JOIN 
						CAT_DOMINIO D INNER JOIN
						APLICACION_PROVEEDOR AP ON AP.Csi_Id = aplic.Csi_Id
						WHERE 
						aplic.Id_Dominio = D.Id AND 
						aplic.Id_Dominio = _Domain AND AP.Id_Proveedor = _prov) as total,
				(SELECT ceiling(count(distinct(aplic.CSI_ID))/Count) FROM APLICACION aplic INNER JOIN 
						CAT_DOMINIO D INNER JOIN
						APLICACION_PROVEEDOR AP ON AP.Csi_Id = aplic.Csi_Id
						WHERE 
						aplic.Id_Dominio = D.Id AND 
						aplic.Id_Dominio = _Domain AND AP.Id_Proveedor = _prov) as pages,
				CSI_ID,
				Descripcion_Corta
		  FROM (SELECT *, @rownum := @rownum + 1 AS rank 
				FROM (SELECT 
						distinct(aplic.CSI_ID),
						aplic.Descripcion_Corta 
						FROM 
						APLICACION aplic INNER JOIN 
						CAT_DOMINIO D INNER JOIN
						APLICACION_PROVEEDOR AP ON AP.Csi_Id = aplic.Csi_Id
						WHERE 
						aplic.Id_Dominio = D.Id AND 
						aplic.Id_Dominio = _Domain AND AP.Id_Proveedor = _prov
						) d, (SELECT @rownum  := 0) r ) m
		WHERE rank >= LowerBound AND rank <= UpperBound;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `paginationAppsByProviderEmploye` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `paginationAppsByProviderEmploye`(IN StartIndex INT,IN Count INT, IN _idEmployee INT)
BEGIN
DECLARE LowerBound INT;
DECLARE UpperBound INT;
DECLARE rownum INT;
SET LowerBound = ((StartIndex - 1) * Count) + 1;
SET UpperBound = ((StartIndex - 1) * Count) + Count;

SELECT 	(SELECT count(distinct A.Csi_Id) FROM 
                APLICACION A 
				INNER JOIN RECURSOPROVEEDOR_APLICACION RPA
				INNER JOIN RECURSO_PROVEEDOR RP
				WHERE 
				 RPA.idAplicacion = A.Csi_Id
				AND RP.Id = RPA.idRecursoProveedor 
				AND RPA.idRecursoProveedor = _idEmployee) as total,
		(SELECT ceiling(count(distinct A.Csi_Id)/Count) FROM 
                APLICACION A 
				INNER JOIN RECURSOPROVEEDOR_APLICACION RPA
				INNER JOIN RECURSO_PROVEEDOR RP
				WHERE 
				 RPA.idAplicacion = A.Csi_Id
				AND RP.Id = RPA.idRecursoProveedor 
				AND RPA.idRecursoProveedor = _idEmployee) as pages,
			idAplicacion,
			Descripcion_Corta
  from (SELECT *, @rownum := @rownum + 1 AS rank 
		from (SELECT distinct
				A.Csi_Id AS idAplicacion,
				A.Descripcion_Corta
				FROM 
                APLICACION A 
				INNER JOIN RECURSOPROVEEDOR_APLICACION RPA
				INNER JOIN RECURSO_PROVEEDOR RP
				WHERE 
				 RPA.idAplicacion = A.Csi_Id
				AND RP.Id = RPA.idRecursoProveedor 
				AND RPA.idRecursoProveedor = _idEmployee
				) d, (SELECT @rownum  := 0) r ) m
WHERE rank >= LowerBound and rank <= UpperBound;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `paginationAppsCitiEmploye` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `paginationAppsCitiEmploye`(IN StartIndex INT,IN Count INT, IN _soeId varchar(45))
BEGIN
DECLARE LowerBound INT;
DECLARE UpperBound INT;
DECLARE rownum INT;
SET LowerBound = ((StartIndex - 1) * Count) + 1;
SET UpperBound = ((StartIndex - 1) * Count) + Count;

SELECT 	(SELECT count(*) FROM APLICACION A INNER JOIN RECURSOCITI_APLICACION RCA INNER JOIN RECURSO_CITI RC WHERE A.Csi_Id = RCA.idAplicacion AND RCA.idRecursoCiti = RC.Soe_Id AND RCA.idRecursoCiti = _soeId) as total,
		(SELECT ceiling(count(*)/Count) FROM APLICACION A INNER JOIN RECURSOCITI_APLICACION RCA INNER JOIN RECURSO_CITI RC WHERE A.Csi_Id = RCA.idAplicacion AND RCA.idRecursoCiti = RC.Soe_Id AND RCA.idRecursoCiti = _soeId) as pages,
			idAplicacion, 
			descripcion 
  FROM (SELECT *, @rownum := @rownum + 1 AS rank 
		FROM (SELECT 
				A.Csi_Id AS idAplicacion, 
				A.Descripcion_Corta AS descripcion 
				FROM APLICACION A INNER JOIN 
				RECURSOCITI_APLICACION RCA INNER JOIN 
				RECURSO_CITI RC 
				WHERE 
				A.Csi_Id = RCA.idAplicacion AND 
				RCA.idRecursoCiti = RC.Soe_Id AND 
				RCA.idRecursoCiti = _soeId
				) d, (SELECT @rownum  := 0) r ) m
WHERE rank >= LowerBound AND rank <= UpperBound;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `paginationCitiEmployes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `paginationCitiEmployes`(IN StartIndex INT,IN Count INT)
BEGIN
DECLARE LowerBound INT;
DECLARE UpperBound INT;
DECLARE rownum INT;
SET LowerBound = ((StartIndex - 1) * Count) + 1;
SET UpperBound = ((StartIndex - 1) * Count) + Count;

SELECT  (SELECT count(*) FROM RECURSO_CITI) as total,
		(SELECT ceiling(count(*)/Count) FROM RECURSO_CITI) as pages,
        SOE_ID, 
		Apellido_Paterno, 
		Apellido_Materno, 
		Primer_Nombre, 
		Segundo_Nombre,
		Id_Dominio, 
		Id_Puesto, 
		Id_Ciudad, 
		Ext, 
		Movil, 
		Telefono, 
		Email, 
		Id_ReportaA, 
		Comentarios 
  FROM (SELECT *, @rownum := @rownum + 1 AS rank 
		FROM (SELECT 
				SOE_ID, 
                Apellido_Paterno, 
                Apellido_Materno, 
                Primer_Nombre, 
                Segundo_Nombre,
				Id_Dominio, 
                Id_Puesto, 
                Id_Ciudad, 
				Ext, 
                Movil, 
                Telefono, 
                Email, 
                Id_ReportaA, 
                Comentarios 
				FROM 
                RECURSO_CITI
				) d, (SELECT @rownum  := 0) r ) m
WHERE rank >= LowerBound AND rank <= UpperBound;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `paginationDetailsProviderId` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `paginationDetailsProviderId`(IN StartIndex INT,IN Count INT, IN _IdProvider INT)
BEGIN
DECLARE LowerBound INT;
DECLARE UpperBound INT;
DECLARE rownum INT;
SET LowerBound = ((StartIndex - 1) * Count) + 1;
SET UpperBound = ((StartIndex - 1) * Count) + Count;

SELECT 	(SELECT count(*) FROM RECURSO_PROVEEDOR RP INNER JOIN CAT_PUESTO_PROVEEDOR CPP INNER JOIN CAT_PROVEEDOR CP WHERE CPP.Id = RP.Id_Puesto AND CP.Id = RP.Id_Proveedor AND RP.Id_Proveedor = _IdProvider) as total,
		(SELECT ceiling(count(*)/Count) FROM RECURSO_PROVEEDOR RP INNER JOIN CAT_PUESTO_PROVEEDOR CPP INNER JOIN CAT_PROVEEDOR CP WHERE CPP.Id = RP.Id_Puesto AND CP.Id = RP.Id_Proveedor AND RP.Id_Proveedor = _IdProvider) as pages,
			Id,
			Clave_Empleado,
			concat(Primer_Nombre,' ',Segundo_Nombre,' ',Apellido_Paterno,' ',Apellido_Materno) AS nombre ,
			puesto,
            proveedor
  FROM (SELECT *, @rownum := @rownum + 1 AS rank 
		FROM (SELECT 
				RP.Id,
                RP.Clave_Empleado,
                RP.Primer_Nombre,
                RP.Segundo_Nombre,
                RP.Apellido_Paterno,
                RP.Apellido_Materno,
                CPP.Descripcion AS puesto,
                CP.Descripcion AS proveedor
                FROM 
                RECURSO_PROVEEDOR RP INNER JOIN 
                CAT_PUESTO_PROVEEDOR CPP INNER JOIN
                CAT_PROVEEDOR CP
                WHERE CPP.Id = RP.Id_Puesto AND 
                CP.Id = RP.Id_Proveedor AND 
                RP.Id_Proveedor = _IdProvider
				) d, (SELECT @rownum  := 0) r ) m
WHERE rank >= LowerBound AND rank <= UpperBound;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `paginationDetailsProviders` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `paginationDetailsProviders`(IN StartIndex INT,IN Count INT)
BEGIN
DECLARE LowerBound INT;
DECLARE UpperBound INT;
DECLARE rownum INT;
SET LowerBound = ((StartIndex - 1) * Count) + 1;
SET UpperBound = ((StartIndex - 1) * Count) + Count;

SELECT 	(SELECT count(*) FROM 
                RECURSO_PROVEEDOR RP INNER JOIN 
                CAT_PUESTO_PROVEEDOR CPP INNER JOIN
                CAT_PROVEEDOR CP
                WHERE CPP.Id = RP.Id_Puesto AND 
                CP.Id = RP.Id_Proveedor) as total,
			(SELECT ceiling(count(*)/Count) FROM 
                RECURSO_PROVEEDOR RP INNER JOIN 
                CAT_PUESTO_PROVEEDOR CPP INNER JOIN
                CAT_PROVEEDOR CP
                WHERE CPP.Id = RP.Id_Puesto AND 
                CP.Id = RP.Id_Proveedor) as pages,
			Id,
			Clave_Empleado,
			concat(Primer_Nombre,' ',Segundo_Nombre,' ',Apellido_Paterno,' ',Apellido_Materno) AS nombre ,
			puesto,
            proveedor
  FROM (SELECT *, @rownum := @rownum + 1 AS rank 
		FROM (SELECT 
				RP.Id,
                RP.Clave_Empleado,
                RP.Primer_Nombre,
                RP.Segundo_Nombre,
                RP.Apellido_Paterno,
                RP.Apellido_Materno,
                CPP.Descripcion AS puesto,
                CP.Descripcion AS proveedor
                FROM 
                RECURSO_PROVEEDOR RP INNER JOIN 
                CAT_PUESTO_PROVEEDOR CPP INNER JOIN
                CAT_PROVEEDOR CP
                WHERE CPP.Id = RP.Id_Puesto AND 
                CP.Id = RP.Id_Proveedor
				) d, (SELECT @rownum  := 0) r ) m
WHERE rank >= LowerBound AND rank <= UpperBound;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `paginationDomains` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `paginationDomains`(IN StartIndex INT,IN Count INT)
BEGIN
DECLARE LowerBound INT;
DECLARE UpperBound INT;
DECLARE rownum INT;
SET LowerBound = ((StartIndex - 1) * Count) + 1;
SET UpperBound = ((StartIndex - 1) * Count) + Count;

SELECT 	(SELECT count(*) FROM CAT_DOMINIO) as total,
		(SELECT ceiling(count(*)/Count) FROM CAT_DOMINIO) as pages,
			ID, 
			DESCRIPCION 
  FROM (SELECT *, @rownum := @rownum + 1 AS rank 
		FROM (SELECT 
				ID, 
                DESCRIPCION 
                FROM 
                CAT_DOMINIO
				) d, (SELECT @rownum  := 0) r ) m
WHERE rank >= LowerBound AND rank <= UpperBound;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `paginationEmployesDomain` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `paginationEmployesDomain`(IN StartIndex INT,IN Count INT, IN _Domain INT)
BEGIN
DECLARE LowerBound INT;
DECLARE UpperBound INT;
DECLARE rownum INT;
SET LowerBound = ((StartIndex - 1) * Count) + 1;
SET UpperBound = ((StartIndex - 1) * Count) + Count;

SELECT  (SELECT count(*) FROM RECURSO_CITI RC INNER JOIN CAT_PUESTOCITI PC INNER JOIN CAT_DOMINIO D WHERE RC.Id_Puesto = PC.Id AND D.Id = RC.Id_Dominio AND RC.Id_Dominio = _Domain) as total,
		(SELECT ceiling(count(*)/Count) FROM RECURSO_CITI RC INNER JOIN CAT_PUESTOCITI PC INNER JOIN CAT_DOMINIO D WHERE RC.Id_Puesto = PC.Id AND D.Id = RC.Id_Dominio AND RC.Id_Dominio = _Domain) as pages,
        Soe_Id,
		concat( Primer_Nombre,' ', Segundo_Nombre, ' ', Apellido_Paterno, ' ', Apellido_Materno) as nombre,
		puesto,
        dominio,
        Id_Dominio
  FROM (SELECT *, @rownum := @rownum + 1 AS rank 
		FROM (SELECT 
				RC.Soe_Id,
                RC.Primer_Nombre, 
                RC.Segundo_Nombre,
                RC.Apellido_Paterno,
                RC.Apellido_Materno,
                PC.Descripcion as puesto,
                D.Descripcion as dominio,
                RC.Id_Dominio
				FROM RECURSO_CITI RC INNER JOIN 
                CAT_PUESTOCITI PC INNER JOIN 
                CAT_DOMINIO D 
                WHERE RC.Id_Puesto = PC.Id AND 
                D.Id = RC.Id_Dominio AND 
                RC.Id_Dominio = _Domain
				) d, (SELECT @rownum  := 0) r ) m
WHERE rank >= LowerBound AND rank <= UpperBound;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `paginationProviders` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `paginationProviders`(IN StartIndex INT,IN Count INT)
BEGIN
DECLARE LowerBound INT;
DECLARE UpperBound INT;
DECLARE rownum INT;
SET LowerBound = ((StartIndex - 1) * Count) + 1;
SET UpperBound = ((StartIndex - 1) * Count) + Count;

SELECT   	(SELECT count(*) FROM CAT_PROVEEDOR) as total,
			(SELECT ceiling(count(*) / Count) FROM CAT_PROVEEDOR) as pages,
			Id,
			Descripcion 
  FROM (SELECT *, @rownum := @rownum + 1 AS rank 
		FROM (SELECT 
				Id,
				Descripcion 
                FROM 
                CAT_PROVEEDOR
				) d, (SELECT @rownum  := 0) r ) m
WHERE rank >= LowerBound AND rank <= UpperBound;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
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

SELECT 	(select count(*) from USUARIO u join CAT_PERFIL p on u.Id_Perfil=p.Id_Perfil) as total,
		(select ceiling(count(*)/Count) from USUARIO u join CAT_PERFIL p on u.Id_Perfil=p.Id_Perfil) as pages,
        Email, 
        concat(Primer_Nombre,' ',Segundo_Nombre,' ',Apellido_Paterno,' ',ApellidoMaterno) as nombre,
        Clave,
        Activo,
        Dominios,
        Proveedores,
		Id_Perfil,
        Descripcion,
        Id_Usuarios
  from (SELECT *, @rownum := @rownum + 1 AS rank 
		from (SELECT
					u.Id_Usuarios,
					u.Email, 
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

--
-- Final view structure for view `detailsl1application`
--

/*!50001 DROP VIEW IF EXISTS `detailsl1application`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `detailsl1application` AS
    SELECT 
        `a`.`Csi_Id` AS `idApp`,
        `d`.`Descripcion` AS `dominio`,
        'L1' AS `L`,
        CONCAT(`canalista`.`Primer_Nombre`,
                ' ',
                `canalista`.`Segundo_Nombre`,
                ' ',
                `canalista`.`Apellido_Paterno`,
                ' ',
                `canalista`.`Apellido_Materno`) AS `analista_bnmx`,
        `canalista`.`Soe_Id` AS `id_analista_bnmx`,
        `canalista`.`Ext` AS `ext_analista_bnmx`,
        `canalista`.`Movil` AS `celular_analista_bnmx`,
        `canalista`.`Email` AS `email_analista_bnmx`,
        CONCAT(`clider`.`Primer_Nombre`,
                ' ',
                `clider`.`Segundo_Nombre`,
                ' ',
                `clider`.`Apellido_Paterno`,
                ' ',
                `clider`.`Apellido_Materno`) AS `lider_bnmx`,
        `clider`.`Soe_Id` AS `id_lider_bnmx`,
        `clider`.`Ext` AS `ext_lider_bnmx`,
        `clider`.`Movil` AS `celular_lider_bnmx`,
        `clider`.`Email` AS `email_lider_bnmx`,
        CONCAT(`cgerente`.`Primer_Nombre`,
                ' ',
                `cgerente`.`Segundo_Nombre`,
                ' ',
                `cgerente`.`Apellido_Paterno`,
                ' ',
                `cgerente`.`Apellido_Materno`) AS `gerente_bnmx`,
        `cgerente`.`Soe_Id` AS `id_gerente_bnmx`,
        `cgerente`.`Ext` AS `ext_gerente_bnmx`,
        `cgerente`.`Movil` AS `celular_gerente_bnmx`,
        `cgerente`.`Email` AS `email_gerente_bnmx`,
        `cp`.`Descripcion` AS `proveedor`,
        CONCAT(`presponsable`.`Primer_Nombre`,
                ' ',
                `presponsable`.`Segundo_Nombre`,
                ' ',
                `presponsable`.`Apellido_Paterno`,
                ' ',
                `presponsable`.`Apellido_Materno`) AS `responsable_prov`,
        `presponsable`.`Id` AS `id_responsable_prov`,
        `presponsable`.`Ext_Citi` AS `ext_responsable_banamex_prov`,
        `presponsable`.`LD_celular` AS `lada_cel_responsable_prov`,
        `presponsable`.`Movil_Personal` AS `cel_responsable_prov`,
        `presponsable`.`Email_Citi` AS `email_responsable_bnmx_prov`,
        `presponsable`.`LD_particular` AS `lada_otro_responsable_prov`,
        `presponsable`.`Telefono_Particular` AS `tel_otro_responsable_prov`,
        `presponsable`.`Email_Proveedor` AS `email_responsable_prov`,
        CONCAT(`pbackup`.`Primer_Nombre`,
                ' ',
                `pbackup`.`Segundo_Nombre`,
                ' ',
                `pbackup`.`Apellido_Paterno`,
                ' ',
                `pbackup`.`Apellido_Materno`) AS `backup_prov`,
        `pbackup`.`Id` AS `id_backup_prov`,
        `pbackup`.`Ext_Citi` AS `ext_backup_banamex_prov`,
        `pbackup`.`LD_celular` AS `lada_cel_backup_prov`,
        `pbackup`.`Movil_Personal` AS `cel_backup_prov`,
        `pbackup`.`Email_Citi` AS `email_backup_bnmx_prov`,
        `pbackup`.`LD_particular` AS `lada_otro_backup_prov`,
        `pbackup`.`Telefono_Particular` AS `tel_otro_backup_prov`,
        `pbackup`.`Email_Proveedor` AS `email_backup_prov`,
        CONCAT(`plider`.`Primer_Nombre`,
                ' ',
                `plider`.`Segundo_Nombre`,
                ' ',
                `plider`.`Apellido_Paterno`,
                ' ',
                `plider`.`Apellido_Materno`) AS `lider_prov`,
        `plider`.`Id` AS `id_lider_prov`,
        `plider`.`Ext_Citi` AS `ext_lider_banamex_prov`,
        `plider`.`LD_celular` AS `lada_cel_lider_prov`,
        `plider`.`Movil_Personal` AS `cel_lider_prov`,
        `plider`.`Email_Citi` AS `email_lider_bnmx_prov`,
        `plider`.`LD_particular` AS `lada_otro_lider_prov`,
        `plider`.`Telefono_Particular` AS `tel_otro_lider_prov`,
        `plider`.`Email_Proveedor` AS `email_lider_prov`,
        CONCAT(`pprojectmanager`.`Primer_Nombre`,
                ' ',
                `pprojectmanager`.`Segundo_Nombre`,
                ' ',
                `pprojectmanager`.`Apellido_Paterno`,
                ' ',
                `pprojectmanager`.`Apellido_Materno`) AS `p_manager_prov`,
        `pprojectmanager`.`Id` AS `id_p_manager_prov`,
        `pprojectmanager`.`Ext_Citi` AS `ext_p_manager_banamex_prov`,
        `pprojectmanager`.`LD_celular` AS `lada_cel_p_manager_prov`,
        `pprojectmanager`.`Movil_Personal` AS `cel_p_manager_prov`,
        `pprojectmanager`.`Email_Citi` AS `email_p_manager_bnmx_prov`,
        `pprojectmanager`.`LD_particular` AS `lada_otro_p_manager_prov`,
        `pprojectmanager`.`Telefono_Particular` AS `tel_otro_p_manager_prov`,
        `pprojectmanager`.`Email_Proveedor` AS `email_p_manager_prov`,
        CONCAT(`pdelivery`.`Primer_Nombre`,
                ' ',
                `pdelivery`.`Segundo_Nombre`,
                ' ',
                `pdelivery`.`Apellido_Paterno`,
                ' ',
                `pdelivery`.`Apellido_Materno`) AS `d_manager_prov`,
        `pdelivery`.`Id` AS `id_d_manager_prov`,
        `pdelivery`.`Ext_Citi` AS `ext_d_manager_banamex_prov`,
        `pdelivery`.`LD_celular` AS `lada_cel_d_manager_prov`,
        `pdelivery`.`Movil_Personal` AS `cel_d_manager_prov`,
        `pdelivery`.`Email_Citi` AS `email_d_manager_bnmx_prov`,
        `pdelivery`.`LD_particular` AS `lada_otro_d_manager_prov`,
        `pdelivery`.`Telefono_Particular` AS `tel_otro_d_manager_prov`,
        `pdelivery`.`Email_Proveedor` AS `email_d_manager_prov` from (((((((((((`APLICACION` `a` left join `CAT_PROVEEDOR` `cp` on((`a`.`Id_L1` = `cp`.`Id`))) left join `L1APLICACION` `l1` on((`a`.`Csi_Id` = `l1`.`idAplicacionCiti`))) left join `RECURSO_CITI` `canalista` on((`canalista`.`Soe_Id` = `l1`.`idAnalistaRCiti`))) left join `RECURSO_CITI` `clider` on((`clider`.`Soe_Id` = `l1`.`idLiderRCiti`))) left join `RECURSO_CITI` `cgerente` on((`cgerente`.`Soe_Id` = `l1`.`idGerenteRCiti`))) left join `RECURSO_PROVEEDOR` `presponsable` on((`presponsable`.`Id` = `l1`.`idResponsableRProveedor`))) left join `RECURSO_PROVEEDOR` `pbackup` on((`pbackup`.`Id` = `l1`.`idBackupRProveedor`))) left join `RECURSO_PROVEEDOR` `plider` on((`plider`.`Id` = `l1`.`idLiderRProveedor`))) left join `RECURSO_PROVEEDOR` `pprojectmanager` on((`pprojectmanager`.`Id` = `l1`.`idProjectManagerRProveedor`))) left join `RECURSO_PROVEEDOR` `pdelivery` on((`pdelivery`.`Id` = `l1`.`idDeliveryManagerRProveedor`))) left join `CAT_DOMINIO` `d` on((`d`.`Id` = `a`.`Id_Dominio`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `detailsl2application`
--

/*!50001 DROP VIEW IF EXISTS `detailsl2application`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `detailsl2application` AS
    SELECT 
        `a`.`Csi_Id` AS `idApp`,
        `d`.`Descripcion` AS `dominio`,
        'L2' AS `L`,
        CONCAT(`canalista`.`Primer_Nombre`,
                ' ',
                `canalista`.`Segundo_Nombre`,
                ' ',
                `canalista`.`Apellido_Paterno`,
                ' ',
                `canalista`.`Apellido_Materno`) AS `analista_bnmx`,
        `canalista`.`Soe_Id` AS `id_analista_bnmx`,
        `canalista`.`Ext` AS `ext_analista_bnmx`,
        `canalista`.`Movil` AS `celular_analista_bnmx`,
        `canalista`.`Email` AS `email_analista_bnmx`,
        CONCAT(`clider`.`Primer_Nombre`,
                ' ',
                `clider`.`Segundo_Nombre`,
                ' ',
                `clider`.`Apellido_Paterno`,
                ' ',
                `clider`.`Apellido_Materno`) AS `lider_bnmx`,
        `clider`.`Soe_Id` AS `id_lider_bnmx`,
        `clider`.`Ext` AS `ext_lider_bnmx`,
        `clider`.`Movil` AS `celular_lider_bnmx`,
        `clider`.`Email` AS `email_lider_bnmx`,
        CONCAT(`cgerente`.`Primer_Nombre`,
                ' ',
                `cgerente`.`Segundo_Nombre`,
                ' ',
                `cgerente`.`Apellido_Paterno`,
                ' ',
                `cgerente`.`Apellido_Materno`) AS `gerente_bnmx`,
        `cgerente`.`Soe_Id` AS `id_gerente_bnmx`,
        `cgerente`.`Ext` AS `ext_gerente_bnmx`,
        `cgerente`.`Movil` AS `celular_gerente_bnmx`,
        `cgerente`.`Email` AS `email_gerente_bnmx`,
        `cp`.`Descripcion` AS `proveedor`,
        CONCAT(`presponsable`.`Primer_Nombre`,
                ' ',
                `presponsable`.`Segundo_Nombre`,
                ' ',
                `presponsable`.`Apellido_Paterno`,
                ' ',
                `presponsable`.`Apellido_Materno`) AS `responsable_prov`,
        `presponsable`.`Id` AS `id_responsable_prov`,
        `presponsable`.`Ext_Citi` AS `ext_responsable_banamex_prov`,
        `presponsable`.`LD_celular` AS `lada_cel_responsable_prov`,
        `presponsable`.`Movil_Personal` AS `cel_responsable_prov`,
        `presponsable`.`Email_Citi` AS `email_responsable_bnmx_prov`,
        `presponsable`.`LD_particular` AS `lada_otro_responsable_prov`,
        `presponsable`.`Telefono_Particular` AS `tel_otro_responsable_prov`,
        `presponsable`.`Email_Proveedor` AS `email_responsable_prov`,
        CONCAT(`pbackup`.`Primer_Nombre`,
                ' ',
                `pbackup`.`Segundo_Nombre`,
                ' ',
                `pbackup`.`Apellido_Paterno`,
                ' ',
                `pbackup`.`Apellido_Materno`) AS `backup_prov`,
        `pbackup`.`Id` AS `id_backup_prov`,
        `pbackup`.`Ext_Citi` AS `ext_backup_banamex_prov`,
        `pbackup`.`LD_celular` AS `lada_cel_backup_prov`,
        `pbackup`.`Movil_Personal` AS `cel_backup_prov`,
        `pbackup`.`Email_Citi` AS `email_backup_bnmx_prov`,
        `pbackup`.`LD_particular` AS `lada_otro_backup_prov`,
        `pbackup`.`Telefono_Particular` AS `tel_otro_backup_prov`,
        `pbackup`.`Email_Proveedor` AS `email_backup_prov`,
        CONCAT(`plider`.`Primer_Nombre`,
                ' ',
                `plider`.`Segundo_Nombre`,
                ' ',
                `plider`.`Apellido_Paterno`,
                ' ',
                `plider`.`Apellido_Materno`) AS `lider_prov`,
        `plider`.`Id` AS `id_lider_prov`,
        `plider`.`Ext_Citi` AS `ext_lider_banamex_prov`,
        `plider`.`LD_celular` AS `lada_cel_lider_prov`,
        `plider`.`Movil_Personal` AS `cel_lider_prov`,
        `plider`.`Email_Citi` AS `email_lider_bnmx_prov`,
        `plider`.`LD_particular` AS `lada_otro_lider_prov`,
        `plider`.`Telefono_Particular` AS `tel_otro_lider_prov`,
        `plider`.`Email_Proveedor` AS `email_lider_prov`,
        CONCAT(`pprojectmanager`.`Primer_Nombre`,
                ' ',
                `pprojectmanager`.`Segundo_Nombre`,
                ' ',
                `pprojectmanager`.`Apellido_Paterno`,
                ' ',
                `pprojectmanager`.`Apellido_Materno`) AS `p_manager_prov`,
        `pprojectmanager`.`Id` AS `id_p_manager_prov`,
        `pprojectmanager`.`Ext_Citi` AS `ext_p_manager_banamex_prov`,
        `pprojectmanager`.`LD_celular` AS `lada_cel_p_manager_prov`,
        `pprojectmanager`.`Movil_Personal` AS `cel_p_manager_prov`,
        `pprojectmanager`.`Email_Citi` AS `email_p_manager_bnmx_prov`,
        `pprojectmanager`.`LD_particular` AS `lada_otro_p_manager_prov`,
        `pprojectmanager`.`Telefono_Particular` AS `tel_otro_p_manager_prov`,
        `pprojectmanager`.`Email_Proveedor` AS `email_p_manager_prov`,
        CONCAT(`pdelivery`.`Primer_Nombre`,
                ' ',
                `pdelivery`.`Segundo_Nombre`,
                ' ',
                `pdelivery`.`Apellido_Paterno`,
                ' ',
                `pdelivery`.`Apellido_Materno`) AS `d_manager_prov`,
        `pdelivery`.`Id` AS `id_d_manager_prov`,
        `pdelivery`.`Ext_Citi` AS `ext_d_manager_banamex_prov`,
        `pdelivery`.`LD_celular` AS `lada_cel_d_manager_prov`,
        `pdelivery`.`Movil_Personal` AS `cel_d_manager_prov`,
        `pdelivery`.`Email_Citi` AS `email_d_manager_bnmx_prov`,
        `pdelivery`.`LD_particular` AS `lada_otro_d_manager_prov`,
        `pdelivery`.`Telefono_Particular` AS `tel_otro_d_manager_prov`,
        `pdelivery`.`Email_Proveedor` AS `email_d_manager_prov` from (((((((((((`APLICACION` `a` left join `CAT_PROVEEDOR` `cp` on((`a`.`Id_L2` = `cp`.`Id`))) left join `L2APLICACION` `l1` on((`a`.`Csi_Id` = `l1`.`idAplicacionCiti`))) left join `RECURSO_CITI` `canalista` on((`canalista`.`Soe_Id` = `l1`.`idAnalistaRCiti`))) left join `RECURSO_CITI` `clider` on((`clider`.`Soe_Id` = `l1`.`idLiderRCiti`))) left join `RECURSO_CITI` `cgerente` on((`cgerente`.`Soe_Id` = `l1`.`idGerenteRCiti`))) left join `RECURSO_PROVEEDOR` `presponsable` on((`presponsable`.`Id` = `l1`.`idResponsableRProveedor`))) left join `RECURSO_PROVEEDOR` `pbackup` on((`pbackup`.`Id` = `l1`.`idBackupRProveedor`))) left join `RECURSO_PROVEEDOR` `plider` on((`plider`.`Id` = `l1`.`idLiderRProveedor`))) left join `RECURSO_PROVEEDOR` `pprojectmanager` on((`pprojectmanager`.`Id` = `l1`.`idProjectManagerRProveedor`))) left join `RECURSO_PROVEEDOR` `pdelivery` on((`pdelivery`.`Id` = `l1`.`idDeliveryManagerRProveedor`))) left join `CAT_DOMINIO` `d` on((`d`.`Id` = `a`.`Id_Dominio`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `detailsl3application`
--

/*!50001 DROP VIEW IF EXISTS `detailsl3application`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `detailsl3application` AS
    SELECT 
        `a`.`Csi_Id` AS `idApp`,
        `d`.`Descripcion` AS `dominio`,
        'L3' AS `L`,
        CONCAT(`canalista`.`Primer_Nombre`,
                ' ',
                `canalista`.`Segundo_Nombre`,
                ' ',
                `canalista`.`Apellido_Paterno`,
                ' ',
                `canalista`.`Apellido_Materno`) AS `analista_bnmx`,
        `canalista`.`Soe_Id` AS `id_analista_bnmx`,
        `canalista`.`Ext` AS `ext_analista_bnmx`,
        `canalista`.`Movil` AS `celular_analista_bnmx`,
        `canalista`.`Email` AS `email_analista_bnmx`,
        CONCAT(`clider`.`Primer_Nombre`,
                ' ',
                `clider`.`Segundo_Nombre`,
                ' ',
                `clider`.`Apellido_Paterno`,
                ' ',
                `clider`.`Apellido_Materno`) AS `lider_bnmx`,
        `clider`.`Soe_Id` AS `id_lider_bnmx`,
        `clider`.`Ext` AS `ext_lider_bnmx`,
        `clider`.`Movil` AS `celular_lider_bnmx`,
        `clider`.`Email` AS `email_lider_bnmx`,
        CONCAT(`cgerente`.`Primer_Nombre`,
                ' ',
                `cgerente`.`Segundo_Nombre`,
                ' ',
                `cgerente`.`Apellido_Paterno`,
                ' ',
                `cgerente`.`Apellido_Materno`) AS `gerente_bnmx`,
        `cgerente`.`Soe_Id` AS `id_gerente_bnmx`,
        `cgerente`.`Ext` AS `ext_gerente_bnmx`,
        `cgerente`.`Movil` AS `celular_gerente_bnmx`,
        `cgerente`.`Email` AS `email_gerente_bnmx`,
        `cp`.`Descripcion` AS `proveedor`,
        CONCAT(`presponsable`.`Primer_Nombre`,
                ' ',
                `presponsable`.`Segundo_Nombre`,
                ' ',
                `presponsable`.`Apellido_Paterno`,
                ' ',
                `presponsable`.`Apellido_Materno`) AS `responsable_prov`,
        `presponsable`.`Id` AS `id_responsable_prov`,
        `presponsable`.`Ext_Citi` AS `ext_responsable_banamex_prov`,
        `presponsable`.`LD_celular` AS `lada_cel_responsable_prov`,
        `presponsable`.`Movil_Personal` AS `cel_responsable_prov`,
        `presponsable`.`Email_Citi` AS `email_responsable_bnmx_prov`,
        `presponsable`.`LD_particular` AS `lada_otro_responsable_prov`,
        `presponsable`.`Telefono_Particular` AS `tel_otro_responsable_prov`,
        `presponsable`.`Email_Proveedor` AS `email_responsable_prov`,
        CONCAT(`pbackup`.`Primer_Nombre`,
                ' ',
                `pbackup`.`Segundo_Nombre`,
                ' ',
                `pbackup`.`Apellido_Paterno`,
                ' ',
                `pbackup`.`Apellido_Materno`) AS `backup_prov`,
        `pbackup`.`Id` AS `id_backup_prov`,
        `pbackup`.`Ext_Citi` AS `ext_backup_banamex_prov`,
        `pbackup`.`LD_celular` AS `lada_cel_backup_prov`,
        `pbackup`.`Movil_Personal` AS `cel_backup_prov`,
        `pbackup`.`Email_Citi` AS `email_backup_bnmx_prov`,
        `pbackup`.`LD_particular` AS `lada_otro_backup_prov`,
        `pbackup`.`Telefono_Particular` AS `tel_otro_backup_prov`,
        `pbackup`.`Email_Proveedor` AS `email_backup_prov`,
        CONCAT(`plider`.`Primer_Nombre`,
                ' ',
                `plider`.`Segundo_Nombre`,
                ' ',
                `plider`.`Apellido_Paterno`,
                ' ',
                `plider`.`Apellido_Materno`) AS `lider_prov`,
        `plider`.`Id` AS `id_lider_prov`,
        `plider`.`Ext_Citi` AS `ext_lider_banamex_prov`,
        `plider`.`LD_celular` AS `lada_cel_lider_prov`,
        `plider`.`Movil_Personal` AS `cel_lider_prov`,
        `plider`.`Email_Citi` AS `email_lider_bnmx_prov`,
        `plider`.`LD_particular` AS `lada_otro_lider_prov`,
        `plider`.`Telefono_Particular` AS `tel_otro_lider_prov`,
        `plider`.`Email_Proveedor` AS `email_lider_prov`,
        CONCAT(`pprojectmanager`.`Primer_Nombre`,
                ' ',
                `pprojectmanager`.`Segundo_Nombre`,
                ' ',
                `pprojectmanager`.`Apellido_Paterno`,
                ' ',
                `pprojectmanager`.`Apellido_Materno`) AS `p_manager_prov`,
        `pprojectmanager`.`Id` AS `id_p_manager_prov`,
        `pprojectmanager`.`Ext_Citi` AS `ext_p_manager_banamex_prov`,
        `pprojectmanager`.`LD_celular` AS `lada_cel_p_manager_prov`,
        `pprojectmanager`.`Movil_Personal` AS `cel_p_manager_prov`,
        `pprojectmanager`.`Email_Citi` AS `email_p_manager_bnmx_prov`,
        `pprojectmanager`.`LD_particular` AS `lada_otro_p_manager_prov`,
        `pprojectmanager`.`Telefono_Particular` AS `tel_otro_p_manager_prov`,
        `pprojectmanager`.`Email_Proveedor` AS `email_p_manager_prov`,
        CONCAT(`pdelivery`.`Primer_Nombre`,
                ' ',
                `pdelivery`.`Segundo_Nombre`,
                ' ',
                `pdelivery`.`Apellido_Paterno`,
                ' ',
                `pdelivery`.`Apellido_Materno`) AS `d_manager_prov`,
        `pdelivery`.`Id` AS `id_d_manager_prov`,
        `pdelivery`.`Ext_Citi` AS `ext_d_manager_banamex_prov`,
        `pdelivery`.`LD_celular` AS `lada_cel_d_manager_prov`,
        `pdelivery`.`Movil_Personal` AS `cel_d_manager_prov`,
        `pdelivery`.`Email_Citi` AS `email_d_manager_bnmx_prov`,
        `pdelivery`.`LD_particular` AS `lada_otro_d_manager_prov`,
        `pdelivery`.`Telefono_Particular` AS `tel_otro_d_manager_prov`,
        `pdelivery`.`Email_Proveedor` AS `email_d_manager_prov` from (((((((((((`APLICACION` `a` left join `CAT_PROVEEDOR` `cp` on((`a`.`Id_L3` = `cp`.`Id`))) left join `L3APLICACION` `l1` on((`a`.`Csi_Id` = `l1`.`idAplicacionCiti`))) left join `RECURSO_CITI` `canalista` on((`canalista`.`Soe_Id` = `l1`.`idAnalistaRCiti`))) left join `RECURSO_CITI` `clider` on((`clider`.`Soe_Id` = `l1`.`idLiderRCiti`))) left join `RECURSO_CITI` `cgerente` on((`cgerente`.`Soe_Id` = `l1`.`idGerenteRCiti`))) left join `RECURSO_PROVEEDOR` `presponsable` on((`presponsable`.`Id` = `l1`.`idResponsableRProveedor`))) left join `RECURSO_PROVEEDOR` `pbackup` on((`pbackup`.`Id` = `l1`.`idBackupRProveedor`))) left join `RECURSO_PROVEEDOR` `plider` on((`plider`.`Id` = `l1`.`idLiderRProveedor`))) left join `RECURSO_PROVEEDOR` `pprojectmanager` on((`pprojectmanager`.`Id` = `l1`.`idProjectManagerRProveedor`))) left join `RECURSO_PROVEEDOR` `pdelivery` on((`pdelivery`.`Id` = `l1`.`idDeliveryManagerRProveedor`))) left join `CAT_DOMINIO` `d` on((`d`.`Id` = `a`.`Id_Dominio`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-06-05 16:36:59
