-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: gymplus
-- ------------------------------------------------------
-- Server version	8.0.37

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
-- Table structure for table `member`
--

DROP TABLE IF EXISTS `member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `member` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `phone_number` bigint NOT NULL,
  `email` varchar(60) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `gender` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `emergency_contact_number` bigint DEFAULT NULL,
  `emergency_contact_name` varchar(55) DEFAULT NULL,
  `allergies` varchar(300) DEFAULT NULL,
  `blood_type` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `last_payment` int DEFAULT NULL,
  `membership_type` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `membership_status` varchar(20) NOT NULL DEFAULT 'Inactive',
  `last_visit` datetime DEFAULT NULL,
  `active_days` bigint DEFAULT NULL,
  `porfileImage` varchar(255) DEFAULT NULL,
  `createdAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `last_payment` (`last_payment`),
  CONSTRAINT `member_ibfk_1` FOREIGN KEY (`last_payment`) REFERENCES `membership_payment` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member`
--

LOCK TABLES `member` WRITE;
/*!40000 ALTER TABLE `member` DISABLE KEYS */;
INSERT INTO `member` VALUES (1,'admin','admin',5574,'admin@gymplus.com','2024-06-20','Masculino',NULL,NULL,NULL,NULL,NULL,'1','Inactivo',NULL,NULL,NULL,NULL,'2024-07-25 21:12:31'),(2,'Nathan','Valdez',557452,'','2024-06-09','Masculino',NULL,'','','',36,'1','Activo',NULL,2,NULL,'2024-06-20 22:02:21','2024-09-10 17:46:53'),(3,'Ricardo','Valdez',123456878,'gl;k@gmail.com','2024-06-19','Masculino',1234346,'asdfgdh','none','A+',34,'1','Activo',NULL,NULL,NULL,'2024-06-21 18:07:10','2024-09-10 17:44:45'),(4,'Norma ','Valdez',23656875467,'dfsdf','2024-06-17','Femenino',NULL,'','','',30,'1','Inactivo',NULL,NULL,NULL,'2024-06-21 22:48:21','2024-09-25 14:10:31'),(5,'Juan Oracio Tzun','Gonzales Carrascoza',234,'juan@gmail.com','1994-07-06','Masculino',856775,'mama','alacranes','B-',35,'1','Inactivo',NULL,NULL,NULL,'2024-07-02 14:41:34','2024-09-25 14:10:31'),(8,'Cristiano Ronaldo','Dos Santos Aveiro',454223,'','1985-02-05','Masculino',NULL,'','','A-',33,'1','Activo',NULL,NULL,'Cristiano-Ronaldo-ceremony-rename-airport-Santa-Cruz-Madeira-Portugal-March-29-2017.webp','2024-09-09 19:06:44','2024-09-11 14:39:31'),(9,'Javier (chicharito)','Hernandez Blacazar',5246423345674,'javierchicharito@gmail.com','1973-12-07','Otro',5234365457567,'','Gatos','B-',NULL,NULL,'Inactivo',NULL,NULL,'17125358508472.jpg','2024-09-11 17:32:08','2024-09-11 17:57:15');
/*!40000 ALTER TABLE `member` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-09-27 23:56:32
