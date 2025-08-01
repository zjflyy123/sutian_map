--
-- 创建数据库，并切换至当前数据库
--
CREATE DATABASE `x1_community` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE x1_community;
SET NAMES utf8mb4;
SET GLOBAL host_cache_size=0;

-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: 192.168.6.101    Database: x1_community
-- ------------------------------------------------------
-- Server version	8.0.41

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
-- Table structure for table `class`
--

DROP TABLE IF EXISTS `class`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `class` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `ontology_id` bigint NOT NULL,
  `name` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `color` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `tool_type` enum('POLYGON','BOUNDING_BOX','POLYLINE','KEY_POINT','SEGMENTATION','CUBOID') CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `tool_type_options` json DEFAULT NULL,
  `attributes` json DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` bigint NOT NULL,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` bigint DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_ontology_id_name_tool_type` (`ontology_id`,`name`,`tool_type`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `class`
--

LOCK TABLES `class` WRITE;
/*!40000 ALTER TABLE `class` DISABLE KEYS */;
INSERT INTO `class` VALUES (1,1,'big_car1','#faef2c','CUBOID','{\"width\": [null, null], \"height\": [null, null], \"length\": [null, null], \"isStandard\": false, \"isConstraints\": false}','[]','2024-06-15 16:02:05',58,'2025-04-08 17:00:27',60),(2,1,'pedestrian','#8177f5','CUBOID','{\"width\": [null, null], \"height\": [null, null], \"length\": [null, null], \"isStandard\": false, \"isConstraints\": false}','[]','2024-06-15 16:02:24',58,NULL,NULL),(3,1,'small_car','#de7ef6','CUBOID','{\"width\": [null, null], \"height\": [null, null], \"length\": [null, null], \"isStandard\": false, \"isConstraints\": false}','[]','2024-06-15 16:02:33',58,NULL,NULL),(4,1,'two_wheel','#7ff0b3','CUBOID','{\"width\": [null, null], \"height\": [null, null], \"length\": [null, null], \"isStandard\": false, \"isConstraints\": false}','[]','2024-06-15 16:02:50',58,NULL,NULL),(5,2,'障碍物','#7dfaf2','CUBOID','{\"width\": [null, null], \"height\": [null, null], \"length\": [null, null], \"isStandard\": false, \"isConstraints\": false}','[]','2025-04-08 17:18:12',60,NULL,NULL),(6,2,'交通灯','#7dfaf2','CUBOID','{\"width\": [null, null], \"height\": [null, null], \"length\": [null, null], \"isStandard\": false, \"isConstraints\": false}','[]','2025-04-08 17:18:18',60,NULL,NULL),(7,2,'交通标志牌','#7dfaf2','CUBOID','{\"width\": [null, null], \"height\": [null, null], \"length\": [null, null], \"isStandard\": false, \"isConstraints\": false}','[]','2025-04-08 17:18:24',60,NULL,NULL),(8,2,'其它','#7dfaf2','CUBOID','{\"width\": [null, null], \"height\": [null, null], \"length\": [null, null], \"isStandard\": false, \"isConstraints\": false}','[]','2025-04-08 17:18:36',60,NULL,NULL);
/*!40000 ALTER TABLE `class` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `classification`
--

DROP TABLE IF EXISTS `classification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `classification` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `ontology_id` bigint NOT NULL,
  `name` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `is_required` bit(1) NOT NULL DEFAULT b'0',
  `input_type` enum('RADIO','TEXT','MULTI_SELECTION','DROPDOWN','LONG_TEXT') CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `attribute` json DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` bigint NOT NULL,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` bigint DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_ontology_id_name` (`ontology_id`,`name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `classification`
--

