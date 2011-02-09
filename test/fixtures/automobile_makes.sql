-- MySQL dump 10.13  Distrib 5.1.41, for debian-linux-gnu (i486)
--
-- Host: 127.0.0.1    Database: data1
-- ------------------------------------------------------
-- Server version	5.1.41-3ubuntu12.8

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
-- Table structure for table `automobile_makes`
--

DROP TABLE IF EXISTS `automobile_makes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `automobile_makes` (
  `name` varchar(255) NOT NULL DEFAULT '',
  `fuel_efficiency` float DEFAULT NULL,
  `fuel_efficiency_units` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `automobile_makes`
--

LOCK TABLES `automobile_makes` WRITE;
/*!40000 ALTER TABLE `automobile_makes` DISABLE KEYS */;
INSERT INTO `automobile_makes` VALUES ('',NULL,'kilometres_per_litre'),('Acura',9.08129,'kilometres_per_litre'),('Alfa Romeo',10.4075,'kilometres_per_litre'),('Alpina',7.12301,'kilometres_per_litre'),('American Motors',8.83413,'kilometres_per_litre'),('Aston Martin',7.63597,'kilometres_per_litre'),('Audi',8.54408,'kilometres_per_litre'),('Avanti',6.64194,'kilometres_per_litre'),('Bentley',5.05366,'kilometres_per_litre'),('Bertone',12.5756,'kilometres_per_litre'),('Bitter',8.75492,'kilometres_per_litre'),('BMW',10.8585,'kilometres_per_litre'),('Bugatti',4.30568,'kilometres_per_litre'),('Buick',9.02433,'kilometres_per_litre'),('Cadillac',7.75072,'kilometres_per_litre'),('Chevrolet',7.84091,'kilometres_per_litre'),('Chrysler',10.3041,'kilometres_per_litre'),('Citroën',9.30681,'kilometres_per_litre'),('Citroën INC',6.83116,'kilometres_per_litre'),('Daewoo',12.1673,'kilometres_per_litre'),('Daihatsu',17.2183,'kilometres_per_litre'),('DaimlerChrysler',9.98344,'kilometres_per_litre'),('Dodge',7.37358,'kilometres_per_litre'),('Eagle',9.69909,'kilometres_per_litre'),('Excalibur',4.88915,'kilometres_per_litre'),('Ferrari',6.68364,'kilometres_per_litre'),('Fiat',10.5269,'kilometres_per_litre'),('Ford',10.2407,'kilometres_per_litre'),('Geo',11.9565,'kilometres_per_litre'),('GM',10.5065,'kilometres_per_litre'),('GMC',6.88051,'kilometres_per_litre'),('Honda',13.291,'kilometres_per_litre'),('Hummer',6.64142,'kilometres_per_litre'),('Hyundai',13.1387,'kilometres_per_litre'),('IHC',7.35499,'kilometres_per_litre'),('Impco',9.46286,'kilometres_per_litre'),('Infiniti',8.12203,'kilometres_per_litre'),('Isuzu',9.70585,'kilometres_per_litre'),('Jaguar',8.7687,'kilometres_per_litre'),('Jeep',7.01487,'kilometres_per_litre'),('Kia',11.8592,'kilometres_per_litre'),('Laforza',4.87946,'kilometres_per_litre'),('Lamborghini',5.03409,'kilometres_per_litre'),('Land Rover',6.12734,'kilometres_per_litre'),('Lexus',8.45328,'kilometres_per_litre'),('Lincoln',9.05273,'kilometres_per_litre'),('Lotus',11.9396,'kilometres_per_litre'),('Maserati',7.27185,'kilometres_per_litre'),('Maybach',5.47022,'kilometres_per_litre'),('Mazda',12.3846,'kilometres_per_litre'),('Mercedes-Benz',10.0622,'kilometres_per_litre'),('Mercury',7.64315,'kilometres_per_litre'),('Merkur',7.9813,'kilometres_per_litre'),('Mini',12.0537,'kilometres_per_litre'),('Mitsubishi',12.1768,'kilometres_per_litre'),('Morgan',7.62285,'kilometres_per_litre'),('Nissan',11.8682,'kilometres_per_litre'),('Oldsmobile',9.18457,'kilometres_per_litre'),('Panoz',9.88633,'kilometres_per_litre'),('Panther',11.6489,'kilometres_per_litre'),('Peugeot',10.9448,'kilometres_per_litre'),('Pininfarina',12.3193,'kilometres_per_litre'),('Plymouth',9.68965,'kilometres_per_litre'),('Pontiac',9.86449,'kilometres_per_litre'),('Porsche',10.0382,'kilometres_per_litre'),('Quantum',12.6395,'kilometres_per_litre'),('Qvale',7.8845,'kilometres_per_litre'),('Renault',14.6309,'kilometres_per_litre'),('Rolls-Royce',5.09656,'kilometres_per_litre'),('Roush Industries, Inc.',7.66709,'kilometres_per_litre'),('Rover',7.13526,'kilometres_per_litre'),('Saab',10.949,'kilometres_per_litre'),('Saleen',6.91581,'kilometres_per_litre'),('Saturn',10.6349,'kilometres_per_litre'),('Shelby',8.07773,'kilometres_per_litre'),('Spyker',8.27647,'kilometres_per_litre'),('Subaru',12.3556,'kilometres_per_litre'),('Suzuki',12.8985,'kilometres_per_litre'),('TCSTR',5.51797,'kilometres_per_litre'),('Tesla',103.735,'kilometres_per_litre'),('Toyota',12.3622,'kilometres_per_litre'),('TVR',8.80048,'kilometres_per_litre'),('Vector',4.29395,'kilometres_per_litre'),('Vector CORP',3.52924,'kilometres_per_litre'),('Volkswagen',12.4898,'kilometres_per_litre'),('Volvo',10.8427,'kilometres_per_litre'),('Yugo',14.2504,'kilometres_per_litre');
/*!40000 ALTER TABLE `automobile_makes` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2011-02-08  8:41:18
