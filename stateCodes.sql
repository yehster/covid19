-- MariaDB dump 10.17  Distrib 10.5.3-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: covid
-- ------------------------------------------------------
-- Server version	10.5.3-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `state_codes`
--

DROP TABLE IF EXISTS `state_codes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `state_codes` (
  `UID` bigint(20) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`UID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `state_codes`
--

LOCK TABLES `state_codes` WRITE;
/*!40000 ALTER TABLE `state_codes` DISABLE KEYS */;
INSERT INTO `state_codes` VALUES (1,'Alabama'),(2,'Alaska'),(4,'Arizona'),(5,'Arkansas'),(6,'California'),(8,'Colorado'),(9,'Connecticut'),(10,'Delaware'),(11,'District of Columbia'),(12,'Florida'),(13,'Georgia'),(15,'Hawaii'),(16,'Idaho'),(17,'Illinois'),(18,'Indiana'),(19,'Iowa'),(20,'Kansas'),(21,'Kentucky'),(22,'Louisiana'),(23,'Maine'),(24,'Maryland'),(25,'Massachusetts'),(26,'Michigan'),(27,'Minnesota'),(28,'Mississippi'),(29,'Missouri'),(30,'Montana'),(31,'Nebraska'),(32,'Nevada'),(33,'New Hampshire'),(34,'New Jersey'),(35,'New Mexico'),(36,'New York'),(37,'North Carolina'),(38,'North Dakota'),(39,'Ohio'),(40,'Oklahoma'),(41,'Oregon'),(42,'Pennsylvania'),(44,'Rhode Island'),(45,'South Carolina'),(46,'South Dakota'),(47,'Tennessee'),(48,'Texas'),(49,'Utah'),(50,'Vermont'),(51,'Virginia'),(53,'Washington'),(54,'West Virginia'),(55,'Wisconsin'),(56,'Wyoming');
/*!40000 ALTER TABLE `state_codes` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-07-06 12:45:59
