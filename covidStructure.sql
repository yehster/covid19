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
-- Table structure for table `confirmed`
--

DROP TABLE IF EXISTS `confirmed`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `confirmed` (
  `UID` bigint(20) NOT NULL,
  `location` bigint(20) NOT NULL,
  `day` date NOT NULL,
  `number` int(11) NOT NULL,
  PRIMARY KEY (`UID`),
  UNIQUE KEY `location_day` (`location`,`day`),
  CONSTRAINT `FK_confirmed_locations` FOREIGN KEY (`location`) REFERENCES `locations` (`UID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `confirmed_delta`
--

DROP TABLE IF EXISTS `confirmed_delta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `confirmed_delta` (
  `UID` bigint(20) NOT NULL,
  `location` bigint(20) NOT NULL,
  `day` date NOT NULL,
  `number` int(11) NOT NULL,
  PRIMARY KEY (`UID`) USING BTREE,
  UNIQUE KEY `location_day` (`location`,`day`) USING BTREE,
  CONSTRAINT `confirmed_delta_ibfk_1` FOREIGN KEY (`location`) REFERENCES `locations` (`UID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `confirmed_delta_cma`
--

DROP TABLE IF EXISTS `confirmed_delta_cma`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `confirmed_delta_cma` (
  `UID` bigint(20) NOT NULL,
  `location` bigint(20) NOT NULL,
  `day` date NOT NULL,
  `number` float NOT NULL,
  PRIMARY KEY (`UID`) USING BTREE,
  UNIQUE KEY `location_day` (`location`,`day`) USING BTREE,
  CONSTRAINT `confirmed_delta_cma_ibfk_1` FOREIGN KEY (`location`) REFERENCES `locations` (`UID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `confirmed_delta_ma_14`
--

DROP TABLE IF EXISTS `confirmed_delta_ma_14`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `confirmed_delta_ma_14` (
  `UID` bigint(20) NOT NULL,
  `location` bigint(20) NOT NULL,
  `day` date NOT NULL,
  `number` float NOT NULL,
  PRIMARY KEY (`UID`) USING BTREE,
  UNIQUE KEY `location_day` (`location`,`day`) USING BTREE,
  CONSTRAINT `confirmed_delta_ma_14_ibfk_1` FOREIGN KEY (`location`) REFERENCES `locations` (`UID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `confirmed_delta_ma_14_pct_change_14`
--

DROP TABLE IF EXISTS `confirmed_delta_ma_14_pct_change_14`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `confirmed_delta_ma_14_pct_change_14` (
  `UID` bigint(20) NOT NULL,
  `location` bigint(20) NOT NULL,
  `day` date NOT NULL,
  `number` float NOT NULL,
  PRIMARY KEY (`UID`) USING BTREE,
  UNIQUE KEY `location_day` (`location`,`day`) USING BTREE,
  CONSTRAINT `confirmed_delta_ma_14_pct_change_14_ibfk_1` FOREIGN KEY (`location`) REFERENCES `locations` (`UID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `confirmed_delta_ma_7`
--

DROP TABLE IF EXISTS `confirmed_delta_ma_7`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `confirmed_delta_ma_7` (
  `UID` bigint(20) NOT NULL,
  `location` bigint(20) NOT NULL,
  `day` date NOT NULL,
  `number` float NOT NULL,
  PRIMARY KEY (`UID`) USING BTREE,
  UNIQUE KEY `location_day` (`location`,`day`) USING BTREE,
  CONSTRAINT `confirmed_delta_ma_7_ibfk_1` FOREIGN KEY (`location`) REFERENCES `locations` (`UID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `confirmed_delta_ma_7_pct_change_7`
--

DROP TABLE IF EXISTS `confirmed_delta_ma_7_pct_change_7`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `confirmed_delta_ma_7_pct_change_7` (
  `UID` bigint(20) NOT NULL,
  `location` bigint(20) NOT NULL,
  `day` date NOT NULL,
  `number` float NOT NULL,
  PRIMARY KEY (`UID`) USING BTREE,
  UNIQUE KEY `location_day` (`location`,`day`) USING BTREE,
  CONSTRAINT `confirmed_delta_ma_7_pct_change_7_ibfk_1` FOREIGN KEY (`location`) REFERENCES `locations` (`UID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `confirmed_state_delta`
--

DROP TABLE IF EXISTS `confirmed_state_delta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `confirmed_state_delta` (
  `UID` bigint(20) NOT NULL,
  `location` bigint(20) NOT NULL,
  `day` date NOT NULL,
  `number` int(11) NOT NULL,
  PRIMARY KEY (`UID`) USING BTREE,
  UNIQUE KEY `location_day` (`location`,`day`) USING BTREE,
  CONSTRAINT `confirmed_state_delta_ibfk_1` FOREIGN KEY (`location`) REFERENCES `state_codes` (`UID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `confirmed_states`
--

DROP TABLE IF EXISTS `confirmed_states`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `confirmed_states` (
  `UID` bigint(20) NOT NULL,
  `location` bigint(20) NOT NULL,
  `day` date NOT NULL,
  `number` int(11) NOT NULL,
  PRIMARY KEY (`UID`) USING BTREE,
  UNIQUE KEY `location_day` (`location`,`day`) USING BTREE,
  CONSTRAINT `confirmed_states_ibfk_1` FOREIGN KEY (`location`) REFERENCES `state_codes` (`UID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `confirmed_states_delta`
--

DROP TABLE IF EXISTS `confirmed_states_delta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `confirmed_states_delta` (
  `UID` bigint(20) NOT NULL,
  `location` bigint(20) NOT NULL,
  `day` date NOT NULL,
  `number` int(11) NOT NULL,
  PRIMARY KEY (`UID`) USING BTREE,
  UNIQUE KEY `location_day` (`location`,`day`) USING BTREE,
  CONSTRAINT `confirmed_states_delta_ibfk_1` FOREIGN KEY (`location`) REFERENCES `state_codes` (`UID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `confirmed_states_delta_ma_14`
--

DROP TABLE IF EXISTS `confirmed_states_delta_ma_14`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `confirmed_states_delta_ma_14` (
  `UID` bigint(20) NOT NULL,
  `location` bigint(20) NOT NULL,
  `day` date NOT NULL,
  `number` float NOT NULL,
  PRIMARY KEY (`UID`) USING BTREE,
  UNIQUE KEY `location_day` (`location`,`day`) USING BTREE,
  CONSTRAINT `confirmed_states_delta_ma_14_ibfk_1` FOREIGN KEY (`location`) REFERENCES `state_codes` (`UID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `confirmed_states_delta_ma_14_pct_change_14`
--

DROP TABLE IF EXISTS `confirmed_states_delta_ma_14_pct_change_14`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `confirmed_states_delta_ma_14_pct_change_14` (
  `UID` bigint(20) NOT NULL,
  `location` bigint(20) NOT NULL,
  `day` date NOT NULL,
  `number` float NOT NULL,
  PRIMARY KEY (`UID`) USING BTREE,
  UNIQUE KEY `location_day` (`location`,`day`) USING BTREE,
  CONSTRAINT `confirmed_states_delta_ma_14_pct_change_14_ibfk_1` FOREIGN KEY (`location`) REFERENCES `state_codes` (`UID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `confirmed_states_delta_ma_7`
--

DROP TABLE IF EXISTS `confirmed_states_delta_ma_7`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `confirmed_states_delta_ma_7` (
  `UID` bigint(20) NOT NULL,
  `location` bigint(20) NOT NULL,
  `day` date NOT NULL,
  `number` float NOT NULL,
  PRIMARY KEY (`UID`) USING BTREE,
  UNIQUE KEY `location_day` (`location`,`day`) USING BTREE,
  CONSTRAINT `confirmed_states_delta_ma_7_ibfk_1` FOREIGN KEY (`location`) REFERENCES `state_codes` (`UID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `confirmed_states_delta_ma_7_pct_change_7`
--

DROP TABLE IF EXISTS `confirmed_states_delta_ma_7_pct_change_7`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `confirmed_states_delta_ma_7_pct_change_7` (
  `UID` bigint(20) NOT NULL,
  `location` bigint(20) NOT NULL,
  `day` date NOT NULL,
  `number` float NOT NULL,
  PRIMARY KEY (`UID`) USING BTREE,
  UNIQUE KEY `location_day` (`location`,`day`) USING BTREE,
  CONSTRAINT `confirmed_states_delta_ma_7_pct_change_7_ibfk_1` FOREIGN KEY (`location`) REFERENCES `state_codes` (`UID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `deaths`
--

DROP TABLE IF EXISTS `deaths`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `deaths` (
  `UID` bigint(20) NOT NULL,
  `location` bigint(20) NOT NULL,
  `day` date NOT NULL,
  `number` int(11) NOT NULL,
  PRIMARY KEY (`UID`),
  UNIQUE KEY `location_day` (`location`,`day`),
  CONSTRAINT `FK_deaths_locations` FOREIGN KEY (`location`) REFERENCES `locations` (`UID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `deaths_delta`
--

DROP TABLE IF EXISTS `deaths_delta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `deaths_delta` (
  `UID` bigint(20) NOT NULL,
  `location` bigint(20) NOT NULL,
  `day` date NOT NULL,
  `number` int(11) NOT NULL,
  PRIMARY KEY (`UID`) USING BTREE,
  UNIQUE KEY `location_day` (`location`,`day`) USING BTREE,
  CONSTRAINT `deaths_delta_ibfk_1` FOREIGN KEY (`location`) REFERENCES `locations` (`UID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `deaths_delta_cma`
--

DROP TABLE IF EXISTS `deaths_delta_cma`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `deaths_delta_cma` (
  `UID` bigint(20) NOT NULL,
  `location` bigint(20) NOT NULL,
  `day` date NOT NULL,
  `number` float NOT NULL,
  PRIMARY KEY (`UID`) USING BTREE,
  UNIQUE KEY `location_day` (`location`,`day`) USING BTREE,
  CONSTRAINT `deaths_delta_cma_ibfk_1` FOREIGN KEY (`location`) REFERENCES `locations` (`UID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `deaths_delta_delta_ma_7`
--

DROP TABLE IF EXISTS `deaths_delta_delta_ma_7`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `deaths_delta_delta_ma_7` (
  `UID` bigint(20) NOT NULL,
  `location` bigint(20) NOT NULL,
  `day` date NOT NULL,
  `number` float NOT NULL,
  PRIMARY KEY (`UID`) USING BTREE,
  UNIQUE KEY `location_day` (`location`,`day`) USING BTREE,
  CONSTRAINT `deaths_delta_delta_ma_7_ibfk_1` FOREIGN KEY (`location`) REFERENCES `locations` (`UID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `deaths_delta_ma_7`
--

DROP TABLE IF EXISTS `deaths_delta_ma_7`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `deaths_delta_ma_7` (
  `UID` bigint(20) NOT NULL,
  `location` bigint(20) NOT NULL,
  `day` date NOT NULL,
  `number` float NOT NULL,
  PRIMARY KEY (`UID`) USING BTREE,
  UNIQUE KEY `location_day` (`location`,`day`) USING BTREE,
  CONSTRAINT `deaths_delta_ma_7_ibfk_1` FOREIGN KEY (`location`) REFERENCES `locations` (`UID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `deaths_states`
--

DROP TABLE IF EXISTS `deaths_states`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `deaths_states` (
  `UID` bigint(20) NOT NULL,
  `location` bigint(20) NOT NULL,
  `day` date NOT NULL,
  `number` int(11) NOT NULL,
  PRIMARY KEY (`UID`) USING BTREE,
  UNIQUE KEY `location_day` (`location`,`day`) USING BTREE,
  CONSTRAINT `deaths_states_ibfk_1` FOREIGN KEY (`location`) REFERENCES `state_codes` (`UID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `deaths_states_delta`
--

DROP TABLE IF EXISTS `deaths_states_delta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `deaths_states_delta` (
  `UID` bigint(20) NOT NULL,
  `location` bigint(20) NOT NULL,
  `day` date NOT NULL,
  `number` int(11) NOT NULL,
  PRIMARY KEY (`UID`) USING BTREE,
  UNIQUE KEY `location_day` (`location`,`day`) USING BTREE,
  CONSTRAINT `deaths_states_delta_ibfk_1` FOREIGN KEY (`location`) REFERENCES `state_codes` (`UID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `deaths_states_delta_ma_7`
--

DROP TABLE IF EXISTS `deaths_states_delta_ma_7`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `deaths_states_delta_ma_7` (
  `UID` bigint(20) NOT NULL,
  `location` bigint(20) NOT NULL,
  `day` date NOT NULL,
  `number` float NOT NULL,
  PRIMARY KEY (`UID`) USING BTREE,
  UNIQUE KEY `location_day` (`location`,`day`) USING BTREE,
  CONSTRAINT `deaths_states_delta_ma_7_ibfk_1` FOREIGN KEY (`location`) REFERENCES `state_codes` (`UID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `location_states`
--

DROP TABLE IF EXISTS `location_states`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `location_states` (
  `location` bigint(20) NOT NULL,
  `state` bigint(20) NOT NULL,
  PRIMARY KEY (`location`,`state`),
  KEY `FK_location_states_state_codes` (`state`),
  CONSTRAINT `FK__locations` FOREIGN KEY (`location`) REFERENCES `locations` (`UID`),
  CONSTRAINT `FK_location_states_state_codes` FOREIGN KEY (`state`) REFERENCES `state_codes` (`UID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `locations`
--

DROP TABLE IF EXISTS `locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `locations` (
  `UID` bigint(20) NOT NULL,
  `iso2` varchar(50) DEFAULT NULL,
  `iso3` varchar(50) DEFAULT NULL,
  `code3` varchar(50) DEFAULT NULL,
  `FIPS` varchar(50) DEFAULT NULL,
  `Admin2` varchar(50) DEFAULT NULL,
  `Province_State` varchar(50) DEFAULT NULL,
  `Country_Region` varchar(50) DEFAULT NULL,
  `Combined_Key` varchar(255) NOT NULL DEFAULT '',
  `Population` int(11) NOT NULL DEFAULT 0,
  `geo_location` point NOT NULL,
  PRIMARY KEY (`UID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
-- Table structure for table `state_populations`
--

DROP TABLE IF EXISTS `state_populations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `state_populations` (
  `UID` bigint(20) NOT NULL DEFAULT 0,
  `population` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`UID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-07-02 10:19:39
