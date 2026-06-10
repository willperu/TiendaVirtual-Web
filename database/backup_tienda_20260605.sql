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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `carrito`
--

LOCK TABLES `carrito` WRITE;
/*!40000 ALTER TABLE `carrito` DISABLE KEYS */;
INSERT INTO `carrito` VALUES (2,21),(3,22),(4,30);
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
) ENGINE=InnoDB AUTO_INCREMENT=280 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalle_venta`
--

LOCK TABLES `detalle_venta` WRITE;
/*!40000 ALTER TABLE `detalle_venta` DISABLE KEYS */;
INSERT INTO `detalle_venta` VALUES (13,1,300.00,3,9),(14,1,300.00,3,10),(15,1,10.00,5,11),(16,1,15.00,6,11),(17,1,10.00,5,12),(18,1,15.00,6,12),(19,1,10.00,5,13),(20,1,15.00,6,13),(21,1,80.00,2,14),(22,4,300.00,3,20),(23,1,5.00,7,21),(24,1,80.00,2,22),(25,1,300.00,3,22),(26,1,50.00,1,22),(27,2,300.00,3,23),(28,1,80.00,2,24),(29,1,300.00,3,24),(30,1,80.00,2,25),(31,1,80.00,2,26),(32,1,50.00,1,26),(33,1,300.00,3,26),(34,1,80.00,2,27),(35,1,300.00,3,27),(36,1,50.00,1,27),(37,1,80.00,2,28),(38,1,300.00,3,28),(39,3,80.00,2,29),(40,1,300.00,3,29),(41,1,80.00,2,30),(42,2,300.00,3,30),(43,1,300.00,3,31),(44,1,50.00,1,31),(45,1,80.00,2,31),(46,3,80.00,2,32),(47,3,300.00,3,32),(48,2,15.00,6,33),(49,3,5.00,7,33),(50,3,10.00,5,33),(51,1,300.00,3,34),(52,2,80.00,2,34),(53,2,50.00,1,34),(54,1,10.00,5,34),(55,1,15.00,6,34),(56,1,80.00,2,35),(57,1,300.00,3,35),(58,1,80.00,2,36),(59,1,50.00,1,36),(60,1,80.00,2,37),(61,1,50.00,1,37),(62,1,5.00,7,38),(63,1,300.00,3,39),(64,1,80.00,2,39),(65,1,15.00,6,39),(66,1,300.00,3,40),(67,1,80.00,2,40),(68,1,300.00,3,41),(69,1,5.00,7,41),(70,1,80.00,2,42),(71,1,300.00,3,42),(72,1,50.00,1,42),(73,1,15.00,8,43),(74,1,15.00,6,43),(75,1,5.00,7,43),(76,1,10.00,5,43),(77,1,15.00,6,44),(78,1,5.00,7,44),(79,1,300.00,3,44),(80,1,80.00,2,45),(81,1,300.00,3,45),(82,1,80.00,2,46),(83,1,10.00,5,46),(84,1,80.00,2,47),(85,1,300.00,3,47),(86,1,15.00,6,48),(87,1,5.00,7,48),(88,1,300.00,3,49),(89,1,80.00,2,50),(90,1,300.00,3,51),(91,1,80.00,2,52),(92,1,50.00,1,52),(93,1,80.00,2,53),(94,1,5.00,7,54),(95,1,10.00,5,54),(96,2,50.00,1,54),(97,1,80.00,2,55),(98,1,50.00,1,55),(99,1,10.00,5,56),(100,1,300.00,3,56),(101,1,80.00,2,57),(102,1,50.00,1,57),(103,1,15.00,6,57),(104,1,300.00,3,58),(105,1,15.00,8,58),(106,1,8.00,10,58),(107,1,5.00,7,58),(108,1,10.00,5,59),(109,1,15.00,8,59),(110,2,15.00,6,59),(111,1,10.00,5,60),(112,1,10.00,5,61),(113,1,50.00,1,61),(114,1,300.00,3,62),(115,1,10.00,5,62),(116,1,80.00,2,63),(117,1,10.00,5,63),(118,1,8.00,10,63),(119,1,15.00,8,64),(120,1,10.00,5,65),(121,1,80.00,2,65),(122,1,5.00,7,65),(123,1,10.00,5,66),(124,1,10.00,5,67),(125,1,50.00,1,67),(126,1,80.00,2,68),(127,1,50.00,1,68),(128,1,50.00,1,69),(129,1,15.00,6,69),(130,1,15.00,8,69),(131,1,15.00,8,70),(132,1,50.00,1,71),(133,1,15.00,6,71),(134,1,15.00,8,71),(135,1,80.00,2,72),(136,1,15.00,8,72),(137,1,5.00,7,72),(138,1,5.00,7,73),(139,1,50.00,1,73),(140,1,15.00,6,73),(141,1,15.00,8,73),(142,1,10.00,5,74),(143,2,10.00,5,75),(144,2,80.00,2,75),(145,2,80.00,2,76),(146,2,300.00,3,76),(147,3,10.00,5,77),(148,3,5.00,7,78),(149,1,300.00,3,78),(150,1,15.00,6,79),(151,1,300.00,3,79),(152,1,15.00,6,80),(153,1,5.00,7,80),(154,1,300.00,3,80),(155,1,5.00,7,81),(156,1,15.00,6,81),(157,1,15.00,6,82),(158,1,5.00,7,82),(159,1,15.00,6,83),(160,1,5.00,7,83),(161,1,10.00,5,84),(162,1,15.00,6,84),(163,1,10.00,5,85),(164,1,300.00,3,86),(165,1,15.00,6,87),(166,1,10.00,5,88),(167,1,15.00,6,89),(168,1,10.00,5,90),(169,1,15.00,8,90),(170,1,10.00,5,91),(171,1,15.00,6,91),(172,1,15.00,8,92),(173,1,15.00,6,93),(174,1,15.00,8,94),(175,1,10.00,5,95),(176,1,80.00,2,96),(177,1,10.00,5,97),(178,1,5.00,7,98),(179,1,5.00,7,99),(180,1,80.00,2,100),(181,1,80.00,2,101),(182,1,50.00,1,102),(183,1,10.00,5,102),(184,1,50.00,1,103),(185,1,300.00,3,103),(186,1,5.00,7,104),(187,1,80.00,2,105),(188,1,80.00,2,106),(189,1,80.00,2,107),(190,1,10.00,5,108),(191,1,300.00,3,109),(192,1,10.00,5,109),(193,1,80.00,2,110),(194,2,50.00,1,111),(195,1,80.00,2,112),(196,1,300.00,3,113),(197,1,80.00,2,114),(198,1,50.00,1,115),(199,1,300.00,3,115),(200,1,80.00,2,116),(201,1,300.00,3,117),(202,1,10.00,5,118),(203,1,300.00,3,119),(204,1,80.00,2,120),(205,2,50.00,1,121),(206,1,5.00,7,121),(207,2,300.00,3,122),(208,1,10.00,5,122),(209,2,80.00,2,123),(210,3,300.00,3,123),(211,1,300.00,3,124),(212,2,10.00,5,124),(213,1,10.00,5,125),(214,1,300.00,3,125),(215,2,10.00,5,126),(216,1,50.00,1,126),(217,4,80.00,2,127),(218,1,300.00,3,127),(219,1,5.00,7,127),(220,1,80.00,2,128),(221,1,50.00,1,128),(222,1,20.00,14,128),(223,1,80.00,2,129),(224,1,300.00,3,129),(225,1,80.00,2,130),(226,1,5.00,7,130),(227,1,10.00,5,130),(228,1,80.00,2,131),(229,1,15.00,6,131),(230,1,5.00,7,131),(231,1,10.00,5,132),(232,1,20.00,14,132),(233,1,700.00,15,133),(234,1,15.00,8,133),(235,2,8.00,10,133),(236,1,10.00,5,134),(237,1,5.00,7,134),(238,1,80.00,2,134),(239,1,300.00,3,135),(240,1,120.00,13,135),(241,1,50.00,1,136),(242,1,10.00,5,136),(243,1,15.00,8,136),(244,1,10.00,5,137),(245,1,20.00,14,137),(246,1,10.00,5,138),(247,1,15.00,8,138),(248,1,8.00,10,138),(249,1,20.00,14,139),(250,1,700.00,15,139),(251,1,15.00,8,139),(252,1,10.00,5,140),(253,1,5.00,12,141),(254,1,20.00,14,141),(255,1,20.00,14,142),(256,1,8.00,10,142),(257,1,15.00,8,142),(258,1,10.00,5,143),(259,1,5.00,7,143),(260,1,10.00,5,144),(261,1,300.00,3,144),(262,1,300.00,3,145),(263,1,5.00,7,145),(264,1,15.00,6,146),(265,1,5.00,7,146),(266,1,15.00,6,147),(267,1,5.00,7,147),(268,1,50.00,1,148),(269,1,25.00,5,149),(270,2,31.90,12,150),(271,3,600.00,3,151),(272,1,25.00,5,152),(273,5,15.00,6,153),(274,1,12.00,7,154),(275,1,600.00,3,154),(276,3,120.99,13,155),(277,1,22.89,14,155),(278,1,15.00,6,156),(279,1,349.99,27,157);
/*!40000 ALTER TABLE `detalle_venta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `historial_estado_pedido`
--

