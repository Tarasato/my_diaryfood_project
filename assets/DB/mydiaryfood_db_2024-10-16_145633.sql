-- MySQL dump 10.13  Distrib 8.0.33, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: mydiaryfood_db
-- ------------------------------------------------------
-- Server version	5.5.5-10.4.32-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `diaryfood_tb`
--

DROP TABLE IF EXISTS `diaryfood_tb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `diaryfood_tb` (
  `foodId` int(11) NOT NULL AUTO_INCREMENT,
  `foodShopname` varchar(100) NOT NULL,
  `foodMeal` int(11) NOT NULL,
  `foodImage` varchar(100) NOT NULL,
  `foodPay` double NOT NULL,
  `foodDate` varchar(100) NOT NULL,
  `foodProvince` varchar(100) NOT NULL,
  `foodLat` double DEFAULT NULL,
  `foodLng` double DEFAULT NULL,
  `memId` int(11) NOT NULL,
  PRIMARY KEY (`foodId`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `diaryfood_tb`
--

/*!40000 ALTER TABLE `diaryfood_tb` DISABLE KEYS */;
INSERT INTO `diaryfood_tb` VALUES (1,'HachibanRamen1',1,'aaa.jpg',100,'01 มกราคม 2567','ราชบุรี',13.705244313587219,100.34898557447546,1),(2,'KFC',2,'bbb.jpg',200,'14 มีนาคม 2567','พัทลุง',13.722538222228469,100.206087283468,2),(3,'Pizzahut',4,'ccc.jpg',300,'14 เมษายน 2567','ยะลา',13.750038778489262,100.49285679147368,2),(4,'Mixue',4,'snowman.png',35,'14 มีนาคม 2567','Bangkok',14,15,1),(5,'Mixue',0,'snowman',35,'14Mar24','Bangkok',14,15,1),(6,'Mixue',4,'snowman',35,'14Mar24','Bangkok',14,15,1),(7,'Mixue',4,'snowman',35,'14Mar24','Bangkok',14,15,1),(35,'KFC สามสี่',2,'pic_66ebdbb912e32_1726733241078.jpg',200,'14 มีนาคม 2567','bangkok',13,10,3);
/*!40000 ALTER TABLE `diaryfood_tb` ENABLE KEYS */;

--
-- Table structure for table `member_tb`
--

DROP TABLE IF EXISTS `member_tb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `member_tb` (
  `memId` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key',
  `memFullname` varchar(100) NOT NULL,
  `memEmail` varchar(100) NOT NULL,
  `memUsername` varchar(50) NOT NULL,
  `memPassword` varchar(50) NOT NULL,
  `memAge` varchar(3) NOT NULL,
  PRIMARY KEY (`memId`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member_tb`
--

/*!40000 ALTER TABLE `member_tb` DISABLE KEYS */;
INSERT INTO `member_tb` VALUES (8,'Taramiratsu Xato','taramiratsu@gmail.com','Taramiratsu','1','18'),(9,'1','1','1','1','1'),(10,'1','2','3','2','2'),(11,'1','6','5','5','5');
/*!40000 ALTER TABLE `member_tb` ENABLE KEYS */;

--
-- Dumping routines for database 'mydiaryfood_db'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-10-16 14:56:55
