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
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orderList`
--

LOCK TABLES `orderList` WRITE;
/*!40000 ALTER TABLE `orderList` DISABLE KEYS */;
INSERT INTO `orderList` VALUES (1,12,'活力花紋長筒牛仔褲_1','1299','DDF0FF','M',1),(2,12,'活力花紋長筒牛仔褲_2','1500','DDF0FF','S',5),(3,13,'活力花紋長筒牛仔褲_1','1299','DDF0FF','M',1),(4,13,'活力花紋長筒牛仔褲_2','1500','DDF0FF','S',5),(5,14,'活力花紋長筒牛仔褲_1','1299','DDF0FF','M',1),(6,14,'活力花紋長筒牛仔褲_2','1500','DDF0FF','S',5),(7,15,'活力花紋長筒牛仔褲_1','1299','DDF0FF','M',1),(8,15,'活力花紋長筒牛仔褲_2','1500','DDF0FF','S',5),(9,16,'活力花紋長筒牛仔褲_1','1299','DDF0FF','M',1),(10,16,'活力花紋長筒牛仔褲_2','1500','DDF0FF','S',5),(11,17,'活力花紋長筒牛仔褲_1','1299','DDF0FF','M',1),(12,17,'活力花紋長筒牛仔褲_2','1500','DDF0FF','S',5),(13,18,'活力花紋長筒牛仔褲_1','1299','DDF0FF','M',1),(14,18,'活力花紋長筒牛仔褲_2','1500','DDF0FF','S',5),(15,19,'活力花紋長筒牛仔褲_1','1299','DDF0FF','M',1),(16,19,'活力花紋長筒牛仔褲_2','1500','DDF0FF','S',5),(17,20,'活力花紋長筒牛仔褲_1','1299','DDF0FF','M',1),(18,20,'活力花紋長筒牛仔褲_2','1500','DDF0FF','S',5),(19,21,'活力花紋長筒牛仔褲','1299','CCCCCC','XL',1),(20,22,'時尚輕鬆休閒西裝','2399','FFFFFF','L',1),(21,22,'活力花紋長筒牛仔褲','1299','CCCCCC','XL',3),(22,22,'小扇紋細織上衣','599','CCCCCC','XL',2),(23,23,'活力花紋長筒牛仔褲','1299','CCCCCC','XL',1),(24,23,'小扇紋細織上衣','599','CCCCCC','XL',1),(25,24,'透肌澎澎防曬襯衫','599','FFFFFF','S',1),(26,24,'活力花紋長筒牛仔褲','1299','CCCCCC','L',1),(27,24,'純色輕薄百搭襯衫','799','FFFFFF','L',1),(28,25,'前開衩扭結洋裝','799','FFFFFF','S',1),(29,26,'前開衩扭結洋裝','799','FFFFFF','S',1),(30,27,'前開衩扭結洋裝','799','FFFFFF','S',1),(31,28,'透肌澎澎防曬襯衫','599','FFFFFF','S',1),(32,28,'時尚輕鬆休閒西裝','2399','FFFFFF','L',1),(33,28,'活力花紋長筒牛仔褲','1299','CCCCCC','XL',1),(34,29,'純色輕薄百搭襯衫','799','FFFFFF','L',1),(35,29,'小扇紋細織上衣','599','CCCCCC','XL',1),(36,30,'透肌澎澎防曬襯衫','599','FFFFFF','S',1),(37,30,'小扇紋細織上衣','599','CCCCCC','XL',1),(38,31,'活力花紋長筒牛仔褲','1299','CCCCCC','XL',1),(39,31,'活力花紋長筒牛仔褲','1299','CCCCCC','L',1),(40,31,'活力花紋長筒牛仔褲','1299','CCCCCC','F',2),(41,32,'透肌澎澎防曬襯衫','599','FFFFFF','S',1),(42,32,'前開衩扭結洋裝','799','FFFFFF','S',1),(43,32,'前開衩扭結洋裝','799','BB7744','F',1),(44,33,'前開衩扭結洋裝','799','FFFFFF','S',1),(45,34,'前開衩扭結洋裝','799','FFFFFF','S',1),(46,35,'前開衩扭結洋裝','799','FFFFFF','S',1),(47,36,'前開衩扭結洋裝','799','FFFFFF','S',1),(48,36,'純色輕薄百搭襯衫','799','FFFFFF','L',1),(49,37,'小扇紋細織上衣','599','CCCCCC','XL',1);
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
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (17,'delivery','credit_card',1234,14,1300,'asd','asdf','sdf','asdf','Morning',1,'D20210406RUmEjz'),(18,'delivery','credit_card',1234,14,1300,'123','23423','123','123132','Not Specify',1,'D20210406X8DcrM'),(19,'delivery','credit_card',1234,14,1300,'henry','3234','jdjd@gmail.com','234 hr street','Morning',1,'D20210407vOfS2Q'),(20,'delivery','credit_card',1234,14,1300,'1212','1212','1212','1212','Morning',1,'D20210410A7pSre'),(21,'delivery','credit_card',1299,60,1359,'Henry','0987654321','test_123@test.com','123 Happy Street','afternoon',1,'D20210411JdZE91'),(22,'delivery','credit_card',7494,60,7554,'Tony','0909456723','tony@gmail.com','45 Harcourt Rd','afternoon',1,'D20210411pPdrUG'),(23,'delivery','credit_card',1898,60,1958,'Ko','9845736234','ko@gmail.com','34 Ha Street','afternoon',1,'D20210411jIoH2D'),(24,'delivery','credit_card',2697,60,2757,'JoJo','9654234635','jojo@gmail.com','123 Hart Rd','anytime',1,'D20210411o1C3i5'),(25,'delivery','credit_card',799,60,859,'tete','9434637234','tete@gmail.com','123 jaja rd','afternoon',1,'D20210411oYAslC'),(26,'delivery','credit_card',799,60,859,'kiki','9767876543','kiki@gmail.com','678 Ht rd','afternoon',1,'D20210411aRj0tQ'),(27,'delivery','credit_card',799,60,859,'Tete','9876543123','tete@gmail.com','123 hr street','afternoon',1,'D20210411C3mjbB'),(28,'delivery','credit_card',4297,60,4357,'Kobe','9374623432','kobe@gmail.com','2234 hr street','afternoon',1,'D202104118dvkDS'),(29,'delivery','credit_card',1398,60,1458,'Hoho','9348376534','hoho@gmail.com','23 Hart Rd','afternoon',1,'D20210411Ye624G'),(30,'delivery','credit_card',1198,60,1258,'dodo','0987567456','dodo_123@gmail.com','123 dodo street','afternoon',1,'D20210411hOlFFg'),(31,'delivery','credit_card',5196,60,5256,'popo','0987354647','popo_123@gmail.com','23 popo street','afternoon',1,'D20210411IlruJH'),(32,'delivery','credit_card',2197,60,2257,'henry','09387343234','ph@gmail.com','34 ha street','afternoon',1,'D202104128OPx5z'),(33,'delivery','credit_card',799,60,859,'dodo','0987364465','dodo_123@gmail.com','123 jar rd','afternoon',1,'D202104123nUUAq'),(34,'delivery','credit_card',1598,60,1658,'dodo','0978675654','dodo_123@gmail.com','123 Dodo Rd.','afternoon',0,NULL),(35,'delivery','credit_card',1598,60,1658,'123','123','123','123','afternoon',0,NULL),(36,'delivery','credit_card',1598,60,1658,'dodo','0987475564','dodo_123@gmail.com','123 Do street','anytime',1,'D20210413ZDV3mz'),(37,'delivery','credit_card',599,60,659,'dodo','8374657746','dodo_123@gmail.com','23 do street','morning',1,'D2021041321d9QK');
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
INSERT INTO `product` VALUES (1,'Women','前開衩扭結洋裝','厚薄：薄 彈性：無',799,'棉 100%','手洗，溫水','中國','實品顏色依單品照為主','O.N.S is all about options, which is why we took our staple polo shirt and upgraded it with slubby linen jersey, making it even llighter for those who prefer their summer style extra-breezy','eng13240ikn8d8fom','eng13240ikn8d8foo','eng13240ikn8d8fop','eng13240ikn8d8for','eng13240ikn8d8fov'),(2,'Women','透肌澎澎防曬襯衫','厚薄：薄 彈性：無',599,'棉 100%','手洗，溫水','中國','實品顏色依單品照為主','好看的衣服','eng132blvkn8pxqnw','eng132blvkn8pxqny','eng132blvkn8pxqnz','eng132blvkn8pxqo0','eng132blvkn8pxqo2'),(3,'Women','小扇紋細織上衣','厚薄：薄 彈性：無',599,'棉 100%','手洗，溫水','中國','實品顏色依單品照為主','好看的衣服','eng132blvkn8pytcl','eng132blvkn8pytcm','eng132blvkn8pytcn','eng132blvkn8pytco','eng132blvkn8pytcp'),(4,'Women','活力花紋長筒牛仔褲','厚薄：薄 彈性：無',1299,'棉 100%','手洗，溫水','中國','實品顏色依單品照為主','好看的衣服','eng132blvkn8q01te','eng132blvkn8q01tf','eng132blvkn8q01th','eng132blvkn8q01ti','eng132blvkn8q01tj'),(5,'Men','純色輕薄百搭襯衫','厚薄：薄 彈性：無',799,'棉 100%','手洗，溫水','中國','實品顏色依單品照為主','好看的衣服','eng132blvkn8q1d59','eng132blvkn8q1d5a','eng132blvkn8q1d5b','eng132blvkn8q1d5c','eng132blvkn8q1d5d'),(6,'Men','時尚輕鬆休閒西裝','厚薄：薄 彈性：無',2399,'棉 100%','手洗，溫水','中國','實品顏色依單品照為主','好看的衣服','eng132blvkn8q2hge','eng132blvkn8q2hgg','eng132blvkn8q2hgh','eng132blvkn8q2hgi','eng132blvkn8q2hgj'),(7,'Accessories','夏日海灘戶外遮陽帽','厚薄：薄 彈性：無',1499,'棉 100%','手洗，溫水','中國','實品顏色依單品照為主','O.N.S is all about options, which is why we took our staple polo shirt and upgraded it with slubby linen jersey, making it even llighter for those who prefer their summer style extra-breezy','eng13212x7kneppedg','eng13212x7kneppedi','eng13212x7kneppedj','eng13212x7kneppee1','eng13212x7kneppee5'),(8,'Accessories','經典牛仔帽','厚薄：薄 彈性：無',799,'棉 100%','手洗，溫水','中國','實品顏色依單品照為主','O.N.S is all about options, which is why we took our staple polo shirt and upgraded it with slubby linen jersey, making it even llighter for those who prefer their summer style extra-breezy','eng13213q3kneqrj1n','eng13213q3kneqrj1q','eng13213q3kneqrj1r','eng13213q3kneqrj1s','eng13213q3kneqrj1t');
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
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (60,'test123','test_123@test.com','$2b$10$eH11D/7RckZw2oezZkonNONP/vi.NXXh/tg9Ccev39mFsevNLMz/a'),(61,'Momo','momo_jkl@gmail.com','$2b$10$Q7G9Plq4jdYNx6pYgxshT.Co3SQWyow7uYeVCoKu9U9i/3e5g9wiO'),(62,'林鼎棋','gn01168178@yahoo.com.tw',NULL),(63,'Henry','henry_123@gmail.com','$2b$10$lkk8gpDR7VibMP/pidii5.j0sHwj943XTtOgg7bzuLXy11Yq3NfNW'),(64,'koko','koko_123@gmail.com','$2b$10$UIuz1KMpPEJAF3P27x/0Tu3b17q5szhFxaStO/nQSjnOHQXgoUQQC'),(65,'rere','rere_123@gmail.com','$2b$10$3XaE4lqsvINd0Z7Ruz3lluX2RBQkPo55f1biRqYpPAYIZJoC7.R1u'),(66,'yoyo','yoyo_123@gmail.com','$2b$10$hVLWzjzioQ8usm4MzKTAE.vsyhcYCZ9YZtVbqH.BaEmTVswrZ/Vee'),(67,'dodo','dodo_123@gmail.com','$2b$10$XIEU2y.gJTBBZzakkoBN7ukk45smTD0.wVapYyTPw.mxZNuSTFCie'),(68,'fofo','fofo_123@gmail.com','$2b$10$Ll8xU3g6imvoMTCRJh7ExeaRdMrG3OAu4GApWh/wLCPoFTIHFlZLu'),(69,'soso','soso_123@gmail.com','$2b$10$FF0Cx/lg36omo.QNtAPxgukY4dsg8faclyWUa5y9VatcyotxdvbjW'),(70,'popo','popo_123@gmail.com','$2b$10$pnlN9ZJPGLxgakuC/MjL0.Wy0jAzyQnyF2Mp6ovsfxCvT2jjci.MO');
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
INSERT INTO `variant` VALUES (1,'F','BB7744',3),(1,'L','CCCCCC',111),(1,'L','FFDDDD',111),(1,'L','FFFFFF',3),(1,'M','BB7744',33),(1,'M','FFFFFF',33),(1,'S','FFFFFF',11),(2,'S','FFFFFF',12),(3,'L','DDF0FF',13),(3,'S','CCCCCC',33),(3,'XL','CCCCCC',13),(3,'XL','DDF0FF',13),(4,'F','CCCCCC',14),(4,'L','CCCCCC',14),(4,'XL','CCCCCC',14),(5,'L','FFFFFF',15),(6,'L','FFFFFF',16),(7,'L','BB7744',12),(7,'L','DDF0FF',9),(7,'M','BB7744',5),(7,'M','DDF0FF',7),(8,'M','BB7744',13);
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

-- Dump completed on 2021-04-13 13:07:30