DROP TABLE IF EXISTS `historial_estado_pedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `historial_estado_pedido` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `estado` enum('PENDIENTE','PAGADO','PREPARANDO','ENVIADO','EN_CAMINO','ENTREGADO','CANCELADO') DEFAULT NULL,
  `fecha` datetime(6) DEFAULT NULL,
  `venta_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKptdjgfqwcny9dmeuovpholwyq` (`venta_id`),
  CONSTRAINT `FKptdjgfqwcny9dmeuovpholwyq` FOREIGN KEY (`venta_id`) REFERENCES `ventas` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `historial_estado_pedido`
--

LOCK TABLES `historial_estado_pedido` WRITE;
/*!40000 ALTER TABLE `historial_estado_pedido` DISABLE KEYS */;
INSERT INTO `historial_estado_pedido` VALUES (1,'ENVIADO','2026-05-14 15:29:52.008817',137),(2,'PENDIENTE','2026-05-14 15:44:38.916553',141),(3,'ENVIADO','2026-05-14 15:47:09.158330',141),(4,'PENDIENTE','2026-05-15 16:41:31.199733',142),(5,'PENDIENTE','2026-05-15 18:42:23.482442',143),(6,'PENDIENTE','2026-05-15 19:52:07.887758',144),(7,'PENDIENTE','2026-05-16 00:21:05.201831',145),(8,'PENDIENTE','2026-05-16 02:12:09.818105',146),(9,'PENDIENTE','2026-05-18 15:21:56.054847',147),(10,'ENVIADO','2026-05-18 16:13:18.508914',142),(11,'ENVIADO','2026-05-18 16:13:18.508914',142),(12,'EN_CAMINO','2026-05-18 16:13:24.940705',143),(13,'EN_CAMINO','2026-05-18 16:13:24.942718',143),(14,'ENTREGADO','2026-05-18 16:13:31.364632',144),(15,'ENTREGADO','2026-05-18 16:13:31.364632',144),(16,'PENDIENTE','2026-05-22 15:38:22.270904',148),(17,'PENDIENTE','2026-05-22 19:31:49.406769',149),(18,'PENDIENTE','2026-05-22 19:51:42.384595',150),(19,'PENDIENTE','2026-05-22 20:11:12.125083',151),(20,'PREPARANDO','2026-05-23 13:37:33.237150',150),(21,'PREPARANDO','2026-05-23 13:37:33.237150',150),(22,'ENVIADO','2026-05-23 13:37:36.003245',151),(23,'ENVIADO','2026-05-23 13:37:36.003245',151),(24,'PENDIENTE','2026-05-23 13:55:30.875337',152),(25,'PENDIENTE','2026-05-24 19:21:01.548817',153),(26,'PENDIENTE','2026-05-24 19:21:47.885000',154),(27,'PENDIENTE','2026-05-28 14:46:51.300455',155),(28,'PENDIENTE','2026-06-01 14:18:04.945444',156),(29,'PENDIENTE','2026-06-04 19:07:48.023831',157);
/*!40000 ALTER TABLE `historial_estado_pedido` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=358 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_carrito`
--

