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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `campaign`
--

LOCK TABLES `campaign` WRITE;
/*!40000 ALTER TABLE `campaign` DISABLE KEYS */;
INSERT INTO `campaign` VALUES (1,12,'eng13235okn1ye67b','cool sale'),(2,13,'eng13237ikn1ygi5j','warm and hot'),(3,2,'eng1321hskn2riat0','kit kat'),(4,4,'eng1322q0kn2t38ns','red sox');
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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orderList`
--

LOCK TABLES `orderList` WRITE;
/*!40000 ALTER TABLE `orderList` DISABLE KEYS */;
INSERT INTO `orderList` VALUES (1,12,'活力花紋長筒牛仔褲_1','1299','DDF0FF','M',1),(2,12,'活力花紋長筒牛仔褲_2','1500','DDF0FF','S',5),(3,13,'活力花紋長筒牛仔褲_1','1299','DDF0FF','M',1),(4,13,'活力花紋長筒牛仔褲_2','1500','DDF0FF','S',5),(5,14,'活力花紋長筒牛仔褲_1','1299','DDF0FF','M',1),(6,14,'活力花紋長筒牛仔褲_2','1500','DDF0FF','S',5),(7,15,'活力花紋長筒牛仔褲_1','1299','DDF0FF','M',1),(8,15,'活力花紋長筒牛仔褲_2','1500','DDF0FF','S',5),(9,16,'活力花紋長筒牛仔褲_1','1299','DDF0FF','M',1),(10,16,'活力花紋長筒牛仔褲_2','1500','DDF0FF','S',5),(11,17,'活力花紋長筒牛仔褲_1','1299','DDF0FF','M',1),(12,17,'活力花紋長筒牛仔褲_2','1500','DDF0FF','S',5),(13,18,'活力花紋長筒牛仔褲_1','1299','DDF0FF','M',1),(14,18,'活力花紋長筒牛仔褲_2','1500','DDF0FF','S',5);
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
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (5,'delivery','credit_card',1234,14,1300,'123','123','123','123','Morning',1,'sss'),(6,'delivery','credit_card',1234,14,1300,'sdf','sdf','sdf','sdf','Morning',1,NULL),(7,'delivery','credit_card',1234,14,1300,'wer','wer','wer','wer','Morning',0,NULL),(8,'delivery','credit_card',1234,14,1300,'234','234','234','234','Morning',0,NULL),(9,'delivery','credit_card',1234,14,1300,'dfg','sdfg','sdfg','dfg','Morning',0,NULL),(10,'delivery','credit_card',1234,14,1300,'asdf','adsf','asdf','asdf','Morning',0,NULL),(11,'delivery','credit_card',1234,14,1300,'asdf','asd','asd','asdf','Morning',0,NULL),(12,'delivery','credit_card',1234,14,1300,'asdf','asdf','asdf','asdf','Morning',0,NULL),(13,'delivery','credit_card',1234,14,1300,'123','123','12','123','Morning',0,NULL),(14,'delivery','credit_card',1234,14,1300,'test','set','set','set','Morning',0,NULL),(15,'delivery','credit_card',1234,14,1300,'sdfsdf','sdfsdf','sdfsdf','sdfsdf','Not Specify',1,NULL),(16,'delivery','credit_card',1234,14,1300,'dfgdsf','sdfgsdf','sdfsdfg','sdfgsdfg','Afternoon',0,NULL),(17,'delivery','credit_card',1234,14,1300,'asd','asdf','sdf','asdf','Morning',1,'D20210406RUmEjz'),(18,'delivery','credit_card',1234,14,1300,'123','23423','123','123132','Not Specify',1,'D20210406X8DcrM');
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
INSERT INTO `product` VALUES (1,'Women','Trousers_1','Casual Style',2340,'Cotton','Hand Wash','Taiwan','None','Popular Sell','eng1321xdkmw4wzzk','eng1321xdkmw4wzzm','eng1321xdkmw4wzzn','eng1321xdkmw4wzzo','eng1321xdkmw4wzzp'),(2,'Women','Hat_1','Casual Style',139000,'Cotton 100','Hand Wash','Taiwan','None','Popular Sell','eng1321xdkmw4zqcj','eng1321xdkmw4zqcl','eng1321xdkmw4zqcn','eng1321xdkmw4zqco','eng1321xdkmw4zqcp'),(3,'Women','Hat_1','Casual Style',139000,'Cotton 100','Hand Wash','Taiwan','None','Popular Sell','eng1321xdkmw4zzes','eng1321xdkmw4zzet','eng1321xdkmw4zzeu','eng1321xdkmw4zzev','eng1321xdkmw4zzew'),(4,'Women','Hat_1','Casual Style',139000,'Cotton 100','Hand Wash','Taiwan','None','Popular Sell','eng1321xdkmw5039u','eng1321xdkmw5039w','eng1321xdkmw5039x','eng1321xdkmw5039y','eng1321xdkmw5039z'),(5,'Women','Hat_1','Casual Style',139000,'Cotton 100','Hand Wash','Taiwan','None','Popular Sell','eng1321xdkmw505up','eng1321xdkmw505uq','eng1321xdkmw505ur','eng1321xdkmw505us','eng1321xdkmw505ut'),(6,'Women','Hat_1','Casual Style',139000,'Cotton 100','Hand Wash','Taiwan','None','Popular Sell','eng1321xdkmw508ku','eng1321xdkmw508kv','eng1321xdkmw508kw','eng1321xdkmw508kx','eng1321xdkmw508ky'),(7,'Women','Hat_1','Casual Style',139000,'Cotton 100','Hand Wash','Taiwan','None','Popular Sell','eng1321xdkmw50b84','eng1321xdkmw50b85','eng1321xdkmw50b86','eng1321xdkmw50b87','eng1321xdkmw50b88'),(8,'Women','Hat_1','Casual Style',139000,'Cotton 100','Hand Wash','Taiwan','None','Popular Sell','eng1321xdkmw50dqa','eng1321xdkmw50dqb','eng1321xdkmw50dqc','eng1321xdkmw50dqd','eng1321xdkmw50dqe'),(9,'Women','Hat_1','Casual Style',139000,'Cotton 100','Hand Wash','Taiwan','None','Popular Sell','eng1321xdkmw50gjs','eng1321xdkmw50gjt','eng1321xdkmw50gju','eng1321xdkmw50gjv','eng1321xdkmw50gjw'),(10,'Women','Hat_1','Casual Style',139000,'Cotton 100','Hand Wash','Taiwan','None','Popular Sell','eng1321xdkmw50jtk','eng1321xdkmw50jtl','eng1321xdkmw50jtm','eng1321xdkmw50jtn','eng1321xdkmw50jto'),(11,'Women','Hat_1','Casual Style',139000,'Cotton 100','Hand Wash','Taiwan','None','Popular Sell','eng1321xdkmw50na4','eng1321xdkmw50na6','eng1321xdkmw50na7','eng1321xdkmw50na8','eng1321xdkmw50na9'),(12,'Women','Hat_1','Casual Style',139000,'Cotton 100','Hand Wash','Taiwan','None','Popular Sell','eng1321xdkmw50pij','eng1321xdkmw50pik','eng1321xdkmw50pil','eng1321xdkmw50pim','eng1321xdkmw50pin'),(13,'Accessories','Hat_1','Casual Style',13,'Cotton 100','Hand Wash','Taiwan','None','Popular Sell','eng1321xdkmw51dnx','eng1321xdkmw51dny','eng1321xdkmw51dnz','eng1321xdkmw51do0','eng1321xdkmw51do1'),(14,'Accessories','Hat_1','Casual Style',13,'Cotton 100','Hand Wash','Taiwan','None','Popular Sell','eng1321xdkmw51gak','eng1321xdkmw51gal','eng1321xdkmw51gam','eng1321xdkmw51gan','eng1321xdkmw51gao'),(15,'Accessories','Hat_1','Casual Style',13,'Cotton 100','Hand Wash','Taiwan','None','Popular Sell','eng1321xdkmw51k5j','eng1321xdkmw51k5k','eng1321xdkmw51k5l','eng1321xdkmw51k5m','eng1321xdkmw51k5n'),(16,'Accessories','Hat_1','Casual Style',13,'Cotton 100','Hand Wash','Taiwan','None','Popular Sell','eng1321xdkmw5230u','eng1321xdkmw5230v','eng1321xdkmw5230w','eng1321xdkmw5230x','eng1321xdkmw5230y'),(17,'Accessories','Hat_1','Casual Style',13,'Cotton 100','Hand Wash','Taiwan','None','Popular Sell','eng1321xdkmw526at','eng1321xdkmw526au','eng1321xdkmw526av','eng1321xdkmw526aw','eng1321xdkmw526ax'),(18,'Men','Hat_1','Casual Style',13,'Cotton 100','Hand Wash','Taiwan','None','Popular Sell','eng1321xdkmw529y4','eng1321xdkmw529y5','eng1321xdkmw529y6','eng1321xdkmw529y7','eng1321xdkmw529y8'),(19,'Men','Hat_1','Casual Style',13,'Cotton 100','Hand Wash','Taiwan','None','Popular Sell','eng1321xdkmw52cdm','eng1321xdkmw52cdn','eng1321xdkmw52cdo','eng1321xdkmw52cdp','eng1321xdkmw52cdq'),(20,'Men','Hat_1','Casual Style',13,'Cotton 100','Hand Wash','Taiwan','None','Popular Sell','eng1321xdkmw52f3p','eng1321xdkmw52f3q','eng1321xdkmw52f3r','eng1321xdkmw52f3s','eng1321xdkmw52f3t'),(21,'Accessories','Hat_1','Casual Style',13,'Cotton 100','Hand Wash','Taiwan','None','Popular Sell','eng1321xdkmw52jkn','eng1321xdkmw52jko','eng1321xdkmw52jkp','eng1321xdkmw52jkq','eng1321xdkmw52jkr'),(22,'Women','Pant_345','none',350,'none','none','none','none','cool','eng132347kmww2re7','eng132347kmww2re8','eng132347kmww2re9','eng132347kmww2rea','eng132347kmww2reb'),(23,'Women','Pants_345','none',350,'none','none','none','none','cool','eng132347kmww32q5','eng132347kmww32q6','eng132347kmww32q7','eng132347kmww32q8','eng132347kmww32q9'),(24,'Women','Pants_345','none',350,'none','none','none','none','cool','eng132347kmww3504','eng132347kmww3505','eng132347kmww3506','eng132347kmww3507','eng132347kmww3508'),(25,'Women','厚實毛呢格子外套','none',350,'none','none','none','none','cool','eng1323dgkmwwlrtz','eng1323dgkmwwlru0','eng1323dgkmwwlru1','eng1323dgkmwwlru2','eng1323dgkmwwlru3'),(26,'Women','洋裝','none',350,'none','none','none','none','cool','eng1323dgkmwwn44u','eng1323dgkmwwn44v','eng1323dgkmwwn44w','eng1323dgkmwwn44x','eng1323dgkmwwn44y'),(27,'Women','洋裝_12','none',350,'none','none','none','none','cool','eng1323dgkmwwnb3z','eng1323dgkmwwnb40','eng1323dgkmwwnb41','eng1323dgkmwwnb42','eng1323dgkmwwnb43'),(28,'Women','洋裝_13','none',350,'none','none','none','none','cool','eng1323dgkmwwnfun','eng1323dgkmwwnfuo','eng1323dgkmwwnfup','eng1323dgkmwwnfuq','eng1323dgkmwwnfur'),(45,'Women','sdfsdf','sdfsdf',12323,'nono','nonon','ononon','onon','monon','eng1321orkmz0cje4','eng1321orkmz0cje5','eng1321orkmz0cje6','eng1321orkmz0cje7','eng1321orkmz0cje8');
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
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (60,'test123','test_123@test.com','$2b$10$eH11D/7RckZw2oezZkonNONP/vi.NXXh/tg9Ccev39mFsevNLMz/a');
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
INSERT INTO `variant` VALUES (1,'M','DDFFBB',120),(1,'S','FFFFFF',12),(1,'XL','CCCCCC',120),(1,'XL','DDF0FF',120),(1,'XL','DDFFBB',120),(2,'XL','DDF0FF',120),(3,'XL','DDF0FF',120),(4,'XL','DDF0FF',120),(5,'XL','DDF0FF',120),(6,'XL','DDF0FF',120),(7,'XL','DDF0FF',120),(8,'XL','DDF0FF',120),(9,'XL','DDF0FF',120),(10,'XL','DDF0FF',120),(11,'XL','DDF0FF',120),(12,'M','CCCCCC',120),(12,'M','DDFFBB',120),(12,'M','FFDDDD',120),(12,'XL','CCCCCC',120),(12,'XL','DDF0FF',120),(13,'M','FFDDDD',120),(14,'M','FFDDDD',120),(15,'F','BB7744',120),(15,'F','DDF0FF',120),(15,'F','FFFFFF',120),(15,'L','FFFFFF',120),(15,'M','BB7744',120),(15,'M','FFDDDD',240),(16,'L','FFFFFF',120),(17,'L','FFFFFF',120),(18,'L','FFFFFF',120),(19,'L','FFFFFF',120),(20,'L','FFFFFF',120),(21,'L','FFFFFF',120),(22,'L','FFFFFF',133),(23,'L','FFFFFF',133),(24,'L','FFFFFF',133),(25,'L','FFFFFF',133),(26,'L','FFFFFF',133),(27,'L','FFFFFF',133),(28,'L','FFFFFF',133),(45,'S','DDF0FF',688),(45,'S','FFFFFF',1032),(45,'XL','DDF0FF',1032),(45,'XL','DDFFBB',344);
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

-- Dump completed on 2021-04-06 14:27:25