LOCK TABLES `classification` WRITE;
/*!40000 ALTER TABLE `classification` DISABLE KEYS */;
INSERT INTO `classification` VALUES (1,1,'classification1',0x01,'RADIO','{\"id\": \"8e4395d6-904b-4575-9679-c2c86616d4f2\", \"name\": \"classification1\", \"type\": \"RADIO\", \"options\": [], \"required\": true}','2025-04-08 17:02:46',60,NULL,NULL);
/*!40000 ALTER TABLE `classification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data`
--

DROP TABLE IF EXISTS `data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `data` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'Primary key',
  `dataset_id` bigint DEFAULT NULL COMMENT 'Dataset id',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'Data name',
  `content` json DEFAULT NULL COMMENT 'Content (folder path, version information)',
  `status` enum('INVALID','VALID') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT 'VALID' COMMENT 'Data status INVALID,VALID',
  `annotation_status` enum('ANNOTATED','NOT_ANNOTATED','INVALID') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT 'NOT_ANNOTATED' COMMENT 'Data annotation status ANNOTATED, NOT_ANNOTATED, INVALID',
  `split_type` enum('TRAINING','VALIDATION','TEST','NOT_SPLIT') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT 'NOT_SPLIT' COMMENT 'Split type',
  `is_deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT 'Is deleted',
  `del_unique_key` bigint NOT NULL DEFAULT '0' COMMENT '删除唯一标志，写入时为0，逻辑删除后置为主键id',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Create time',
  `created_by` bigint DEFAULT NULL COMMENT 'Creator id',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Update time',
  `updated_by` bigint DEFAULT NULL COMMENT 'Modify person id',
  `type` enum('SINGLE_DATA','SCENE') CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT 'SINGLE_DATA' COMMENT 'Type (indicates continuous frames, non-consecutive frames)',
  `order_name` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'Sort data name',
  `parent_id` bigint NOT NULL DEFAULT '0' COMMENT 'Parent ID (Scene ID)',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_dataset_id_name` (`dataset_id`,`name`,`del_unique_key`) USING BTREE,
  KEY `idx_dataset_id_created_at` (`dataset_id`,`created_at`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3987 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='Data';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data`
--

LOCK TABLES `data` WRITE;
/*!40000 ALTER TABLE `data` DISABLE KEYS */;
INSERT INTO `data` VALUES (3950,17,'Scene_01',NULL,'VALID','NOT_ANNOTATED','NOT_SPLIT',0x00,3950,'2025-04-11 10:41:05',62,'2025-04-14 10:05:12',NULL,'SCENE','Scene_0011998',0),(3951,17,'13','[{\"name\": \"camera_config\", \"type\": \"directory\", \"files\": [{\"name\": \"13.json\", \"type\": \"file\", \"files\": null, \"fileId\": 125559}], \"fileId\": null}, {\"name\": \"camera_image_0\", \"type\": \"directory\", \"files\": [{\"name\": \"13.jpg\", \"type\": \"file\", \"files\": null, \"fileId\": 125561}], \"fileId\": null}, {\"name\": \"camera_image_1\", \"type\": \"directory\", \"files\": [{\"name\": \"13.jpg\", \"type\": \"file\", \"files\": null, \"fileId\": 125562}], \"fileId\": null}, {\"name\": \"camera_image_2\", \"type\": \"directory\", \"files\": [{\"name\": \"13.jpg\", \"type\": \"file\", \"files\": null, \"fileId\": 125564}], \"fileId\": null}, {\"name\": \"camera_image_3\", \"type\": \"directory\", \"files\": [{\"name\": \"13.jpg\", \"type\": \"file\", \"files\": null, \"fileId\": 125565}], \"fileId\": null}, {\"name\": \"lidar_point_cloud_0\", \"type\": \"directory\", \"files\": [{\"name\": \"13.pcd\", \"type\": \"file\", \"files\": null, \"fileId\": 125569}], \"fileId\": null}]','VALID','NOT_ANNOTATED','NOT_SPLIT',0x00,0,'2025-04-11 10:41:05',62,'2025-04-11 10:41:05',NULL,'SINGLE_DATA','00213999',3950),(3952,17,'14','[{\"name\": \"camera_config\", \"type\": \"directory\", \"files\": [{\"name\": \"14.json\", \"type\": \"file\", \"files\": null, \"fileId\": 125595}], \"fileId\": null}, {\"name\": \"camera_image_0\", \"type\": \"directory\", \"files\": [{\"name\": \"14.jpg\", \"type\": \"file\", \"files\": null, \"fileId\": 125598}], \"fileId\": null}, {\"name\": \"camera_image_1\", \"type\": \"directory\", \"files\": [{\"name\": \"14.jpg\", \"type\": \"file\", \"files\": null, \"fileId\": 125599}], \"fileId\": null}, {\"name\": \"camera_image_2\", \"type\": \"directory\", \"files\": [{\"name\": \"14.jpg\", \"type\": \"file\", \"files\": null, \"fileId\": 125601}], \"fileId\": null}, {\"name\": \"camera_image_3\", \"type\": \"directory\", \"files\": [{\"name\": \"14.jpg\", \"type\": \"file\", \"files\": null, \"fileId\": 125603}], \"fileId\": null}, {\"name\": \"lidar_point_cloud_0\", \"type\": \"directory\", \"files\": [{\"name\": \"14.pcd\", \"type\": \"file\", \"files\": null, \"fileId\": 125606}], \"fileId\": null}]','VALID','NOT_ANNOTATED','NOT_SPLIT',0x00,0,'2025-04-11 10:41:05',62,'2025-04-11 10:41:05',NULL,'SINGLE_DATA','00214999',3950),(3953,17,'15','[{\"name\": \"camera_config\", \"type\": \"directory\", \"files\": [{\"name\": \"15.json\", \"type\": \"file\", \"files\": null, \"fileId\": 125631}], \"fileId\": null}, {\"name\": \"camera_image_0\", \"type\": \"directory\", \"files\": [{\"name\": \"15.jpg\", \"type\": \"file\", \"files\": null, \"fileId\": 125632}], \"fileId\": null}, {\"name\": \"camera_image_1\", \"type\": \"directory\", \"files\": [{\"name\": \"15.jpg\", \"type\": \"file\", \"files\": null, \"fileId\": 125633}], \"fileId\": null}, {\"name\": \"camera_image_2\", \"type\": \"directory\", \"files\": [{\"name\": \"15.jpg\", \"type\": \"file\", \"files\": null, \"fileId\": 125634}], \"fileId\": null}, {\"name\": \"camera_image_3\", \"type\": \"directory\", \"files\": [{\"name\": \"15.jpg\", \"type\": \"file\", \"files\": null, \"fileId\": 125635}], \"fileId\": null}, {\"name\": \"lidar_point_cloud_0\", \"type\": \"directory\", \"files\": [{\"name\": \"15.pcd\", \"type\": \"file\", \"files\": null, \"fileId\": 125636}], \"fileId\": null}]','VALID','NOT_ANNOTATED','NOT_SPLIT',0x00,0,'2025-04-11 10:41:05',62,'2025-04-11 10:41:05',NULL,'SINGLE_DATA','00215999',3950),(3954,17,'08','[{\"name\": \"camera_config\", \"type\": \"directory\", \"files\": [{\"name\": \"08.json\", \"type\": \"file\", \"files\": null, \"fileId\": 125560}], \"fileId\": null}, {\"name\": \"camera_image_0\", \"type\": \"directory\", \"files\": [{\"name\": \"08.jpg\", \"type\": \"file\", \"files\": null, \"fileId\": 125563}], \"fileId\": null}, {\"name\": \"camera_image_1\", \"type\": \"directory\", \"files\": [{\"name\": \"08.jpg\", \"type\": \"file\", \"files\": null, \"fileId\": 125566}], \"fileId\": null}, {\"name\": \"camera_image_2\", \"type\": \"directory\", \"files\": [{\"name\": \"08.jpg\", \"type\": \"file\", \"files\": null, \"fileId\": 125567}], \"fileId\": null}, {\"name\": \"camera_image_3\", \"type\": \"directory\", \"files\": [{\"name\": \"08.jpg\", \"type\": \"file\", \"files\": null, \"fileId\": 125568}], \"fileId\": null}, {\"name\": \"lidar_point_cloud_0\", \"type\": \"directory\", \"files\": [{\"name\": \"08.pcd\", \"type\": \"file\", \"files\": null, \"fileId\": 125570}], \"fileId\": null}]','VALID','NOT_ANNOTATED','NOT_SPLIT',0x00,0,'2025-04-11 10:41:05',62,'2025-04-11 10:41:05',NULL,'SINGLE_DATA','0018998',3950),(3955,17,'09','[{\"name\": \"camera_config\", \"type\": \"directory\", \"files\": [{\"name\": \"09.json\", \"type\": \"file\", \"files\": null, \"fileId\": 125596}], \"fileId\": null}, {\"name\": \"camera_image_0\", \"type\": \"directory\", \"files\": [{\"name\": \"09.jpg\", \"type\": \"file\", \"files\": null, \"fileId\": 125597}], \"fileId\": null}, {\"name\": \"camera_image_1\", \"type\": \"directory\", \"files\": [{\"name\": \"09.jpg\", \"type\": \"file\", \"files\": null, \"fileId\": 125600}], \"fileId\": null}, {\"name\": \"camera_image_2\", \"type\": \"directory\", \"files\": [{\"name\": \"09.jpg\", \"type\": \"file\", \"files\": null, \"fileId\": 125602}], \"fileId\": null}, {\"name\": \"camera_image_3\", \"type\": \"directory\", \"files\": [{\"name\": \"09.jpg\", \"type\": \"file\", \"files\": null, \"fileId\": 125604}], \"fileId\": null}, {\"name\": \"lidar_point_cloud_0\", \"type\": \"directory\", \"files\": [{\"name\": \"09.pcd\", \"type\": \"file\", \"files\": null, \"fileId\": 125605}], \"fileId\": null}]','VALID','NOT_ANNOTATED','NOT_SPLIT',0x00,0,'2025-04-11 10:41:05',62,'2025-04-11 10:41:05',NULL,'SINGLE_DATA','0019998',3950),(3956,17,'10','[{\"name\": \"camera_config\", \"type\": \"directory\", \"files\": [{\"name\": \"10.json\", \"type\": \"file\", \"files\": null, \"fileId\": 125637}], \"fileId\": null}, {\"name\": \"camera_image_0\", \"type\": \"directory\", \"files\": [{\"name\": \"10.jpg\", \"type\": \"file\", \"files\": null, \"fileId\": 125638}], \"fileId\": null}, {\"name\": \"camera_image_1\", \"type\": \"directory\", \"files\": [{\"name\": \"10.jpg\", \"type\": \"file\", \"files\": null, \"fileId\": 125639}], \"fileId\": null}, {\"name\": \"camera_image_2\", \"type\": \"directory\", \"files\": [{\"name\": \"10.jpg\", \"type\": \"file\", \"files\": null, \"fileId\": 125640}], \"fileId\": null}, {\"name\": \"camera_image_3\", \"type\": \"directory\", \"files\": [{\"name\": \"10.jpg\", \"type\": \"file\", \"files\": null, \"fileId\": 125641}], \"fileId\": null}, {\"name\": \"lidar_point_cloud_0\", \"type\": \"directory\", \"files\": [{\"name\": \"10.pcd\", \"type\": \"file\", \"files\": null, \"fileId\": 125642}], \"fileId\": null}]','VALID','NOT_ANNOTATED','NOT_SPLIT',0x00,0,'2025-04-11 10:41:05',62,'2025-04-11 10:41:05',NULL,'SINGLE_DATA','00210999',3950),(3957,17,'11','[{\"name\": \"camera_config\", \"type\": \"directory\", \"files\": [{\"name\": \"11.json\", \"type\": \"file\", \"files\": null, \"fileId\": 125667}], \"fileId\": null}, {\"name\": \"camera_image_0\", \"type\": \"directory\", \"files\": [{\"name\": \"11.jpg\", \"type\": \"file\", \"files\": null, \"fileId\": 125668}], \"fileId\": null}, {\"name\": \"camera_image_1\", \"type\": \"directory\", \"files\": [{\"name\": \"11.jpg\", \"type\": \"file\", \"files\": null, \"fileId\": 125669}], \"fileId\": null}, {\"name\": \"camera_image_2\", \"type\": \"directory\", \"files\": [{\"name\": \"11.jpg\", \"type\": \"file\", \"files\": null, \"fileId\": 125670}], \"fileId\": null}, {\"name\": \"camera_image_3\", \"type\": \"directory\", \"files\": [{\"name\": \"11.jpg\", \"type\": \"file\", \"files\": null, \"fileId\": 125671}], \"fileId\": null}, {\"name\": \"lidar_point_cloud_0\", \"type\": \"directory\", \"files\": [{\"name\": \"11.pcd\", \"type\": \"file\", \"files\": null, \"fileId\": 125672}], \"fileId\": null}]','VALID','NOT_ANNOTATED','NOT_SPLIT',0x00,0,'2025-04-11 10:41:05',62,'2025-04-11 10:41:05',NULL,'SINGLE_DATA','00211999',3950),(3958,17,'12','[{\"name\": \"camera_config\", \"type\": \"directory\", \"files\": [{\"name\": \"12.json\", \"type\": \"file\", \"files\": null, \"fileId\": 125685}], \"fileId\": null}, {\"name\": \"camera_image_0\", \"type\": \"directory\", \"files\": [{\"name\": \"12.jpg\", \"type\": \"file\", \"files\": null, \"fileId\": 125686}], \"fileId\": null}, {\"name\": \"camera_image_1\", \"type\": \"directory\", \"files\": [{\"name\": \"12.jpg\", \"type\": \"file\", \"files\": null, \"fileId\": 125687}], \"fileId\": null}, {\"name\": \"camera_image_2\", \"type\": \"directory\", \"files\": [{\"name\": \"12.jpg\", \"type\": \"file\", \"files\": null, \"fileId\": 125688}], \"fileId\": null}, {\"name\": \"camera_image_3\", \"type\": \"directory\", \"files\": [{\"name\": \"12.jpg\", \"type\": \"file\", \"files\": null, \"fileId\": 125689}], \"fileId\": null}, {\"name\": \"lidar_point_cloud_0\", \"type\": \"directory\", \"files\": [{\"name\": \"12.pcd\", \"type\": \"file\", \"files\": null, \"fileId\": 125690}], \"fileId\": null}]','VALID','NOT_ANNOTATED','NOT_SPLIT',0x00,0,'2025-04-11 10:41:05',62,'2025-04-11 10:41:05',NULL,'SINGLE_DATA','00212999',3950),(3959,20,'Scene_01',NULL,'VALID','NOT_ANNOTATED','NOT_SPLIT',0x00,0,'2025-04-11 11:07:21',62,'2025-04-11 11:07:20',NULL,'SCENE','Scene_0011998',0),(3960,20,'13','[{\"name\": \"lidar_point_cloud_0\", \"type\": \"directory\", \"files\": [{\"name\": \"13.pcd\", \"type\": \"file\", \"files\": null, \"fileId\": 125703}], \"fileId\": null}]','VALID','NOT_ANNOTATED','NOT_SPLIT',0x00,0,'2025-04-11 11:07:21',62,'2025-04-11 11:07:21',NULL,'SINGLE_DATA','00213999',3959),(3961,20,'14','[{\"name\": \"lidar_point_cloud_0\", \"type\": \"directory\", \"files\": [{\"name\": \"14.pcd\", \"type\": \"file\", \"files\": null, \"fileId\": 125705}], \"fileId\": null}]','VALID','NOT_ANNOTATED','NOT_SPLIT',0x00,0,'2025-04-11 11:07:21',62,'2025-04-11 11:07:21',NULL,'SINGLE_DATA','00214999',3959),(3962,20,'15','[{\"name\": \"lidar_point_cloud_0\", \"type\": \"directory\", \"files\": [{\"name\": \"15.pcd\", \"type\": \"file\", \"files\": null, \"fileId\": 125708}], \"fileId\": null}]','VALID','NOT_ANNOTATED','NOT_SPLIT',0x00,0,'2025-04-11 11:07:21',62,'2025-04-11 11:07:21',NULL,'SINGLE_DATA','00215999',3959),(3963,20,'08','[{\"name\": \"lidar_point_cloud_0\", \"type\": \"directory\", \"files\": [{\"name\": \"08.pcd\", \"type\": \"file\", \"files\": null, \"fileId\": 125704}], \"fileId\": null}]','VALID','NOT_ANNOTATED','NOT_SPLIT',0x00,0,'2025-04-11 11:07:21',62,'2025-04-11 11:07:21',NULL,'SINGLE_DATA','0018998',3959),(3964,20,'09','[{\"name\": \"lidar_point_cloud_0\", \"type\": \"directory\", \"files\": [{\"name\": \"09.pcd\", \"type\": \"file\", \"files\": null, \"fileId\": 125706}], \"fileId\": null}]','VALID','NOT_ANNOTATED','NOT_SPLIT',0x00,0,'2025-04-11 11:07:21',62,'2025-04-11 11:07:21',NULL,'SINGLE_DATA','0019998',3959),(3965,20,'10','[{\"name\": \"lidar_point_cloud_0\", \"type\": \"directory\", \"files\": [{\"name\": \"10.pcd\", \"type\": \"file\", \"files\": null, \"fileId\": 125707}], \"fileId\": null}]','VALID','NOT_ANNOTATED','NOT_SPLIT',0x00,0,'2025-04-11 11:07:21',62,'2025-04-11 11:07:21',NULL,'SINGLE_DATA','00210999',3959),(3966,20,'11','[{\"name\": \"lidar_point_cloud_0\", \"type\": \"directory\", \"files\": [{\"name\": \"11.pcd\", \"type\": \"file\", \"files\": null, \"fileId\": 125709}], \"fileId\": null}]','VALID','NOT_ANNOTATED','NOT_SPLIT',0x00,0,'2025-04-11 11:07:21',62,'2025-04-11 11:07:21',NULL,'SINGLE_DATA','00211999',3959),(3967,20,'12','[{\"name\": \"lidar_point_cloud_0\", \"type\": \"directory\", \"files\": [{\"name\": \"12.pcd\", \"type\": \"file\", \"files\": null, \"fileId\": 125710}], \"fileId\": null}]','VALID','NOT_ANNOTATED','NOT_SPLIT',0x00,0,'2025-04-11 11:07:21',62,'2025-04-11 11:07:21',NULL,'SINGLE_DATA','00212999',3959),(3978,21,'Scene_01',NULL,'VALID','NOT_ANNOTATED','NOT_SPLIT',0x00,0,'2025-04-11 16:26:20',62,'2025-04-11 16:26:20',NULL,'SCENE','Scene_0011998',0),(3979,21,'13','[{\"name\": \"lidar_point_cloud_0\", \"type\": \"directory\", \"files\": [{\"name\": \"13.pcd\", \"type\": \"file\", \"files\": null, \"fileId\": 125719}], \"fileId\": null}]','VALID','NOT_ANNOTATED','NOT_SPLIT',0x00,0,'2025-04-11 16:26:20',62,'2025-04-11 16:26:20',NULL,'SINGLE_DATA','00213999',3978),(3980,21,'14','[{\"name\": \"lidar_point_cloud_0\", \"type\": \"directory\", \"files\": [{\"name\": \"14.pcd\", \"type\": \"file\", \"files\": null, \"fileId\": 125722}], \"fileId\": null}]','VALID','NOT_ANNOTATED','NOT_SPLIT',0x00,0,'2025-04-11 16:26:20',62,'2025-04-11 16:26:20',NULL,'SINGLE_DATA','00214999',3978),(3981,21,'15','[{\"name\": \"lidar_point_cloud_0\", \"type\": \"directory\", \"files\": [{\"name\": \"15.pcd\", \"type\": \"file\", \"files\": null, \"fileId\": 125724}], \"fileId\": null}]','VALID','NOT_ANNOTATED','NOT_SPLIT',0x00,0,'2025-04-11 16:26:20',62,'2025-04-11 16:26:20',NULL,'SINGLE_DATA','00215999',3978),(3982,21,'08','[{\"name\": \"lidar_point_cloud_0\", \"type\": \"directory\", \"files\": [{\"name\": \"08.pcd\", \"type\": \"file\", \"files\": null, \"fileId\": 125720}], \"fileId\": null}]','VALID','ANNOTATED','NOT_SPLIT',0x00,0,'2025-04-11 16:26:20',62,'2025-07-16 17:19:57',60,'SINGLE_DATA','0018998',3978),(3983,21,'09','[{\"name\": \"lidar_point_cloud_0\", \"type\": \"directory\", \"files\": [{\"name\": \"09.pcd\", \"type\": \"file\", \"files\": null, \"fileId\": 125721}], \"fileId\": null}]','VALID','ANNOTATED','NOT_SPLIT',0x00,0,'2025-04-11 16:26:20',62,'2025-04-14 15:48:04',62,'SINGLE_DATA','0019998',3978),(3984,21,'10','[{\"name\": \"lidar_point_cloud_0\", \"type\": \"directory\", \"files\": [{\"name\": \"10.pcd\", \"type\": \"file\", \"files\": null, \"fileId\": 125723}], \"fileId\": null}]','VALID','NOT_ANNOTATED','NOT_SPLIT',0x00,0,'2025-04-11 16:26:20',62,'2025-04-11 16:26:20',NULL,'SINGLE_DATA','00210999',3978),(3985,21,'11','[{\"name\": \"lidar_point_cloud_0\", \"type\": \"directory\", \"files\": [{\"name\": \"11.pcd\", \"type\": \"file\", \"files\": null, \"fileId\": 125725}], \"fileId\": null}]','VALID','NOT_ANNOTATED','NOT_SPLIT',0x00,0,'2025-04-11 16:26:20',62,'2025-04-11 16:26:20',NULL,'SINGLE_DATA','00211999',3978),(3986,21,'12','[{\"name\": \"lidar_point_cloud_0\", \"type\": \"directory\", \"files\": [{\"name\": \"12.pcd\", \"type\": \"file\", \"files\": null, \"fileId\": 125726}], \"fileId\": null}]','VALID','NOT_ANNOTATED','NOT_SPLIT',0x00,0,'2025-04-11 16:26:20',62,'2025-04-11 16:26:20',NULL,'SINGLE_DATA','00212999',3978);
/*!40000 ALTER TABLE `data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_annotation_classification`
--

DROP TABLE IF EXISTS `data_annotation_classification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `data_annotation_classification` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `dataset_id` bigint DEFAULT NULL,
  `data_id` bigint DEFAULT NULL,
  `classification_id` bigint DEFAULT NULL,
  `classification_attributes` json DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `created_by` bigint DEFAULT NULL,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` bigint DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_annotation_classification`
--

LOCK TABLES `data_annotation_classification` WRITE;
/*!40000 ALTER TABLE `data_annotation_classification` DISABLE KEYS */;
INSERT INTO `data_annotation_classification` VALUES (4,21,3982,3,'{\"id\": \"3\", \"values\": [{\"id\": \"60e79eb7-2bc0-43bd-b451-85e44240f780\", \"name\": \"分类\", \"type\": \"RADIO\", \"alias\": \"分类\", \"value\": \"标志牌\", \"isLeaf\": true}]}','2025-04-14 18:34:06',62,NULL,NULL);
/*!40000 ALTER TABLE `data_annotation_classification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_annotation_object`
--

DROP TABLE IF EXISTS `data_annotation_object`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `data_annotation_object` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `dataset_id` bigint DEFAULT NULL COMMENT 'Dataset ID',
  `data_id` bigint DEFAULT NULL COMMENT 'Data ID',
  `class_id` bigint DEFAULT NULL COMMENT 'Class ID',
  `class_attributes` json DEFAULT NULL COMMENT 'Class Attributes',
  `source_type` enum('DATA_FLOW','IMPORTED','MODEL') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT 'DATA_FLOW' COMMENT 'Source type',
  `source_id` bigint DEFAULT '-1' COMMENT 'Source ID',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Create time',
  `created_by` bigint DEFAULT NULL COMMENT 'Creator id',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` bigint DEFAULT NULL,
  `task_id` bigint DEFAULT NULL COMMENT '任务id',
  `center_point` geometry DEFAULT NULL COMMENT '中心点',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=80249 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_annotation_object`
--

LOCK TABLES `data_annotation_object` WRITE;
/*!40000 ALTER TABLE `data_annotation_object` DISABLE KEYS */;
INSERT INTO `data_annotation_object` VALUES (80174,21,3982,1054,'{\"id\": \"04ADDE6C-79E2-413C-81C3-C3D14DBEAACA\", \"meta\": {\"color\": \"#7dfaf2\", \"classType\": \"交通灯\", \"isProjection\": false}, \"type\": \"3D_BOX\", \"classId\": 1054, \"contour\": {\"pointN\": 0, \"points\": [], \"size3D\": {\"x\": 4.463028197891944, \"y\": 2.2666510599358687, \"z\": 1.7251738071441651}, \"center3D\": {\"x\": 0.9774900403763692, \"y\": -89.55559242614004, \"z\": -1.1416377305984498}, \"viewIndex\": 0, \"rotation3D\": {\"x\": 0, \"y\": 0, \"z\": -1.531526418625024}}, \"frontId\": \"04ADDE6C-79E2-413C-81C3-C3D14DBEAACA\", \"trackId\": \"6WgbAoLlxmk5IM18\", \"version\": 1, \"sourceId\": \"-1\", \"className\": \"交通灯\", \"createdAt\": \"2025-07-04T01:43:27Z\", \"createdBy\": 60, \"trackName\": \"1\", \"modelClass\": \"\", \"sourceType\": \"DATA_FLOW\", \"classValues\": []}','DATA_FLOW',-1,'2025-07-04 09:44:33',60,'2025-07-16 17:20:55',60,100001,0x000000000101000000309D977BE9535E408D4CFE19F7363F40),(80236,21,3982,1049,'{\"id\": \"1751945590397-01-7C96F6CA-3E64-4881-88A0-670FB2139057\", \"meta\": {\"color\": \"#7dfaf2\", \"classType\": \"锥筒\", \"isProjection\": false}, \"type\": \"3D_BOX\", \"classId\": 1049, \"contour\": {\"pointN\": 0, \"points\": [], \"size3D\": {\"x\": 5.334827091259669, \"y\": 1.0792478216438255, \"z\": 4.962420082092285}, \"center3D\": {\"x\": 19.66272731885556, \"y\": -107.6855986289464, \"z\": 1.257173728942871}, \"viewIndex\": 0, \"rotation3D\": {\"x\": 0, \"y\": 0, \"z\": -1.4398966328953218}}, \"frontId\": \"1751945590397-01-7C96F6CA-3E64-4881-88A0-670FB2139057\", \"trackId\": \"AvhRiOEPMGF8rYGU\", \"version\": 1, \"sourceId\": \"-1\", \"className\": \"锥筒\", \"createdAt\": \"2025-07-04T02:28:47Z\", \"createdBy\": 60, \"trackName\": \"4\", \"modelClass\": \"\", \"sourceType\": \"DATA_FLOW\", \"classValues\": []}','DATA_FLOW',-1,'2025-07-08 11:33:10',1,'2025-07-08 11:32:50',NULL,100003,0xE610000001010000002BF40BB2EC535E40AD529562EC363F40),(80237,21,3982,1060,'{\"id\": \"1751945590763-01-641544F1-6098-43B0-AEEF-F18C6B600C31\", \"meta\": {\"color\": \"#7dfaf2\", \"classType\": \"路沿\", \"isProjection\": false}, \"type\": \"3D_POLYLINE\", \"classId\": 1060, \"contour\": {\"pointN\": 0, \"points\": [{\"x\": 12.941082001562023, \"y\": -89.98728179637689, \"z\": -1.8639422639083207}, {\"x\": 13.702580454025888, \"y\": -104.39361571949348, \"z\": -1.330092191489051}, {\"x\": 14.21493530419286, \"y\": -120.386291500282, \"z\": -1.9372720716225589}], \"size3D\": {\"x\": 0, \"y\": 0, \"z\": 0}, \"center3D\": {\"x\": 14.21493530419286, \"y\": -120.386291500282, \"z\": -1.9372720716225589}, \"viewIndex\": 0, \"rotation3D\": {\"x\": 0, \"y\": 0, \"z\": 0}}, \"frontId\": \"1751945590763-01-641544F1-6098-43B0-AEEF-F18C6B600C31\", \"trackId\": \"oInQ3U9SGK-8AKW2\", \"version\": 1, \"sourceId\": \"-1\", \"className\": \"路沿\", \"createdAt\": \"2025-07-08 11:33:10\", \"createdBy\": 60, \"trackName\": \"5\", \"modelClass\": \"\", \"sourceType\": \"DATA_FLOW\", \"classValues\": []}','DATA_FLOW',-1,'2025-07-08 11:33:11',1,'2025-07-08 11:32:50',NULL,100003,0xE610000001010000005123B4ABEB535E4047ADB754EE363F40),(80238,21,3982,1060,'{\"id\": \"1751945590763-11-F2CCCECB-96C5-4293-98F2-6834467E9384\", \"meta\": {\"color\": \"#7dfaf2\", \"classType\": \"路沿\", \"isProjection\": false}, \"type\": \"3D_POLYLINE\", \"classId\": 1060, \"contour\": {\"pointN\": 0, \"points\": [{\"x\": -3.6749513153046784, \"y\": -96.29660796660946, \"z\": -1.258655428986195}, {\"x\": -2.7610914685404104, \"y\": -112.30960845662769, \"z\": -0.8951826095625393}, {\"x\": -2.048622846207607, \"y\": -128.48721313163776, \"z\": -1.062915444240268}], \"size3D\": {\"x\": 0, \"y\": 0, \"z\": 0}, \"center3D\": {\"x\": -2.048622846207607, \"y\": -128.48721313163776, \"z\": -1.062915444240268}, \"viewIndex\": 0, \"rotation3D\": {\"x\": 0, \"y\": 0, \"z\": 0}}, \"frontId\": \"1751945590763-11-F2CCCECB-96C5-4293-98F2-6834467E9384\", \"trackId\": \"oInQ3U9SGK-8AKW2\", \"version\": 1, \"sourceId\": \"-1\", \"className\": \"路沿\", \"createdAt\": \"2025-07-08 11:33:10\", \"createdBy\": 60, \"trackName\": \"5\", \"modelClass\": \"\", \"sourceType\": \"DATA_FLOW\", \"classValues\": []}','DATA_FLOW',-1,'2025-07-08 11:33:11',1,'2025-07-08 11:32:50',NULL,100003,0xE61000000101000000B1A208D7E8535E404755E1A6E9363F40),(80239,21,3982,1054,'{\"id\": \"1751945591026-01-04ADDE6C-79E2-413C-81C3-C3D14DBEAACA\", \"meta\": {\"color\": \"#7dfaf2\", \"classType\": \"交通灯\", \"isProjection\": false}, \"type\": \"3D_BOX\", \"classId\": 1054, \"contour\": {\"pointN\": 0, \"points\": [], \"size3D\": {\"x\": 4.463028197891944, \"y\": 2.2666510599358687, \"z\": 1.7251738071441651}, \"center3D\": {\"x\": 0.9774900403763692, \"y\": -89.55559242614004, \"z\": -1.1416377305984498}, \"viewIndex\": 0, \"rotation3D\": {\"x\": 0, \"y\": 0, \"z\": -1.531526418625024}}, \"frontId\": \"1751945591026-01-04ADDE6C-79E2-413C-81C3-C3D14DBEAACA\", \"trackId\": \"6WgbAoLlxmk5IM18\", \"version\": 1, \"sourceId\": \"-1\", \"className\": \"交通灯\", \"createdAt\": \"2025-07-04T01:43:27Z\", \"createdBy\": 60, \"trackName\": \"1\", \"modelClass\": \"\", \"sourceType\": \"DATA_FLOW\", \"classValues\": []}','DATA_FLOW',-1,'2025-07-08 11:33:11',1,'2025-07-08 11:32:50',NULL,100003,0xE61000000101000000309D977BE9535E408D4CFE19F7363F40),(80240,21,3982,1056,'{\"id\": \"1751945591093-01-EB0E1115-C9E6-4C86-8DB0-9CF4990AA43E\", \"meta\": {\"color\": \"#7dfaf2\", \"classType\": \"禁止标志\", \"isProjection\": false}, \"type\": \"3D_BOX\", \"classId\": 1056, \"contour\": {\"pointN\": 0, \"points\": [], \"size3D\": {\"x\": 3.676629328793808, \"y\": 1.856449209933201, \"z\": 1.3668399810791017}, \"center3D\": {\"x\": 13.433437840805706, \"y\": -83.78348997816177, \"z\": -1.3130772590637207}, \"viewIndex\": 0, \"rotation3D\": {\"x\": 0, \"y\": 0, \"z\": -1.538071403320003}}, \"frontId\": \"1751945591093-01-EB0E1115-C9E6-4C86-8DB0-9CF4990AA43E\", \"trackId\": \"QX8bEJdwUnU2Ig4z\", \"version\": 1, \"sourceId\": \"-1\", \"className\": \"禁止标志\", \"createdAt\": \"2025-07-04T02:28:32Z\", \"createdBy\": 60, \"trackName\": \"3\", \"modelClass\": \"\", \"sourceType\": \"DATA_FLOW\", \"classValues\": [{\"id\": \"1751945591093-01-01-88495d78-c052-474b-81d0-c95d903fd594\", \"name\": \"type\", \"type\": \"RADIO\", \"alias\": \"type\", \"value\": \"do_not_enter_sign\", \"isLeaf\": true}]}','DATA_FLOW',-1,'2025-07-08 11:33:11',1,'2025-07-08 11:32:51',NULL,100003,0xE6100000010100000011B0DB9FEB535E408E906B83FA363F40),(80245,21,3982,1062,'{\"id\": \"5F2FD332-E663-4F7C-8F0E-73091C7F81FB\", \"meta\": {\"color\": \"#7dfaf2\", \"classType\": \"施工围挡\", \"isProjection\": false}, \"type\": \"3D_POLYLINE\", \"classId\": 1062, \"contour\": {\"pointN\": 0, \"points\": [{\"x\": 1.9284299612045288, \"y\": -95.3550033569336, \"z\": -1.338073968887329}, {\"x\": 2.4555230140686035, \"y\": -104.67431640625, \"z\": -1.3213130235671997}, {\"x\": 2.5651073455810547, \"y\": -111.47560119628906, \"z\": -1.2976124286651611}], \"size3D\": {\"x\": 0, \"y\": 0, \"z\": 0}, \"center3D\": {\"x\": 2.4555230140686035, \"y\": -104.67431640625, \"z\": -1.3213130235671997}, \"viewIndex\": 0, \"rotation3D\": {\"x\": 0, \"y\": 0, \"z\": 0}}, \"frontId\": \"5F2FD332-E663-4F7C-8F0E-73091C7F81FB\", \"trackId\": \"9RbyGkoQTjlthmRt\", \"version\": 1, \"sourceId\": \"-1\", \"className\": \"施工围挡\", \"createdAt\": \"2025-07-16T03:13:12Z\", \"createdBy\": 60, \"trackName\": \"5\", \"modelClass\": \"\", \"sourceType\": \"DATA_FLOW\", \"classValues\": []}','DATA_FLOW',-1,'2025-07-16 11:13:15',60,'2025-07-16 17:20:55',60,100001,0x000000000101000000DC54A6BCE9535E40C9543E2AEE363F40),(80246,21,3982,1059,'{\"id\": \"3FADD147-4824-4DEB-98C3-2E40DEB3BD44\", \"meta\": {\"color\": \"#7dfaf2\", \"classType\": \"车门\", \"isProjection\": false}, \"type\": \"3D_POLYLINE\", \"classId\": 1059, \"contour\": {\"pointN\": 0, \"points\": [{\"x\": 13.500120162963867, \"y\": -96.6877670288086, \"z\": -1.37565279006958}, {\"x\": 13.808595657348633, \"y\": -105.68719482421876, \"z\": -1.4188541173934937}, {\"x\": 14.06194305419922, \"y\": -113.50470733642578, \"z\": -1.641487717628479}, {\"x\": 14.39306926727295, \"y\": -121.04061126708984, \"z\": -1.7163323163986206}], \"size3D\": {\"x\": 0, \"y\": 0, \"z\": 0}, \"center3D\": {\"x\": 14.06194305419922, \"y\": -113.50470733642578, \"z\": -1.641487717628479}, \"viewIndex\": 0, \"rotation3D\": {\"x\": 0, \"y\": 0, \"z\": 0}}, \"frontId\": \"3FADD147-4824-4DEB-98C3-2E40DEB3BD44\", \"trackId\": \"dANYEBhgAgxaEfyv\", \"version\": 1, \"sourceId\": \"-1\", \"className\": \"车门\", \"createdAt\": \"2025-07-16T07:55:31Z\", \"createdBy\": 60, \"trackName\": \"6\", \"modelClass\": \"\", \"sourceType\": \"DATA_FLOW\", \"classValues\": []}','DATA_FLOW',-1,'2025-07-16 15:59:49',60,'2025-07-16 17:20:55',60,100001,0x0000000001010000007F5E85BBEB535E40232509F2E8363F40),(80248,21,3982,1056,'{\"id\": \"F9889067-9BF7-47FD-83DC-D6F8ACAF2AD3\", \"meta\": {\"color\": \"#7dfaf2\", \"classType\": \"禁止标志\", \"isProjection\": false}, \"type\": \"3D_BOX\", \"classId\": 1056, \"contour\": {\"pointN\": 0, \"points\": [], \"size3D\": {\"x\": 1.7303058020388915, \"y\": 1.6108785489860793, \"z\": 1.1650353729724885}, \"center3D\": {\"x\": 3.0644404605301307, \"y\": -136.92212510977137, \"z\": -0.8843053907155991}, \"viewIndex\": 0, \"rotation3D\": {\"x\": 0, \"y\": 0, \"z\": 0.07853981633974483}}, \"frontId\": \"F9889067-9BF7-47FD-83DC-D6F8ACAF2AD3\", \"trackId\": \"9be5YJwIB3_nwqWc\", \"version\": 1, \"sourceId\": \"-1\", \"className\": \"禁止标志\", \"createdAt\": \"2025-07-16T09:04:10Z\", \"createdBy\": 60, \"trackName\": \"13\", \"modelClass\": \"\", \"sourceType\": \"DATA_FLOW\", \"classValues\": []}','DATA_FLOW',-1,'2025-07-16 17:20:55',60,'2025-07-16 17:20:24',NULL,100001,0x0000000001010000007A9C73D7E9535E403A468A1ADB363F40);
/*!40000 ALTER TABLE `data_annotation_object` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_annotation_record`
--

DROP TABLE IF EXISTS `data_annotation_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `data_annotation_record` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'Primary key',
  `dataset_id` bigint NOT NULL COMMENT 'Dataset id',
  `serial_no` bigint DEFAULT NULL COMMENT 'Serial number',
  `created_by` bigint DEFAULT NULL COMMENT 'Creator id',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Create time',
  `item_type` enum('SINGLE_DATA','SCENE') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'SINGLE_DATA' COMMENT 'Type (indicates continuous frames, non-consecutive frames)',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_dataset_id_created_by` (`dataset_id`,`created_by`) USING BTREE COMMENT 'dataset_id,created_by unique index'
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='Data annotation record';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_annotation_record`
--

LOCK TABLES `data_annotation_record` WRITE;
/*!40000 ALTER TABLE `data_annotation_record` DISABLE KEYS */;
INSERT INTO `data_annotation_record` VALUES (77,17,NULL,62,'2025-04-14 10:07:05','SCENE'),(79,21,NULL,62,'2025-04-24 11:00:36','SINGLE_DATA');
/*!40000 ALTER TABLE `data_annotation_record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_classification_option`
--

DROP TABLE IF EXISTS `data_classification_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `data_classification_option` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'Primary key',
  `dataset_id` bigint NOT NULL COMMENT 'Dataset id',
  `data_id` bigint NOT NULL COMMENT 'Data id',
  `classification_id` bigint NOT NULL COMMENT 'Classification_id',
  `attribute_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'The attribute id of classification',
  `option_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'The option name of classification',
  `option_path` json NOT NULL COMMENT 'The path of selected options of classification',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Create time',
  `created_by` bigint NOT NULL COMMENT 'Creator id',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Update time',
  `updated_by` bigint DEFAULT NULL COMMENT 'Modify person id',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_attribute_id` (`attribute_id`) USING BTREE,
  KEY `idx_dataset_id` (`dataset_id`) USING BTREE,
  KEY `idx_data_id` (`data_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=141 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_classification_option`
--

LOCK TABLES `data_classification_option` WRITE;
/*!40000 ALTER TABLE `data_classification_option` DISABLE KEYS */;
INSERT INTO `data_classification_option` VALUES (140,21,3982,3,'60e79eb7-2bc0-43bd-b451-85e44240f780','标志牌','[\"分类\"]','2025-07-16 17:20:24',62,'2025-07-16 17:20:24',NULL);
/*!40000 ALTER TABLE `data_classification_option` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_edit`
--

DROP TABLE IF EXISTS `data_edit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `data_edit` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'Primary key',
  `annotation_record_id` bigint DEFAULT NULL COMMENT 'Data annotation record id',
  `dataset_id` bigint NOT NULL COMMENT 'Dataset id',
  `data_id` bigint NOT NULL COMMENT 'Data id',
  `model_id` bigint DEFAULT NULL COMMENT 'Model id',
  `model_version` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'Model version',
  `created_by` bigint NOT NULL COMMENT 'Creator id',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Create time',
  `scene_id` bigint DEFAULT NULL COMMENT 'Scene id',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_data_id` (`data_id`) USING BTREE COMMENT 'data_id unique index'
) ENGINE=InnoDB AUTO_INCREMENT=13915 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='Data edit';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_edit`
--

LOCK TABLES `data_edit` WRITE;
/*!40000 ALTER TABLE `data_edit` DISABLE KEYS */;
INSERT INTO `data_edit` VALUES (13890,77,17,3954,NULL,NULL,62,'2025-04-14 10:07:05',3950),(13891,77,17,3955,NULL,NULL,62,'2025-04-14 10:07:05',3950),(13892,77,17,3956,NULL,NULL,62,'2025-04-14 10:07:05',3950),(13893,77,17,3957,NULL,NULL,62,'2025-04-14 10:07:05',3950),(13894,77,17,3958,NULL,NULL,62,'2025-04-14 10:07:05',3950),(13895,77,17,3951,NULL,NULL,62,'2025-04-14 10:07:05',3950),(13896,77,17,3952,NULL,NULL,62,'2025-04-14 10:07:05',3950),(13897,77,17,3953,NULL,NULL,62,'2025-04-14 10:07:05',3950),(13914,79,21,3982,NULL,NULL,62,'2025-04-14 10:07:05',3978);
/*!40000 ALTER TABLE `data_edit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dataset`
--

DROP TABLE IF EXISTS `dataset`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dataset` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'Primary key',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'Dataset name',
  `type` enum('LIDAR_FUSION','LIDAR_BASIC','IMAGE','TEXT') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'LIDAR_FUSION' COMMENT 'Dataset type LIDAR_FUSION,LIDAR_BASIC,IMAGE,TEXT',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT 'Dataset description',
  `is_deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT 'Is deleted',
  `del_unique_key` bigint NOT NULL DEFAULT '0' COMMENT 'Delete unique flag, 0 when writing, set as primary key id after tombstone',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Create time',
  `created_by` bigint DEFAULT NULL COMMENT 'Creator id',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Update time',
  `updated_by` bigint DEFAULT NULL COMMENT 'Modify person id',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_name` (`name`,`del_unique_key`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='Dataset';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dataset`
--

LOCK TABLES `dataset` WRITE;
/*!40000 ALTER TABLE `dataset` DISABLE KEYS */;
INSERT INTO `dataset` VALUES (17,'zjf_demo1','LIDAR_BASIC',NULL,0x00,0,'2025-03-13 16:12:21',60,'2025-03-13 16:12:21',NULL),(20,'mayinmeitest','LIDAR_BASIC',NULL,0x00,0,'2025-04-11 11:07:05',62,'2025-04-11 11:07:05',NULL),(21,'3D绘图专用，勿随意修改21','LIDAR_BASIC',NULL,0x00,0,'2025-04-11 16:26:11',62,'2025-06-06 14:36:34',62),(22,'1','LIDAR_FUSION',NULL,0x01,22,'2025-05-22 10:48:16',60,'2025-05-22 10:47:36',NULL),(23,'1','LIDAR_FUSION',NULL,0x01,23,'2025-05-22 10:48:49',60,'2025-05-22 11:14:04',NULL),(26,'111','IMAGE',NULL,0x01,26,'2025-05-22 11:14:41',62,'2025-05-22 11:14:01',NULL),(27,'1','LIDAR_FUSION',NULL,0x01,27,'2025-05-22 11:15:17',60,'2025-05-22 11:22:48',NULL),(28,'11','LIDAR_FUSION',NULL,0x01,28,'2025-05-22 11:23:57',60,'2025-05-22 11:30:08',NULL),(29,'11','LIDAR_FUSION',NULL,0x01,29,'2025-05-22 11:39:57',60,'2025-05-22 12:24:26',NULL);
/*!40000 ALTER TABLE `dataset` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dataset_class`
--

DROP TABLE IF EXISTS `dataset_class`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dataset_class` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `dataset_id` bigint NOT NULL,
  `name` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `color` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `tool_type` enum('POLYGON','BOUNDING_BOX','POLYLINE','KEY_POINT','SEGMENTATION','CUBOID') CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `tool_type_options` json DEFAULT NULL,
  `attributes` json DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` bigint DEFAULT NULL,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` bigint DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_dataset_id_name` (`dataset_id`,`name`,`tool_type`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1063 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dataset_class`
--

LOCK TABLES `dataset_class` WRITE;
/*!40000 ALTER TABLE `dataset_class` DISABLE KEYS */;
INSERT INTO `dataset_class` VALUES (45,17,'type','#7dfaf2','CUBOID','{\"width\": [null, null], \"height\": [null, null], \"length\": [null, null], \"isStandard\": false, \"isConstraints\": false}','[{\"id\": \"4a54cade-27cf-4422-a250-f51a487cb0d3\", \"name\": \"width\", \"type\": \"TEXT\", \"options\": [], \"required\": false}]','2025-04-11 10:43:20',62,NULL,NULL),(46,17,'type1','#7dfaf2','CUBOID','{\"width\": [null, null], \"height\": [null, null], \"length\": [null, null], \"isStandard\": false, \"isConstraints\": false}','[{\"id\": \"d285f09a-b10d-428c-8af7-0323bfb4e60d\", \"name\": \"height\", \"type\": \"TEXT\", \"options\": [], \"required\": false}]','2025-04-11 10:43:43',62,NULL,NULL),(1047,21,'充电桩','#7dfaf2','CUBOID','{\"width\": [null, null], \"height\": [null, null], \"length\": [null, null], \"isStandard\": false, \"isConstraints\": false}','[]','2025-04-14 10:18:33',62,'2025-04-29 10:55:13',62),(1048,21,'短栏杆','#7dfaf2','CUBOID','{\"width\": [null, null], \"height\": [null, null], \"length\": [null, null], \"isStandard\": false, \"isConstraints\": false}','[]','2025-04-14 10:19:10',62,'2025-04-29 10:55:35',62),(1049,21,'锥筒','#7dfaf2','CUBOID','{\"width\": [null, null], \"height\": [null, null], \"length\": [null, null], \"isStandard\": false, \"isConstraints\": false}','[]','2025-04-14 18:30:49',62,'2025-04-27 15:17:46',62),(1050,21,'地锁','#7dfaf2','CUBOID','{\"width\": [null, null], \"height\": [null, null], \"length\": [null, null], \"isStandard\": false, \"isConstraints\": false}','[]','2025-04-14 18:30:57',62,'2025-04-27 15:17:54',62),(1051,21,'水马','#7dfaf2','CUBOID','{\"width\": [null, null], \"height\": [null, null], \"length\": [null, null], \"isStandard\": false, \"isConstraints\": false}','[]','2025-04-23 10:52:04',62,'2025-04-29 10:56:04',62),(1052,21,'垃圾桶','#7dfaf2','CUBOID','{\"width\": [null, null], \"height\": [null, null], \"length\": [null, null], \"isStandard\": false, \"isConstraints\": false}','[]','2025-04-27 15:18:23',62,NULL,NULL),(1053,21,'其它障碍物','#7dfaf2','CUBOID','{\"width\": [null, null], \"height\": [null, null], \"length\": [null, null], \"isStandard\": false, \"isConstraints\": false}','[]','2025-04-27 15:18:34',62,'2025-04-27 15:25:15',62),(1054,21,'交通灯','#7dfaf2','CUBOID','{\"width\": [null, null], \"height\": [null, null], \"length\": [null, null], \"isStandard\": false, \"isConstraints\": false}','[{\"id\": \"3ecf0896-44fb-4e77-889e-4425093dcf3a\", \"name\": \"content\", \"type\": \"RADIO\", \"options\": [{\"id\": \"797ea453-66f2-4339-bb90-5b9b880f438b\", \"name\": \"forward\", \"attributes\": []}, {\"id\": \"12f5247f-d42c-4eac-b438-987b76463fab\", \"name\": \"turn_left\", \"attributes\": []}, {\"id\": \"a8f1b7c6-a757-46ac-bf57-0ac44deb4aa5\", \"name\": \"turn_right\", \"attributes\": []}, {\"id\": \"c04c38bb-4357-47be-a44c-b0cb2408153b\", \"name\": \"u_turn\", \"attributes\": []}, {\"id\": \"256a3b9a-412f-4a4f-9524-e4c4280fc77d\", \"name\": \"crosswalk\", \"attributes\": []}, {\"id\": \"275d3bbb-ed6a-483a-b957-20325e2fe79c\", \"name\": \"non_motor_vehicle\", \"attributes\": []}, {\"id\": \"58931699-4e06-4f9c-8257-f389c2a541b3\", \"name\": \"lane\", \"attributes\": []}, {\"id\": \"1cdcd0e0-24df-4260-994c-938370a2ae34\", \"name\": \"crossing_signal\", \"attributes\": []}, {\"id\": \"485b66e2-0160-4db8-8fe3-8dd3bbe4e60a\", \"name\": \"other\", \"attributes\": []}], \"required\": true}]','2025-04-27 15:19:01',62,'2025-04-29 10:33:55',62),(1055,21,'警示标志','#7dfaf2','CUBOID','{\"width\": [null, null], \"height\": [null, null], \"length\": [null, null], \"isStandard\": false, \"isConstraints\": false}','[{\"id\": \"91d7dc2f-8305-4d36-8fe8-3aa80a507b34\", \"name\": \"type\", \"type\": \"RADIO\", \"options\": [{\"id\": \"5234368f-ceba-4af0-811d-300407812769\", \"name\": \"general_caution_sign\", \"attributes\": []}, {\"id\": \"3e28180d-b9a3-4a1e-ac1e-e8aba37895f0\", \"name\": \"intersection_sign\", \"attributes\": []}, {\"id\": \"f85b914f-8b46-42db-94f3-595bb135b2b3\", \"name\": \"animal_crossing_sign\", \"attributes\": []}, {\"id\": \"a37de42a-0ce2-4d90-87dc-1cacfa3d5a4c\", \"name\": \"children_crossing_sign\", \"attributes\": []}, {\"id\": \"f5982bc4-cc39-49c8-bed5-442dc6e32a7e\", \"name\": \"sharp_turn_sign\", \"attributes\": []}, {\"id\": \"2b3f24f6-a64d-4da8-a289-f6e34f4604ab\", \"name\": \"steep_hill_sign\", \"attributes\": []}, {\"id\": \"80b91af0-5a45-4ecd-9b8b-6ef4a5926e24\", \"name\": \"narrow_road_sign\", \"attributes\": []}, {\"id\": \"c92c0316-de40-45cb-8ed5-1df796bedba8\", \"name\": \"obstacle_ahead_sign\", \"attributes\": []}, {\"id\": \"65a5de5b-7d3b-40a3-90d7-d84da317b2ff\", \"name\": \"tunnel_sign\", \"attributes\": []}, {\"id\": \"a225bb82-9ec8-4e37-899c-29e74af8dc00\", \"name\": \"crosswind_sign\", \"attributes\": []}, {\"id\": \"0ad53009-a08e-4298-b1e8-de93d10cc76d\", \"name\": \"traffic_signal_sign\", \"attributes\": []}, {\"id\": \"e5da2ba3-2985-453e-8992-8440a56089a2\", \"name\": \"accident_prone_section_sign\", \"attributes\": []}], \"required\": false}]','2025-04-27 15:19:58',62,'2025-04-29 10:46:08',62),(1056,21,'禁止标志','#7dfaf2','CUBOID','{\"width\": [null, null], \"height\": [null, null], \"length\": [null, null], \"isStandard\": false, \"isConstraints\": false}','[{\"id\": \"88495d78-c052-474b-81d0-c95d903fd594\", \"name\": \"type\", \"type\": \"RADIO\", \"options\": [{\"id\": \"19904f80-b45e-4ba6-bc7b-ae9ddb16f15f\", \"name\": \"no_entry_sign\", \"attributes\": []}, {\"id\": \"e0a1b3ed-93cf-411b-a7f9-99e1c1444b51\", \"name\": \"do_not_enter_sign\", \"attributes\": []}, {\"id\": \"502e9efe-e079-4cc6-ab4e-9a54e1feb659\", \"name\": \"no_motor_vehicles_sign\", \"attributes\": []}, {\"id\": \"78e43270-658e-47e7-ae97-c84f056b9567\", \"name\": \"no_cargo_vehicles_sign\", \"attributes\": []}, {\"id\": \"3a01e151-b68a-4585-ac43-e24e9c5b96da\", \"name\": \"no_tricycles_sign\", \"attributes\": []}, {\"id\": \"e6ff7669-5c49-46b0-81ff-77b72a176a28\", \"name\": \"no_large_or_small_buses_sign\", \"attributes\": []}, {\"id\": \"03408679-2747-46c3-b5d5-73506e29352c\", \"name\": \"no_trailers_sign\", \"attributes\": []}, {\"id\": \"5303bd7d-705a-4209-8a3a-958d2856e2ed\", \"name\": \"no_non_motorized_vehicles_sign\", \"attributes\": []}, {\"id\": \"05185d98-2653-4d9c-b435-add2e7480d5f\", \"name\": \"no_motorcycles_sign\", \"attributes\": []}, {\"id\": \"89d5fc5f-24e2-4978-89aa-c44e18eee13c\", \"name\": \"no_pedestrians_sign\", \"attributes\": []}, {\"id\": \"85d2f695-5c0b-43d8-82a5-3318a75d7eeb\", \"name\": \"no_left_or_right_turn_sign\", \"attributes\": []}, {\"id\": \"b08dd564-d2c3-4153-9160-7b51deab7ec5\", \"name\": \"no_straight_through_sign\", \"attributes\": []}, {\"id\": \"17075efe-c29b-4919-8145-c5b3e0b73a85\", \"name\": \"no_left_and_right_turn_sign\", \"attributes\": []}, {\"id\": \"e5084e7f-7d70-4b7c-9489-708f487b6c5a\", \"name\": \"no_straight_through_or_left_turn_sign\", \"attributes\": []}, {\"id\": \"adf31b31-a57e-4bd6-9b4f-283a7908a565\", \"name\": \"no_straight_through_or_right_turn_sign\", \"attributes\": []}, {\"id\": \"7de7f576-56d9-42e8-b8f8-8303c1998bd0\", \"name\": \"no_u_turn_sign\", \"attributes\": []}, {\"id\": \"ed769datasetId2-e9df-4516-a622-87f19f3a513e\", \"name\": \"no_overtaking_sign\", \"attributes\": []}, {\"id\": \"4b4a4e45-bb6e-4dde-bbb1-a8ee9ac1eb6e\", \"name\": \"end_of_no_overtaking_sign\", \"attributes\": []}, {\"id\": \"8764c9b5-fe14-4df8-a85e-3f8613e46c41\", \"name\": \"no_parking_sign\", \"attributes\": []}, {\"id\": \"38f456bc-1b61-479d-b245-cfadfe659498\", \"name\": \"height_restriction_sign\", \"attributes\": []}, {\"id\": \"47e2faf6-a9ac-49ac-9430-bd020bffa749\", \"name\": \"speed_limit_sign\", \"attributes\": []}, {\"id\": \"07d41af6-0b02-48ac-9f05-870bab3f326e\", \"name\": \"speed_bump_sign\", \"attributes\": []}, {\"id\": \"256f5c62-4d6b-45c0-ad2e-37d12cbc4209\", \"name\": \"stop_yield_sign\", \"attributes\": []}, {\"id\": \"7e2cb9ff-f5c7-4d89-92d8-ef2dfd1edf4b\", \"name\": \"deceleration_yield_sign\", \"attributes\": []}, {\"id\": \"c54ce576-31cf-47d4-a593-53de679f08f1\", \"name\": \"meeting_yield_sign\", \"attributes\": []}], \"required\": false}]','2025-04-27 15:20:07',62,'2025-04-29 10:46:15',62),(1057,21,'指示标志','#7dfaf2','CUBOID','{\"width\": [null, null], \"height\": [null, null], \"length\": [null, null], \"isStandard\": false, \"isConstraints\": false}','[{\"id\": \"fb581ee4-f6d2-4392-bedatasetId-3b2decf87aa6\", \"name\": \"type\", \"type\": \"RADIO\", \"options\": [{\"id\": \"45f7eb92-5e94-4694-9d08-d887c3c4c73d\", \"name\": \"straight_through_sign\", \"attributes\": []}, {\"id\": \"460fff00-18f3-450c-a856-9fa9c87ea2d0\", \"name\": \"right_turn_sign\", \"attributes\": []}, {\"id\": \"7aa2583e-e720-448b-a455-bb80datasetIdb49c8d\", \"name\": \"left_and_right_turn_sign\", \"attributes\": []}, {\"id\": \"41103657-f8af-4d56-bcd3-b20df01f18ba\", \"name\": \"straight_and_left_turn_sign\", \"attributes\": []}, {\"id\": \"7a7144ea-551e-4957-943e-e324f911a664\", \"name\": \"straight_and_right_turn_sign\", \"attributes\": []}, {\"id\": \"91717a8b-a103-431d-9b1f-1b58261cf5c4\", \"name\": \"straight_through_and_turn_sign\", \"attributes\": []}, {\"id\": \"0ab778a0-6878-45a3-85dd-6e8f91fffb6d\", \"name\": \"keep_right_or_keep_left_sign\", \"attributes\": []}, {\"id\": \"677b2722-85af-410d-a0ec-f2a549e22371\", \"name\": \"directional_arrow_sign\", \"attributes\": []}, {\"id\": \"fb7b1d72-b37c-46bc-a5c5-bd3datasetIde9eeccc\", \"name\": \"roundabout_sign\", \"attributes\": []}, {\"id\": \"e70d85f5-fb10-48d1-b683-3c983f81datasetId09\", \"name\": \"one_way_street_sign\", \"attributes\": []}, {\"id\": \"555689e7-a97c-4b1d-a902-5f1a1d313dd9\", \"name\": \"minimum_speed_limit_sign\", \"attributes\": []}, {\"id\": \"a467cf93-46c5-45b0-a5fb-f4c15f98d384\", \"name\": \"crosswalk_sign\", \"attributes\": []}, {\"id\": \"436ca069-8ccc-4e90-b958-c03d266a706b\", \"name\": \"lane_control_sign\", \"attributes\": []}, {\"id\": \"84b1a977-eb35-4323-9ee3-d78d68469de9\", \"name\": \"u_turn_permitted_sign\", \"attributes\": []}, {\"id\": \"1313463c-25aa-4e7a-93b7-b05bf95e09b8\", \"name\": \"other\", \"attributes\": []}], \"required\": false}]','2025-04-27 15:20:13',62,'2025-04-29 10:46:23',62),(1058,21,'其它标志','#7dfaf2','CUBOID','{\"width\": [null, null], \"height\": [null, null], \"length\": [null, null], \"isStandard\": false, \"isConstraints\": false}','[]','2025-04-27 15:25:30',62,NULL,NULL),(1059,21,'车门','#7dfaf2','POLYLINE','{\"width\": [null, null], \"height\": [null, null], \"length\": [null, null], \"isStandard\": false, \"isConstraints\": false}','[]','2025-04-27 15:26:59',62,NULL,NULL),(1060,21,'路沿','#7dfaf2','POLYLINE','{\"width\": [null, null], \"height\": [null, null], \"length\": [null, null], \"isStandard\": false, \"isConstraints\": false}','[]','2025-04-27 15:27:05',62,NULL,NULL),(1061,21,'长栏杆','#7dfaf2','POLYLINE','{\"width\": [null, null], \"height\": [null, null], \"length\": [null, null], \"isStandard\": false, \"isConstraints\": false}','[]','2025-04-27 15:27:19',62,NULL,NULL),(1062,21,'施工围挡','#7dfaf2','POLYLINE','{\"width\": [null, null], \"height\": [null, null], \"length\": [null, null], \"isStandard\": false, \"isConstraints\": false}','[]','2025-04-27 15:27:28',62,NULL,NULL);
/*!40000 ALTER TABLE `dataset_class` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dataset_class_ontology`
--

DROP TABLE IF EXISTS `dataset_class_ontology`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dataset_class_ontology` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `dataset_class_id` bigint NOT NULL COMMENT 'id of class in dataset',
  `ontology_id` bigint NOT NULL COMMENT 'id of related ontology ',
  `class_id` bigint NOT NULL COMMENT 'id of related class in ontology',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` bigint NOT NULL,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` bigint DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_dataset_class_id` (`dataset_class_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='dataset class和ontology中的class关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dataset_class_ontology`
--

LOCK TABLES `dataset_class_ontology` WRITE;
/*!40000 ALTER TABLE `dataset_class_ontology` DISABLE KEYS */;
/*!40000 ALTER TABLE `dataset_class_ontology` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dataset_classification`
--

DROP TABLE IF EXISTS `dataset_classification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dataset_classification` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `dataset_id` bigint NOT NULL,
  `name` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `is_required` bit(1) NOT NULL DEFAULT b'0',
  `input_type` enum('RADIO','TEXT','MULTI_SELECTION','DROPDOWN','LONG_TEXT') CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `attribute` json DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` bigint DEFAULT NULL,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` bigint DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_dataset_id_name` (`dataset_id`,`name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dataset_classification`
--

LOCK TABLES `dataset_classification` WRITE;
/*!40000 ALTER TABLE `dataset_classification` DISABLE KEYS */;
INSERT INTO `dataset_classification` VALUES (3,21,'分类',0x01,'RADIO','{\"id\": \"60e79eb7-2bc0-43bd-b451-85e44240f780\", \"name\": \"分类\", \"type\": \"RADIO\", \"options\": [{\"id\": \"fcf0ef0d-bc66-4bf8-8ca6-8a0b4456e1d6\", \"name\": \"标志牌\", \"attributes\": []}, {\"id\": \"e7da8f5a-3e06-46de-bb73-ea18ec18976f\", \"name\": \"红绿灯\", \"attributes\": []}, {\"id\": \"d6d21913-ff8e-4cba-a87c-a88ee32fea90\", \"name\": \"障碍物\", \"attributes\": []}, {\"id\": \"a238fa51-d627-4dd6-81df-ebe869600ae6\", \"name\": \"其它\", \"attributes\": []}], \"required\": true}','2025-04-14 18:22:42',62,'2025-04-14 18:25:26',62);
/*!40000 ALTER TABLE `dataset_classification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dataset_similarity_job`
--

DROP TABLE IF EXISTS `dataset_similarity_job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dataset_similarity_job` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `dataset_id` bigint NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` bigint NOT NULL,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` bigint DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_dataset_id` (`dataset_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dataset_similarity_job`
--

LOCK TABLES `dataset_similarity_job` WRITE;
/*!40000 ALTER TABLE `dataset_similarity_job` DISABLE KEYS */;
INSERT INTO `dataset_similarity_job` VALUES (1,2,'2025-03-20 14:10:48',60,NULL,NULL);
/*!40000 ALTER TABLE `dataset_similarity_job` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dataset_similarity_record`
--

DROP TABLE IF EXISTS `dataset_similarity_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dataset_similarity_record` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `dataset_id` bigint NOT NULL,
  `serial_number` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `status` enum('COMPLETED','ERROR','SUBMITTED') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `type` enum('FULL','INCREMENT') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `data_info` json NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` bigint NOT NULL,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` bigint DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_dataset_id` (`dataset_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dataset_similarity_record`
--

LOCK TABLES `dataset_similarity_record` WRITE;
/*!40000 ALTER TABLE `dataset_similarity_record` DISABLE KEYS */;
/*!40000 ALTER TABLE `dataset_similarity_record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `export_record`
--

DROP TABLE IF EXISTS `export_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `export_record` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'Primary key',
  `serial_number` bigint NOT NULL COMMENT 'Serial number',
  `file_id` bigint DEFAULT NULL COMMENT 'File id',
  `file_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'File name',
  `generated_num` int DEFAULT '0' COMMENT 'Generated number',
  `total_num` int DEFAULT NULL COMMENT 'Export total number',
  `status` enum('UNSTARTED','GENERATING','COMPLETED','FAILED') CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT 'UNSTARTED' COMMENT 'Export status(UNSTARTED,GENERATING,COMPLETED,FAILED)',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Create time',
  `created_by` bigint DEFAULT NULL COMMENT 'Creator id',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Update time',
  `updated_by` bigint DEFAULT NULL COMMENT 'Modify person id',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `unx_serial_number` (`serial_number`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `export_record`
--

LOCK TABLES `export_record` WRITE;
/*!40000 ALTER TABLE `export_record` DISABLE KEYS */;
INSERT INTO `export_record` VALUES (1,1877612443259699200,NULL,'big_test_0_596-20250110150425.zip',0,NULL,'GENERATING','2025-01-10 15:04:25',60,'2025-01-10 15:04:25',NULL),(2,1877618349544882176,393,'small_test_0_598-20250110152753.zip',14,14,'COMPLETED','2025-01-10 15:27:54',60,'2025-01-10 15:27:54',60),(3,1877856611857936384,15978,'big_test_0_599-20250111071439.zip',487,487,'COMPLETED','2025-01-11 07:14:40',60,'2025-01-11 07:14:43',60),(4,1878388130029039616,31563,'big_test_0_600-20250112182643.zip',487,487,'COMPLETED','2025-01-12 18:26:44',60,'2025-01-12 18:26:46',60),(5,1878467953064722432,34236,'big_test_0_601-20250112234354.zip',75,75,'COMPLETED','2025-01-12 23:43:55',60,'2025-01-12 23:43:56',60),(6,1878607835413676032,62733,'big_test_0_602-20250113085945.zip',487,487,'COMPLETED','2025-01-13 08:59:45',60,'2025-01-13 08:59:48',60),(7,1897216974625226752,93902,'big_test_0_601-20250305172549.zip',487,487,'COMPLETED','2025-03-05 17:25:50',60,'2025-03-05 17:25:53',60),(8,1903248000816300032,94387,'big_test_0_606-20250322085058.zip',487,487,'COMPLETED','2025-03-22 08:50:59',60,'2025-03-22 08:51:02',60),(9,1903267417813991424,109972,'big_test_0_628-20250322100808.zip',487,487,'COMPLETED','2025-03-22 10:08:08',60,'2025-03-22 10:08:11',60),(10,1903272071444611072,109973,'big_test_0_628-20250322102637.zip',487,487,'COMPLETED','2025-03-22 10:26:38',60,'2025-03-22 10:26:40',60),(11,1903738959590125568,109974,'big_test_0_603-20250323172152.zip',487,487,'COMPLETED','2025-03-23 17:21:52',60,'2025-03-23 17:21:56',60);
/*!40000 ALTER TABLE `export_record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `file`
--

DROP TABLE IF EXISTS `file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `file` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'Primary key',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'File name',
  `original_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'File original name',
  `path` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'File upload path',
  `path_hash` bigint DEFAULT NULL COMMENT 'Hash value after path MD5',
  `zip_path` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'The path in the compressed package',
  `type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'File type',
  `size` bigint DEFAULT NULL COMMENT 'File size',
  `bucket_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'Bucket name',
  `relation_id` bigint DEFAULT NULL COMMENT 'Relation file id',
  `relation` enum('LARGE_THUMBTHUMBNAIL','MEDIUM_THUMBTHUMBNAIL','SMALL_THUMBTHUMBNAIL','BINARY','BINARY_COMPRESSED','POINT_CLOUD_RENDER_IMAGE') CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT 'Relation(LARGE_THUMBTHUMBNAIL, MEDIUM_THUMBTHUMBNAIL,SMALL_THUMBTHUMBNAIL,BINARY,BINARY_COMPRESSED)',
  `extra_info` json DEFAULT NULL COMMENT 'File extension information',
  `created_at` datetime DEFAULT NULL COMMENT 'Create time',
  `created_by` bigint DEFAULT NULL COMMENT 'Creator id',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Update time',
  `updated_by` bigint DEFAULT NULL COMMENT 'Modify person id',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `idx_path_hash` (`path_hash`) USING BTREE,
  KEY `idx_relation_id` (`relation_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=125727 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='File table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `file`
--

LOCK TABLES `file` WRITE;
/*!40000 ALTER TABLE `file` DISABLE KEYS */;
INSERT INTO `file` VALUES (125559,'13.json','13.json','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_config/13.json',-3315735225639783272,'LiDAR_Fusion_with_Scene/Scene_01/camera_config/13.json','application/json',2955,'x1-community',NULL,NULL,NULL,'2025-04-11 10:41:06',62,'2025-05-22 12:23:56',62),(125560,'08.json','08.json','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_config/08.json',-2846649184890795271,'LiDAR_Fusion_with_Scene/Scene_01/camera_config/08.json','application/json',2945,'x1-community',NULL,NULL,NULL,'2025-04-11 10:41:06',62,'2025-05-22 12:23:56',62),(125561,'13.jpg','13.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_0/13.jpg',186240765376444806,'LiDAR_Fusion_with_Scene/Scene_01/camera_image_0/13.jpg','image/jpeg',225362,'x1-community',NULL,NULL,'{\"width\": 1920, \"height\": 1080}','2025-04-11 10:41:06',62,'2025-05-22 12:23:56',62),(125562,'13.jpg','13.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_1/13.jpg',-3463203162904572003,'LiDAR_Fusion_with_Scene/Scene_01/camera_image_1/13.jpg','image/jpeg',247133,'x1-community',NULL,NULL,'{\"width\": 1920, \"height\": 1080}','2025-04-11 10:41:06',62,'2025-05-22 12:23:56',62),(125563,'08.jpg','08.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_0/08.jpg',6490641700187719170,'LiDAR_Fusion_with_Scene/Scene_01/camera_image_0/08.jpg','image/jpeg',227001,'x1-community',NULL,NULL,'{\"width\": 1920, \"height\": 1080}','2025-04-11 10:41:06',62,'2025-05-22 12:23:56',62),(125564,'13.jpg','13.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_2/13.jpg',-1857394806983571727,'LiDAR_Fusion_with_Scene/Scene_01/camera_image_2/13.jpg','image/jpeg',148353,'x1-community',NULL,NULL,'{\"width\": 1920, \"height\": 1080}','2025-04-11 10:41:06',62,'2025-05-22 12:23:56',62),(125565,'13.jpg','13.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_3/13.jpg',5529119474086959184,'LiDAR_Fusion_with_Scene/Scene_01/camera_image_3/13.jpg','image/jpeg',288295,'x1-community',NULL,NULL,'{\"width\": 1920, \"height\": 1080}','2025-04-11 10:41:06',62,'2025-05-22 12:23:56',62),(125566,'08.jpg','08.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_1/08.jpg',-3483797301656737919,'LiDAR_Fusion_with_Scene/Scene_01/camera_image_1/08.jpg','image/jpeg',232567,'x1-community',NULL,NULL,'{\"width\": 1920, \"height\": 1080}','2025-04-11 10:41:06',62,'2025-05-22 12:23:56',62),(125567,'08.jpg','08.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_2/08.jpg',7546618871011961035,'LiDAR_Fusion_with_Scene/Scene_01/camera_image_2/08.jpg','image/jpeg',146888,'x1-community',NULL,NULL,'{\"width\": 1920, \"height\": 1080}','2025-04-11 10:41:06',62,'2025-05-22 12:23:56',62),(125568,'08.jpg','08.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_3/08.jpg',4130964030689064366,'LiDAR_Fusion_with_Scene/Scene_01/camera_image_3/08.jpg','image/jpeg',280216,'x1-community',NULL,NULL,'{\"width\": 1920, \"height\": 1080}','2025-04-11 10:41:06',62,'2025-05-22 12:23:56',62),(125569,'13.pcd','13.pcd','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/lidar_point_cloud_0/13.pcd',1226352452789084767,'LiDAR_Fusion_with_Scene/Scene_01/lidar_point_cloud_0/13.pcd',NULL,4737053,'x1-community',NULL,NULL,NULL,'2025-04-11 10:41:06',62,'2025-05-22 12:23:56',62),(125570,'08.pcd','08.pcd','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/lidar_point_cloud_0/08.pcd',-3637544957954753195,'LiDAR_Fusion_with_Scene/Scene_01/lidar_point_cloud_0/08.pcd',NULL,4671757,'x1-community',NULL,NULL,NULL,'2025-04-11 10:41:06',62,'2025-05-22 12:23:56',62),(125571,'13.jpg','13.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_0/13_large.jpg',-5677477014084026650,NULL,'image/jpeg',NULL,'x1-community',125561,'LARGE_THUMBTHUMBNAIL',NULL,'2025-04-11 10:41:08',62,'2025-05-22 12:23:56',62),(125572,'13.jpg','13.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_0/13_medium.jpg',-3666312443174967907,NULL,'image/jpeg',NULL,'x1-community',125561,'MEDIUM_THUMBTHUMBNAIL',NULL,'2025-04-11 10:41:08',62,'2025-05-22 12:23:56',62),(125573,'13.jpg','13.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_0/13_small.jpg',8661789818339799250,NULL,'image/jpeg',NULL,'x1-community',125561,'SMALL_THUMBTHUMBNAIL',NULL,'2025-04-11 10:41:08',62,'2025-05-22 12:23:56',62),(125574,'13.jpg','13.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_1/13_large.jpg',6092486562504017284,NULL,'image/jpeg',NULL,'x1-community',125562,'LARGE_THUMBTHUMBNAIL',NULL,'2025-04-11 10:41:08',62,'2025-05-22 12:23:56',62),(125575,'13.jpg','13.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_1/13_medium.jpg',1317018172509367858,NULL,'image/jpeg',NULL,'x1-community',125562,'MEDIUM_THUMBTHUMBNAIL',NULL,'2025-04-11 10:41:08',62,'2025-05-22 12:23:56',62),(125576,'13.jpg','13.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_1/13_small.jpg',-8762857173669852998,NULL,'image/jpeg',NULL,'x1-community',125562,'SMALL_THUMBTHUMBNAIL',NULL,'2025-04-11 10:41:08',62,'2025-05-22 12:23:56',62),(125577,'13.jpg','13.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_2/13_large.jpg',4647990741193700377,NULL,'image/jpeg',NULL,'x1-community',125564,'LARGE_THUMBTHUMBNAIL',NULL,'2025-04-11 10:41:08',62,'2025-05-22 12:23:56',62),(125578,'13.jpg','13.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_2/13_medium.jpg',8937092592344587517,NULL,'image/jpeg',NULL,'x1-community',125564,'MEDIUM_THUMBTHUMBNAIL',NULL,'2025-04-11 10:41:08',62,'2025-05-22 12:23:56',62),(125579,'13.jpg','13.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_2/13_small.jpg',-1546054908580300332,NULL,'image/jpeg',NULL,'x1-community',125564,'SMALL_THUMBTHUMBNAIL',NULL,'2025-04-11 10:41:08',62,'2025-05-22 12:23:56',62),(125580,'13.jpg','13.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_3/13_large.jpg',-933131621118704309,NULL,'image/jpeg',NULL,'x1-community',125565,'LARGE_THUMBTHUMBNAIL',NULL,'2025-04-11 10:41:08',62,'2025-05-22 12:23:56',62),(125581,'13.jpg','13.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_3/13_medium.jpg',-5675205799869578645,NULL,'image/jpeg',NULL,'x1-community',125565,'MEDIUM_THUMBTHUMBNAIL',NULL,'2025-04-11 10:41:08',62,'2025-05-22 12:23:56',62),(125582,'13.jpg','13.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_3/13_small.jpg',4671037378002576971,NULL,'image/jpeg',NULL,'x1-community',125565,'SMALL_THUMBTHUMBNAIL',NULL,'2025-04-11 10:41:08',62,'2025-05-22 12:23:56',62),(125583,'08.jpg','08.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_0/08_large.jpg',-5156799728242397435,NULL,'image/jpeg',NULL,'x1-community',125563,'LARGE_THUMBTHUMBNAIL',NULL,'2025-04-11 10:41:08',62,'2025-05-22 12:23:56',62),(125584,'08.jpg','08.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_0/08_medium.jpg',6030575985573335353,NULL,'image/jpeg',NULL,'x1-community',125563,'MEDIUM_THUMBTHUMBNAIL',NULL,'2025-04-11 10:41:08',62,'2025-05-22 12:23:56',62),(125585,'08.jpg','08.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_0/08_small.jpg',8268587062119496941,NULL,'image/jpeg',NULL,'x1-community',125563,'SMALL_THUMBTHUMBNAIL',NULL,'2025-04-11 10:41:08',62,'2025-05-22 12:23:56',62),(125586,'08.jpg','08.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_1/08_large.jpg',6161769861462647145,NULL,'image/jpeg',NULL,'x1-community',125566,'LARGE_THUMBTHUMBNAIL',NULL,'2025-04-11 10:41:08',62,'2025-05-22 12:23:57',62),(125587,'08.jpg','08.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_1/08_medium.jpg',4189101381080498120,NULL,'image/jpeg',NULL,'x1-community',125566,'MEDIUM_THUMBTHUMBNAIL',NULL,'2025-04-11 10:41:08',62,'2025-05-22 12:23:57',62),(125588,'08.jpg','08.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_1/08_small.jpg',-2753501878296519287,NULL,'image/jpeg',NULL,'x1-community',125566,'SMALL_THUMBTHUMBNAIL',NULL,'2025-04-11 10:41:08',62,'2025-05-22 12:23:57',62),(125589,'08.jpg','08.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_2/08_large.jpg',9040137142605856992,NULL,'image/jpeg',NULL,'x1-community',125567,'LARGE_THUMBTHUMBNAIL',NULL,'2025-04-11 10:41:08',62,'2025-05-22 12:23:57',62),(125590,'08.jpg','08.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_2/08_medium.jpg',-1859433441055387841,NULL,'image/jpeg',NULL,'x1-community',125567,'MEDIUM_THUMBTHUMBNAIL',NULL,'2025-04-11 10:41:08',62,'2025-05-22 12:23:57',62),(125591,'08.jpg','08.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_2/08_small.jpg',-6101067441971976201,NULL,'image/jpeg',NULL,'x1-community',125567,'SMALL_THUMBTHUMBNAIL',NULL,'2025-04-11 10:41:08',62,'2025-05-22 12:23:57',62),(125592,'08.jpg','08.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_3/08_large.jpg',2164174239500389669,NULL,'image/jpeg',NULL,'x1-community',125568,'LARGE_THUMBTHUMBNAIL',NULL,'2025-04-11 10:41:08',62,'2025-05-22 12:23:57',62),(125593,'08.jpg','08.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_3/08_medium.jpg',4287466084111300744,NULL,'image/jpeg',NULL,'x1-community',125568,'MEDIUM_THUMBTHUMBNAIL',NULL,'2025-04-11 10:41:08',62,'2025-05-22 12:23:57',62),(125594,'08.jpg','08.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_3/08_small.jpg',-3861812006667659900,NULL,'image/jpeg',NULL,'x1-community',125568,'SMALL_THUMBTHUMBNAIL',NULL,'2025-04-11 10:41:08',62,'2025-05-22 12:23:57',62),(125595,'14.json','14.json','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_config/14.json',-3782769693423187122,'LiDAR_Fusion_with_Scene/Scene_01/camera_config/14.json','application/json',2975,'x1-community',NULL,NULL,NULL,'2025-04-11 10:41:20',62,'2025-05-22 12:23:57',62),(125596,'09.json','09.json','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_config/09.json',-6070530395579950590,'LiDAR_Fusion_with_Scene/Scene_01/camera_config/09.json','application/json',2944,'x1-community',NULL,NULL,NULL,'2025-04-11 10:41:20',62,'2025-05-22 12:23:57',62),(125597,'09.jpg','09.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_0/09.jpg',-7670862598953570761,'LiDAR_Fusion_with_Scene/Scene_01/camera_image_0/09.jpg','image/jpeg',227641,'x1-community',NULL,NULL,'{\"width\": 1920, \"height\": 1080}','2025-04-11 10:41:20',62,'2025-05-22 12:23:57',62),(125598,'14.jpg','14.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_0/14.jpg',-7513401248139283563,'LiDAR_Fusion_with_Scene/Scene_01/camera_image_0/14.jpg','image/jpeg',224431,'x1-community',NULL,NULL,'{\"width\": 1920, \"height\": 1080}','2025-04-11 10:41:20',62,'2025-05-22 12:23:57',62),(125599,'14.jpg','14.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_1/14.jpg',1410978295035524620,'LiDAR_Fusion_with_Scene/Scene_01/camera_image_1/14.jpg','image/jpeg',251632,'x1-community',NULL,NULL,'{\"width\": 1920, \"height\": 1080}','2025-04-11 10:41:20',62,'2025-05-22 12:23:57',62),(125600,'09.jpg','09.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_1/09.jpg',1660406518794473712,'LiDAR_Fusion_with_Scene/Scene_01/camera_image_1/09.jpg','image/jpeg',234267,'x1-community',NULL,NULL,'{\"width\": 1920, \"height\": 1080}','2025-04-11 10:41:20',62,'2025-05-22 12:23:57',62),(125601,'14.jpg','14.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_2/14.jpg',-4129563479097011580,'LiDAR_Fusion_with_Scene/Scene_01/camera_image_2/14.jpg','image/jpeg',148560,'x1-community',NULL,NULL,'{\"width\": 1920, \"height\": 1080}','2025-04-11 10:41:20',62,'2025-05-22 12:23:57',62),(125602,'09.jpg','09.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_2/09.jpg',8089501812065527361,'LiDAR_Fusion_with_Scene/Scene_01/camera_image_2/09.jpg','image/jpeg',149400,'x1-community',NULL,NULL,'{\"width\": 1920, \"height\": 1080}','2025-04-11 10:41:20',62,'2025-05-22 12:23:57',62),(125603,'14.jpg','14.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_3/14.jpg',-3333114810786036943,'LiDAR_Fusion_with_Scene/Scene_01/camera_image_3/14.jpg','image/jpeg',289901,'x1-community',NULL,NULL,'{\"width\": 1920, \"height\": 1080}','2025-04-11 10:41:20',62,'2025-05-22 12:23:57',62),(125604,'09.jpg','09.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_3/09.jpg',1346077602920771443,'LiDAR_Fusion_with_Scene/Scene_01/camera_image_3/09.jpg','image/jpeg',282658,'x1-community',NULL,NULL,'{\"width\": 1920, \"height\": 1080}','2025-04-11 10:41:20',62,'2025-05-22 12:23:57',62),(125605,'09.pcd','09.pcd','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/lidar_point_cloud_0/09.pcd',-4195174549707279422,'LiDAR_Fusion_with_Scene/Scene_01/lidar_point_cloud_0/09.pcd',NULL,4659745,'x1-community',NULL,NULL,NULL,'2025-04-11 10:41:20',62,'2025-05-22 12:23:57',62),(125606,'14.pcd','14.pcd','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/lidar_point_cloud_0/14.pcd',-2755927566396462638,'LiDAR_Fusion_with_Scene/Scene_01/lidar_point_cloud_0/14.pcd',NULL,4761413,'x1-community',NULL,NULL,NULL,'2025-04-11 10:41:20',62,'2025-05-22 12:23:57',62),(125607,'14.jpg','14.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_0/14_large.jpg',7078356730303799539,NULL,'image/jpeg',NULL,'x1-community',125598,'LARGE_THUMBTHUMBNAIL',NULL,'2025-04-11 10:41:21',62,'2025-05-22 12:23:57',62),(125608,'14.jpg','14.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_0/14_medium.jpg',6669192715850075910,NULL,'image/jpeg',NULL,'x1-community',125598,'MEDIUM_THUMBTHUMBNAIL',NULL,'2025-04-11 10:41:21',62,'2025-05-22 12:23:57',62),(125609,'14.jpg','14.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_0/14_small.jpg',-8349217268511527584,NULL,'image/jpeg',NULL,'x1-community',125598,'SMALL_THUMBTHUMBNAIL',NULL,'2025-04-11 10:41:21',62,'2025-05-22 12:23:57',62),(125610,'14.jpg','14.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_1/14_large.jpg',-4061627426100057504,NULL,'image/jpeg',NULL,'x1-community',125599,'LARGE_THUMBTHUMBNAIL',NULL,'2025-04-11 10:41:21',62,'2025-05-22 12:23:57',62),(125611,'14.jpg','14.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_1/14_medium.jpg',1961897660534171781,NULL,'image/jpeg',NULL,'x1-community',125599,'MEDIUM_THUMBTHUMBNAIL',NULL,'2025-04-11 10:41:21',62,'2025-05-22 12:23:57',62),(125612,'14.jpg','14.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_1/14_small.jpg',6040725238237288668,NULL,'image/jpeg',NULL,'x1-community',125599,'SMALL_THUMBTHUMBNAIL',NULL,'2025-04-11 10:41:21',62,'2025-05-22 12:23:57',62),(125613,'14.jpg','14.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_2/14_large.jpg',8333788242385893700,NULL,'image/jpeg',NULL,'x1-community',125601,'LARGE_THUMBTHUMBNAIL',NULL,'2025-04-11 10:41:21',62,'2025-05-22 12:23:57',62),(125614,'14.jpg','14.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_2/14_medium.jpg',-7687869974213846297,NULL,'image/jpeg',NULL,'x1-community',125601,'MEDIUM_THUMBTHUMBNAIL',NULL,'2025-04-11 10:41:21',62,'2025-05-22 12:23:57',62),(125615,'14.jpg','14.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_2/14_small.jpg',7449771131539800153,NULL,'image/jpeg',NULL,'x1-community',125601,'SMALL_THUMBTHUMBNAIL',NULL,'2025-04-11 10:41:21',62,'2025-05-22 12:23:57',62),(125616,'14.jpg','14.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_3/14_large.jpg',545629416042083371,NULL,'image/jpeg',NULL,'x1-community',125603,'LARGE_THUMBTHUMBNAIL',NULL,'2025-04-11 10:41:21',62,'2025-05-22 12:23:57',62),(125617,'14.jpg','14.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_3/14_medium.jpg',-7186038106777584787,NULL,'image/jpeg',NULL,'x1-community',125603,'MEDIUM_THUMBTHUMBNAIL',NULL,'2025-04-11 10:41:21',62,'2025-05-22 12:23:57',62),(125618,'09.jpg','09.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_0/09_large.jpg',-805322935897861047,NULL,'image/jpeg',NULL,'x1-community',125597,'LARGE_THUMBTHUMBNAIL',NULL,'2025-04-11 10:41:21',62,'2025-05-22 12:23:57',62),(125619,'14.jpg','14.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_3/14_small.jpg',1091237957062817056,NULL,'image/jpeg',NULL,'x1-community',125603,'SMALL_THUMBTHUMBNAIL',NULL,'2025-04-11 10:41:21',62,'2025-05-22 12:23:57',62),(125620,'09.jpg','09.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_0/09_medium.jpg',5080586564915896731,NULL,'image/jpeg',NULL,'x1-community',125597,'MEDIUM_THUMBTHUMBNAIL',NULL,'2025-04-11 10:41:21',62,'2025-05-22 12:23:57',62),(125621,'09.jpg','09.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_0/09_small.jpg',6170483199097263594,NULL,'image/jpeg',NULL,'x1-community',125597,'SMALL_THUMBTHUMBNAIL',NULL,'2025-04-11 10:41:21',62,'2025-05-22 12:23:57',62),(125622,'09.jpg','09.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_1/09_large.jpg',4217703449118394685,NULL,'image/jpeg',NULL,'x1-community',125600,'LARGE_THUMBTHUMBNAIL',NULL,'2025-04-11 10:41:21',62,'2025-05-22 12:23:57',62),(125623,'09.jpg','09.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_1/09_medium.jpg',2787989101784817529,NULL,'image/jpeg',NULL,'x1-community',125600,'MEDIUM_THUMBTHUMBNAIL',NULL,'2025-04-11 10:41:21',62,'2025-05-22 12:23:57',62),(125624,'09.jpg','09.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_1/09_small.jpg',-4570009761837490138,NULL,'image/jpeg',NULL,'x1-community',125600,'SMALL_THUMBTHUMBNAIL',NULL,'2025-04-11 10:41:21',62,'2025-05-22 12:23:57',62),(125625,'09.jpg','09.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_2/09_large.jpg',-1912796024975114101,NULL,'image/jpeg',NULL,'x1-community',125602,'LARGE_THUMBTHUMBNAIL',NULL,'2025-04-11 10:41:21',62,'2025-05-22 12:23:57',62),(125626,'09.jpg','09.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_2/09_medium.jpg',-7676299303070605358,NULL,'image/jpeg',NULL,'x1-community',125602,'MEDIUM_THUMBTHUMBNAIL',NULL,'2025-04-11 10:41:21',62,'2025-05-22 12:23:57',62),(125627,'09.jpg','09.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_2/09_small.jpg',5621811699253970167,NULL,'image/jpeg',NULL,'x1-community',125602,'SMALL_THUMBTHUMBNAIL',NULL,'2025-04-11 10:41:21',62,'2025-05-22 12:23:57',62),(125628,'09.jpg','09.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_3/09_large.jpg',-2040861083750953419,NULL,'image/jpeg',NULL,'x1-community',125604,'LARGE_THUMBTHUMBNAIL',NULL,'2025-04-11 10:41:21',62,'2025-05-22 12:23:57',62),(125629,'09.jpg','09.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_3/09_medium.jpg',6732040061451450262,NULL,'image/jpeg',NULL,'x1-community',125604,'MEDIUM_THUMBTHUMBNAIL',NULL,'2025-04-11 10:41:21',62,'2025-05-22 12:23:57',62),(125630,'09.jpg','09.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_3/09_small.jpg',3353981075297395093,NULL,'image/jpeg',NULL,'x1-community',125604,'SMALL_THUMBTHUMBNAIL',NULL,'2025-04-11 10:41:21',62,'2025-05-22 12:23:57',62),(125631,'15.json','15.json','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_config/15.json',5966418647686947362,'LiDAR_Fusion_with_Scene/Scene_01/camera_config/15.json','application/json',2955,'x1-community',NULL,NULL,NULL,'2025-04-11 10:41:22',62,'2025-05-22 12:23:57',62),(125632,'15.jpg','15.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_0/15.jpg',-4914472580413042936,'LiDAR_Fusion_with_Scene/Scene_01/camera_image_0/15.jpg','image/jpeg',224600,'x1-community',NULL,NULL,'{\"width\": 1920, \"height\": 1080}','2025-04-11 10:41:22',62,'2025-05-22 12:23:57',62),(125633,'15.jpg','15.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_1/15.jpg',4782122605634651714,'LiDAR_Fusion_with_Scene/Scene_01/camera_image_1/15.jpg','image/jpeg',255407,'x1-community',NULL,NULL,'{\"width\": 1920, \"height\": 1080}','2025-04-11 10:41:22',62,'2025-05-22 12:23:57',62),(125634,'15.jpg','15.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_2/15.jpg',-5217062905608096142,'LiDAR_Fusion_with_Scene/Scene_01/camera_image_2/15.jpg','image/jpeg',147539,'x1-community',NULL,NULL,'{\"width\": 1920, \"height\": 1080}','2025-04-11 10:41:22',62,'2025-05-22 12:23:57',62),(125635,'15.jpg','15.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_3/15.jpg',1513782739600034300,'LiDAR_Fusion_with_Scene/Scene_01/camera_image_3/15.jpg','image/jpeg',291435,'x1-community',NULL,NULL,'{\"width\": 1920, \"height\": 1080}','2025-04-11 10:41:22',62,'2025-05-22 12:23:57',62),(125636,'15.pcd','15.pcd','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/lidar_point_cloud_0/15.pcd',3975997722514802328,'LiDAR_Fusion_with_Scene/Scene_01/lidar_point_cloud_0/15.pcd',NULL,4800585,'x1-community',NULL,NULL,NULL,'2025-04-11 10:41:22',62,'2025-05-22 12:23:57',62),(125637,'10.json','10.json','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_config/10.json',-323373426482636054,'LiDAR_Fusion_with_Scene/Scene_01/camera_config/10.json','application/json',2957,'x1-community',NULL,NULL,NULL,'2025-04-11 10:41:22',62,'2025-05-22 12:23:57',62),(125638,'10.jpg','10.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_0/10.jpg',-6825638438124821780,'LiDAR_Fusion_with_Scene/Scene_01/camera_image_0/10.jpg','image/jpeg',227097,'x1-community',NULL,NULL,'{\"width\": 1920, \"height\": 1080}','2025-04-11 10:41:22',62,'2025-05-22 12:23:57',62),(125639,'10.jpg','10.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_1/10.jpg',-5066935125937281730,'LiDAR_Fusion_with_Scene/Scene_01/camera_image_1/10.jpg','image/jpeg',236848,'x1-community',NULL,NULL,'{\"width\": 1920, \"height\": 1080}','2025-04-11 10:41:22',62,'2025-05-22 12:23:57',62),(125640,'10.jpg','10.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_2/10.jpg',-4045099929905516324,'LiDAR_Fusion_with_Scene/Scene_01/camera_image_2/10.jpg','image/jpeg',148870,'x1-community',NULL,NULL,'{\"width\": 1920, \"height\": 1080}','2025-04-11 10:41:22',62,'2025-05-22 12:23:57',62),(125641,'10.jpg','10.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_3/10.jpg',5237580858789923006,'LiDAR_Fusion_with_Scene/Scene_01/camera_image_3/10.jpg','image/jpeg',283441,'x1-community',NULL,NULL,'{\"width\": 1920, \"height\": 1080}','2025-04-11 10:41:22',62,'2025-05-22 12:23:57',62),(125642,'10.pcd','10.pcd','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/lidar_point_cloud_0/10.pcd',-7478024566062655141,'LiDAR_Fusion_with_Scene/Scene_01/lidar_point_cloud_0/10.pcd',NULL,4650253,'x1-community',NULL,NULL,NULL,'2025-04-11 10:41:22',62,'2025-05-22 12:23:57',62),(125643,'15.jpg','15.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_0/15_large.jpg',1589787682322340592,NULL,'image/jpeg',NULL,'x1-community',125632,'LARGE_THUMBTHUMBNAIL',NULL,'2025-04-11 10:41:23',62,'2025-05-22 12:23:57',62),(125644,'15.jpg','15.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_0/15_medium.jpg',2720018004831368149,NULL,'image/jpeg',NULL,'x1-community',125632,'MEDIUM_THUMBTHUMBNAIL',NULL,'2025-04-11 10:41:23',62,'2025-05-22 12:23:57',62),(125645,'15.jpg','15.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_0/15_small.jpg',1761667320089352236,NULL,'image/jpeg',NULL,'x1-community',125632,'SMALL_THUMBTHUMBNAIL',NULL,'2025-04-11 10:41:23',62,'2025-05-22 12:23:57',62),(125646,'15.jpg','15.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_1/15_large.jpg',5968536162102651273,NULL,'image/jpeg',NULL,'x1-community',125633,'LARGE_THUMBTHUMBNAIL',NULL,'2025-04-11 10:41:23',62,'2025-05-22 12:23:57',62),(125647,'15.jpg','15.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_1/15_medium.jpg',-5616717427550677829,NULL,'image/jpeg',NULL,'x1-community',125633,'MEDIUM_THUMBTHUMBNAIL',NULL,'2025-04-11 10:41:23',62,'2025-05-22 12:23:57',62),(125648,'15.jpg','15.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_1/15_small.jpg',5986169075460732030,NULL,'image/jpeg',NULL,'x1-community',125633,'SMALL_THUMBTHUMBNAIL',NULL,'2025-04-11 10:41:23',62,'2025-05-22 12:23:57',62),(125649,'15.jpg','15.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_2/15_large.jpg',-6747057950236703151,NULL,'image/jpeg',NULL,'x1-community',125634,'LARGE_THUMBTHUMBNAIL',NULL,'2025-04-11 10:41:23',62,'2025-05-22 12:23:57',62),(125650,'15.jpg','15.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_2/15_medium.jpg',1543200851311365389,NULL,'image/jpeg',NULL,'x1-community',125634,'MEDIUM_THUMBTHUMBNAIL',NULL,'2025-04-11 10:41:23',62,'2025-05-22 12:23:57',62),(125651,'15.jpg','15.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_2/15_small.jpg',-5504863024404486861,NULL,'image/jpeg',NULL,'x1-community',125634,'SMALL_THUMBTHUMBNAIL',NULL,'2025-04-11 10:41:23',62,'2025-05-22 12:23:57',62),(125652,'15.jpg','15.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_3/15_large.jpg',6725569704961654443,NULL,'image/jpeg',NULL,'x1-community',125635,'LARGE_THUMBTHUMBNAIL',NULL,'2025-04-11 10:41:23',62,'2025-05-22 12:23:57',62),(125653,'15.jpg','15.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_3/15_medium.jpg',-1441318661619266747,NULL,'image/jpeg',NULL,'x1-community',125635,'MEDIUM_THUMBTHUMBNAIL',NULL,'2025-04-11 10:41:23',62,'2025-05-22 12:23:57',62),(125654,'15.jpg','15.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_3/15_small.jpg',7356729329262528931,NULL,'image/jpeg',NULL,'x1-community',125635,'SMALL_THUMBTHUMBNAIL',NULL,'2025-04-11 10:41:23',62,'2025-05-22 12:23:57',62),(125655,'10.jpg','10.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_0/10_large.jpg',-2326737893706244984,NULL,'image/jpeg',NULL,'x1-community',125638,'LARGE_THUMBTHUMBNAIL',NULL,'2025-04-11 10:41:23',62,'2025-05-22 12:23:57',62),(125656,'10.jpg','10.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_0/10_medium.jpg',1481135552492719004,NULL,'image/jpeg',NULL,'x1-community',125638,'MEDIUM_THUMBTHUMBNAIL',NULL,'2025-04-11 10:41:23',62,'2025-05-22 12:23:57',62),(125657,'10.jpg','10.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_0/10_small.jpg',-4187396847536218683,NULL,'image/jpeg',NULL,'x1-community',125638,'SMALL_THUMBTHUMBNAIL',NULL,'2025-04-11 10:41:23',62,'2025-05-22 12:23:57',62),(125658,'10.jpg','10.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_1/10_large.jpg',8413308744163858570,NULL,'image/jpeg',NULL,'x1-community',125639,'LARGE_THUMBTHUMBNAIL',NULL,'2025-04-11 10:41:23',62,'2025-05-22 12:23:57',62),(125659,'10.jpg','10.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_1/10_medium.jpg',-6308251104903993538,NULL,'image/jpeg',NULL,'x1-community',125639,'MEDIUM_THUMBTHUMBNAIL',NULL,'2025-04-11 10:41:23',62,'2025-05-22 12:23:57',62),(125660,'10.jpg','10.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_1/10_small.jpg',-8204749435726532375,NULL,'image/jpeg',NULL,'x1-community',125639,'SMALL_THUMBTHUMBNAIL',NULL,'2025-04-11 10:41:23',62,'2025-05-22 12:23:57',62),(125661,'10.jpg','10.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_2/10_large.jpg',-6495687222427972362,NULL,'image/jpeg',NULL,'x1-community',125640,'LARGE_THUMBTHUMBNAIL',NULL,'2025-04-11 10:41:23',62,'2025-05-22 12:23:57',62),(125662,'10.jpg','10.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_2/10_medium.jpg',-1105912172785044480,NULL,'image/jpeg',NULL,'x1-community',125640,'MEDIUM_THUMBTHUMBNAIL',NULL,'2025-04-11 10:41:23',62,'2025-05-22 12:23:57',62),(125663,'10.jpg','10.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_2/10_small.jpg',4858905336257828242,NULL,'image/jpeg',NULL,'x1-community',125640,'SMALL_THUMBTHUMBNAIL',NULL,'2025-04-11 10:41:23',62,'2025-05-22 12:23:57',62),(125664,'10.jpg','10.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_3/10_large.jpg',8826860635096392279,NULL,'image/jpeg',NULL,'x1-community',125641,'LARGE_THUMBTHUMBNAIL',NULL,'2025-04-11 10:41:23',62,'2025-05-22 12:23:57',62),(125665,'10.jpg','10.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_3/10_medium.jpg',-1972047417961783113,NULL,'image/jpeg',NULL,'x1-community',125641,'MEDIUM_THUMBTHUMBNAIL',NULL,'2025-04-11 10:41:23',62,'2025-05-22 12:23:57',62),(125666,'10.jpg','10.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_3/10_small.jpg',-1317719015245409090,NULL,'image/jpeg',NULL,'x1-community',125641,'SMALL_THUMBTHUMBNAIL',NULL,'2025-04-11 10:41:23',62,'2025-05-22 12:23:57',62),(125667,'11.json','11.json','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_config/11.json',-3652042951556109995,'LiDAR_Fusion_with_Scene/Scene_01/camera_config/11.json','application/json',2960,'x1-community',NULL,NULL,NULL,'2025-04-11 10:41:23',62,'2025-05-22 12:23:57',62),(125668,'11.jpg','11.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_0/11.jpg',4013734473726369468,'LiDAR_Fusion_with_Scene/Scene_01/camera_image_0/11.jpg','image/jpeg',226611,'x1-community',NULL,NULL,'{\"width\": 1920, \"height\": 1080}','2025-04-11 10:41:23',62,'2025-05-22 12:23:57',62),(125669,'11.jpg','11.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_1/11.jpg',-7716218466927521924,'LiDAR_Fusion_with_Scene/Scene_01/camera_image_1/11.jpg','image/jpeg',239932,'x1-community',NULL,NULL,'{\"width\": 1920, \"height\": 1080}','2025-04-11 10:41:23',62,'2025-05-22 12:23:57',62),(125670,'11.jpg','11.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_2/11.jpg',8754412876477260911,'LiDAR_Fusion_with_Scene/Scene_01/camera_image_2/11.jpg','image/jpeg',149289,'x1-community',NULL,NULL,'{\"width\": 1920, \"height\": 1080}','2025-04-11 10:41:23',62,'2025-05-22 12:23:57',62),(125671,'11.jpg','11.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_3/11.jpg',5321936711485372015,'LiDAR_Fusion_with_Scene/Scene_01/camera_image_3/11.jpg','image/jpeg',280575,'x1-community',NULL,NULL,'{\"width\": 1920, \"height\": 1080}','2025-04-11 10:41:23',62,'2025-05-22 12:23:57',62),(125672,'11.pcd','11.pcd','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/lidar_point_cloud_0/11.pcd',-6694948811726209888,'LiDAR_Fusion_with_Scene/Scene_01/lidar_point_cloud_0/11.pcd',NULL,4710453,'x1-community',NULL,NULL,NULL,'2025-04-11 10:41:23',62,'2025-05-22 12:23:57',62),(125673,'11.jpg','11.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_0/11_large.jpg',-8569872231949127567,NULL,'image/jpeg',NULL,'x1-community',125668,'LARGE_THUMBTHUMBNAIL',NULL,'2025-04-11 10:41:25',62,'2025-05-22 12:23:57',62),(125674,'11.jpg','11.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_0/11_medium.jpg',-5574110774874540493,NULL,'image/jpeg',NULL,'x1-community',125668,'MEDIUM_THUMBTHUMBNAIL',NULL,'2025-04-11 10:41:25',62,'2025-05-22 12:23:57',62),(125675,'11.jpg','11.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_0/11_small.jpg',444860001008877050,NULL,'image/jpeg',NULL,'x1-community',125668,'SMALL_THUMBTHUMBNAIL',NULL,'2025-04-11 10:41:25',62,'2025-05-22 12:23:57',62),(125676,'11.jpg','11.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_1/11_large.jpg',-1389135095088249819,NULL,'image/jpeg',NULL,'x1-community',125669,'LARGE_THUMBTHUMBNAIL',NULL,'2025-04-11 10:41:25',62,'2025-05-22 12:23:57',62),(125677,'11.jpg','11.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_1/11_medium.jpg',-7067280436105672163,NULL,'image/jpeg',NULL,'x1-community',125669,'MEDIUM_THUMBTHUMBNAIL',NULL,'2025-04-11 10:41:25',62,'2025-05-22 12:23:57',62),(125678,'11.jpg','11.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_1/11_small.jpg',-2936843304231899436,NULL,'image/jpeg',NULL,'x1-community',125669,'SMALL_THUMBTHUMBNAIL',NULL,'2025-04-11 10:41:25',62,'2025-05-22 12:23:57',62),(125679,'11.jpg','11.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_2/11_large.jpg',2877698096032750393,NULL,'image/jpeg',NULL,'x1-community',125670,'LARGE_THUMBTHUMBNAIL',NULL,'2025-04-11 10:41:25',62,'2025-05-22 12:23:57',62),(125680,'11.jpg','11.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_2/11_medium.jpg',-6888894069839526410,NULL,'image/jpeg',NULL,'x1-community',125670,'MEDIUM_THUMBTHUMBNAIL',NULL,'2025-04-11 10:41:25',62,'2025-05-22 12:23:57',62),(125681,'11.jpg','11.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_2/11_small.jpg',3650011120593162091,NULL,'image/jpeg',NULL,'x1-community',125670,'SMALL_THUMBTHUMBNAIL',NULL,'2025-04-11 10:41:25',62,'2025-05-22 12:23:57',62),(125682,'11.jpg','11.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_3/11_large.jpg',-8328255503100940966,NULL,'image/jpeg',NULL,'x1-community',125671,'LARGE_THUMBTHUMBNAIL',NULL,'2025-04-11 10:41:25',62,'2025-05-22 12:23:57',62),(125683,'11.jpg','11.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_3/11_medium.jpg',-2861552582980581261,NULL,'image/jpeg',NULL,'x1-community',125671,'MEDIUM_THUMBTHUMBNAIL',NULL,'2025-04-11 10:41:25',62,'2025-05-22 12:23:57',62),(125684,'11.jpg','11.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_3/11_small.jpg',2759075469809683778,NULL,'image/jpeg',NULL,'x1-community',125671,'SMALL_THUMBTHUMBNAIL',NULL,'2025-04-11 10:41:25',62,'2025-05-22 12:23:57',62),(125685,'12.json','12.json','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_config/12.json',-693762348590672726,'LiDAR_Fusion_with_Scene/Scene_01/camera_config/12.json','application/json',2952,'x1-community',NULL,NULL,NULL,'2025-04-11 10:41:25',62,'2025-05-22 12:23:57',62),(125686,'12.jpg','12.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_0/12.jpg',1403235015963832298,'LiDAR_Fusion_with_Scene/Scene_01/camera_image_0/12.jpg','image/jpeg',226056,'x1-community',NULL,NULL,'{\"width\": 1920, \"height\": 1080}','2025-04-11 10:41:25',62,'2025-05-22 12:23:57',62),(125687,'12.jpg','12.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_1/12.jpg',-2565518607821890743,'LiDAR_Fusion_with_Scene/Scene_01/camera_image_1/12.jpg','image/jpeg',242803,'x1-community',NULL,NULL,'{\"width\": 1920, \"height\": 1080}','2025-04-11 10:41:25',62,'2025-05-22 12:23:57',62),(125688,'12.jpg','12.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_2/12.jpg',-3486357393796289783,'LiDAR_Fusion_with_Scene/Scene_01/camera_image_2/12.jpg','image/jpeg',149228,'x1-community',NULL,NULL,'{\"width\": 1920, \"height\": 1080}','2025-04-11 10:41:25',62,'2025-05-22 12:23:57',62),(125689,'12.jpg','12.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_3/12.jpg',-2268201543362386479,'LiDAR_Fusion_with_Scene/Scene_01/camera_image_3/12.jpg','image/jpeg',283863,'x1-community',NULL,NULL,'{\"width\": 1920, \"height\": 1080}','2025-04-11 10:41:25',62,'2025-05-22 12:23:57',62),(125690,'12.pcd','12.pcd','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/lidar_point_cloud_0/12.pcd',4905452439239849398,'LiDAR_Fusion_with_Scene/Scene_01/lidar_point_cloud_0/12.pcd',NULL,4702193,'x1-community',NULL,NULL,NULL,'2025-04-11 10:41:25',62,'2025-05-22 12:23:57',62),(125691,'12.jpg','12.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_0/12_large.jpg',-4541839359078378440,NULL,'image/jpeg',NULL,'x1-community',125686,'LARGE_THUMBTHUMBNAIL',NULL,'2025-04-11 10:41:26',62,'2025-05-22 12:23:57',62),(125692,'12.jpg','12.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_0/12_medium.jpg',2716922852352712041,NULL,'image/jpeg',NULL,'x1-community',125686,'MEDIUM_THUMBTHUMBNAIL',NULL,'2025-04-11 10:41:26',62,'2025-05-22 12:23:57',62),(125693,'12.jpg','12.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_0/12_small.jpg',4227489036535545123,NULL,'image/jpeg',NULL,'x1-community',125686,'SMALL_THUMBTHUMBNAIL',NULL,'2025-04-11 10:41:26',62,'2025-05-22 12:23:57',62),(125694,'12.jpg','12.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_1/12_large.jpg',6906067042309229414,NULL,'image/jpeg',NULL,'x1-community',125687,'LARGE_THUMBTHUMBNAIL',NULL,'2025-04-11 10:41:26',62,'2025-05-22 12:23:57',62),(125695,'12.jpg','12.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_1/12_medium.jpg',1389792276221196098,NULL,'image/jpeg',NULL,'x1-community',125687,'MEDIUM_THUMBTHUMBNAIL',NULL,'2025-04-11 10:41:26',62,'2025-05-22 12:23:57',62),(125696,'12.jpg','12.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_1/12_small.jpg',-1348813495086669403,NULL,'image/jpeg',NULL,'x1-community',125687,'SMALL_THUMBTHUMBNAIL',NULL,'2025-04-11 10:41:26',62,'2025-05-22 12:23:57',62),(125697,'12.jpg','12.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_2/12_large.jpg',-6770682821746872986,NULL,'image/jpeg',NULL,'x1-community',125688,'LARGE_THUMBTHUMBNAIL',NULL,'2025-04-11 10:41:26',62,'2025-05-22 12:23:57',62),(125698,'12.jpg','12.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_2/12_medium.jpg',7443951033396922842,NULL,'image/jpeg',NULL,'x1-community',125688,'MEDIUM_THUMBTHUMBNAIL',NULL,'2025-04-11 10:41:26',62,'2025-05-22 12:23:57',62),(125699,'12.jpg','12.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_2/12_small.jpg',-4642948280862563941,NULL,'image/jpeg',NULL,'x1-community',125688,'SMALL_THUMBTHUMBNAIL',NULL,'2025-04-11 10:41:26',62,'2025-05-22 12:23:57',62),(125700,'12.jpg','12.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_3/12_large.jpg',8832827156537633443,NULL,'image/jpeg',NULL,'x1-community',125689,'LARGE_THUMBTHUMBNAIL',NULL,'2025-04-11 10:41:26',62,'2025-05-22 12:23:57',62),(125701,'12.jpg','12.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_3/12_medium.jpg',2457603655889747125,NULL,'image/jpeg',NULL,'x1-community',125689,'MEDIUM_THUMBTHUMBNAIL',NULL,'2025-04-11 10:41:26',62,'2025-05-22 12:23:57',62),(125702,'12.jpg','12.jpg','62/17/71330cbf1ca94e529ba7530d910030ac/LiDAR_Fusion_with_Scene/Scene_01/camera_image_3/12_small.jpg',8294882596867572331,NULL,'image/jpeg',NULL,'x1-community',125689,'SMALL_THUMBTHUMBNAIL',NULL,'2025-04-11 10:41:26',62,'2025-05-22 12:23:57',62),(125703,'13.pcd','13.pcd','62/20/57ea4809469545c0bf6371f19f099cf3/LiDAR_Basic_with_Scene/Scene_01/lidar_point_cloud_0/13.pcd',5752888189137331007,'LiDAR_Basic_with_Scene/Scene_01/lidar_point_cloud_0/13.pcd',NULL,4737053,'x1-community',NULL,NULL,NULL,'2025-04-11 11:07:21',62,'2025-05-22 12:23:57',62),(125704,'08.pcd','08.pcd','62/20/57ea4809469545c0bf6371f19f099cf3/LiDAR_Basic_with_Scene/Scene_01/lidar_point_cloud_0/08.pcd',-9062904214780661287,'LiDAR_Basic_with_Scene/Scene_01/lidar_point_cloud_0/08.pcd',NULL,4671757,'x1-community',NULL,NULL,NULL,'2025-04-11 11:07:21',62,'2025-05-22 12:23:57',62),(125705,'14.pcd','14.pcd','62/20/57ea4809469545c0bf6371f19f099cf3/LiDAR_Basic_with_Scene/Scene_01/lidar_point_cloud_0/14.pcd',790419192593654180,'LiDAR_Basic_with_Scene/Scene_01/lidar_point_cloud_0/14.pcd',NULL,4761413,'x1-community',NULL,NULL,NULL,'2025-04-11 11:07:24',62,'2025-05-22 12:23:57',62),(125706,'09.pcd','09.pcd','62/20/57ea4809469545c0bf6371f19f099cf3/LiDAR_Basic_with_Scene/Scene_01/lidar_point_cloud_0/09.pcd',-5620646588306763781,'LiDAR_Basic_with_Scene/Scene_01/lidar_point_cloud_0/09.pcd',NULL,4659745,'x1-community',NULL,NULL,NULL,'2025-04-11 11:07:24',62,'2025-05-22 12:23:57',62),(125707,'10.pcd','10.pcd','62/20/57ea4809469545c0bf6371f19f099cf3/LiDAR_Basic_with_Scene/Scene_01/lidar_point_cloud_0/10.pcd',-6703701036039097465,'LiDAR_Basic_with_Scene/Scene_01/lidar_point_cloud_0/10.pcd',NULL,4650253,'x1-community',NULL,NULL,NULL,'2025-04-11 11:07:24',62,'2025-05-22 12:23:57',62),(125708,'15.pcd','15.pcd','62/20/57ea4809469545c0bf6371f19f099cf3/LiDAR_Basic_with_Scene/Scene_01/lidar_point_cloud_0/15.pcd',-3257697963444888276,'LiDAR_Basic_with_Scene/Scene_01/lidar_point_cloud_0/15.pcd',NULL,4800585,'x1-community',NULL,NULL,NULL,'2025-04-11 11:07:24',62,'2025-05-22 12:23:57',62),(125709,'11.pcd','11.pcd','62/20/57ea4809469545c0bf6371f19f099cf3/LiDAR_Basic_with_Scene/Scene_01/lidar_point_cloud_0/11.pcd',5450018331654314540,'LiDAR_Basic_with_Scene/Scene_01/lidar_point_cloud_0/11.pcd',NULL,4710453,'x1-community',NULL,NULL,NULL,'2025-04-11 11:07:24',62,'2025-05-22 12:23:57',62),(125710,'12.pcd','12.pcd','62/20/57ea4809469545c0bf6371f19f099cf3/LiDAR_Basic_with_Scene/Scene_01/lidar_point_cloud_0/12.pcd',-5292262109158923035,'LiDAR_Basic_with_Scene/Scene_01/lidar_point_cloud_0/12.pcd',NULL,4702193,'x1-community',NULL,NULL,NULL,'2025-04-11 11:07:25',62,'2025-05-22 12:23:57',62),(125711,'13.pcd','13.pcd','62/17/77d6610c59ad4526b1812c9b530a42e7/LiDAR_Basic_with_Scene/Scene_01/lidar_point_cloud_0/13.pcd',3929841314899949649,'LiDAR_Basic_with_Scene/Scene_01/lidar_point_cloud_0/13.pcd',NULL,4737053,'x1-community',NULL,NULL,NULL,'2025-04-11 16:25:35',62,'2025-05-22 12:23:57',62),(125712,'08.pcd','08.pcd','62/17/77d6610c59ad4526b1812c9b530a42e7/LiDAR_Basic_with_Scene/Scene_01/lidar_point_cloud_0/08.pcd',6088620340699736897,'LiDAR_Basic_with_Scene/Scene_01/lidar_point_cloud_0/08.pcd',NULL,4671757,'x1-community',NULL,NULL,NULL,'2025-04-11 16:25:35',62,'2025-05-22 12:23:57',62),(125713,'09.pcd','09.pcd','62/17/77d6610c59ad4526b1812c9b530a42e7/LiDAR_Basic_with_Scene/Scene_01/lidar_point_cloud_0/09.pcd',4087915848602871689,'LiDAR_Basic_with_Scene/Scene_01/lidar_point_cloud_0/09.pcd',NULL,4659745,'x1-community',NULL,NULL,NULL,'2025-04-11 16:25:38',62,'2025-05-22 12:23:57',62),(125714,'14.pcd','14.pcd','62/17/77d6610c59ad4526b1812c9b530a42e7/LiDAR_Basic_with_Scene/Scene_01/lidar_point_cloud_0/14.pcd',1146267691020123744,'LiDAR_Basic_with_Scene/Scene_01/lidar_point_cloud_0/14.pcd',NULL,4761413,'x1-community',NULL,NULL,NULL,'2025-04-11 16:25:38',62,'2025-05-22 12:23:57',62),(125715,'10.pcd','10.pcd','62/17/77d6610c59ad4526b1812c9b530a42e7/LiDAR_Basic_with_Scene/Scene_01/lidar_point_cloud_0/10.pcd',908718312440510871,'LiDAR_Basic_with_Scene/Scene_01/lidar_point_cloud_0/10.pcd',NULL,4650253,'x1-community',NULL,NULL,NULL,'2025-04-11 16:25:38',62,'2025-05-22 12:23:57',62),(125716,'15.pcd','15.pcd','62/17/77d6610c59ad4526b1812c9b530a42e7/LiDAR_Basic_with_Scene/Scene_01/lidar_point_cloud_0/15.pcd',277097442499294013,'LiDAR_Basic_with_Scene/Scene_01/lidar_point_cloud_0/15.pcd',NULL,4800585,'x1-community',NULL,NULL,NULL,'2025-04-11 16:25:38',62,'2025-05-22 12:23:57',62),(125717,'11.pcd','11.pcd','62/17/77d6610c59ad4526b1812c9b530a42e7/LiDAR_Basic_with_Scene/Scene_01/lidar_point_cloud_0/11.pcd',-4862402577747294874,'LiDAR_Basic_with_Scene/Scene_01/lidar_point_cloud_0/11.pcd',NULL,4710453,'x1-community',NULL,NULL,NULL,'2025-04-11 16:25:39',62,'2025-05-22 12:23:57',62),(125718,'12.pcd','12.pcd','62/17/77d6610c59ad4526b1812c9b530a42e7/LiDAR_Basic_with_Scene/Scene_01/lidar_point_cloud_0/12.pcd',8184771528425193629,'LiDAR_Basic_with_Scene/Scene_01/lidar_point_cloud_0/12.pcd',NULL,4702193,'x1-community',NULL,NULL,NULL,'2025-04-11 16:25:39',62,'2025-05-22 12:23:57',62),(125719,'13.pcd','13.pcd','62/21/f096462869504b7b9d1688adab546126/LiDAR_Basic_with_Scene/Scene_01/lidar_point_cloud_0/13.pcd',-3937792180137056260,'LiDAR_Basic_with_Scene/Scene_01/lidar_point_cloud_0/13.pcd',NULL,4737053,'x1-community',NULL,NULL,NULL,'2025-04-11 16:26:21',62,'2025-05-22 12:23:57',62),(125720,'08.pcd','08.pcd','62/21/f096462869504b7b9d1688adab546126/LiDAR_Basic_with_Scene/Scene_01/lidar_point_cloud_0/08.pcd',-5587535680736250115,'LiDAR_Basic_with_Scene/Scene_01/lidar_point_cloud_0/08.pcd',NULL,4671757,'x1-community',NULL,NULL,NULL,'2025-04-11 16:26:21',62,'2025-05-22 12:23:57',62),(125721,'09.pcd','09.pcd','62/21/f096462869504b7b9d1688adab546126/LiDAR_Basic_with_Scene/Scene_01/lidar_point_cloud_0/09.pcd',-5849116168217494527,'LiDAR_Basic_with_Scene/Scene_01/lidar_point_cloud_0/09.pcd',NULL,4659745,'x1-community',NULL,NULL,NULL,'2025-04-11 16:26:23',62,'2025-05-22 12:23:57',62),(125722,'14.pcd','14.pcd','62/21/f096462869504b7b9d1688adab546126/LiDAR_Basic_with_Scene/Scene_01/lidar_point_cloud_0/14.pcd',-6354514003742560798,'LiDAR_Basic_with_Scene/Scene_01/lidar_point_cloud_0/14.pcd',NULL,4761413,'x1-community',NULL,NULL,NULL,'2025-04-11 16:26:23',62,'2025-05-22 12:23:57',62),(125723,'10.pcd','10.pcd','62/21/f096462869504b7b9d1688adab546126/LiDAR_Basic_with_Scene/Scene_01/lidar_point_cloud_0/10.pcd',-8339007332080456846,'LiDAR_Basic_with_Scene/Scene_01/lidar_point_cloud_0/10.pcd',NULL,4650253,'x1-community',NULL,NULL,NULL,'2025-04-11 16:26:23',62,'2025-05-22 12:23:57',62),(125724,'15.pcd','15.pcd','62/21/f096462869504b7b9d1688adab546126/LiDAR_Basic_with_Scene/Scene_01/lidar_point_cloud_0/15.pcd',8998514792004327633,'LiDAR_Basic_with_Scene/Scene_01/lidar_point_cloud_0/15.pcd',NULL,4800585,'x1-community',NULL,NULL,NULL,'2025-04-11 16:26:23',62,'2025-05-22 12:23:57',62),(125725,'11.pcd','11.pcd','62/21/f096462869504b7b9d1688adab546126/LiDAR_Basic_with_Scene/Scene_01/lidar_point_cloud_0/11.pcd',-973014018811826276,'LiDAR_Basic_with_Scene/Scene_01/lidar_point_cloud_0/11.pcd',NULL,4710453,'x1-community',NULL,NULL,NULL,'2025-04-11 16:26:24',62,'2025-05-22 12:23:57',62),(125726,'12.pcd','12.pcd','62/21/f096462869504b7b9d1688adab546126/LiDAR_Basic_with_Scene/Scene_01/lidar_point_cloud_0/12.pcd',-47935917158225053,'LiDAR_Basic_with_Scene/Scene_01/lidar_point_cloud_0/12.pcd',NULL,4702193,'x1-community',NULL,NULL,NULL,'2025-04-11 16:26:24',62,'2025-05-22 12:23:57',62);
/*!40000 ALTER TABLE `file` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `model`
--

DROP TABLE IF EXISTS `model`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `model` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'Primary key',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `version` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `scenario` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'Scenes',
  `dataset_type` enum('LIDAR_FUSION','LIDAR_BASIC','IMAGE','LIDAR') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'Dataset types supported by this model',
  `model_type` enum('DETECTION') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT 'DETECTION' COMMENT 'Model type',
  `model_code` enum('PRE_LABEL','COCO_80','LIDAR_DETECTION','IMAGE_DETECTION') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'Model''s unique identifier',
  `url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'Model run url',
  `is_deleted` bit(1) NOT NULL DEFAULT b'0',
  `del_unique_key` bigint NOT NULL DEFAULT '0' COMMENT '\nDelete unique flag, 0 when writing, set as primary key id after tombstone',
  `created_at` datetime NOT NULL,
  `created_by` bigint NOT NULL,
  `updated_at` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` bigint DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_name_dataset_type` (`name`,`dataset_type`,`del_unique_key`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `model`
--

LOCK TABLES `model` WRITE;
/*!40000 ALTER TABLE `model` DISABLE KEYS */;
INSERT INTO `model` VALUES (1,'Basic Lidar Object Detection11','v0.1.2','<p>Basic Lidar Object Detection Model empowers you to detect the most common classes precisely and efficiently during lidar and lidar fusion annotation in Autonomous Vehicle Industry.&nbsp;<br><br>• &nbsp;BLOD is a hyper-based methodology invented, trained and maintained by Basic AI&nbsp;<br><br>• &nbsp;BLOD has been testified in more than 20TB production data.&nbsp;<br><br>• &nbsp;BLOD boosts your annotation speed by at least 26%<br><br>• &nbsp;Try it for free now!</p>','[\"Lidar\",\"Lidar fusion\",\"Autonomous Vehicle\",\"Object Detection\"]','LIDAR','DETECTION','LIDAR_DETECTION','http://point-cloud-object-detection:5000/pointCloud/recognition',0x00,0,'2024-08-05 15:01:04',1,NULL,NULL),(2,'COCO Object Detection','v0.1.0','<p>\r\n    The COCO Object Detection Model, trained on MS COCO dataset, empowers you to detect 80 common classes precisely and efficiently. It outputs both bounding boxes and classes.\r\n</p>\r\n<p>\r\n    • &nbsp;It saves your annotation edits by at least 41.3% in 80 COCO classes.\r\n</p>\r\n<p>\r\n    • &nbsp;It is extremely fast. Results can be obtained in a short time.\r\n</p>\r\n<p>\r\n    • &nbsp;It is highly expandable, which allows new models with new datasets and classes to be trained easily. Contact us to know more.\r\n</p>\r\n<p>\r\n    • &nbsp;Try it for FREE now!\r\n</p>','[\"Common Objects Detection\"]','IMAGE','DETECTION','IMAGE_DETECTION','http://image-object-detection:5000/image/recognition ',0x00,0,'2024-08-05 15:01:04',1,NULL,NULL);
/*!40000 ALTER TABLE `model` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `model_class`
--

DROP TABLE IF EXISTS `model_class`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `model_class` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `model_id` bigint NOT NULL COMMENT 'Model ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'Name',
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'Model code',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Create time',
  `created_by` bigint NOT NULL COMMENT 'Creator id',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Update time',
  `updated_by` bigint DEFAULT NULL COMMENT 'Modify person id',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_model_id_code` (`model_id`,`code`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=91 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `model_class`
--

LOCK TABLES `model_class` WRITE;
/*!40000 ALTER TABLE `model_class` DISABLE KEYS */;
INSERT INTO `model_class` VALUES (1,2,'Person','PERSON','2024-08-05 15:01:04',1,NULL,NULL),(2,2,'Bicycle','BICYCLE','2024-08-05 15:01:04',1,NULL,NULL),(3,2,'Car','CAR','2024-08-05 15:01:04',1,NULL,NULL),(4,2,'Motorcycle','MOTORCYCLE','2024-08-05 15:01:04',1,NULL,NULL),(5,2,'Airplane','AIRPLANE','2024-08-05 15:01:04',1,NULL,NULL),(6,2,'Train','TRAIN','2024-08-05 15:01:04',1,NULL,NULL),(7,2,'Truck','TRUCK','2024-08-05 15:01:04',1,NULL,NULL),(8,2,'Boat','BOAT','2024-08-05 15:01:04',1,NULL,NULL),(9,2,'Traffic Light','TRAFFIC LIGHT','2024-08-05 15:01:05',1,NULL,NULL),(10,2,'Fire Hydrant','FIRE HYDRANT','2024-08-05 15:01:05',1,NULL,NULL),(11,2,'Stop Sign','STOP SIGN','2024-08-05 15:01:05',1,NULL,NULL),(12,2,'Parking Meter','PARKING METER','2024-08-05 15:01:05',1,NULL,NULL),(13,2,'Bench','BENCH','2024-08-05 15:01:05',1,NULL,NULL),(14,2,'Bird','BIRD','2024-08-05 15:01:05',1,NULL,NULL),(15,2,'Cat','CAT','2024-08-05 15:01:05',1,NULL,NULL),(16,2,'Dog','DOG','2024-08-05 15:01:05',1,NULL,NULL),(17,2,'Horse','HORSE','2024-08-05 15:01:05',1,NULL,NULL),(18,2,'Sheep','SHEEP','2024-08-05 15:01:05',1,NULL,NULL),(19,2,'Cow','COW','2024-08-05 15:01:05',1,NULL,NULL),(20,2,'Elephant','ELEPHANT','2024-08-05 15:01:05',1,NULL,NULL),(21,2,'Bear','BEAR','2024-08-05 15:01:05',1,NULL,NULL),(22,2,'Zebra','ZEBRA','2024-08-05 15:01:05',1,NULL,NULL),(23,2,'Giraffe','GIRAFFE','2024-08-05 15:01:05',1,NULL,NULL),(24,2,'Backpack','BACKPACK','2024-08-05 15:01:05',1,NULL,NULL),(25,2,'Umbrella','UMBRELLA','2024-08-05 15:01:05',1,NULL,NULL),(26,2,'Handbag','HANDBAG','2024-08-05 15:01:05',1,NULL,NULL),(27,2,'Tie','TIE','2024-08-05 15:01:05',1,NULL,NULL),(28,2,'Suitcase','SUITCASE','2024-08-05 15:01:05',1,NULL,NULL),(29,2,'Frisbee','FRISBEE','2024-08-05 15:01:05',1,NULL,NULL),(30,2,'Skis','SKIS','2024-08-05 15:01:05',1,NULL,NULL),(31,2,'Snowboard','SNOWBOARD','2024-08-05 15:01:05',1,NULL,NULL),(32,2,'Sports Ball','SPORTS BALL','2024-08-05 15:01:05',1,NULL,NULL),(33,2,'Kite','KITE','2024-08-05 15:01:05',1,NULL,NULL),(34,2,'Baseball Bat','BASEBALL BAT','2024-08-05 15:01:05',1,NULL,NULL),(35,2,'Baseball Glove','BASEBALL GLOVE','2024-08-05 15:01:05',1,NULL,NULL),(36,2,'Skateboard','SKATEBOARD','2024-08-05 15:01:05',1,NULL,NULL),(37,2,'Surfboard','SURFBOARD','2024-08-05 15:01:05',1,NULL,NULL),(38,2,'Tennis Racket','TENNIS RACKET','2024-08-05 15:01:05',1,NULL,NULL),(39,2,'Bottle','BOTTLE','2024-08-05 15:01:05',1,NULL,NULL),(40,2,'Wine Glass','WINE GLASS','2024-08-05 15:01:05',1,NULL,NULL),(41,2,'Cup','CUP','2024-08-05 15:01:05',1,NULL,NULL),(42,2,'Fork','FORK','2024-08-05 15:01:05',1,NULL,NULL),(43,2,'Knife','KNIFE','2024-08-05 15:01:05',1,NULL,NULL),(44,2,'Spoon','SPOON','2024-08-05 15:01:05',1,NULL,NULL),(45,2,'Bowl','BOWL','2024-08-05 15:01:05',1,NULL,NULL),(46,2,'Banana','BANANA','2024-08-05 15:01:05',1,NULL,NULL),(47,2,'Apple','APPLE','2024-08-05 15:01:05',1,NULL,NULL),(48,2,'Sandwich','SANDWICH','2024-08-05 15:01:05',1,NULL,NULL),(49,2,'Orange','ORANGE','2024-08-05 15:01:05',1,NULL,NULL),(50,2,'Broccoli','BROCCOLI','2024-08-05 15:01:05',1,NULL,NULL),(51,2,'Carrot','CARROT','2024-08-05 15:01:05',1,NULL,NULL),(52,2,'Hot Dog','HOT DOG','2024-08-05 15:01:05',1,NULL,NULL),(53,2,'Pizza','PIZZA','2024-08-05 15:01:05',1,NULL,NULL),(54,2,'Donut','DONUT','2024-08-05 15:01:05',1,NULL,NULL),(55,2,'Cake','CAKE','2024-08-05 15:01:05',1,NULL,NULL),(56,2,'Chair','CHAIR','2024-08-05 15:01:05',1,NULL,NULL),(57,2,'Couch','COUCH','2024-08-05 15:01:05',1,NULL,NULL),(58,2,'Potted Plant','POTTED PLANT','2024-08-05 15:01:05',1,NULL,NULL),(59,2,'Bed','BED','2024-08-05 15:01:05',1,NULL,NULL),(60,2,'Dining Table','DINING TABLE','2024-08-05 15:01:05',1,NULL,NULL),(61,2,'Toilet','TOILET','2024-08-05 15:01:05',1,NULL,NULL),(62,2,'Tv','TV','2024-08-05 15:01:05',1,NULL,NULL),(63,2,'Laptop','LAPTOP','2024-08-05 15:01:05',1,NULL,NULL),(64,2,'Mouse','MOUSE','2024-08-05 15:01:05',1,NULL,NULL),(65,2,'Remote','REMOTE','2024-08-05 15:01:05',1,NULL,NULL),(66,2,'Keyboard','KEYBOARD','2024-08-05 15:01:05',1,NULL,NULL),(67,2,'Cell Phone','CELL PHONE','2024-08-05 15:01:05',1,NULL,NULL),(68,2,'Microwave','MICROWAVE','2024-08-05 15:01:05',1,NULL,NULL),(69,2,'Oven','OVEN','2024-08-05 15:01:05',1,NULL,NULL),(70,2,'Toaster','TOASTER','2024-08-05 15:01:05',1,NULL,NULL),(71,2,'Sink','SINK','2024-08-05 15:01:05',1,NULL,NULL),(72,2,'Refrigerator','REFRIGERATOR','2024-08-05 15:01:05',1,NULL,NULL),(73,2,'Book','BOOK','2024-08-05 15:01:05',1,NULL,NULL),(74,2,'Clock','CLOCK','2024-08-05 15:01:05',1,NULL,NULL),(75,2,'Vase','VASE','2024-08-05 15:01:05',1,NULL,NULL),(76,2,'Scissors','SCISSORS','2024-08-05 15:01:05',1,NULL,NULL),(77,2,'Teddy Bear','TEDDY BEAR','2024-08-05 15:01:05',1,NULL,NULL),(78,2,'Hair Drier','HAIR DRIER','2024-08-05 15:01:05',1,NULL,NULL),(79,2,'Toothbrush','TOOTHBRUSH','2024-08-05 15:01:05',1,NULL,NULL),(80,2,'Bus','BUS','2024-08-05 15:01:05',1,NULL,NULL),(81,1,'Car','CAR','2024-08-05 15:01:05',1,NULL,NULL),(82,1,'Truck','TRUCK','2024-08-05 15:01:05',1,NULL,NULL),(83,1,'Construction Vehicle','CONSTRUCTION_VEHICLE ','2024-08-05 15:01:05',1,NULL,NULL),(84,1,' Bus','BUS','2024-08-05 15:01:05',1,NULL,NULL),(85,1,'Trailer','TRAILER','2024-08-05 15:01:05',1,NULL,NULL),(86,1,'Barrier','BARRIER','2024-08-05 15:01:05',1,NULL,NULL),(87,1,'Motorcycle','MOTORCYCLE','2024-08-05 15:01:05',1,NULL,NULL),(88,1,'Bicycle','BICYCLE','2024-08-05 15:01:05',1,NULL,NULL),(89,1,'Pedestrian','PEDESTRIAN','2024-08-05 15:01:05',1,NULL,NULL),(90,1,'Traffic Cone','TRAFFIC_CONE','2024-08-05 15:01:05',1,NULL,NULL);
/*!40000 ALTER TABLE `model_class` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `model_data_result`
--

DROP TABLE IF EXISTS `model_data_result`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `model_data_result` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'Primary key',
  `model_id` bigint NOT NULL COMMENT 'Model id',
  `model_version` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'Model version',
  `dataset_id` bigint NOT NULL COMMENT 'Dataset id',
  `data_id` bigint NOT NULL COMMENT 'Data id',
  `model_serial_no` bigint DEFAULT NULL COMMENT 'Serial number',
  `result_filter_param` json DEFAULT NULL COMMENT 'Model results filtering parameters',
  `model_result` json DEFAULT NULL COMMENT 'The result returned by running the model',
  `created_at` datetime NOT NULL COMMENT 'Create time',
  `created_by` bigint DEFAULT NULL COMMENT 'Creator id',
  `updated_at` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'Update time',
  `updated_by` bigint DEFAULT NULL COMMENT 'Modify person id',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_model_serial_no_data_id` (`model_serial_no`,`data_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='Data model result';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `model_data_result`
--

LOCK TABLES `model_data_result` WRITE;
/*!40000 ALTER TABLE `model_data_result` DISABLE KEYS */;
INSERT INTO `model_data_result` VALUES (1,1,'v0.1.2',9,1979,1878775509221441536,'{\"classes\": [\"CAR\", \"TRUCK\", \"CONSTRUCTION_VEHICLE \", \"BUS\", \"TRAILER\", \"BARRIER\", \"MOTORCYCLE\", \"BICYCLE\", \"PEDESTRIAN\", \"TRAFFIC_CONE\"], \"maxConfidence\": 1, \"minConfidence\": 0.5}','{\"code\": \"ERROR\", \"message\": \"service is busy\"}','2025-01-13 20:06:02',60,'2025-01-13 20:06:02',60),(2,1,'v0.1.2',9,1979,1878775541316255744,'{\"classes\": [\"CAR\", \"TRUCK\", \"CONSTRUCTION_VEHICLE \", \"BUS\", \"TRAILER\", \"BARRIER\", \"MOTORCYCLE\", \"BICYCLE\", \"PEDESTRIAN\", \"TRAFFIC_CONE\"], \"maxConfidence\": 1, \"minConfidence\": 0.5}','{\"code\": \"ERROR\", \"message\": \"service is busy\"}','2025-01-13 20:06:10',60,'2025-01-13 20:06:10',60),(3,1,'v0.1.2',9,1979,1878775629937704960,'{\"classes\": [\"CAR\", \"TRUCK\", \"CONSTRUCTION_VEHICLE \", \"BUS\", \"TRAILER\", \"BARRIER\", \"MOTORCYCLE\", \"BICYCLE\", \"PEDESTRIAN\", \"TRAFFIC_CONE\"], \"maxConfidence\": 1, \"minConfidence\": 0.5}','{\"code\": \"ERROR\", \"message\": \"service is busy\"}','2025-01-13 20:06:31',60,'2025-01-13 20:06:31',60),(4,1,'v0.1.2',9,1979,1878775665534763008,'{\"classes\": [\"CAR\", \"TRUCK\", \"CONSTRUCTION_VEHICLE \", \"BUS\", \"TRAILER\", \"BARRIER\", \"MOTORCYCLE\", \"BICYCLE\", \"PEDESTRIAN\", \"TRAFFIC_CONE\"], \"maxConfidence\": 1, \"minConfidence\": 0.5}','{\"code\": \"ERROR\", \"message\": \"service is busy\"}','2025-01-13 20:06:39',60,'2025-01-13 20:06:39',60),(5,1,'v0.1.2',5,17,1878775917327220736,'{\"classes\": [\"CAR\", \"TRUCK\", \"CONSTRUCTION_VEHICLE \", \"BUS\", \"TRAILER\", \"BARRIER\", \"MOTORCYCLE\", \"BICYCLE\", \"PEDESTRIAN\", \"TRAFFIC_CONE\"], \"maxConfidence\": 1, \"minConfidence\": 0.5}','{\"code\": \"ERROR\", \"message\": \"service is busy\"}','2025-01-13 20:07:39',60,'2025-01-13 20:07:39',60),(6,1,'v0.1.2',5,17,1878775979759435776,'{\"classes\": [\"CAR\", \"TRUCK\", \"CONSTRUCTION_VEHICLE \", \"BUS\", \"TRAILER\", \"BARRIER\", \"MOTORCYCLE\", \"BICYCLE\", \"PEDESTRIAN\", \"TRAFFIC_CONE\"], \"maxConfidence\": 1, \"minConfidence\": 0.5}','{\"code\": \"ERROR\", \"message\": \"service is busy\"}','2025-01-13 20:07:54',60,'2025-01-13 20:07:54',60),(7,1,'v0.1.2',5,17,1878776215441571840,'{\"classes\": [\"CAR\", \"TRUCK\", \"CONSTRUCTION_VEHICLE \", \"BUS\", \"TRAILER\", \"BARRIER\", \"MOTORCYCLE\", \"BICYCLE\", \"PEDESTRIAN\", \"TRAFFIC_CONE\"], \"maxConfidence\": 1, \"minConfidence\": 0.5}','{\"code\": \"ERROR\", \"message\": \"service is busy\"}','2025-01-13 20:08:50',60,'2025-01-13 20:08:50',60),(8,1,'v0.1.2',5,17,1878776243639877632,'{\"classes\": [\"CAR\", \"TRUCK\", \"CONSTRUCTION_VEHICLE \", \"BUS\", \"TRAILER\", \"BARRIER\", \"MOTORCYCLE\", \"BICYCLE\", \"PEDESTRIAN\", \"TRAFFIC_CONE\"], \"maxConfidence\": 1, \"minConfidence\": 0.5}','{\"code\": \"ERROR\", \"message\": \"service is busy\"}','2025-01-13 20:08:57',60,'2025-01-13 20:08:57',60),(9,1,'v0.1.2',4,6,1896753631577817088,'{\"classes\": [\"CAR\", \"TRUCK\", \"CONSTRUCTION_VEHICLE \", \"BUS\", \"TRAILER\", \"BARRIER\", \"MOTORCYCLE\", \"BICYCLE\", \"PEDESTRIAN\", \"TRAFFIC_CONE\"], \"maxConfidence\": 1, \"minConfidence\": 0.5}','{\"code\": \"ERROR\", \"message\": \"service is busy\"}','2025-03-04 10:44:40',60,'2025-03-04 10:44:40',60),(10,1,'v0.1.2',7,995,1897217950023204864,'{\"classes\": [\"CAR\", \"TRUCK\", \"CONSTRUCTION_VEHICLE \", \"BUS\", \"TRAILER\", \"BARRIER\", \"MOTORCYCLE\", \"BICYCLE\", \"PEDESTRIAN\", \"TRAFFIC_CONE\"], \"maxConfidence\": 1, \"minConfidence\": 0.5}','{\"code\": \"ERROR\", \"message\": \"service is busy\"}','2025-03-05 17:29:43',60,'2025-03-05 17:29:43',60),(11,1,'v0.1.2',1,2967,1897582175384027136,'{\"classes\": [\"CAR\", \"TRUCK\", \"CONSTRUCTION_VEHICLE \", \"BUS\", \"TRAILER\", \"BARRIER\", \"MOTORCYCLE\", \"BICYCLE\", \"PEDESTRIAN\", \"TRAFFIC_CONE\"], \"maxConfidence\": 1, \"minConfidence\": 0.5}','{\"code\": \"ERROR\", \"message\": \"service is busy\"}','2025-03-06 17:37:01',60,'2025-03-06 17:37:01',60),(12,1,'v0.1.2',21,3982,1911675726339305472,'{\"classes\": [\"CAR\", \"TRUCK\", \"CONSTRUCTION_VEHICLE \", \"BUS\", \"TRAILER\", \"BARRIER\", \"MOTORCYCLE\", \"BICYCLE\", \"PEDESTRIAN\", \"TRAFFIC_CONE\"], \"maxConfidence\": 1, \"minConfidence\": 0.5}','{\"code\": \"ERROR\", \"message\": \"service is busy\"}','2025-04-14 14:59:45',62,'2025-04-14 14:59:47',62),(13,1,'v0.1.2',21,3982,1911683914866438144,'{\"classes\": [\"CAR\", \"TRUCK\", \"CONSTRUCTION_VEHICLE \", \"BUS\", \"TRAILER\", \"BARRIER\", \"MOTORCYCLE\", \"BICYCLE\", \"PEDESTRIAN\", \"TRAFFIC_CONE\"], \"maxConfidence\": 1, \"minConfidence\": 0.5}','{\"code\": \"ERROR\", \"message\": \"service is busy\"}','2025-04-14 15:32:17',62,'2025-04-14 15:32:19',62),(14,1,'v0.1.2',21,3982,1912442103182454784,'{\"classes\": [\"CAR\", \"TRUCK\", \"CONSTRUCTION_VEHICLE \", \"BUS\", \"TRAILER\", \"BARRIER\", \"MOTORCYCLE\", \"BICYCLE\", \"PEDESTRIAN\", \"TRAFFIC_CONE\"], \"maxConfidence\": 1, \"minConfidence\": 0.5}','{\"code\": \"ERROR\", \"message\": \"service is busy\"}','2025-04-16 17:45:04',62,'2025-04-16 17:45:07',62),(15,1,'v0.1.2',21,3982,1912442107133489152,'{\"classes\": [\"CAR\", \"TRUCK\", \"CONSTRUCTION_VEHICLE \", \"BUS\", \"TRAILER\", \"BARRIER\", \"MOTORCYCLE\", \"BICYCLE\", \"PEDESTRIAN\", \"TRAFFIC_CONE\"], \"maxConfidence\": 1, \"minConfidence\": 0.5}','{\"code\": \"ERROR\", \"message\": \"service is busy\"}','2025-04-16 17:45:04',62,'2025-04-16 17:45:07',62),(16,1,'v0.1.2',21,3982,1912442110585401344,'{\"classes\": [\"CAR\", \"TRUCK\", \"CONSTRUCTION_VEHICLE \", \"BUS\", \"TRAILER\", \"BARRIER\", \"MOTORCYCLE\", \"BICYCLE\", \"PEDESTRIAN\", \"TRAFFIC_CONE\"], \"maxConfidence\": 1, \"minConfidence\": 0.5}','{\"code\": \"ERROR\", \"message\": \"service is busy\"}','2025-04-16 17:45:05',62,'2025-04-16 17:45:07',62),(17,1,'v0.1.2',21,3982,1912465987113906176,'{\"classes\": [\"CAR\", \"TRUCK\", \"CONSTRUCTION_VEHICLE \", \"BUS\", \"TRAILER\", \"BARRIER\", \"MOTORCYCLE\", \"BICYCLE\", \"PEDESTRIAN\", \"TRAFFIC_CONE\"], \"maxConfidence\": 1, \"minConfidence\": 0.5}','{\"code\": \"ERROR\", \"message\": \"service is busy\"}','2025-04-16 19:19:58',62,'2025-04-16 19:20:00',62),(18,1,'v0.1.2',21,3982,1914146991708913664,'{\"classes\": [\"CAR\", \"TRUCK\", \"CONSTRUCTION_VEHICLE \", \"BUS\", \"TRAILER\", \"BARRIER\", \"MOTORCYCLE\", \"BICYCLE\", \"PEDESTRIAN\", \"TRAFFIC_CONE\"], \"maxConfidence\": 1, \"minConfidence\": 0.5}','{\"code\": \"ERROR\", \"message\": \"service is busy\"}','2025-04-21 10:39:41',62,'2025-04-21 10:39:43',62),(19,1,'v0.1.2',21,3982,1914212300067258368,'{\"classes\": [\"CAR\", \"TRUCK\", \"CONSTRUCTION_VEHICLE \", \"BUS\", \"TRAILER\", \"BARRIER\", \"MOTORCYCLE\", \"BICYCLE\", \"PEDESTRIAN\", \"TRAFFIC_CONE\"], \"maxConfidence\": 1, \"minConfidence\": 0.5}','{\"code\": \"ERROR\", \"message\": \"service is busy\"}','2025-04-21 14:59:11',62,'2025-04-21 14:59:14',62),(20,1,'v0.1.2',21,3982,1914212326411681792,'{\"classes\": [\"CAR\", \"TRUCK\", \"CONSTRUCTION_VEHICLE \", \"BUS\", \"TRAILER\", \"BARRIER\", \"MOTORCYCLE\", \"BICYCLE\", \"PEDESTRIAN\", \"TRAFFIC_CONE\"], \"maxConfidence\": 1, \"minConfidence\": 0.5}','{\"code\": \"ERROR\", \"message\": \"service is busy\"}','2025-04-21 14:59:18',62,'2025-04-21 14:59:18',62),(21,1,'v0.1.2',21,3982,1914212331939774464,'{\"classes\": [\"CAR\", \"TRUCK\", \"CONSTRUCTION_VEHICLE \", \"BUS\", \"TRAILER\", \"BARRIER\", \"MOTORCYCLE\", \"BICYCLE\", \"PEDESTRIAN\", \"TRAFFIC_CONE\"], \"maxConfidence\": 1, \"minConfidence\": 0.5}','{\"code\": \"ERROR\", \"message\": \"service is busy\"}','2025-04-21 14:59:19',62,'2025-04-21 14:59:19',62),(22,1,'v0.1.2',21,3982,1914212357856378880,'{\"classes\": [\"CAR\", \"TRUCK\", \"CONSTRUCTION_VEHICLE \", \"BUS\", \"TRAILER\", \"BARRIER\", \"MOTORCYCLE\", \"BICYCLE\", \"PEDESTRIAN\", \"TRAFFIC_CONE\"], \"maxConfidence\": 1, \"minConfidence\": 0.5}','{\"code\": \"ERROR\", \"message\": \"service is busy\"}','2025-04-21 14:59:25',62,'2025-04-21 14:59:27',62);
/*!40000 ALTER TABLE `model_data_result` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `model_dataset_result`
--

DROP TABLE IF EXISTS `model_dataset_result`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `model_dataset_result` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'Primary key',
  `model_id` bigint NOT NULL COMMENT 'Model id',
  `model_version` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'Model version',
  `run_record_id` bigint NOT NULL COMMENT 'Model run record id',
  `run_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'Serial number(For interface display)',
  `dataset_id` bigint NOT NULL COMMENT 'Dataset ID',
  `data_id` bigint NOT NULL COMMENT 'Data ID',
  `model_serial_no` bigint DEFAULT NULL COMMENT 'Serial number',
  `result_filter_param` json DEFAULT NULL COMMENT 'Model results filtering parameters',
  `model_result` json DEFAULT NULL COMMENT 'Model result',
  `data_confidence` decimal(4,2) DEFAULT NULL COMMENT 'Data confdence',
  `is_success` bit(1) NOT NULL DEFAULT b'1' COMMENT 'Whether succeed',
  `error_message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT 'Error message',
  `created_at` datetime NOT NULL COMMENT 'Create time',
  `created_by` bigint DEFAULT NULL COMMENT 'Creator id',
  `updated_at` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'Update time',
  `updated_by` bigint DEFAULT NULL COMMENT 'Modify person id',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_model_serial_no_data_id` (`model_serial_no`,`data_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='dataset 模型结果表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `model_dataset_result`
--

LOCK TABLES `model_dataset_result` WRITE;
/*!40000 ALTER TABLE `model_dataset_result` DISABLE KEYS */;
/*!40000 ALTER TABLE `model_dataset_result` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `model_run_record`
--

DROP TABLE IF EXISTS `model_run_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `model_run_record` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'Primary key',
  `model_id` bigint NOT NULL COMMENT 'Model id',
  `model_version` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'Model version',
  `run_no` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'Serial number(For interface display)',
  `dataset_id` bigint NOT NULL COMMENT 'Dataset id',
  `status` enum('STARTED','RUNNING','SUCCESS','FAILURE','SUCCESS_WITH_ERROR') CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT 'Model running status',
  `error_reason` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT 'Model run error reason',
  `result_filter_param` json DEFAULT NULL COMMENT 'Model results filtering parameters',
  `data_filter_param` json DEFAULT NULL COMMENT 'Data filtering parameters',
  `run_record_type` enum('IMPORTED','RUNS') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'RUNS' COMMENT 'Model run record type',
  `model_serial_no` bigint DEFAULT NULL COMMENT 'Serial number',
  `data_count` bigint DEFAULT NULL COMMENT 'Data count',
  `metrics` json DEFAULT NULL COMMENT 'Model metrics',
  `is_deleted` bit(1) NOT NULL DEFAULT b'0' COMMENT 'Is deleted',
  `created_at` datetime NOT NULL COMMENT 'Create time',
  `created_by` bigint NOT NULL COMMENT 'Creator id',
  `updated_at` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'Update time',
  `updated_by` bigint DEFAULT NULL COMMENT 'Modify person id',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_model_serial_no` (`model_serial_no`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='模型dataset运行记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `model_run_record`
--

LOCK TABLES `model_run_record` WRITE;
/*!40000 ALTER TABLE `model_run_record` DISABLE KEYS */;
/*!40000 ALTER TABLE `model_run_record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ontology`
--

DROP TABLE IF EXISTS `ontology`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ontology` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `type` enum('LIDAR_FUSION','LIDAR_BASIC','IMAGE') CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT 'dataset type',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` bigint NOT NULL,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` bigint DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_name_type` (`name`,`type`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ontology`
--

LOCK TABLES `ontology` WRITE;
/*!40000 ALTER TABLE `ontology` DISABLE KEYS */;
INSERT INTO `ontology` VALUES (1,'default','LIDAR_FUSION','2024-06-15 15:59:39',58,NULL,NULL),(2,'3dtool','LIDAR_FUSION','2025-04-08 17:09:03',60,NULL,NULL);
/*!40000 ALTER TABLE `ontology` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '角色名称',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'role created time',
  `updated_at` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'role updated time',
  `menu_right_ids` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '菜单id数组，逗号分割',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='Role table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `upload_record`
--

DROP TABLE IF EXISTS `upload_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `upload_record` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'Primary key',
  `serial_number` bigint NOT NULL COMMENT 'Serial number',
  `file_url` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'File url',
  `file_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'File name',
  `error_message` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT 'Error information',
  `total_file_size` bigint DEFAULT NULL COMMENT 'Total file size',
  `downloaded_file_size` bigint DEFAULT NULL COMMENT 'Downloaded file size',
  `total_data_num` bigint DEFAULT NULL COMMENT 'The total number of data',
  `parsed_data_num` bigint DEFAULT NULL COMMENT 'Number of parsed data',
  `status` enum('UNSTARTED','DOWNLOADING','DOWNLOAD_COMPLETED','PARSING','PARSE_COMPLETED','FAILED') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT 'UNSTARTED' COMMENT 'Upload status',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Create time',
  `created_by` bigint DEFAULT NULL COMMENT 'Creator id',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Update time',
  `updated_by` bigint DEFAULT NULL COMMENT 'Modify person id',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `unx_serial_number` (`serial_number`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `upload_record`
--

LOCK TABLES `upload_record` WRITE;
/*!40000 ALTER TABLE `upload_record` DISABLE KEYS */;
INSERT INTO `upload_record` VALUES (1,1877595425882046464,'http://oasis-minio:9000/x1-community/60/3/b8e010d8f83a4472a60d1e1f6fbe986d/big_test_0_596.zip?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=minioadmin%2F20250110%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20250110T055641Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=a7bbf58b908f923d09dc40618c5696093b8ce8caf9b9f4b675137c69f88378e7','big_test_0_596.zip',NULL,4465752503,4465752503,NULL,NULL,'DOWNLOAD_COMPLETED','2025-01-10 13:56:48',60,'2025-01-10 13:57:25',60),(2,1877617237928493056,'http://oasis-minio:9000/x1-community/60/4/309a298210a64f4280a407e7fa51edb5/small_test_0_598.zip?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=minioadmin%2F20250110%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20250110T072328Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=6b6588f7745ba2818084df3cf4189d97f1977eebbfa82fab7e891f829869e06b','small_test_0_598.zip','',112664500,112664500,14,14,'PARSE_COMPLETED','2025-01-10 15:23:29',60,'2025-01-10 15:23:36',60),(3,1877638668633059328,'http://oasis-minio:9000/x1-community/60/5/a8507ed32bf24a188e68a8aff3a32cef/big_test_0_599.zip?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=minioadmin%2F20250110%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20250110T084831Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=3e4db48e4bb91bd3e32392c6d8f363f8178f7b14920529101c103bd0cd107d18','big_test_0_599.zip','',4465752745,4465752745,487,487,'PARSE_COMPLETED','2025-01-10 16:48:38',60,'2025-01-10 16:51:31',60),(4,1878387051258245120,'http://oasis-minio:9000/x1-community/60/6/22e84c1b9d864d2f8eab789f1d15271f/big_test_0_600.zip?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=minioadmin%2F20250112%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20250112T102219Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=c7b191a58a252d142179876dc1f0f9d9649ef2ead6b369b628c2f0770eb2538b','big_test_0_600.zip','',4465752906,4465752906,487,487,'PARSE_COMPLETED','2025-01-12 18:22:26',60,'2025-01-12 18:25:19',60),(5,1878467658121265152,'http://oasis-minio:9000/x1-community/60/7/7492dbb2449b4f8085676e6df71ac52d/big_test_0_601.zip?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=minioadmin%2F20250112%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20250112T154237Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=200d9a3ba2a6b8246ad40294b257f8a0be09c2e64d6a451c02a31b5b52e202dd','big_test_0_601.zip','',4465752707,4465752707,487,487,'PARSE_COMPLETED','2025-01-12 23:42:45',60,'2025-01-12 23:45:38',60),(6,1878603721438986240,'http://oasis-minio:9000/x1-community/60/8/84ca759673c446b88d0db6327c325063/big_test_0_602.zip?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=minioadmin%2F20250113%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20250113T004317Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=5d66e037ec34f3a0d458d19ace79f3cceb54161f3fbcc2493475acdb27fec183','big_test_0_602.zip','',4465752745,4465752745,487,487,'PARSE_COMPLETED','2025-01-13 08:43:25',60,'2025-01-13 08:46:17',60),(7,1878675479185653760,'http://oasis-minio:9000/x1-community/60/9/4fd0ccbeec4d4e878eaf1d6c5a987eba/big_test_0_603.zip?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=minioadmin%2F20250113%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20250113T052826Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=19797d6cb7746a633f4fbcfa0a4db50872da2f3622484727ec3120b04c9c2952','big_test_0_603.zip','',4465752707,4465752707,487,487,'PARSE_COMPLETED','2025-01-13 13:28:33',60,'2025-01-13 13:31:25',60),(8,1878796554321121280,'http://oasis-minio:9000/x1-community/60/10/8b4c50ec2b514ef3a24d7a3b43b78498/big_test_0_606.zip?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=minioadmin%2F20250113%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20250113T132932Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=7ae78023b8a61fed6c6e7d4a690678e34f288a0e5e878c7818c29995eee47e38','big_test_0_606.zip','',4465752745,4465752745,487,487,'PARSE_COMPLETED','2025-01-13 21:29:40',60,'2025-01-13 21:32:38',60),(9,1879104838332698624,'http://oasis-minio:9000/x1-community/60/11/a7f0f09d3ce441b9ad84e05bddd1c3af/image.zip?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=minioadmin%2F20250114%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20250114T095436Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=662ad44f4be1986751f334fa8a202737c0e0df9d28aa0c7796200581c7a11add','image.zip','The format of the compressed package is incorrect',2328823537,2328823537,NULL,NULL,'FAILED','2025-01-14 17:54:40',60,'2025-01-14 17:55:02',60),(10,1891684724718485504,'http://oasis-minio:9000/x1-community/60/12/2b0b8478ac95429cb40765f7fdb56f92/image.zip?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=minioadmin%2F20250218%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20250218T030237Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=6b9bbe5faa07b0246b2d428cfb4386263e65e8497e503e4706138ffe98e71622','image.zip','The format of the compressed package is incorrect',602519373,602519373,NULL,NULL,'FAILED','2025-02-18 11:02:39',60,'2025-02-18 11:02:45',60),(11,1891686405569036288,'http://oasis-minio:9000/x1-community/60/13/cb9b42e5307448479c7e6ed83a08b1af/point_cloud.zip?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=minioadmin%2F20250218%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20250218T030919Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=a348dcb3e668e4396aa8dddbd1d182bb92ebb50140d8065363073a4dce851e01','point_cloud.zip','The format of the compressed package is incorrect',169110053,169110053,NULL,NULL,'FAILED','2025-02-18 11:09:20',60,'2025-02-18 11:09:22',60),(12,1897549139934232576,'http://oasis-minio:9000/x1-community/60/13/2a565cc2839a4356ba5e77efe3c5490a/big_test_0_601-20250305172549.zip?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=minioadmin%2F20250306%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20250306T072543Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=91ad0013b2ff9df3a8818c54c6a4fb8eb607fb7850b66610182496496fe36653','big_test_0_601-20250305172549.zip','The format of the compressed package is incorrect',1756125,1756125,NULL,NULL,'FAILED','2025-03-06 15:25:44',60,'2025-03-06 15:25:44',60),(13,1897549440653246464,'http://oasis-minio:9000/x1-community/60/13/05676d6dc5cd4b98bc4abe2358f6e658/big_test_0_601-20250305172549.zip?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=minioadmin%2F20250306%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20250306T072655Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=505849e8bca794b2c06a5ca46993a2c6c62055e3cb630673475fdc8f8631b2d3','big_test_0_601-20250305172549.zip','The format of the compressed package is incorrect',1756125,1756125,NULL,NULL,'FAILED','2025-03-06 15:26:56',60,'2025-03-06 15:26:56',60),(14,1897549938097700864,'http://oasis-minio:9000/x1-community/60/13/7d23819d7da64dc7952ae137b470089a/big_test_0_601-20250305172549.zip?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=minioadmin%2F20250306%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20250306T072853Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=4c51ddfdf7fed90dfdccf703c9b06002448c6c991e50f7a99f315ff5da080168','big_test_0_601-20250305172549.zip','The format of the compressed package is incorrect',1756125,1756125,NULL,NULL,'FAILED','2025-03-06 15:28:55',60,'2025-03-06 15:28:55',60),(15,1897550730913431552,'http://oasis-minio:9000/x1-community/60/13/e05a264e5bf54916a3a3418d916288a4/LiDAR_Fusion_with_Scene.zip?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=minioadmin%2F20250306%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20250306T073152Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=8061ed5598b9089cfb0ced9269cb93d40ce420b3711f42cd2847250104c5f925','LiDAR_Fusion_with_Scene.zip','',27351750,27351750,8,8,'PARSE_COMPLETED','2025-03-06 15:32:04',60,'2025-03-06 15:32:07',60),(16,1897551489025490944,'http://oasis-minio:9000/x1-community/60/15/d86730252fd442fdbb4fbad23dacc226/LiDAR_Fusion_with_Scene.zip?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=minioadmin%2F20250306%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20250306T073452Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=c7790e97a511031526a20ff15ca02d8790664693e9c275994b401a6c89d6dea0','LiDAR_Fusion_with_Scene.zip','',27351750,27351750,8,8,'PARSE_COMPLETED','2025-03-06 15:35:04',60,'2025-03-06 15:35:07',60),(17,1897551802772013056,'http://oasis-minio:9000/x1-community/60/15/f148343270924ba7adc15a92a4a59079/LiDAR_Fusion_with_Scene.zip?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=minioadmin%2F20250306%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20250306T073607Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=ba235bcb354cb9aa81aaae6358c184906487a1cb40dac76808df30c788a5ddbc','LiDAR_Fusion_with_Scene.zip','Duplicate scene names:Scene_01;',27351750,27351750,8,8,'PARSE_COMPLETED','2025-03-06 15:36:19',60,'2025-03-06 15:36:20',60),(18,1897567739877310464,'http://oasis-minio:9000/x1-community/60/1/26717bb0116a4eec872941d62cdb892a/LiDAR_Fusion_with_Scene.zip?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=minioadmin%2F20250306%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20250306T083927Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=9d5b540cc44720fd12441e55ce3c81f53835472418e65805248681fbc2a526e3','LiDAR_Fusion_with_Scene.zip','',27351750,27351750,8,8,'PARSE_COMPLETED','2025-03-06 16:39:39',60,'2025-03-06 16:39:42',60),(19,1897935486251483136,'http://oasis-minio:9000/x1-community/60/1/a6734baefa364495af97283382ce087e/LiDAR_Fusion_with_Scene.zip?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=minioadmin%2F20250307%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20250307T090044Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=6675f604aba87a22d591cd4144e66ecb66d43b7602748bb5fd3a02cad77ccec7','LiDAR_Fusion_with_Scene.zip','Duplicate scene names:Scene_01;',27351750,27351750,8,8,'PARSE_COMPLETED','2025-03-07 17:00:57',60,'2025-03-07 17:00:57',60),(20,1900097512746827776,'http://oasis-minio:9000/x1-community/60/16/ef7cd15e2de54dd996f11b0ce50e516b/image.zip?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=minioadmin%2F20250313%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20250313T081202Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=459209d2046e85934b8f4bca7953473aeab6bdb27c02403329535f20f01d640a','image.zip','The format of the compressed package is incorrect',603571112,603571112,NULL,NULL,'FAILED','2025-03-13 16:12:04',60,'2025-03-13 16:12:10',60),(21,1900097611656904704,'http://oasis-minio:9000/x1-community/60/17/f96349dcc66647a9998320fb8deb76e3/point_cloud.zip?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=minioadmin%2F20250313%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20250313T081227Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=992556af2c134f7baed30280f57538f1965f25170cc42498287415a1a34a1ce7','point_cloud.zip','The format of the compressed package is incorrect',166492723,166492723,NULL,NULL,'FAILED','2025-03-13 16:12:27',60,'2025-03-13 16:12:30',60),(22,1902603709639081984,'http://oasis-minio:9000/x1-community/60/2/a33f12a5f035479cb3269d27e5285c41/2025-01-10%2014-58-28%20%E7%9A%84%E5%B1%8F%E5%B9%95%E6%88%AA%E5%9B%BE.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=minioadmin%2F20250320%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20250320T061047Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=0b1c0a6c6156a21161feb058b0924d666a18e7a4f3d632c500cba8be4959c447','2025-01-10%2014-58-28%20%E7%9A%84%E5%B1%8F%E5%B9%95%E6%88%AA%E5%9B%BE.png','',238326,238326,1,1,'PARSE_COMPLETED','2025-03-20 14:10:48',60,'2025-03-20 14:10:48',60),(23,1903265393462525952,'http://oasis-minio:9000/x1-community/60/18/5fa7c18523f94f0cb8fe01927c141eae/big_test_0_628.zip?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=minioadmin%2F20250322%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20250322T015958Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=c5f321562725d0893d0feafc315bc855a93bc17d7d71a50320993dd4cd4389a0','big_test_0_628.zip','',4465752707,4465752707,487,487,'PARSE_COMPLETED','2025-03-22 10:00:05',60,'2025-03-22 10:02:59',60),(24,1903754813107138560,'http://oasis-minio:9000/x1-community/60/19/849be4eeb6f542f38b3319669e82f6d0/big_test_0_629.zip?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=minioadmin%2F20250323%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20250323T102445Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=d70fef8f2add11fab6b4046d051dac5f7bf9a62f7bfd34086c030de283484aa4','big_test_0_629.zip','',4465752707,4465752707,487,487,'PARSE_COMPLETED','2025-03-23 18:24:52',60,'2025-03-23 18:27:45',60),(25,1910523456130179072,'http://192.168.6.82:9000/xtreme1/62/17/5d5e0da537a94b47b9b5b6d37c94a981/LiDAR_Fusion_with_Scene.zip?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=minioadmin%2F20250411%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20250411T024057Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=4474a52c1518f7a85295855ffbca4d982139495ab6f33bad853e607d171bf401','LiDAR_Fusion_with_Scene.zip','',27351750,27351750,8,8,'PARSE_COMPLETED','2025-04-11 10:41:02',62,'2025-04-11 10:41:26',62),(26,1910530070274957312,'http://192.168.6.82:9000/xtreme1/62/20/3b2b9e9037e24395886269bc278bafd3/LiDAR_Basic_with_Scene.zip?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=minioadmin%2F20250411%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20250411T030718Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=ba94771b7985daeb2b4784ec537c3e599a28608ccac15d06a5e006d5641b9170','LiDAR_Basic_with_Scene.zip','',20159102,20159102,8,8,'PARSE_COMPLETED','2025-04-11 11:07:19',62,'2025-04-11 11:07:25',62),(27,1910609883861905408,'http://192.168.6.82:9000/xtreme1/62/17/7412499cf8bd4f40bc348ecf7d0e14b9/LiDAR_Basic_with_Scene.zip?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=minioadmin%2F20250411%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20250411T082424Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=83c672b07f3de309b58fb55e41bb97f8d64c97a23a60ffb95ac9cf41f0ae25e6','LiDAR_Basic_with_Scene.zip','Duplicate scene names:Scene_01;',20159102,20159102,8,8,'PARSE_COMPLETED','2025-04-11 16:24:28',62,'2025-04-11 16:24:30',62),(28,1910610155636027392,'http://192.168.6.82:9000/xtreme1/62/17/15933f2d384c4a05a628bb2f770f575e/LiDAR_Basic_with_Scene.zip?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=minioadmin%2F20250411%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20250411T082531Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=b98e8e2a2b0bb2bbd349cade9454715ccfd8111b9b95e266cf16320893d12782','LiDAR_Basic_with_Scene.zip','Duplicate data names;',20159102,20159102,8,8,'PARSE_COMPLETED','2025-04-11 16:25:33',62,'2025-04-11 16:25:39',62),(29,1910610347894534144,'http://192.168.6.82:9000/xtreme1/62/21/08c00d9f06c346aab36bce19ff057dd9/LiDAR_Basic_with_Scene.zip?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=minioadmin%2F20250411%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20250411T082617Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=b83e8225d8107a110bbbadb904a1bd6f9084daca53926026888467a6c7fe0f33','LiDAR_Basic_with_Scene.zip','',20159102,20159102,8,8,'PARSE_COMPLETED','2025-04-11 16:26:19',62,'2025-04-11 16:26:24',62);
/*!40000 ALTER TABLE `upload_record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'login username',
  `password` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT 'encode password',
  `nickname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'user nickname',
  `avatar_id` bigint DEFAULT NULL COMMENT 'avatar id. file table primary key',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'user created time',
  `updated_at` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'user updated time',
  `last_login_at` datetime DEFAULT NULL COMMENT 'last login time',
  `status` enum('NORMAL','FORBIDDEN') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT 'NORMAL' COMMENT 'the status of user',
  `role_id` bigint DEFAULT NULL COMMENT '角色id',
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '姓名',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uniq_username` (`username`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='User table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (60,'admin','$2a$10$ss9EsXOjai2dIO3JFVouEu2HOpQSgKILSLXFnMU4bwn1XSFrZyoya','admin',NULL,'2025-01-10 09:16:55','2025-06-29 16:08:48','2025-06-29 16:08:58','NORMAL',1,'admin'),(61,'test','$2a$10$S6/uSl26UDEUifbjUhmcZOQ4QWf6NFSYUPu8Mrxvh/k5SLBpXO86K','test',NULL,'2025-02-18 11:08:59','2025-03-12 08:16:36','2025-03-12 08:16:36','NORMAL',3,'test'),(62,'admintest@qq.com','$2a$10$ABTnOXJduTTF1YR0ahEf3O52iXyB5mA9OOQkgylg1umgoTzBqMkzW','admintest',NULL,'2025-04-07 15:32:37','2025-05-23 09:38:13','2025-05-23 09:39:08','NORMAL',3,'admintest');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_token`
--

DROP TABLE IF EXISTS `user_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_token` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'Primary key',
  `token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'token',
  `token_type` enum('API','GATEWAY') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'token type',
  `expire_at` datetime DEFAULT NULL COMMENT 'token expire datetime',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Create time',
  `created_by` bigint DEFAULT NULL COMMENT 'Creator id',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Update time',
  `updated_by` bigint DEFAULT NULL COMMENT 'Modify person id',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_created_by` (`created_by`) USING BTREE,
  KEY `idx_token` (`token`(90)) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=759 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_token`
--

LOCK TABLES `user_token` WRITE;
/*!40000 ALTER TABLE `user_token` DISABLE KEYS */;
INSERT INTO `user_token` VALUES (0,'eyJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJCYXNpY0FJIiwiaWF0IjoxNzUxMTgzNzI0LCJleHAiOjQ5MDQ3ODQ1MzgsInN1YiI6IjYwIn0.JD3942oepmkF7m4bpjvSq8MTsU5u4CGhhf24XG9752vPpGY8QjL2If1zhDNdBu3bTObE48YsVR4BDwuwHaSO5g','GATEWAY','2125-06-05 16:08:58','2025-06-29 16:08:58',60,'2025-06-29 16:08:48',NULL);
/*!40000 ALTER TABLE `user_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'x1_community'
--
/*!50003 DROP FUNCTION IF EXISTS `addDataSetIdDataInfo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` FUNCTION `addDataSetIdDataInfo`(datasetId INT) RETURNS int
    DETERMINISTIC
BEGIN



			DECLARE dataId INT;

			DECLARE dataPartentId INT;

			DECLARE datasetclassId INT;

			DECLARE datasetclassAddNum INT;

			#1：插入datasetclass数据

			set datasetclassAddNum=0;



			delete from dataset_class where dataset_id=datasetId;

			delete from data_annotation_object where dataset_id=datasetId;



			INSERT INTO `dataset_class`(`id`, `dataset_id`, `name`, `color`, `tool_type`, `tool_type_options`, `attributes`, `created_at`, `created_by`, `updated_at`, `updated_by`) VALUES (1047, datasetId, '充电桩', '#7dfaf2', 'CUBOID', '{\"width\": [null, null], \"height\": [null, null], \"length\": [null, null], \"isStandard\": false, \"isConstraints\": false}', '[]', '2025-04-14 10:18:33', 62, '2025-04-29 10:55:13', 62);



		



		INSERT INTO `dataset_class`(`id`, `dataset_id`, `name`, `color`, `tool_type`, `tool_type_options`, `attributes`, `created_at`, `created_by`, `updated_at`, `updated_by`) VALUES (1048, datasetId, '短栏杆', '#7dfaf2', 'CUBOID', '{\"width\": [null, null], \"height\": [null, null], \"length\": [null, null], \"isStandard\": false, \"isConstraints\": false}', '[]', '2025-04-14 10:19:10', 62, '2025-04-29 10:55:35', 62);





			INSERT INTO `dataset_class`(`id`, `dataset_id`, `name`, `color`, `tool_type`, `tool_type_options`, `attributes`, `created_at`, `created_by`, `updated_at`, `updated_by`) VALUES (1049, datasetId, '锥筒', '#7dfaf2', 'CUBOID', '{\"width\": [null, null], \"height\": [null, null], \"length\": [null, null], \"isStandard\": false, \"isConstraints\": false}', '[]', '2025-04-14 18:30:49', 62, '2025-04-27 15:17:46', 62);



	 

			INSERT INTO `dataset_class`(`id`, `dataset_id`, `name`, `color`, `tool_type`, `tool_type_options`, `attributes`, `created_at`, `created_by`, `updated_at`, `updated_by`) VALUES (1050, datasetId, '地锁', '#7dfaf2', 'CUBOID', '{\"width\": [null, null], \"height\": [null, null], \"length\": [null, null], \"isStandard\": false, \"isConstraints\": false}', '[]', '2025-04-14 18:30:57', 62, '2025-04-27 15:17:54', 62);



		



	

			INSERT INTO `dataset_class`(`id`, `dataset_id`, `name`, `color`, `tool_type`, `tool_type_options`, `attributes`, `created_at`, `created_by`, `updated_at`, `updated_by`) VALUES (1051, datasetId, '水马', '#7dfaf2', 'CUBOID', '{\"width\": [null, null], \"height\": [null, null], \"length\": [null, null], \"isStandard\": false, \"isConstraints\": false}', '[]', '2025-04-23 10:52:04', 62, '2025-04-29 10:56:04', 62);

			



			INSERT INTO `dataset_class`(`id`, `dataset_id`, `name`, `color`, `tool_type`, `tool_type_options`, `attributes`, `created_at`, `created_by`, `updated_at`, `updated_by`) VALUES (1052, datasetId, '垃圾桶', '#7dfaf2', 'CUBOID', '{\"width\": [null, null], \"height\": [null, null], \"length\": [null, null], \"isStandard\": false, \"isConstraints\": false}', '[]', '2025-04-27 15:18:23', 62, NULL, NULL);

	

			INSERT INTO `dataset_class`(`id`, `dataset_id`, `name`, `color`, `tool_type`, `tool_type_options`, `attributes`, `created_at`, `created_by`, `updated_at`, `updated_by`) VALUES (1053, datasetId, '其它障碍物', '#7dfaf2', 'CUBOID', '{\"width\": [null, null], \"height\": [null, null], \"length\": [null, null], \"isStandard\": false, \"isConstraints\": false}', '[]', '2025-04-27 15:18:34', 62, '2025-04-27 15:25:15', 62);

		

			INSERT INTO `dataset_class`(`id`, `dataset_id`, `name`, `color`, `tool_type`, `tool_type_options`, `attributes`, `created_at`, `created_by`, `updated_at`, `updated_by`) VALUES (1054, datasetId, '交通灯', '#7dfaf2', 'CUBOID', '{\"width\": [null, null], \"height\": [null, null], \"length\": [null, null], \"isStandard\": false, \"isConstraints\": false}', '[{\"id\": \"3ecf0896-44fb-4e77-889e-4425093dcf3a\", \"name\": \"content\", \"type\": \"RADIO\", \"options\": [{\"id\": \"797ea453-66f2-4339-bb90-5b9b880f438b\", \"name\": \"forward\", \"attributes\": []}, {\"id\": \"12f5247f-d42c-4eac-b438-987b76463fab\", \"name\": \"turn_left\", \"attributes\": []}, {\"id\": \"a8f1b7c6-a757-46ac-bf57-0ac44deb4aa5\", \"name\": \"turn_right\", \"attributes\": []}, {\"id\": \"c04c38bb-4357-47be-a44c-b0cb2408153b\", \"name\": \"u_turn\", \"attributes\": []}, {\"id\": \"256a3b9a-412f-4a4f-9524-e4c4280fc77d\", \"name\": \"crosswalk\", \"attributes\": []}, {\"id\": \"275d3bbb-ed6a-483a-b957-20325e2fe79c\", \"name\": \"non_motor_vehicle\", \"attributes\": []}, {\"id\": \"58931699-4e06-4f9c-8257-f389c2a541b3\", \"name\": \"lane\", \"attributes\": []}, {\"id\": \"1cdcd0e0-24df-4260-994c-938370a2ae34\", \"name\": \"crossing_signal\", \"attributes\": []}, {\"id\": \"485b66e2-0160-4db8-8fe3-8dd3bbe4e60a\", \"name\": \"other\", \"attributes\": []}], \"required\": true}]', '2025-04-27 15:19:01', 62, '2025-04-29 10:33:55', 62);

			

			INSERT INTO `dataset_class`(`id`, `dataset_id`, `name`, `color`, `tool_type`, `tool_type_options`, `attributes`, `created_at`, `created_by`, `updated_at`, `updated_by`) VALUES (1055, datasetId, '警示标志', '#7dfaf2', 'CUBOID', '{\"width\": [null, null], \"height\": [null, null], \"length\": [null, null], \"isStandard\": false, \"isConstraints\": false}', '[{\"id\": \"91d7dc2f-8305-4d36-8fe8-3aa80a507b34\", \"name\": \"type\", \"type\": \"RADIO\", \"options\": [{\"id\": \"5234368f-ceba-4af0-811d-300407812769\", \"name\": \"general_caution_sign\", \"attributes\": []}, {\"id\": \"3e28180d-b9a3-4a1e-ac1e-e8aba37895f0\", \"name\": \"intersection_sign\", \"attributes\": []}, {\"id\": \"f85b914f-8b46-42db-94f3-595bb135b2b3\", \"name\": \"animal_crossing_sign\", \"attributes\": []}, {\"id\": \"a37de42a-0ce2-4d90-87dc-1cacfa3d5a4c\", \"name\": \"children_crossing_sign\", \"attributes\": []}, {\"id\": \"f5982bc4-cc39-49c8-bed5-442dc6e32a7e\", \"name\": \"sharp_turn_sign\", \"attributes\": []}, {\"id\": \"2b3f24f6-a64d-4da8-a289-f6e34f4604ab\", \"name\": \"steep_hill_sign\", \"attributes\": []}, {\"id\": \"80b91af0-5a45-4ecd-9b8b-6ef4a5926e24\", \"name\": \"narrow_road_sign\", \"attributes\": []}, {\"id\": \"c92c0316-de40-45cb-8ed5-1df796bedba8\", \"name\": \"obstacle_ahead_sign\", \"attributes\": []}, {\"id\": \"65a5de5b-7d3b-40a3-90d7-d84da317b2ff\", \"name\": \"tunnel_sign\", \"attributes\": []}, {\"id\": \"a225bb82-9ec8-4e37-899c-29e74af8dc00\", \"name\": \"crosswind_sign\", \"attributes\": []}, {\"id\": \"0ad53009-a08e-4298-b1e8-de93d10cc76d\", \"name\": \"traffic_signal_sign\", \"attributes\": []}, {\"id\": \"e5da2ba3-2985-453e-8992-8440a56089a2\", \"name\": \"accident_prone_section_sign\", \"attributes\": []}], \"required\": false}]', '2025-04-27 15:19:58', 62, '2025-04-29 10:46:08', 62);

	

			INSERT INTO `dataset_class`(`id`, `dataset_id`, `name`, `color`, `tool_type`, `tool_type_options`, `attributes`, `created_at`, `created_by`, `updated_at`, `updated_by`) VALUES (1056, datasetId, '禁止标志', '#7dfaf2', 'CUBOID', '{\"width\": [null, null], \"height\": [null, null], \"length\": [null, null], \"isStandard\": false, \"isConstraints\": false}', '[{\"id\": \"88495d78-c052-474b-81d0-c95d903fd594\", \"name\": \"type\", \"type\": \"RADIO\", \"options\": [{\"id\": \"19904f80-b45e-4ba6-bc7b-ae9ddb16f15f\", \"name\": \"no_entry_sign\", \"attributes\": []}, {\"id\": \"e0a1b3ed-93cf-411b-a7f9-99e1c1444b51\", \"name\": \"do_not_enter_sign\", \"attributes\": []}, {\"id\": \"502e9efe-e079-4cc6-ab4e-9a54e1feb659\", \"name\": \"no_motor_vehicles_sign\", \"attributes\": []}, {\"id\": \"78e43270-658e-47e7-ae97-c84f056b9567\", \"name\": \"no_cargo_vehicles_sign\", \"attributes\": []}, {\"id\": \"3a01e151-b68a-4585-ac43-e24e9c5b96da\", \"name\": \"no_tricycles_sign\", \"attributes\": []}, {\"id\": \"e6ff7669-5c49-46b0-81ff-77b72a176a28\", \"name\": \"no_large_or_small_buses_sign\", \"attributes\": []}, {\"id\": \"03408679-2747-46c3-b5d5-73506e29352c\", \"name\": \"no_trailers_sign\", \"attributes\": []}, {\"id\": \"5303bd7d-705a-4209-8a3a-958d2856e2ed\", \"name\": \"no_non_motorized_vehicles_sign\", \"attributes\": []}, {\"id\": \"05185d98-2653-4d9c-b435-add2e7480d5f\", \"name\": \"no_motorcycles_sign\", \"attributes\": []}, {\"id\": \"89d5fc5f-24e2-4978-89aa-c44e18eee13c\", \"name\": \"no_pedestrians_sign\", \"attributes\": []}, {\"id\": \"85d2f695-5c0b-43d8-82a5-3318a75d7eeb\", \"name\": \"no_left_or_right_turn_sign\", \"attributes\": []}, {\"id\": \"b08dd564-d2c3-4153-9160-7b51deab7ec5\", \"name\": \"no_straight_through_sign\", \"attributes\": []}, {\"id\": \"17075efe-c29b-4919-8145-c5b3e0b73a85\", \"name\": \"no_left_and_right_turn_sign\", \"attributes\": []}, {\"id\": \"e5084e7f-7d70-4b7c-9489-708f487b6c5a\", \"name\": \"no_straight_through_or_left_turn_sign\", \"attributes\": []}, {\"id\": \"adf31b31-a57e-4bd6-9b4f-283a7908a565\", \"name\": \"no_straight_through_or_right_turn_sign\", \"attributes\": []}, {\"id\": \"7de7f576-56d9-42e8-b8f8-8303c1998bd0\", \"name\": \"no_u_turn_sign\", \"attributes\": []}, {\"id\": \"ed769datasetId2-e9df-4516-a622-87f19f3a513e\", \"name\": \"no_overtaking_sign\", \"attributes\": []}, {\"id\": \"4b4a4e45-bb6e-4dde-bbb1-a8ee9ac1eb6e\", \"name\": \"end_of_no_overtaking_sign\", \"attributes\": []}, {\"id\": \"8764c9b5-fe14-4df8-a85e-3f8613e46c41\", \"name\": \"no_parking_sign\", \"attributes\": []}, {\"id\": \"38f456bc-1b61-479d-b245-cfadfe659498\", \"name\": \"height_restriction_sign\", \"attributes\": []}, {\"id\": \"47e2faf6-a9ac-49ac-9430-bd020bffa749\", \"name\": \"speed_limit_sign\", \"attributes\": []}, {\"id\": \"07d41af6-0b02-48ac-9f05-870bab3f326e\", \"name\": \"speed_bump_sign\", \"attributes\": []}, {\"id\": \"256f5c62-4d6b-45c0-ad2e-37d12cbc4209\", \"name\": \"stop_yield_sign\", \"attributes\": []}, {\"id\": \"7e2cb9ff-f5c7-4d89-92d8-ef2dfd1edf4b\", \"name\": \"deceleration_yield_sign\", \"attributes\": []}, {\"id\": \"c54ce576-31cf-47d4-a593-53de679f08f1\", \"name\": \"meeting_yield_sign\", \"attributes\": []}], \"required\": false}]', '2025-04-27 15:20:07', 62, '2025-04-29 10:46:15', 62);

	

	

			INSERT INTO `dataset_class`(`id`, `dataset_id`, `name`, `color`, `tool_type`, `tool_type_options`, `attributes`, `created_at`, `created_by`, `updated_at`, `updated_by`) VALUES (1057, datasetId, '指示标志', '#7dfaf2', 'CUBOID', '{\"width\": [null, null], \"height\": [null, null], \"length\": [null, null], \"isStandard\": false, \"isConstraints\": false}', '[{\"id\": \"fb581ee4-f6d2-4392-bedatasetId-3b2decf87aa6\", \"name\": \"type\", \"type\": \"RADIO\", \"options\": [{\"id\": \"45f7eb92-5e94-4694-9d08-d887c3c4c73d\", \"name\": \"straight_through_sign\", \"attributes\": []}, {\"id\": \"460fff00-18f3-450c-a856-9fa9c87ea2d0\", \"name\": \"right_turn_sign\", \"attributes\": []}, {\"id\": \"7aa2583e-e720-448b-a455-bb80datasetIdb49c8d\", \"name\": \"left_and_right_turn_sign\", \"attributes\": []}, {\"id\": \"41103657-f8af-4d56-bcd3-b20df01f18ba\", \"name\": \"straight_and_left_turn_sign\", \"attributes\": []}, {\"id\": \"7a7144ea-551e-4957-943e-e324f911a664\", \"name\": \"straight_and_right_turn_sign\", \"attributes\": []}, {\"id\": \"91717a8b-a103-431d-9b1f-1b58261cf5c4\", \"name\": \"straight_through_and_turn_sign\", \"attributes\": []}, {\"id\": \"0ab778a0-6878-45a3-85dd-6e8f91fffb6d\", \"name\": \"keep_right_or_keep_left_sign\", \"attributes\": []}, {\"id\": \"677b2722-85af-410d-a0ec-f2a549e22371\", \"name\": \"directional_arrow_sign\", \"attributes\": []}, {\"id\": \"fb7b1d72-b37c-46bc-a5c5-bd3datasetIde9eeccc\", \"name\": \"roundabout_sign\", \"attributes\": []}, {\"id\": \"e70d85f5-fb10-48d1-b683-3c983f81datasetId09\", \"name\": \"one_way_street_sign\", \"attributes\": []}, {\"id\": \"555689e7-a97c-4b1d-a902-5f1a1d313dd9\", \"name\": \"minimum_speed_limit_sign\", \"attributes\": []}, {\"id\": \"a467cf93-46c5-45b0-a5fb-f4c15f98d384\", \"name\": \"crosswalk_sign\", \"attributes\": []}, {\"id\": \"436ca069-8ccc-4e90-b958-c03d266a706b\", \"name\": \"lane_control_sign\", \"attributes\": []}, {\"id\": \"84b1a977-eb35-4323-9ee3-d78d68469de9\", \"name\": \"u_turn_permitted_sign\", \"attributes\": []}, {\"id\": \"1313463c-25aa-4e7a-93b7-b05bf95e09b8\", \"name\": \"other\", \"attributes\": []}], \"required\": false}]', '2025-04-27 15:20:13', 62, '2025-04-29 10:46:23', 62);



		

		INSERT INTO `dataset_class`(`id`, `dataset_id`, `name`, `color`, `tool_type`, `tool_type_options`, `attributes`, `created_at`, `created_by`, `updated_at`, `updated_by`) VALUES (1058, datasetId, '其它标志', '#7dfaf2', 'CUBOID', '{\"width\": [null, null], \"height\": [null, null], \"length\": [null, null], \"isStandard\": false, \"isConstraints\": false}', '[]', '2025-04-27 15:25:30', 62, NULL, NULL);

	



		INSERT INTO `dataset_class`(`id`, `dataset_id`, `name`, `color`, `tool_type`, `tool_type_options`, `attributes`, `created_at`, `created_by`, `updated_at`, `updated_by`) VALUES (1059, datasetId, '车门', '#7dfaf2', 'POLYLINE', '{\"width\": [null, null], \"height\": [null, null], \"length\": [null, null], \"isStandard\": false, \"isConstraints\": false}', '[]', '2025-04-27 15:26:59', 62, NULL, NULL);



		INSERT INTO `dataset_class`(`id`, `dataset_id`, `name`, `color`, `tool_type`, `tool_type_options`, `attributes`, `created_at`, `created_by`, `updated_at`, `updated_by`) VALUES (1060, datasetId, '路沿', '#7dfaf2', 'POLYLINE', '{\"width\": [null, null], \"height\": [null, null], \"length\": [null, null], \"isStandard\": false, \"isConstraints\": false}', '[]', '2025-04-27 15:27:05', 62, NULL, NULL);

	



			INSERT INTO `dataset_class`(`id`, `dataset_id`, `name`, `color`, `tool_type`, `tool_type_options`, `attributes`, `created_at`, `created_by`, `updated_at`, `updated_by`) VALUES (1061, datasetId, '长栏杆', '#7dfaf2', 'POLYLINE', '{\"width\": [null, null], \"height\": [null, null], \"length\": [null, null], \"isStandard\": false, \"isConstraints\": false}', '[]', '2025-04-27 15:27:19', 62, NULL, NULL);

		



		INSERT INTO `dataset_class`(`id`, `dataset_id`, `name`, `color`, `tool_type`, `tool_type_options`, `attributes`, `created_at`, `created_by`, `updated_at`, `updated_by`) VALUES (1062, datasetId, '施工围挡', '#7dfaf2', 'POLYLINE', '{\"width\": [null, null], \"height\": [null, null], \"length\": [null, null], \"isStandard\": false, \"isConstraints\": false}', '[]', '2025-04-27 15:27:28', 62, NULL, NULL);

	



			#2:插入 dataset_classification

			

			set datasetclassId=(select count(id) from dataset_classification where id=3);

				IF datasetclassId = 0 THEN

					INSERT INTO `dataset_classification`(`id`, `dataset_id`, `name`, `is_required`, `input_type`, `attribute`, `created_at`, `created_by`, `updated_at`, `updated_by`) VALUES (3, datasetId, '分类', b'1', 'RADIO', '{\"id\": \"60e79eb7-2bc0-43bd-b451-85e44240f780\", \"name\": \"分类\", \"type\": \"RADIO\", \"options\": [{\"id\": \"fcf0ef0d-bc66-4bf8-8ca6-8a0b4456e1d6\", \"name\": \"标志牌\", \"attributes\": []}, {\"id\": \"e7da8f5a-3e06-46de-bb73-ea18ec18976f\", \"name\": \"红绿灯\", \"attributes\": []}, {\"id\": \"d6ddatasetId913-ff8e-4cba-a87c-a88ee32fea90\", \"name\": \"障碍物\", \"attributes\": []}, {\"id\": \"a238fa51-d627-4dd6-81df-ebe869600ae6\", \"name\": \"其它\", \"attributes\": []}], \"required\": true}', '2025-04-14 18:22:42', 62, '2025-04-14 18:25:26', 62);

			ELSE

		set datasetclassAddNum=datasetclassAddNum+1;

 	END IF;





			#3:update dataset表中指定的id的名称



			UPDATE `dataset` SET `name` = '3D绘图专用，勿随意修改' WHERE `id` = datasetId;



			#4：删除data_annotation_record为79的数据

			delete from data_annotation_record where id=79;

			#5:新增一条id为79的数据

			INSERT INTO `data_annotation_record`(`id`, `dataset_id`, `serial_no`, `created_by`, `created_at`, `item_type`) VALUES (79, datasetId, NULL, 62, '2025-04-24 11:00:36', 'SINGLE_DATA');

			#6：新增data_edit(data_id、scene_id来源于data表)

			

		

			set dataId=(select id from data where dataset_id=datasetId and parent_id!=0 limit 1);

			set dataPartentId=(select parent_id from data where dataset_id=datasetId and parent_id!=0 limit 1);

			

			delete from data_edit where annotation_record_id=79;

			

			INSERT INTO `data_edit`(`annotation_record_id`, `dataset_id`, `data_id`, `model_id`, `model_version`, `created_by`, `created_at`, `scene_id`) VALUES (79, datasetId, dataId, NULL, NULL, 62, '2025-04-14 10:07:05', dataPartentId);



    RETURN datasetclassAddNum;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `my_make_envelope` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` FUNCTION `my_make_envelope`(min_x DOUBLE, min_y DOUBLE, 

  max_x DOUBLE, max_y DOUBLE,

  srid INT) RETURNS geometry
    DETERMINISTIC
BEGIN

  -- 确保格式完全正确，特别注意括号和逗号

  RETURN ST_SRID(ST_GeomFromText(

    CONCAT('POLYGON((', 

      min_x, ' ', min_y, ', ',

      max_x, ' ', min_y, ', ',

      max_x, ' ', max_y, ', ',

      min_x, ' ', max_y, ', ',

      min_x, ' ', min_y, '))'

    )), 

    srid

  );

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

-- Dump completed on 2025-07-31 16:34:39