LOCK TABLES `item_carrito` WRITE;
/*!40000 ALTER TABLE `item_carrito` DISABLE KEYS */;
/*!40000 ALTER TABLE `item_carrito` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_reset_tokens` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `expiry_date` datetime(6) DEFAULT NULL,
  `token` varchar(255) DEFAULT NULL,
  `usuario_id` bigint DEFAULT NULL,
  `verification_code` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_nmq2xlhxauheilqejd5py9xx8` (`usuario_id`),
  CONSTRAINT `FKp3log76r68owjybas53j8jaig` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_reset_tokens`
--

LOCK TABLES `password_reset_tokens` WRITE;
/*!40000 ALTER TABLE `password_reset_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_reset_tokens` ENABLE KEYS */;
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
  `descripcion` longtext,
  `fecha_creacion` datetime DEFAULT NULL,
  `imagen` varchar(255) DEFAULT NULL,
  `colores` varchar(255) DEFAULT NULL,
  `tallas` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UKmlgw7js72hh2xtd4mvpdqfsbe` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productos`
--

LOCK TABLES `productos` WRITE;
/*!40000 ALTER TABLE `productos` DISABLE KEYS */;
INSERT INTO `productos` VALUES (1,'Mouse Inalambrico para PC',25.00,37,'ELECTRONICOS','Com uma resolução de 1200 DPI, este mouse oferece uma precisão excepcional. Independentemente da tarefa em mãos, desde navegar na web até trabalhar em projetos criativos, você pode contar com um rastreamento suave e uma resposta rápida aos seus movimentos. A frequência sem fio de 2.4GHz garante uma conexão estável e confiável, minimizando a interferência e garantindo um desempenho consistente.',NULL,'Informatica/mouse.png','Negro',''),(2,'Teclado Gamer Inalambrico',80.00,14,'ELECTRONICOS','',NULL,'Informatica/teclado.png','',''),(3,'Monitor para PC Alta Resolucion',600.00,20,'ELECTRONICOS','Tecnologia IPS (In-plane switching)\nDetalhes do tempo de resposta\n8 ms GTG\n4 ms GTG (Rápido)\n1 ms MPRT\nRelação de aspecto\n16:9\nPasso de Pixel\n0.27450mm x 0.27450mm\nÂngulo de visualização horizontal\n178°\nângulo de visualização vertical\n178°\nTipo de montagem\nMontagem em painel\nTecnologia de iluminação traseira\nSistema LED Edgelight\nAdequado para HDCP\nSim\nÂngulo inclinação\n-5° para 21°\nCaracterísticas\nTecnologia de conforto ocular\nAnti-ofuscante\nSlot de bloqueio de cabo\nBFR Free\nPVC grátis\nVidro sem arsênico\nLivre de mercúrio',NULL,'Informatica/monitor.png','Negro','18\'\'- 24\'\'- 36\'\''),(5,'Caja de Focos LED x3 100wts',25.00,22,'HOGAR','Datos Técnicos\nBase: E27\nColor de Luz: 3.000°K\nConsumo: 4W\nVoltaje: 220V\nFlujo Lumínico: 280 Lm\nÁngulo de Apertura: 130°\nProtección IP: IP20\nDimeable: No\nDimensiones: Ø50×85 mm\n',NULL,'hogar/lampada100wts.png','Blanco frio',''),(6,'Cargador Rapido de Celular',15.00,8,'ELECTRONICOS','Cargador para Samsung 45W Carga Rápida S20 Note 20 S21\n¡Carga tu Samsung en tiempo récord con el Cargador para Samsung 45W! Este cargador ultrarrápido te devuelve al 100% de batería en un instante, para que no pierdas el ritmo de tu día a día. Compatible con modelos como el S20, Note 20 y S21, este cargador OEM es la solución perfecta para una carga eficiente y segura.\n\nCarga super rápida de 45W.\nCompatible con Samsung S20, Note 20, S21.\nIncluye cable USB-C a USB-C.\nColor negro.','2026-03-17 00:27:36','hogar/carregadordecelular.png','Negro',''),(7,'Pilas Duracell AAA x4 Unidades',12.00,0,'HOGAR','Ficha del producto:\n1-Marca: DURACELL\n2-Modelo: PILAAAX4\n4-Contenido: Pack de 4\n6-Hecho en: China\n7-Información adicional: PILAAAX4\n8-Característica comercial: PILAAAX4\n9-Condicion del producto: Nuevo','2026-03-17 15:43:38','hogar/pilha3.5v.png','',''),(8,'Pila Duracell 9v Alcalina',20.00,23,'HOGAR','Pila alcalina de larga duración con una capacidad energética de 9V, respalda con la calidad que solo el líder mundial en pilas, Duracell puede ofrecer.\nPila 9V compuesto por dióxido de magnesio, zinc, hidróxido de potasio, grafito y óxido de zinc, diseñado para dar enérgia por un determinado tiempo a dispositivos que requieran su uso.','2026-04-08 13:47:00','hogar/pilha9v.png','',''),(10,'Gillette Prestobarba 3 Carbono 2 Unidades',19.90,44,'HOGAR','La nueva rasuradora desechable Gillette Prestobarba 3 Carbono que brinda una sensación de limpieza profunda después de su uso. Cuenta con tres (3) hojas montadas sobre resortes independientes y una cabeza móvil que se ajustan al contorno de la cara, para lograr una mejor afeitada. Además, su mango de goma antideslizante te brindará un buen control al rasurarte. Para una mejor experiencia al rasurarte, prueba usarla con las Espumas para Afeitar de Gillette.',NULL,'hogar/prestobarba.png','',''),(12,'Encendedor Linterna Recargable Electrico',31.90,20,'HOGAR','Características destacadas:3 modos de luz: alta, baja y parpadeante.Función de encendido integrada: ideal para camping y actividades al aire libre.Batería de litio recargable (incluida) vía USB Tipo-C.Incluye estuche, cable, manual y presentación elegante para regalar.Compacta, ligera y fácil de llevar como llavero.Esta linterna no solo ofrece una iluminación potente de hasta 200 lúmenes y alcance de 100 metros, sino que también te ayuda a estar preparado en todo momento.Ideal para Día del Padre, San Valentín, cumpleaños o como accesorio.','2026-04-17 18:09:05','hogar/isqueiro.png','Negro','Mini - Llavero'),(13,'Ventilador de Mesa Miray VMC-951 50W',120.99,46,'HOGAR','Tamaño: 12 pulgadas, perfecto para mesas y superficies pequeñas.\nDiseño: Compacto y moderno en color blanco, que se adapta a cualquier entorno.\nOscilación: Sí, para un flujo de aire más amplio y uniforme en la habitación.\nNúmero de velocidades: 3 niveles de velocidad para ajustar el flujo de aire a tus necesidades.\nTemporizador: 60 minutos, permitiéndote configurar el tiempo de funcionamiento según tus preferencias.\nControl remoto: Incluido, para que puedas ajustar la velocidad y otras funciones cómodamente desde la distancia.\nMaterial: Plástico resistente de alta calidad, fácil de mantener y duradero.\nAlimentación: Red eléctrica, ideal para un uso prolongado.','2026-05-01 23:38:08','hogar/ventilador.png','Negro - Blanco',''),(14,'Multipuerto Entrada Adaptador Hub USB',22.89,18,'ELECTRONICOS','Sistema de soporte: Windows 2000/2003/ME/XP/Vista/WIN 7/8/10 o Mac OS 8,1 o superior. USB 3,0, 10 veces más rápido que USB 2,0, velocidad de transferencia de hasta 5Gbps. Compatible con las especificaciones USB 2,0 y 1,1. Soporta voltaje de sobrecarga y función de protección entre corriente, puede proteger el equipo conectado y el concentrador en sí de manera efectiva cuando se activa repentinamente.','2026-05-01 23:45:21','Informatica/hub.png','Negro',''),(15,'Smartwatch Ultra 2025 47mm LTE',1699.99,48,'ROPA','Un asistente intuitivo, justo en tu muñeca: obtén un poco de ayuda adicional cuando estés pasando por tu zona de comodidad, justo en tu muñeca. Galaxy Watch Ultra cuenta con un asistente personal de inteligencia artificial6 que te ayuda a hacer las cosas con manos libres\nUn simple número. Un mundo de conocimientos: comprende mejor tu cuerpo usando Energy Score con Galaxy AI.7 Tu Galaxy Watch Ultra analiza el sueño, la actividad y la frecuencia cardíaca de ayer8 para darte un resumen de tu bienestar general varias veces al día\nResistente. Fiable. Listo para cualquier cosa: sube el pico más alto. En bicicleta por el largo camino a casa. El diseño de titanio duradero es nuestro más duro hasta ahora, capaz de soportar los rigores de tu entrenamiento, incluyendo condiciones lluviosas o polvorientas, incluso natación en el océano.9','2026-05-02 14:03:37','hogar/smartwatch.png','Negro - Azul',''),(16,'Pantalón Montaria Femenino',79.80,24,'ROPA','Perfecto pantalón con un diseño versátil y moderno,lo puedes combinar con sandalias,o el calzado que prefieras. Estupendo para toda ocasión,lo puedes usar durante todas las estaciones del año, este pantalón te hará lucir  FRESCA , ELEGANTE y sentirte CÓMODA.\n\nTENEMOS VARIEDAD DE COLORES\nMATERIAL: Algodón\nPAIS DE ORIGEN: China','2026-05-20 20:28:41','RopaFemenina/Pantalon_Montaria_Femenino.png','Negro - Azul- Marron- Blanco','S,M,L,XL'),(17,'Pantalon Bandagem Femenino',100.00,46,'ROPA','Bonito pantalón de corte acampanado con efecto de faja y cintura alta. Su corte acampanado combinado con el efecto de faja moldea el cuerpo de manera incomparable, además la cintura alta realza la figura. Fácil de combinar y adecuado para cualquier ocasión.  \n\nEsta prenda definitivamente es para vestir y “lucirse”. Un excelente consejo es usarla con tacones, haciendo que las piernas se vean más largas y la cintura más delgada.','2026-05-20 21:57:13','RopaFemenina/pantaBandagem.png','Negro - Azul- Marron- Blanco- Verde','S,M,L,XL'),(18,'Pantalon Jeans Femennino',119.90,50,'ROPA','Elaborado Denim Premium Stretch con 3 botones, bolsillos delanteros funcionales y con pliegues levanta cola.\n\n Ajuste perfecto: El tejido denim premium con stretch se adapta a tu cuerpo como una segunda piel, brindándote comodidad y libertad de movimiento.\n\n Estilo elegante: El diseño clásico de 3 botones y los bolsillos delanteros funcionales le dan un toque de sofisticación a tu look.','2026-05-20 22:02:01','RopaFemenina/pantaJeans.png','Azul','S,M,L'),(19,'Pantalón Rivana Femenino',57.95,37,'ROPA','Confeccionada em tecido ribana de alta qualidade, esta peça oferece um toque suave à pele e uma elasticidade que se adapta perfeitamente ao corpo, proporcionando liberdade total de movimento.\n\nA modelagem favorece as curvas, enquanto a elegante listra lateral não só adiciona um toque de estilo esportivo-chic, mas também contribui para alongar a silhueta. Perfeita para looks casuais do dia a dia, combinações mais arrumadas ou para o conforto do home office.\n\nUma peça versátil e indispensável no seu guarda-roupa, que une tendência, conforto e valorização do corpo!','2026-05-20 22:04:29','RopaFemenina/pantaRivana.png','Crema, Negro','S,M,L'),(20,'Pantalona Verano - Otoño',88.35,70,'ROPA','Ya sea en una reunión importante o en una cena familiar, irradiarás encanto con elegancia natural. Con un corte suave, estos pantalones aumentan tu confianza, permitiendo que tu encanto incomparable brille.  \nDi adiós al incomodidad de la ropa formal que no resalta tu belleza natural. Estos pantalones anchos combinan perfectamente estilo, comodidad e inclusión, permitiéndote aceptar tu autenticidad.  \nCompresión suave que moldea el cuerpo proporcionando seguridad y comodidad durante el uso, versatilidad social y profesional perfecta para ocasiones formales y eventos especiales.','2026-05-20 22:05:54','RopaFemenina/pantalona.png','Naranja, Blanco','S,M,L,XL'),(21,'Camiiseta Lacoste Masculino',141.90,45,'ROPA','Lacoste aumentó las apuestas en el juego de la ropa deportiva elegante con la invención del polo en 1933. Nació el Original L.12.12, con cuello, banda con botones y un nuevo tejido de punto. El histórico diseño slim fit presenta un corte entallado. Confeccionado con más de 20 kilómetros de hilo, con un cocodrilo bordado formado por 2367 puntos.\nEl tejido de punto piqué característico de Lacoste.\nAcabado acanalado en cuello y mangas.\nCorte ajustado, corte ajustado\nCocodrilo bordado en el pecho.\nCocodrilo bordado cosido en el pecho','2026-05-20 22:13:21','CamisaMasculina/camisaLacoste.png','Crema, Negro, Azul','S,M,L'),(22,'Camiseta Levis Masculino',99.20,50,'ROPA','Esta Polo es un clásico, tanto por su estampado como por su corte. Tiene manga corta, corte regular y cuello redondo; es versatilidad para todos los días.','2026-05-20 22:16:17','CamisaMasculina/camisaLevis.png','','S,M,L'),(24,'Camiseta Levis Adulto Masculino',149.95,60,'ROPA','Un polo versátil que puedes utilizar con tus jeans, chinos o shorts favoritos. Con una textura clásica de piqué y logotipo de Levi\'s bordado en el pecho., 35883-0005 NUESTRO ESTILO ES TREMENDAMENTE ACTUAL, PERO EMPEZAMOS EN 1853. Icónicos. Originales. Atemporales. Levi Strauss fue un pionero con su invento de los \"blue jeans\" o vaqueros. Basados en innovación y calidad, Levi Strauss & Co es la primera empresa basada en San Francisco en producir prendas que hoy se llaman blue jeans,','2026-05-20 22:18:20','CamisaMasculina/camisaLevis2.png','Rojo, Azul, Negro, Blanco','S,M,L'),(25,'Polo Nike LBR PK4 Masculino',189.75,50,'ROPA','Comodidad Superior: Fabricado en algodón de alta calidad para una sensación suave y confortable durante todo el día.\nLibertad de Movimiento: Diseño regular fit que permite una total libertad de movimiento en tus actividades físicas.\nEstilo Versátil: Su diseño minimalista y color negro lo hacen fácil de combinar con cualquier outfit deportivo o casual.\nIdeal para Training: Perfecto para entrenamientos de alta intensidad, gracias a su transpirabilidad y confort.\nFácil Cuidado: El algodón es un material fácil de lavar y mantener, garantizando la durabilidad del polo.\nExperimenta el confort y el rendimiento que solo Nike puede ofrecerte. El Polo LBR PK4 es la elección perfecta para quienes buscan un equilibrio entre funcionalidad y estilo deportivo.','2026-05-20 22:20:01','CamisaMasculina/camisaNike.png','Rojo, Azul, Negro, Blanco','S,M,L,XL'),(26,'Camiseta Polo Masculino',80.99,40,'ROPA','Nueva camisa POLO masculina de manga corta, casual para negocios, de color liso, elegante, transpirable y cómoda, una prenda versátil para el verano.','2026-05-20 22:21:51','CamisaMasculina/camisaPolo.png','Rojo, Azul, Negro, Blanco','S,M,L'),(27,'Zapatilla Adidas Streettalk - JP8275',349.99,19,'ROPA','Corte clásico\nSistema de amarre de pasadores\nExterior de material sintético\nForro interno de tela\nSuela de caucho\nColor del artículo: Cloud White / Core Black / Gold Metallic\nNúmero de artículo: JP8275','2026-05-20 22:25:20','TenisFemenino/tenisAdidas.png','Blanco','36, 38, 41'),(28,'Zapatilla Olympikus Versa - 263 Femenino',489.89,35,'ROPA','Comodidad superior: Plantilla de PVC que ofrece amortiguación y confort durante todo el día.\nDiseño versátil: Perfectas para combinar con looks casuales y deportivos, adaptándose a tu estilo personal.\nAjuste personalizado: El sistema de cordones permite un ajuste seguro y cómodo, brindando soporte a tus pies.\nEstilo femenino: Los tonos pasteles y el diseño moderno te harán destacar con un toque de elegancia sutil.\nLigereza y flexibilidad: Disfruta de la libertad de movimiento gracias a su diseño ligero y materiales flexibles.','2026-05-23 02:15:48','TenisFemenino/tenisOlimpikus.png','Blanco, Rosado','36, 38, 40, 41'),(29,'Zapatillas Running Mujer Puma Flyer Lite 3 Evo',149.90,25,'ROPA','Ficha del producto:\nModelo: 312350 53\nPaís de origen: Vietnam\nCondicion del producto: Nuevo\nMarca: PUMA\nGénero: Mujer\nDisciplina: Running\nMaterial principal: Textil\nImpermeabilidad de la tela: No\nTipo de caña: Media','2026-05-23 02:21:48','TenisFemenino/tenisPuma.png','Negro','36, 38, 40, 41'),(30,'Zapatillas Reebok Glide Up  100201277 Mujer',261.50,35,'ROPA','Comodidad Superior: Plantilla OrthoLite® Memory Tech que se adapta a la forma de tu pie, brindando confort duradero.\nEstilo Urbano Versátil: Diseño minimalista en cuero color negro que combina con cualquier look.\nAmortiguación y Ligereza: Mediasuela de EVA que absorbe impactos y ofrece una pisada suave.\nDurabilidad Garantizada: Suela de caucho resistente que proporciona tracción y agarre en diversas superficies.\nAjuste Seguro: Cierre de cordones que permite un ajuste personalizado para mayor estabilidad.','2026-05-23 02:28:18','TenisFemenino/tenisReebok.png','Negro, Blanco','36, 38, 40, 41'),(31,'Zapatillas Reebok Glide Low 100208666 Mujer',223.30,35,'ROPA','Exterior en capas de nailon con superposiciones de gamuza y cuero sintético para mayor durabilidad y estilo.\nSuela de caucho que proporciona tracción y resistencia al desgaste.\nPlantilla de tela que ofrece confort y suavidad en cada pisada.\nCierre con cordones para un ajuste seguro y personalizado.\nIdeales para complementar tu estilo de vida urbano con un toque retro.','2026-05-23 02:34:08','TenisFemenino/tenisReebok2.png','Blanco','36, 38, 40, 41'),(32,'Arrocera DIAMONDFORCE Oster Df 2.2L Negra',249.00,30,'HOGAR','Condicion del producto	Nuevo\r\nHecho en	China\r\nGarantía del proveedor	1 año\r\nDetalle de la garantía	Por falla de fábrica\r\nPotencia	1700 watts\r\nModelo	CKSTRC12DFBLK\r\nMaterial de electrodomésticos	Varios\r\nAntiadherente	Sí\r\nColor	Negro\r\nCapacidad	2,2 litros\r\nIncluye	Accesorios incluidos: Incluye vaporera, taza medidora, cuchara y cable desmontable, para que preparar tus comidas sea más fácil y cómodo\r\nVoltaje	220V','2026-05-29 16:52:00','hogar/arrocera.png','Negro','');
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
  `email` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `usuario` (`usuario`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (21,'admin','$2a$10$NIHcUFsIJQF3cELXELKhNuh/wovfAwG3BVjB49T33oGpxGG9PFgFy','ADMIN','willperu.tienda@gmail.com'),(22,'will','$2a$10$AGz3O5zNoquwxt.AnI0ex.d3GTNRO61mxoDe2XN3ej8SFPopZZOEy','CLIENTE',NULL),(29,'willandes','$2a$10$.Zd9tARfwwgBg2Fi39d74OGubXMLp3Dq02jvJzQwT2V/m1p32/ICG','ADMIN','will.andesbrazil@gmail.com'),(30,'will2','$2a$10$7yWHSz/UPt17DHg7/78Ug.ch/d9.Bh8dJv4FIEum8o.OgJN6qeVKW','CLIENTE','will2@gmail.com');
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
  `estado_pedido` enum('PENDIENTE','PAGADO','PREPARANDO','ENVIADO','EN_CAMINO','ENTREGADO','CANCELADO') DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKco9r9xjcdqtgd4nvnnolsr6ei` (`usuario_id`),
  CONSTRAINT `FKco9r9xjcdqtgd4nvnnolsr6ei` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=158 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ventas`
--

LOCK TABLES `ventas` WRITE;
/*!40000 ALTER TABLE `ventas` DISABLE KEYS */;
INSERT INTO `ventas` VALUES (9,'2026-03-26 19:22:14.333355',300.00,NULL,21,NULL,NULL,NULL,NULL,'PENDIENTE'),(10,'2026-03-27 16:19:26.670085',300.00,NULL,21,NULL,NULL,NULL,NULL,'PENDIENTE'),(11,'2026-03-27 18:32:05.925537',25.00,NULL,21,NULL,NULL,NULL,NULL,'PENDIENTE'),(12,'2026-03-27 19:13:54.687736',25.00,NULL,21,NULL,NULL,NULL,NULL,'PENDIENTE'),(13,'2026-03-27 19:21:13.150194',25.00,NULL,21,NULL,NULL,NULL,NULL,'PENDIENTE'),(14,'2026-04-02 20:10:16.103221',80.00,NULL,21,NULL,NULL,NULL,NULL,'PENDIENTE'),(15,'2026-04-02 20:11:55.161018',0.00,NULL,21,NULL,NULL,NULL,NULL,'PENDIENTE'),(16,'2026-04-02 20:12:11.460868',0.00,NULL,21,NULL,NULL,NULL,NULL,'PENDIENTE'),(17,'2026-04-06 19:37:39.175651',0.00,NULL,21,NULL,NULL,NULL,NULL,'PENDIENTE'),(18,'2026-04-06 19:41:07.081955',0.00,NULL,21,NULL,NULL,NULL,NULL,'PENDIENTE'),(19,'2026-04-06 19:41:10.133210',0.00,NULL,21,NULL,NULL,NULL,NULL,'PENDIENTE'),(20,'2026-04-06 19:49:41.256180',1200.00,NULL,21,NULL,NULL,NULL,NULL,'PENDIENTE'),(21,'2026-04-09 16:51:13.116957',5.00,NULL,21,NULL,NULL,NULL,NULL,'PENDIENTE'),(22,'2026-04-11 14:22:59.193268',430.00,NULL,21,NULL,NULL,NULL,NULL,'PENDIENTE'),(23,'2026-04-11 14:43:46.739302',600.00,NULL,21,NULL,NULL,NULL,NULL,'PENDIENTE'),(24,'2026-04-11 14:49:56.749841',380.00,NULL,21,NULL,NULL,NULL,NULL,'PENDIENTE'),(25,'2026-04-11 14:51:14.413460',80.00,NULL,21,NULL,NULL,NULL,NULL,'PENDIENTE'),(26,'2026-04-11 15:07:53.979061',430.00,NULL,21,NULL,NULL,NULL,NULL,'PENDIENTE'),(27,'2026-04-11 15:47:32.605391',430.00,NULL,21,NULL,NULL,NULL,NULL,'PENDIENTE'),(28,'2026-04-11 15:48:38.201997',380.00,NULL,21,NULL,NULL,NULL,NULL,'PENDIENTE'),(29,'2026-04-11 16:24:30.579194',540.00,NULL,21,NULL,NULL,NULL,NULL,'PENDIENTE'),(30,'2026-04-12 13:40:24.517616',680.00,NULL,21,NULL,NULL,NULL,NULL,'PENDIENTE'),(31,'2026-04-12 14:11:03.551039',430.00,NULL,21,NULL,NULL,NULL,NULL,'PENDIENTE'),(32,'2026-04-12 14:34:20.142654',1140.00,NULL,21,NULL,NULL,NULL,NULL,'PENDIENTE'),(33,'2026-04-12 14:35:06.236838',75.00,NULL,21,NULL,NULL,NULL,NULL,'PENDIENTE'),(34,'2026-04-15 14:28:15.446655',585.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com','will','981078464','PENDIENTE'),(35,'2026-04-15 14:29:24.708555',380.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com','will','981078464','PENDIENTE'),(36,'2026-04-15 14:38:37.728991',130.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com','will','981078464','PENDIENTE'),(37,'2026-04-15 14:47:57.433506',130.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com','will','981078464','PENDIENTE'),(38,'2026-04-15 14:48:20.107104',5.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com','will','981078464','PENDIENTE'),(39,'2026-04-15 15:28:12.463091',395.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com','will','981078464','PENDIENTE'),(40,'2026-04-15 15:28:45.643219',380.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com','will','981078464','PENDIENTE'),(41,'2026-04-15 15:29:23.008696',305.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com','will','981078464','PENDIENTE'),(42,'2026-04-15 15:53:41.673574',430.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com','will','981078464','PENDIENTE'),(43,'2026-04-15 15:54:45.004092',45.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com','will','981078464','PENDIENTE'),(44,'2026-04-15 15:55:21.585228',320.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com','will','981078464','PENDIENTE'),(45,'2026-04-15 16:35:52.208186',380.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com','will','981078464','PENDIENTE'),(46,'2026-04-15 16:50:15.783375',90.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com','will','981078464','PENDIENTE'),(47,'2026-04-15 18:07:33.502631',380.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com','will','981078464','PENDIENTE'),(48,'2026-04-15 18:28:39.337103',20.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com','will','981078464','PENDIENTE'),(49,'2026-04-18 14:45:22.420383',300.00,NULL,21,'','',NULL,'','PENDIENTE'),(50,'2026-04-18 14:45:35.573044',80.00,NULL,21,'','',NULL,'','PENDIENTE'),(51,'2026-04-18 15:19:20.844371',300.00,NULL,21,'','',NULL,'','PENDIENTE'),(52,'2026-04-18 15:19:44.121941',130.00,NULL,21,'','',NULL,'','PENDIENTE'),(53,'2026-04-18 15:26:42.226783',80.00,NULL,21,'','',NULL,'','PENDIENTE'),(54,'2026-04-22 13:53:22.946928',115.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464','PENDIENTE'),(55,'2026-04-22 13:55:50.037674',130.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464','PENDIENTE'),(56,'2026-04-22 15:28:02.946504',310.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464','PENDIENTE'),(57,'2026-04-22 15:39:25.319593',145.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464','PENDIENTE'),(58,'2026-04-22 16:04:13.316808',328.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464','PENDIENTE'),(59,'2026-04-22 16:16:35.554583',55.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464','PENDIENTE'),(60,'2026-04-22 16:25:33.535404',10.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464','PENDIENTE'),(61,'2026-04-22 16:33:52.833692',60.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464','PENDIENTE'),(62,'2026-04-22 17:08:29.061065',310.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464','PENDIENTE'),(63,'2026-04-22 17:45:44.746086',98.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464','PENDIENTE'),(64,'2026-04-22 17:46:11.971143',15.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464','PENDIENTE'),(65,'2026-04-22 17:50:13.499104',95.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464','PENDIENTE'),(66,'2026-04-22 17:50:52.586714',10.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464','PENDIENTE'),(67,'2026-04-22 18:11:40.773850',60.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464','PENDIENTE'),(68,'2026-04-22 18:20:06.795974',130.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464','PENDIENTE'),(69,'2026-04-22 19:02:14.635250',80.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464','PENDIENTE'),(70,'2026-04-22 19:03:53.743781',15.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464','PENDIENTE'),(71,'2026-04-22 19:12:34.038679',80.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464','PENDIENTE'),(72,'2026-04-22 19:22:15.653502',100.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464','PENDIENTE'),(73,'2026-04-22 19:37:06.292345',85.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464','PENDIENTE'),(74,'2026-04-22 19:42:59.692498',10.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464','PENDIENTE'),(75,'2026-04-22 20:06:19.360256',180.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464','PENDIENTE'),(76,'2026-04-22 20:14:51.626837',760.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464','PENDIENTE'),(77,'2026-04-23 15:33:00.208768',30.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464','PENDIENTE'),(78,'2026-04-23 15:39:50.663349',315.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464','PENDIENTE'),(79,'2026-04-23 16:05:55.606270',315.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464','PENDIENTE'),(80,'2026-04-23 16:23:12.059263',320.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464','PENDIENTE'),(81,'2026-04-23 16:24:32.285372',20.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464','PENDIENTE'),(82,'2026-04-23 16:34:14.212347',20.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464','PENDIENTE'),(83,'2026-04-23 18:56:39.664568',20.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464','PENDIENTE'),(84,'2026-04-23 18:57:31.815874',25.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464','PENDIENTE'),(85,'2026-04-23 19:00:54.863855',10.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464','PENDIENTE'),(86,'2026-04-23 19:01:43.948884',300.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464','PENDIENTE'),(87,'2026-04-23 19:02:38.199613',15.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464','PENDIENTE'),(88,'2026-04-23 19:06:09.770386',10.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464','PENDIENTE'),(89,'2026-04-23 19:09:20.529627',15.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464','PENDIENTE'),(90,'2026-04-23 19:11:14.845166',25.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464','PENDIENTE'),(91,'2026-04-23 19:31:30.615848',25.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464','PENDIENTE'),(92,'2026-04-23 19:31:48.336739',15.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464','PENDIENTE'),(93,'2026-04-23 19:33:56.397047',15.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464','PENDIENTE'),(94,'2026-04-23 19:34:15.891385',15.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464','PENDIENTE'),(95,'2026-04-23 19:36:32.484959',10.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464','PENDIENTE'),(96,'2026-04-23 19:37:47.270939',80.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464','PENDIENTE'),(97,'2026-04-23 19:38:13.913189',10.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464','PENDIENTE'),(98,'2026-04-23 19:38:40.613321',5.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464','PENDIENTE'),(99,'2026-04-23 19:38:56.192037',5.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464','PENDIENTE'),(100,'2026-04-24 13:28:34.514267',80.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464','PENDIENTE'),(101,'2026-04-24 13:39:16.131210',80.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464','PENDIENTE'),(102,'2026-04-24 13:39:43.756061',60.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464','PENDIENTE'),(103,'2026-04-24 13:46:58.592255',350.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464','PENDIENTE'),(104,'2026-04-24 13:47:18.544406',5.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464','PENDIENTE'),(105,'2026-04-24 13:47:53.883823',80.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464','PENDIENTE'),(106,'2026-04-24 13:58:44.148690',80.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464','PENDIENTE'),(107,'2026-04-24 14:00:41.141800',80.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464','PENDIENTE'),(108,'2026-04-24 14:00:56.159409',10.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464','PENDIENTE'),(109,'2026-04-24 14:07:54.310210',310.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464','PENDIENTE'),(110,'2026-04-24 14:42:18.758905',80.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464','PENDIENTE'),(111,'2026-04-24 14:43:05.316512',100.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464','PENDIENTE'),(112,'2026-04-24 14:45:45.100797',80.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464','PENDIENTE'),(113,'2026-04-24 14:46:31.302856',300.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464','PENDIENTE'),(114,'2026-04-24 14:47:54.992218',80.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464','PENDIENTE'),(115,'2026-04-24 17:43:04.926427',350.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464','PENDIENTE'),(116,'2026-04-24 18:27:21.266273',80.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464','PENDIENTE'),(117,'2026-04-24 18:58:19.873073',300.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464','PENDIENTE'),(118,'2026-04-24 18:59:24.749954',10.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464','PENDIENTE'),(119,'2026-04-24 19:03:40.755935',300.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464','PENDIENTE'),(120,'2026-04-24 19:12:40.689027',80.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464','PENDIENTE'),(121,'2026-04-24 19:16:51.274219',105.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464','PENDIENTE'),(122,'2026-04-26 22:35:11.772058',610.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464','PENDIENTE'),(123,'2026-04-29 15:31:56.740966',1060.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464','PENDIENTE'),(124,'2026-04-29 15:57:52.164528',320.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464','PENDIENTE'),(125,'2026-04-29 16:09:08.401134',310.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464','PENDIENTE'),(126,'2026-04-29 16:12:54.302491',70.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464','PENDIENTE'),(127,'2026-04-29 18:27:04.803765',625.00,NULL,21,'av pepino 43','will.andesbrazil@gmail.com',NULL,'981078464','PENDIENTE'),(128,'2026-05-02 14:18:25.527234',150.00,NULL,21,'Av Andromeda 35','marco@gmai.com',NULL,'(11)965368445','PENDIENTE'),(129,'2026-05-02 21:09:09.646165',380.00,NULL,22,'Av Andromeda 35','marco@gmai.com',NULL,'(11)965368445','PENDIENTE'),(130,'2026-05-05 13:39:41.040238',95.00,NULL,22,'Av Andromeda 35','will@gmai.com',NULL,'(11)965368400','ENVIADO'),(131,'2026-05-06 19:14:21.558817',100.00,NULL,21,'Av Andromeda 35','will@gmail.com',NULL,'(11)965368400','PENDIENTE'),(132,'2026-05-06 20:46:55.223372',30.00,NULL,21,'Av Andromeda 35','will@gmail.com',NULL,'(11)965368400','PENDIENTE'),(133,'2026-05-07 13:50:31.195558',731.00,NULL,22,'Av Andromeda 35','will@gmail.com',NULL,'(11)965368400','PENDIENTE'),(134,'2026-05-07 17:30:01.185782',95.00,NULL,22,'Av Andromeda 35','will@gmail.com',NULL,'(11)965368400','PENDIENTE'),(135,'2026-05-13 15:31:49.971329',420.00,NULL,21,'Av Andromeda 35','will@gmail.com',NULL,'(11)965368400','PAGADO'),(136,'2026-05-13 15:42:46.217119',75.00,NULL,21,'Av Andromeda 35','will@gmail.com',NULL,'(11)965368400','ENVIADO'),(137,'2026-05-13 15:51:40.683954',30.00,NULL,22,'Av Andromeda 35','will@gmail.com',NULL,'(11)965368400','ENVIADO'),(138,'2026-05-13 15:52:44.565428',33.00,NULL,22,'Av Andromeda 35','will@gmail.com',NULL,'(11)965368400','EN_CAMINO'),(139,'2026-05-13 16:06:24.279544',735.00,NULL,22,'Av Andromeda 35','will@gmail.com',NULL,'(11)965368400','ENTREGADO'),(140,'2026-05-13 16:27:01.689063',10.00,NULL,21,'Av Andromeda 35','will@gmail.com',NULL,'(11)965368400','CANCELADO'),(141,'2026-05-14 15:44:38.878638',25.00,NULL,22,'Av Andromeda 35','will@gmail.com',NULL,'(11)965368400','ENVIADO'),(142,'2026-05-15 16:41:31.181546',43.00,NULL,30,'Av Manzano 12','will@gmail.com',NULL,'12981078464','ENVIADO'),(143,'2026-05-15 18:42:23.474612',15.00,NULL,30,'Av Manzano 12','will@gmail.com',NULL,'12981078464','EN_CAMINO'),(144,'2026-05-15 19:52:07.868247',310.00,NULL,21,'Av Manzano 12','will@gmail.com',NULL,'12981078464','ENTREGADO'),(145,'2026-05-16 00:21:05.152457',305.00,NULL,30,'Av Manzano 12','will@gmail.com',NULL,'12981078464','PENDIENTE'),(146,'2026-05-16 02:12:09.803880',20.00,NULL,30,'Av Manzano 12','will@gmail.com',NULL,'12981078464','PENDIENTE'),(147,'2026-05-18 15:21:55.999711',20.00,NULL,30,'Av Manzano 12','will@gmail.com',NULL,'12981078464','PENDIENTE'),(148,'2026-05-22 15:38:22.220776',50.00,NULL,30,'Av Manzano 12','will@gmail.com',NULL,'12981078464','PENDIENTE'),(149,'2026-05-22 19:31:49.389871',25.00,NULL,30,'Av Manzano 12','will@gmail.com',NULL,'12981078464','PENDIENTE'),(150,'2026-05-22 19:51:42.375619',63.80,NULL,30,'Av Manzano 12','will@gmail.com',NULL,'12981078464','PREPARANDO'),(151,'2026-05-22 20:11:12.116771',1800.00,NULL,30,'Av Manzano 12','will@gmail.com',NULL,'12981078464','ENVIADO'),(152,'2026-05-23 13:55:30.846032',25.00,NULL,21,'Av Manzano 12','will@gmail.com',NULL,'12981078464','PENDIENTE'),(153,'2026-05-24 19:21:01.514883',75.00,NULL,30,'Av Manzano 12','will@gmail.com',NULL,'12981078464','PENDIENTE'),(154,'2026-05-24 19:21:47.868521',612.00,NULL,30,'Av Manzano 12','will@gmail.com',NULL,'12981078464','PENDIENTE'),(155,'2026-05-28 14:46:51.267828',385.86,NULL,30,'Av Manzano 12','will@gmail.com',NULL,'12981078464','PENDIENTE'),(156,'2026-06-01 14:18:04.920774',15.00,NULL,30,'Av Manzano 12','will@gmail.com',NULL,'12981078464','PENDIENTE'),(157,'2026-06-04 19:07:47.940756',349.99,NULL,30,'Av Manzano 12','will@gmail.com',NULL,'12981078464','PENDIENTE');
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

-- Dump completed on 2026-06-05 12:15:57
