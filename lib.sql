-- MySQL dump 10.13  Distrib 8.0.37, for Linux (x86_64)
--
-- Host: localhost    Database: lib
-- ------------------------------------------------------
-- Server version	8.0.37

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
-- Current Database: `lib`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `lib` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `lib`;

--
-- Table structure for table `Books`
--

DROP TABLE IF EXISTS `Books`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Books` (
  `ISBN` int NOT NULL,
  `Title` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Quantity` int DEFAULT '0',
  PRIMARY KEY (`ISBN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Books`
--

LOCK TABLES `Books` WRITE;
/*!40000 ALTER TABLE `Books` DISABLE KEYS */;
INSERT INTO `Books` VALUES (101,'Mio, min Mio',3),(102,'Harry Potter',3),(103,'Sagan om Ringen',2),(104,'To Kill a Mockingbird',4),(105,'Pride and Prejudice',6),(106,'The Catcher in the Rye',1),(107,'1984',5),(108,'The Great Gatsby',3),(109,'Jane Eyre',2),(110,'Lord of the Flies',4),(111,'The Hobbit',7),(112,'Brave New World',3),(113,'Animal Farm',2),(114,'Wuthering Heights',4),(115,'Frankenstein',6),(116,'Little Women',1),(117,'The Bell Jar',5),(118,'Catch-22',3),(119,'Gone with the Wind',2),(120,'The Lord of the Rings',4),(121,'Hejsan',5);
/*!40000 ALTER TABLE `Books` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Borrows`
--

DROP TABLE IF EXISTS `Borrows`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Borrows` (
  `BID` int NOT NULL AUTO_INCREMENT,
  `ISBN` int DEFAULT NULL,
  `CID` int DEFAULT NULL,
  `SID` int DEFAULT NULL,
  `StartDate` date DEFAULT (curdate()),
  `EndDate` date DEFAULT ((curdate() + interval 3 month)),
  `ReturnedDate` date DEFAULT NULL,
  PRIMARY KEY (`BID`),
  KEY `ISBN` (`ISBN`),
  KEY `CID` (`CID`),
  KEY `SID` (`SID`),
  CONSTRAINT `Borrows_ibfk_1` FOREIGN KEY (`ISBN`) REFERENCES `Books` (`ISBN`),
  CONSTRAINT `Borrows_ibfk_2` FOREIGN KEY (`CID`) REFERENCES `Customers` (`CID`),
  CONSTRAINT `Borrows_ibfk_3` FOREIGN KEY (`SID`) REFERENCES `Staff` (`SID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Borrows`
--

LOCK TABLES `Borrows` WRITE;
/*!40000 ALTER TABLE `Borrows` DISABLE KEYS */;
INSERT INTO `Borrows` VALUES (2,101,1,1,'2024-08-20','2024-11-20',NULL),(4,101,2,2,'2024-08-20','2024-11-20',NULL);
/*!40000 ALTER TABLE `Borrows` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `borrowedBook` AFTER INSERT ON `Borrows` FOR EACH ROW BEGIN

  UPDATE Books
  SET Books.Quantity = Books.Quantity - 1
  WHERE NEW.ISBN = Books.ISBN;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `returnedBook` AFTER UPDATE ON `Borrows` FOR EACH ROW BEGIN

  DECLARE returnedDate DATE;

  SELECT Borrows.ReturnedDate
  INTO returnedDate
  FROM Borrows
  WHERE NEW.BID = Borrows.BID;

  IF returnedDate IS NOT NULL THEN
    UPDATE Books
    SET Books.Quantity = Books.Quantity + 1
    WHERE Books.ISBN = NEW.ISBN;
  END IF;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `CurrentlyBorrowed`
--

DROP TABLE IF EXISTS `CurrentlyBorrowed`;
/*!50001 DROP VIEW IF EXISTS `CurrentlyBorrowed`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `CurrentlyBorrowed` AS SELECT 
 1 AS `ISBN`,
 1 AS `Title`,
 1 AS `CurrentlyBorrowed`,
 1 AS `EarliestReturn`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `Customers`
--

DROP TABLE IF EXISTS `Customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Customers` (
  `CID` int NOT NULL AUTO_INCREMENT,
  `FName` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  `LName` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  `PhoneNbr` int DEFAULT NULL,
  `Email` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`CID`),
  CONSTRAINT `ValidateCustomer` CHECK (((`Email` is not null) or (`PhoneNbr` is not null)))
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Customers`
--

LOCK TABLES `Customers` WRITE;
/*!40000 ALTER TABLE `Customers` DISABLE KEYS */;
INSERT INTO `Customers` VALUES (1,'Emma','Andersson',12345,'emma.andersson@gmail.com'),(2,'Oscar','Nilsson',32215,'oscar.nilsson@hotmail.com'),(3,'Sofia','Karlsson',18273,'sofia.karlsson@yahoo.com'),(4,'Lucas','Eriksson',34421,'lucas.eriksson@gmail.com'),(5,'Alice','Johansson',62346,'alice.johansson@gmail.com'),(6,'William','Lindström',12345,'william.lindstrom@gmail.com'),(7,'Julia','Persson',56231,'julia.persson@hotmail.com'),(8,'Elias','Gustafsson',56623,'elias.gustafsson@yahoo.com'),(9,'Klara','Berg',12435,'klara.berg@gmail.com'),(10,'Liam','Svensson',63421,'liam.svensson@hotmail.com'),(11,'Moa','Bergström',72354,'moa.bergstrom@gmail.com'),(12,'Hugo','Andersson',23465,'hugo.andersson@yahoo.com'),(13,'Alva','Lindgren',23623,'alva.lindgren@gmail.com'),(14,'Noah','Sjöberg',62345,'noah.sjoberg@hotmail.com'),(15,'Wilma','Holm',63242,'wilma.holm@yahoo.com'),(16,'Ebba','Ahlström',23456,'ebba.ahlstrom@gmail.com'),(17,'Isak','Ek',34562,'isak.ek@hotmail.com'),(18,'Ella','Lundgren',73452,'ella.lundgren@gmail.com'),(19,'Filip','Öberg',45657,'filip.oberg@yahoo.com'),(20,'Vera','Åberg',23835,'vera.aberg@hotmail.com'),(21,'Oliver','Nyström',53426,'oliver.nystrom@gmail.com'),(22,'Saga','Norberg',23477,'saga.norberg@yahoo.com'),(23,'Axel','Bergman',34527,'axel.bergman@gmail.com'),(24,'Elsa','Sundqvist',23472,'elsa.sundqvist@hotmail.com'),(25,'Gabriel','Hellström',84523,'gabriel.hellstrom@gmail.com'),(26,'Molly','Lundqvist',97865,'molly.lundqvist@yahoo.com'),(27,'Melvin','Ekström',65783,'melvin.ekstrom@gmail.com'),(28,'Nova','Håkansson',87563,'nova.hakansson@hotmail.com'),(29,'Vincent','Söderberg',86532,'vincent.soderberg@gmail.com'),(30,'Ellen','Nyberg',85623,'ellen.nyberg@yahoo.com'),(31,'Liam','Holmgren',58645,'liam.holmgren@gmail.com'),(32,'Astrid','Lindqvist',82675,'astrid.lindqvist@hotmail.com'),(33,'Adam','Månsson',25347,'adam.mansson@gmail.com'),(34,'Molly','Jonsson',45769,'molly.jonsson@yahoo.com'),(35,'Nils','Pålsson',23458,'nils.palsson@gmail.com'),(36,'Alice','Ekman',43562,'alice.ekman@hotmail.com'),(37,'Elias','Sandberg',87634,'elias.sandberg@gmail.com'),(38,'Saga','Dahlberg',97234,'saga.dahlberg@yahoo.com'),(39,'Elvira','Bergqvist',75653,'elvira.bergqvist@gmail.com'),(40,'William','Engström',65434,'william.engstrom@hotmail.com'),(41,'Ida','Larsson',34568,'ida.larsson@yahoo.com'),(42,'Hugo','Lund',97632,'hugo.lund@gmail.com'),(43,'Julia','Strömberg',24894,'julia.stromberg@hotmail.com'),(44,'Liam','Åkesson',98764,'liam.akesson@gmail.com'),(45,'Maja','Forsberg',23465,'maja.forsberg@yahoo.com'),(46,'Max','Eklund',98349,'max.eklund@gmail.com'),(47,'Elsa','Sjögren',92393,'elsa.sjogren@hotmail.com'),(48,'class','ohlsson',12345,'c.c@c.com');
/*!40000 ALTER TABLE `Customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `LateReturns`
--

DROP TABLE IF EXISTS `LateReturns`;
/*!50001 DROP VIEW IF EXISTS `LateReturns`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `LateReturns` AS SELECT 
 1 AS `Title`,
 1 AS `ISBN`,
 1 AS `CName`,
 1 AS `EndDate`,
 1 AS `DaysLate`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `MostPopularBorrow`
--

DROP TABLE IF EXISTS `MostPopularBorrow`;
/*!50001 DROP VIEW IF EXISTS `MostPopularBorrow`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `MostPopularBorrow` AS SELECT 
 1 AS `ISBN`,
 1 AS `Title`,
 1 AS `BorrowCount`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `Staff`
--

DROP TABLE IF EXISTS `Staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Staff` (
  `SID` int NOT NULL AUTO_INCREMENT,
  `FName` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  `LName` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  `PhoneNbr` int NOT NULL,
  `Email` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`SID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Staff`
--

LOCK TABLES `Staff` WRITE;
/*!40000 ALTER TABLE `Staff` DISABLE KEYS */;
INSERT INTO `Staff` VALUES (1,'Anna','Andersson',98672,'anna.anderssoon@biblioteket.se'),(2,'David','Nilsson',23958,'david.nilsson@biblioteket.se'),(3,'Linda','Johansson',94834,'linda.johansson@biblioteket.se'),(4,'Erik','Svensson',23285,'erik.svensson@biblioteket.se'),(5,'Sara','Karlsson',23895,'sara.karlsson@biblioteket.se'),(6,'class','ohlsson',123455,'c.c@c.com');
/*!40000 ALTER TABLE `Staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Current Database: `lib`
--

USE `lib`;

--
-- Final view structure for view `CurrentlyBorrowed`
--

/*!50001 DROP VIEW IF EXISTS `CurrentlyBorrowed`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`lib`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `CurrentlyBorrowed` AS select `Borrows`.`ISBN` AS `ISBN`,`Books`.`Title` AS `Title`,count(`Borrows`.`ISBN`) AS `CurrentlyBorrowed`,min(`Borrows`.`EndDate`) AS `EarliestReturn` from (`Borrows` join `Books` on((`Borrows`.`ISBN` = `Books`.`ISBN`))) group by `Borrows`.`ISBN` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `LateReturns`
--

/*!50001 DROP VIEW IF EXISTS `LateReturns`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`lib`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `LateReturns` AS select `Books`.`Title` AS `Title`,`Books`.`ISBN` AS `ISBN`,concat(`Customers`.`FName`,' ',`Customers`.`LName`) AS `CName`,`Borrows`.`EndDate` AS `EndDate`,(to_days(curdate()) - to_days(`Borrows`.`EndDate`)) AS `DaysLate` from ((`Borrows` join `Customers` on((`Borrows`.`CID` = `Customers`.`CID`))) join `Books` on((`Borrows`.`ISBN` = `Books`.`ISBN`))) where (`Borrows`.`EndDate` < curdate()) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `MostPopularBorrow`
--

/*!50001 DROP VIEW IF EXISTS `MostPopularBorrow`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`lib`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `MostPopularBorrow` AS select `Borrows`.`ISBN` AS `ISBN`,`Books`.`Title` AS `Title`,count(`Borrows`.`ISBN`) AS `BorrowCount` from (`Borrows` join `Books` on((`Borrows`.`ISBN` = `Books`.`ISBN`))) group by `Borrows`.`ISBN` order by `BorrowCount` desc limit 1 */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-08-23 15:37:07
