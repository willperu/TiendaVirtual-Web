CREATE DATABASE IF NOT EXISTS tiendavirtual;
USE tiendavirtual;
-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: localhost    Database: tiendavirtual
-- ------------------------------------------------------
-- Server version	8.0.41

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `backup_detalle_venta`
--

DROP TABLE IF EXISTS `backup_detalle_venta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `backup_detalle_venta` (
  `id` int NOT NULL DEFAULT '0',
  `venta_id` int NOT NULL,
  `producto_id` int NOT NULL,
  `cantidad` int NOT NULL,
  `precio` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `backup_detalle_venta`
--

LOCK TABLES `backup_detalle_venta` WRITE;
/*!40000 ALTER TABLE `backup_detalle_venta` DISABLE KEYS */;
INSERT INTO `backup_detalle_venta` VALUES (2,3,4,10,5.00),(3,3,5,2,11.00),(4,4,4,10,5.00),(5,5,5,4,11.00),(6,5,4,14,5.00),(7,6,5,1,11.00),(8,7,1,2,20.00),(9,7,4,3,5.00),(10,7,5,2,11.00),(11,8,1,2,20.00),(12,8,4,4,5.00),(13,9,1,1,20.00),(14,9,5,1,11.00),(15,9,4,3,5.00),(16,10,5,2,11.00),(17,10,5,3,11.00),(18,11,4,2,5.00),(19,11,5,1,11.00),(20,12,2,1,50.00),(21,12,5,2,11.00),(22,13,16,2,2.50),(23,14,18,3,11.30);
/*!40000 ALTER TABLE `backup_detalle_venta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `backup_productos`
--

DROP TABLE IF EXISTS `backup_productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `backup_productos` (
  `id` int NOT NULL DEFAULT '0',
  `nombre` varchar(255) NOT NULL,
  `precio` decimal(10,2) NOT NULL,
  `stock` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `backup_productos`
--

LOCK TABLES `backup_productos` WRITE;
/*!40000 ALTER TABLE `backup_productos` DISABLE KEYS */;
INSERT INTO `backup_productos` VALUES (1,'Mouse',20.00,3),(2,'Teclado',50.00,3),(3,'Monitor',900.00,3),(4,'Lampada',5.00,10),(5,'Cable',11.00,4),(6,'Prego',2.50,30),(7,'Pilha 3v x 2',5.50,30),(8,'Pilha 9v',11.30,45),(9,'Testador de energia 110v-220v',15.00,25),(10,'Lampada de Led 60w 110v',10.00,30),(11,'Cadarzo',2.00,20);
/*!40000 ALTER TABLE `backup_productos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `carrito`
--

DROP TABLE IF EXISTS `carrito`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `carrito` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `usuario_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_jo3wdfqn510qwk6ffx5v9nua8` (`usuario_id`),
  CONSTRAINT `FKbunaoq2qnb3gd29rcqv2e2dal` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `carrito`
--

