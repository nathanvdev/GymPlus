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
-- Table structure for table `membership_payment`
--

DROP TABLE IF EXISTS `membership_payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `membership_payment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `member_id` int NOT NULL,
  `membership_plan` int NOT NULL,
  `billing_quantity` int DEFAULT NULL,
  `billing_cycle` int NOT NULL,
  `initialpaymentdate` date NOT NULL,
  `nextpaymentdate` date NOT NULL,
  `subtotal` float NOT NULL,
  `discounts` float DEFAULT NULL,
  `discounts_description` varchar(400) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `total` float NOT NULL,
  `payment_method` int NOT NULL,
  `cash` float DEFAULT NULL,
  `change` float DEFAULT NULL,
  `payment_status` int NOT NULL,
  `payment_reference` varchar(20) DEFAULT NULL,
  `admin_member_id` int NOT NULL,
  `createdAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `member_id` (`member_id`),
  KEY `admin_member_id` (`admin_member_id`),
  CONSTRAINT `membership_payment_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `member` (`id`),
  CONSTRAINT `membership_payment_ibfk_2` FOREIGN KEY (`admin_member_id`) REFERENCES `user` (`member_id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `membership_payment`
--

LOCK TABLES `membership_payment` WRITE;
/*!40000 ALTER TABLE `membership_payment` DISABLE KEYS */;
INSERT INTO `membership_payment` VALUES (28,2,1,4,1,'2024-08-23','2024-09-13',20,5,'es pana',15,1,20,0,1,'',1,'2024-08-23 15:04:17','2024-09-09 16:59:11'),(29,3,1,2,1,'2024-08-23','2024-08-25',10,0,'',10,1,10,0,1,'',1,'2024-08-23 15:10:23','2024-09-04 03:33:41'),(30,4,1,3,2,'2024-08-23','2024-09-24',30,0,'',30,1,300,0,1,'',1,'2024-08-23 15:10:49','2024-09-03 22:25:45'),(31,5,1,6,1,'2024-08-30','2024-09-05',30,0,'',30,1,30,0,1,'',1,'2024-08-30 22:30:26','2024-08-30 22:30:26'),(32,2,1,2,1,'2024-08-30','2024-09-01',10,0,'',10,1,10,0,1,'',1,'2024-08-30 22:42:52','2024-08-30 22:42:52'),(33,8,1,1,4,'2024-09-11','2025-09-11',1000,500,'Membrecia Al-Nassr',500,1,700,200,1,'',1,'2024-09-10 16:16:53','2024-09-10 16:16:53'),(34,3,1,3,2,'2024-09-10','2024-10-01',30,0,'',30,1,30,0,1,'',1,'2024-09-10 17:44:45','2024-09-10 17:44:45'),(35,5,1,2,2,'2024-09-10','2024-09-24',20,0,'',20,1,20,0,1,'',1,'2024-09-10 17:46:06','2024-09-10 17:46:06'),(36,2,1,6,2,'2024-09-10','2024-10-22',60,20,'si',40,1,50,10,1,'',1,'2024-09-10 17:46:53','2024-09-10 17:46:53');
/*!40000 ALTER TABLE `membership_payment` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_membership_payment_insert` AFTER INSERT ON `membership_payment` FOR EACH ROW BEGIN
    -- Actualizar la fecha de próximo pago, estado de membresía y el último pago en la tabla member
    UPDATE member
    SET 
        last_payment = NEW.id,
        membership_type = NEW.membership_plan,
        membership_status = CASE
            WHEN NEW.initialpaymentdate = CURDATE() THEN 'Activo'
            ELSE membership_status
        END
    WHERE id = NEW.member_id;
END */;;
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

-- Dump completed on 2024-09-27 23:56:31
