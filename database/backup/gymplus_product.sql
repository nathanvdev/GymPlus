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
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `stock` int NOT NULL,
  `price` float NOT NULL,
  `imageurl` varchar(255) DEFAULT NULL,
  `createdAt` timestamp NULL DEFAULT NULL,
  `updatedAt` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (1,'Dymatize® ISO100® Hydrolyzed 5 Lbs.',10,550.7,'lib/assets/tmp/iso100.webp',NULL,'2024-08-27 17:13:10'),(2,'One® Protein Bar 2.12 Oz. (60 g)',5,10,'lib/assets/tmp/GNC800X800-2022-08-08T131357.676_800x.webp',NULL,'2024-08-27 17:41:13'),(4,'Muscletech® Nitro Tech™ 4 Lbs',20,707.5,'lib\\assets\\tmp\\GNC800X800-2022-08-08T172308.191_1400x.webp',NULL,NULL),(5,'GNC Total Lean® Lean Bar',45,19.9,'lib\\assets\\tmp\\GNC800X800-2022-08-08T130733.695_1400x.webp',NULL,NULL),(6,'GNC Total Lean® Lean Shake™ 25',12,30.25,'lib\\assets\\tmp\\GNC800X800-2022-08-08T120300.496_1400x.webp',NULL,NULL),(7,'Nature\'s Best Isopure® Protein Powder - Zero Carb Protein',18,699.95,'lib\\assets\\tmp\\GNC800X800-2022-08-08T175342.393_1400x.webp',NULL,NULL),(8,'GNC Total Lean® Lean Shake™ 25',25,413.96,'lib\\assets\\tmp\\GNC800X800-2022-08-09T124532.785_1400x.webp',NULL,NULL),(9,'Optimum Nutrition Gold Standard® 100% Whey',37,502.95,'lib\\assets\\tmp\\GNC800X800-2022-08-09T103221.683_ba932ebf-442b-422d-8966-4a5180aa5efb_1400x.webp',NULL,NULL),(10,'Nutrabolics® Mass Fusion',82,777.85,'lib\\assets\\tmp\\GNC800X800-2022-08-09T102050.609_1400x.webp',NULL,NULL);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
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
