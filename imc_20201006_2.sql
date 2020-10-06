-- MySQL dump 10.13  Distrib 8.0.20, for Win64 (x86_64)
--
-- Host: localhost    Database: imc
-- ------------------------------------------------------
-- Server version	8.0.20

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

USE imc;
--
-- Table structure for table `brands`
--

DROP TABLE IF EXISTS `brands`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `brands` (
  `id_brand` int NOT NULL AUTO_INCREMENT,
  `cod_brand` varchar(45) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `path_image` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`id_brand`),
  UNIQUE KEY `cod_brand_UNIQUE` (`cod_brand`)
) ENGINE=InnoDB AUTO_INCREMENT=16384 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `parts`
--

DROP TABLE IF EXISTS `parts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `parts` (
  `id_part` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_part`)
) ENGINE=InnoDB AUTO_INCREMENT=764056 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `parts_replacements`
--

DROP TABLE IF EXISTS `parts_replacements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `parts_replacements` (
  `id_part_replacement` int NOT NULL AUTO_INCREMENT,
  `id_part` int DEFAULT NULL,
  `replacement_id` int DEFAULT NULL,
  PRIMARY KEY (`id_part_replacement`),
  KEY `ind_idpart_idreplacement` (`id_part`,`replacement_id`)
) ENGINE=InnoDB AUTO_INCREMENT=284244 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `id_product` int NOT NULL AUTO_INCREMENT,
  `id_brand` varchar(45) NOT NULL,
  `sku` varchar(45) DEFAULT NULL,
  `description` varchar(150) DEFAULT NULL,
  `cost` decimal(8,3) DEFAULT NULL,
  `price_list` decimal(8,3) DEFAULT NULL,
  `core` varchar(50) DEFAULT NULL,
  `position` varchar(250) DEFAULT NULL,
  `imc_sku` varchar(45) DEFAULT NULL,
  `weight` varchar(45) DEFAULT NULL,
  `pack_qty` varchar(45) DEFAULT NULL,
  `qty_required` varchar(45) DEFAULT NULL,
  `warranty` varchar(45) DEFAULT NULL,
  `description_large` text,
  `features_benefits` text,
  `path_image` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_product`),
  UNIQUE KEY `id_product_UNIQUE` (`id_product`),
  KEY `ind_idproduct` (`id_product`)
) ENGINE=InnoDB AUTO_INCREMENT=17424 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping routines for database 'imc'
--
/*!50003 DROP FUNCTION IF EXISTS `sps_brand` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `sps_brand`(
	vi_name varchar(50)
) RETURNS int
    DETERMINISTIC
BEGIN
    DECLARE count INT DEFAULT 0;
    
	select 
		id_brand into count 
	from brands
    where
		name = trim(vi_name);
        
	return count;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `sps_brand_v2` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `sps_brand_v2`(
	vi_cod_brand varchar(50)
) RETURNS int
    DETERMINISTIC
BEGIN
    DECLARE count INT DEFAULT 0;
    
	select 
		id_brand into count 
	from brands
    where
		cod_brand = vi_cod_brand;
        
	return count;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `sps_product` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `sps_product`(
	vi_sku varchar(50),
    vi_brand varchar(45)
) RETURNS int
    DETERMINISTIC
BEGIN
    DECLARE count INT DEFAULT 0;
    
	select 
		p.id_product into count 
	from products p
    inner join brands b on b.id_brand = p.id_brand
    where
		p.sku = trim(vi_sku) and
        b.name = trim(vi_brand);
        
	return count;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `sps_product_v2` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `sps_product_v2`(
	vi_sku varchar(50),
    vi_cod_brand varchar(45)
) RETURNS int
    DETERMINISTIC
BEGIN
    DECLARE count INT DEFAULT 0;
    
	select 
		p.id_product into count 
	from products p
    inner join brands b on b.id_brand = p.id_brand
    where
		p.sku = trim(vi_sku) and
        b.cod_brand = trim(vi_cod_brand);
        
	return count;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spi_brand` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spi_brand`(IN vi_name varchar(50), IN vi_path varchar(50), OUT vo_insert_id INT)
BEGIN
	DECLARE id INT DEFAULT 0;
    
    select 
		id_brand into id 
	from brands
    where
		name = trim(vi_name);
        
	if id > 0 then
		set vo_insert_id = id;
    else
		insert into brands(name, path_image) values (trim(vi_name), vi_path);
		set vo_insert_id = LAST_INSERT_ID();
    end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spi_brand_v2` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spi_brand_v2`(IN vi_cod_brand varchar(50), IN vi_path varchar(50), OUT vo_insert_id INT)
BEGIN
	DECLARE id INT DEFAULT 0;
    
    select 
		id_brand into id 
	from brands
    where
		cod_brand = vi_cod_brand;
        
	if id > 0 then
		set vo_insert_id = id;
    else
		insert into brands(cod_brand, path_image) values (vi_cod_brand, vi_path);
		set vo_insert_id = LAST_INSERT_ID();
    end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spi_parts_replacements` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spi_parts_replacements`(IN vi_ids varchar(500))
BEGIN
	SET @vi_sql = CONCAT("insert into parts_replacements(id_part, replacement_id) 
    select 
		distinct
			case when t1.id_product<=t2.id_product then t1.id_product else t2.id_product end id1,
			case when t1.id_product<=t2.id_product then t2.id_product else t1.id_product end id2
	from products t1 
    cross join products t2 
    where 
		t1.id_product IN (",vi_ids,") and 
        t2.id_product IN (",vi_ids,")");
    
    PREPARE stmt FROM @vi_sql;
	EXECUTE stmt;
	DEALLOCATE PREPARE stmt;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spi_product` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spi_product`(IN vi_id_brand int, IN vi_sku varchar(45), IN vi_description varchar(150), IN vi_cost decimal(8,3), IN vi_price_list decimal(8,3), IN vi_core varchar(50), IN vi_position varchar(250), IN vi_imc_sku varchar(50), IN vi_weight decimal(4,2), IN vi_pack_qty varchar(20), IN vi_qty_req int, IN vi_warranty varchar(50), IN vi_desc_large TEXT, IN vi_features TEXT, IN vi_path varchar(50), OUT vo_insert_id INT)
BEGIN
	DECLARE id INT DEFAULT 0;
    
    select 
		id_product into id 
	from products
    where
		sku = trim(vi_sku);
        
	if id > 0 then
		set vo_insert_id = id;
    else
		insert into products(id_brand, sku, description, cost, price_list, core, position, imc_sku, weight, pack_qty, qty_required, warranty, description_large, features_benefits, path_image) values (vi_id_brand, trim(vi_sku), vi_description, vi_cost, vi_price_list, vi_core, vi_position, vi_imc_sku, vi_weight, vi_pack_qty, vi_qty_req, vi_warranty, vi_desc_large, vi_features, vi_path);
		set vo_insert_id = LAST_INSERT_ID();
    end if;
END ;;
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

-- Dump completed on 2020-10-06 15:04:50
