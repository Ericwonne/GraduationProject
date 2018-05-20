-- MySQL dump 10.13  Distrib 5.7.16, for Win64 (x86_64)
--
-- Host: localhost    Database: gpdb
-- ------------------------------------------------------
-- Server version	5.7.16

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
-- Table structure for table `account`
--

DROP TABLE IF EXISTS `account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account` (
  `acct_num` int(11) DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account`
--

LOCK TABLES `account` WRITE;
/*!40000 ALTER TABLE `account` DISABLE KEYS */;
/*!40000 ALTER TABLE `account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `build_information`
--

DROP TABLE IF EXISTS `build_information`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `build_information` (
  `code` char(2) NOT NULL COMMENT '编号',
  `name` varchar(50) DEFAULT NULL COMMENT '教学楼名称',
  `ava` char(1) DEFAULT 'Y',
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='教学楼信息表（build_information）';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `build_information`
--

LOCK TABLES `build_information` WRITE;
/*!40000 ALTER TABLE `build_information` DISABLE KEYS */;
INSERT INTO `build_information` VALUES ('',NULL,'Y'),('A1','第一教学楼','Y'),('A2','第二教学楼','Y'),('A3','第三教学楼','Y'),('A4','第四教学楼','Y'),('A5','综合教学楼','Y'),('A6','光电信息与计算机工程学院大楼','Y'),('A7','演讲厅','Y'),('A8','健身房','Y'),('B1','环境与建筑学院大楼','Y'),('B2','能源与动力学院大楼','Y'),('B3','机械学院大楼','Y'),('BH','大礼堂','Y'),('MH','音乐堂','Y'),('S1','申一教学楼','Y'),('S2','申二教学楼','Y'),('SH','小礼堂','Y'),('SW','游泳池','Y');
/*!40000 ALTER TABLE `build_information` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_information`
--

DROP TABLE IF EXISTS `course_information`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_information` (
  `courseID` char(10) NOT NULL COMMENT '课程代号：10字符固定长度',
  `courseName` varchar(100) NOT NULL COMMENT '课程名称',
  `courseTeacher` char(10) DEFAULT NULL COMMENT '代课老师：此处为教师唯一编号(UniqueClientID)。外键于教师信息表',
  `publishDate` varchar(30) DEFAULT NULL,
  `startDate` varchar(30) DEFAULT NULL,
  `endDate` varchar(30) DEFAULT NULL,
  `venue` varchar(60) DEFAULT NULL COMMENT '例如：综合教学楼405教室;格式：综合教学楼（405教室）',
  `period` varchar(50) DEFAULT NULL COMMENT '例如：该学期内每周三15:00-17:00;格式：周三（15:00-17:00）\nweek = { "A", "B", "C", "D", "E", "F", "G" };  { "星期一", "星期二", "星期三", "星期四", "星期五", "星期六", "星期日" };\ntime =  { "A", "B", "C", "D", "E", "F" };          { "一二节", "三四节", "三四五节", "六七节", "八九节", "十十一十二节" };\n\n{ "一二节":"上午8:00-9:50", \n"三四节":"上午9:55-11:30", \n"三四五节":"上午9:55-12:25",\n "六七节":"下午13:15-14:55", \n"八九节":"下午15:00-16:45", \n"十十一十二节" :"晚上18:00-20:25"};',
  `examID` char(10) DEFAULT NULL COMMENT '外键于考试信息表',
  `chosen` int(11) DEFAULT '0' COMMENT '历史选课人数',
  `collected` int(11) DEFAULT '0' COMMENT '被收藏次数',
  `courseInfo` varchar(256) DEFAULT NULL COMMENT '注意：不超过128字符的介绍',
  `detailInfo` varchar(2048) DEFAULT NULL COMMENT '注意：超过128个字符的介绍，但不超过2500个字符，有初值（NULL）',
  `subTag` varchar(50) DEFAULT NULL COMMENT '二级学科名称不超过25个字符（字节）',
  `capacity` int(11) DEFAULT '0' COMMENT '课程容量',
  `ava` char(1) DEFAULT 'Y',
  PRIMARY KEY (`courseID`),
  KEY `courseTeacher_idx` (`courseTeacher`),
  CONSTRAINT `courseTeacher` FOREIGN KEY (`courseTeacher`) REFERENCES `teacher_information` (`uniqueClientID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='课程信息表（course_information）';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_information`
--

LOCK TABLES `course_information` WRITE;
/*!40000 ALTER TABLE `course_information` DISABLE KEYS */;
INSERT INTO `course_information` VALUES ('CAXX000001','马克思主义概论','UT00000001','2018-02-02 10:30:00','2018-02-16 10:30:00','2018-08-16 10:30:00','综合教学楼（704）','DE','EAXX000001',NULL,NULL,NULL,NULL,'',90,'Y'),('CAXX000002','毛泽东思想与社会主义概论','UT00000002','2018-02-02 10:30:00','2018-02-16 10:30:00','2018-08-16 10:30:00','第一教学楼（205）','EE','EAXX000004',NULL,NULL,NULL,NULL,NULL,70,'Y'),('CAXX000003','近现代史纲要','UT00000001','2018-03-31 10:30:30','2018-04-01 10:30:30','2018-08-16 10:30:00','第一教学楼（205）','EB','EAXX000003',0,0,NULL,NULL,NULL,60,'Y'),('CBXX000001','经济学原理','UT00000003','2018-02-02 10:30:00','2018-02-16 10:30:00','2018-08-16 10:30:00','第一教学楼（205）','EC','EBXX000001',NULL,NULL,'',NULL,'',70,'Y'),('CBXX000002','工商管理基础','UT00000003','2018-02-02 10:30:00','2018-02-16 10:30:00','2018-08-16 10:30:00','第一教学楼（205）','EF','EBXX000002',NULL,NULL,'',NULL,'',50,'Y'),('CBXX000003','会计学基础','UT00000001','2018-03-12 10:30:00','2018-03-16 10:30:00','2018-08-16 10:30:00','光电大楼（403）','FA','EBXX000003',NULL,NULL,NULL,NULL,NULL,60,'Y'),('CCXX000001','诉讼法概论','UT00000003','2018-02-02 10:30:00','2018-02-16 10:30:00','2018-08-16 10:30:00','第一教学楼（205）','ED','ECXX000001',NULL,NULL,'',NULL,'',70,'Y'),('CCXX000002','民法概论','UT00000003','2018-02-02 10:30:00','2018-02-16 10:30:00','2018-08-16 10:30:00','第一教学楼（205）','DE','ECXX000002',NULL,NULL,'',NULL,'',60,'Y'),('CEXX000001','唐朝历史','UT00000003','2018-02-02 10:30:00','2018-02-16 10:30:00','2018-08-16 10:30:00','第一教学楼（205）','GF','EEXX000001',NULL,NULL,'',NULL,'',60,'Y'),('CIXX000001','农学概论','UT00000003','2018-02-02 10:30:00','2018-02-16 10:30:00','2018-08-16 10:30:00','第一教学楼（205）','DF','EIXX000001',NULL,NULL,'',NULL,'',70,'Y'),('CIXX000002','植物学','UT00000014','2018-02-02 10:30:00','2018-02-16 10:30:00','2018-08-16 10:30:00','第一教学楼（205）','AB','EIXX000002',0,0,NULL,NULL,NULL,50,'Y'),('CIXX000003','动物学','UT00000015','2018-02-02 10:30:00','2018-02-16 10:30:00','2018-08-16 10:30:00','第一教学楼（205）','EC','EIXX000003',0,0,NULL,NULL,NULL,30,'Y'),('CIXX000004','微生物学','UT00000016','2018-02-02 10:30:00','2018-02-16 10:30:00','2018-08-16 10:30:00','第一教学楼（205）','FC','EIXX000004',0,0,NULL,NULL,NULL,70,'Y'),('CIXX000005','稻米种植法','UT00000017','2018-02-02 10:30:00','2018-02-16 10:30:00','2018-08-16 10:30:00','第一教学楼（205）','BB','EIXX000005',0,0,NULL,NULL,NULL,60,'Y'),('CIXX000006','谷物与气候的关系','UT00000018','2018-02-02 10:30:00','2018-02-16 10:30:00','2018-08-16 10:30:00','第一教学楼（205）','EA','EIXX000006',0,0,NULL,NULL,NULL,90,'Y'),('CIXX000007','绿色蔬菜种植方法','UT00000019','2018-02-02 10:30:00','2018-02-16 10:30:00','2018-08-16 10:30:00','第一教学楼（205）','DA','EIXX000007',0,0,NULL,NULL,NULL,100,'Y'),('CIXX000008','哺乳动物学','UT00000020','2018-02-02 10:30:00','2018-02-16 10:30:00','2018-08-16 10:30:00','第一教学楼（205）','CD','EIXX000008',0,0,NULL,NULL,NULL,20,'Y'),('CIXX000009','脊椎动物学','UT00000021','2018-02-02 10:30:00','2018-02-16 10:30:00','2018-08-16 10:30:00','第一教学楼（205）','DC','EIXX000009',0,0,NULL,NULL,NULL,25,'Y'),('CIXX000010','被子植物学','UT00000022','2018-02-02 10:30:00','2018-02-16 10:30:00','2018-08-16 10:30:00','第一教学楼（205）','DF','EIXX000010',0,0,NULL,NULL,NULL,36,'Y'),('CIXX000011','裸子植物学','UT00000023','2018-02-02 10:30:00','2018-02-16 10:30:00','2018-08-16 10:30:00','第一教学楼（205）','GF','EIXX000011',0,0,NULL,NULL,NULL,40,'Y'),('CIXX000012','羊群与牧犬的关系','UT00000024','2018-02-02 10:30:00','2018-02-16 10:30:00','2018-08-16 10:30:00','第一教学楼（205）','GA','EIXX000012',0,0,NULL,NULL,NULL,50,'Y'),('CKXX000001','军训概论','UT00000003','2018-02-02 10:30:00','2018-02-16 10:30:00','2018-08-16 10:30:00','第二教学楼（400）','AA','EKXX000001',NULL,NULL,'',NULL,'',60,'Y'),('CKXX000002','军训概论基础原理','UT00000004','2018-03-02 10:30:00','2018-05-07 10:00:00','2018-08-16 20:00:00','第二教学楼（400）','EA','EKXX000002',NULL,NULL,'',NULL,'',100,'Y'),('CLXX000001','管理的艺术','UT00000003','2018-02-02 10:30:00','2018-02-16 10:30:00','2018-08-16 10:30:00','第一教学楼（205）','DC','ELXX000001',NULL,NULL,'',NULL,'',70,'Y'),('CLXX000002','管理的交响','UT00000010','2018-04-17 17:30:00','2018-05-17 17:30:00','2018-09-17 17:30:00','第二教学楼（205）','CC','ELXX000002',0,0,NULL,NULL,NULL,47,'Y'),('CLXX000003','管理与智慧','UT00000011','2018-04-17 17:30:00','2018-05-17 17:30:00','2018-09-17 17:30:00','第二教学楼（205）','DD','ELXX000003',0,0,NULL,NULL,NULL,44,'Y'),('CLXX000004','经济与管理','UT00000012','2018-04-17 17:30:00','2018-05-17 17:30:00','2018-09-17 17:30:00','第二教学楼（205）','EE','ELXX000004',0,0,NULL,NULL,NULL,55,'Y'),('CLXX000005','军事化管理','UT00000013','2018-04-17 17:30:00','2018-05-17 17:30:00','2018-09-17 17:30:00','第二教学楼（205）','FF','ELXX000005',0,0,NULL,NULL,NULL,50,'Y'),('CLXX000006','管理学','UT00000014','2018-04-17 17:30:00','2018-05-17 17:30:00','2018-09-17 17:30:00','第二教学楼（205）','BC','ELXX000006',0,0,NULL,NULL,NULL,90,'Y'),('CLXX000007','宏观经济分析','UT00000015','2018-04-17 17:30:00','2018-05-17 17:30:00','2018-09-17 17:30:00','第二教学楼（205）','ED','ELXX000007',0,0,NULL,NULL,NULL,150,'Y'),('CLXX000008','微观经济分析','UT00000016','2018-04-17 17:30:00','2018-05-17 17:30:00','2018-09-17 17:30:00','第二教学楼（205）','EA','ELXX000008',0,0,NULL,NULL,NULL,500,'Y');
/*!40000 ALTER TABLE `course_information` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = gbk */ ;
/*!50003 SET character_set_results = gbk */ ;
/*!50003 SET collation_connection  = gbk_chinese_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger courseID_tr
before insert on course_information
for each row
insert into exam_information(examID) values(new.examID) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `course_records`
--

DROP TABLE IF EXISTS `course_records`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_records` (
  `suid` char(10) NOT NULL,
  `cuid` char(10) NOT NULL,
  `mtype` char(1) DEFAULT 'N' COMMENT 'A: Choose course; B: Collect Course; AB:Choose and Collect',
  `mtime` varchar(30) DEFAULT NULL,
  `ifdeleted` char(1) DEFAULT 'N' COMMENT 'N: Not deleted; Y: Deleted',
  PRIMARY KEY (`suid`,`cuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_records`
--

LOCK TABLES `course_records` WRITE;
/*!40000 ALTER TABLE `course_records` DISABLE KEYS */;
INSERT INTO `course_records` VALUES ('US00000001','CAXX000001','C','2018-04-07 16:38:37','N'),('US00000001','CAXX000002','C','2018-03-29 19:28:38','N'),('US00000001','CAXX000003','C','2018-05-06 12:49:22','N'),('US00000001','CBXX000001','A','2018-03-29 18:33:54','N'),('US00000001','CBXX000002','B','2018-04-04 18:22:39','N'),('US00000001','CBXX000003','C','2018-04-07 16:38:51','N'),('US00000001','CCXX000001','A','2018-04-07 15:11:29','N'),('US00000001','CCXX000002','C','2018-04-04 18:22:16','N'),('US00000001','CEXX000001','C','2018-04-07 10:00:00','N'),('US00000001','CIXX000001','A','2018-04-07 10:00:00','N'),('US00000001','CIXX000002','A','2018-05-16 15:53:18','N'),('US00000001','CIXX000003','A','2018-05-06 12:49:55','N'),('US00000001','CIXX000004','B','2018-05-16 15:52:03','Y'),('US00000001','CIXX000005','A','2018-05-16 15:04:58','N'),('US00000001','CIXX000006','A','2018-05-16 16:04:01','N'),('US00000001','CIXX000007','A','2018-05-16 16:04:10','Y'),('US00000001','CIXX000008','C','2018-05-16 16:39:59','N'),('US00000001','CIXX000009','A','2018-05-16 17:00:15','Y'),('US00000001','CIXX000011','A','2018-05-16 15:46:24','N'),('US00000001','CIXX000012','A','2018-05-16 17:47:28','N'),('US00000001','CKXX000002','C','2018-04-07 10:00:00','N'),('US00000001','CLXX000001','C','2018-03-29 19:28:44','N'),('US00000002','CAXX000001','C','2018-03-31 10:00:00','N'),('US00000002','CCXX000001','C','2018-04-07 21:52:00','N'),('US00000003','CAXX000001','C','2018-03-31 10:00:00','N'),('US00000004','CAXX000001','C','2018-03-31 10:00:00','N'),('US00000004','CBXX000001','A','2018-05-16 17:49:22','N'),('US00000004','CCXX000002','C','2018-05-16 17:49:01','N'),('US00000004','CIXX000004','A','2018-05-16 17:51:22','N');
/*!40000 ALTER TABLE `course_records` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exam_information`
--

DROP TABLE IF EXISTS `exam_information`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `exam_information` (
  `examID` char(10) NOT NULL COMMENT '考试代号：10字符固定长度',
  `courseID` char(10) DEFAULT NULL COMMENT '课程代号：10字符固定长度，通过此字段可以获取课程名称（外键于课程信息表）',
  `examDate` varchar(30) DEFAULT NULL COMMENT '例如：2017-11-12 11:30:00(yymmdd-hhmmss)',
  `examDuration` varchar(5) DEFAULT '1',
  `examVenue` varchar(10) DEFAULT NULL COMMENT '格式：同上课地点（venue）',
  `examType` varchar(15) DEFAULT '闭卷' COMMENT '格式：开卷/闭卷',
  `examTaken` int(11) DEFAULT '0' COMMENT '参加考试的人数',
  `examRate` varchar(4) DEFAULT '60%' COMMENT '合格率',
  `ava` char(1) DEFAULT 'Y',
  PRIMARY KEY (`examID`),
  KEY `courseID_idx` (`courseID`),
  KEY `examVenue_idx` (`examVenue`),
  CONSTRAINT `courseID` FOREIGN KEY (`courseID`) REFERENCES `course_information` (`courseID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='考试信息表（exam_information）';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exam_information`
--

LOCK TABLES `exam_information` WRITE;
/*!40000 ALTER TABLE `exam_information` DISABLE KEYS */;
INSERT INTO `exam_information` VALUES ('EAXX000001','CAXX000001','2018-10-15 15:00:00','2.5','ROOMA10305','开卷',0,'60%','Y'),('EAXX000002','CAXX000002','2018-10-15 15:00:00','1','ROOMA10304','闭卷',0,'60%','Y'),('EAXX000003','CAXX000003','2018/08/17 18:00','1','ROOMA10303','闭卷',0,'60%','Y'),('EBXX000001','CBXX000001','2018-10-15 15:00:00','1','ROOMA10303','闭卷',0,'60%','Y'),('EBXX000002','CBXX000002','2018/05/16 19:00:00','1','ROOMA10302','闭卷',0,'60%','Y'),('EBXX000003','CBXX000003','2018-10-15 15:00:00','1','ROOMA10301','闭卷',0,'60%','Y'),('ECXX000001','CCXX000001','2018-10-15 15:00:00','1','ROOMA10301','闭卷',0,'60%','Y'),('ECXX000002','CCXX000002','2018-10-15 15:00:00','1','ROOMA10305','闭卷',0,'60%','Y'),('EEXX000001','CEXX000001','2018/08/17 18:00','1','ROOMA50704','开卷',0,'60%','Y'),('EIXX000001','CIXX000001','2018/05/16 19:00','1','ROOMA50704','开卷',0,'60%','Y'),('EIXX000002',NULL,NULL,'1',NULL,'闭卷',0,'60%','Y'),('EIXX000003',NULL,NULL,'1',NULL,'闭卷',0,'60%','Y'),('EIXX000004',NULL,NULL,'1',NULL,'闭卷',0,'60%','Y'),('EIXX000005',NULL,NULL,'1',NULL,'闭卷',0,'60%','Y'),('EIXX000006',NULL,NULL,'1',NULL,'闭卷',0,'60%','Y'),('EIXX000007',NULL,NULL,'1',NULL,'闭卷',0,'60%','Y'),('EIXX000008',NULL,NULL,'1',NULL,'闭卷',0,'60%','Y'),('EIXX000009',NULL,NULL,'1',NULL,'闭卷',0,'60%','Y'),('EIXX000010',NULL,NULL,'1',NULL,'闭卷',0,'60%','Y'),('EIXX000011',NULL,NULL,'1',NULL,'闭卷',0,'60%','Y'),('EIXX000012',NULL,NULL,'1',NULL,'闭卷',0,'60%','Y'),('EKXX000001','CKXX000001','2018/08/17 18:00','3','ROOMA10305','闭卷',0,'60%','Y'),('EKXX000002','CKXX000002','2018/08/17 18:00','1.5','ROOMA10305','开卷',0,'60%','Y'),('ELXX000001','CLXX000001','2018/05/16 19:00','1','ROOMA10305','闭卷',0,'60%','Y'),('ELXX000002',NULL,NULL,'1',NULL,'闭卷',0,'60%','Y'),('ELXX000003',NULL,NULL,'1',NULL,'闭卷',0,'60%','Y'),('ELXX000004',NULL,NULL,'1',NULL,'闭卷',0,'60%','Y'),('ELXX000005',NULL,NULL,'1',NULL,'闭卷',0,'60%','Y'),('ELXX000006',NULL,NULL,'1',NULL,'闭卷',0,'60%','Y'),('ELXX000007',NULL,NULL,'1',NULL,'闭卷',0,'60%','Y'),('ELXX000008',NULL,NULL,'1',NULL,'闭卷',0,'60%','Y');
/*!40000 ALTER TABLE `exam_information` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `login_examine`
--

DROP TABLE IF EXISTS `login_examine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `login_examine` (
  `uniqueClientID` char(10) NOT NULL COMMENT '此处编号唯一标识一个用户，即用户的用户名和密码不能同时一致，包括教师和学生，以及管理员',
  `username` varchar(50) NOT NULL COMMENT '此处的用户名即为登录名，不同于用户姓名',
  `password` varchar(1024) NOT NULL COMMENT '此处的密码（长度小于50byte）经过函数加密，存储方式为：密文（长度小于1024byte）',
  `registryDate` varchar(30) DEFAULT '2018-01-01 12:00:00',
  `registryType` enum('S','T','A') NOT NULL DEFAULT 'S' COMMENT '注册类型：学生（''Student''）/教师（''Teacher''）/管理员（''Admin''），不区分大小写。',
  `ava` varchar(45) DEFAULT 'Y',
  PRIMARY KEY (`uniqueClientID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='登陆验证表（login_examine）';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `login_examine`
--

LOCK TABLES `login_examine` WRITE;
/*!40000 ALTER TABLE `login_examine` DISABLE KEYS */;
INSERT INTO `login_examine` VALUES ('UA00000001','zhangwang@126.com','123456','2018-01-01 12:00:00','A','Y'),('US00000001','wangqifan1996@126.com','123456','2018-01-01 12:00:00','S','Y'),('US00000002','liminqi@126.com','123456','2018-03-24 09:15:50','S','Y'),('US00000003','wangyongjian@126.com','123456','2018-03-24 09:16:11','S','Y'),('US00000004','happywang@email.com','654321','2018-03-24 11:02:25','S','Y'),('UT00000001','miaojunpei1995@qq.com','123456','2018-01-01 12:00:00','T','Y'),('UT00000002','happy@email.com','654321','2018-03-19 20:14:52','T','Y'),('UT00000003','busybuzzy@email.com','123456','2018-03-19 20:20:22','T','Y'),('UT00000004','jiangxiaohui@outlook.com','123456','2018-03-24 09:15:00','T','Y'),('UT00000005','yuzhixian@usst.edu.cn','123456','2018-04-14 16:35:00','T','Y'),('UT00000006','yujinhong@usst.edu.cn','123456','2018-04-14 16:35:00','T','Y'),('UT00000007','xulizhu@usst.edu.cn','123456','2018-04-14 16:35:00','T','Y'),('UT00000008','jihaihui@usst.edu.cn','123456','2018-04-14 16:35:00','T','Y'),('UT00000009','xushuihua@usst.edu.cn','123456','2018-04-14 16:35:00','T','Y'),('UT00000010','songqinghong@usst.edu.cn','123456','2018-04-14 16:35:00','T','Y'),('UT00000011','caiyufan@usst.edu.cn','123456','2018-04-14 16:35:00','T','Y'),('UT00000012','xuboqing@usst.edu.cn','123456','2018-04-14 16:35:00','T','Y'),('UT00000013','yanxiaolei@usst.edu.cn','123456','2018-04-14 16:35:00','T','Y'),('UT00000014','houwen@usst.edu.cn','123456','2018-04-14 16:35:00','T','Y'),('UT00000015','huangfuquansheng@usst.edu.cn','123456','2018-04-14 16:35:00','T','Y'),('UT00000016','zhanglifang@usst.edu.cn','123456','2018-04-14 16:35:00','T','Y'),('UT00000017','qinmei@usst.edu.cn','123456','2018-04-14 16:35:00','T','Y'),('UT00000018','guomaoxing@usst.edu.cn','123456','2018-04-14 16:35:00','T','Y'),('UT00000019','zangjinsong@usst.edu.cn','123456','2018-04-14 16:35:00','T','Y'),('UT00000020','sunhao@usst.edu.cn','123456','2018-04-14 16:35:00','T','Y'),('UT00000021','yangdonglei@usst.edu.cn','123456','2018-04-14 16:35:00','T','Y'),('UT00000022','lianghao@usst.edu.cn','123456','2018-04-14 16:35:00','T','Y'),('UT00000023','bojun@usst.edu.cn','123456','2018-04-14 16:35:00','T','Y'),('UT00000024','ouguangyu@usst.edu.cn','123456','2018-04-14 16:35:00','T','Y'),('UT00000025','hudemin@usst.edu.cn','123456','2018-04-14 16:35:00','T','Y'),('UT00000026','zhouqun@usst.edu.cn','123456','2018-04-14 16:35:00','T','Y'),('UT00000027','xujianguang@usst.edu.cn','123456','2018-04-14 16:35:00','T','Y'),('UT00000028','wangcongcong@usst.edu.cn','123456','2018-04-14 16:35:00','T','Y'),('UT00000029','aikefeng@usst.edu.cn','123456','2018-04-14 16:35:00','T','Y'),('UT00000030','yangzan@usst.edu.cn','123456','2018-04-14 16:35:00','T','Y'),('UT00000031','lilei@usst.edu.cn','123456','2018-04-14 16:35:00','T','Y'),('UT00000032','caochunping@usst.edu.cn','123456','2018-04-14 16:35:00','T','Y'),('UT00000033','shaoqing@usst.edu.cn','123456','2018-04-14 16:35:00','T','Y'),('UT00000034','chendawen@usst.edu.cn','123456','2018-04-14 16:35:00','T','Y'),('UT00000035','qianjianqiu@usst.edu.cn','123456','2018-04-14 16:35:00','T','Y'),('UT00000036','yangguisong@usst.edu.cn','123456','2018-04-14 16:35:00','T','Y'),('UT00000037','liyansong@usst.edu.cn','123456','2018-04-14 16:35:00','T','Y'),('UT00000038','zhuzhen@usst.edu.cn','123456','2018-04-14 16:35:00','T','Y'),('UT00000039','maoweiqin@usst.edu.cn','123456','2018-04-14 16:35:00','T','Y'),('UT00000040','zhangyan@usst.edu.cn','123456','2018-04-14 16:35:00','T','Y'),('UT00000041','zhangxing@usst.edu.cn','123456','2018-04-14 16:35:00','T','Y'),('UT00000042','pengdunlu@usst.edu.cn','123456','2018-04-14 16:35:00','T','Y'),('UT00000043','lirui@usst.edu.cn','123456','2018-04-14 16:35:00','T','Y'),('UT00000044','zhaohaiyan@usst.edu.cn','123456','2018-04-14 16:35:00','T','Y'),('UT00000045','sufanjun@usst.edu.cn','123456','2018-04-14 16:35:00','T','Y'),('UT00000046','zhaofengyu@usst.edu.cn','123456','2018-04-14 16:35:00','T','Y'),('UT00000047','liuya@usst.edu.cn','123456','2018-04-14 16:35:00','T','Y'),('UT00000048','miaojianwei@usst.edu.cn','123456','2018-04-14 16:35:00','T','Y'),('UT00000049','zouhua@usst.edu.cn','123456','2018-04-14 16:35:00','T','Y');
/*!40000 ALTER TABLE `login_examine` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `room_information`
--

DROP TABLE IF EXISTS `room_information`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `room_information` (
  `roomID` char(10) NOT NULL COMMENT '教室代号',
  `roomName` varchar(60) DEFAULT NULL COMMENT '例如：综合教学楼405教室;格式：综合教学楼（405教室）',
  `roomTag` varchar(35) DEFAULT NULL COMMENT '例如：豫园/世博园/森林公园',
  `roomBuilding` char(2) DEFAULT NULL COMMENT '所属建筑；例如：综合楼/第一教学楼/第二教学楼/申二教',
  `roomCapacity` smallint(6) DEFAULT '30' COMMENT '可容人数：不超过999人',
  PRIMARY KEY (`roomID`),
  KEY `roomBuilding_idx` (`roomBuilding`),
  CONSTRAINT `roomBuilding` FOREIGN KEY (`roomBuilding`) REFERENCES `build_information` (`code`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='教室信息表（room_information）';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `room_information`
--

LOCK TABLES `room_information` WRITE;
/*!40000 ALTER TABLE `room_information` DISABLE KEYS */;
INSERT INTO `room_information` VALUES ('ROOMA10305','第一教学楼（305）','一教305','A1',60),('ROOMA10306','第一教学楼（306）','一教306','A1',60),('ROOMA20110','第二教学楼（110）','二教110','A2',80),('ROOMA20306','第二教学楼（306）','二教306','A2',60),('ROOMA30210','第三教学楼（210）','三教210','A3',80),('ROOMA50704','综合教学楼（704）','','A5',60),('ROOMA61009','光电信息与计算机工程学院大楼（1009）','光电大楼1009','A6',100),('ROOMA80000','健身房',NULL,'A8',60),('ROOMBH0100','大礼堂一楼',NULL,'BH',300),('ROOMBH0300','大礼堂三楼',NULL,'BH',150),('ROOMMH0200','音乐堂二楼',NULL,'MH',20),('ROOMS10100','申一教学楼（100）',NULL,'S1',60),('ROOMS20305','申二教学楼（305）',NULL,'S2',70),('ROOMSW0000','游泳池',NULL,'SW',30);
/*!40000 ALTER TABLE `room_information` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roomuse_information`
--

DROP TABLE IF EXISTS `roomuse_information`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roomuse_information` (
  `roomID` char(10) NOT NULL COMMENT '外键于教室信息表',
  `type` enum('C','E') DEFAULT 'C' COMMENT '考试占用或上课占用（E代表考试，C代表上课）',
  `occupier` char(10) DEFAULT NULL COMMENT '此处为占用教师ID号码',
  `dayperiod` enum('AA','AB','AC','AD','AE','AF','CA','CB','CC','CD','CE','CF','DA','DB','DC','DD','DE','DF','EA','EB','EC','ED','EE','EF','FA','FB','FC','FD','FE','FF','GA','GB','GC','GD','GE','GF') DEFAULT NULL COMMENT '该字段为结合字段（由weekday和period结合），表示方法见页面备注事项。'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='教室使用表（roomuse_information）';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roomuse_information`
--

LOCK TABLES `roomuse_information` WRITE;
/*!40000 ALTER TABLE `roomuse_information` DISABLE KEYS */;
/*!40000 ALTER TABLE `roomuse_information` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `semester`
--

DROP TABLE IF EXISTS `semester`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `semester` (
  `year` char(4) CHARACTER SET latin1 NOT NULL,
  `sems` char(1) CHARACTER SET latin1 NOT NULL,
  `start` varchar(20) CHARACTER SET latin1 NOT NULL,
  `end` varchar(20) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`year`,`sems`,`start`,`end`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `semester`
--

LOCK TABLES `semester` WRITE;
/*!40000 ALTER TABLE `semester` DISABLE KEYS */;
INSERT INTO `semester` VALUES ('2018','1','2018-02-02 00:00:00','2018-09-09 00:00:00'),('2018','2','2018-09-02 00:00:00','2019-03-09 00:00:00'),('2019','1','2019-03-02 00:00:00','2019-09-09 00:00:00'),('2019','2','2019-09-02 00:00:00','2020-02-09 00:00:00');
/*!40000 ALTER TABLE `semester` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_information`
--

DROP TABLE IF EXISTS `student_information`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student_information` (
  `uniqueClientID` char(10) NOT NULL COMMENT '此处唯一编号唯一标识一个用户，即用户的用户名和密码不能同时一致',
  `name` varchar(30) NOT NULL COMMENT '此处姓名并非唯一（不要求唯一性）',
  `gender` enum('M','F','U') NOT NULL DEFAULT 'U' COMMENT '性别：男（''Male''）/女（''Female''）/未知（''Unknown'')',
  `age` smallint(6) DEFAULT NULL COMMENT '年龄：使用smallint类型，不同于tinyint或者int',
  `email` varchar(50) DEFAULT NULL COMMENT '邮箱：不超过50个字符（字节）',
  `wechat` varchar(50) DEFAULT NULL COMMENT '微信：不超过50个字符（字节）',
  `qqNumber` varchar(12) DEFAULT NULL COMMENT '腾讯：不超过12个字符（字节）',
  `phone` varchar(30) DEFAULT NULL COMMENT '手机：不超过30个字符（字节）',
  `university` varchar(100) DEFAULT NULL COMMENT '学校：不超过100个字符（字节）',
  `college` varchar(100) DEFAULT NULL COMMENT '学院：不超过100个字符（字节）',
  `major` varchar(100) DEFAULT NULL COMMENT '专业：不超过100个字符（字节）',
  `position` enum('B','M','D') DEFAULT NULL COMMENT '学位：本科（B）/硕士研究生（M）/博士研究生（D）',
  `grade` enum('FR','SO','JU','SE') DEFAULT NULL COMMENT '年级：一年级（Freshman）/二年级（Sophomore）/三年级（Junior）/四年级（Senior）',
  `cardNo` varchar(20) DEFAULT NULL COMMENT '学生卡上的号码',
  `cardPass` varchar(1024) DEFAULT NULL COMMENT '此处的密码经过函数加密，存储方式为：密文',
  KEY `uniqueClientID_idx` (`uniqueClientID`),
  CONSTRAINT `uniqueClientIDs` FOREIGN KEY (`uniqueClientID`) REFERENCES `login_examine` (`uniqueClientID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='学生信息表（student_information）';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_information`
--

LOCK TABLES `student_information` WRITE;
/*!40000 ALTER TABLE `student_information` DISABLE KEYS */;
INSERT INTO `student_information` VALUES ('US00000001','王启帆','M',22,'wangqifan1996@126.com','EricWong1996','1318272348','15316831783','上海理工大学','光电信息与计算机工程学院','计算机科学与技术','B','SE','1318272348',NULL),('US00000002','李旻琦','M',20,'liminqi@anothermail.com','','','','上海理工大学','','','B','SE','',''),('US00000003','王永健','M',22,'wangyongjian@anothermail.com','','','','上海理工大学','','','B','SE','',''),('US00000004','冯凯鑫','M',32,'happy@anothermail.com','','','','上海理工大学','','','B','SE','','');
/*!40000 ALTER TABLE `student_information` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subject_category`
--

DROP TABLE IF EXISTS `subject_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subject_category` (
  `code` char(2) NOT NULL COMMENT 'CA,CB,CC,CD,CE,...,CM（共十三个学科门类代号）',
  `name` varchar(20) DEFAULT NULL COMMENT '哲学，...，法学共十三个',
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='学科门类表（subject_category）';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subject_category`
--

LOCK TABLES `subject_category` WRITE;
/*!40000 ALTER TABLE `subject_category` DISABLE KEYS */;
INSERT INTO `subject_category` VALUES ('CA','哲学'),('CB','经济学'),('CC','法学'),('CD','教育学'),('CE','文学'),('CF','历史学'),('CG','理学'),('CH','工学'),('CI','农学'),('CJ','医学'),('CK','军事学'),('CL','管理学'),('CM','艺术学');
/*!40000 ALTER TABLE `subject_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teacher_information`
--

DROP TABLE IF EXISTS `teacher_information`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `teacher_information` (
  `uniqueClientID` char(10) NOT NULL COMMENT '此处唯一编号唯一标识一个用户，即用户的用户名和密码不能同时一致',
  `name` varchar(30) NOT NULL COMMENT '此处姓名并非唯一（不要求唯一性）',
  `gender` enum('M','F','U') NOT NULL DEFAULT 'U' COMMENT '性别：男（''Male''）/女（''Female''）/未知（''Unknown'')',
  `age` smallint(6) DEFAULT NULL COMMENT '年龄：使用smallint类型，不同于tinyint或者int',
  `email` varchar(50) DEFAULT NULL COMMENT '邮箱：不超过50个字符（字节）',
  `wechat` varchar(50) DEFAULT NULL COMMENT '微信：不超过50个字符（字节）',
  `qqNumber` varchar(12) DEFAULT NULL COMMENT '腾讯：不超过12个字符（字节）',
  `phone` varchar(30) DEFAULT NULL COMMENT '手机：不超过30个字符（字节）',
  `university` varchar(100) DEFAULT NULL COMMENT '学校：不超过100个字符（字节）',
  `college` varchar(100) DEFAULT NULL COMMENT '学院：不超过100个字符（字节）',
  `major` varchar(100) DEFAULT NULL COMMENT '专业：不超过100个字符（字节）',
  `courses` varchar(125) DEFAULT NULL COMMENT '表示方法：JSON格式{''courseID1'',''courseID2'',...}',
  `workNo` varchar(20) DEFAULT NULL COMMENT '学生卡上的号码',
  `workPass` varchar(1024) DEFAULT NULL COMMENT '此处的密码经过函数加密，存储方式为：密文',
  UNIQUE KEY `uniqueClientID_UNIQUE` (`uniqueClientID`),
  KEY `uniqueClientID_idx` (`uniqueClientID`),
  CONSTRAINT `uniqueClientIDt` FOREIGN KEY (`uniqueClientID`) REFERENCES `login_examine` (`uniqueClientID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='教师信息表（teacher_information）';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teacher_information`
--

LOCK TABLES `teacher_information` WRITE;
/*!40000 ALTER TABLE `teacher_information` DISABLE KEYS */;
INSERT INTO `teacher_information` VALUES ('UT00000001','庙军培','M',23,'miaojunpei1995@qq.com','miaojunpei1995','1049175213','15316831929','北京邮电大学','计算机学院','通信工程','','1412480409',NULL),('UT00000002','李凯馨','F',27,'happy@anothermail.com','happy','1049234563','15314567689','Nottingham University','计算机学院','通信工程','','1412580409',''),('UT00000003','巴则则','M',29,'busybuzzy@anothermail.com','busybuzzy','4391334563','15856567689','Harvard University','计算机学院','通信工程','','1412559409',''),('UT00000004','江小辉','M',40,'jiangxianghui@anothermail.com','jiangxianghui','4391343563','15786567689','北京大学','计算机学院','通信工程','','1417559409',''),('UT00000005','余志先','M',29,'yuzhixian@usst.edu.cn','yuzhixian','4391334563','15786567689','北京师范大学','计算机学院','通信工程',NULL,NULL,NULL),('UT00000006','于金红','F',29,'yujinhong@usst.edu.cn','yujinhong','4391334563','15786567689','北京师范大学','计算机学院','通信工程',NULL,NULL,NULL),('UT00000007','徐丽珠','F',29,'xulizhu@usst.edu.cn','xulizhu','4391334563','15786567689','北京师范大学','计算机学院','通信工程',NULL,NULL,NULL),('UT00000008','纪海慧','F',29,'jihaihui@usst.edu.cn','jihaihui','4391334563','15786567689','北京师范大学','计算机学院','通信工程',NULL,NULL,NULL),('UT00000009','徐水华','M',29,'xushuihua@usst.edu.cn','xushuihua','4391334563','15786567689','北京师范大学','计算机学院','通信工程',NULL,NULL,NULL),('UT00000010','宋青红','F',29,'songqinghong@usst.edu.cn','songqinghong','4391334563','15786567689','北京师范大学','计算机学院','通信工程',NULL,NULL,NULL),('UT00000011','蔡育凡','M',29,'caiyufan@usst.edu.cn','caiyufan','4391334563','15786567689','北京师范大学','计算机学院','通信工程',NULL,NULL,NULL),('UT00000012','徐伯清','M',29,'xuboqing@usst.edu.cn','xuboqing','4391334563','15786567689','北京师范大学','计算机学院','通信工程',NULL,NULL,NULL),('UT00000013','杨晓磊','M',29,'yanxiaolei@usst.edu.cn','yanxiaolei','4391334563','15786567689','北京师范大学乌鲁木齐分校','计算机学院','通信工程',NULL,NULL,NULL),('UT00000014','候文','F',29,'houwen@usst.edu.cn','houwen','4391334563','15786567689','北京师范大学','计算机学院','通信工程',NULL,NULL,NULL),('UT00000015','皇甫泉声','M',29,'huangfuquansheng@usst.edu.cn','huangfuquansheng','4391334563','15786567689','北京师范大学','计算机学院','通信工程',NULL,NULL,NULL),('UT00000016','张丽芳','F',29,'zhanglifang@usst.edu.cn','zhanglifang','4391334563','15786567689','北京师范大学','计算机学院','通信工程',NULL,NULL,NULL),('UT00000017','秦梅','F',29,'qinmei@usst.edu.cn','qinmei','4391334563','15786567689','北京师范大学','计算机学院','通信工程',NULL,NULL,NULL),('UT00000018','郭茂星','M',29,'guomaoxing@usst.edu.cn','guomaoxing','4391334563','15786567689','北京师范大学','计算机学院','通信工程',NULL,NULL,NULL),('UT00000019','臧劲松','F',29,'zangjinsong@usst.edu.cn','zangjinsong','4391334563','15786567689','北京航空航天大学','计算机学院','通信工程',NULL,NULL,NULL),('UT00000020','孙浩','M',29,'sunhao@usst.edu.cn','sunhao','4391334563','15786567689','北京师范大学','计算机学院','通信工程',NULL,NULL,NULL),('UT00000021','杨董磊','M',29,'yangdonglei@usst.edu.cn','yangdonglei','4391334563','15786567689','北京师范大学','计算机学院','通信工程',NULL,NULL,NULL),('UT00000022','梁浩','M',29,'lianghao@usst.edu.cn','lianghao','4391334563','15786567689','北京师范大学','计算机学院','通信工程',NULL,NULL,NULL),('UT00000023','箔君','F',29,'bojun@usst.edu.cn','bojun','4391334563','15786567689','北京师范大学','计算机学院','通信工程',NULL,NULL,NULL),('UT00000024','欧广宇','F',29,'ouguangyu@usst.edu.cn','ouguangyu','4391334563','15786567689','北京师范大学','计算机学院','通信工程',NULL,NULL,NULL),('UT00000025','胡德敏','M',29,'hudemin@usst.edu.cn','hudemin','4391334563','15786567689','北京师范大学','计算机学院','通信工程',NULL,NULL,NULL),('UT00000026','周群','M',29,'zhouqun@usst.edu.cn','zhouqun','4391334563','15786567689','北京师范大学','计算机学院','通信工程',NULL,NULL,NULL),('UT00000027','徐建光','M',29,'xujianguang@usst.edu.cn','xujianguang','4391334563','15786567689','北京师范大学','计算机学院','通信工程',NULL,NULL,NULL),('UT00000028','王聪聪','F',29,'wangcongcong@usst.edu.cn','wangcongcong','4391334563','15786567689','北京师范大学','计算机学院','通信工程',NULL,NULL,NULL),('UT00000029','艾克风','F',29,'aikefeng@usst.edu.cn','aikefeng','4391334563','15786567689','北京师范大学','计算机学院','通信工程',NULL,NULL,NULL),('UT00000030','杨赞','F',29,'yangzan@usst.edu.cn','yangzan','4391334563','15786567689','北京师范大学','计算机学院','通信工程',NULL,NULL,NULL),('UT00000031','李磊','M',29,'lilei@usst.edu.cn','lilei','4391334563','15786567689','北京师范大学','计算机学院','通信工程',NULL,NULL,NULL),('UT00000032','曹春萍','F',29,'caochunping@usst.edu.cn','caochunping','4391334563','15786567689','北京师范大学','计算机学院','通信工程',NULL,NULL,NULL),('UT00000033','邵清','F',29,'shaoqing@usst.edu.cn','shaoqing','4391334563','15786567689','北京师范大学','计算机学院','通信工程',NULL,NULL,NULL),('UT00000034','陈大文','M',29,'chendawen@usst.edu.cn','chendawen','4391334563','15786567689','北京师范大学','计算机学院','通信工程',NULL,NULL,NULL),('UT00000035','钱剑秋','M',29,'qianjianqiu@usst.edu.cn','qianjianqiu','4391334563','15786567689','北京师范大学','计算机学院','通信工程',NULL,NULL,NULL),('UT00000036','杨桂松','M',29,'yangguisong@usst.edu.cn','yangguisong','4391334563','15786567689','北京师范大学','计算机学院','通信工程',NULL,NULL,NULL),('UT00000037','李岩松','M',29,'liyansong@usst.edu.cn','liyansong','4391334563','15786567689','北京师范大学','计算机学院','通信工程',NULL,NULL,NULL),('UT00000038','朱桢','F',29,'zhuzhen@usst.edu.cn','zhuzhen','4391334563','15786567689','北京师范大学','计算机学院','通信工程',NULL,NULL,NULL),('UT00000039','茂伟秦','M',29,'maoweiqin@usst.edu.cn','maoweiqin','4391334563','15786567689','北京师范大学','计算机学院','通信工程',NULL,NULL,NULL),('UT00000040','张艳','F',29,'zhangyan@usst.edu.cn','zhangyan','4391334563','15786567689','北京师范大学','计算机学院','通信工程',NULL,NULL,NULL),('UT00000041','张兴','F',29,'zhangxing@usst.edu.cn','zhangxing','4391334563','15786567689','北京师范大学','计算机学院','通信工程',NULL,NULL,NULL),('UT00000042','彭敦陆','M',29,'pengdunlu@usst.edu.cn','pengdunlu','4391334563','15786567689','北京师范大学','计算机学院','通信工程',NULL,NULL,NULL),('UT00000043','李瑞','M',29,'lirui@usst.edu.cn','lirui','4391334563','15786567689','北京师范大学','计算机学院','通信工程',NULL,NULL,NULL),('UT00000044','赵海燕','F',29,'zhaohaiyan@usst.edu.cn','zhaohaiyan','4391334563','15786567689','北京师范大学','计算机学院','通信工程',NULL,NULL,NULL),('UT00000045','苏凡军','M',29,'sufanjun@usst.edu.cn','sufanjun','4391334563','15786567689','北京师范大学','计算机学院','通信工程',NULL,NULL,NULL),('UT00000046','赵逢禹','M',29,'zhaofengyu@usst.edu.cn','zhaofengyu','4391334563','15786567689','北京师范大学','计算机学院','通信工程',NULL,NULL,NULL),('UT00000047','刘亚','F',29,'liuya@usst.edu.cn','liuya','4391334563','15786567689','北京师范大学','计算机学院','通信工程',NULL,NULL,NULL),('UT00000048','缪建伟','F',29,'miaojianwei@usst.edu.cn','miaojianwei','4391334563','15786567689','北京师范大学','计算机学院','通信工程',NULL,NULL,NULL),('UT00000049','邹华','M',29,'zouhua@usst.edu.cn','zouhua','4391334563','15786567689','北京师范大学','计算机学院','通信工程',NULL,NULL,NULL);
/*!40000 ALTER TABLE `teacher_information` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `v_uidname`
--

DROP TABLE IF EXISTS `v_uidname`;
/*!50001 DROP VIEW IF EXISTS `v_uidname`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_uidname` AS SELECT 
 1 AS `uid`,
 1 AS `uname`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `v_uidname`
--

/*!50001 DROP VIEW IF EXISTS `v_uidname`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_uidname` AS select `student_information`.`uniqueClientID` AS `uid`,`student_information`.`name` AS `uname` from `student_information` union all select `teacher_information`.`uniqueClientID` AS `uniqueclientid`,`teacher_information`.`name` AS `name` from `teacher_information` */;
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

-- Dump completed on 2018-05-20 23:52:42