LOCK TABLES `carrito` WRITE;
/*!40000 ALTER TABLE `carrito` DISABLE KEYS */;
INSERT INTO `carrito` VALUES (2,21);
/*!40000 ALTER TABLE `carrito` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detalle_venta`
--

DROP TABLE IF EXISTS `detalle_venta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `detalle_venta` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `cantidad` int DEFAULT NULL,
  `precio` decimal(38,2) DEFAULT NULL,
  `producto_id` bigint DEFAULT NULL,
  `venta_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKdn5t1y68ckfy82hqxs0lmi9e` (`producto_id`),
  KEY `FK834rjd9cwo349m5xdf1knbl0l` (`venta_id`),
  CONSTRAINT `FK834rjd9cwo349m5xdf1knbl0l` FOREIGN KEY (`venta_id`) REFERENCES `ventas` (`id`),
  CONSTRAINT `FKdn5t1y68ckfy82hqxs0lmi9e` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=220 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalle_venta`
--

LOCK TABLES `detalle_venta` WRITE;
/*!40000 ALTER TABLE `detalle_venta` DISABLE KEYS */;
INSERT INTO `detalle_venta` VALUES (13,1,300.00,3,9),(14,1,300.00,3,10),(15,1,10.00,5,11),(16,1,15.00,6,11),(17,1,10.00,5,12),(18,1,15.00,6,12),(19,1,10.00,5,13),(20,1,15.00,6,13),(21,1,80.00,2,14),(22,4,300.00,3,20),(23,1,5.00,7,21),(24,1,80.00,2,22),(25,1,300.00,3,22),(26,1,50.00,1,22),(27,2,300.00,3,23),(28,1,80.00,2,24),(29,1,300.00,3,24),(30,1,80.00,2,25),(31,1,80.00,2,26),(32,1,50.00,1,26),(33,1,300.00,3,26),(34,1,80.00,2,27),(35,1,300.00,3,27),(36,1,50.00,1,27),(37,1,80.00,2,28),(38,1,300.00,3,28),(39,3,80.00,2,29),(40,1,300.00,3,29),(41,1,80.00,2,30),(42,2,300.00,3,30),(43,1,300.00,3,31),(44,1,50.00,1,31),(45,1,80.00,2,31),(46,3,80.00,2,32),(47,3,300.00,3,32),(48,2,15.00,6,33),(49,3,5.00,7,33),(50,3,10.00,5,33),(51,1,300.00,3,34),(52,2,80.00,2,34),(53,2,50.00,1,34),(54,1,10.00,5,34),(55,1,15.00,6,34),(56,1,80.00,2,35),(57,1,300.00,3,35),(58,1,80.00,2,36),(59,1,50.00,1,36),(60,1,80.00,2,37),(61,1,50.00,1,37),(62,1,5.00,7,38),(63,1,300.00,3,39),(64,1,80.00,2,39),(65,1,15.00,6,39),(66,1,300.00,3,40),(67,1,80.00,2,40),(68,1,300.00,3,41),(69,1,5.00,7,41),(70,1,80.00,2,42),(71,1,300.00,3,42),(72,1,50.00,1,42),(73,1,15.00,8,43),(74,1,15.00,6,43),(75,1,5.00,7,43),(76,1,10.00,5,43),(77,1,15.00,6,44),(78,1,5.00,7,44),(79,1,300.00,3,44),(80,1,80.00,2,45),(81,1,300.00,3,45),(82,1,80.00,2,46),(83,1,10.00,5,46),(84,1,80.00,2,47),(85,1,300.00,3,47),(86,1,15.00,6,48),(87,1,5.00,7,48),(88,1,300.00,3,49),(89,1,80.00,2,50),(90,1,300.00,3,51),(91,1,80.00,2,52),(92,1,50.00,1,52),(93,1,80.00,2,53),(94,1,5.00,7,54),(95,1,10.00,5,54),(96,2,50.00,1,54),(97,1,80.00,2,55),(98,1,50.00,1,55),(99,1,10.00,5,56),(100,1,300.00,3,56),(101,1,80.00,2,57),(102,1,50.00,1,57),(103,1,15.00,6,57),(104,1,300.00,3,58),(105,1,15.00,8,58),(106,1,8.00,10,58),(107,1,5.00,7,58),(108,1,10.00,5,59),(109,1,15.00,8,59),(110,2,15.00,6,59),(111,1,10.00,5,60),(112,1,10.00,5,61),(113,1,50.00,1,61),(114,1,300.00,3,62),(115,1,10.00,5,62),(116,1,80.00,2,63),(117,1,10.00,5,63),(118,1,8.00,10,63),(119,1,15.00,8,64),(120,1,10.00,5,65),(121,1,80.00,2,65),(122,1,5.00,7,65),(123,1,10.00,5,66),(124,1,10.00,5,67),(125,1,50.00,1,67),(126,1,80.00,2,68),(127,1,50.00,1,68),(128,1,50.00,1,69),(129,1,15.00,6,69),(130,1,15.00,8,69),(131,1,15.00,8,70),(132,1,50.00,1,71),(133,1,15.00,6,71),(134,1,15.00,8,71),(135,1,80.00,2,72),(136,1,15.00,8,72),(137,1,5.00,7,72),(138,1,5.00,7,73),(139,1,50.00,1,73),(140,1,15.00,6,73),(141,1,15.00,8,73),(142,1,10.00,5,74),(143,2,10.00,5,75),(144,2,80.00,2,75),(145,2,80.00,2,76),(146,2,300.00,3,76),(147,3,10.00,5,77),(148,3,5.00,7,78),(149,1,300.00,3,78),(150,1,15.00,6,79),(151,1,300.00,3,79),(152,1,15.00,6,80),(153,1,5.00,7,80),(154,1,300.00,3,80),(155,1,5.00,7,81),(156,1,15.00,6,81),(157,1,15.00,6,82),(158,1,5.00,7,82),(159,1,15.00,6,83),(160,1,5.00,7,83),(161,1,10.00,5,84),(162,1,15.00,6,84),(163,1,10.00,5,85),(164,1,300.00,3,86),(165,1,15.00,6,87),(166,1,10.00,5,88),(167,1,15.00,6,89),(168,1,10.00,5,90),(169,1,15.00,8,90),(170,1,10.00,5,91),(171,1,15.00,6,91),(172,1,15.00,8,92),(173,1,15.00,6,93),(174,1,15.00,8,94),(175,1,10.00,5,95),(176,1,80.00,2,96),(177,1,10.00,5,97),(178,1,5.00,7,98),(179,1,5.00,7,99),(180,1,80.00,2,100),(181,1,80.00,2,101),(182,1,50.00,1,102),(183,1,10.00,5,102),(184,1,50.00,1,103),(185,1,300.00,3,103),(186,1,5.00,7,104),(187,1,80.00,2,105),(188,1,80.00,2,106),(189,1,80.00,2,107),(190,1,10.00,5,108),(191,1,300.00,3,109),(192,1,10.00,5,109),(193,1,80.00,2,110),(194,2,50.00,1,111),(195,1,80.00,2,112),(196,1,300.00,3,113),(197,1,80.00,2,114),(198,1,50.00,1,115),(199,1,300.00,3,115),(200,1,80.00,2,116),(201,1,300.00,3,117),(202,1,10.00,5,118),(203,1,300.00,3,119),(204,1,80.00,2,120),(205,2,50.00,1,121),(206,1,5.00,7,121),(207,2,300.00,3,122),(208,1,10.00,5,122),(209,2,80.00,2,123),(210,3,300.00,3,123),(211,1,300.00,3,124),(212,2,10.00,5,124),(213,1,10.00,5,125),(214,1,300.00,3,125),(215,2,10.00,5,126),(216,1,50.00,1,126),(217,4,80.00,2,127),(218,1,300.00,3,127),(219,1,5.00,7,127);
/*!40000 ALTER TABLE `detalle_venta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_carrito`
--

DROP TABLE IF EXISTS `item_carrito`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `item_carrito` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `cantidad` int NOT NULL,
  `carrito_id` bigint DEFAULT NULL,
  `producto_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK7jlhnuuh4m7q1cn77xhtx9kdq` (`carrito_id`),
  KEY `FK56pta5ak42wucf5fidc7b91fx` (`producto_id`),
  CONSTRAINT `FK56pta5ak42wucf5fidc7b91fx` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`),
  CONSTRAINT `FK7jlhnuuh4m7q1cn77xhtx9kdq` FOREIGN KEY (`carrito_id`) REFERENCES `carrito` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=264 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_carrito`
--

LOCK TABLES `item_carrito` WRITE;
/*!40000 ALTER TABLE `item_carrito` DISABLE KEYS */;
/*!40000 ALTER TABLE `item_carrito` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productos`
--

DROP TABLE IF EXISTS `productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productos` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) DEFAULT NULL,
  `precio` decimal(12,2) NOT NULL,
  `stock` int DEFAULT NULL,
  `categoria` varchar(50) DEFAULT NULL,
  `descripcion` varchar(500) DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT NULL,
  `imagen` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UKmlgw7js72hh2xtd4mvpdqfsbe` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productos`
--

LOCK TABLES `productos` WRITE;
/*!40000 ALTER TABLE `productos` DISABLE KEYS */;
INSERT INTO `productos` VALUES (1,'Mouse',50.00,40,NULL,NULL,NULL,'mouse.png'),(2,'Teclado',80.00,16,NULL,NULL,NULL,'teclado.png'),(3,'Monitor',300.00,28,NULL,NULL,NULL,'monitor.png'),(5,'Lampada 100wts',10.00,33,NULL,NULL,NULL,'lampada100wts.png'),(6,'Carregador de Celular',15.00,22,NULL,NULL,'2026-03-17 00:27:36','carregadordecelular.png'),(7,'Pilha 3.5v',5.00,24,NULL,NULL,'2026-03-17 15:43:38','pilha3.5v.png'),(8,'Pilha 9v',15.00,28,NULL,NULL,'2026-04-08 13:47:00','pilha9v.png'),(10,'Prestobarba',8.00,48,NULL,NULL,NULL,NULL),(12,'Isqueiro',5.00,23,NULL,NULL,'2026-04-17 18:09:05',NULL);
/*!40000 ALTER TABLE `productos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `usuario` varchar(50) NOT NULL,
  `password` varchar(64) NOT NULL,
  `rol` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `usuario` (`usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (21,'admin','$2a$10$opSPASFqGTC14qkvR5V0kORdrdLcR9sZru43TSuVzwJRtABudDyaq','ADMIN');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ventas`
--

DROP TABLE IF EXISTS `ventas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ventas` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `fecha` datetime(6) DEFAULT NULL,
  `total` decimal(38,2) DEFAULT NULL,
  `usuario` varchar(100) DEFAULT NULL,
  `usuario_id` bigint DEFAULT NULL,
  `direccion` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `nombre_cliente` varchar(255) DEFAULT NULL,
  `telefono` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKco9r9xjcdqtgd4nvnnolsr6ei` (`usuario_id`),
  CONSTRAINT `FKco9r9xjcdqtgd4nvnnolsr6ei` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=128 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ventas`
--

LOCK TABLES `ventas` WRITE;
/*!40000 ALTER TABLE `ventas` DISABLE KEYS */;
INSERT INTO `ventas` VALUES (9,'2026-03-26 19:22:14.333355',300.00,NULL,21,NULL,NULL,NULL,NULL),(10,'2026-03-27 16:19:26.670085',300.00,NULL,21,NULL,NULL,NULL,NULL),(11,'2026-03-27 18:32:05.925537',25.00,NULL,21,NULL,NULL,NULL,NULL),(12,'2026-03-27 19:13:54.687736',25.00,NULL,21,NULL,NULL,NULL,NULL),(13,'2026-03-27 19:21:13.150194',25.00,NULL,21,NULL,NULL,NULL,NULL),(14,'2026-04-02 20:10:16.103221',80.00,NULL,21,NULL,NULL,NULL,NULL),(15,'2026-04-02 20:11:55.161018',0.00,NULL,21,NULL,NULL,NULL,NULL),(16,'2026-04-02 20:12:11.460868',0.00,NULL,21,NULL,NULL,NULL,NULL),(17,'2026-04-06 19:37:39.175651',0.00,NULL,21,NULL,NULL,NULL,NULL),(18,'2026-04-06 19:41:07.081955',0.00,NULL,21,NULL,NULL,NULL,NULL),(19,'2026-04-06 19:41:10.133210',0.00,NULL,21,NULL,NULL,NULL,NULL),(20,'2026-04-06 19:49:41.256180',1200.00,NULL,21,NULL,NULL,NULL,NULL),(21,'2026-04-09 16:51:13.116957',5.00,NULL,21,NULL,NULL,NULL,NULL),(22,'2026-04-11 14:22:59.193268',430.00,NULL,21,NULL,NULL,NULL,NULL),(23,'2026-04-11 14:43:46.739302',600.00,NULL,21,NULL,NULL,NULL,NULL),(24,'2026-04-11 14:49:56.749841',380.00,NULL,21,NULL,NULL,NULL,NULL),(25,'2026-04-11 14:51:14.413460',80.00,NULL,21,NULL,NULL,NULL,NULL),(26,'2026-04-11 15:07:53.979061',430.00,NULL,21,NULL,NULL,NULL,NULL),(27,'2026-04-11 15:47:32.605391',430.00,NULL,21,NULL,NULL,NULL,NULL),(28,'2026-04-11 15:48:38.201997',380.00,NULL,21,NULL,NULL,NULL,NULL),(29,'2026-04-11 16:24:30.579194',540.00,NULL,21,NULL,NULL,NULL,NULL),(30,'2026-04-12 13:40:24.517616',680.00,NULL,21,NULL,NULL,NULL,NULL),(31,'2026-04-12 14:11:03.551039',430.00,NULL,21,NULL,NULL,NULL,NULL),(32,'2026-04-12 14:34:20.142654',1140.00,NULL,21,NULL,NULL,NULL,NULL),(33,'2026-04-12 14:35:06.236838',75.00,NULL,21,NULL,NULL,NULL,NULL),(34,'2026-04-15 14:28:15.446655',585.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com','will','981078464'),(35,'2026-04-15 14:29:24.708555',380.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com','will','981078464'),(36,'2026-04-15 14:38:37.728991',130.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com','will','981078464'),(37,'2026-04-15 14:47:57.433506',130.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com','will','981078464'),(38,'2026-04-15 14:48:20.107104',5.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com','will','981078464'),(39,'2026-04-15 15:28:12.463091',395.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com','will','981078464'),(40,'2026-04-15 15:28:45.643219',380.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com','will','981078464'),(41,'2026-04-15 15:29:23.008696',305.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com','will','981078464'),(42,'2026-04-15 15:53:41.673574',430.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com','will','981078464'),(43,'2026-04-15 15:54:45.004092',45.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com','will','981078464'),(44,'2026-04-15 15:55:21.585228',320.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com','will','981078464'),(45,'2026-04-15 16:35:52.208186',380.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com','will','981078464'),(46,'2026-04-15 16:50:15.783375',90.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com','will','981078464'),(47,'2026-04-15 18:07:33.502631',380.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com','will','981078464'),(48,'2026-04-15 18:28:39.337103',20.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com','will','981078464'),(49,'2026-04-18 14:45:22.420383',300.00,NULL,21,'','',NULL,''),(50,'2026-04-18 14:45:35.573044',80.00,NULL,21,'','',NULL,''),(51,'2026-04-18 15:19:20.844371',300.00,NULL,21,'','',NULL,''),(52,'2026-04-18 15:19:44.121941',130.00,NULL,21,'','',NULL,''),(53,'2026-04-18 15:26:42.226783',80.00,NULL,21,'','',NULL,''),(54,'2026-04-22 13:53:22.946928',115.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464'),(55,'2026-04-22 13:55:50.037674',130.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464'),(56,'2026-04-22 15:28:02.946504',310.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464'),(57,'2026-04-22 15:39:25.319593',145.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464'),(58,'2026-04-22 16:04:13.316808',328.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464'),(59,'2026-04-22 16:16:35.554583',55.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464'),(60,'2026-04-22 16:25:33.535404',10.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464'),(61,'2026-04-22 16:33:52.833692',60.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464'),(62,'2026-04-22 17:08:29.061065',310.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464'),(63,'2026-04-22 17:45:44.746086',98.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464'),(64,'2026-04-22 17:46:11.971143',15.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464'),(65,'2026-04-22 17:50:13.499104',95.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464'),(66,'2026-04-22 17:50:52.586714',10.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464'),(67,'2026-04-22 18:11:40.773850',60.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464'),(68,'2026-04-22 18:20:06.795974',130.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464'),(69,'2026-04-22 19:02:14.635250',80.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464'),(70,'2026-04-22 19:03:53.743781',15.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464'),(71,'2026-04-22 19:12:34.038679',80.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464'),(72,'2026-04-22 19:22:15.653502',100.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464'),(73,'2026-04-22 19:37:06.292345',85.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464'),(74,'2026-04-22 19:42:59.692498',10.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464'),(75,'2026-04-22 20:06:19.360256',180.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464'),(76,'2026-04-22 20:14:51.626837',760.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464'),(77,'2026-04-23 15:33:00.208768',30.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464'),(78,'2026-04-23 15:39:50.663349',315.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464'),(79,'2026-04-23 16:05:55.606270',315.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464'),(80,'2026-04-23 16:23:12.059263',320.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464'),(81,'2026-04-23 16:24:32.285372',20.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464'),(82,'2026-04-23 16:34:14.212347',20.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464'),(83,'2026-04-23 18:56:39.664568',20.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464'),(84,'2026-04-23 18:57:31.815874',25.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464'),(85,'2026-04-23 19:00:54.863855',10.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464'),(86,'2026-04-23 19:01:43.948884',300.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464'),(87,'2026-04-23 19:02:38.199613',15.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464'),(88,'2026-04-23 19:06:09.770386',10.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464'),(89,'2026-04-23 19:09:20.529627',15.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464'),(90,'2026-04-23 19:11:14.845166',25.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464'),(91,'2026-04-23 19:31:30.615848',25.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464'),(92,'2026-04-23 19:31:48.336739',15.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464'),(93,'2026-04-23 19:33:56.397047',15.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464'),(94,'2026-04-23 19:34:15.891385',15.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464'),(95,'2026-04-23 19:36:32.484959',10.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464'),(96,'2026-04-23 19:37:47.270939',80.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464'),(97,'2026-04-23 19:38:13.913189',10.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464'),(98,'2026-04-23 19:38:40.613321',5.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464'),(99,'2026-04-23 19:38:56.192037',5.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464'),(100,'2026-04-24 13:28:34.514267',80.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464'),(101,'2026-04-24 13:39:16.131210',80.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464'),(102,'2026-04-24 13:39:43.756061',60.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464'),(103,'2026-04-24 13:46:58.592255',350.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464'),(104,'2026-04-24 13:47:18.544406',5.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464'),(105,'2026-04-24 13:47:53.883823',80.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464'),(106,'2026-04-24 13:58:44.148690',80.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464'),(107,'2026-04-24 14:00:41.141800',80.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464'),(108,'2026-04-24 14:00:56.159409',10.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464'),(109,'2026-04-24 14:07:54.310210',310.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464'),(110,'2026-04-24 14:42:18.758905',80.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464'),(111,'2026-04-24 14:43:05.316512',100.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464'),(112,'2026-04-24 14:45:45.100797',80.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464'),(113,'2026-04-24 14:46:31.302856',300.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464'),(114,'2026-04-24 14:47:54.992218',80.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464'),(115,'2026-04-24 17:43:04.926427',350.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464'),(116,'2026-04-24 18:27:21.266273',80.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464'),(117,'2026-04-24 18:58:19.873073',300.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464'),(118,'2026-04-24 18:59:24.749954',10.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464'),(119,'2026-04-24 19:03:40.755935',300.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464'),(120,'2026-04-24 19:12:40.689027',80.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464'),(121,'2026-04-24 19:16:51.274219',105.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464'),(122,'2026-04-26 22:35:11.772058',610.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464'),(123,'2026-04-29 15:31:56.740966',1060.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464'),(124,'2026-04-29 15:57:52.164528',320.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464'),(125,'2026-04-29 16:09:08.401134',310.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464'),(126,'2026-04-29 16:12:54.302491',70.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464'),(127,'2026-04-29 18:27:04.803765',625.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464');
/*!40000 ALTER TABLE `ventas` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-04-29 16:16:39
