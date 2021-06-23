-- MySQL dump 10.13  Distrib 8.0.23, for macos10.15 (x86_64)
--
-- Host: localhost    Database: stylish
-- ------------------------------------------------------
-- Server version	8.0.23

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
-- Table structure for table `campaign`
--

DROP TABLE IF EXISTS `campaign`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `campaign` (
  `Campaign_ID` int NOT NULL AUTO_INCREMENT,
  `Product_ID` int NOT NULL,
  `Picture` varchar(45) NOT NULL,
  `Story` varchar(45) NOT NULL,
  PRIMARY KEY (`Campaign_ID`),
  UNIQUE KEY `Campaign_ID_UNIQUE` (`Campaign_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `campaign`
--

LOCK TABLES `campaign` WRITE;
/*!40000 ALTER TABLE `campaign` DISABLE KEYS */;
INSERT INTO `campaign` VALUES (1,12,'eng13235okn1ye67b','cool sale'),(2,13,'eng13237ikn1ygi5j','warm and hot'),(3,2,'eng1321hskn2riat0','kit kat'),(4,4,'eng1322q0kn2t38ns','red sox'),(5,999,'eng1327zgkn5pnt6x','sdfasdf'),(6,999,'eng1327zgkn5pnxef','sdfasdf'),(7,67,'eng1328dqkn5q1z45','asd'),(8,3434,'eng1328wakn5qm82i','asdfasdf'),(9,30,'eng1321vekn6tlbbv','zxc');
/*!40000 ALTER TABLE `campaign` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `colors`
--

DROP TABLE IF EXISTS `colors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `colors` (
  `Color_code` varchar(255) NOT NULL,
  `Color_name` varchar(255) NOT NULL,
  PRIMARY KEY (`Color_code`),
  UNIQUE KEY `Color_code_UNIQUE` (`Color_code`),
  UNIQUE KEY `Color_name_UNIQUE` (`Color_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `colors`
--

LOCK TABLES `colors` WRITE;
/*!40000 ALTER TABLE `colors` DISABLE KEYS */;
INSERT INTO `colors` VALUES ('DDF0FF','Blue'),('BB7744','Brown'),('DDFFBB','Green'),('CCCCCC','Grey'),('FFDDDD','Pink'),('FFFFFF','White');
/*!40000 ALTER TABLE `colors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orderList`
--

DROP TABLE IF EXISTS `orderList`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orderList` (
  `OrderList_ID` int NOT NULL AUTO_INCREMENT,
  `Orders_ID` int NOT NULL,
  `Name` varchar(255) NOT NULL,
  `Price` varchar(255) NOT NULL,
  `Color_code` varchar(255) NOT NULL,
  `Size` varchar(255) NOT NULL,
  `Qty` int NOT NULL,
  PRIMARY KEY (`OrderList_ID`),
  UNIQUE KEY `Order_UNIQUE` (`OrderList_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orderList`
--

LOCK TABLES `orderList` WRITE;
/*!40000 ALTER TABLE `orderList` DISABLE KEYS */;
INSERT INTO `orderList` VALUES (1,12,'活力花紋長筒牛仔褲_1','1299','DDF0FF','M',1),(2,12,'活力花紋長筒牛仔褲_2','1500','DDF0FF','S',5),(3,13,'活力花紋長筒牛仔褲_1','1299','DDF0FF','M',1),(4,13,'活力花紋長筒牛仔褲_2','1500','DDF0FF','S',5),(5,14,'活力花紋長筒牛仔褲_1','1299','DDF0FF','M',1),(6,14,'活力花紋長筒牛仔褲_2','1500','DDF0FF','S',5),(7,15,'活力花紋長筒牛仔褲_1','1299','DDF0FF','M',1),(8,15,'活力花紋長筒牛仔褲_2','1500','DDF0FF','S',5),(9,16,'活力花紋長筒牛仔褲_1','1299','DDF0FF','M',1),(10,16,'活力花紋長筒牛仔褲_2','1500','DDF0FF','S',5),(11,17,'活力花紋長筒牛仔褲_1','1299','DDF0FF','M',1),(12,17,'活力花紋長筒牛仔褲_2','1500','DDF0FF','S',5),(13,18,'活力花紋長筒牛仔褲_1','1299','DDF0FF','M',1),(14,18,'活力花紋長筒牛仔褲_2','1500','DDF0FF','S',5),(15,19,'活力花紋長筒牛仔褲_1','1299','DDF0FF','M',1),(16,19,'活力花紋長筒牛仔褲_2','1500','DDF0FF','S',5);
/*!40000 ALTER TABLE `orderList` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `Order_ID` int NOT NULL AUTO_INCREMENT,
  `Shipping` varchar(255) NOT NULL,
  `Payment` varchar(255) NOT NULL,
  `Subtotal` float NOT NULL,
  `Freight` float NOT NULL,
  `Total` float NOT NULL,
  `Name` varchar(255) NOT NULL,
  `Phone` varchar(255) NOT NULL,
  `Email` varchar(255) NOT NULL,
  `Address` varchar(255) NOT NULL,
  `Time` varchar(255) NOT NULL,
  `Paid` tinyint NOT NULL,
  `Rec_Trade_ID` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Order_ID`),
  UNIQUE KEY `idtest_UNIQUE` (`Order_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (17,'delivery','credit_card',1234,14,1300,'asd','asdf','sdf','asdf','Morning',1,'D20210406RUmEjz'),(18,'delivery','credit_card',1234,14,1300,'123','23423','123','123132','Not Specify',1,'D20210406X8DcrM'),(19,'delivery','credit_card',1234,14,1300,'henry','3234','jdjd@gmail.com','234 hr street','Morning',1,'D20210407vOfS2Q');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `Product_ID` int NOT NULL,
  `Category` varchar(255) NOT NULL,
  `Title` varchar(255) NOT NULL,
  `Description` varchar(255) NOT NULL,
  `Price` int NOT NULL,
  `Texture` varchar(255) NOT NULL,
  `Wash` varchar(45) NOT NULL,
  `Place` varchar(255) NOT NULL,
  `Note` varchar(255) NOT NULL,
  `Story` varchar(255) NOT NULL,
  `Main_image` varchar(255) NOT NULL,
  `Other_image_1` varchar(255) NOT NULL,
  `Other_image_2` varchar(255) NOT NULL,
  `Other_image_3` varchar(255) NOT NULL,
  `Other_image_4` varchar(255) NOT NULL,
  PRIMARY KEY (`Product_ID`),
  UNIQUE KEY `Product_ID_UNIQUE` (`Product_ID`),
  UNIQUE KEY `Main_image_UNIQUE` (`Main_image`),
  UNIQUE KEY `Other_image_1_UNIQUE` (`Other_image_1`),
  UNIQUE KEY `Other_image_2_UNIQUE` (`Other_image_2`),
  UNIQUE KEY `Other_image_3_UNIQUE` (`Other_image_3`),
  UNIQUE KEY `Other_image_4_UNIQUE` (`Other_image_4`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `User_ID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `Email` varchar(255) NOT NULL,
  `Password` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`User_ID`),
  UNIQUE KEY `iduser_UNIQUE` (`User_ID`),
  UNIQUE KEY `email_UNIQUE` (`Email`)
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (60,'test123','test_123@test.com','$2b$10$eH11D/7RckZw2oezZkonNONP/vi.NXXh/tg9Ccev39mFsevNLMz/a'),(61,'Momo','momo_jkl@gmail.com','$2b$10$Q7G9Plq4jdYNx6pYgxshT.Co3SQWyow7uYeVCoKu9U9i/3e5g9wiO'),(62,'林鼎棋','gn01168178@yahoo.com.tw',NULL);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `variant`
--

DROP TABLE IF EXISTS `variant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `variant` (
  `Product_ID` int NOT NULL,
  `Size` varchar(255) NOT NULL,
  `Color_code` varchar(255) NOT NULL,
  `Stock` int NOT NULL,
  PRIMARY KEY (`Product_ID`,`Size`,`Color_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `variant`
--

LOCK TABLES `variant` WRITE;
/*!40000 ALTER TABLE `variant` DISABLE KEYS */;
/*!40000 ALTER TABLE `variant` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-04-08 11:43:56
