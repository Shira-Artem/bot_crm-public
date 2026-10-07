
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
DROP TABLE IF EXISTS `abonents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `abonents` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `type` enum('user','specialist') NOT NULL,
  `user_id` int DEFAULT NULL,
  `specialist_id` bigint DEFAULT NULL,
  `phone_e164` varchar(20) NOT NULL,
  `phone_verified` tinyint(1) NOT NULL DEFAULT '0',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `can_make_calls` tinyint(1) NOT NULL DEFAULT '1',
  `can_receive_calls` tinyint(1) NOT NULL DEFAULT '1',
  `preferred_channel` varchar(20) NOT NULL DEFAULT 'pstn',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `phone` varchar(32) DEFAULT NULL,
  `display_name` varchar(128) DEFAULT NULL,
  `entity_type` enum('client','specialist') DEFAULT NULL,
  `client_user_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_abonents_phone_e164` (`phone_e164`),
  UNIQUE KEY `uq_abonents_user_id` (`user_id`),
  UNIQUE KEY `uq_abonents_specialist_id` (`specialist_id`),
  KEY `idx_abonents_type_active` (`type`,`is_active`),
  KEY `idx_abonents_phone_verified` (`phone_verified`),
  KEY `ix_abonents_phone_e164` (`phone_e164`),
  CONSTRAINT `fk_abonents_specialist` FOREIGN KEY (`specialist_id`) REFERENCES `specialists` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_abonents_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `abonents` WRITE;
/*!40000 ALTER TABLE `abonents` DISABLE KEYS */;
/*!40000 ALTER TABLE `abonents` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `alfabank_ip_applications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alfabank_ip_applications` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `tg_user_id` bigint DEFAULT NULL,
  `alfabank_id` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('pending','approved','declined') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `alfabank_state` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `alfabank_raw` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_alfabank_ip_alfabank_id` (`alfabank_id`),
  KEY `idx_alfabank_ip_user` (`user_id`),
  KEY `idx_alfabank_ip_tg` (`tg_user_id`),
  KEY `idx_alfabank_ip_status` (`status`),
  CONSTRAINT `fk_alfabank_ip_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `alfabank_ip_applications` WRITE;
/*!40000 ALTER TABLE `alfabank_ip_applications` DISABLE KEYS */;
/*!40000 ALTER TABLE `alfabank_ip_applications` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `bonus_product_policies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bonus_product_policies` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_type` varchar(64) NOT NULL COMMENT 'order, service, ofd, edo, kkt и т.д.',
  `event_type` varchar(64) NOT NULL COMMENT 'purchase, first_purchase, repeat_purchase',
  `points_fixed` int DEFAULT NULL COMMENT 'Фиксированное кол-во баллов (NULL = не используется)',
  `points_per_rub` decimal(8,4) DEFAULT NULL COMMENT 'Баллов за 1 рубль (NULL = не используется)',
  `points_lifetime_days` int DEFAULT NULL COMMENT 'Срок жизни баллов (NULL = system default)',
  `min_order_rub` int DEFAULT NULL COMMENT 'Мин. сумма заказа для начисления',
  `max_points` int DEFAULT NULL COMMENT 'Потолок начисления за одну операцию',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `priority` int NOT NULL DEFAULT '0' COMMENT 'Приоритет: большее значение = выше',
  `valid_from` datetime DEFAULT NULL,
  `valid_until` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `ix_bpp_lookup` (`product_type`,`event_type`,`is_active`),
  KEY `ix_bpp_valid` (`valid_from`,`valid_until`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `bonus_product_policies` WRITE;
/*!40000 ALTER TABLE `bonus_product_policies` DISABLE KEYS */;
/*!40000 ALTER TABLE `bonus_product_policies` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `bot_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bot_events` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `ts` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `tg_user_id` bigint DEFAULT NULL,
  `chat_id` bigint DEFAULT NULL,
  `message_id` bigint DEFAULT NULL,
  `update_id` bigint DEFAULT NULL,
  `event_type` varchar(32) NOT NULL,
  `name` varchar(128) DEFAULT NULL,
  `callback_data` text,
  `text_len` int DEFAULT NULL,
  `has_file` tinyint(1) DEFAULT NULL,
  `payload` json DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_ts` (`ts`),
  KEY `idx_user_ts` (`tg_user_id`,`ts`),
  KEY `idx_type_name_ts` (`event_type`,`name`,`ts`),
  KEY `fk_events_users` (`user_id`),
  CONSTRAINT `fk_events_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=111 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `bot_events` WRITE;
/*!40000 ALTER TABLE `bot_events` DISABLE KEYS */;
INSERT INTO `bot_events` (`id`, `ts`, `tg_user_id`, `chat_id`, `message_id`, `update_id`, `event_type`, `name`, `callback_data`, `text_len`, `has_file`, `payload`, `user_id`) VALUES (1,'2026-10-06 11:58:43.000',NULL,NULL,NULL,NULL,'menu','click',NULL,NULL,NULL,NULL,2),(2,'2026-10-05 10:58:43.000',NULL,NULL,NULL,NULL,'order','view',NULL,NULL,NULL,NULL,3),(3,'2026-10-04 09:58:43.000',NULL,NULL,NULL,NULL,'support','submit',NULL,NULL,NULL,NULL,4),(4,'2026-10-03 08:58:43.000',NULL,NULL,NULL,NULL,'start','open',NULL,NULL,NULL,NULL,5),(5,'2026-10-02 07:58:43.000',NULL,NULL,NULL,NULL,'menu','click',NULL,NULL,NULL,NULL,6),(6,'2026-10-01 06:58:43.000',NULL,NULL,NULL,NULL,'order','view',NULL,NULL,NULL,NULL,7),(7,'2026-09-30 05:58:43.000',NULL,NULL,NULL,NULL,'support','submit',NULL,NULL,NULL,NULL,8),(8,'2026-09-29 04:58:43.000',NULL,NULL,NULL,NULL,'start','open',NULL,NULL,NULL,NULL,9),(9,'2026-09-28 03:58:43.000',NULL,NULL,NULL,NULL,'menu','click',NULL,NULL,NULL,NULL,10),(10,'2026-09-27 02:58:43.000',NULL,NULL,NULL,NULL,'order','view',NULL,NULL,NULL,NULL,11),(11,'2026-09-26 01:58:43.000',NULL,NULL,NULL,NULL,'support','submit',NULL,NULL,NULL,NULL,12),(12,'2026-09-25 12:58:43.000',NULL,NULL,NULL,NULL,'start','open',NULL,NULL,NULL,NULL,13),(13,'2026-09-24 11:58:43.000',NULL,NULL,NULL,NULL,'menu','click',NULL,NULL,NULL,NULL,14),(14,'2026-09-23 10:58:43.000',NULL,NULL,NULL,NULL,'order','view',NULL,NULL,NULL,NULL,15),(15,'2026-09-22 09:58:43.000',NULL,NULL,NULL,NULL,'support','submit',NULL,NULL,NULL,NULL,16),(16,'2026-09-21 08:58:43.000',NULL,NULL,NULL,NULL,'start','open',NULL,NULL,NULL,NULL,17),(17,'2026-09-20 07:58:43.000',NULL,NULL,NULL,NULL,'menu','click',NULL,NULL,NULL,NULL,18),(18,'2026-09-19 06:58:43.000',NULL,NULL,NULL,NULL,'order','view',NULL,NULL,NULL,NULL,19),(19,'2026-09-18 05:58:43.000',NULL,NULL,NULL,NULL,'support','submit',NULL,NULL,NULL,NULL,20),(20,'2026-09-17 04:58:43.000',NULL,NULL,NULL,NULL,'start','open',NULL,NULL,NULL,NULL,21),(21,'2026-09-16 03:58:43.000',NULL,NULL,NULL,NULL,'menu','click',NULL,NULL,NULL,NULL,22),(22,'2026-09-15 02:58:43.000',NULL,NULL,NULL,NULL,'order','view',NULL,NULL,NULL,NULL,23),(23,'2026-09-14 01:58:43.000',NULL,NULL,NULL,NULL,'support','submit',NULL,NULL,NULL,NULL,24),(24,'2026-09-13 12:58:43.000',NULL,NULL,NULL,NULL,'start','open',NULL,NULL,NULL,NULL,25),(25,'2026-09-12 11:58:43.000',NULL,NULL,NULL,NULL,'menu','click',NULL,NULL,NULL,NULL,26),(26,'2026-09-11 10:58:43.000',NULL,NULL,NULL,NULL,'order','view',NULL,NULL,NULL,NULL,27),(27,'2026-09-10 09:58:43.000',NULL,NULL,NULL,NULL,'support','submit',NULL,NULL,NULL,NULL,28),(28,'2026-09-09 08:58:43.000',NULL,NULL,NULL,NULL,'start','open',NULL,NULL,NULL,NULL,29),(29,'2026-09-08 07:58:43.000',NULL,NULL,NULL,NULL,'menu','click',NULL,NULL,NULL,NULL,30),(30,'2026-10-07 06:58:43.000',NULL,NULL,NULL,NULL,'order','view',NULL,NULL,NULL,NULL,31),(31,'2026-10-06 05:58:43.000',NULL,NULL,NULL,NULL,'support','submit',NULL,NULL,NULL,NULL,32),(32,'2026-10-05 04:58:43.000',NULL,NULL,NULL,NULL,'start','open',NULL,NULL,NULL,NULL,33),(33,'2026-10-04 03:58:43.000',NULL,NULL,NULL,NULL,'menu','click',NULL,NULL,NULL,NULL,34),(34,'2026-10-03 02:58:43.000',NULL,NULL,NULL,NULL,'order','view',NULL,NULL,NULL,NULL,35),(35,'2026-10-02 01:58:43.000',NULL,NULL,NULL,NULL,'support','submit',NULL,NULL,NULL,NULL,36),(36,'2026-10-01 12:58:43.000',NULL,NULL,NULL,NULL,'start','open',NULL,NULL,NULL,NULL,1),(37,'2026-09-30 11:58:43.000',NULL,NULL,NULL,NULL,'menu','click',NULL,NULL,NULL,NULL,2),(38,'2026-09-29 10:58:43.000',NULL,NULL,NULL,NULL,'order','view',NULL,NULL,NULL,NULL,3),(39,'2026-09-28 09:58:43.000',NULL,NULL,NULL,NULL,'support','submit',NULL,NULL,NULL,NULL,4),(40,'2026-09-27 08:58:43.000',NULL,NULL,NULL,NULL,'start','open',NULL,NULL,NULL,NULL,5),(41,'2026-09-26 07:58:43.000',NULL,NULL,NULL,NULL,'menu','click',NULL,NULL,NULL,NULL,6),(42,'2026-09-25 06:58:43.000',NULL,NULL,NULL,NULL,'order','view',NULL,NULL,NULL,NULL,7),(43,'2026-09-24 05:58:43.000',NULL,NULL,NULL,NULL,'support','submit',NULL,NULL,NULL,NULL,8),(44,'2026-09-23 04:58:43.000',NULL,NULL,NULL,NULL,'start','open',NULL,NULL,NULL,NULL,9),(45,'2026-09-22 03:58:43.000',NULL,NULL,NULL,NULL,'menu','click',NULL,NULL,NULL,NULL,10),(46,'2026-09-21 02:58:43.000',NULL,NULL,NULL,NULL,'order','view',NULL,NULL,NULL,NULL,11),(47,'2026-09-20 01:58:43.000',NULL,NULL,NULL,NULL,'support','submit',NULL,NULL,NULL,NULL,12),(48,'2026-09-19 12:58:43.000',NULL,NULL,NULL,NULL,'start','open',NULL,NULL,NULL,NULL,13),(49,'2026-09-18 11:58:43.000',NULL,NULL,NULL,NULL,'menu','click',NULL,NULL,NULL,NULL,14),(50,'2026-09-17 10:58:43.000',NULL,NULL,NULL,NULL,'order','view',NULL,NULL,NULL,NULL,15),(51,'2026-09-16 09:58:43.000',NULL,NULL,NULL,NULL,'support','submit',NULL,NULL,NULL,NULL,16),(52,'2026-09-15 08:58:43.000',NULL,NULL,NULL,NULL,'start','open',NULL,NULL,NULL,NULL,17),(53,'2026-09-14 07:58:43.000',NULL,NULL,NULL,NULL,'menu','click',NULL,NULL,NULL,NULL,18),(54,'2026-09-13 06:58:43.000',NULL,NULL,NULL,NULL,'order','view',NULL,NULL,NULL,NULL,19),(55,'2026-09-12 05:58:43.000',NULL,NULL,NULL,NULL,'support','submit',NULL,NULL,NULL,NULL,20),(56,'2026-09-11 04:58:43.000',NULL,NULL,NULL,NULL,'start','open',NULL,NULL,NULL,NULL,21),(57,'2026-09-10 03:58:43.000',NULL,NULL,NULL,NULL,'menu','click',NULL,NULL,NULL,NULL,22),(58,'2026-09-09 02:58:43.000',NULL,NULL,NULL,NULL,'order','view',NULL,NULL,NULL,NULL,23),(59,'2026-09-08 01:58:43.000',NULL,NULL,NULL,NULL,'support','submit',NULL,NULL,NULL,NULL,24),(60,'2026-10-07 12:58:43.000',NULL,NULL,NULL,NULL,'start','open',NULL,NULL,NULL,NULL,25),(61,'2026-10-06 11:58:43.000',NULL,NULL,NULL,NULL,'menu','click',NULL,NULL,NULL,NULL,26),(62,'2026-10-05 10:58:43.000',NULL,NULL,NULL,NULL,'order','view',NULL,NULL,NULL,NULL,27),(63,'2026-10-04 09:58:43.000',NULL,NULL,NULL,NULL,'support','submit',NULL,NULL,NULL,NULL,28),(64,'2026-10-03 08:58:43.000',NULL,NULL,NULL,NULL,'start','open',NULL,NULL,NULL,NULL,29),(65,'2026-10-02 07:58:43.000',NULL,NULL,NULL,NULL,'menu','click',NULL,NULL,NULL,NULL,30),(66,'2026-10-01 06:58:43.000',NULL,NULL,NULL,NULL,'order','view',NULL,NULL,NULL,NULL,31),(67,'2026-09-30 05:58:43.000',NULL,NULL,NULL,NULL,'support','submit',NULL,NULL,NULL,NULL,32),(68,'2026-09-29 04:58:43.000',NULL,NULL,NULL,NULL,'start','open',NULL,NULL,NULL,NULL,33),(69,'2026-09-28 03:58:43.000',NULL,NULL,NULL,NULL,'menu','click',NULL,NULL,NULL,NULL,34),(70,'2026-09-27 02:58:43.000',NULL,NULL,NULL,NULL,'order','view',NULL,NULL,NULL,NULL,35),(71,'2026-09-26 01:58:43.000',NULL,NULL,NULL,NULL,'support','submit',NULL,NULL,NULL,NULL,36),(72,'2026-09-25 12:58:43.000',NULL,NULL,NULL,NULL,'start','open',NULL,NULL,NULL,NULL,1),(73,'2026-09-24 11:58:43.000',NULL,NULL,NULL,NULL,'menu','click',NULL,NULL,NULL,NULL,2),(74,'2026-09-23 10:58:43.000',NULL,NULL,NULL,NULL,'order','view',NULL,NULL,NULL,NULL,3),(75,'2026-09-22 09:58:43.000',NULL,NULL,NULL,NULL,'support','submit',NULL,NULL,NULL,NULL,4),(76,'2026-09-21 08:58:43.000',NULL,NULL,NULL,NULL,'start','open',NULL,NULL,NULL,NULL,5),(77,'2026-09-20 07:58:43.000',NULL,NULL,NULL,NULL,'menu','click',NULL,NULL,NULL,NULL,6),(78,'2026-09-19 06:58:43.000',NULL,NULL,NULL,NULL,'order','view',NULL,NULL,NULL,NULL,7),(79,'2026-09-18 05:58:43.000',NULL,NULL,NULL,NULL,'support','submit',NULL,NULL,NULL,NULL,8),(80,'2026-09-17 04:58:43.000',NULL,NULL,NULL,NULL,'start','open',NULL,NULL,NULL,NULL,9),(81,'2026-09-16 03:58:43.000',NULL,NULL,NULL,NULL,'menu','click',NULL,NULL,NULL,NULL,10),(82,'2026-09-15 02:58:43.000',NULL,NULL,NULL,NULL,'order','view',NULL,NULL,NULL,NULL,11),(83,'2026-09-14 01:58:43.000',NULL,NULL,NULL,NULL,'support','submit',NULL,NULL,NULL,NULL,12),(84,'2026-09-13 12:58:43.000',NULL,NULL,NULL,NULL,'start','open',NULL,NULL,NULL,NULL,13),(85,'2026-09-12 11:58:43.000',NULL,NULL,NULL,NULL,'menu','click',NULL,NULL,NULL,NULL,14),(86,'2026-09-11 10:58:43.000',NULL,NULL,NULL,NULL,'order','view',NULL,NULL,NULL,NULL,15),(87,'2026-09-10 09:58:43.000',NULL,NULL,NULL,NULL,'support','submit',NULL,NULL,NULL,NULL,16),(88,'2026-09-09 08:58:43.000',NULL,NULL,NULL,NULL,'start','open',NULL,NULL,NULL,NULL,17),(89,'2026-09-08 07:58:43.000',NULL,NULL,NULL,NULL,'menu','click',NULL,NULL,NULL,NULL,18),(90,'2026-10-07 06:58:43.000',NULL,NULL,NULL,NULL,'order','view',NULL,NULL,NULL,NULL,19),(91,'2026-10-06 05:58:43.000',NULL,NULL,NULL,NULL,'support','submit',NULL,NULL,NULL,NULL,20),(92,'2026-10-05 04:58:43.000',NULL,NULL,NULL,NULL,'start','open',NULL,NULL,NULL,NULL,21),(93,'2026-10-04 03:58:43.000',NULL,NULL,NULL,NULL,'menu','click',NULL,NULL,NULL,NULL,22),(94,'2026-10-03 02:58:43.000',NULL,NULL,NULL,NULL,'order','view',NULL,NULL,NULL,NULL,23),(95,'2026-10-02 01:58:43.000',NULL,NULL,NULL,NULL,'support','submit',NULL,NULL,NULL,NULL,24),(96,'2026-10-01 12:58:43.000',NULL,NULL,NULL,NULL,'start','open',NULL,NULL,NULL,NULL,25),(97,'2026-09-30 11:58:43.000',NULL,NULL,NULL,NULL,'menu','click',NULL,NULL,NULL,NULL,26),(98,'2026-09-29 10:58:43.000',NULL,NULL,NULL,NULL,'order','view',NULL,NULL,NULL,NULL,27),(99,'2026-09-28 09:58:43.000',NULL,NULL,NULL,NULL,'support','submit',NULL,NULL,NULL,NULL,28),(100,'2026-09-27 08:58:43.000',NULL,NULL,NULL,NULL,'start','open',NULL,NULL,NULL,NULL,29),(101,'2026-09-26 07:58:43.000',NULL,NULL,NULL,NULL,'menu','click',NULL,NULL,NULL,NULL,30),(102,'2026-09-25 06:58:43.000',NULL,NULL,NULL,NULL,'order','view',NULL,NULL,NULL,NULL,31),(103,'2026-09-24 05:58:43.000',NULL,NULL,NULL,NULL,'support','submit',NULL,NULL,NULL,NULL,32),(104,'2026-09-23 04:58:43.000',NULL,NULL,NULL,NULL,'start','open',NULL,NULL,NULL,NULL,33),(105,'2026-09-22 03:58:43.000',NULL,NULL,NULL,NULL,'menu','click',NULL,NULL,NULL,NULL,34),(106,'2026-09-21 02:58:43.000',NULL,NULL,NULL,NULL,'order','view',NULL,NULL,NULL,NULL,35),(107,'2026-09-20 01:58:43.000',NULL,NULL,NULL,NULL,'support','submit',NULL,NULL,NULL,NULL,36),(108,'2026-09-19 12:58:43.000',NULL,NULL,NULL,NULL,'start','open',NULL,NULL,NULL,NULL,1),(109,'2026-09-18 11:58:43.000',NULL,NULL,NULL,NULL,'menu','click',NULL,NULL,NULL,NULL,2),(110,'2026-09-17 10:58:43.000',NULL,NULL,NULL,NULL,'order','view',NULL,NULL,NULL,NULL,3);
/*!40000 ALTER TABLE `bot_events` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `bot_events_weekly`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bot_events_weekly` (
  `week_start` date NOT NULL,
  `event_type` varchar(32) NOT NULL,
  `name` varchar(128) NOT NULL DEFAULT '',
  `cnt_total` bigint NOT NULL,
  `cnt_with_file` bigint NOT NULL,
  `avg_text_len` double DEFAULT NULL,
  `uniq_users` bigint NOT NULL,
  `first_ts` timestamp(3) NULL DEFAULT NULL,
  `last_ts` timestamp(3) NULL DEFAULT NULL,
  PRIMARY KEY (`week_start`,`event_type`,`name`),
  KEY `idx_week` (`week_start`),
  KEY `idx_type` (`event_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `bot_events_weekly` WRITE;
/*!40000 ALTER TABLE `bot_events_weekly` DISABLE KEYS */;
/*!40000 ALTER TABLE `bot_events_weekly` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `calendar_event_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `calendar_event_categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `code` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `color` varchar(20) NOT NULL DEFAULT '#667eea',
  `icon` varchar(10) DEFAULT '',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `calendar_event_categories` WRITE;
/*!40000 ALTER TABLE `calendar_event_categories` DISABLE KEYS */;
INSERT INTO `calendar_event_categories` (`id`, `code`, `name`, `color`, `icon`, `created_at`) VALUES (1,'meeting','Встреча','#667eea','','2026-10-07 09:58:51'),(2,'service','Сервис','#10b981','','2026-10-07 09:58:51'),(3,'deadline','Срок','#f59e0b','','2026-10-07 09:58:51');
/*!40000 ALTER TABLE `calendar_event_categories` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `calendar_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `calendar_events` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `event_date` date NOT NULL,
  `event_time` time DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `description` text,
  `category_id` int DEFAULT NULL,
  `client_id` int DEFAULT NULL,
  `created_by` bigint NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_event_date` (`event_date`),
  KEY `idx_category` (`category_id`),
  KEY `idx_client` (`client_id`),
  KEY `idx_created_by` (`created_by`),
  CONSTRAINT `fk_event_category` FOREIGN KEY (`category_id`) REFERENCES `calendar_event_categories` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_event_client` FOREIGN KEY (`client_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_event_created_by` FOREIGN KEY (`created_by`) REFERENCES `specialists` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `calendar_events` WRITE;
/*!40000 ALTER TABLE `calendar_events` DISABLE KEYS */;
INSERT INTO `calendar_events` (`id`, `event_date`, `event_time`, `title`, `description`, `category_id`, `client_id`, `created_by`, `created_at`, `updated_at`) VALUES (1,'2026-09-30','11:00:00','Обслуживание — DEMO 1','Вымышленное событие календаря',2,1,1,'2026-10-07 09:58:51','2026-10-07 09:58:51'),(2,'2026-10-01','12:00:00','Продление — DEMO 2','Вымышленное событие календаря',3,2,1,'2026-10-07 09:58:51','2026-10-07 09:58:51'),(3,'2026-10-02','13:00:00','Встреча — DEMO 3','Вымышленное событие календаря',1,3,1,'2026-10-07 09:58:51','2026-10-07 09:58:51'),(4,'2026-10-03','14:00:00','Обслуживание — DEMO 4','Вымышленное событие календаря',2,4,1,'2026-10-07 09:58:51','2026-10-07 09:58:51'),(5,'2026-10-04','15:00:00','Продление — DEMO 5','Вымышленное событие календаря',3,5,1,'2026-10-07 09:58:51','2026-10-07 09:58:51'),(6,'2026-10-05','16:00:00','Встреча — DEMO 6','Вымышленное событие календаря',1,6,1,'2026-10-07 09:58:51','2026-10-07 09:58:51'),(7,'2026-10-06','10:00:00','Обслуживание — DEMO 7','Вымышленное событие календаря',2,7,1,'2026-10-07 09:58:51','2026-10-07 09:58:51'),(8,'2026-10-07','11:00:00','Продление — DEMO 8','Вымышленное событие календаря',3,8,1,'2026-10-07 09:58:51','2026-10-07 09:58:51'),(9,'2026-10-08','12:00:00','Встреча — DEMO 9','Вымышленное событие календаря',1,9,1,'2026-10-07 09:58:52','2026-10-07 09:58:52'),(10,'2026-10-09','13:00:00','Обслуживание — DEMO 10','Вымышленное событие календаря',2,10,1,'2026-10-07 09:58:52','2026-10-07 09:58:52'),(11,'2026-10-10','14:00:00','Продление — DEMO 11','Вымышленное событие календаря',3,11,1,'2026-10-07 09:58:52','2026-10-07 09:58:52'),(12,'2026-10-11','15:00:00','Встреча — DEMO 12','Вымышленное событие календаря',1,12,1,'2026-10-07 09:58:52','2026-10-07 09:58:52'),(13,'2026-10-12','16:00:00','Обслуживание — DEMO 13','Вымышленное событие календаря',2,13,1,'2026-10-07 09:58:52','2026-10-07 09:58:52'),(14,'2026-10-13','10:00:00','Продление — DEMO 14','Вымышленное событие календаря',3,14,1,'2026-10-07 09:58:52','2026-10-07 09:58:52'),(15,'2026-10-14','11:00:00','Встреча — DEMO 15','Вымышленное событие календаря',1,15,1,'2026-10-07 09:58:52','2026-10-07 09:58:52');
/*!40000 ALTER TABLE `calendar_events` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `call_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `call_logs` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `call_session_id` bigint NOT NULL,
  `event_type` varchar(50) NOT NULL,
  `event_payload` json DEFAULT NULL,
  `event_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `raw_callerid` varchar(50) DEFAULT NULL,
  `trunk_name` varchar(100) DEFAULT NULL,
  `asterisk_channel` varchar(255) DEFAULT NULL,
  `hangup_cause` varchar(100) DEFAULT NULL,
  `duration_sec` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_call_logs_session_time` (`call_session_id`,`event_time`),
  KEY `idx_call_logs_event_type` (`event_type`),
  KEY `idx_call_logs_event_time` (`event_time`),
  CONSTRAINT `fk_call_logs_session` FOREIGN KEY (`call_session_id`) REFERENCES `call_sessions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `call_logs` WRITE;
/*!40000 ALTER TABLE `call_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `call_logs` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `call_sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `call_sessions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `initiator_type` enum('user','specialist','system') NOT NULL,
  `initiator_abonent_id` bigint NOT NULL,
  `caller_abonent_id` bigint NOT NULL,
  `callee_abonent_id` bigint NOT NULL,
  `direction` enum('user_to_specialist','specialist_to_user') NOT NULL,
  `channel` enum('pstn') NOT NULL DEFAULT 'pstn',
  `status` enum('created','validated','dialing_first_leg','first_leg_answered','dialing_second_leg','bridged','completed','failed','cancelled','expired') NOT NULL DEFAULT 'created',
  `asterisk_linkedid` varchar(64) DEFAULT NULL,
  `asterisk_first_channel` varchar(255) DEFAULT NULL,
  `asterisk_second_channel` varchar(255) DEFAULT NULL,
  `started_at` datetime DEFAULT NULL,
  `bridged_at` datetime DEFAULT NULL,
  `ended_at` datetime DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL,
  `failure_reason` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_call_sessions_status` (`status`),
  KEY `idx_call_sessions_created_at` (`created_at`),
  KEY `idx_call_sessions_direction_status` (`direction`,`status`),
  KEY `idx_call_sessions_initiator` (`initiator_abonent_id`,`created_at`),
  KEY `idx_call_sessions_pair` (`caller_abonent_id`,`callee_abonent_id`,`created_at`),
  KEY `idx_call_sessions_linkedid` (`asterisk_linkedid`),
  KEY `fk_call_sessions_callee_abonent` (`callee_abonent_id`),
  CONSTRAINT `fk_call_sessions_callee_abonent` FOREIGN KEY (`callee_abonent_id`) REFERENCES `abonents` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_call_sessions_caller_abonent` FOREIGN KEY (`caller_abonent_id`) REFERENCES `abonents` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_call_sessions_initiator_abonent` FOREIGN KEY (`initiator_abonent_id`) REFERENCES `abonents` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `call_sessions` WRITE;
/*!40000 ALTER TABLE `call_sessions` DISABLE KEYS */;
/*!40000 ALTER TABLE `call_sessions` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `client_fn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `client_fn` (
  `id` int NOT NULL AUTO_INCREMENT,
  `kkt_id` int NOT NULL,
  `fn_expires_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_client_fn_kkt_id` (`kkt_id`),
  CONSTRAINT `fk_client_fn_kkt` FOREIGN KEY (`kkt_id`) REFERENCES `client_kkt` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `client_fn` WRITE;
/*!40000 ALTER TABLE `client_fn` DISABLE KEYS */;
INSERT INTO `client_fn` (`id`, `kkt_id`, `fn_expires_at`, `created_at`, `updated_at`) VALUES (1,1,'2026-10-02 00:00:00',NULL,NULL),(2,2,'2026-10-14 00:00:00',NULL,NULL),(3,3,'2026-10-30 00:00:00',NULL,NULL),(4,4,'2027-01-28 00:00:00',NULL,NULL),(5,5,'2027-02-14 00:00:00',NULL,NULL),(6,6,'2027-03-03 00:00:00',NULL,NULL),(7,7,'2027-03-20 00:00:00',NULL,NULL),(8,8,'2027-04-06 00:00:00',NULL,NULL),(9,9,'2027-04-23 00:00:00',NULL,NULL),(10,10,'2027-05-10 00:00:00',NULL,NULL),(11,11,'2026-11-28 00:00:00',NULL,NULL),(12,12,'2026-12-15 00:00:00',NULL,NULL),(13,13,'2027-01-01 00:00:00',NULL,NULL),(14,14,'2027-01-18 00:00:00',NULL,NULL),(15,15,'2027-02-04 00:00:00',NULL,NULL),(16,16,'2027-02-21 00:00:00',NULL,NULL),(17,17,'2027-03-10 00:00:00',NULL,NULL),(18,18,'2027-03-27 00:00:00',NULL,NULL),(19,19,'2027-04-13 00:00:00',NULL,NULL),(20,20,'2027-04-30 00:00:00',NULL,NULL),(21,21,'2027-05-17 00:00:00',NULL,NULL),(22,22,'2026-12-05 00:00:00',NULL,NULL),(23,23,'2026-12-22 00:00:00',NULL,NULL),(24,24,'2027-01-08 00:00:00',NULL,NULL),(25,25,'2027-01-25 00:00:00',NULL,NULL),(26,26,'2027-02-11 00:00:00',NULL,NULL),(27,27,'2027-02-28 00:00:00',NULL,NULL),(28,28,'2027-03-17 00:00:00',NULL,NULL);
/*!40000 ALTER TABLE `client_fn` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `client_kkt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `client_kkt` (
  `id` int NOT NULL AUTO_INCREMENT,
  `client_id` int DEFAULT NULL,
  `company_id` int DEFAULT NULL,
  `kkt_slot` varchar(50) NOT NULL,
  `address` text,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL COMMENT 'Название торговой точки',
  `phone` varchar(50) DEFAULT NULL COMMENT 'Телефон торговой точки',
  `landmark` text COMMENT 'Ориентир / комментарий',
  `kkt_registered_at` date DEFAULT NULL COMMENT 'Дата регистрации ККТ',
  `kkt_model` varchar(100) DEFAULT NULL COMMENT 'Модель ККТ',
  `kkt_serial_number` varchar(50) DEFAULT NULL COMMENT 'ЗН ККТ',
  `kkt_reg_number` varchar(50) DEFAULT NULL COMMENT 'РН ККТ',
  `kkt_firmware` varchar(100) DEFAULT NULL COMMENT 'Прошивка ККТ',
  `fn_serial_number` varchar(50) DEFAULT NULL COMMENT 'ЗН ФН',
  `fn_type` varchar(50) DEFAULT NULL COMMENT 'Тип ФН (ФН-15, ФН-36)',
  `fn_manufacturer` varchar(100) DEFAULT NULL COMMENT 'Производитель ФН',
  `ofd_inn` varchar(20) DEFAULT NULL COMMENT 'ИНН ОФД',
  `ofd_name` varchar(100) DEFAULT NULL COMMENT 'Название ОФД',
  `trade_system` varchar(100) DEFAULT NULL COMMENT 'Система торговли (Сбис, 1С)',
  `sno` varchar(50) DEFAULT NULL COMMENT 'Система налогообложения',
  `marking_enabled` tinyint(1) DEFAULT '0' COMMENT 'Маркировка включена',
  `marking_type` varchar(100) DEFAULT NULL COMMENT 'Вид маркировки',
  `scanner_model` varchar(100) DEFAULT NULL COMMENT 'Модель сканера',
  `imei` varchar(50) DEFAULT NULL COMMENT 'IMEI устройства',
  `sim_number` varchar(50) DEFAULT NULL COMMENT 'Номер СИМ карты',
  `fn_expires_at` date DEFAULT NULL COMMENT 'Срок действия ФН',
  `ofd_expires_at` date DEFAULT NULL COMMENT 'Срок действия ОФД',
  `mark_expires_at` date DEFAULT NULL COMMENT 'Срок маркировки',
  `chz_registered` tinyint(1) DEFAULT '0' COMMENT 'Зарегистрирован в ЧЗ',
  `chz_token` varchar(255) DEFAULT NULL COMMENT 'Токен Честный Знак',
  `chz_has_ep` tinyint(1) DEFAULT '0' COMMENT 'Есть ЭП для ЧЗ',
  `chz_product_type` varchar(100) DEFAULT NULL COMMENT 'Тип продукции ЧЗ',
  `chz_fias_id` varchar(100) DEFAULT NULL COMMENT 'ФИАС ID для ЧЗ',
  `tspiot_installed_at` datetime DEFAULT NULL COMMENT 'Дата установки ТСПИоТ',
  `tspiot_tariff_expires_at` date DEFAULT NULL COMMENT 'Срок тарифа ТСПИоТ',
  `tspiot_vendor` varchar(100) DEFAULT NULL COMMENT 'Поставщик ТСПИоТ',
  `ecp_enabled` tinyint(1) DEFAULT '0' COMMENT 'ЭЦП включена',
  `ecp_type` varchar(100) DEFAULT NULL COMMENT 'Тип ЭЦП',
  `ecp_expires_at` date DEFAULT NULL COMMENT 'Срок ЭЦП',
  `ecp_comment` text COMMENT 'Комментарий к ЭЦП',
  `to_kkt_yurt` varchar(100) DEFAULT NULL COMMENT 'Привязка к ККТ Юрта',
  `has_sim` tinyint(1) DEFAULT '0' COMMENT 'Есть SIM',
  `sim_payment_at` datetime DEFAULT NULL COMMENT 'Дата оплаты SIM',
  `ofd_expires_field` varchar(100) DEFAULT NULL COMMENT 'Поле срока ОФД (доп.)',
  `evotor_utm` varchar(255) DEFAULT NULL COMMENT 'Эвотор UTM',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_client_kkt_client_slot` (`client_id`,`kkt_slot`),
  KEY `idx_client_kkt_client_id` (`client_id`),
  KEY `idx_kkt_serial` (`kkt_serial_number`),
  KEY `idx_kkt_reg_number` (`kkt_reg_number`),
  KEY `idx_fn_serial` (`fn_serial_number`),
  CONSTRAINT `fk_client_kkt_user` FOREIGN KEY (`client_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `client_kkt` WRITE;
/*!40000 ALTER TABLE `client_kkt` DISABLE KEYS */;
INSERT INTO `client_kkt` (`id`, `client_id`, `company_id`, `kkt_slot`, `address`, `created_at`, `updated_at`, `name`, `phone`, `landmark`, `kkt_registered_at`, `kkt_model`, `kkt_serial_number`, `kkt_reg_number`, `kkt_firmware`, `fn_serial_number`, `fn_type`, `fn_manufacturer`, `ofd_inn`, `ofd_name`, `trade_system`, `sno`, `marking_enabled`, `marking_type`, `scanner_model`, `imei`, `sim_number`, `fn_expires_at`, `ofd_expires_at`, `mark_expires_at`, `chz_registered`, `chz_token`, `chz_has_ep`, `chz_product_type`, `chz_fias_id`, `tspiot_installed_at`, `tspiot_tariff_expires_at`, `tspiot_vendor`, `ecp_enabled`, `ecp_type`, `ecp_expires_at`, `ecp_comment`, `to_kkt_yurt`, `has_sim`, `sim_payment_at`, `ofd_expires_field`, `evotor_utm`) VALUES (1,1,NULL,'DEMO-KKT-001','Казань, Демо проспект, 1','2026-10-03 12:58:43',NULL,'Торговая точка 1',NULL,NULL,NULL,'Атол 30Ф','DEMO-SN-00001',NULL,NULL,'DEMO-FN-00001',NULL,NULL,NULL,'Учебный ОФД',NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-10-02','2026-11-26','2027-01-20',0,NULL,0,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL),(2,2,NULL,'DEMO-KKT-002','Тверь, Демо проспект, 2','2026-09-29 12:58:43',NULL,'Торговая точка 2',NULL,NULL,NULL,'Эвотор 7.3','DEMO-SN-00002',NULL,NULL,'DEMO-FN-00002',NULL,NULL,NULL,'Учебный ОФД',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-10-14','2026-12-08','2027-02-01',0,NULL,0,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL),(3,3,NULL,'DEMO-KKT-003','Самара, Демо проспект, 3','2026-09-25 12:58:43',NULL,'Торговая точка 3',NULL,NULL,NULL,'Атол 30Ф','DEMO-SN-00003',NULL,NULL,'DEMO-FN-00003',NULL,NULL,NULL,'Учебный ОФД',NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-10-30','2026-12-24','2027-02-17',0,NULL,0,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL),(4,4,NULL,'DEMO-KKT-004','Пермь, Демо проспект, 4','2026-09-21 12:58:43',NULL,'Торговая точка 4',NULL,NULL,NULL,'Эвотор 7.3','DEMO-SN-00004',NULL,NULL,'DEMO-FN-00004',NULL,NULL,NULL,'Учебный ОФД',NULL,NULL,0,NULL,NULL,NULL,NULL,'2027-01-28','2027-03-24','2027-05-18',0,NULL,0,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL),(5,5,NULL,'DEMO-KKT-005','Тула, Демо проспект, 5','2026-09-17 12:58:43',NULL,'Торговая точка 5',NULL,NULL,NULL,'Атол 30Ф','DEMO-SN-00005',NULL,NULL,'DEMO-FN-00005',NULL,NULL,NULL,'Учебный ОФД',NULL,NULL,1,NULL,NULL,NULL,NULL,'2027-02-14','2027-04-10','2027-06-04',0,NULL,0,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL),(6,6,NULL,'DEMO-KKT-006','Калуга, Демо проспект, 6','2026-09-13 12:58:43',NULL,'Торговая точка 6',NULL,NULL,NULL,'Эвотор 7.3','DEMO-SN-00006',NULL,NULL,'DEMO-FN-00006',NULL,NULL,NULL,'Учебный ОФД',NULL,NULL,0,NULL,NULL,NULL,NULL,'2027-03-03','2027-04-27','2027-06-21',0,NULL,0,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL),(7,7,NULL,'DEMO-KKT-007','Воронеж, Демо проспект, 7','2026-09-09 12:58:43',NULL,'Торговая точка 7',NULL,NULL,NULL,'Атол 30Ф','DEMO-SN-00007',NULL,NULL,'DEMO-FN-00007',NULL,NULL,NULL,'Учебный ОФД',NULL,NULL,1,NULL,NULL,NULL,NULL,'2027-03-20','2027-05-14','2027-07-08',0,NULL,0,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL),(8,8,NULL,'DEMO-KKT-008','Москва, Демо проспект, 8','2026-09-05 12:58:43',NULL,'Торговая точка 8',NULL,NULL,NULL,'Эвотор 7.3','DEMO-SN-00008',NULL,NULL,'DEMO-FN-00008',NULL,NULL,NULL,'Учебный ОФД',NULL,NULL,0,NULL,NULL,NULL,NULL,'2027-04-06','2027-05-31','2027-07-25',0,NULL,0,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL),(9,9,NULL,'DEMO-KKT-009','Казань, Демо проспект, 9','2026-09-01 12:58:43',NULL,'Торговая точка 9',NULL,NULL,NULL,'Атол 30Ф','DEMO-SN-00009',NULL,NULL,'DEMO-FN-00009',NULL,NULL,NULL,'Учебный ОФД',NULL,NULL,1,NULL,NULL,NULL,NULL,'2027-04-23','2027-06-17','2027-08-11',0,NULL,0,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL),(10,10,NULL,'DEMO-KKT-010','Тверь, Демо проспект, 10','2026-08-28 12:58:43',NULL,'Торговая точка 10',NULL,NULL,NULL,'Эвотор 7.3','DEMO-SN-00010',NULL,NULL,'DEMO-FN-00010',NULL,NULL,NULL,'Учебный ОФД',NULL,NULL,0,NULL,NULL,NULL,NULL,'2027-05-10','2027-07-04','2027-08-28',0,NULL,0,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL),(11,11,NULL,'DEMO-KKT-011','Самара, Демо проспект, 11','2026-08-24 12:58:43',NULL,'Торговая точка 11',NULL,NULL,NULL,'Атол 30Ф','DEMO-SN-00011',NULL,NULL,'DEMO-FN-00011',NULL,NULL,NULL,'Учебный ОФД',NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-11-28','2027-01-22','2027-03-18',0,NULL,0,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL),(12,12,NULL,'DEMO-KKT-012','Пермь, Демо проспект, 12','2026-08-20 12:58:43',NULL,'Торговая точка 12',NULL,NULL,NULL,'Эвотор 7.3','DEMO-SN-00012',NULL,NULL,'DEMO-FN-00012',NULL,NULL,NULL,'Учебный ОФД',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-12-15','2027-02-08','2027-04-04',0,NULL,0,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL),(13,13,NULL,'DEMO-KKT-013','Тула, Демо проспект, 13','2026-08-16 12:58:43',NULL,'Торговая точка 13',NULL,NULL,NULL,'Атол 30Ф','DEMO-SN-00013',NULL,NULL,'DEMO-FN-00013',NULL,NULL,NULL,'Учебный ОФД',NULL,NULL,1,NULL,NULL,NULL,NULL,'2027-01-01','2027-02-25','2027-04-21',0,NULL,0,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL),(14,14,NULL,'DEMO-KKT-014','Калуга, Демо проспект, 14','2026-08-12 12:58:43',NULL,'Торговая точка 14',NULL,NULL,NULL,'Эвотор 7.3','DEMO-SN-00014',NULL,NULL,'DEMO-FN-00014',NULL,NULL,NULL,'Учебный ОФД',NULL,NULL,0,NULL,NULL,NULL,NULL,'2027-01-18','2027-03-14','2027-05-08',0,NULL,0,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL),(15,15,NULL,'DEMO-KKT-015','Воронеж, Демо проспект, 15','2026-08-08 12:58:43',NULL,'Торговая точка 15',NULL,NULL,NULL,'Атол 30Ф','DEMO-SN-00015',NULL,NULL,'DEMO-FN-00015',NULL,NULL,NULL,'Учебный ОФД',NULL,NULL,1,NULL,NULL,NULL,NULL,'2027-02-04','2027-03-31','2027-05-25',0,NULL,0,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL),(16,16,NULL,'DEMO-KKT-016','Москва, Демо проспект, 16','2026-08-04 12:58:43',NULL,'Торговая точка 16',NULL,NULL,NULL,'Эвотор 7.3','DEMO-SN-00016',NULL,NULL,'DEMO-FN-00016',NULL,NULL,NULL,'Учебный ОФД',NULL,NULL,0,NULL,NULL,NULL,NULL,'2027-02-21','2027-04-17','2027-06-11',0,NULL,0,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL),(17,17,NULL,'DEMO-KKT-017','Казань, Демо проспект, 17','2026-07-31 12:58:43',NULL,'Торговая точка 17',NULL,NULL,NULL,'Атол 30Ф','DEMO-SN-00017',NULL,NULL,'DEMO-FN-00017',NULL,NULL,NULL,'Учебный ОФД',NULL,NULL,1,NULL,NULL,NULL,NULL,'2027-03-10','2027-05-04','2027-06-28',0,NULL,0,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL),(18,18,NULL,'DEMO-KKT-018','Тверь, Демо проспект, 18','2026-07-27 12:58:43',NULL,'Торговая точка 18',NULL,NULL,NULL,'Эвотор 7.3','DEMO-SN-00018',NULL,NULL,'DEMO-FN-00018',NULL,NULL,NULL,'Учебный ОФД',NULL,NULL,0,NULL,NULL,NULL,NULL,'2027-03-27','2027-05-21','2027-07-15',0,NULL,0,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL),(19,19,NULL,'DEMO-KKT-019','Самара, Демо проспект, 19','2026-07-23 12:58:43',NULL,'Торговая точка 19',NULL,NULL,NULL,'Атол 30Ф','DEMO-SN-00019',NULL,NULL,'DEMO-FN-00019',NULL,NULL,NULL,'Учебный ОФД',NULL,NULL,1,NULL,NULL,NULL,NULL,'2027-04-13','2027-06-07','2027-08-01',0,NULL,0,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL),(20,20,NULL,'DEMO-KKT-020','Пермь, Демо проспект, 20','2026-07-19 12:58:43',NULL,'Торговая точка 20',NULL,NULL,NULL,'Эвотор 7.3','DEMO-SN-00020',NULL,NULL,'DEMO-FN-00020',NULL,NULL,NULL,'Учебный ОФД',NULL,NULL,0,NULL,NULL,NULL,NULL,'2027-04-30','2027-06-24','2027-08-18',0,NULL,0,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL),(21,NULL,1,'DEMO-KKT-021','Тула, Демо проспект, 21','2026-07-15 12:58:43',NULL,'Торговая точка 21',NULL,NULL,NULL,'Атол 30Ф','DEMO-SN-00021',NULL,NULL,'DEMO-FN-00021',NULL,NULL,NULL,'Учебный ОФД',NULL,NULL,1,NULL,NULL,NULL,NULL,'2027-05-17','2027-07-11','2027-09-04',0,NULL,0,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL),(22,NULL,2,'DEMO-KKT-022','Калуга, Демо проспект, 22','2026-07-11 12:58:43',NULL,'Торговая точка 22',NULL,NULL,NULL,'Эвотор 7.3','DEMO-SN-00022',NULL,NULL,'DEMO-FN-00022',NULL,NULL,NULL,'Учебный ОФД',NULL,NULL,0,NULL,NULL,NULL,NULL,'2026-12-05','2027-01-29','2027-03-25',0,NULL,0,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL),(23,NULL,3,'DEMO-KKT-023','Воронеж, Демо проспект, 23','2026-07-07 12:58:43',NULL,'Торговая точка 23',NULL,NULL,NULL,'Атол 30Ф','DEMO-SN-00023',NULL,NULL,'DEMO-FN-00023',NULL,NULL,NULL,'Учебный ОФД',NULL,NULL,1,NULL,NULL,NULL,NULL,'2026-12-22','2027-02-15','2027-04-11',0,NULL,0,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL),(24,NULL,4,'DEMO-KKT-024','Москва, Демо проспект, 24','2026-07-03 12:58:43',NULL,'Торговая точка 24',NULL,NULL,NULL,'Эвотор 7.3','DEMO-SN-00024',NULL,NULL,'DEMO-FN-00024',NULL,NULL,NULL,'Учебный ОФД',NULL,NULL,0,NULL,NULL,NULL,NULL,'2027-01-08','2027-03-04','2027-04-28',0,NULL,0,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL),(25,NULL,5,'DEMO-KKT-025','Казань, Демо проспект, 25','2026-06-29 12:58:43',NULL,'Торговая точка 25',NULL,NULL,NULL,'Атол 30Ф','DEMO-SN-00025',NULL,NULL,'DEMO-FN-00025',NULL,NULL,NULL,'Учебный ОФД',NULL,NULL,1,NULL,NULL,NULL,NULL,'2027-01-25','2027-03-21','2027-05-15',0,NULL,0,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL),(26,NULL,6,'DEMO-KKT-026','Тверь, Демо проспект, 26','2026-06-25 12:58:43',NULL,'Торговая точка 26',NULL,NULL,NULL,'Эвотор 7.3','DEMO-SN-00026',NULL,NULL,'DEMO-FN-00026',NULL,NULL,NULL,'Учебный ОФД',NULL,NULL,0,NULL,NULL,NULL,NULL,'2027-02-11','2027-04-07','2027-06-01',0,NULL,0,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL),(27,NULL,7,'DEMO-KKT-027','Самара, Демо проспект, 27','2026-06-21 12:58:43',NULL,'Торговая точка 27',NULL,NULL,NULL,'Атол 30Ф','DEMO-SN-00027',NULL,NULL,'DEMO-FN-00027',NULL,NULL,NULL,'Учебный ОФД',NULL,NULL,1,NULL,NULL,NULL,NULL,'2027-02-28','2027-04-24','2027-06-18',0,NULL,0,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL),(28,NULL,8,'DEMO-KKT-028','Пермь, Демо проспект, 28','2026-06-17 12:58:43',NULL,'Торговая точка 28',NULL,NULL,NULL,'Эвотор 7.3','DEMO-SN-00028',NULL,NULL,'DEMO-FN-00028',NULL,NULL,NULL,'Учебный ОФД',NULL,NULL,0,NULL,NULL,NULL,NULL,'2027-03-17','2027-05-11','2027-07-05',0,NULL,0,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL);
/*!40000 ALTER TABLE `client_kkt` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `client_mark`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `client_mark` (
  `id` int NOT NULL AUTO_INCREMENT,
  `kkt_id` int NOT NULL,
  `mark_expires_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_client_mark_kkt_id` (`kkt_id`),
  CONSTRAINT `fk_client_mark_kkt` FOREIGN KEY (`kkt_id`) REFERENCES `client_kkt` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `client_mark` WRITE;
/*!40000 ALTER TABLE `client_mark` DISABLE KEYS */;
INSERT INTO `client_mark` (`id`, `kkt_id`, `mark_expires_at`, `created_at`, `updated_at`) VALUES (1,1,'2027-01-20 00:00:00',NULL,NULL),(2,3,'2027-02-17 00:00:00',NULL,NULL),(3,5,'2027-06-04 00:00:00',NULL,NULL),(4,7,'2027-07-08 00:00:00',NULL,NULL),(5,9,'2027-08-11 00:00:00',NULL,NULL),(6,11,'2027-03-18 00:00:00',NULL,NULL),(7,13,'2027-04-21 00:00:00',NULL,NULL),(8,15,'2027-05-25 00:00:00',NULL,NULL),(9,17,'2027-06-28 00:00:00',NULL,NULL),(10,19,'2027-08-01 00:00:00',NULL,NULL),(11,21,'2027-09-04 00:00:00',NULL,NULL),(12,23,'2027-04-11 00:00:00',NULL,NULL),(13,25,'2027-05-15 00:00:00',NULL,NULL),(14,27,'2027-06-18 00:00:00',NULL,NULL);
/*!40000 ALTER TABLE `client_mark` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `client_notes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `client_notes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `client_id` int NOT NULL,
  `author_id` int NOT NULL,
  `author_name` varchar(255) NOT NULL,
  `note_type` enum('note','deal') NOT NULL DEFAULT 'note',
  `product` varchar(255) DEFAULT NULL,
  `amount` decimal(12,2) DEFAULT NULL,
  `description` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_client` (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `client_notes` WRITE;
/*!40000 ALTER TABLE `client_notes` DISABLE KEYS */;
/*!40000 ALTER TABLE `client_notes` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `client_ofd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `client_ofd` (
  `id` int NOT NULL AUTO_INCREMENT,
  `kkt_id` int NOT NULL,
  `ofd_expires_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_client_ofd_kkt_id` (`kkt_id`),
  CONSTRAINT `fk_client_ofd_kkt` FOREIGN KEY (`kkt_id`) REFERENCES `client_kkt` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `client_ofd` WRITE;
/*!40000 ALTER TABLE `client_ofd` DISABLE KEYS */;
INSERT INTO `client_ofd` (`id`, `kkt_id`, `ofd_expires_at`, `created_at`, `updated_at`) VALUES (1,1,'2026-11-26 00:00:00',NULL,NULL),(2,2,'2026-12-08 00:00:00',NULL,NULL),(3,3,'2026-12-24 00:00:00',NULL,NULL),(4,4,'2027-03-24 00:00:00',NULL,NULL),(5,5,'2027-04-10 00:00:00',NULL,NULL),(6,6,'2027-04-27 00:00:00',NULL,NULL),(7,7,'2027-05-14 00:00:00',NULL,NULL),(8,8,'2027-05-31 00:00:00',NULL,NULL),(9,9,'2027-06-17 00:00:00',NULL,NULL),(10,10,'2027-07-04 00:00:00',NULL,NULL),(11,11,'2027-01-22 00:00:00',NULL,NULL),(12,12,'2027-02-08 00:00:00',NULL,NULL),(13,13,'2027-02-25 00:00:00',NULL,NULL),(14,14,'2027-03-14 00:00:00',NULL,NULL),(15,15,'2027-03-31 00:00:00',NULL,NULL),(16,16,'2027-04-17 00:00:00',NULL,NULL),(17,17,'2027-05-04 00:00:00',NULL,NULL),(18,18,'2027-05-21 00:00:00',NULL,NULL),(19,19,'2027-06-07 00:00:00',NULL,NULL),(20,20,'2027-06-24 00:00:00',NULL,NULL),(21,21,'2027-07-11 00:00:00',NULL,NULL),(22,22,'2027-01-29 00:00:00',NULL,NULL),(23,23,'2027-02-15 00:00:00',NULL,NULL),(24,24,'2027-03-04 00:00:00',NULL,NULL),(25,25,'2027-03-21 00:00:00',NULL,NULL),(26,26,'2027-04-07 00:00:00',NULL,NULL),(27,27,'2027-04-24 00:00:00',NULL,NULL),(28,28,'2027-05-11 00:00:00',NULL,NULL);
/*!40000 ALTER TABLE `client_ofd` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `codes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `codes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `code_value` varchar(255) NOT NULL,
  `is_used` tinyint(1) NOT NULL DEFAULT '0',
  `user_id` int DEFAULT NULL,
  `issued_at` datetime DEFAULT NULL,
  `code_type` enum('ofd_first','ofd_platform','ofd_other','edo','service','service_order') DEFAULT NULL,
  `operator_id` int DEFAULT NULL,
  `type_id` int DEFAULT NULL,
  `source_price` int DEFAULT NULL,
  `sell_price` int DEFAULT NULL,
  `vendor_name` varchar(255) DEFAULT NULL,
  `months_number` int DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL,
  `vseofd_order_id` char(36) DEFAULT NULL,
  `kkt_factory_number` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_codes_user_id` (`user_id`),
  CONSTRAINT `fk_codes_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `codes` WRITE;
/*!40000 ALTER TABLE `codes` DISABLE KEYS */;
/*!40000 ALTER TABLE `codes` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `companies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `companies` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `inn` varchar(20) DEFAULT NULL,
  `kpp` varchar(20) DEFAULT NULL,
  `ogrn` varchar(20) DEFAULT NULL,
  `address` text,
  `phone` varchar(50) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `description` text,
  `note` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `added_by_specialist_id` int DEFAULT NULL COMMENT 'ID специалиста/директора, создавшего компанию через CRM',
  `added_by_partner_id` bigint DEFAULT NULL,
  `partner_source_type` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_inn` (`inn`),
  KEY `idx_name` (`name`),
  KEY `ix_companies_added_by_partner` (`added_by_partner_id`),
  KEY `ix_companies_partner_source_type` (`partner_source_type`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `companies` WRITE;
/*!40000 ALTER TABLE `companies` DISABLE KEYS */;
INSERT INTO `companies` (`id`, `name`, `inn`, `kpp`, `ogrn`, `address`, `phone`, `email`, `website`, `description`, `note`, `created_at`, `updated_at`, `added_by_specialist_id`, `added_by_partner_id`, `partner_source_type`) VALUES (1,'ООО «Демо Маркет»','0000000001',NULL,NULL,'Москва, Примерная улица, 1','+70000020001','company01@demo.example',NULL,'Учебная компания для публичной демонстрации CRM',NULL,'2026-10-07 09:58:44','2026-10-07 09:58:44',1,NULL,NULL),(2,'ООО «Пример Сервис»','0000000002',NULL,NULL,'Казань, Примерная улица, 2','+70000020002','company02@demo.example',NULL,'Учебная компания для публичной демонстрации CRM',NULL,'2026-10-07 09:58:44','2026-10-07 09:58:44',1,NULL,NULL),(3,'ООО «Макет Торг»','0000000003',NULL,NULL,'Тверь, Примерная улица, 3','+70000020003','company03@demo.example',NULL,'Учебная компания для публичной демонстрации CRM',NULL,'2026-10-07 09:58:44','2026-10-07 09:58:44',1,NULL,NULL),(4,'ООО «Тест Кафе»','0000000004',NULL,NULL,'Самара, Примерная улица, 4','+70000020004','company04@demo.example',NULL,'Учебная компания для публичной демонстрации CRM',NULL,'2026-10-07 09:58:44','2026-10-07 09:58:44',1,NULL,NULL),(5,'ООО «Учебный Склад»','0000000005',NULL,NULL,'Пермь, Примерная улица, 5','+70000020005','company05@demo.example',NULL,'Учебная компания для публичной демонстрации CRM',NULL,'2026-10-07 09:58:44','2026-10-07 09:58:44',1,NULL,NULL),(6,'ООО «Сценарий»','0000000006',NULL,NULL,'Тула, Примерная улица, 6','+70000020006','company06@demo.example',NULL,'Учебная компания для публичной демонстрации CRM',NULL,'2026-10-07 09:58:44','2026-10-07 09:58:44',1,NULL,NULL),(7,'ООО «Витрина»','0000000007',NULL,NULL,'Калуга, Примерная улица, 7','+70000020007','company07@demo.example',NULL,'Учебная компания для публичной демонстрации CRM',NULL,'2026-10-07 09:58:45','2026-10-07 09:58:45',1,NULL,NULL),(8,'ООО «Образец Плюс»','0000000008',NULL,NULL,'Воронеж, Примерная улица, 8','+70000020008','company08@demo.example',NULL,'Учебная компания для публичной демонстрации CRM',NULL,'2026-10-07 09:58:45','2026-10-07 09:58:45',1,NULL,NULL),(9,'ООО «Проба»','0000000009',NULL,NULL,'Москва, Примерная улица, 9','+70000020009','company09@demo.example',NULL,'Учебная компания для публичной демонстрации CRM',NULL,'2026-10-07 09:58:45','2026-10-07 09:58:45',1,NULL,NULL),(10,'ООО «Демо Логистика»','0000000010',NULL,NULL,'Казань, Примерная улица, 10','+70000020010','company10@demo.example',NULL,'Учебная компания для публичной демонстрации CRM',NULL,'2026-10-07 09:58:45','2026-10-07 09:58:45',1,NULL,NULL);
/*!40000 ALTER TABLE `companies` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `company_contacts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `company_contacts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `company_id` int NOT NULL,
  `contact_id` int NOT NULL,
  `role` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_company_contact` (`company_id`,`contact_id`),
  KEY `idx_company` (`company_id`),
  KEY `idx_contact` (`contact_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `company_contacts` WRITE;
/*!40000 ALTER TABLE `company_contacts` DISABLE KEYS */;
INSERT INTO `company_contacts` (`id`, `company_id`, `contact_id`, `role`, `created_at`) VALUES (1,1,1,'Контактное лицо','2026-10-07 09:58:44'),(2,2,2,'Контактное лицо','2026-10-07 09:58:44'),(3,3,3,'Контактное лицо','2026-10-07 09:58:44'),(4,4,4,'Контактное лицо','2026-10-07 09:58:44'),(5,5,5,'Контактное лицо','2026-10-07 09:58:44'),(6,6,6,'Контактное лицо','2026-10-07 09:58:45'),(7,7,7,'Контактное лицо','2026-10-07 09:58:45'),(8,8,8,'Контактное лицо','2026-10-07 09:58:45'),(9,9,9,'Контактное лицо','2026-10-07 09:58:45'),(10,10,10,'Контактное лицо','2026-10-07 09:58:45');
/*!40000 ALTER TABLE `company_contacts` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `deadline_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `deadline_types` (
  `id` int NOT NULL AUTO_INCREMENT,
  `code` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `deadline_types` WRITE;
/*!40000 ALTER TABLE `deadline_types` DISABLE KEYS */;
/*!40000 ALTER TABLE `deadline_types` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (1,'contenttypes','0001_initial','2026-10-07 09:58:43.222785'),(2,'auth','0001_initial','2026-10-07 09:58:43.270720'),(3,'admin','0001_initial','2026-10-07 09:58:43.310224'),(4,'admin','0002_logentry_remove_auto_add','2026-10-07 09:58:43.340939'),(5,'admin','0003_logentry_add_action_flag_choices','2026-10-07 09:58:43.382410'),(6,'contenttypes','0002_remove_content_type_name','2026-10-07 09:58:43.416635'),(7,'auth','0002_alter_permission_name_max_length','2026-10-07 09:58:43.448090'),(8,'auth','0003_alter_user_email_max_length','2026-10-07 09:58:43.507018'),(9,'auth','0004_alter_user_username_opts','2026-10-07 09:58:43.539478'),(10,'auth','0005_alter_user_last_login_null','2026-10-07 09:58:43.562340'),(11,'auth','0006_require_contenttypes_0002','2026-10-07 09:58:43.581350'),(12,'auth','0007_alter_validators_add_error_messages','2026-10-07 09:58:43.602736'),(13,'auth','0008_alter_user_username_max_length','2026-10-07 09:58:43.620653'),(14,'auth','0009_alter_user_last_name_max_length','2026-10-07 09:58:43.671599'),(15,'auth','0010_alter_group_name_max_length','2026-10-07 09:58:43.712848'),(16,'auth','0011_update_proxy_permissions','2026-10-07 09:58:43.730578'),(17,'auth','0012_alter_user_first_name_max_length','2026-10-07 09:58:43.752111'),(18,'sessions','0001_initial','2026-10-07 09:58:43.774758');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `equipment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `equipment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `category` enum('Кассы','Сканер','ФН','Кассовые ленты','Этикетки') DEFAULT NULL,
  `is_used` tinyint(1) NOT NULL DEFAULT '0',
  `price` int NOT NULL DEFAULT '0',
  `image_name` varchar(100) DEFAULT NULL,
  `count` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `equipment` WRITE;
/*!40000 ALTER TABLE `equipment` DISABLE KEYS */;
INSERT INTO `equipment` (`id`, `name`, `category`, `is_used`, `price`, `image_name`, `count`) VALUES (1,'Касса Атол 30Ф',NULL,0,18900,NULL,25),(2,'Фискальный накопитель 36 мес.',NULL,0,13900,NULL,25),(3,'Подключение ОФД',NULL,0,4900,NULL,25),(4,'Сканер штрихкода',NULL,0,6200,NULL,25),(5,'Настройка маркировки',NULL,0,7800,NULL,25);
/*!40000 ALTER TABLE `equipment` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `ext_price_overrides`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ext_price_overrides` (
  `id` int NOT NULL AUTO_INCREMENT,
  `category` enum('ofd','service','edo') NOT NULL,
  `operator_id` int NOT NULL,
  `type_id` int NOT NULL,
  `price_fixed` int DEFAULT NULL,
  `markup_pct` decimal(8,2) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `comment` varchar(255) DEFAULT NULL,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_ext_price` (`category`,`operator_id`,`type_id`),
  KEY `idx_ext_price_active` (`category`,`is_active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `ext_price_overrides` WRITE;
/*!40000 ALTER TABLE `ext_price_overrides` DISABLE KEYS */;
/*!40000 ALTER TABLE `ext_price_overrides` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `ext_product_operators`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ext_product_operators` (
  `id` int NOT NULL AUTO_INCREMENT,
  `category` enum('ofd','service','services_for_orders','edo') NOT NULL,
  `operator_id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `sort_order` int NOT NULL DEFAULT '0',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_ext_product_operator` (`category`,`operator_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `ext_product_operators` WRITE;
/*!40000 ALTER TABLE `ext_product_operators` DISABLE KEYS */;
/*!40000 ALTER TABLE `ext_product_operators` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `ext_product_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ext_product_types` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type_id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `months_number` int DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `sort_order` int NOT NULL DEFAULT '0',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_ext_product_type` (`type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `ext_product_types` WRITE;
/*!40000 ALTER TABLE `ext_product_types` DISABLE KEYS */;
/*!40000 ALTER TABLE `ext_product_types` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `ext_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ext_products` (
  `id` int NOT NULL AUTO_INCREMENT,
  `category` enum('ofd','service','services_for_orders','edo') NOT NULL,
  `operator_id` int NOT NULL,
  `type_id` int NOT NULL,
  `external_name` varchar(255) DEFAULT NULL,
  `source_price` int DEFAULT NULL,
  `price_fixed` int DEFAULT NULL,
  `markup_pct` decimal(8,2) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `comment` varchar(255) DEFAULT NULL,
  `last_seen_at` datetime DEFAULT NULL,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_ext_product` (`category`,`operator_id`,`type_id`),
  KEY `idx_ext_products_active` (`category`,`is_active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `ext_products` WRITE;
/*!40000 ALTER TABLE `ext_products` DISABLE KEYS */;
/*!40000 ALTER TABLE `ext_products` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `login_attempts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `login_attempts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `login` varchar(128) NOT NULL,
  `ip_address` varchar(45) NOT NULL,
  `attempted_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `success` tinyint DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_login_ip` (`login`,`ip_address`),
  KEY `idx_attempted` (`attempted_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `login_attempts` WRITE;
/*!40000 ALTER TABLE `login_attempts` DISABLE KEYS */;
/*!40000 ALTER TABLE `login_attempts` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `loyalty_accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `loyalty_accounts` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `owner_type` enum('client','partner') NOT NULL DEFAULT 'client',
  `owner_id` bigint NOT NULL COMMENT 'users.id или specialists.id',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_loyalty_account_owner` (`owner_type`,`owner_id`),
  KEY `ix_loyalty_accounts_active` (`is_active`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `loyalty_accounts` WRITE;
/*!40000 ALTER TABLE `loyalty_accounts` DISABLE KEYS */;
INSERT INTO `loyalty_accounts` (`id`, `owner_type`, `owner_id`, `is_active`, `created_at`, `updated_at`) VALUES (1,'client',1,1,'2026-10-07 09:58:52','2026-10-07 09:58:52'),(2,'client',2,1,'2026-10-07 09:58:52','2026-10-07 09:58:52'),(3,'client',3,1,'2026-10-07 09:58:52','2026-10-07 09:58:52'),(4,'client',4,1,'2026-10-07 09:58:52','2026-10-07 09:58:52'),(5,'client',5,1,'2026-10-07 09:58:52','2026-10-07 09:58:52'),(6,'client',6,1,'2026-10-07 09:58:52','2026-10-07 09:58:52'),(7,'client',7,1,'2026-10-07 09:58:52','2026-10-07 09:58:52'),(8,'client',8,1,'2026-10-07 09:58:52','2026-10-07 09:58:52'),(9,'client',9,1,'2026-10-07 09:58:52','2026-10-07 09:58:52'),(10,'client',10,1,'2026-10-07 09:58:52','2026-10-07 09:58:52'),(11,'client',11,1,'2026-10-07 09:58:52','2026-10-07 09:58:52'),(12,'client',12,1,'2026-10-07 09:58:52','2026-10-07 09:58:52'),(13,'client',13,1,'2026-10-07 09:58:52','2026-10-07 09:58:52'),(14,'client',14,1,'2026-10-07 09:58:52','2026-10-07 09:58:52'),(15,'client',15,1,'2026-10-07 09:58:52','2026-10-07 09:58:52'),(16,'client',16,1,'2026-10-07 09:58:53','2026-10-07 09:58:53'),(17,'client',17,1,'2026-10-07 09:58:53','2026-10-07 09:58:53'),(18,'client',18,1,'2026-10-07 09:58:53','2026-10-07 09:58:53'),(19,'client',19,1,'2026-10-07 09:58:53','2026-10-07 09:58:53'),(20,'client',20,1,'2026-10-07 09:58:53','2026-10-07 09:58:53');
/*!40000 ALTER TABLE `loyalty_accounts` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `loyalty_balances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `loyalty_balances` (
  `account_id` bigint NOT NULL,
  `available_amount` int NOT NULL DEFAULT '0',
  `reserved_amount` int NOT NULL DEFAULT '0',
  `total_earned` int NOT NULL DEFAULT '0' COMMENT 'Всего начислено за всё время',
  `total_spent` int NOT NULL DEFAULT '0' COMMENT 'Всего списано за всё время',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`account_id`),
  CONSTRAINT `fk_loyalty_bal_account` FOREIGN KEY (`account_id`) REFERENCES `loyalty_accounts` (`id`) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `loyalty_balances` WRITE;
/*!40000 ALTER TABLE `loyalty_balances` DISABLE KEYS */;
INSERT INTO `loyalty_balances` (`account_id`, `available_amount`, `reserved_amount`, `total_earned`, `total_spent`, `updated_at`) VALUES (1,175,0,175,0,'2026-10-07 09:58:52'),(2,250,0,250,0,'2026-10-07 09:58:52'),(3,325,0,325,0,'2026-10-07 09:58:52'),(4,400,0,400,0,'2026-10-07 09:58:52'),(5,100,0,100,0,'2026-10-07 09:58:52'),(6,175,0,175,0,'2026-10-07 09:58:52'),(7,250,0,250,0,'2026-10-07 09:58:52'),(8,325,0,325,0,'2026-10-07 09:58:52'),(9,400,0,400,0,'2026-10-07 09:58:52'),(10,100,0,100,0,'2026-10-07 09:58:52'),(11,175,0,175,0,'2026-10-07 09:58:52'),(12,250,0,250,0,'2026-10-07 09:58:52'),(13,325,0,325,0,'2026-10-07 09:58:52'),(14,400,0,400,0,'2026-10-07 09:58:52'),(15,100,0,100,0,'2026-10-07 09:58:53'),(16,175,0,175,0,'2026-10-07 09:58:53'),(17,250,0,250,0,'2026-10-07 09:58:53'),(18,325,0,325,0,'2026-10-07 09:58:53'),(19,400,0,400,0,'2026-10-07 09:58:53'),(20,100,0,100,0,'2026-10-07 09:58:53');
/*!40000 ALTER TABLE `loyalty_balances` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `loyalty_transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `loyalty_transactions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `account_id` bigint NOT NULL,
  `direction` enum('credit','debit') NOT NULL COMMENT 'credit=начисление, debit=списание',
  `amount` int NOT NULL COMMENT 'Всегда положительное, направление определяется direction',
  `event_type` varchar(64) NOT NULL COMMENT 'purchase, first_purchase, profile_field, referral, redeem, expiry, manual и др.',
  `idempotency_key` varchar(128) NOT NULL COMMENT 'Уникальный ключ для идемпотентности',
  `description` varchar(255) DEFAULT NULL COMMENT 'Человекочитаемое описание для отображения в боте',
  `rating_delta` int NOT NULL DEFAULT '0' COMMENT 'Изменение рейтинга пользователя',
  `reversal_of_transaction_id` bigint DEFAULT NULL COMMENT 'Ссылка на сторнируемую транзакцию',
  `expires_at` datetime DEFAULT NULL COMMENT 'Дата сгорания баллов (NULL = бессрочно)',
  `is_expired` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Флаг: баллы уже сгорели',
  `ref_entity_type` varchar(32) DEFAULT NULL COMMENT 'order, chat_payment, referral и т.д.',
  `ref_entity_id` bigint DEFAULT NULL COMMENT 'ID связанной сущности',
  `meta_json` json DEFAULT NULL COMMENT 'Произвольные данные',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_loyalty_tx_idempotency` (`idempotency_key`),
  KEY `ix_loyalty_tx_account` (`account_id`,`created_at`),
  KEY `ix_loyalty_tx_event_type` (`event_type`),
  KEY `ix_loyalty_tx_expires` (`is_expired`,`expires_at`),
  KEY `ix_loyalty_tx_reversal` (`reversal_of_transaction_id`),
  CONSTRAINT `fk_loyalty_tx_account` FOREIGN KEY (`account_id`) REFERENCES `loyalty_accounts` (`id`) ON DELETE RESTRICT,
  CONSTRAINT `fk_loyalty_tx_reversal` FOREIGN KEY (`reversal_of_transaction_id`) REFERENCES `loyalty_transactions` (`id`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `loyalty_transactions` WRITE;
/*!40000 ALTER TABLE `loyalty_transactions` DISABLE KEYS */;
INSERT INTO `loyalty_transactions` (`id`, `account_id`, `direction`, `amount`, `event_type`, `idempotency_key`, `description`, `rating_delta`, `reversal_of_transaction_id`, `expires_at`, `is_expired`, `ref_entity_type`, `ref_entity_id`, `meta_json`, `created_at`) VALUES (1,1,'credit',175,'demo_purchase','demo-seed-1','Начисление DEMO баллов',0,NULL,NULL,0,NULL,NULL,NULL,'2026-10-07 09:58:52'),(2,2,'credit',250,'demo_purchase','demo-seed-2','Начисление DEMO баллов',0,NULL,NULL,0,NULL,NULL,NULL,'2026-10-07 09:58:52'),(3,3,'credit',325,'demo_purchase','demo-seed-3','Начисление DEMO баллов',0,NULL,NULL,0,NULL,NULL,NULL,'2026-10-07 09:58:52'),(4,4,'credit',400,'demo_purchase','demo-seed-4','Начисление DEMO баллов',0,NULL,NULL,0,NULL,NULL,NULL,'2026-10-07 09:58:52'),(5,5,'credit',100,'demo_purchase','demo-seed-5','Начисление DEMO баллов',0,NULL,NULL,0,NULL,NULL,NULL,'2026-10-07 09:58:52'),(6,6,'credit',175,'demo_purchase','demo-seed-6','Начисление DEMO баллов',0,NULL,NULL,0,NULL,NULL,NULL,'2026-10-07 09:58:52'),(7,7,'credit',250,'demo_purchase','demo-seed-7','Начисление DEMO баллов',0,NULL,NULL,0,NULL,NULL,NULL,'2026-10-07 09:58:52'),(8,8,'credit',325,'demo_purchase','demo-seed-8','Начисление DEMO баллов',0,NULL,NULL,0,NULL,NULL,NULL,'2026-10-07 09:58:52'),(9,9,'credit',400,'demo_purchase','demo-seed-9','Начисление DEMO баллов',0,NULL,NULL,0,NULL,NULL,NULL,'2026-10-07 09:58:52'),(10,10,'credit',100,'demo_purchase','demo-seed-10','Начисление DEMO баллов',0,NULL,NULL,0,NULL,NULL,NULL,'2026-10-07 09:58:52'),(11,11,'credit',175,'demo_purchase','demo-seed-11','Начисление DEMO баллов',0,NULL,NULL,0,NULL,NULL,NULL,'2026-10-07 09:58:52'),(12,12,'credit',250,'demo_purchase','demo-seed-12','Начисление DEMO баллов',0,NULL,NULL,0,NULL,NULL,NULL,'2026-10-07 09:58:52'),(13,13,'credit',325,'demo_purchase','demo-seed-13','Начисление DEMO баллов',0,NULL,NULL,0,NULL,NULL,NULL,'2026-10-07 09:58:52'),(14,14,'credit',400,'demo_purchase','demo-seed-14','Начисление DEMO баллов',0,NULL,NULL,0,NULL,NULL,NULL,'2026-10-07 09:58:52'),(15,15,'credit',100,'demo_purchase','demo-seed-15','Начисление DEMO баллов',0,NULL,NULL,0,NULL,NULL,NULL,'2026-10-07 09:58:53'),(16,16,'credit',175,'demo_purchase','demo-seed-16','Начисление DEMO баллов',0,NULL,NULL,0,NULL,NULL,NULL,'2026-10-07 09:58:53'),(17,17,'credit',250,'demo_purchase','demo-seed-17','Начисление DEMO баллов',0,NULL,NULL,0,NULL,NULL,NULL,'2026-10-07 09:58:53'),(18,18,'credit',325,'demo_purchase','demo-seed-18','Начисление DEMO баллов',0,NULL,NULL,0,NULL,NULL,NULL,'2026-10-07 09:58:53'),(19,19,'credit',400,'demo_purchase','demo-seed-19','Начисление DEMO баллов',0,NULL,NULL,0,NULL,NULL,NULL,'2026-10-07 09:58:53'),(20,20,'credit',100,'demo_purchase','demo-seed-20','Начисление DEMO баллов',0,NULL,NULL,0,NULL,NULL,NULL,'2026-10-07 09:58:53');
/*!40000 ALTER TABLE `loyalty_transactions` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `notification_delivery_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notification_delivery_log` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `notification_id` bigint NOT NULL,
  `channel` enum('web','telegram','email') NOT NULL,
  `recipient_id` bigint DEFAULT NULL,
  `sent_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `delivered_at` datetime DEFAULT NULL,
  `error` text,
  PRIMARY KEY (`id`),
  KEY `idx_notif` (`notification_id`),
  KEY `idx_sent` (`sent_at`),
  CONSTRAINT `fk_delivery_notif` FOREIGN KEY (`notification_id`) REFERENCES `notifications` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `notification_delivery_log` WRITE;
/*!40000 ALTER TABLE `notification_delivery_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `notification_delivery_log` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `notification_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notification_settings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `specialist_id` bigint NOT NULL,
  `type_id` int NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `email_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `telegram_enabled` tinyint(1) NOT NULL DEFAULT '1',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_spec_type` (`specialist_id`,`type_id`),
  KEY `fk_settings_type` (`type_id`),
  CONSTRAINT `fk_settings_spec` FOREIGN KEY (`specialist_id`) REFERENCES `specialists` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_settings_type` FOREIGN KEY (`type_id`) REFERENCES `notification_types` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `notification_settings` WRITE;
/*!40000 ALTER TABLE `notification_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `notification_settings` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `notification_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notification_types` (
  `id` int NOT NULL AUTO_INCREMENT,
  `code` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `icon` varchar(10) DEFAULT '?',
  `default_priority` enum('low','medium','high','urgent') DEFAULT 'medium',
  `description` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `notification_types` WRITE;
/*!40000 ALTER TABLE `notification_types` DISABLE KEYS */;
INSERT INTO `notification_types` (`id`, `code`, `name`, `icon`, `default_priority`, `description`) VALUES (1,'task','Задача','?','medium',NULL),(2,'deadline','Срок обслуживания','?','medium',NULL),(3,'chat','Чат','?','medium',NULL),(4,'order','Сделка','?','medium',NULL);
/*!40000 ALTER TABLE `notification_types` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notifications` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `type_id` int NOT NULL,
  `priority` enum('low','medium','high','urgent') NOT NULL DEFAULT 'medium',
  `title` varchar(255) NOT NULL,
  `message` text,
  `client_id` int DEFAULT NULL,
  `order_id` int DEFAULT NULL,
  `chat_id` bigint DEFAULT NULL,
  `kkt_id` int DEFAULT NULL,
  `deadline_type_id` int DEFAULT NULL,
  `deadline_date` date DEFAULT NULL,
  `extra_data` json DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `read_at` datetime DEFAULT NULL,
  `read_by` bigint DEFAULT NULL,
  `dismissed_at` datetime DEFAULT NULL,
  `dismissed_by` bigint DEFAULT NULL,
  `unique_key` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_unique_key` (`unique_key`),
  KEY `idx_type` (`type_id`),
  KEY `idx_priority` (`priority`),
  KEY `idx_client` (`client_id`),
  KEY `idx_order` (`order_id`),
  KEY `idx_chat` (`chat_id`),
  KEY `idx_kkt` (`kkt_id`),
  KEY `idx_deadline_date` (`deadline_date`),
  KEY `idx_created` (`created_at`),
  KEY `idx_read` (`read_at`),
  KEY `idx_unread` (`read_at`,`dismissed_at`),
  KEY `fk_notif_deadline_type` (`deadline_type_id`),
  KEY `fk_notif_read_by` (`read_by`),
  KEY `fk_notif_dismissed_by` (`dismissed_by`),
  CONSTRAINT `fk_notif_chat` FOREIGN KEY (`chat_id`) REFERENCES `support_chats` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_notif_client` FOREIGN KEY (`client_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_notif_deadline_type` FOREIGN KEY (`deadline_type_id`) REFERENCES `deadline_types` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_notif_dismissed_by` FOREIGN KEY (`dismissed_by`) REFERENCES `specialists` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_notif_kkt` FOREIGN KEY (`kkt_id`) REFERENCES `client_kkt` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_notif_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_notif_read_by` FOREIGN KEY (`read_by`) REFERENCES `specialists` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_notif_type` FOREIGN KEY (`type_id`) REFERENCES `notification_types` (`id`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
INSERT INTO `notifications` (`id`, `type_id`, `priority`, `title`, `message`, `client_id`, `order_id`, `chat_id`, `kkt_id`, `deadline_type_id`, `deadline_date`, `extra_data`, `created_at`, `read_at`, `read_by`, `dismissed_at`, `dismissed_by`, `unique_key`) VALUES (1,2,'medium','Демо уведомление #1','Проверьте срок ФН клиента 1.',1,NULL,NULL,NULL,NULL,'2026-10-01',NULL,'2026-10-07 07:58:43',NULL,NULL,NULL,NULL,NULL),(2,3,'high','Демо уведомление #2','Проверьте чат клиента 2.',2,NULL,NULL,NULL,NULL,NULL,NULL,'2026-10-07 02:58:43',NULL,NULL,NULL,NULL,NULL),(3,4,'low','Демо уведомление #3','Проверьте сделку клиента 3.',3,NULL,NULL,NULL,NULL,NULL,NULL,'2026-10-06 21:58:43',NULL,NULL,NULL,NULL,NULL),(4,1,'medium','Демо уведомление #4','Проверьте задачу клиента 4.',4,NULL,NULL,NULL,NULL,NULL,NULL,'2026-10-06 16:58:43',NULL,NULL,NULL,NULL,NULL),(5,2,'high','Демо уведомление #5','Проверьте срок ФН клиента 5.',5,NULL,NULL,NULL,NULL,'2026-10-05',NULL,'2026-10-06 11:58:43',NULL,NULL,NULL,NULL,NULL),(6,3,'low','Демо уведомление #6','Проверьте чат клиента 6.',6,NULL,NULL,NULL,NULL,NULL,NULL,'2026-10-06 06:58:43',NULL,NULL,NULL,NULL,NULL),(7,4,'medium','Демо уведомление #7','Проверьте сделку клиента 7.',7,NULL,NULL,NULL,NULL,NULL,NULL,'2026-10-06 01:58:43',NULL,NULL,NULL,NULL,NULL),(8,1,'high','Демо уведомление #8','Проверьте задачу клиента 8.',8,NULL,NULL,NULL,NULL,NULL,NULL,'2026-10-05 20:58:43',NULL,NULL,NULL,NULL,NULL),(9,2,'low','Демо уведомление #9','Проверьте срок ФН клиента 9.',9,NULL,NULL,NULL,NULL,'2026-10-09',NULL,'2026-10-05 15:58:43',NULL,NULL,NULL,NULL,NULL),(10,3,'medium','Демо уведомление #10','Проверьте чат клиента 10.',10,NULL,NULL,NULL,NULL,NULL,NULL,'2026-10-05 10:58:43',NULL,NULL,NULL,NULL,NULL),(11,4,'high','Демо уведомление #11','Проверьте сделку клиента 11.',11,NULL,NULL,NULL,NULL,NULL,NULL,'2026-10-05 05:58:43',NULL,NULL,NULL,NULL,NULL),(12,1,'low','Демо уведомление #12','Проверьте задачу клиента 12.',12,NULL,NULL,NULL,NULL,NULL,NULL,'2026-10-05 00:58:43',NULL,NULL,NULL,NULL,NULL),(13,2,'medium','Демо уведомление #13','Проверьте срок ФН клиента 13.',13,NULL,NULL,NULL,NULL,'2026-10-13',NULL,'2026-10-04 19:58:43',NULL,NULL,NULL,NULL,NULL),(14,3,'high','Демо уведомление #14','Проверьте чат клиента 14.',14,NULL,NULL,NULL,NULL,NULL,NULL,'2026-10-04 14:58:43',NULL,NULL,NULL,NULL,NULL),(15,4,'low','Демо уведомление #15','Проверьте сделку клиента 15.',15,NULL,NULL,NULL,NULL,NULL,NULL,'2026-10-04 09:58:43',NULL,NULL,NULL,NULL,NULL),(16,1,'medium','Демо уведомление #16','Проверьте задачу клиента 16.',16,NULL,NULL,NULL,NULL,NULL,NULL,'2026-10-04 04:58:43',NULL,NULL,NULL,NULL,NULL),(17,2,'high','Демо уведомление #17','Проверьте срок ФН клиента 17.',17,NULL,NULL,NULL,NULL,'2026-10-17',NULL,'2026-10-03 23:58:43',NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `order_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_items` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `code_id` int DEFAULT NULL,
  `equipment_id` int DEFAULT NULL,
  `qty` int NOT NULL DEFAULT '1',
  `price` int NOT NULL DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `legacy_item_type` varchar(255) DEFAULT NULL,
  `legacy_item_title` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_order_items_order_id` (`order_id`),
  KEY `idx_order_items_code_id` (`code_id`),
  KEY `idx_order_items_equipment_id` (`equipment_id`),
  CONSTRAINT `fk_order_items_code` FOREIGN KEY (`code_id`) REFERENCES `codes` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_order_items_equipment` FOREIGN KEY (`equipment_id`) REFERENCES `equipment` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_order_items_order_id` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `order_items` WRITE;
/*!40000 ALTER TABLE `order_items` DISABLE KEYS */;
INSERT INTO `order_items` (`id`, `order_id`, `code_id`, `equipment_id`, `qty`, `price`, `created_at`, `legacy_item_type`, `legacy_item_title`) VALUES (1,1,NULL,2,1,8100,'2026-10-05 12:58:43',NULL,'Фискальный накопитель 36 мес.'),(2,2,NULL,3,1,11300,'2026-10-03 12:58:43',NULL,'Подключение ОФД'),(3,3,NULL,4,1,14500,'2026-10-01 12:58:43',NULL,'Сканер штрихкода'),(4,4,NULL,5,1,17700,'2026-09-29 12:58:43',NULL,'Настройка маркировки'),(5,5,NULL,1,1,20900,'2026-09-27 12:58:43',NULL,'Касса Атол 30Ф'),(6,6,NULL,2,1,24100,'2026-09-25 12:58:43',NULL,'Фискальный накопитель 36 мес.'),(7,7,NULL,3,1,27300,'2026-09-23 12:58:43',NULL,'Подключение ОФД'),(8,8,NULL,4,1,4900,'2026-09-21 12:58:43',NULL,'Сканер штрихкода'),(9,9,NULL,5,1,8100,'2026-09-19 12:58:43',NULL,'Настройка маркировки'),(10,10,NULL,1,1,11300,'2026-09-17 12:58:43',NULL,'Касса Атол 30Ф'),(11,11,NULL,2,1,14500,'2026-09-15 12:58:43',NULL,'Фискальный накопитель 36 мес.'),(12,12,NULL,3,1,17700,'2026-09-13 12:58:43',NULL,'Подключение ОФД'),(13,13,NULL,4,1,20900,'2026-09-11 12:58:43',NULL,'Сканер штрихкода'),(14,14,NULL,5,1,24100,'2026-09-09 12:58:43',NULL,'Настройка маркировки'),(15,15,NULL,1,1,27300,'2026-09-07 12:58:43',NULL,'Касса Атол 30Ф'),(16,16,NULL,2,1,4900,'2026-09-05 12:58:43',NULL,'Фискальный накопитель 36 мес.'),(17,17,NULL,3,1,8100,'2026-09-03 12:58:43',NULL,'Подключение ОФД'),(18,18,NULL,4,1,11300,'2026-09-01 12:58:43',NULL,'Сканер штрихкода'),(19,19,NULL,5,1,14500,'2026-08-30 12:58:43',NULL,'Настройка маркировки'),(20,20,NULL,1,1,17700,'2026-08-28 12:58:43',NULL,'Касса Атол 30Ф'),(21,21,NULL,2,1,20900,'2026-08-26 12:58:43',NULL,'Фискальный накопитель 36 мес.'),(22,22,NULL,3,1,24100,'2026-08-24 12:58:43',NULL,'Подключение ОФД'),(23,23,NULL,4,1,27300,'2026-08-22 12:58:43',NULL,'Сканер штрихкода'),(24,24,NULL,5,1,4900,'2026-08-20 12:58:43',NULL,'Настройка маркировки'),(25,25,NULL,1,1,8100,'2026-08-18 12:58:43',NULL,'Касса Атол 30Ф'),(26,26,NULL,2,1,11300,'2026-08-16 12:58:43',NULL,'Фискальный накопитель 36 мес.');
/*!40000 ALTER TABLE `order_items` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `company_id` int DEFAULT NULL,
  `specialist_id` int DEFAULT NULL,
  `amount` int NOT NULL DEFAULT '0',
  `status` enum('CANCELLED','CONFIRMED','INIT','SHIPPED','ADVANCE','COMPLETED') DEFAULT NULL,
  `source` varchar(32) DEFAULT NULL,
  `payment_info` text,
  `description` text,
  `admin_note` text,
  `author_name` varchar(255) DEFAULT NULL,
  `payment_id` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `paid_at` datetime DEFAULT NULL,
  `delivery` enum('Доставка','Самовывоз','Доставка Озон/ВБ') DEFAULT NULL,
  `address_delivery` varchar(200) DEFAULT NULL,
  `address` text,
  PRIMARY KEY (`id`),
  KEY `idx_orders_user_id` (`user_id`),
  CONSTRAINT `fk_orders_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` (`id`, `user_id`, `company_id`, `specialist_id`, `amount`, `status`, `source`, `payment_info`, `description`, `admin_note`, `author_name`, `payment_id`, `created_at`, `updated_at`, `paid_at`, `delivery`, `address_delivery`, `address`) VALUES (1,1,NULL,3,8100,'SHIPPED','telegram',NULL,'Демонстрационная сделка: Фискальный накопитель 36 мес.',NULL,'Демо Директор',NULL,'2026-10-05 12:58:43','2026-10-05 12:58:43','2026-10-05 14:58:43',NULL,NULL,NULL),(2,2,NULL,4,11300,'INIT','max',NULL,'Демонстрационная сделка: Подключение ОФД',NULL,'Демо Директор',NULL,'2026-10-03 12:58:43','2026-10-03 12:58:43',NULL,NULL,NULL,NULL),(3,3,4,5,14500,'CANCELLED','manual',NULL,'Демонстрационная сделка: Сканер штрихкода',NULL,'Демо Директор',NULL,'2026-10-01 12:58:43','2026-10-01 12:58:43',NULL,NULL,NULL,NULL),(4,4,NULL,2,17700,'CONFIRMED','telegram',NULL,'Демонстрационная сделка: Настройка маркировки',NULL,'Демо Директор',NULL,'2026-09-29 12:58:43','2026-09-29 12:58:43','2026-09-29 14:58:43',NULL,NULL,NULL),(5,5,NULL,3,20900,'SHIPPED','max',NULL,'Демонстрационная сделка: Касса Атол 30Ф',NULL,'Демо Директор',NULL,'2026-09-27 12:58:43','2026-09-27 12:58:43','2026-09-27 14:58:43',NULL,NULL,NULL),(6,6,7,4,24100,'INIT','manual',NULL,'Демонстрационная сделка: Фискальный накопитель 36 мес.',NULL,'Демо Директор',NULL,'2026-09-25 12:58:43','2026-09-25 12:58:43',NULL,NULL,NULL,NULL),(7,7,NULL,5,27300,'CANCELLED','telegram',NULL,'Демонстрационная сделка: Подключение ОФД',NULL,'Демо Директор',NULL,'2026-09-23 12:58:43','2026-09-23 12:58:43',NULL,NULL,NULL,NULL),(8,8,NULL,2,4900,'CONFIRMED','max',NULL,'Демонстрационная сделка: Сканер штрихкода',NULL,'Демо Директор',NULL,'2026-09-21 12:58:43','2026-09-21 12:58:43','2026-09-21 14:58:43',NULL,NULL,NULL),(9,9,10,3,8100,'SHIPPED','manual',NULL,'Демонстрационная сделка: Настройка маркировки',NULL,'Демо Директор',NULL,'2026-09-19 12:58:43','2026-09-19 12:58:43','2026-09-19 14:58:43',NULL,NULL,NULL),(10,10,NULL,4,11300,'INIT','telegram',NULL,'Демонстрационная сделка: Касса Атол 30Ф',NULL,'Демо Директор',NULL,'2026-09-17 12:58:43','2026-09-17 12:58:43',NULL,NULL,NULL,NULL),(11,11,NULL,5,14500,'CANCELLED','max',NULL,'Демонстрационная сделка: Фискальный накопитель 36 мес.',NULL,'Демо Директор',NULL,'2026-09-15 12:58:43','2026-09-15 12:58:43',NULL,NULL,NULL,NULL),(12,12,3,2,17700,'CONFIRMED','manual',NULL,'Демонстрационная сделка: Подключение ОФД',NULL,'Демо Директор',NULL,'2026-09-13 12:58:43','2026-09-13 12:58:43','2026-09-13 14:58:43',NULL,NULL,NULL),(13,13,NULL,3,20900,'SHIPPED','telegram',NULL,'Демонстрационная сделка: Сканер штрихкода',NULL,'Демо Директор',NULL,'2026-09-11 12:58:43','2026-09-11 12:58:43','2026-09-11 14:58:43',NULL,NULL,NULL),(14,14,NULL,4,24100,'INIT','max',NULL,'Демонстрационная сделка: Настройка маркировки',NULL,'Демо Директор',NULL,'2026-09-09 12:58:43','2026-09-09 12:58:43',NULL,NULL,NULL,NULL),(15,15,6,5,27300,'CANCELLED','manual',NULL,'Демонстрационная сделка: Касса Атол 30Ф',NULL,'Демо Директор',NULL,'2026-09-07 12:58:43','2026-09-07 12:58:43',NULL,NULL,NULL,NULL),(16,16,NULL,2,4900,'CONFIRMED','telegram',NULL,'Демонстрационная сделка: Фискальный накопитель 36 мес.',NULL,'Демо Директор',NULL,'2026-09-05 12:58:43','2026-09-05 12:58:43','2026-09-05 14:58:43',NULL,NULL,NULL),(17,17,NULL,3,8100,'SHIPPED','max',NULL,'Демонстрационная сделка: Подключение ОФД',NULL,'Демо Директор',NULL,'2026-09-03 12:58:43','2026-09-03 12:58:43','2026-09-03 14:58:43',NULL,NULL,NULL),(18,18,9,4,11300,'INIT','manual',NULL,'Демонстрационная сделка: Сканер штрихкода',NULL,'Демо Директор',NULL,'2026-09-01 12:58:43','2026-09-01 12:58:43',NULL,NULL,NULL,NULL),(19,19,NULL,5,14500,'CANCELLED','telegram',NULL,'Демонстрационная сделка: Настройка маркировки',NULL,'Демо Директор',NULL,'2026-08-30 12:58:43','2026-08-30 12:58:43',NULL,NULL,NULL,NULL),(20,20,NULL,2,17700,'CONFIRMED','max',NULL,'Демонстрационная сделка: Касса Атол 30Ф',NULL,'Демо Директор',NULL,'2026-08-28 12:58:43','2026-08-28 12:58:43','2026-08-28 14:58:43',NULL,NULL,NULL),(21,21,2,3,20900,'SHIPPED','manual',NULL,'Демонстрационная сделка: Фискальный накопитель 36 мес.',NULL,'Демо Директор',NULL,'2026-08-26 12:58:43','2026-08-26 12:58:43','2026-08-26 14:58:43',NULL,NULL,NULL),(22,22,NULL,4,24100,'INIT','telegram',NULL,'Демонстрационная сделка: Подключение ОФД',NULL,'Демо Директор',NULL,'2026-08-24 12:58:43','2026-08-24 12:58:43',NULL,NULL,NULL,NULL),(23,23,NULL,5,27300,'CANCELLED','max',NULL,'Демонстрационная сделка: Сканер штрихкода',NULL,'Демо Директор',NULL,'2026-08-22 12:58:43','2026-08-22 12:58:43',NULL,NULL,NULL,NULL),(24,24,5,2,4900,'CONFIRMED','manual',NULL,'Демонстрационная сделка: Настройка маркировки',NULL,'Демо Директор',NULL,'2026-08-20 12:58:43','2026-08-20 12:58:43','2026-08-20 14:58:43',NULL,NULL,NULL),(25,25,NULL,3,8100,'SHIPPED','telegram',NULL,'Демонстрационная сделка: Касса Атол 30Ф',NULL,'Демо Директор',NULL,'2026-08-18 12:58:43','2026-08-18 12:58:43','2026-08-18 14:58:43',NULL,NULL,NULL),(26,26,NULL,4,11300,'INIT','max',NULL,'Демонстрационная сделка: Фискальный накопитель 36 мес.',NULL,'Демо Директор',NULL,'2026-08-16 12:58:43','2026-08-16 12:58:43',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `partner_financial_profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `partner_financial_profile` (
  `specialist_id` bigint NOT NULL,
  `base_revenue_pct` decimal(5,2) NOT NULL DEFAULT '50.00' COMMENT 'Базовая ставка % от выручки',
  `override_revenue_pct` decimal(5,2) DEFAULT NULL COMMENT 'Ручная ставка от директора (перекрывает base)',
  `rating` int NOT NULL DEFAULT '100' COMMENT 'Рейтинг партнёра (начальный 100)',
  `rating_tier` varchar(32) NOT NULL DEFAULT 'standard',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`specialist_id`),
  KEY `ix_pfp_rating` (`rating`),
  KEY `ix_pfp_active` (`is_active`),
  CONSTRAINT `fk_pfp_specialist` FOREIGN KEY (`specialist_id`) REFERENCES `specialists` (`id`) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `partner_financial_profile` WRITE;
/*!40000 ALTER TABLE `partner_financial_profile` DISABLE KEYS */;
INSERT INTO `partner_financial_profile` (`specialist_id`, `base_revenue_pct`, `override_revenue_pct`, `rating`, `rating_tier`, `is_active`, `created_at`, `updated_at`) VALUES (6,50.00,NULL,120,'standard',1,'2026-10-07 09:58:53','2026-10-07 09:58:53');
/*!40000 ALTER TABLE `partner_financial_profile` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `partner_rating_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `partner_rating_events` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `specialist_id` bigint NOT NULL,
  `delta` int NOT NULL COMMENT 'Изменение рейтинга (+/-)',
  `reason` varchar(64) NOT NULL COMMENT 'complaint, bonus, monthly_review, manual',
  `comment` varchar(500) DEFAULT NULL,
  `initiated_by` bigint DEFAULT NULL COMMENT 'specialists.id директора/админа (NULL = система)',
  `rating_before` int NOT NULL,
  `rating_after` int NOT NULL,
  `ref_entity_type` varchar(32) DEFAULT NULL COMMENT 'chat, order и т.д.',
  `ref_entity_id` bigint DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `ix_pre_specialist` (`specialist_id`,`created_at`),
  KEY `ix_pre_reason` (`reason`),
  CONSTRAINT `fk_pre_specialist` FOREIGN KEY (`specialist_id`) REFERENCES `specialists` (`id`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `partner_rating_events` WRITE;
/*!40000 ALTER TABLE `partner_rating_events` DISABLE KEYS */;
INSERT INTO `partner_rating_events` (`id`, `specialist_id`, `delta`, `reason`, `comment`, `initiated_by`, `rating_before`, `rating_after`, `ref_entity_type`, `ref_entity_id`, `created_at`) VALUES (1,6,20,'monthly_review','Демонстрационный рейтинг',NULL,100,120,NULL,NULL,'2026-10-07 09:58:53');
/*!40000 ALTER TABLE `partner_rating_events` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `partner_salary_adjustments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `partner_salary_adjustments` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `salary_period_id` bigint NOT NULL,
  `type` enum('bonus','penalty','correction') NOT NULL,
  `amount_rub` decimal(12,2) NOT NULL COMMENT 'Положительная для бонуса, отрицательная для штрафа',
  `comment` varchar(500) NOT NULL,
  `created_by` bigint NOT NULL COMMENT 'specialists.id директора',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `ix_psa_period` (`salary_period_id`),
  KEY `fk_psa_created_by` (`created_by`),
  CONSTRAINT `fk_psa_created_by` FOREIGN KEY (`created_by`) REFERENCES `specialists` (`id`) ON DELETE RESTRICT,
  CONSTRAINT `fk_psa_period` FOREIGN KEY (`salary_period_id`) REFERENCES `partner_salary_periods` (`id`) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `partner_salary_adjustments` WRITE;
/*!40000 ALTER TABLE `partner_salary_adjustments` DISABLE KEYS */;
/*!40000 ALTER TABLE `partner_salary_adjustments` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `partner_salary_periods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `partner_salary_periods` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `specialist_id` bigint NOT NULL,
  `period_month` char(7) NOT NULL COMMENT 'Формат YYYY-MM',
  `status` enum('draft','approved','paid') NOT NULL DEFAULT 'draft',
  `gross_revenue_rub` decimal(12,2) NOT NULL DEFAULT '0.00' COMMENT 'Общая выручка по партнёру за месяц',
  `effective_pct` decimal(5,2) NOT NULL DEFAULT '0.00' COMMENT 'Итоговый % (base/override + tier-бонус)',
  `base_salary_rub` decimal(12,2) NOT NULL DEFAULT '0.00' COMMENT 'gross_revenue * effective_pct / 100',
  `adjustments_rub` decimal(12,2) NOT NULL DEFAULT '0.00' COMMENT 'Сумма ручных корректировок',
  `final_salary_rub` decimal(12,2) NOT NULL DEFAULT '0.00' COMMENT 'base_salary + adjustments',
  `approved_by` bigint DEFAULT NULL,
  `approved_at` datetime DEFAULT NULL,
  `paid_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_psp_specialist_month` (`specialist_id`,`period_month`),
  KEY `ix_psp_status` (`status`),
  KEY `ix_psp_period` (`period_month`),
  CONSTRAINT `fk_psp_specialist` FOREIGN KEY (`specialist_id`) REFERENCES `specialists` (`id`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `partner_salary_periods` WRITE;
/*!40000 ALTER TABLE `partner_salary_periods` DISABLE KEYS */;
INSERT INTO `partner_salary_periods` (`id`, `specialist_id`, `period_month`, `status`, `gross_revenue_rub`, `effective_pct`, `base_salary_rub`, `adjustments_rub`, `final_salary_rub`, `approved_by`, `approved_at`, `paid_at`, `created_at`, `updated_at`) VALUES (1,6,'2026-10','draft',48000.00,50.00,24000.00,0.00,24000.00,NULL,NULL,NULL,'2026-10-07 09:58:53','2026-10-07 09:58:53');
/*!40000 ALTER TABLE `partner_salary_periods` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `rating_tiers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rating_tiers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `target_type` enum('client','partner') NOT NULL,
  `tier_name` varchar(32) NOT NULL COMMENT 'bronze, silver, gold, platinum',
  `min_rating` int NOT NULL COMMENT 'Минимальный рейтинг для попадания в уровень',
  `bonus_pct` decimal(5,2) NOT NULL DEFAULT '0.00' COMMENT 'Доп. % к начислению (для клиента) или к ставке (для партнёра)',
  `description` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_rt_type_tier` (`target_type`,`tier_name`),
  KEY `ix_rt_lookup` (`target_type`,`min_rating`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `rating_tiers` WRITE;
/*!40000 ALTER TABLE `rating_tiers` DISABLE KEYS */;
/*!40000 ALTER TABLE `rating_tiers` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `referral_activations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `referral_activations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `referral_code_id` bigint NOT NULL,
  `activated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `raw_text` varchar(64) DEFAULT NULL,
  `scan_source` varchar(32) DEFAULT NULL COMMENT 'qr, deep_link, manual',
  `verification_status` enum('pending','verified','rejected') DEFAULT NULL,
  `verification_at` datetime DEFAULT NULL,
  `unique_hash` varchar(64) DEFAULT NULL COMMENT 'Хэш для дедупликации QR-сканов',
  `source_platform` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_user_once` (`user_id`),
  KEY `ix_ref_code` (`referral_code_id`),
  KEY `ix_ra_unique_hash` (`unique_hash`),
  CONSTRAINT `fk_activations_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_ra_code` FOREIGN KEY (`referral_code_id`) REFERENCES `referral_codes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `referral_activations` WRITE;
/*!40000 ALTER TABLE `referral_activations` DISABLE KEYS */;
INSERT INTO `referral_activations` (`id`, `user_id`, `referral_code_id`, `activated_at`, `raw_text`, `scan_source`, `verification_status`, `verification_at`, `unique_hash`, `source_platform`) VALUES (1,13,1,'2026-10-07 09:58:52','DEMO0001','manual','verified',NULL,NULL,'telegram'),(2,14,2,'2026-10-07 09:58:52','DEMO0002','manual','verified',NULL,NULL,'telegram'),(3,15,3,'2026-10-07 09:58:52','DEMO0003','manual','verified',NULL,NULL,'telegram'),(4,16,4,'2026-10-07 09:58:52','DEMO0004','manual','verified',NULL,NULL,'telegram'),(5,17,5,'2026-10-07 09:58:52','DEMO0005','manual','verified',NULL,NULL,'telegram'),(6,18,6,'2026-10-07 09:58:52','DEMO0006','manual','verified',NULL,NULL,'telegram');
/*!40000 ALTER TABLE `referral_activations` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `referral_codes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `referral_codes` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `code` varchar(32) DEFAULT NULL,
  `owner_name` varchar(128) NOT NULL,
  `owner_note` varchar(255) DEFAULT NULL,
  `is_active` tinyint NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `user_id` int DEFAULT NULL,
  `owner_user_id` bigint DEFAULT NULL,
  `code_type` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_ref_code` (`code`),
  KEY `ix_ref_active` (`is_active`),
  KEY `fk_ref_codes_users` (`user_id`),
  CONSTRAINT `fk_ref_codes_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `referral_codes` WRITE;
/*!40000 ALTER TABLE `referral_codes` DISABLE KEYS */;
INSERT INTO `referral_codes` (`id`, `code`, `owner_name`, `owner_note`, `is_active`, `created_at`, `user_id`, `owner_user_id`, `code_type`) VALUES (1,'DEMO0001','Демо партнёр 1','Вымышленная реферальная программа',1,'2026-10-07 09:58:52',1,NULL,NULL),(2,'DEMO0002','Демо партнёр 2','Вымышленная реферальная программа',1,'2026-10-07 09:58:52',2,NULL,NULL),(3,'DEMO0003','Демо партнёр 3','Вымышленная реферальная программа',1,'2026-10-07 09:58:52',3,NULL,NULL),(4,'DEMO0004','Демо партнёр 4','Вымышленная реферальная программа',1,'2026-10-07 09:58:52',4,NULL,NULL),(5,'DEMO0005','Демо партнёр 5','Вымышленная реферальная программа',1,'2026-10-07 09:58:52',5,NULL,NULL),(6,'DEMO0006','Демо партнёр 6','Вымышленная реферальная программа',1,'2026-10-07 09:58:52',6,NULL,NULL);
/*!40000 ALTER TABLE `referral_codes` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `referral_qr_collection`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `referral_qr_collection` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `owner_user_id` int NOT NULL,
  `invited_user_id` int NOT NULL,
  `collected_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_owner_invited` (`owner_user_id`,`invited_user_id`),
  KEY `ix_owner` (`owner_user_id`),
  KEY `ix_invited` (`invited_user_id`),
  CONSTRAINT `fk_rqc_invited_user` FOREIGN KEY (`invited_user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_rqc_owner_user` FOREIGN KEY (`owner_user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `referral_qr_collection` WRITE;
/*!40000 ALTER TABLE `referral_qr_collection` DISABLE KEYS */;
/*!40000 ALTER TABLE `referral_qr_collection` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `specialist_promocodes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `specialist_promocodes` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `promo_code` varchar(64) NOT NULL,
  `specialist_id` bigint NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_promo` (`promo_code`),
  KEY `ix_promo_spec` (`specialist_id`),
  CONSTRAINT `fk_promo_spec` FOREIGN KEY (`specialist_id`) REFERENCES `specialists` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `specialist_promocodes` WRITE;
/*!40000 ALTER TABLE `specialist_promocodes` DISABLE KEYS */;
/*!40000 ALTER TABLE `specialist_promocodes` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `specialists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `specialists` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `phone` varchar(32) DEFAULT NULL,
  `tg_username` varchar(64) DEFAULT NULL,
  `tg_user_id` bigint DEFAULT NULL,
  `name` varchar(128) NOT NULL,
  `profession` tinyint NOT NULL,
  `role` varchar(32) NOT NULL DEFAULT 'specialist',
  `is_active` tinyint NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `phone_verified` tinyint NOT NULL DEFAULT '0',
  `login` varchar(50) DEFAULT NULL COMMENT 'Логин для сайта',
  `password_hash` varchar(255) DEFAULT NULL COMMENT 'Хэш пароля (SHA256+salt)',
  `is_director` tinyint(1) DEFAULT '0' COMMENT 'Флаг директора',
  `max_user_id` bigint DEFAULT NULL,
  `max_username` varchar(64) DEFAULT NULL,
  `linked_user_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_spec_tg_user_id` (`tg_user_id`),
  UNIQUE KEY `idx_specialists_login` (`login`),
  KEY `ix_spec_prof_active` (`profession`,`is_active`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `specialists` WRITE;
/*!40000 ALTER TABLE `specialists` DISABLE KEYS */;
INSERT INTO `specialists` (`id`, `phone`, `tg_username`, `tg_user_id`, `name`, `profession`, `role`, `is_active`, `created_at`, `updated_at`, `phone_verified`, `login`, `password_hash`, `is_director`, `max_user_id`, `max_username`, `linked_user_id`) VALUES (1,'+70000000001',NULL,NULL,'Демо Директор',1,'director',1,'2026-10-07 09:58:43','2026-10-07 09:58:43',0,'demo_1',NULL,1,NULL,NULL,NULL),(2,'+70000000002',NULL,NULL,'Анна Сервисная',1,'specialist',1,'2026-10-07 09:58:43','2026-10-07 09:58:43',0,'demo_2',NULL,0,NULL,NULL,NULL),(3,'+70000000003',NULL,NULL,'Максим Консультант',2,'specialist',1,'2026-10-07 09:58:43','2026-10-07 09:58:43',0,'demo_3',NULL,0,NULL,NULL,NULL),(4,'+70000000004',NULL,NULL,'Елена Бухгалтер',3,'specialist',1,'2026-10-07 09:58:43','2026-10-07 09:58:43',0,'demo_4',NULL,0,NULL,NULL,NULL),(5,'+70000000005',NULL,NULL,'Павел Документы',4,'specialist',1,'2026-10-07 09:58:43','2026-10-07 09:58:43',0,'demo_5',NULL,0,NULL,NULL,NULL),(6,'+70000000006',NULL,NULL,'Ольга Партнёр',5,'partner',1,'2026-10-07 09:58:43','2026-10-07 09:58:43',0,'demo_6',NULL,0,NULL,NULL,NULL);
/*!40000 ALTER TABLE `specialists` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `support_chat_declines`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `support_chat_declines` (
  `chat_id` bigint NOT NULL,
  `specialist_id` bigint NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`chat_id`,`specialist_id`),
  KEY `ix_decl_spec` (`specialist_id`),
  CONSTRAINT `fk_decl_chat` FOREIGN KEY (`chat_id`) REFERENCES `support_chats` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_decl_spec` FOREIGN KEY (`specialist_id`) REFERENCES `specialists` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `support_chat_declines` WRITE;
/*!40000 ALTER TABLE `support_chat_declines` DISABLE KEYS */;
/*!40000 ALTER TABLE `support_chat_declines` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `support_chat_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `support_chat_files` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `chat_id` bigint NOT NULL,
  `message_id` bigint DEFAULT NULL,
  `sender` tinyint NOT NULL,
  `original_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `stored_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `mime` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `size_bytes` bigint NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_chat_id` (`chat_id`),
  KEY `idx_message_id` (`message_id`),
  CONSTRAINT `fk_file_chat` FOREIGN KEY (`chat_id`) REFERENCES `support_chats` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_file_msg` FOREIGN KEY (`message_id`) REFERENCES `support_chat_messages` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `support_chat_files` WRITE;
/*!40000 ALTER TABLE `support_chat_files` DISABLE KEYS */;
/*!40000 ALTER TABLE `support_chat_files` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `support_chat_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `support_chat_messages` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `chat_id` bigint NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `sender` tinyint NOT NULL,
  `text` text NOT NULL,
  `is_read` tinyint NOT NULL DEFAULT '1',
  `edited_at` timestamp NULL DEFAULT NULL,
  `edited_by` bigint DEFAULT NULL,
  `is_edited` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `ix_chat_time` (`chat_id`,`id`),
  KEY `ix_msg_edited` (`is_edited`),
  KEY `ix_msg_unread` (`chat_id`,`sender`,`is_read`),
  KEY `ix_chat_sender_id` (`chat_id`,`sender`,`id`),
  CONSTRAINT `fk_msg_chat` FOREIGN KEY (`chat_id`) REFERENCES `support_chats` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `support_chat_messages` WRITE;
/*!40000 ALTER TABLE `support_chat_messages` DISABLE KEYS */;
INSERT INTO `support_chat_messages` (`id`, `chat_id`, `created_at`, `sender`, `text`, `is_read`, `edited_at`, `edited_by`, `is_edited`) VALUES (1,1,'2026-10-06 12:58:43',0,'Здравствуйте! Подскажите, пожалуйста, по теме: продление офд.',1,NULL,NULL,0),(2,1,'2026-10-06 13:08:43',1,'Здравствуйте! Проверяем данные и поможем вам.',1,NULL,NULL,0),(3,2,'2026-10-05 12:58:43',0,'Здравствуйте! Подскажите, пожалуйста, по теме: замена фн.',1,NULL,NULL,0),(4,2,'2026-10-05 13:08:43',1,'Здравствуйте! Проверяем данные и поможем вам.',1,NULL,NULL,0),(5,3,'2026-10-04 12:58:43',0,'Здравствуйте! Подскажите, пожалуйста, по теме: настройка маркировки.',1,NULL,NULL,0),(6,3,'2026-10-04 13:08:43',1,'Здравствуйте! Проверяем данные и поможем вам.',1,NULL,NULL,0),(7,4,'2026-10-03 12:58:43',0,'Здравствуйте! Подскажите, пожалуйста, по теме: вопрос по договору.',1,NULL,NULL,0),(8,4,'2026-10-03 13:08:43',1,'Здравствуйте! Проверяем данные и поможем вам.',1,NULL,NULL,0),(9,5,'2026-10-02 12:58:43',0,'Здравствуйте! Подскажите, пожалуйста, по теме: помощь с отчётом.',1,NULL,NULL,0),(10,5,'2026-10-02 13:08:43',1,'Здравствуйте! Проверяем данные и поможем вам.',1,NULL,NULL,0),(11,6,'2026-10-01 12:58:43',0,'Здравствуйте! Подскажите, пожалуйста, по теме: подключение кассы.',1,NULL,NULL,0),(12,6,'2026-10-01 13:08:43',1,'Здравствуйте! Проверяем данные и поможем вам.',1,NULL,NULL,0),(13,7,'2026-09-30 12:58:43',0,'Здравствуйте! Подскажите, пожалуйста, по теме: продление офд.',1,NULL,NULL,0),(14,7,'2026-09-30 13:08:43',1,'Здравствуйте! Проверяем данные и поможем вам.',1,NULL,NULL,0),(15,8,'2026-09-29 12:58:43',0,'Здравствуйте! Подскажите, пожалуйста, по теме: замена фн.',1,NULL,NULL,0),(16,8,'2026-09-29 13:08:43',1,'Здравствуйте! Проверяем данные и поможем вам.',1,NULL,NULL,0),(17,9,'2026-09-28 12:58:43',0,'Здравствуйте! Подскажите, пожалуйста, по теме: настройка маркировки.',1,NULL,NULL,0),(18,9,'2026-09-28 13:08:43',1,'Здравствуйте! Проверяем данные и поможем вам.',1,NULL,NULL,0),(19,10,'2026-09-27 12:58:43',0,'Здравствуйте! Подскажите, пожалуйста, по теме: вопрос по договору.',1,NULL,NULL,0),(20,10,'2026-09-27 13:08:43',1,'Здравствуйте! Проверяем данные и поможем вам.',1,NULL,NULL,0),(21,11,'2026-09-26 12:58:43',0,'Здравствуйте! Подскажите, пожалуйста, по теме: помощь с отчётом.',1,NULL,NULL,0),(22,11,'2026-09-26 13:08:43',1,'Здравствуйте! Проверяем данные и поможем вам.',1,NULL,NULL,0),(23,12,'2026-09-25 12:58:43',0,'Здравствуйте! Подскажите, пожалуйста, по теме: подключение кассы.',1,NULL,NULL,0),(24,12,'2026-09-25 13:08:43',1,'Здравствуйте! Проверяем данные и поможем вам.',1,NULL,NULL,0),(25,13,'2026-09-24 12:58:43',0,'Здравствуйте! Подскажите, пожалуйста, по теме: продление офд.',1,NULL,NULL,0),(26,13,'2026-09-24 13:08:43',1,'Здравствуйте! Проверяем данные и поможем вам.',1,NULL,NULL,0);
/*!40000 ALTER TABLE `support_chat_messages` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `support_chat_offers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `support_chat_offers` (
  `chat_id` bigint NOT NULL,
  `specialist_id` bigint NOT NULL,
  `tg_chat_id` bigint NOT NULL,
  `message_id` bigint NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`chat_id`,`specialist_id`,`message_id`),
  KEY `ix_offer_chat` (`chat_id`),
  KEY `ix_offer_spec` (`specialist_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `support_chat_offers` WRITE;
/*!40000 ALTER TABLE `support_chat_offers` DISABLE KEYS */;
/*!40000 ALTER TABLE `support_chat_offers` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `support_chat_payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `support_chat_payments` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `chat_id` bigint NOT NULL,
  `specialist_id` bigint NOT NULL,
  `amount_rub` int NOT NULL,
  `payment_id` varchar(64) NOT NULL,
  `pay_url` text NOT NULL,
  `status` varchar(32) NOT NULL DEFAULT 'NEW',
  `bonus_points_applied` int NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `gross_amount_rub` int DEFAULT NULL COMMENT 'Полная сумма до скидки',
  `bonus_discount_rub` int NOT NULL DEFAULT '0' COMMENT 'Скидка за счёт баллов (в рублях)',
  `cash_amount_rub` int NOT NULL DEFAULT '0',
  `bonus_reservation_key` varchar(128) DEFAULT NULL,
  `payment_method` varchar(32) NOT NULL DEFAULT 'CASH_ONLY',
  `paid_at` timestamp NULL DEFAULT NULL,
  `net_amount_rub` int DEFAULT NULL COMMENT 'Итого к оплате (gross - bonus_discount)',
  `bonus_points_spent` int NOT NULL DEFAULT '0' COMMENT 'Списано баллов',
  `bonus_rate_snapshot` decimal(8,4) DEFAULT NULL COMMENT 'Курс баллы→руб на момент оплаты',
  `salary_base_amount_rub` int DEFAULT NULL COMMENT 'База для расчёта зарплаты партнёра (= gross, не net)',
  `order_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_payment_id` (`payment_id`),
  KEY `ix_pay_chat` (`chat_id`),
  KEY `fk_pay_spec` (`specialist_id`),
  KEY `ix_pay_chat_status` (`chat_id`,`status`),
  KEY `ix_pay_paid_at` (`paid_at`),
  KEY `idx_scp_order_id` (`order_id`),
  CONSTRAINT `fk_pay_chat` FOREIGN KEY (`chat_id`) REFERENCES `support_chats` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_pay_spec` FOREIGN KEY (`specialist_id`) REFERENCES `specialists` (`id`) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `support_chat_payments` WRITE;
/*!40000 ALTER TABLE `support_chat_payments` DISABLE KEYS */;
/*!40000 ALTER TABLE `support_chat_payments` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `support_chat_read_state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `support_chat_read_state` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `chat_id` bigint NOT NULL,
  `specialist_id` bigint NOT NULL,
  `last_read_message_id` bigint NOT NULL DEFAULT '0',
  `last_read_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ux_chat_reader` (`chat_id`,`specialist_id`),
  KEY `ix_reader_chat` (`specialist_id`,`chat_id`),
  KEY `ix_chat_last_read` (`chat_id`,`last_read_message_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `support_chat_read_state` WRITE;
/*!40000 ALTER TABLE `support_chat_read_state` DISABLE KEYS */;
/*!40000 ALTER TABLE `support_chat_read_state` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `support_chat_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `support_chat_tokens` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `token` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `chat_id` bigint NOT NULL,
  `role` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `actor_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `expires_at` datetime NOT NULL,
  `revoked_at` datetime DEFAULT NULL,
  `replaced_by` bigint DEFAULT NULL,
  `last_seen_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `token` (`token`),
  KEY `idx_chat_tokens_chat_id` (`chat_id`),
  KEY `idx_chat_tokens_token` (`token`),
  KEY `idx_chat_tokens_expires` (`expires_at`),
  KEY `ix_support_chat_tokens_replaced_by` (`replaced_by`),
  CONSTRAINT `fk_token_chat` FOREIGN KEY (`chat_id`) REFERENCES `support_chats` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `support_chat_tokens` WRITE;
/*!40000 ALTER TABLE `support_chat_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `support_chat_tokens` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `support_chats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `support_chats` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `client_user_id` bigint NOT NULL,
  `specialist_id` bigint DEFAULT NULL,
  `profession` int NOT NULL,
  `category` varchar(128) DEFAULT NULL,
  `request_type` varchar(128) DEFAULT NULL,
  `status` enum('pending','active','consultation','closed','test') DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `accepted_at` timestamp NULL DEFAULT NULL,
  `closed_at` timestamp NULL DEFAULT NULL,
  `open_key` tinyint GENERATED ALWAYS AS ((case when (`status` in (_utf8mb4'pending',_utf8mb4'active')) then 1 else NULL end)) STORED,
  `close_req_client` tinyint NOT NULL DEFAULT '0',
  `close_req_agent` tinyint NOT NULL DEFAULT '0',
  `close_req_client_at` timestamp NULL DEFAULT NULL,
  `close_req_agent_at` timestamp NULL DEFAULT NULL,
  `source` varchar(32) DEFAULT 'telegram',
  PRIMARY KEY (`id`),
  KEY `ix_spec_status` (`specialist_id`,`status`),
  KEY `ix_client_prof` (`client_user_id`,`profession`),
  CONSTRAINT `fk_chat_spec` FOREIGN KEY (`specialist_id`) REFERENCES `specialists` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `support_chats` WRITE;
/*!40000 ALTER TABLE `support_chats` DISABLE KEYS */;
INSERT INTO `support_chats` (`id`, `client_user_id`, `specialist_id`, `profession`, `category`, `request_type`, `status`, `created_at`, `updated_at`, `accepted_at`, `closed_at`, `close_req_client`, `close_req_agent`, `close_req_client_at`, `close_req_agent_at`, `source`) VALUES (1,6,3,2,'Продление ОФД','support','pending','2026-10-06 12:58:43','2026-10-07 09:58:50',NULL,NULL,0,0,NULL,NULL,'max'),(2,7,4,3,'Замена ФН','support','closed','2026-10-05 12:58:43','2026-10-07 09:58:50','2026-10-05 13:06:43','2026-10-05 16:58:43',0,0,NULL,NULL,'manual'),(3,8,5,4,'Настройка маркировки','support','consultation','2026-10-04 12:58:43','2026-10-07 09:58:50','2026-10-04 13:06:43',NULL,0,0,NULL,NULL,'telegram'),(4,9,2,1,'Вопрос по договору','support','active','2026-10-03 12:58:43','2026-10-07 09:58:50','2026-10-03 13:06:43',NULL,0,0,NULL,NULL,'max'),(5,10,3,2,'Помощь с отчётом','support','pending','2026-10-02 12:58:43','2026-10-07 09:58:50',NULL,NULL,0,0,NULL,NULL,'manual'),(6,11,4,3,'Подключение кассы','support','closed','2026-10-01 12:58:43','2026-10-07 09:58:50','2026-10-01 13:06:43','2026-10-01 16:58:43',0,0,NULL,NULL,'telegram'),(7,12,5,4,'Продление ОФД','support','consultation','2026-09-30 12:58:43','2026-10-07 09:58:50','2026-09-30 13:06:43',NULL,0,0,NULL,NULL,'max'),(8,13,2,1,'Замена ФН','support','active','2026-09-29 12:58:43','2026-10-07 09:58:50','2026-09-29 13:06:43',NULL,0,0,NULL,NULL,'manual'),(9,14,3,2,'Настройка маркировки','support','pending','2026-09-28 12:58:43','2026-10-07 09:58:50',NULL,NULL,0,0,NULL,NULL,'telegram'),(10,15,4,3,'Вопрос по договору','support','closed','2026-09-27 12:58:43','2026-10-07 09:58:50','2026-09-27 13:06:43','2026-09-27 16:58:43',0,0,NULL,NULL,'max'),(11,16,5,4,'Помощь с отчётом','support','consultation','2026-09-26 12:58:43','2026-10-07 09:58:50','2026-09-26 13:06:43',NULL,0,0,NULL,NULL,'manual'),(12,17,2,1,'Подключение кассы','support','active','2026-09-25 12:58:43','2026-10-07 09:58:50','2026-09-25 13:06:43',NULL,0,0,NULL,NULL,'telegram'),(13,18,3,2,'Продление ОФД','support','pending','2026-09-24 12:58:43','2026-10-07 09:58:51',NULL,NULL,0,0,NULL,NULL,'max');
/*!40000 ALTER TABLE `support_chats` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `system_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_settings` (
  `name` varchar(100) NOT NULL,
  `value_type` enum('number','text','json') NOT NULL,
  `char_value` varchar(1000) DEFAULT NULL,
  `number_value` decimal(12,4) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` bigint DEFAULT NULL,
  `group_name` varchar(64) DEFAULT NULL COMMENT 'Группа настройки для UI',
  `sort_order` int NOT NULL DEFAULT '0' COMMENT 'Порядок отображения в группе',
  `unit` varchar(32) DEFAULT NULL COMMENT 'Единица измерения: %, баллы, руб, дни',
  PRIMARY KEY (`name`),
  KEY `idx_system_settings_value_type` (`value_type`),
  KEY `idx_system_settings_updated_by` (`updated_by`),
  CONSTRAINT `fk_system_settings_updated_by` FOREIGN KEY (`updated_by`) REFERENCES `specialists` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `system_settings` WRITE;
/*!40000 ALTER TABLE `system_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `system_settings` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `task_clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `task_clients` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `task_id` bigint NOT NULL,
  `client_id` int NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_task_client` (`task_id`,`client_id`),
  KEY `idx_task_clients_client` (`client_id`),
  CONSTRAINT `fk_task_clients_client` FOREIGN KEY (`client_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_task_clients_task` FOREIGN KEY (`task_id`) REFERENCES `tasks` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `task_clients` WRITE;
/*!40000 ALTER TABLE `task_clients` DISABLE KEYS */;
INSERT INTO `task_clients` (`id`, `task_id`, `client_id`, `created_at`) VALUES (1,1,1,'2026-10-07 09:58:48'),(2,2,2,'2026-10-07 09:58:48'),(3,3,3,'2026-10-07 09:58:48'),(4,4,4,'2026-10-07 09:58:48'),(5,5,5,'2026-10-07 09:58:48'),(6,6,6,'2026-10-07 09:58:48'),(7,7,7,'2026-10-07 09:58:49'),(8,8,8,'2026-10-07 09:58:49'),(9,9,9,'2026-10-07 09:58:49'),(10,10,10,'2026-10-07 09:58:49'),(11,11,11,'2026-10-07 09:58:49'),(12,12,12,'2026-10-07 09:58:49'),(13,13,13,'2026-10-07 09:58:49'),(14,14,14,'2026-10-07 09:58:49'),(15,15,15,'2026-10-07 09:58:49'),(16,16,16,'2026-10-07 09:58:49'),(17,17,17,'2026-10-07 09:58:49'),(18,18,18,'2026-10-07 09:58:49'),(19,19,19,'2026-10-07 09:58:50'),(20,20,20,'2026-10-07 09:58:50'),(21,21,21,'2026-10-07 09:58:50');
/*!40000 ALTER TABLE `task_clients` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `task_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `task_history` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `task_id` bigint NOT NULL,
  `actor_id` bigint DEFAULT NULL,
  `action_type` varchar(64) NOT NULL,
  `comment` text,
  `old_status` varchar(32) DEFAULT NULL,
  `new_status` varchar(32) DEFAULT NULL,
  `reminder_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_task_history_task` (`task_id`),
  KEY `idx_task_history_created` (`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `task_history` WRITE;
/*!40000 ALTER TABLE `task_history` DISABLE KEYS */;
INSERT INTO `task_history` (`id`, `task_id`, `actor_id`, `action_type`, `comment`, `old_status`, `new_status`, `reminder_at`, `created_at`) VALUES (1,1,1,'created','Создано в DEMO',NULL,'awaiting_assignment',NULL,'2026-10-06 12:58:43'),(2,1,3,'status_changed',NULL,'awaiting_assignment','in_progress',NULL,'2026-10-06 14:58:43'),(3,2,1,'created','Создано в DEMO',NULL,'awaiting_assignment',NULL,'2026-10-05 12:58:43'),(4,2,4,'status_changed',NULL,'awaiting_assignment','postponed',NULL,'2026-10-05 14:58:43'),(5,3,1,'created','Создано в DEMO',NULL,'awaiting_assignment',NULL,'2026-10-04 12:58:43'),(6,3,5,'status_changed',NULL,'awaiting_assignment','done',NULL,'2026-10-04 14:58:43'),(7,4,1,'created','Создано в DEMO',NULL,'awaiting_assignment',NULL,'2026-10-03 12:58:43'),(8,5,1,'created','Создано в DEMO',NULL,'awaiting_assignment',NULL,'2026-10-02 12:58:43'),(9,5,3,'status_changed',NULL,'awaiting_assignment','in_progress',NULL,'2026-10-02 14:58:43'),(10,6,1,'created','Создано в DEMO',NULL,'awaiting_assignment',NULL,'2026-10-01 12:58:43'),(11,6,4,'status_changed',NULL,'awaiting_assignment','postponed',NULL,'2026-10-01 14:58:43'),(12,7,1,'created','Создано в DEMO',NULL,'awaiting_assignment',NULL,'2026-09-30 12:58:43'),(13,7,5,'status_changed',NULL,'awaiting_assignment','done',NULL,'2026-09-30 14:58:43'),(14,8,1,'created','Создано в DEMO',NULL,'awaiting_assignment',NULL,'2026-09-29 12:58:43'),(15,9,1,'created','Создано в DEMO',NULL,'awaiting_assignment',NULL,'2026-09-28 12:58:43'),(16,9,3,'status_changed',NULL,'awaiting_assignment','in_progress',NULL,'2026-09-28 14:58:43'),(17,10,1,'created','Создано в DEMO',NULL,'awaiting_assignment',NULL,'2026-09-27 12:58:43'),(18,10,4,'status_changed',NULL,'awaiting_assignment','postponed',NULL,'2026-09-27 14:58:43'),(19,11,1,'created','Создано в DEMO',NULL,'awaiting_assignment',NULL,'2026-09-26 12:58:43'),(20,11,5,'status_changed',NULL,'awaiting_assignment','done',NULL,'2026-09-26 14:58:43'),(21,12,1,'created','Создано в DEMO',NULL,'awaiting_assignment',NULL,'2026-09-25 12:58:43'),(22,13,1,'created','Создано в DEMO',NULL,'awaiting_assignment',NULL,'2026-09-24 12:58:43'),(23,13,3,'status_changed',NULL,'awaiting_assignment','in_progress',NULL,'2026-09-24 14:58:43'),(24,14,1,'created','Создано в DEMO',NULL,'awaiting_assignment',NULL,'2026-09-23 12:58:43'),(25,14,4,'status_changed',NULL,'awaiting_assignment','postponed',NULL,'2026-09-23 14:58:43'),(26,15,1,'created','Создано в DEMO',NULL,'awaiting_assignment',NULL,'2026-09-22 12:58:43'),(27,15,5,'status_changed',NULL,'awaiting_assignment','done',NULL,'2026-09-22 14:58:43'),(28,16,1,'created','Создано в DEMO',NULL,'awaiting_assignment',NULL,'2026-09-21 12:58:43'),(29,17,1,'created','Создано в DEMO',NULL,'awaiting_assignment',NULL,'2026-09-20 12:58:43'),(30,17,3,'status_changed',NULL,'awaiting_assignment','in_progress',NULL,'2026-09-20 14:58:43'),(31,18,1,'created','Создано в DEMO',NULL,'awaiting_assignment',NULL,'2026-09-19 12:58:43'),(32,18,4,'status_changed',NULL,'awaiting_assignment','postponed',NULL,'2026-09-19 14:58:43'),(33,19,1,'created','Создано в DEMO',NULL,'awaiting_assignment',NULL,'2026-09-18 12:58:43'),(34,19,5,'status_changed',NULL,'awaiting_assignment','done',NULL,'2026-09-18 14:58:43'),(35,20,1,'created','Создано в DEMO',NULL,'awaiting_assignment',NULL,'2026-09-17 12:58:43'),(36,21,1,'created','Создано в DEMO',NULL,'awaiting_assignment',NULL,'2026-09-16 12:58:43'),(37,21,3,'status_changed',NULL,'awaiting_assignment','in_progress',NULL,'2026-09-16 14:58:43');
/*!40000 ALTER TABLE `task_history` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tasks` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(500) NOT NULL,
  `description` text,
  `source_type` varchar(32) NOT NULL DEFAULT 'manual',
  `source_id` bigint DEFAULT NULL,
  `dedupe_key` varchar(255) DEFAULT NULL,
  `meta_json` longtext,
  `director_id` bigint DEFAULT NULL,
  `created_by` bigint NOT NULL,
  `assignee_id` bigint DEFAULT NULL,
  `client_id` bigint DEFAULT NULL,
  `assigned_at` datetime DEFAULT NULL,
  `completed_at` datetime DEFAULT NULL,
  `postponed_until` datetime DEFAULT NULL,
  `deadline` datetime DEFAULT NULL,
  `priority` varchar(16) NOT NULL DEFAULT 'medium',
  `status` varchar(32) NOT NULL DEFAULT 'awaiting_assignment',
  `result_comment` text,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_tasks_dedupe` (`dedupe_key`),
  KEY `idx_tasks_assignee` (`assignee_id`),
  KEY `idx_tasks_status` (`status`),
  KEY `idx_tasks_deadline` (`deadline`),
  KEY `idx_tasks_source` (`source_type`,`source_id`),
  KEY `idx_tasks_created_by` (`created_by`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `tasks` WRITE;
/*!40000 ALTER TABLE `tasks` DISABLE KEYS */;
INSERT INTO `tasks` (`id`, `title`, `description`, `source_type`, `source_id`, `dedupe_key`, `meta_json`, `director_id`, `created_by`, `assignee_id`, `client_id`, `assigned_at`, `completed_at`, `postponed_until`, `deadline`, `priority`, `status`, `result_comment`, `created_at`, `updated_at`) VALUES (1,'Проверить срок ФН — клиент 1','Тестовая задача для демонстрации рабочего процесса.','manual',NULL,NULL,NULL,1,1,3,1,NULL,NULL,NULL,'2026-10-05 12:58:43','medium','in_progress',NULL,'2026-10-06 12:58:43','2026-10-07 09:58:48'),(2,'Подготовить КП — клиент 2','Тестовая задача для демонстрации рабочего процесса.','manual',NULL,NULL,NULL,1,1,4,2,NULL,NULL,'2026-10-10 12:58:43','2026-10-06 12:58:43','high','postponed',NULL,'2026-10-05 12:58:43','2026-10-07 09:58:48'),(3,'Настроить кассу — клиент 3','Тестовая задача для демонстрации рабочего процесса.','manual',NULL,NULL,NULL,1,1,5,3,NULL,'2026-10-04 16:58:43',NULL,'2026-10-07 12:58:43','low','done',NULL,'2026-10-04 12:58:43','2026-10-07 09:58:48'),(4,'Обновить карточку клиента — клиент 4','Тестовая задача для демонстрации рабочего процесса.','manual',NULL,NULL,NULL,1,1,NULL,4,NULL,NULL,NULL,'2026-10-08 12:58:43','medium','awaiting_assignment',NULL,'2026-10-03 12:58:43','2026-10-07 09:58:48'),(5,'Уточнить реквизиты — клиент 5','Тестовая задача для демонстрации рабочего процесса.','manual',NULL,NULL,NULL,1,1,3,5,NULL,NULL,NULL,'2026-10-09 12:58:43','high','in_progress',NULL,'2026-10-02 12:58:43','2026-10-07 09:58:48'),(6,'Связаться с клиентом — клиент 6','Тестовая задача для демонстрации рабочего процесса.','manual',NULL,NULL,NULL,1,1,4,6,NULL,NULL,'2026-10-10 12:58:43','2026-10-10 12:58:43','low','postponed',NULL,'2026-10-01 12:58:43','2026-10-07 09:58:48'),(7,'Продлить договор ОФД — клиент 7','Тестовая задача для демонстрации рабочего процесса.','manual',NULL,NULL,NULL,1,1,5,7,NULL,'2026-09-30 16:58:43',NULL,'2026-10-11 12:58:43','medium','done',NULL,'2026-09-30 12:58:43','2026-10-07 09:58:49'),(8,'Проверить срок ФН — клиент 8','Тестовая задача для демонстрации рабочего процесса.','manual',NULL,NULL,NULL,1,1,NULL,8,NULL,NULL,NULL,'2026-10-12 12:58:43','high','awaiting_assignment',NULL,'2026-09-29 12:58:43','2026-10-07 09:58:49'),(9,'Подготовить КП — клиент 9','Тестовая задача для демонстрации рабочего процесса.','manual',NULL,NULL,NULL,1,1,3,9,NULL,NULL,NULL,'2026-10-04 12:58:43','low','in_progress',NULL,'2026-09-28 12:58:43','2026-10-07 09:58:49'),(10,'Настроить кассу — клиент 10','Тестовая задача для демонстрации рабочего процесса.','manual',NULL,NULL,NULL,1,1,4,10,NULL,NULL,'2026-10-10 12:58:43','2026-10-05 12:58:43','medium','postponed',NULL,'2026-09-27 12:58:43','2026-10-07 09:58:49'),(11,'Обновить карточку клиента — клиент 11','Тестовая задача для демонстрации рабочего процесса.','manual',NULL,NULL,NULL,1,1,5,11,NULL,'2026-09-26 16:58:43',NULL,'2026-10-06 12:58:43','high','done',NULL,'2026-09-26 12:58:43','2026-10-07 09:58:49'),(12,'Уточнить реквизиты — клиент 12','Тестовая задача для демонстрации рабочего процесса.','manual',NULL,NULL,NULL,1,1,NULL,12,NULL,NULL,NULL,'2026-10-07 12:58:43','low','awaiting_assignment',NULL,'2026-09-25 12:58:43','2026-10-07 09:58:49'),(13,'Связаться с клиентом — клиент 13','Тестовая задача для демонстрации рабочего процесса.','manual',NULL,NULL,NULL,1,1,3,13,NULL,NULL,NULL,'2026-10-08 12:58:43','medium','in_progress',NULL,'2026-09-24 12:58:43','2026-10-07 09:58:49'),(14,'Продлить договор ОФД — клиент 14','Тестовая задача для демонстрации рабочего процесса.','manual',NULL,NULL,NULL,1,1,4,14,NULL,NULL,'2026-10-10 12:58:43','2026-10-09 12:58:43','high','postponed',NULL,'2026-09-23 12:58:43','2026-10-07 09:58:49'),(15,'Проверить срок ФН — клиент 15','Тестовая задача для демонстрации рабочего процесса.','manual',NULL,NULL,NULL,1,1,5,15,NULL,'2026-09-22 16:58:43',NULL,'2026-10-10 12:58:43','low','done',NULL,'2026-09-22 12:58:43','2026-10-07 09:58:49'),(16,'Подготовить КП — клиент 16','Тестовая задача для демонстрации рабочего процесса.','manual',NULL,NULL,NULL,1,1,NULL,16,NULL,NULL,NULL,'2026-10-11 12:58:43','medium','awaiting_assignment',NULL,'2026-09-21 12:58:43','2026-10-07 09:58:49'),(17,'Настроить кассу — клиент 17','Тестовая задача для демонстрации рабочего процесса.','manual',NULL,NULL,NULL,1,1,3,17,NULL,NULL,NULL,'2026-10-12 12:58:43','high','in_progress',NULL,'2026-09-20 12:58:43','2026-10-07 09:58:49'),(18,'Обновить карточку клиента — клиент 18','Тестовая задача для демонстрации рабочего процесса.','manual',NULL,NULL,NULL,1,1,4,18,NULL,NULL,'2026-10-10 12:58:43','2026-10-04 12:58:43','low','postponed',NULL,'2026-09-19 12:58:43','2026-10-07 09:58:49'),(19,'Уточнить реквизиты — клиент 19','Тестовая задача для демонстрации рабочего процесса.','manual',NULL,NULL,NULL,1,1,5,19,NULL,'2026-09-18 16:58:43',NULL,'2026-10-05 12:58:43','medium','done',NULL,'2026-09-18 12:58:43','2026-10-07 09:58:49'),(20,'Связаться с клиентом — клиент 20','Тестовая задача для демонстрации рабочего процесса.','manual',NULL,NULL,NULL,1,1,NULL,20,NULL,NULL,NULL,'2026-10-06 12:58:43','high','awaiting_assignment',NULL,'2026-09-17 12:58:43','2026-10-07 09:58:50'),(21,'Продлить договор ОФД — клиент 21','Тестовая задача для демонстрации рабочего процесса.','manual',NULL,NULL,NULL,1,1,3,21,NULL,NULL,NULL,'2026-10-07 12:58:43','low','in_progress',NULL,'2026-09-16 12:58:43','2026-10-07 09:58:50');
/*!40000 ALTER TABLE `tasks` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `ui_state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ui_state` (
  `tg_user_id` bigint NOT NULL,
  `main_menu_mid` bigint DEFAULT NULL,
  `boot_notice_mid` bigint DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`tg_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `ui_state` WRITE;
/*!40000 ALTER TABLE `ui_state` DISABLE KEYS */;
/*!40000 ALTER TABLE `ui_state` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `user_custom_fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_custom_fields` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `field_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `field_value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_user_field` (`user_id`,`field_name`),
  KEY `idx_user_id` (`user_id`),
  CONSTRAINT `fk_custom_fields_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `user_custom_fields` WRITE;
/*!40000 ALTER TABLE `user_custom_fields` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_custom_fields` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `user_loyalty_profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_loyalty_profile` (
  `user_id` bigint NOT NULL COMMENT 'users.id (internal)',
  `rating` int NOT NULL DEFAULT '0',
  `tier` varchar(32) NOT NULL DEFAULT 'bronze',
  `total_orders` int NOT NULL DEFAULT '0',
  `total_spent_rub` decimal(12,2) NOT NULL DEFAULT '0.00',
  `last_activity_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  KEY `ix_ulp_rating` (`rating`),
  KEY `ix_ulp_tier` (`tier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `user_loyalty_profile` WRITE;
/*!40000 ALTER TABLE `user_loyalty_profile` DISABLE KEYS */;
INSERT INTO `user_loyalty_profile` (`user_id`, `rating`, `tier`, `total_orders`, `total_spent_rub`, `last_activity_at`, `created_at`, `updated_at`) VALUES (1,103,'bronze',2,6000.00,'2026-10-06 12:58:43','2026-10-07 09:58:52','2026-10-07 09:58:52'),(2,106,'bronze',3,7100.00,'2026-10-05 12:58:43','2026-10-07 09:58:52','2026-10-07 09:58:52'),(3,109,'bronze',1,8200.00,'2026-10-04 12:58:43','2026-10-07 09:58:52','2026-10-07 09:58:52'),(4,112,'silver',2,9300.00,'2026-10-03 12:58:43','2026-10-07 09:58:52','2026-10-07 09:58:52'),(5,115,'bronze',3,10400.00,'2026-10-02 12:58:43','2026-10-07 09:58:52','2026-10-07 09:58:52'),(6,118,'bronze',1,11500.00,'2026-10-01 12:58:43','2026-10-07 09:58:52','2026-10-07 09:58:52'),(7,121,'bronze',2,12600.00,'2026-09-30 12:58:43','2026-10-07 09:58:52','2026-10-07 09:58:52'),(8,124,'silver',3,13700.00,'2026-09-29 12:58:43','2026-10-07 09:58:52','2026-10-07 09:58:52'),(9,127,'bronze',1,14800.00,'2026-09-28 12:58:43','2026-10-07 09:58:52','2026-10-07 09:58:52'),(10,130,'bronze',2,15900.00,'2026-09-27 12:58:43','2026-10-07 09:58:52','2026-10-07 09:58:52'),(11,133,'bronze',3,17000.00,'2026-09-26 12:58:43','2026-10-07 09:58:52','2026-10-07 09:58:52'),(12,136,'silver',1,18100.00,'2026-09-25 12:58:43','2026-10-07 09:58:52','2026-10-07 09:58:52'),(13,139,'bronze',2,19200.00,'2026-09-24 12:58:43','2026-10-07 09:58:52','2026-10-07 09:58:52'),(14,142,'bronze',3,20300.00,'2026-09-23 12:58:43','2026-10-07 09:58:52','2026-10-07 09:58:52'),(15,145,'bronze',1,21400.00,'2026-09-22 12:58:43','2026-10-07 09:58:53','2026-10-07 09:58:53'),(16,148,'silver',2,22500.00,'2026-09-21 12:58:43','2026-10-07 09:58:53','2026-10-07 09:58:53'),(17,151,'bronze',3,23600.00,'2026-09-20 12:58:43','2026-10-07 09:58:53','2026-10-07 09:58:53'),(18,154,'bronze',1,24700.00,'2026-09-19 12:58:43','2026-10-07 09:58:53','2026-10-07 09:58:53'),(19,157,'bronze',2,25800.00,'2026-09-18 12:58:43','2026-10-07 09:58:53','2026-10-07 09:58:53'),(20,160,'silver',3,26900.00,'2026-09-17 12:58:43','2026-10-07 09:58:53','2026-10-07 09:58:53');
/*!40000 ALTER TABLE `user_loyalty_profile` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tg_user_id` bigint DEFAULT NULL,
  `max_user_id` bigint DEFAULT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `tg_username` varchar(255) DEFAULT NULL,
  `inn` varchar(20) DEFAULT NULL,
  `org_name` varchar(255) DEFAULT NULL,
  `kpp` varchar(20) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `birth_date` date DEFAULT NULL,
  `amo_company_id` varchar(64) DEFAULT NULL,
  `consent_accepted` tinyint(1) NOT NULL DEFAULT '0',
  `consent_accepted_at` datetime DEFAULT NULL,
  `is_verified` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `referral_code_id` bigint DEFAULT NULL,
  `address` varchar(200) DEFAULT NULL,
  `kkt_factory_number` varchar(25) DEFAULT NULL,
  `we_added` tinyint(1) NOT NULL DEFAULT '0',
  `added_by_specialist_id` int DEFAULT NULL COMMENT 'ID специалиста/директора, создавшего клиента через CRM',
  `added_by_partner_id` bigint DEFAULT NULL,
  `source_partner_id` bigint DEFAULT NULL,
  `partner_source_type` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_users_tg_user_id` (`tg_user_id`),
  UNIQUE KEY `max_user_id` (`max_user_id`),
  KEY `idx_users_inn` (`inn`),
  KEY `idx_users_phone` (`phone`),
  KEY `fk_users_referral_code` (`referral_code_id`),
  KEY `ix_users_added_by_partner` (`added_by_partner_id`),
  KEY `ix_users_source_partner` (`source_partner_id`),
  KEY `ix_users_partner_source_type` (`partner_source_type`),
  CONSTRAINT `fk_users_referral_code` FOREIGN KEY (`referral_code_id`) REFERENCES `referral_codes` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`, `tg_user_id`, `max_user_id`, `first_name`, `last_name`, `phone`, `email`, `tg_username`, `inn`, `org_name`, `kpp`, `city`, `birth_date`, `amo_company_id`, `consent_accepted`, `consent_accepted_at`, `is_verified`, `created_at`, `updated_at`, `referral_code_id`, `address`, `kkt_factory_number`, `we_added`, `added_by_specialist_id`, `added_by_partner_id`, `source_partner_id`, `partner_source_type`) VALUES (1,NULL,NULL,'Анна','Примерова','+70000010001','client01@demo.example',NULL,'000000000001','ООО «Демо Маркет»',NULL,'Москва',NULL,NULL,0,NULL,1,'2026-10-04 12:58:43','2026-10-06 12:58:43',NULL,'Москва, Демо улица, 1',NULL,1,1,NULL,NULL,NULL),(2,NULL,NULL,'Михаил','Тестов','+70000010002','client02@demo.example',NULL,'000000000002','ООО «Пример Сервис»',NULL,'Казань',NULL,NULL,0,NULL,1,'2026-10-01 12:58:43','2026-10-05 12:58:43',NULL,'Казань, Демо улица, 2',NULL,1,1,NULL,NULL,NULL),(3,NULL,NULL,'Елена','Демина','+70000010003','client03@demo.example',NULL,'000000000003','ООО «Макет Торг»',NULL,'Тверь',NULL,NULL,0,NULL,1,'2026-09-28 12:58:43','2026-10-04 12:58:43',NULL,'Тверь, Демо улица, 3',NULL,1,1,NULL,NULL,NULL),(4,NULL,NULL,'Павел','Образцов','+70000010004','client04@demo.example',NULL,'000000000004','ООО «Тест Кафе»',NULL,'Самара',NULL,NULL,0,NULL,0,'2026-09-25 12:58:43','2026-10-03 12:58:43',NULL,'Самара, Демо улица, 4',NULL,1,1,NULL,NULL,NULL),(5,NULL,NULL,'Мария','Модельная','+70000010005','client05@demo.example',NULL,'000000000005','ООО «Учебный Склад»',NULL,'Пермь',NULL,NULL,0,NULL,1,'2026-09-22 12:58:43','2026-10-02 12:58:43',NULL,'Пермь, Демо улица, 5',NULL,1,1,NULL,NULL,NULL),(6,NULL,NULL,'Игорь','Учебный','+70000010006','client06@demo.example',NULL,'000000000006','ООО «Сценарий»',NULL,'Тула',NULL,NULL,0,NULL,1,'2026-09-19 12:58:43','2026-10-01 12:58:43',NULL,'Тула, Демо улица, 6',NULL,1,1,NULL,NULL,NULL),(7,NULL,NULL,'Ольга','Вымышленная','+70000010007','client07@demo.example',NULL,'000000000007','ООО «Витрина»',NULL,'Калуга',NULL,NULL,0,NULL,1,'2026-09-16 12:58:43','2026-09-30 12:58:43',NULL,'Калуга, Демо улица, 7',NULL,1,1,NULL,NULL,NULL),(8,NULL,NULL,'Денис','Пробный','+70000010008','client08@demo.example',NULL,'000000000008','ООО «Образец Плюс»',NULL,'Воронеж',NULL,NULL,0,NULL,0,'2026-09-13 12:58:43','2026-09-29 12:58:43',NULL,'Воронеж, Демо улица, 8',NULL,1,1,NULL,NULL,NULL),(9,NULL,NULL,'Наталья','Макетова','+70000010009','client09@demo.example',NULL,'000000000009','ООО «Проба»',NULL,'Москва',NULL,NULL,0,NULL,1,'2026-09-10 12:58:43','2026-10-07 12:58:43',NULL,'Москва, Демо улица, 9',NULL,1,1,NULL,NULL,NULL),(10,NULL,NULL,'Артём','Демонстрационный','+70000010010','client10@demo.example',NULL,'000000000010','ООО «Демо Логистика»',NULL,'Казань',NULL,NULL,0,NULL,1,'2026-09-07 12:58:43','2026-10-06 12:58:43',NULL,'Казань, Демо улица, 10',NULL,1,1,NULL,NULL,NULL),(11,NULL,NULL,'Вера','Сценарная','+70000010011','client11@demo.example',NULL,'000000000011','ООО «Демо Маркет»',NULL,'Тверь',NULL,NULL,0,NULL,1,'2026-09-04 12:58:43','2026-10-05 12:58:43',NULL,'Тверь, Демо улица, 11',NULL,1,1,NULL,NULL,NULL),(12,NULL,NULL,'Роман','Тестовый','+70000010012','client12@demo.example',NULL,'000000000012','ООО «Пример Сервис»',NULL,'Самара',NULL,NULL,0,NULL,0,'2026-09-01 12:58:43','2026-10-04 12:58:43',NULL,'Самара, Демо улица, 12',NULL,1,1,NULL,NULL,NULL),(13,NULL,NULL,'Анна','Примерова','+70000010013','client13@demo.example',NULL,'000000000013','ООО «Макет Торг»',NULL,'Пермь',NULL,NULL,0,NULL,1,'2026-08-29 12:58:43','2026-10-03 12:58:43',NULL,'Пермь, Демо улица, 13',NULL,1,1,NULL,NULL,NULL),(14,NULL,NULL,'Михаил','Тестов','+70000010014','client14@demo.example',NULL,'000000000014','ООО «Тест Кафе»',NULL,'Тула',NULL,NULL,0,NULL,1,'2026-08-26 12:58:43','2026-10-02 12:58:43',NULL,'Тула, Демо улица, 14',NULL,1,1,NULL,NULL,NULL),(15,NULL,NULL,'Елена','Демина','+70000010015','client15@demo.example',NULL,'000000000015','ООО «Учебный Склад»',NULL,'Калуга',NULL,NULL,0,NULL,1,'2026-08-23 12:58:43','2026-10-01 12:58:43',NULL,'Калуга, Демо улица, 15',NULL,1,1,NULL,NULL,NULL),(16,NULL,NULL,'Павел','Образцов','+70000010016','client16@demo.example',NULL,'000000000016','ООО «Сценарий»',NULL,'Воронеж',NULL,NULL,0,NULL,0,'2026-08-20 12:58:43','2026-09-30 12:58:43',NULL,'Воронеж, Демо улица, 16',NULL,1,1,NULL,NULL,NULL),(17,NULL,NULL,'Мария','Модельная','+70000010017','client17@demo.example',NULL,'000000000017','ООО «Витрина»',NULL,'Москва',NULL,NULL,0,NULL,1,'2026-08-17 12:58:43','2026-09-29 12:58:43',NULL,'Москва, Демо улица, 17',NULL,1,1,NULL,NULL,NULL),(18,NULL,NULL,'Игорь','Учебный','+70000010018','client18@demo.example',NULL,'000000000018','ООО «Образец Плюс»',NULL,'Казань',NULL,NULL,0,NULL,1,'2026-08-14 12:58:43','2026-10-07 12:58:43',NULL,'Казань, Демо улица, 18',NULL,1,1,NULL,NULL,NULL),(19,NULL,NULL,'Ольга','Вымышленная','+70000010019','client19@demo.example',NULL,'000000000019','ООО «Проба»',NULL,'Тверь',NULL,NULL,0,NULL,1,'2026-08-11 12:58:43','2026-10-06 12:58:43',NULL,'Тверь, Демо улица, 19',NULL,1,1,NULL,NULL,NULL),(20,NULL,NULL,'Денис','Пробный','+70000010020','client20@demo.example',NULL,'000000000020','ООО «Демо Логистика»',NULL,'Самара',NULL,NULL,0,NULL,0,'2026-08-08 12:58:43','2026-10-05 12:58:43',NULL,'Самара, Демо улица, 20',NULL,1,1,NULL,NULL,NULL),(21,NULL,NULL,'Наталья','Макетова','+70000010021','client21@demo.example',NULL,'000000000021','ООО «Демо Маркет»',NULL,'Пермь',NULL,NULL,0,NULL,1,'2026-08-05 12:58:43','2026-10-04 12:58:43',NULL,'Пермь, Демо улица, 21',NULL,1,1,NULL,NULL,NULL),(22,NULL,NULL,'Артём','Демонстрационный','+70000010022','client22@demo.example',NULL,'000000000022','ООО «Пример Сервис»',NULL,'Тула',NULL,NULL,0,NULL,1,'2026-08-02 12:58:43','2026-10-03 12:58:43',NULL,'Тула, Демо улица, 22',NULL,1,1,NULL,NULL,NULL),(23,NULL,NULL,'Вера','Сценарная','+70000010023','client23@demo.example',NULL,'000000000023','ООО «Макет Торг»',NULL,'Калуга',NULL,NULL,0,NULL,1,'2026-07-30 12:58:43','2026-10-02 12:58:43',NULL,'Калуга, Демо улица, 23',NULL,1,1,NULL,NULL,NULL),(24,NULL,NULL,'Роман','Тестовый','+70000010024','client24@demo.example',NULL,'000000000024','ООО «Тест Кафе»',NULL,'Воронеж',NULL,NULL,0,NULL,0,'2026-07-27 12:58:43','2026-10-01 12:58:43',NULL,'Воронеж, Демо улица, 24',NULL,1,1,NULL,NULL,NULL),(25,NULL,NULL,'Анна','Примерова','+70000010025','client25@demo.example',NULL,'000000000025','ООО «Учебный Склад»',NULL,'Москва',NULL,NULL,0,NULL,1,'2026-07-24 12:58:43','2026-09-30 12:58:43',NULL,'Москва, Демо улица, 25',NULL,1,1,NULL,NULL,NULL),(26,NULL,NULL,'Михаил','Тестов','+70000010026','client26@demo.example',NULL,'000000000026','ООО «Сценарий»',NULL,'Казань',NULL,NULL,0,NULL,1,'2026-07-21 12:58:43','2026-09-29 12:58:43',NULL,'Казань, Демо улица, 26',NULL,1,1,NULL,NULL,NULL),(27,NULL,NULL,'Елена','Демина','+70000010027','client27@demo.example',NULL,'000000000027','ООО «Витрина»',NULL,'Тверь',NULL,NULL,0,NULL,1,'2026-07-18 12:58:43','2026-10-07 12:58:43',NULL,'Тверь, Демо улица, 27',NULL,1,1,NULL,NULL,NULL),(28,NULL,NULL,'Павел','Образцов','+70000010028','client28@demo.example',NULL,'000000000028','ООО «Образец Плюс»',NULL,'Самара',NULL,NULL,0,NULL,0,'2026-07-15 12:58:43','2026-10-06 12:58:43',NULL,'Самара, Демо улица, 28',NULL,1,1,NULL,NULL,NULL),(29,NULL,NULL,'Мария','Модельная','+70000010029','client29@demo.example',NULL,'000000000029','ООО «Проба»',NULL,'Пермь',NULL,NULL,0,NULL,1,'2026-07-12 12:58:43','2026-10-05 12:58:43',NULL,'Пермь, Демо улица, 29',NULL,1,1,NULL,NULL,NULL),(30,NULL,NULL,'Игорь','Учебный','+70000010030','client30@demo.example',NULL,'000000000030','ООО «Демо Логистика»',NULL,'Тула',NULL,NULL,0,NULL,1,'2026-07-09 12:58:43','2026-10-04 12:58:43',NULL,'Тула, Демо улица, 30',NULL,1,1,NULL,NULL,NULL),(31,NULL,NULL,'Ольга','Вымышленная','+70000010031','client31@demo.example',NULL,'000000000031','ООО «Демо Маркет»',NULL,'Калуга',NULL,NULL,0,NULL,1,'2026-07-06 12:58:43','2026-10-03 12:58:43',NULL,'Калуга, Демо улица, 31',NULL,1,1,NULL,NULL,NULL),(32,NULL,NULL,'Денис','Пробный','+70000010032','client32@demo.example',NULL,'000000000032','ООО «Пример Сервис»',NULL,'Воронеж',NULL,NULL,0,NULL,0,'2026-07-03 12:58:43','2026-10-02 12:58:43',NULL,'Воронеж, Демо улица, 32',NULL,1,1,NULL,NULL,NULL),(33,NULL,NULL,'Наталья','Макетова','+70000010033','client33@demo.example',NULL,'000000000033','ООО «Макет Торг»',NULL,'Москва',NULL,NULL,0,NULL,1,'2026-06-30 12:58:43','2026-10-01 12:58:43',NULL,'Москва, Демо улица, 33',NULL,1,1,NULL,NULL,NULL),(34,NULL,NULL,'Артём','Демонстрационный','+70000010034','client34@demo.example',NULL,'000000000034','ООО «Тест Кафе»',NULL,'Казань',NULL,NULL,0,NULL,1,'2026-06-27 12:58:43','2026-09-30 12:58:43',NULL,'Казань, Демо улица, 34',NULL,1,1,NULL,NULL,NULL),(35,NULL,NULL,'Вера','Сценарная','+70000010035','client35@demo.example',NULL,'000000000035','ООО «Учебный Склад»',NULL,'Тверь',NULL,NULL,0,NULL,1,'2026-06-24 12:58:43','2026-09-29 12:58:43',NULL,'Тверь, Демо улица, 35',NULL,1,1,NULL,NULL,NULL),(36,NULL,NULL,'Роман','Тестовый','+70000010036','client36@demo.example',NULL,'000000000036','ООО «Сценарий»',NULL,'Самара',NULL,NULL,0,NULL,0,'2026-06-21 12:58:43','2026-10-07 12:58:43',NULL,'Самара, Демо улица, 36',NULL,1,1,NULL,NULL,NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
