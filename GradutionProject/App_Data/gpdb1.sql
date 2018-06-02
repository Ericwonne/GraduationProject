-- MySQL dump 10.13  Distrib 5.7.21, for Win64 (x86_64)
--
-- Host: localhost    Database: gpdb
-- ------------------------------------------------------
-- Server version	5.7.21

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
INSERT INTO `build_information` VALUES ('A1','第一教学楼','Y'),('A2','第二教学楼','Y'),('A3','第三教学楼','Y'),('A4','第四教学楼','Y'),('A5','综合教学楼','Y'),('A6','光电信息与计算机工程学院大楼','Y'),('A7','演讲厅','Y'),('A8','健身房','Y'),('B1','环境与建筑学院大楼','Y'),('B2','能源与动力学院大楼','Y'),('B3','机械学院大楼','Y'),('BH','大礼堂','Y'),('MH','音乐堂','Y'),('S1','申一教学楼','Y'),('S2','申二教学楼','Y'),('SH','小礼堂','Y'),('SW','游泳池','Y');
/*!40000 ALTER TABLE `build_information` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `college_information`
--

DROP TABLE IF EXISTS `college_information`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `college_information` (
  `uniqueCode` varchar(5) CHARACTER SET latin1 NOT NULL,
  `name` varchar(100) CHARACTER SET gbk NOT NULL,
  `descrpt` text CHARACTER SET gbk,
  PRIMARY KEY (`uniqueCode`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='院别信息表（college_information）';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `college_information`
--

LOCK TABLES `college_information` WRITE;
/*!40000 ALTER TABLE `college_information` DISABLE KEYS */;
INSERT INTO `college_information` VALUES ('CE00A','能源与动力工程学院','能源与动力工程学院主要在能源、动力、环境和过程控制等领域培养高级人才和开展科学研究与社会服务，是我国上述领域重要的科研和人才培养基地。学院现有热能与动力工程、新能源科学与工程、过程装备与控制工程三个本科专业，其中热能与动力工程是国家特色专业。学院形成了以国家级精品课、上海市级和校级精品课集群为核心的课程教学体系，可为本科生开设120余门专业基础课和专业课；拥有能源动力类国家级实验教学示范中心和一批依托优秀企业的校外实践教育基地，可为本科生提供优质的实践教学资源。学院师资力量雄厚，有中国工程院院士1人、教授33人（其中博士生导师23人）、副教授36人、具有博士学位的教师47人和国家级教学团队热工教学团队。学院具有动力工程及工程热物理一级学科博士学位授予权和博士后流动站，下辖热能工程、制冷及低温工程、动力机械及工程、工程热物理、化工过程机械、流体机械及工程6 个二级学科博士点和相关专业的7个硕士点，为各专业本科生提供了继续深造的优越条件。学院还与国内外许多著名高等学府建立了紧密的教学和科研合作关系，每年选送部分优秀在读本科生赴日本、德国、法国等国家的著名高校进行交流学习，并推荐部分优秀毕业生进入国内外高校继续攻读更高一级的学位。2013年在上海市及外省市招生专业名称：能源动力类（含能源与动力工程、新能源科学与工程、过程装备与控制工程3个专业）'),('CE00B','光电信息与计算机工程学院','学院现有各类全日制学生4000多人，其中本科学生近3000人，硕士研究生近1000人，博士研究生近100人。学院现有教职工250余人，其中工程院院士1人，国家级有突出贡献的中青年专家1人，国家千人计划特聘教授2人，“长江学者”1人，上海市千人计划特聘教授3人，“东方学者”3人，教育部新世纪优秀人才2名，上海市曙光学者3名，上海市浦江人才2名，上海市科技启明星3名，上海市晨光学者2名，博士生导师20余人，教授30多人、副教授50余人，专任教师近200人。学院下设5个系和1个上海市高等学校本科实验教学示范中心—光电信息实验中心。学院拥有光学工程一级学科博士点和博士后流动站各1个，国家重点学科(培育)1个，教育部工程研究中心1个，上海市重点学科、重点实验室和工程中心各1个，8个二级学科博士点、7个一级学科硕士点、4个工程硕士点和2个上海市本科教育高地。学院现有10个本科专业，其中1个为国家级特色专业。学院教学科研并重，历年来获得重大科研成果奖60余项，其中国家级奖2项，部、市级科技进步三等奖以上近60项。近年来年均科研经费3000万元以上，获得或完成863项目、973项目和国家自然科学基金30多项。获得多项国家级、上海市级精品课程和教学成果奖。学院努力拓展学生的国际视野，已与美国、英国、德国、加拿大、澳大利亚、日本、爱尔兰、爱沙尼亚和台湾等十几个国家和地区的高校和企业建立各种合作关系，每年选送部分学生和教师到国外交流学习。'),('CE00C','管理学院','管理学院前身为我国最早成立的系统工程系和系统工程研究所（1979年），1999年5月更名为管理学院，2006 年 1月与商学院、MBA教育管理中心重组成立新的管理学院（Business School）。学院教职工190多名；博士生140多名，硕士生1500多名，本科生3000多名。学院设有“管理科学与工程”博士后流动站一个，同时具有该学科的一级学科博士学位授予权，并拥有“系统分析与集成”二级学科博士学位授予权。学院拥有“管理科学与工程”、“ 应 用 经 济 学 ” 、 “ 系 统 科学”、“公共管理”等7个一级学科硕士学位授予权。此外，学院还有工商管理硕士（MBA）、公共管理硕士（MPA）、工业工程、项目管理等8个专业硕士学位授予权。学院下设九个系，即工业工程系、公共管理系、工商管理系、信息管理与信息系统系、系统科学系、交通系统工程系、财政金融系、会计学系、国际贸易系，以及专业学位教育中心。管理学院与美国北达科他大学开展本科合作办学项目，与瑞典保鲁斯大学开展本科双学位合作办学项目。'),('CE00D','机械工程学院','上海理工大学源溯百年，其机械制造在国内的工科高等教育史上具有重要影“制造业工程师的摇篮”的美誉。机械工程学院现有机械设计制造及其自动化、车辆工程2个本科专业；拥有机械工程一级学科博士学位和硕士学位授予权，机械制造及其自动化、机械电子工程、机械设计及理论、车辆工程等4个二级学科博学位和硕士学位授予权；并拥有机械工程领域、车辆工程领域工程硕士学位授予“机械工程”一级学科为“上海高校一流学科”。'),('CE00E','外语学院','外语学院前身为科技外语系，1979年开始招收英语和德语本科生，是全国最早开设的两个科技外语专业院校之一，下设英语、德语和日语三个本科专业，共五个方向。其中英语专业在2009年中国大学专业排名154所大学中名列45，被评为A类专业。学院1984年开始招收硕士研究生，现有外国语言学及应用语言学、英语语言文学和翻译专业硕士三个学位点。1996年起，与美国纽约市立大学皇后学院联合创办了上海—纽约国际联合语言学院，是教育部注册登记的国际合作办学单位。在2013年教育部中外合作项目评估中，该合作英语专业本科教育项目以88.89%的优异成绩获得通过，其中“培养目标”和“社会效果”两项达100%。学院现有专职教师140名，其中正、副教授42名，具有博士、硕士学位教师133名，30余名拥有国外留学经历。每年还聘请20余人次外籍教师任教。学院拥有完备的外语教学设施，包括多媒体资料室、自主学习中心、计算机辅助翻译实验室、同声传译实验室和专门用途案例教学教室等；并在合作单位建有多个实习实践基地。学院在教学中注重培养具有国际视野的复合型高素质外语人才。每年举办、承办或参加各种层次的外语专业比赛，在全国赛扶、演讲、辩论、写作、笔译、口译等赛事中屡获殊荣。学院与美国加州大学洛杉矶分校、美国佩斯大学、美国奥特本大学、美国安柏瑞德航空航天大学、英国东伦敦大学、德国柏林教育集团、德国柏林经济与法应用技术大学、德国汉堡应用技术大学、加拿大英属哥伦比亚大学、加拿大菲莎河谷大学、澳大利亚尹迪斯考文大学、瑞典克里斯蒂安塔德大学、日本冈山大学、中央大学、武藏野大学、京都外国语大学、香港中文大学、香港理工大学等境外名校和机构开展学分转换、留学和游学等合作交流。学院与诸多企业开展校企合作，学生就读期间可以参加学院组织的翻译及会展等实习，积累实际工作经验，增加就业竞争力。'),('CE00F','环境与建筑学院','理学院的前身是基础教学部，建于1960年。理学院现拥有光电子物理与器件二级学科博士点，数学、物理学、统计学三个一级学科硕士点，应用数学、基础数学、运筹学与控制论、凝聚态物理、光学、理论物理、绿色化学过程与资源综合利用等7个二级学科硕士点，以及数学与应用数学、应用物理学、应用化学3个本科专业。目前我院有硕士研究生187人，本科生471人。学院拥有一批教学优秀、事业心强的师资队伍，现有教职工97人，其中正教授21人（含兼职）、副教授24人，有上海高校教学名师2人，有博士生、硕士生指导教师40余人。近年来，学院多次获得市优秀教学成果奖和市优秀教材奖，主持或承担30多个国家自然科学基金资助项目、市基金项目和曙光计划项目，总科研经费500余万元。近三年发表论文650余篇，其中SCI收录200余篇。我院组织学生参加全国大学生和研究生数学建模竞赛多次获全国一、二等奖和上海市一等奖。2007年工程数学教研室荣获上海科教系统“文明班组”称号。在田家炳基金会的资助下，学院设立了田家炳奖学金。'),('CE00G','理学院','学院拥有一支实力雄厚的专业教师队伍，其中教授和副教授45名，具有博士学位教师58名；中国工程院院士、著名生物医学工程专家王威琪教授担任学院名誉院长，首届国家级教学名师、著名低温生物医学技术专家华泽钊教授担任学院首席教授。学院所属的医疗器械与食品实验中心设有各类公共和专业实验室18个，总面积达4000平方米。学院依托“现代微创医疗器械及技术”教育部工程研究中心等科研平台，积极开展科学研究和技术创新，在现代医疗器械、智能医学仪器与系统、生物系统热科学及食品安全检测、监控等研究领域内走在了全国的前列，近年来获得了多项国家和省部级奖励。'),('CE00H','医疗器械与食品学院','学院拥有一支实力雄厚的专业教师队伍，其中教授和副教授45名，具有博士学位教师58名；中国工程院院士、著名生物医学工程专家王威琪教授担任学院名誉院长，首届国家级教学名师、著名低温生物医学技术专家华泽钊教授担任学院首席教授。学院所属的医疗器械与食品实验中心设有各类公共和专业实验室18个，总面积达4000平方米。学院依托“现代微创医疗器械及技术”教育部工程研究中心等科研平台，积极开展科学研究和技术创新，在现代医疗器械、智能医学仪器与系统、生物系统热科学及食品安全检测、监控等研究领域内走在了全国的前列，近年来获得了多项国家和省部级奖励。'),('CE00I','出版印刷与艺术设计学院','出版印刷与艺术设计学院是在原出版印刷学院、艺术设计学院基础上于2007年5月合并组建而成。学院是工、文、艺有机融合的多科类学院，现设有印刷与包装工程、新媒体与出版传播、艺术设计、动画与公共艺术、工业设计、音乐系、美术系7个系；设有数字印刷、印刷包装工程、出版与传播、数字出版、现代艺术、创意设计和产品造型设计7个研究所。开设编辑出版学、广告学、传播学、印刷工程、包装工程、环境设计（设环境设计方向、公共艺术方向）、视觉传达设计（设视觉传达设计方向、印刷美术设计方向）、产品设计、工业设计和动画10个本科专业；现有新闻传播学一级硕士点，传播学、印刷光学、数字出版与传播三个硕士学位授权点，印刷光学工程和传媒管理2个二级学科博士学位授权点；建有现代出版印刷（传媒类）国家级实验教学示范中心、国家新闻出版总署印刷出版人才培养基地；国家新闻出版总署数字传播科学重点实验室、国家新闻出版总署数字印刷工程研究中心。现代传播科学上海市级实验教学示范中心；印刷出版上海市重点学科；印刷出版本科专业群和工业设计专业是上海市本科教育高地；“新媒体与出版印刷”学科群是上海理工大学重点建设的六大学科群之一。'),('CE00J','上海-汉堡国际工程学院中德国际学院','2004年12月14日，德国权威的理工学科专业认证机构ASIIN通过对电气工程及其自动化专业和机械设计制造及其自动化专业的评估认证，两个专业的合格毕业生可同时获得上海理工大学和德国汉堡应用技术大学双学士学位。这使上海理工大学成为中国第一个本科工程专业“不出国门就能获得德国大学学士学位证书”的大学，也是中国乃至亚洲地区首个获得ASIIN认证评估的大学。2010年电气工程及其自动化、机械设计制造及其自动化两个专业又通过了复评估，国际经济与贸易也通过了初评估。目前，三个专业都具有未来5年颁发中德双学士学位的资质。2011年，电气工程及其自动化专业受到上海市教委表彰，被评为八个“上海市示范性中外合作办学项目”之一。学院网址：http://shc.usst.edu.cn'),('CE00K','中英国际学院','上海理工大学中英国际学院的校园位于上海理工大学复兴路校区，地处上海市中心地带，交通方便，环境优美，周围商业繁华，文化气氛浓郁。目前学院已建立商务与传播学院和工程学院，下设工商管理系、会展管理系、财务与金融系、电子电气工程系、机械工程系，以及学术英语（EAP）教学中心和物理与数学教学中心，实行全英文授课，小班制教学。学院教职员工逾200人，其中超过80人的师资团队由资深外籍教师组成，分别来自全球20个不同的国家和地区。目前，中英国际学院在校生人数约2000名，并拥有来自于42个国家和地区的150多名国际学生。在执行校长高岩教授（Professor Ian Gow OBE）的带领下，学校将继续为学生提供一流的国际化学位教育。'),('CE00L','材料科学与工程学院','材料科学与工程学院从事材料领域研究和本科、研究生等各级人才的培养，学院现有“材料科学与工程”和“材料成型及控制工程”本科专业，是国家“卓越工程师培养计划”试点专业、上海市“卓越工程教育”试点专业、上海市“本科专业综合改革”试点专业和上海市“本科教育高地”重点建设专业。已经形成复合材料、新能源材料、电功能材料、纳米材料与性能、石墨烯材料、材料计算与模拟、先进材料成型技术与装备等极具特色的学科专业方向。学生通过本科阶段的学习，牢固掌握材料科学与工程学科的理论基础和系统的专门知识，掌握必要的实验技能、计算方法和技术手段，具备解决工程问题和从事新产品、新工艺和新设备开发的能力。学院本科毕业生连续四年就业率、签约率和高质量就业率均位列全校第一。学院还设有“新能源材料”、“机电功能材料”博士点，有“材料工程”、“新能源材料”、“机电功能材料”硕士点。正在探索本—硕—博一体化培养机制。');
/*!40000 ALTER TABLE `college_information` ENABLE KEYS */;
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
  `period` char(2) DEFAULT NULL COMMENT '例如：该学期内每周三15:00-17:00;格式：周三（15:00-17:00）\nweek = { "A", "B", "C", "D", "E", "F", "G" };  { "星期一", "星期二", "星期三", "星期四", "星期五", "星期六", "星期日" };\ntime =  { "A", "B", "C", "D", "E", "F" };          { "一二节", "三四节", "三四五节", "六七节", "八九节", "十十一十二节" };\n\n{ "一二节":"上午8:00-9:50", \n"三四节":"上午9:55-11:30", \n"三四五节":"上午9:55-12:25",\n "六七节":"下午13:15-14:55", \n"八九节":"下午15:00-16:45", \n"十十一十二节" :"晚上18:00-20:25"};',
  `examID` char(10) DEFAULT NULL COMMENT '外键于考试信息表',
  `chosen` int(11) DEFAULT '0' COMMENT '历史选课人数',
  `collected` int(11) DEFAULT '0' COMMENT '被收藏次数',
  `courseInfo` varchar(256) DEFAULT NULL COMMENT '注意：不超过128字符的介绍',
  `detailInfo` varchar(2048) DEFAULT NULL COMMENT '注意：超过128个字符的介绍，但不超过2500个字符，有初值（NULL）',
  `subTag` varchar(50) DEFAULT NULL COMMENT '二级学科名称不超过25个字符（字节）',
  `capacity` int(11) DEFAULT '0' COMMENT '课程容量',
  `ava` char(1) DEFAULT 'Y',
  `faculty` varchar(5) DEFAULT NULL,
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
INSERT INTO `course_information` VALUES ('CAXX000001','马克思主义概论','UT00000001','2018-02-02 10:30:00','2018-02-16 10:30:00','2018-08-16 10:30:00','ROOMA10100 ','DE','EAXX000001',NULL,NULL,NULL,'This is Max','',90,'N','A0001'),('CAXX000002','毛泽东思想与社会主义概论','UT00000002','2018-02-02 10:30:00','2018-02-16 10:30:00','2018-08-16 10:30:00','ROOMA10205 ','EE','EAXX000004',1,NULL,NULL,'This is MaoZedong',NULL,70,'Y','B0002'),('CAXX000003','近现代史纲要','UT00000001','2018-03-31 10:30:30','2018-04-01 10:30:30','2018-08-16 10:30:00','ROOMA10305 ','EB','EAXX000003',2,0,NULL,NULL,NULL,60,'Y','C0003'),('CBXX000001','经济学原理','UT00000003','2018-02-02 10:30:00','2018-02-16 10:30:00','2018-08-16 10:30:00','ROOMA10205','EC','EBXX000001',1,NULL,'',NULL,'',70,'Y','D0004'),('CBXX000002','工商管理基础','UT00000003','2018-02-02 10:30:00','2018-02-16 10:30:00','2018-08-16 10:30:00','ROOMA10306 ','EF','EBXX000002',1,NULL,'',NULL,'',50,'Y','E0005'),('CBXX000003','会计学基础','UT00000001','2018-03-12 10:30:00','2018-03-16 10:30:00','2018-08-16 10:30:00','ROOMA10310 ','FA','EBXX000003',1,NULL,NULL,NULL,NULL,60,'Y','F0006'),('CCXX000001','诉讼法概论','UT00000003','2018-02-02 10:30:00','2018-02-16 10:30:00','2018-08-16 10:30:00','ROOMA20110 ','ED','ECXX000001',1,NULL,'',NULL,'',70,'Y','G0007'),('CCXX000002','民法概论','UT00000003','2018-02-02 10:30:00','2018-02-16 10:30:00','2018-08-16 10:30:00','ROOMA20306 ','DE','ECXX000002',2,NULL,'',NULL,'',60,'Y','H0008'),('CDXX000001','城市雕塑','UT00000002','2018-05-29 10:30:00','2018/05/03 17:38','2018/08/16 17:38','ROOMA10305','GE','EDXX000001',0,0,'这是一个测试课程信息的句子',NULL,'',60,'N','C0003'),('CEXX000001','唐朝历史','UT00000003','2018-02-02 10:30:00','2018-02-16 10:30:00','2018-08-16 10:30:00','ROOMA30100 ','GF','EEXX000001',1,NULL,'',NULL,'',60,'Y','I0009'),('CIXX000001','农学概论','UT00000003','2018-02-02 10:30:00','2018-02-16 10:30:00','2018-08-16 10:30:00','ROOMA30210 ','DF','EIXX000001',1,NULL,'',NULL,'',70,'Y','J0010'),('CIXX000002','植物学','UT00000014','2018-02-02 10:30:00','2018-02-16 10:30:00','2018-08-16 10:30:00','ROOMA50704 ','AB','EIXX000002',1,0,NULL,NULL,NULL,50,'Y','K0011'),('CIXX000003','动物学','UT00000015','2018-02-02 10:30:00','2018-02-16 10:30:00','2018-08-16 10:30:00','ROOMA61009 ','EC','EIXX000003',1,0,NULL,NULL,NULL,30,'Y','L0012'),('CIXX000004','微生物学','UT00000016','2018-02-02 10:30:00','2018-02-16 10:30:00','2018-08-16 10:30:00','ROOMA80000 ','FC','EIXX000004',1,0,NULL,NULL,NULL,70,'Y','A0001'),('CIXX000005','稻米种植法','UT00000017','2018-02-02 10:30:00','2018-02-16 10:30:00','2018-08-16 10:30:00','ROOMBH0100 ','BB','EIXX000005',1,0,NULL,NULL,NULL,60,'Y','B0002'),('CIXX000006','谷物与气候的关系','UT00000018','2018-02-02 10:30:00','2018-02-16 10:30:00','2018-08-16 10:30:00','ROOMBH0300 ','EA','EIXX000006',1,0,NULL,NULL,NULL,90,'Y','C0003'),('CIXX000007','绿色蔬菜种植方法','UT00000019','2018-02-02 10:30:00','2018-02-16 10:30:00','2018-08-16 10:30:00','ROOMMH0200 ','DA','EIXX000007',0,0,NULL,NULL,NULL,100,'Y','D0004'),('CIXX000008','哺乳动物学','UT00000020','2018-02-02 10:30:00','2018-02-16 10:30:00','2018-08-16 10:30:00','ROOMS10100 ','CD','EIXX000008',1,0,NULL,NULL,NULL,20,'Y','E0005'),('CIXX000009','脊椎动物学','UT00000021','2018-02-02 10:30:00','2018-02-16 10:30:00','2018-08-16 10:30:00','ROOMS20305 ','DC','EIXX000009',0,0,NULL,NULL,NULL,25,'Y','F0006'),('CIXX000010','被子植物学','UT00000022','2018-02-02 10:30:00','2018-02-16 10:30:00','2018-08-16 10:30:00','ROOMSW0000 ','DF','EIXX000010',0,0,NULL,NULL,NULL,36,'Y','G0007'),('CIXX000011','裸子植物学','UT00000023','2018-02-02 10:30:00','2018-02-16 10:30:00','2018-08-16 10:30:00','ROOMA10100 ','GF','EIXX000011',1,0,NULL,NULL,NULL,40,'Y','H0008'),('CIXX000012','羊群与牧犬的关系','UT00000024','2018-02-02 10:30:00','2018-02-16 10:30:00','2018-08-16 10:30:00','ROOMA10205 ','GA','EIXX000012',1,0,NULL,NULL,NULL,50,'Y','I0009'),('CKXX000001','军训概论','UT00000003','2018-02-02 10:30:00','2018-02-16 10:30:00','2018-08-16 10:30:00','ROOMA10306 ','AA','EKXX000001',NULL,NULL,'',NULL,'',60,'Y','J0010'),('CKXX000002','军训概论基础原理','UT00000004','2018-03-02 10:30:00','2018-05-07 10:00:00','2018-08-16 20:00:00','ROOMA10310 ','EA','EKXX000002',1,NULL,'',NULL,'',100,'Y','K0011'),('CLXX000001','管理的艺术','UT00000003','2018-02-02 10:30:00','2018-02-16 10:30:00','2018-08-16 10:30:00','ROOMA50704 ','DC','ELXX000001',1,NULL,'',NULL,'',70,'Y','L0012'),('CLXX000002','管理的交响','UT00000010','2018-04-17 17:30:00','2018-05-17 17:30:00','2018-09-17 17:30:00','ROOMA61009 ','CC','ELXX000002',0,0,NULL,NULL,NULL,47,'Y','A0001'),('CLXX000003','管理与智慧','UT00000011','2018-04-17 17:30:00','2018-05-17 17:30:00','2018-09-17 17:30:00','ROOMA80000 ','DD','ELXX000003',0,0,NULL,NULL,NULL,44,'Y','B0002'),('CLXX000004','经济与管理','UT00000012','2018-04-17 17:30:00','2018-05-17 17:30:00','2018-09-17 17:30:00','ROOMBH0300 ','EE','ELXX000004',1,0,NULL,NULL,NULL,55,'Y','C0003'),('CLXX000005','军事化管理','UT00000013','2018-04-17 17:30:00','2018-05-17 17:30:00','2018-09-17 17:30:00','ROOMA20306 ','FF','ELXX000005',0,0,NULL,NULL,NULL,50,'Y','D0004'),('CLXX000006','管理学','UT00000014','2018-04-17 17:30:00','2018-05-17 17:30:00','2018-09-17 17:30:00','ROOMA30210 ','BC','ELXX000006',0,0,NULL,NULL,NULL,90,'Y','E0005'),('CLXX000007','宏观经济分析','UT00000015','2018-04-17 17:30:00','2018-05-17 17:30:00','2018-09-17 17:30:00','ROOMA61009 ','ED','ELXX000007',0,0,NULL,NULL,NULL,150,'Y','F0006'),('CLXX000008','微观经济分析','UT00000016','2018-04-17 17:30:00','2018-05-17 17:30:00','2018-09-17 17:30:00','ROOMS20305 ','EA','ELXX000008',3,0,NULL,NULL,NULL,500,'Y','G0007');
/*!40000 ALTER TABLE `course_information` ENABLE KEYS */;
UNLOCK TABLES;
ALTER DATABASE `gpdb` CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
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
ALTER DATABASE `gpdb` CHARACTER SET utf8 COLLATE utf8_general_ci ;

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
INSERT INTO `course_records` VALUES ('UA00000001','CAXX000003','A','2018-05-23 15:31:27','N'),('US00000001','CAXX000002','B','2018-03-29 19:28:38','N'),('US00000001','CAXX000003','B','2018-05-06 12:49:22','N'),('US00000001','CBXX000001','A','2018-03-29 18:33:54','Y'),('US00000001','CBXX000002','B','2018-04-04 18:22:39','N'),('US00000001','CBXX000003','B','2018-04-07 16:38:51','N'),('US00000001','CCXX000001','A','2018-04-07 15:11:29','Y'),('US00000001','CCXX000002','B','2018-04-04 18:22:16','N'),('US00000001','CEXX000001','B','2018-04-07 10:00:00','N'),('US00000001','CIXX000001','A','2018-04-07 10:00:00','Y'),('US00000001','CIXX000002','A','2018-05-16 15:53:18','Y'),('US00000001','CIXX000003','A','2018-05-06 12:49:55','Y'),('US00000001','CIXX000004','B','2018-05-16 15:52:03','Y'),('US00000001','CIXX000005','A','2018-05-16 15:04:58','Y'),('US00000001','CIXX000006','A','2018-05-16 16:04:01','Y'),('US00000001','CIXX000007','A','2018-05-16 16:04:10','Y'),('US00000001','CIXX000008','C','2018-05-16 16:39:59','N'),('US00000001','CIXX000009','A','2018-05-16 17:00:15','Y'),('US00000001','CIXX000011','A','2018-05-16 15:46:24','Y'),('US00000001','CIXX000012','A','2018-05-16 17:47:28','Y'),('US00000001','CKXX000002','B','2018-04-07 10:00:00','N'),('US00000001','CLXX000001','B','2018-03-29 19:28:44','N'),('US00000001','CLXX000004','B','2018-05-28 16:30:06','N'),('US00000002','CCXX000001','C','2018-04-07 21:52:00','N'),('US00000004','CBXX000001','A','2018-05-16 17:49:22','N'),('US00000004','CCXX000002','C','2018-05-16 17:49:01','N'),('US00000004','CIXX000004','A','2018-05-16 17:51:22','N');
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
INSERT INTO `exam_information` VALUES ('EAXX000001','CAXX000001','2018-10-15 15:00:00','2.5','ROOMA10305','开卷',0,'60%','Y'),('EAXX000002','CAXX000002','2018-10-15 15:00:00','1','ROOMA10304','闭卷',0,'60%','Y'),('EAXX000003','CAXX000003','2018/08/17 18:00','1','ROOMA10303','闭卷',0,'60%','Y'),('EBXX000001','CBXX000001','2018-10-15 15:00:00','1','ROOMA10303','闭卷',0,'60%','Y'),('EBXX000002','CBXX000002','2018/05/16 19:00:00','1','ROOMA10302','闭卷',0,'60%','Y'),('EBXX000003','CBXX000003','2018-10-15 15:00:00','1','ROOMA10301','闭卷',0,'60%','Y'),('ECXX000001','CCXX000001','2018-10-15 15:00:00','1','ROOMA10301','闭卷',0,'60%','Y'),('ECXX000002','CCXX000002','2018-10-15 15:00:00','1','ROOMA10305','闭卷',0,'60%','Y'),('EDXX000001','CDXX000001','2018/08/01 18:00','2.5','ROOMS20305','闭卷',0,'60%','N'),('EEXX000001','CEXX000001','2018/08/17 18:00','1','ROOMA50704','开卷',0,'60%','Y'),('EIXX000001','CIXX000001','2018/05/16 19:00','1','ROOMA50704','开卷',0,'60%','Y'),('EIXX000002','CIXX000002',NULL,'1',NULL,'闭卷',0,'60%','Y'),('EIXX000003','CIXX000003',NULL,'1',NULL,'闭卷',0,'60%','Y'),('EIXX000004','CIXX000004',NULL,'1',NULL,'闭卷',0,'60%','Y'),('EIXX000005','CIXX000005',NULL,'1',NULL,'闭卷',0,'60%','Y'),('EIXX000006','CIXX000006',NULL,'1',NULL,'闭卷',0,'60%','Y'),('EIXX000007','CIXX000007',NULL,'1',NULL,'闭卷',0,'60%','Y'),('EIXX000008','CIXX000008',NULL,'1',NULL,'闭卷',0,'60%','Y'),('EIXX000009','CIXX000009',NULL,'1',NULL,'闭卷',0,'60%','Y'),('EIXX000010','CIXX000010',NULL,'1',NULL,'闭卷',0,'60%','Y'),('EIXX000011','CIXX000011',NULL,'1',NULL,'闭卷',0,'60%','Y'),('EIXX000012','CIXX000012',NULL,'1',NULL,'闭卷',0,'60%','Y'),('EKXX000001','CKXX000001','2018/08/17 18:00','3','ROOMA10305','闭卷',0,'60%','Y'),('EKXX000002','CKXX000002','2018/08/17 18:00','1.5','ROOMA10305','开卷',0,'60%','Y'),('ELXX000001','CLXX000001','2018/05/16 19:00','1','ROOMA10305','闭卷',0,'60%','Y'),('ELXX000002','CLXX000002',NULL,'1',NULL,'闭卷',0,'60%','Y'),('ELXX000003','CLXX000003',NULL,'1',NULL,'闭卷',0,'60%','Y'),('ELXX000004','CLXX000004',NULL,'1',NULL,'闭卷',0,'60%','Y'),('ELXX000005','CLXX000005',NULL,'1',NULL,'闭卷',0,'60%','Y'),('ELXX000006','CLXX000006',NULL,'1',NULL,'闭卷',0,'60%','Y'),('ELXX000007','CLXX000007',NULL,'1',NULL,'闭卷',0,'60%','Y'),('ELXX000008','CLXX000008',NULL,'1',NULL,'闭卷',0,'60%','Y');
/*!40000 ALTER TABLE `exam_information` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `faculty_information`
--

DROP TABLE IF EXISTS `faculty_information`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `faculty_information` (
  `uniqueCode` varchar(5) CHARACTER SET latin1 NOT NULL COMMENT '系别编号\n',
  `name` varchar(100) CHARACTER SET gbk NOT NULL,
  `belong` varchar(5) CHARACTER SET latin1 DEFAULT NULL COMMENT '所属学院\n',
  PRIMARY KEY (`uniqueCode`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系别信息表（falcuty_information）													\n';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `faculty_information`
--

LOCK TABLES `faculty_information` WRITE;
/*!40000 ALTER TABLE `faculty_information` DISABLE KEYS */;
INSERT INTO `faculty_information` VALUES ('A0001','能动系','A'),('B0002','光电系','B'),('C0003','管理系','C'),('D0004','机械系','D'),('E0005','外语系','E'),('F0006','建筑系','F'),('G0007','理化系','G'),('H0008','医疗系','H'),('I0009','印刷系','I'),('J0010','汉堡系','J'),('K0011','中英系','K'),('L0012','材料系','L');
/*!40000 ALTER TABLE `faculty_information` ENABLE KEYS */;
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
INSERT INTO `room_information` VALUES ('ROOMA10100','第一教学楼（100）',NULL,'A1',30),('ROOMA10205','第一教学楼（205）',NULL,'A1',30),('ROOMA10305','第一教学楼（305）','一教305','A1',60),('ROOMA10306','第一教学楼（306）','一教306','A1',60),('ROOMA10310','第一教学楼（310）',NULL,'A1',30),('ROOMA20110','第二教学楼（110）','二教110','A2',80),('ROOMA20306','第二教学楼（306）','二教306','A2',60),('ROOMA30100','第三教学楼（100）',NULL,'A3',30),('ROOMA30210','第三教学楼（210）','三教210','A3',80),('ROOMA50704','综合教学楼（704）','','A5',60),('ROOMA61009','光电信息与计算机工程学院大楼（1009）','光电大楼1009','A6',100),('ROOMA80000','健身房',NULL,'A8',60),('ROOMBH0100','大礼堂一楼',NULL,'BH',300),('ROOMBH0300','大礼堂三楼',NULL,'BH',150),('ROOMMH0200','音乐堂二楼',NULL,'MH',20),('ROOMS10100','申一教学楼（100）',NULL,'S1',60),('ROOMS20305','申二教学楼（305）',NULL,'S2',70),('ROOMSW0000','游泳池',NULL,'SW',30);
/*!40000 ALTER TABLE `room_information` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `gpdb`.`room_information_BEFORE_INSERT` BEFORE INSERT ON `room_information` FOR EACH ROW
BEGIN
set new.roomBuilding=substring(new.roomID,5,2);  
-- 注意：MySQL中的字符串起始索引不是0，已验证。
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

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
  `dayperiod` char(2) DEFAULT NULL COMMENT '该字段为结合字段（由weekday和period结合），表示方法见页面备注事项。',
  `occucourse` char(10) DEFAULT NULL,
  `ava` char(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='教室使用表（roomuse_information）';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roomuse_information`
--

LOCK TABLES `roomuse_information` WRITE;
/*!40000 ALTER TABLE `roomuse_information` DISABLE KEYS */;
INSERT INTO `roomuse_information` VALUES ('ROOMA50704','C','UT00000001','DE','CAXX000001','Y'),('ROOMA10100','C','UT00000001','DE','CAXX000001','Y'),('ROOMA10205','C','UT00000002','EE','CAXX000002','Y'),('ROOMA10305','C','UT00000001','EB','CAXX000003','Y'),('ROOMA10205','C','UT00000003','EC','CBXX000001','Y'),('ROOMA10306','C','UT00000003','EF','CBXX000002','Y'),('ROOMA10310','C','UT00000001','FA','CBXX000003','Y'),('ROOMA20110','C','UT00000003','ED','CCXX000001','Y'),('ROOMA20306','C','UT00000003','DE','CCXX000002','Y'),('ROOMA30100','C','UT00000003','GF','CEXX000001','Y'),('ROOMA30210','C','UT00000003','DF','CIXX000001','Y'),('ROOMA50704','C','UT00000014','AB','CIXX000002','Y'),('ROOMA61009','C','UT00000015','EC','CIXX000003','Y'),('ROOMA80000','C','UT00000016','FC','CIXX000004','Y'),('ROOMBH0100','C','UT00000017','BB','CIXX000005','Y'),('ROOMBH0300','C','UT00000018','EA','CIXX000006','Y'),('ROOMMH0200','C','UT00000019','DA','CIXX000007','Y'),('ROOMS10100','C','UT00000020','CD','CIXX000008','Y'),('ROOMS20305','C','UT00000021','DC','CIXX000009','Y'),('ROOMSW0000','C','UT00000022','DF','CIXX000010','Y'),('ROOMA10100','C','UT00000023','GF','CIXX000011','Y'),('ROOMA10205','C','UT00000024','GA','CIXX000012','Y'),('ROOMA10306','C','UT00000003','AA','CKXX000001','Y'),('ROOMA10310','C','UT00000004','EA','CKXX000002','Y'),('ROOMA50704','C','UT00000003','DC','CLXX000001','Y'),('ROOMA61009','C','UT00000010','CC','CLXX000002','Y'),('ROOMA80000','C','UT00000011','DD','CLXX000003','Y'),('ROOMBH0300','C','UT00000012','EE','CLXX000004','Y'),('ROOMA20306','C','UT00000013','FF','CLXX000005','Y'),('ROOMA30210','C','UT00000014','BC','CLXX000006','Y'),('ROOMA61009','C','UT00000015','ED','CLXX000007','Y'),('ROOMS20305','C','UT00000016','EA','CLXX000008','Y');
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
  `faculty` varchar(5) DEFAULT NULL,
  KEY `uniqueClientID_idx` (`uniqueClientID`),
  CONSTRAINT `uniqueClientIDs` FOREIGN KEY (`uniqueClientID`) REFERENCES `login_examine` (`uniqueClientID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='学生信息表（student_information）';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_information`
--

LOCK TABLES `student_information` WRITE;
/*!40000 ALTER TABLE `student_information` DISABLE KEYS */;
INSERT INTO `student_information` VALUES ('US00000001','王启帆','M',22,'wangqifan1996@126.com','EricWong1996','1318272348','15316831783','上海理工大学','光电信息与计算机工程学院','计算机科学与技术','B','SE','1318272348',NULL,'A0001'),('US00000002','李旻琦','F',22,'liminqi@anothermail.com','','','','上海理工大学','','','B','SE','','','B0002'),('US00000003','王永健','M',23,'wangyongjian@anothermail.com','','','','上海理工大学','','','B','SE','','','C0003'),('US00000004','冯凯鑫','M',32,'happy@anothermail.com','','','','上海理工大学','','','B','SE','','','D0004');
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
  `faculty` varchar(5) DEFAULT NULL COMMENT '系别',
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
INSERT INTO `teacher_information` VALUES ('UT00000001','庙军培','M',23,'miaojunpei1995@qq.com','miaojunpei1995','1049175213','15316831929','北京邮电大学','计算机学院','通信工程','','1412480409',NULL,'A0001'),('UT00000002','李凯馨','F',27,'happy@anothermail.com','happy','1049234563','15314567689','Nottingham University','计算机学院','通信工程','','1412580409','','B0002'),('UT00000003','巴则则','M',29,'busybuzzy@anothermail.com','busybuzzy','4391334563','15856567689','Harvard University','计算机学院','通信工程','','1412559409','','C0003'),('UT00000004','江小辉','M',40,'jiangxianghui@anothermail.com','jiangxianghui','4391343563','15786567689','北京大学','计算机学院','通信工程','','1417559409','','D0004'),('UT00000005','余志先','M',29,'yuzhixian@usst.edu.cn','yuzhixian','4391334563','15786567689','北京师范大学','计算机学院','通信工程',NULL,NULL,NULL,'E0005'),('UT00000006','于金红','F',29,'yujinhong@usst.edu.cn','yujinhong','4391334563','15786567689','北京师范大学','计算机学院','通信工程',NULL,NULL,NULL,'F0006'),('UT00000007','徐丽珠','F',29,'xulizhu@usst.edu.cn','xulizhu','4391334563','15786567689','北京师范大学','计算机学院','通信工程',NULL,NULL,NULL,'G0007'),('UT00000008','纪海慧','F',29,'jihaihui@usst.edu.cn','jihaihui','4391334563','15786567689','北京师范大学','计算机学院','通信工程',NULL,NULL,NULL,'H0008'),('UT00000009','徐水华','M',29,'xushuihua@usst.edu.cn','xushuihua','4391334563','15786567689','北京师范大学','计算机学院','通信工程',NULL,NULL,NULL,'I0009'),('UT00000010','宋青红','F',29,'songqinghong@usst.edu.cn','songqinghong','4391334563','15786567689','北京师范大学','计算机学院','通信工程',NULL,NULL,NULL,'J0010'),('UT00000011','蔡育凡','M',29,'caiyufan@usst.edu.cn','caiyufan','4391334563','15786567689','北京师范大学','计算机学院','通信工程',NULL,NULL,NULL,'K0011'),('UT00000012','徐伯清','M',29,'xuboqing@usst.edu.cn','xuboqing','4391334563','15786567689','北京师范大学','计算机学院','通信工程',NULL,NULL,NULL,'L0012'),('UT00000013','杨晓磊','M',29,'yanxiaolei@usst.edu.cn','yanxiaolei','4391334563','15786567689','北京师范大学乌鲁木齐分校','计算机学院','通信工程',NULL,NULL,NULL,'A0001'),('UT00000014','候文','F',29,'houwen@usst.edu.cn','houwen','4391334563','15786567689','北京师范大学','计算机学院','通信工程',NULL,NULL,NULL,'B0002'),('UT00000015','皇甫泉声','M',29,'huangfuquansheng@usst.edu.cn','huangfuquansheng','4391334563','15786567689','北京师范大学','计算机学院','通信工程',NULL,NULL,NULL,'C0003'),('UT00000016','张丽芳','F',29,'zhanglifang@usst.edu.cn','zhanglifang','4391334563','15786567689','北京师范大学','计算机学院','通信工程',NULL,NULL,NULL,'D0004'),('UT00000017','秦梅','F',29,'qinmei@usst.edu.cn','qinmei','4391334563','15786567689','北京师范大学','计算机学院','通信工程',NULL,NULL,NULL,'E0005'),('UT00000018','郭茂星','M',29,'guomaoxing@usst.edu.cn','guomaoxing','4391334563','15786567689','北京师范大学','计算机学院','通信工程',NULL,NULL,NULL,'F0006'),('UT00000019','臧劲松','F',29,'zangjinsong@usst.edu.cn','zangjinsong','4391334563','15786567689','北京航空航天大学','计算机学院','通信工程',NULL,NULL,NULL,'G0007'),('UT00000020','孙浩','M',29,'sunhao@usst.edu.cn','sunhao','4391334563','15786567689','北京师范大学','计算机学院','通信工程',NULL,NULL,NULL,'H0008'),('UT00000021','杨董磊','M',29,'yangdonglei@usst.edu.cn','yangdonglei','4391334563','15786567689','北京师范大学','计算机学院','通信工程',NULL,NULL,NULL,'I0009'),('UT00000022','梁浩','M',29,'lianghao@usst.edu.cn','lianghao','4391334563','15786567689','北京师范大学','计算机学院','通信工程',NULL,NULL,NULL,'J0010'),('UT00000023','箔君','F',29,'bojun@usst.edu.cn','bojun','4391334563','15786567689','北京师范大学','计算机学院','通信工程',NULL,NULL,NULL,'K0011'),('UT00000024','欧广宇','F',29,'ouguangyu@usst.edu.cn','ouguangyu','4391334563','15786567689','北京师范大学','计算机学院','通信工程',NULL,NULL,NULL,'L0012'),('UT00000025','胡德敏','M',29,'hudemin@usst.edu.cn','hudemin','4391334563','15786567689','北京师范大学','计算机学院','通信工程',NULL,NULL,NULL,'A0001'),('UT00000026','周群','M',29,'zhouqun@usst.edu.cn','zhouqun','4391334563','15786567689','北京师范大学','计算机学院','通信工程',NULL,NULL,NULL,'B0002'),('UT00000027','徐建光','M',29,'xujianguang@usst.edu.cn','xujianguang','4391334563','15786567689','北京师范大学','计算机学院','通信工程',NULL,NULL,NULL,'C0003'),('UT00000028','王聪聪','F',29,'wangcongcong@usst.edu.cn','wangcongcong','4391334563','15786567689','北京师范大学','计算机学院','通信工程',NULL,NULL,NULL,'D0004'),('UT00000029','艾克风','F',29,'aikefeng@usst.edu.cn','aikefeng','4391334563','15786567689','北京师范大学','计算机学院','通信工程',NULL,NULL,NULL,'E0005'),('UT00000030','杨赞','F',29,'yangzan@usst.edu.cn','yangzan','4391334563','15786567689','北京师范大学','计算机学院','通信工程',NULL,NULL,NULL,'F0006'),('UT00000031','李磊','M',29,'lilei@usst.edu.cn','lilei','4391334563','15786567689','北京师范大学','计算机学院','通信工程',NULL,NULL,NULL,'G0007'),('UT00000032','曹春萍','F',29,'caochunping@usst.edu.cn','caochunping','4391334563','15786567689','北京师范大学','计算机学院','通信工程',NULL,NULL,NULL,'H0008'),('UT00000033','邵清','F',29,'shaoqing@usst.edu.cn','shaoqing','4391334563','15786567689','北京师范大学','计算机学院','通信工程',NULL,NULL,NULL,'I0009'),('UT00000034','陈大文','M',29,'chendawen@usst.edu.cn','chendawen','4391334563','15786567689','北京师范大学','计算机学院','通信工程',NULL,NULL,NULL,'J0010'),('UT00000035','钱剑秋','M',29,'qianjianqiu@usst.edu.cn','qianjianqiu','4391334563','15786567689','北京师范大学','计算机学院','通信工程',NULL,NULL,NULL,'K0011'),('UT00000036','杨桂松','M',29,'yangguisong@usst.edu.cn','yangguisong','4391334563','15786567689','北京师范大学','计算机学院','通信工程',NULL,NULL,NULL,'L0012'),('UT00000037','李岩松','M',29,'liyansong@usst.edu.cn','liyansong','4391334563','15786567689','北京师范大学','计算机学院','通信工程',NULL,NULL,NULL,'A0001'),('UT00000038','朱桢','F',29,'zhuzhen@usst.edu.cn','zhuzhen','4391334563','15786567689','北京师范大学','计算机学院','通信工程',NULL,NULL,NULL,'B0002'),('UT00000039','茂伟秦','M',29,'maoweiqin@usst.edu.cn','maoweiqin','4391334563','15786567689','北京师范大学','计算机学院','通信工程',NULL,NULL,NULL,'C0003'),('UT00000040','张艳','F',29,'zhangyan@usst.edu.cn','zhangyan','4391334563','15786567689','北京师范大学','计算机学院','通信工程',NULL,NULL,NULL,'D0004'),('UT00000041','张兴','F',29,'zhangxing@usst.edu.cn','zhangxing','4391334563','15786567689','北京师范大学','计算机学院','通信工程',NULL,NULL,NULL,'E0005'),('UT00000042','???','M',29,'pengdunlu@usst.edu.cn','pengdunlu','4391334563','15786567689','??????','计算机学院','????',NULL,NULL,NULL,'F0006'),('UT00000043','李瑞','M',29,'lirui@usst.edu.cn','lirui','4391334563','15786567689','北京师范大学','计算机学院','通信工程',NULL,NULL,NULL,'G0007'),('UT00000044','赵海燕','F',29,'zhaohaiyan@usst.edu.cn','zhaohaiyan','4391334563','15786567689','北京师范大学','计算机学院','通信工程',NULL,NULL,NULL,'H0008'),('UT00000045','苏凡军','M',29,'sufanjun@usst.edu.cn','sufanjun','4391334563','15786567689','北京师范大学','计算机学院','通信工程',NULL,NULL,NULL,'I0009'),('UT00000046','赵逢禹','M',29,'zhaofengyu@usst.edu.cn','zhaofengyu','4391334563','15786567689','北京师范大学','计算机学院','通信工程',NULL,NULL,NULL,'J0010'),('UT00000047','刘亚','F',29,'liuya@usst.edu.cn','liuya','4391334563','15786567689','北京师范大学','计算机学院','通信工程',NULL,NULL,NULL,'K0011'),('UT00000048','缪建伟','F',29,'miaojianwei@usst.edu.cn','miaojianwei','4391334563','15786567689','北京师范大学','计算机学院','通信工程',NULL,NULL,NULL,'L0012'),('UT00000049','邹华','M',29,'zouhua@usst.edu.cn','zouhua','4391334563','15786567689','北京师范大学','计算机学院','通信工程',NULL,NULL,NULL,'A0001');
/*!40000 ALTER TABLE `teacher_information` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `v_uidname`
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

-- Dump completed on 2018-06-02 16:54:35
