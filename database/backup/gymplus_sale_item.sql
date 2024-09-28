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
-- Table structure for table `sale_item`
--

DROP TABLE IF EXISTS `sale_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sale_item` (
  `id` int DEFAULT NULL,
  `sale_id` int NOT NULL,
  `product_name` varchar(255) DEFAULT NULL,
  `price` float NOT NULL,
  `quantity` int DEFAULT NULL,
  `updatedAt` timestamp NULL DEFAULT NULL,
  `createdAt` timestamp NULL DEFAULT NULL,
  KEY `sale_id` (`sale_id`),
  CONSTRAINT `sale_item_ibfk_1` FOREIGN KEY (`sale_id`) REFERENCES `sale` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sale_item`
--

LOCK TABLES `sale_item` WRITE;
/*!40000 ALTER TABLE `sale_item` DISABLE KEYS */;
INSERT INTO `sale_item` VALUES (NULL,4,'GNC Total Lean® Lean Shake™ 25',30.25,1,'2024-09-03 23:18:09','2024-09-03 23:18:09'),(NULL,4,'GNC Total Lean® Lean Shake™ 25',413.96,1,'2024-09-03 23:18:09','2024-09-03 23:18:09'),(NULL,5,'Dymatize® ISO100® Hydrolyzed 5 Lbs.',550.7,1,'2024-09-03 23:18:18','2024-09-03 23:18:18'),(NULL,5,'GNC Total Lean® Lean Bar',19.9,1,'2024-09-03 23:18:18','2024-09-03 23:18:18'),(NULL,5,'GNC Total Lean® Lean Shake™ 25',413.96,1,'2024-09-03 23:18:18','2024-09-03 23:18:18'),(NULL,5,'Optimum Nutrition Gold Standard® 100% Whey',502.95,1,'2024-09-03 23:18:18','2024-09-03 23:18:18'),(NULL,5,'Nutrabolics® Mass Fusion',777.85,1,'2024-09-03 23:18:18','2024-09-03 23:18:18'),(NULL,5,'Nature\'s Best Isopure® Protein Powder - Zero Carb Protein',699.95,1,'2024-09-03 23:18:18','2024-09-03 23:18:18'),(NULL,6,'Muscletech® Nitro Tech™ 4 Lbs',707.5,1,'2024-09-03 23:18:25','2024-09-03 23:18:25');
/*!40000 ALTER TABLE `sale_item` ENABLE KEYS */;
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
