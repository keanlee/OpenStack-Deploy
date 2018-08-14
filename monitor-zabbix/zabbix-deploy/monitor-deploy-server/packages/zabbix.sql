-- MySQL dump 10.16  Distrib 10.1.20-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: localhost
-- ------------------------------------------------------
-- Server version	10.1.20-MariaDB

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
-- Table structure for table `acknowledges`
--

DROP TABLE IF EXISTS `acknowledges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acknowledges` (
  `acknowledgeid` bigint(20) unsigned NOT NULL,
  `userid` bigint(20) unsigned NOT NULL,
  `eventid` bigint(20) unsigned NOT NULL,
  `clock` int(11) NOT NULL DEFAULT '0',
  `message` varchar(255) NOT NULL DEFAULT '',
  `action` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`acknowledgeid`),
  KEY `acknowledges_1` (`userid`),
  KEY `acknowledges_2` (`eventid`),
  KEY `acknowledges_3` (`clock`),
  CONSTRAINT `c_acknowledges_1` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`) ON DELETE CASCADE,
  CONSTRAINT `c_acknowledges_2` FOREIGN KEY (`eventid`) REFERENCES `events` (`eventid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acknowledges`
--

LOCK TABLES `acknowledges` WRITE;
/*!40000 ALTER TABLE `acknowledges` DISABLE KEYS */;
/*!40000 ALTER TABLE `acknowledges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `actions`
--

DROP TABLE IF EXISTS `actions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `actions` (
  `actionid` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `eventsource` int(11) NOT NULL DEFAULT '0',
  `evaltype` int(11) NOT NULL DEFAULT '0',
  `status` int(11) NOT NULL DEFAULT '0',
  `esc_period` int(11) NOT NULL DEFAULT '0',
  `def_shortdata` varchar(255) NOT NULL DEFAULT '',
  `def_longdata` text NOT NULL,
  `r_shortdata` varchar(255) NOT NULL DEFAULT '',
  `r_longdata` text NOT NULL,
  `formula` varchar(255) NOT NULL DEFAULT '',
  `maintenance_mode` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`actionid`),
  UNIQUE KEY `actions_2` (`name`),
  KEY `actions_1` (`eventsource`,`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `actions`
--

LOCK TABLES `actions` WRITE;
/*!40000 ALTER TABLE `actions` DISABLE KEYS */;
INSERT INTO `actions` VALUES (2,'Auto discovery. Linux servers.',1,0,1,0,'','','','','',1),(3,'Report problems to Zabbix administrators',0,0,1,3600,'{TRIGGER.STATUS}: {TRIGGER.NAME}','Trigger: {TRIGGER.NAME}\r\nTrigger status: {TRIGGER.STATUS}\r\nTrigger severity: {TRIGGER.SEVERITY}\r\nTrigger URL: {TRIGGER.URL}\r\n\r\nItem values:\r\n\r\n1. {ITEM.NAME1} ({HOST.NAME1}:{ITEM.KEY1}): {ITEM.VALUE1}\r\n2. {ITEM.NAME2} ({HOST.NAME2}:{ITEM.KEY2}): {ITEM.VALUE2}\r\n3. {ITEM.NAME3} ({HOST.NAME3}:{ITEM.KEY3}): {ITEM.VALUE3}\r\n\r\nOriginal event ID: {EVENT.ID}','{TRIGGER.STATUS}: {TRIGGER.NAME}','Trigger: {TRIGGER.NAME}\r\nTrigger status: {TRIGGER.STATUS}\r\nTrigger severity: {TRIGGER.SEVERITY}\r\nTrigger URL: {TRIGGER.URL}\r\n\r\nItem values:\r\n\r\n1. {ITEM.NAME1} ({HOST.NAME1}:{ITEM.KEY1}): {ITEM.VALUE1}\r\n2. {ITEM.NAME2} ({HOST.NAME2}:{ITEM.KEY2}): {ITEM.VALUE2}\r\n3. {ITEM.NAME3} ({HOST.NAME3}:{ITEM.KEY3}): {ITEM.VALUE3}\r\n\r\nOriginal event ID: {EVENT.ID}','',1),(4,'Report not supported items',3,0,1,3600,'{ITEM.STATE}: {HOST.NAME}:{ITEM.NAME}','Host: {HOST.NAME}\r\nItem: {ITEM.NAME}\r\nKey: {ITEM.KEY}\r\nState: {ITEM.STATE}','{ITEM.STATE}: {HOST.NAME}:{ITEM.NAME}','Host: {HOST.NAME}\r\nItem: {ITEM.NAME}\r\nKey: {ITEM.KEY}\r\nState: {ITEM.STATE}','',1),(5,'Report not supported low level discovery rules',3,0,1,3600,'{LLDRULE.STATE}: {HOST.NAME}:{LLDRULE.NAME}','Host: {HOST.NAME}\r\nLow level discovery rule: {LLDRULE.NAME}\r\nKey: {LLDRULE.KEY}\r\nState: {LLDRULE.STATE}','{LLDRULE.STATE}: {HOST.NAME}:{LLDRULE.NAME}','Host: {HOST.NAME}\r\nLow level discovery rule: {LLDRULE.NAME}\r\nKey: {LLDRULE.KEY}\r\nState: {LLDRULE.STATE}','',1),(6,'Report unknown triggers',3,0,1,3600,'{TRIGGER.STATE}: {TRIGGER.NAME}','Trigger name: {TRIGGER.NAME}\r\nExpression: {TRIGGER.EXPRESSION}\r\nState: {TRIGGER.STATE}','{TRIGGER.STATE}: {TRIGGER.NAME}','Trigger name: {TRIGGER.NAME}\r\nExpression: {TRIGGER.EXPRESSION}\r\nState: {TRIGGER.STATE}','',1),(7,'Send E-mail',0,0,0,120,'Cluster故障: {HOST.IP}  {EVENT.TIME} {TRIGGER.STATUS}: {TRIGGER.NAME}','Trigger: {TRIGGER.NAME}\r\nTrigger status: {TRIGGER.STATUS}\r\nTrigger severity: {TRIGGER.SEVERITY}\r\n\r\nItem values:\r\n\r\n{ITEM.NAME1} ({HOST.NAME1}:{ITEM.KEY1}): {ITEM.VALUE1}\r\n\r\nOriginal event ID: {EVENT.ID}','Cluster故障恢复: {HOST.IP}  {TRIGGER.STATUS}: {TRIGGER.NAME}','Trigger: {TRIGGER.NAME}\r\nTrigger status: {TRIGGER.STATUS}\r\nTrigger severity: {TRIGGER.SEVERITY}\r\n\r\nItem values:\r\n\r\n{ITEM.NAME1} ({HOST.NAME1}:{ITEM.KEY1}): {ITEM.VALUE1}\r\n\r\nOriginal event ID: {EVENT.ID}','',1),(8,'Auto registration:controller',2,0,0,0,'Auto registration: {HOST.HOST}','Host name: {HOST.HOST}\r\nHost IP: {HOST.IP}\r\nAgent port: {HOST.PORT}','','','',1),(9,'Auto registration:compute',2,0,0,0,'Auto registration: {HOST.HOST}','Host name: {HOST.HOST}\r\nHost IP: {HOST.IP}\r\nAgent port: {HOST.PORT}','','','',1),(10,'Auto registration:linux',2,0,0,0,'Auto registration: {HOST.HOST}','Host name: {HOST.HOST}\r\nHost IP: {HOST.IP}\r\nAgent port: {HOST.PORT}','','','',1),(11,'send wechat',0,0,0,3600,'Cluster: {HOST.IP}  {EVENT.TIME} {TRIGGER.STATUS}: {TRIGGER.NAME}','Trigger: {TRIGGER.NAME}\r\nTrigger status: {TRIGGER.STATUS}\r\nTrigger severity: {TRIGGER.SEVERITY}\r\n\r\nItem values:\r\n\r\n{ITEM.NAME1} ({HOST.NAME1}:{ITEM.KEY1}): {ITEM.VALUE1}\r\n\r\nOriginal event ID: {EVENT.ID}','Cluster: {HOST.IP}  {TRIGGER.STATUS}: {TRIGGER.NAME}','Trigger: {TRIGGER.NAME}\r\nTrigger status: {TRIGGER.STATUS}\r\nTrigger severity: {TRIGGER.SEVERITY}\r\n\r\nItem values:\r\n\r\n{ITEM.NAME1} ({HOST.NAME1}:{ITEM.KEY1}): {ITEM.VALUE1}\r\n\r\nOriginal event ID: {EVENT.ID}','',1),(12,'send email by 163',0,0,0,3600,'Cluster故障: {HOST.IP}  {EVENT.TIME} {TRIGGER.STATUS}: {TRIGGER.NAME}','Trigger: {TRIGGER.NAME}\r\nTrigger status: {TRIGGER.STATUS}\r\nTrigger severity: {TRIGGER.SEVERITY}\r\n\r\nItem values:\r\n\r\n{ITEM.NAME1} ({HOST.NAME1}:{ITEM.KEY1}): {ITEM.VALUE1}\r\n\r\nOriginal event ID: {EVENT.ID}','Cluster故障恢复: {HOST.IP}  {TRIGGER.STATUS}: {TRIGGER.NAME}','Trigger: {TRIGGER.NAME}\r\nTrigger status: {TRIGGER.STATUS}\r\nTrigger severity: {TRIGGER.SEVERITY}\r\n\r\nItem values:\r\n\r\n{ITEM.NAME1} ({HOST.NAME1}:{ITEM.KEY1}): {ITEM.VALUE1}\r\n\r\nOriginal event ID: {EVENT.ID}','',1),(13,'Auto registration:ceph',2,0,0,0,'Auto registration: {HOST.HOST}','Host name: {HOST.HOST}\r\nHost IP: {HOST.IP}\r\nAgent port: {HOST.PORT}','','','',1);
/*!40000 ALTER TABLE `actions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alerts`
--

DROP TABLE IF EXISTS `alerts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `alerts` (
  `alertid` bigint(20) unsigned NOT NULL,
  `actionid` bigint(20) unsigned NOT NULL,
  `eventid` bigint(20) unsigned NOT NULL,
  `userid` bigint(20) unsigned DEFAULT NULL,
  `clock` int(11) NOT NULL DEFAULT '0',
  `mediatypeid` bigint(20) unsigned DEFAULT NULL,
  `sendto` varchar(100) NOT NULL DEFAULT '',
  `subject` varchar(255) NOT NULL DEFAULT '',
  `message` text NOT NULL,
  `status` int(11) NOT NULL DEFAULT '0',
  `retries` int(11) NOT NULL DEFAULT '0',
  `error` varchar(128) NOT NULL DEFAULT '',
  `esc_step` int(11) NOT NULL DEFAULT '0',
  `alerttype` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`alertid`),
  KEY `alerts_1` (`actionid`),
  KEY `alerts_2` (`clock`),
  KEY `alerts_3` (`eventid`),
  KEY `alerts_4` (`status`,`retries`),
  KEY `alerts_5` (`mediatypeid`),
  KEY `alerts_6` (`userid`),
  CONSTRAINT `c_alerts_1` FOREIGN KEY (`actionid`) REFERENCES `actions` (`actionid`) ON DELETE CASCADE,
  CONSTRAINT `c_alerts_2` FOREIGN KEY (`eventid`) REFERENCES `events` (`eventid`) ON DELETE CASCADE,
  CONSTRAINT `c_alerts_3` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`) ON DELETE CASCADE,
  CONSTRAINT `c_alerts_4` FOREIGN KEY (`mediatypeid`) REFERENCES `media_type` (`mediatypeid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alerts`
--

LOCK TABLES `alerts` WRITE;
/*!40000 ALTER TABLE `alerts` DISABLE KEYS */;
/*!40000 ALTER TABLE `alerts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `application_discovery`
--

DROP TABLE IF EXISTS `application_discovery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `application_discovery` (
  `application_discoveryid` bigint(20) unsigned NOT NULL,
  `applicationid` bigint(20) unsigned NOT NULL,
  `application_prototypeid` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `lastcheck` int(11) NOT NULL DEFAULT '0',
  `ts_delete` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`application_discoveryid`),
  KEY `application_discovery_1` (`applicationid`),
  KEY `application_discovery_2` (`application_prototypeid`),
  CONSTRAINT `c_application_discovery_1` FOREIGN KEY (`applicationid`) REFERENCES `applications` (`applicationid`) ON DELETE CASCADE,
  CONSTRAINT `c_application_discovery_2` FOREIGN KEY (`application_prototypeid`) REFERENCES `application_prototype` (`application_prototypeid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `application_discovery`
--

LOCK TABLES `application_discovery` WRITE;
/*!40000 ALTER TABLE `application_discovery` DISABLE KEYS */;
/*!40000 ALTER TABLE `application_discovery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `application_prototype`
--

DROP TABLE IF EXISTS `application_prototype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `application_prototype` (
  `application_prototypeid` bigint(20) unsigned NOT NULL,
  `itemid` bigint(20) unsigned NOT NULL,
  `templateid` bigint(20) unsigned DEFAULT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`application_prototypeid`),
  KEY `application_prototype_1` (`itemid`),
  KEY `application_prototype_2` (`templateid`),
  CONSTRAINT `c_application_prototype_1` FOREIGN KEY (`itemid`) REFERENCES `items` (`itemid`) ON DELETE CASCADE,
  CONSTRAINT `c_application_prototype_2` FOREIGN KEY (`templateid`) REFERENCES `application_prototype` (`application_prototypeid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `application_prototype`
--

LOCK TABLES `application_prototype` WRITE;
/*!40000 ALTER TABLE `application_prototype` DISABLE KEYS */;
/*!40000 ALTER TABLE `application_prototype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `application_template`
--

DROP TABLE IF EXISTS `application_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `application_template` (
  `application_templateid` bigint(20) unsigned NOT NULL,
  `applicationid` bigint(20) unsigned NOT NULL,
  `templateid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`application_templateid`),
  UNIQUE KEY `application_template_1` (`applicationid`,`templateid`),
  KEY `application_template_2` (`templateid`),
  CONSTRAINT `c_application_template_1` FOREIGN KEY (`applicationid`) REFERENCES `applications` (`applicationid`) ON DELETE CASCADE,
  CONSTRAINT `c_application_template_2` FOREIGN KEY (`templateid`) REFERENCES `applications` (`applicationid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `application_template`
--

LOCK TABLES `application_template` WRITE;
/*!40000 ALTER TABLE `application_template` DISABLE KEYS */;
INSERT INTO `application_template` VALUES (13,566,546),(14,567,547),(15,568,545),(16,569,546),(17,570,547),(18,571,548),(19,572,545),(20,573,546),(21,574,547),(22,575,548);
/*!40000 ALTER TABLE `application_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `applications`
--

DROP TABLE IF EXISTS `applications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `applications` (
  `applicationid` bigint(20) unsigned NOT NULL,
  `hostid` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `flags` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`applicationid`),
  UNIQUE KEY `applications_2` (`hostid`,`name`),
  CONSTRAINT `c_applications_1` FOREIGN KEY (`hostid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `applications`
--

LOCK TABLES `applications` WRITE;
/*!40000 ALTER TABLE `applications` DISABLE KEYS */;
INSERT INTO `applications` VALUES (345,10084,'Zabbix server',0),(346,10084,'CPU',0),(347,10084,'Filesystems',0),(348,10084,'General',0),(349,10084,'Memory',0),(350,10084,'Network interfaces',0),(351,10084,'OS',0),(352,10084,'Performance',0),(353,10084,'Processes',0),(354,10084,'Security',0),(355,10084,'Zabbix agent',0),(497,10154,'ceph',0),(498,10155,'Openstack',0),(499,10156,'Openstack',0),(500,10157,'Openstack',0),(501,10158,'Openstack',0),(502,10159,'Openstack',0),(503,10160,'Openstack',0),(504,10161,'Openstack',0),(505,10162,'Openstack',0),(506,10163,'Openstack',0),(507,10164,'Openstack',0),(508,10165,'CephProNum',0),(509,10166,'Ceph_State',0),(510,10167,'IO_states',0),(511,10168,'MySQL',0),(512,10169,'Openstack',0),(513,10170,'Openstack',0),(514,10171,'SSH service',0),(515,10172,'Zabbix agent',0),(516,10173,'Zabbix proxy',0),(517,10174,'Zabbix server',0),(518,10175,'ICMP',0),(519,10176,'Fans',0),(520,10176,'Temperature',0),(521,10176,'Voltage',0),(522,10177,'Fans',0),(523,10177,'Temperature',0),(524,10177,'Voltage',0),(525,10178,'CPU',0),(526,10178,'Filesystems',0),(527,10178,'General',0),(528,10178,'Memory',0),(529,10178,'Network interfaces',0),(530,10178,'OS',0),(531,10178,'Performance',0),(532,10178,'Processes',0),(533,10178,'scripts',0),(534,10178,'Security',0),(535,10178,'Zabbix agent',0),(536,10179,'CPU',0),(537,10179,'Filesystems',0),(538,10179,'General',0),(539,10179,'Memory',0),(540,10179,'Network interfaces',0),(541,10179,'OS',0),(542,10179,'Performance',0),(543,10179,'Processes',0),(544,10179,'Zabbix agent',0),(545,10180,'Disk partitions',0),(546,10181,'General',0),(547,10182,'Interfaces',0),(548,10183,'Processors',0),(549,10184,'Clusters',0),(550,10184,'General',0),(551,10184,'Log',0),(552,10185,'CPU',0),(553,10185,'Disks',0),(554,10185,'Filesystems',0),(555,10185,'General',0),(556,10185,'Interfaces',0),(557,10185,'Memory',0),(558,10185,'Network',0),(559,10185,'Storage',0),(560,10186,'CPU',0),(561,10186,'Datastore',0),(562,10186,'General',0),(563,10186,'Hardware',0),(564,10186,'Memory',0),(565,10186,'Network',0),(566,10187,'General',0),(567,10187,'Interfaces',0),(568,10188,'Disk partitions',0),(569,10188,'General',0),(570,10188,'Interfaces',0),(571,10188,'Processors',0),(572,10189,'Disk partitions',0),(573,10189,'General',0),(574,10189,'Interfaces',0),(575,10189,'Processors',0);
/*!40000 ALTER TABLE `applications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auditlog`
--

DROP TABLE IF EXISTS `auditlog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auditlog` (
  `auditid` bigint(20) unsigned NOT NULL,
  `userid` bigint(20) unsigned NOT NULL,
  `clock` int(11) NOT NULL DEFAULT '0',
  `action` int(11) NOT NULL DEFAULT '0',
  `resourcetype` int(11) NOT NULL DEFAULT '0',
  `details` varchar(128) NOT NULL DEFAULT '0',
  `ip` varchar(39) NOT NULL DEFAULT '',
  `resourceid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `resourcename` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`auditid`),
  KEY `auditlog_1` (`userid`,`clock`),
  KEY `auditlog_2` (`clock`),
  CONSTRAINT `c_auditlog_1` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auditlog`
--

LOCK TABLES `auditlog` WRITE;
/*!40000 ALTER TABLE `auditlog` DISABLE KEYS */;
INSERT INTO `auditlog` VALUES (430,1,1492236757,3,0,'0','10.96.196.127',1,''),(431,1,1492239584,2,13,'0','10.96.196.127',13691,'Host name of zabbix_agentd was changed on {HOST.NAME}'),(432,1,1492239584,2,13,'0','10.96.196.127',13692,'Version of zabbix_agent(d) was changed on {HOST.NAME}'),(433,1,1492239584,2,13,'0','10.96.196.127',13693,'Zabbix agent on {HOST.NAME} is unreachable for 5 minutes'),(434,1,1492239584,2,31,'0','10.96.196.127',13694,'Free disk space is less than 20% on volume {#FSNAME}:{13297}<20'),(435,1,1492239584,2,31,'0','10.96.196.127',13695,'Free inodes is less than 20% on volume {#FSNAME}:{13298}<20'),(436,1,1492239584,2,13,'0','10.96.196.127',13559,'/etc/passwd has been changed on {HOST.NAME}'),(437,1,1492239584,2,13,'0','10.96.196.127',13560,'CEPH critical error'),(438,1,1492239584,2,13,'0','10.96.196.127',13561,'CEPH warning'),(439,1,1492239584,2,13,'0','10.96.196.127',13562,'Configured max number of opened files is too low on {HOST.NAME}'),(440,1,1492239584,2,13,'0','10.96.196.127',13563,'Configured max number of processes is too low on {HOST.NAME}'),(441,1,1492239584,2,13,'0','10.96.196.127',13564,'Disk I/O is overloaded on {HOST.NAME}'),(442,1,1492239584,2,13,'0','10.96.196.127',13565,'Host information was changed on {HOST.NAME}'),(443,1,1492239584,2,13,'0','10.96.196.127',13566,'Host name of zabbix_agentd was changed on {HOST.NAME}'),(444,1,1492239584,2,13,'0','10.96.196.127',13567,'Hostname was changed on {HOST.NAME}'),(445,1,1492239584,2,13,'0','10.96.196.127',13568,'IMAP service is down on {HOST.NAME}'),(446,1,1492239584,2,13,'0','10.96.196.127',13569,'Lack of available memory on server {HOST.NAME}'),(447,1,1492239584,2,13,'0','10.96.196.127',13570,'Lack of free swap space on {HOST.NAME}'),(448,1,1492239584,2,13,'0','10.96.196.127',13571,'LDAP service is down on {HOST.NAME}'),(449,1,1492239584,2,13,'0','10.96.196.127',13572,'Less than 5% free in the value cache'),(450,1,1492239584,2,13,'0','10.96.196.127',13573,'Less than 25% free in the configuration cache'),(451,1,1492239584,2,13,'0','10.96.196.127',13574,'Less than 25% free in the configuration cache'),(452,1,1492239584,2,13,'0','10.96.196.127',13575,'Less than 25% free in the history cache'),(453,1,1492239584,2,13,'0','10.96.196.127',13576,'Less than 25% free in the history cache'),(454,1,1492239584,2,13,'0','10.96.196.127',13577,'Less than 25% free in the history index cache'),(455,1,1492239584,2,13,'0','10.96.196.127',13578,'Less than 25% free in the text history cache'),(456,1,1492239584,2,13,'0','10.96.196.127',13579,'Less than 25% free in the trends cache'),(457,1,1492239584,2,13,'0','10.96.196.127',13580,'Less than 25% free in the vmware cache'),(458,1,1492239584,2,13,'0','10.96.196.127',13581,'More than 100 items having missing data for more than 10'),(459,1,1492239584,2,13,'0','10.96.196.127',13582,'More than 100 items having missing data for more than 10 minutes'),(460,1,1492239584,2,13,'0','10.96.196.127',13583,'MySQL is down'),(461,1,1492239584,2,13,'0','10.96.196.127',13584,'Neutron server daemon status'),(462,1,1492239584,2,13,'0','10.96.196.127',13585,'openstack ceilometer-agent-notification has down'),(463,1,1492239584,2,13,'0','10.96.196.127',13586,'openstack ceilometer-collector has down'),(464,1,1492239584,2,13,'0','10.96.196.127',13587,'openstack ceilometer-polling has down'),(465,1,1492239584,2,13,'0','10.96.196.127',13588,'openstack ceilometer-polling has down'),(466,1,1492239584,2,13,'0','10.96.196.127',13589,'openstack ceilometer collector daemon status'),(467,1,1492239584,2,13,'0','10.96.196.127',13590,'openstack cinder-api has down'),(468,1,1492239584,2,13,'0','10.96.196.127',13591,'openstack cinder-scheduler has down'),(469,1,1492239584,2,13,'0','10.96.196.127',13592,'openstack cinder-volume has down'),(470,1,1492239584,2,13,'0','10.96.196.127',13593,'Openstack cinder process status'),(471,1,1492239584,2,13,'0','10.96.196.127',13594,'Openstack compute service cinder volume'),(472,1,1492239584,2,13,'0','10.96.196.127',13595,'Openstack compute service libvirtd'),(473,1,1492239584,2,13,'0','10.96.196.127',13596,'Openstack compute service neutron l3 agent'),(474,1,1492239584,2,13,'0','10.96.196.127',13597,'Openstack compute service neutron metadata agent'),(475,1,1492239584,2,13,'0','10.96.196.127',13598,'Openstack compute service neutron openvswitch agent'),(476,1,1492239584,2,13,'0','10.96.196.127',13599,'Openstack compute service nova compute'),(477,1,1492239584,2,13,'0','10.96.196.127',13600,'Openstack controller service cinder api'),(478,1,1492239584,2,13,'0','10.96.196.127',13601,'Openstack controller service cinder scheduler'),(479,1,1492239584,2,13,'0','10.96.196.127',13602,'Openstack controller service glance api'),(480,1,1492239584,2,13,'0','10.96.196.127',13603,'Openstack controller service glance registry'),(481,1,1492239584,2,13,'0','10.96.196.127',13604,'Openstack controller service httpd'),(482,1,1492239584,2,13,'0','10.96.196.127',13605,'Openstack controller service memcached'),(483,1,1492239584,2,13,'0','10.96.196.127',13606,'Openstack controller service neutron dhcp agent'),(484,1,1492239584,2,13,'0','10.96.196.127',13607,'Openstack controller service neutron l3 agent'),(485,1,1492239584,2,13,'0','10.96.196.127',13608,'Openstack controller service neutron metadata agent'),(486,1,1492239584,2,13,'0','10.96.196.127',13609,'Openstack controller service neutron openvswitch agent'),(487,1,1492239584,2,13,'0','10.96.196.127',13610,'Openstack controller service neutron server'),(488,1,1492239584,2,13,'0','10.96.196.127',13611,'Openstack controller service nova api'),(489,1,1492239584,2,13,'0','10.96.196.127',13612,'Openstack controller service nova cert'),(490,1,1492239584,2,13,'0','10.96.196.127',13613,'Openstack controller service nova conductor'),(491,1,1492239584,2,13,'0','10.96.196.127',13614,'Openstack controller service nova consoleauth'),(492,1,1492239584,2,13,'0','10.96.196.127',13615,'Openstack controller service nova novncproxy'),(493,1,1492239584,2,13,'0','10.96.196.127',13616,'Openstack controller service nova scheduler'),(494,1,1492239584,2,13,'0','10.96.196.127',13617,'openstack glance-api has down'),(495,1,1492239584,2,13,'0','10.96.196.127',13618,'openstack glance-registry has down'),(496,1,1492239584,2,13,'0','10.96.196.127',13619,'openstack heat api daemon status'),(497,1,1492239584,2,13,'0','10.96.196.127',13620,'openstack httpd has down'),(498,1,1492239584,2,13,'0','10.96.196.127',13621,'openstack httpd has down'),(499,1,1492239584,2,13,'0','10.96.196.127',13622,'openstack libvirtd has down'),(500,1,1492239584,2,13,'0','10.96.196.127',13623,'openstack memcached has down'),(501,1,1492239584,2,13,'0','10.96.196.127',13624,'openstack mysqld has down'),(502,1,1492239584,2,13,'0','10.96.196.127',13625,'openstack neutron-dhcp-agent has down'),(503,1,1492239584,2,13,'0','10.96.196.127',13626,'openstack neutron-l3-agent has down'),(504,1,1492239584,2,13,'0','10.96.196.127',13627,'openstack neutron-l3-agent has down'),(505,1,1492239584,2,13,'0','10.96.196.127',13628,'openstack neutron-lbaasv2-agent has down'),(506,1,1492239584,2,13,'0','10.96.196.127',13629,'openstack  neutron-metadata-agent has down'),(507,1,1492239584,2,13,'0','10.96.196.127',13630,'openstack neutron-openvswitch-agent has down'),(508,1,1492239584,2,13,'0','10.96.196.127',13631,'openstack neutron-openvswitch-agent has down'),(509,1,1492239584,2,13,'0','10.96.196.127',13632,'openstack neutron-server has down'),(510,1,1492239584,2,13,'0','10.96.196.127',13633,'Openstack neutron process status'),(511,1,1492239584,2,13,'0','10.96.196.127',13634,'openstack nova-api has down'),(512,1,1492239584,2,13,'0','10.96.196.127',13635,'openstack nova-cert has down'),(513,1,1492239584,2,13,'0','10.96.196.127',13636,'openstack nova-compute has down'),(514,1,1492239584,2,13,'0','10.96.196.127',13637,'openstack nova-conductor has down'),(515,1,1492239584,2,13,'0','10.96.196.127',13638,'openstack nova-consoleauth has down'),(516,1,1492239584,2,13,'0','10.96.196.127',13639,'openstack nova-novncproxy has down'),(517,1,1492239584,2,13,'0','10.96.196.127',13640,'openstack nova-scheduler has down'),(518,1,1492239584,2,13,'0','10.96.196.127',13641,'Openstack nova process status'),(519,1,1492239584,2,13,'0','10.96.196.127',13642,'openstack ntpd has down'),(520,1,1492239584,2,13,'0','10.96.196.127',13643,'openstack openvswitch has down'),(521,1,1492239584,2,13,'0','10.96.196.127',13644,'openstack rabbitmq-server has down'),(522,1,1492239584,2,13,'0','10.96.196.127',13645,'Openstack service haproxy has down'),(523,1,1492239584,2,13,'0','10.96.196.127',13646,'Openstack service heat api cfn daemon status'),(524,1,1492239584,2,13,'0','10.96.196.127',13647,'Openstack service heat engine daemon status'),(525,1,1492239584,2,13,'0','10.96.196.127',13648,'Openstack service keepalived has down'),(526,1,1492239584,2,13,'0','10.96.196.127',13649,'openstack xinetd has down'),(527,1,1492239584,2,13,'0','10.96.196.127',13650,'Processor load is too high on {HOST.NAME}'),(528,1,1492239584,2,13,'0','10.96.196.127',13651,'SSH service is down on {HOST.NAME}'),(529,1,1492239584,2,13,'0','10.96.196.127',13652,'Too many processes on {HOST.NAME}'),(530,1,1492239584,2,13,'0','10.96.196.127',13653,'Too many processes running on {HOST.NAME}'),(531,1,1492239584,2,13,'0','10.96.196.127',13654,'Version of zabbix_agent(d) was changed on {HOST.NAME}'),(532,1,1492239584,2,13,'0','10.96.196.127',13655,'Zabbix agent on {HOST.NAME} is unreachable for 5 minutes'),(533,1,1492239584,2,13,'0','10.96.196.127',13656,'Zabbix alerter processes more than 75% busy'),(534,1,1492239584,2,13,'0','10.96.196.127',13657,'Zabbix configuration syncer processes more than 75% busy'),(535,1,1492239584,2,13,'0','10.96.196.127',13658,'Zabbix configuration syncer processes more than 75% busy'),(536,1,1492239584,2,13,'0','10.96.196.127',13659,'Zabbix data sender processes more than 75% busy'),(537,1,1492239584,2,13,'0','10.96.196.127',13660,'Zabbix db watchdog processes more than 75% busy'),(538,1,1492239584,2,13,'0','10.96.196.127',13661,'Zabbix discoverer processes more than 75% busy'),(539,1,1492239584,2,13,'0','10.96.196.127',13662,'Zabbix discoverer processes more than 75% busy'),(540,1,1492239584,2,13,'0','10.96.196.127',13663,'Zabbix escalator processes more than 75% busy'),(541,1,1492239584,2,13,'0','10.96.196.127',13664,'Zabbix heartbeat sender processes more than 75% busy'),(542,1,1492239584,2,13,'0','10.96.196.127',13665,'Zabbix history syncer processes more than 75% busy'),(543,1,1492239584,2,13,'0','10.96.196.127',13666,'Zabbix history syncer processes more than 75% busy'),(544,1,1492239584,2,13,'0','10.96.196.127',13667,'Zabbix housekeeper processes more than 75% busy'),(545,1,1492239584,2,13,'0','10.96.196.127',13668,'Zabbix housekeeper processes more than 75% busy'),(546,1,1492239584,2,13,'0','10.96.196.127',13669,'Zabbix http poller processes more than 75% busy'),(547,1,1492239584,2,13,'0','10.96.196.127',13670,'Zabbix http poller processes more than 75% busy'),(548,1,1492239584,2,13,'0','10.96.196.127',13671,'Zabbix icmp pinger processes more than 75% busy'),(549,1,1492239584,2,13,'0','10.96.196.127',13672,'Zabbix icmp pinger processes more than 75% busy'),(550,1,1492239584,2,13,'0','10.96.196.127',13673,'Zabbix ipmi poller processes more than 75% busy'),(551,1,1492239584,2,13,'0','10.96.196.127',13674,'Zabbix ipmi poller processes more than 75% busy'),(552,1,1492239584,2,13,'0','10.96.196.127',13675,'Zabbix java poller processes more than 75% busy'),(553,1,1492239584,2,13,'0','10.96.196.127',13676,'Zabbix java poller processes more than 75% busy'),(554,1,1492239584,2,13,'0','10.96.196.127',13677,'Zabbix poller processes more than 75% busy'),(555,1,1492239584,2,13,'0','10.96.196.127',13678,'Zabbix poller processes more than 75% busy'),(556,1,1492239584,2,13,'0','10.96.196.127',13679,'Zabbix proxy poller processes more than 75% busy'),(557,1,1492239584,2,13,'0','10.96.196.127',13680,'Zabbix self-monitoring processes more than 75% busy'),(558,1,1492239584,2,13,'0','10.96.196.127',13681,'Zabbix self-monitoring processes more than 75% busy'),(559,1,1492239584,2,13,'0','10.96.196.127',13682,'Zabbix snmp trapper processes more than 75% busy'),(560,1,1492239584,2,13,'0','10.96.196.127',13683,'Zabbix snmp trapper processes more than 75% busy'),(561,1,1492239584,2,13,'0','10.96.196.127',13684,'Zabbix timer processes more than 75% busy'),(562,1,1492239584,2,13,'0','10.96.196.127',13685,'Zabbix trapper processes more than 75% busy'),(563,1,1492239584,2,13,'0','10.96.196.127',13686,'Zabbix trapper processes more than 75% busy'),(564,1,1492239584,2,13,'0','10.96.196.127',13687,'Zabbix unreachable poller processes more than 75% busy'),(565,1,1492239584,2,13,'0','10.96.196.127',13688,'Zabbix unreachable poller processes more than 75% busy'),(566,1,1492239584,2,13,'0','10.96.196.127',13689,'Zabbix vmware collector processes more than 75% busy'),(567,1,1492239584,2,13,'0','10.96.196.127',13690,'{HOST.NAME} has just been restarted'),(568,1,1492239584,2,4,'0','10.96.196.127',10085,'compute node'),(569,1,1492239584,2,4,'0','10.96.196.127',10086,'controller node'),(570,1,1492239584,2,4,'0','10.96.196.127',10087,'dashboard'),(571,1,1492239584,2,4,'0','10.96.196.127',10088,'haproxy'),(572,1,1492239584,2,4,'0','10.96.196.127',10089,'lbaas'),(573,1,1492239584,2,4,'0','10.96.196.127',10090,'memcache'),(574,1,1492239584,2,4,'0','10.96.196.127',10091,'mysql'),(575,1,1492239584,2,4,'0','10.96.196.127',10092,'novnc'),(576,1,1492239584,2,4,'0','10.96.196.127',10093,'ntp'),(577,1,1492239584,2,4,'0','10.96.196.127',10094,'rabbitmq'),(578,1,1492239584,2,4,'0','10.96.196.127',10095,'Template App Ceph ProcessNum'),(579,1,1492239584,2,4,'0','10.96.196.127',10096,'Template App Ceph State'),(580,1,1492239584,2,4,'0','10.96.196.127',10097,'Template App IMAP Service'),(581,1,1492239584,2,4,'0','10.96.196.127',10098,'Template App LDAP Service'),(582,1,1492239584,2,4,'0','10.96.196.127',10099,'Template App MySQL'),(583,1,1492239584,2,4,'0','10.96.196.127',10100,'Template App Openstack Compute ServiceExist'),(584,1,1492239584,2,4,'0','10.96.196.127',10101,'Template App Openstack Controller ServiceExist'),(585,1,1492239584,2,4,'0','10.96.196.127',10102,'Template App SSH Service'),(586,1,1492239584,2,4,'0','10.96.196.127',10103,'Template App Zabbix Agent'),(587,1,1492239584,2,4,'0','10.96.196.127',10104,'Template App Zabbix Proxy'),(588,1,1492239584,2,4,'0','10.96.196.127',10105,'Template App Zabbix Server'),(589,1,1492239584,2,4,'0','10.96.196.127',10106,'Template OS Linux'),(590,1,1492239623,0,13,'0','10.96.196.127',13696,'/etc/passwd has been changed on {HOST.NAME}'),(591,1,1492239623,0,13,'0','10.96.196.127',13697,'Auto Increment Control is disabled'),(592,1,1492239623,0,13,'0','10.96.196.127',13698,'Binary Log Do Filter is enabled'),(593,1,1492239623,0,13,'0','10.96.196.127',13699,'Binary Log Ignore Filter is enabled'),(594,1,1492239623,0,13,'0','10.96.196.127',13700,'Binary Log is disabled'),(595,1,1492239623,0,13,'0','10.96.196.127',13701,'Binlog format MIXED with filtering'),(596,1,1492239623,0,13,'0','10.96.196.127',13702,'Binlog Statement Cache size too small'),(597,1,1492239623,0,13,'0','10.96.196.127',13703,'Binlog Transaction Cache size too small'),(598,1,1492239623,0,13,'0','10.96.196.127',13704,'Causal Reads is enabled'),(599,1,1492239623,0,13,'0','10.96.196.127',13705,'CEPH critical error'),(600,1,1492239623,0,13,'0','10.96.196.127',13706,'CEPH warning'),(601,1,1492239623,0,13,'0','10.96.196.127',13707,'Character Set of Server is utf8'),(602,1,1492239623,0,13,'0','10.96.196.127',13708,'Cluster Configuration has changed'),(603,1,1492239623,0,13,'0','10.96.196.127',13709,'Cluster is slowed down due to slave lag'),(604,1,1492239623,0,13,'0','10.96.196.127',13710,'Cluster node status'),(605,1,1492239623,0,13,'0','10.96.196.127',13711,'Cluster size is different from expected'),(606,1,1492239623,0,13,'0','10.96.196.127',13712,'Configured max number of opened files is too low on {HOST.NAME}'),(607,1,1492239623,0,13,'0','10.96.196.127',13713,'Configured max number of processes is too low on {HOST.NAME}'),(608,1,1492239623,0,13,'0','10.96.196.127',13714,'CPU interrupt time {HOST.NAME}'),(609,1,1492239623,0,13,'0','10.96.196.127',13715,'Default Storage Engine is not InnoDB'),(610,1,1492239623,0,13,'0','10.96.196.127',13716,'Disk I/O is overloaded on {HOST.NAME}'),(611,1,1492239623,0,13,'0','10.96.196.127',13717,'fpmmm Agent is down'),(612,1,1492239623,0,13,'0','10.96.196.127',13718,'fpmmm MaaS Agent is not sending data'),(613,1,1492239623,0,13,'0','10.96.196.127',13719,'fpmmm MaaS Agent is sending data again'),(614,1,1492239623,0,13,'0','10.96.196.127',13720,'fpmmm Version'),(615,1,1492239623,0,13,'0','10.96.196.127',13721,'General Log is enabled'),(616,1,1492239623,0,13,'0','10.96.196.127',13722,'Host information was changed on {HOST.NAME}'),(617,1,1492239623,0,13,'0','10.96.196.127',13723,'Host information was changed on {HOST.NAME}'),(618,1,1492239623,0,13,'0','10.96.196.127',13724,'InnoDB Buffer Pool Instances is too small'),(619,1,1492239623,0,13,'0','10.96.196.127',13725,'InnoDB Deadlock detected'),(620,1,1492239623,0,13,'0','10.96.196.127',13726,'InnoDB Flush Log at Transaction Commit'),(621,1,1492239623,0,13,'0','10.96.196.127',13727,'InnoDB Flush Method has changed'),(622,1,1492239623,0,13,'0','10.96.196.127',13728,'InnoDB Force Recovery is enabled'),(623,1,1492239623,0,13,'0','10.96.196.127',13729,'InnoDB Foreign Key error detected'),(624,1,1492239623,0,13,'0','10.96.196.127',13730,'InnoDB Log Buffer too small'),(625,1,1492239623,0,13,'0','10.96.196.127',13731,'InnoDB Log File size is too small'),(626,1,1492239623,0,13,'0','10.96.196.127',13732,'InnoDB Log File size is too small'),(627,1,1492239623,0,13,'0','10.96.196.127',13733,'InnoDB Plugin is enabled'),(628,1,1492239623,0,13,'0','10.96.196.127',13734,'IO thread stopped'),(629,1,1492239623,0,13,'0','10.96.196.127',13735,'Lack of available memory on server {HOST.NAME}'),(630,1,1492239623,0,13,'0','10.96.196.127',13736,'Lack of free memory on server {HOST.NAME}'),(631,1,1492239623,0,13,'0','10.96.196.127',13737,'Lack of free swap space on {HOST.NAME}'),(632,1,1492239623,0,13,'0','10.96.196.127',13738,'Less than 5% free in the value cache'),(633,1,1492239623,0,13,'0','10.96.196.127',13739,'Less than 25% free in the configuration cache'),(634,1,1492239623,0,13,'0','10.96.196.127',13740,'Less than 25% free in the configuration cache'),(635,1,1492239623,0,13,'0','10.96.196.127',13741,'Less than 25% free in the history cache'),(636,1,1492239623,0,13,'0','10.96.196.127',13742,'Less than 25% free in the history cache'),(637,1,1492239623,0,13,'0','10.96.196.127',13743,'Less than 25% free in the history index cache'),(638,1,1492239623,0,13,'0','10.96.196.127',13744,'Less than 25% free in the text history cache'),(639,1,1492239623,0,13,'0','10.96.196.127',13745,'Less than 25% free in the trends cache'),(640,1,1492239623,0,13,'0','10.96.196.127',13746,'Less than 25% free in the vmware cache'),(641,1,1492239623,0,13,'0','10.96.196.127',13747,'Log Output is other than File'),(642,1,1492239623,0,13,'0','10.96.196.127',13748,'Log Queries not using Indexes is disabled'),(643,1,1492239623,0,13,'0','10.96.196.127',13749,'Low free disk space'),(644,1,1492239623,0,13,'0','10.96.196.127',13750,'Low free disk space'),(645,1,1492239623,0,13,'0','10.96.196.127',13751,'More than 100 items having missing data for more than 10 minutes'),(646,1,1492239623,0,13,'0','10.96.196.127',13752,'More than 100 items having missing data for more than 10 minutes'),(647,1,1492239623,0,13,'0','10.96.196.127',13753,'MySQL is down'),(648,1,1492239623,0,13,'0','10.96.196.127',13754,'MySQL is down'),(649,1,1492239623,0,13,'0','10.96.196.127',13755,'MySQL is up again'),(650,1,1492239623,0,13,'0','10.96.196.127',13756,'Node is not ready'),(651,1,1492239623,0,13,'0','10.96.196.127',13757,'nova-novncproxy has  down'),(652,1,1492239623,0,13,'0','10.96.196.127',13758,'Old Binlog Format is still used'),(653,1,1492239623,0,13,'0','10.96.196.127',13759,'Open files high'),(654,1,1492239623,0,13,'0','10.96.196.127',13760,'openstack ceilometer-agent-notification has down'),(655,1,1492239623,0,13,'0','10.96.196.127',13761,'openstack ceilometer-collector has down'),(656,1,1492239623,0,13,'0','10.96.196.127',13762,'openstack ceilometer-polling has down'),(657,1,1492239623,0,13,'0','10.96.196.127',13763,'openstack ceilometer-polling has down'),(658,1,1492239623,0,13,'0','10.96.196.127',13764,'openstack cinder-api has down'),(659,1,1492239623,0,13,'0','10.96.196.127',13765,'openstack cinder-scheduler has down'),(660,1,1492239623,0,13,'0','10.96.196.127',13766,'openstack cinder-volume has down'),(661,1,1492239623,0,13,'0','10.96.196.127',13767,'Openstack cinder process status'),(662,1,1492239623,0,13,'0','10.96.196.127',13768,'Openstack compute service cinder volume'),(663,1,1492239623,0,13,'0','10.96.196.127',13769,'Openstack compute service libvirtd'),(664,1,1492239623,0,13,'0','10.96.196.127',13770,'Openstack compute service neutron l3 agent'),(665,1,1492239623,0,13,'0','10.96.196.127',13771,'Openstack compute service neutron metadata agent'),(666,1,1492239623,0,13,'0','10.96.196.127',13772,'Openstack compute service neutron openvswitch agent'),(667,1,1492239623,0,13,'0','10.96.196.127',13773,'Openstack compute service nova compute'),(668,1,1492239623,0,13,'0','10.96.196.127',13774,'Openstack controller service cinder api'),(669,1,1492239623,0,13,'0','10.96.196.127',13775,'Openstack controller service cinder scheduler'),(670,1,1492239623,0,13,'0','10.96.196.127',13776,'Openstack controller service glance api'),(671,1,1492239623,0,13,'0','10.96.196.127',13777,'Openstack controller service glance registry'),(672,1,1492239623,0,13,'0','10.96.196.127',13778,'Openstack controller service httpd'),(673,1,1492239623,0,13,'0','10.96.196.127',13779,'Openstack controller service memcached'),(674,1,1492239623,0,13,'0','10.96.196.127',13780,'Openstack controller service neutron dhcp agent'),(675,1,1492239623,0,13,'0','10.96.196.127',13781,'Openstack controller service neutron l3 agent'),(676,1,1492239623,0,13,'0','10.96.196.127',13782,'Openstack controller service neutron metadata agent'),(677,1,1492239623,0,13,'0','10.96.196.127',13783,'Openstack controller service neutron openvswitch agent'),(678,1,1492239623,0,13,'0','10.96.196.127',13784,'Openstack controller service neutron server'),(679,1,1492239623,0,13,'0','10.96.196.127',13785,'Openstack controller service nova api'),(680,1,1492239623,0,13,'0','10.96.196.127',13786,'Openstack controller service nova cert'),(681,1,1492239623,0,13,'0','10.96.196.127',13787,'Openstack controller service nova conductor'),(682,1,1492239623,0,13,'0','10.96.196.127',13788,'Openstack controller service nova consoleauth'),(683,1,1492239623,0,13,'0','10.96.196.127',13789,'Openstack controller service nova novncproxy'),(684,1,1492239623,0,13,'0','10.96.196.127',13790,'Openstack controller service nova scheduler'),(685,1,1492239623,0,13,'0','10.96.196.127',13791,'openstack glance-api has down'),(686,1,1492239623,0,13,'0','10.96.196.127',13792,'openstack glance-registry has down'),(687,1,1492239623,0,13,'0','10.96.196.127',13793,'Openstack haproxy has down'),(688,1,1492239623,0,13,'0','10.96.196.127',13794,'openstack httpd has down'),(689,1,1492239623,0,13,'0','10.96.196.127',13795,'openstack httpd has down'),(690,1,1492239623,0,13,'0','10.96.196.127',13796,'openstack libvirtd has down'),(691,1,1492239623,0,13,'0','10.96.196.127',13797,'openstack memcached has down'),(692,1,1492239623,0,13,'0','10.96.196.127',13798,'openstack mysqld has down'),(693,1,1492239623,0,13,'0','10.96.196.127',13799,'openstack neutron-dhcp-agent has down'),(694,1,1492239623,0,13,'0','10.96.196.127',13800,'openstack neutron-l3-agent has down'),(695,1,1492239623,0,13,'0','10.96.196.127',13801,'openstack neutron-l3-agent has down'),(696,1,1492239623,0,13,'0','10.96.196.127',13802,'openstack neutron-lbaasv2-agent has down'),(697,1,1492239623,0,13,'0','10.96.196.127',13803,'openstack  neutron-metadata-agent has down'),(698,1,1492239623,0,13,'0','10.96.196.127',13804,'openstack neutron-openvswitch-agent has down'),(699,1,1492239623,0,13,'0','10.96.196.127',13805,'openstack neutron-openvswitch-agent has down'),(700,1,1492239623,0,13,'0','10.96.196.127',13806,'openstack neutron-server has down'),(701,1,1492239623,0,13,'0','10.96.196.127',13807,'Openstack neutron process status'),(702,1,1492239623,0,13,'0','10.96.196.127',13808,'openstack nova-api has down'),(703,1,1492239623,0,13,'0','10.96.196.127',13809,'openstack nova-cert has down'),(704,1,1492239623,0,13,'0','10.96.196.127',13810,'openstack nova-compute has down'),(705,1,1492239623,0,13,'0','10.96.196.127',13811,'openstack nova-conductor has down'),(706,1,1492239623,0,13,'0','10.96.196.127',13812,'openstack nova-consoleauth has down'),(707,1,1492239623,0,13,'0','10.96.196.127',13813,'openstack nova-novncproxy has down'),(708,1,1492239623,0,13,'0','10.96.196.127',13814,'openstack nova-scheduler has down'),(709,1,1492239623,0,13,'0','10.96.196.127',13815,'Openstack nova process status'),(710,1,1492239623,0,13,'0','10.96.196.127',13816,'openstack ntpd has down'),(711,1,1492239623,0,13,'0','10.96.196.127',13817,'openstack openvswitch has down'),(712,1,1492239623,0,13,'0','10.96.196.127',13818,'openstack rabbitmq-server has down'),(713,1,1492239623,0,13,'0','10.96.196.127',13819,'Openstack service haproxy has down'),(714,1,1492239623,0,13,'0','10.96.196.127',13820,'Openstack service keepalived has down'),(715,1,1492239623,0,13,'0','10.96.196.127',13821,'openstack xinetd has down'),(716,1,1492239623,0,13,'0','10.96.196.127',13822,'Processor load is too high on(5min)  {HOST.NAME}'),(717,1,1492239623,0,13,'0','10.96.196.127',13823,'Processor load is too high on (15min){HOST.NAME}'),(718,1,1492239623,0,13,'0','10.96.196.127',13824,'Processor load is too high on {HOST.NAME}'),(719,1,1492239623,0,13,'0','10.96.196.127',13825,'Processor load is too high on {HOST.NAME}'),(720,1,1492239623,0,13,'0','10.96.196.127',13826,'Read buffer size is bigger than max. allowed packet size'),(721,1,1492239623,0,13,'0','10.96.196.127',13827,'Slave errors are skipped!'),(722,1,1492239623,0,13,'0','10.96.196.127',13828,'Slave is NOT read only'),(723,1,1492239623,0,13,'0','10.96.196.127',13829,'Slave lagging behind Master'),(724,1,1492239623,0,13,'0','10.96.196.127',13830,'Slave lagging behind Master'),(725,1,1492239623,0,13,'0','10.96.196.127',13831,'Sort buffer possibly missconfigured'),(726,1,1492239623,0,13,'0','10.96.196.127',13832,'SQL thread stopped'),(727,1,1492239623,0,13,'0','10.96.196.127',13833,'SSH service is down on {HOST.NAME}'),(728,1,1492239623,0,13,'0','10.96.196.127',13834,'Sync Binlog is enabled'),(729,1,1492239623,0,13,'0','10.96.196.127',13835,'Table definition cache too small'),(730,1,1492239623,0,13,'0','10.96.196.127',13836,'Table open cache too small'),(731,1,1492239623,0,13,'0','10.96.196.127',13837,'Thread stack size is possibly too small'),(732,1,1492239623,0,13,'0','10.96.196.127',13838,'Thread stack size is too small'),(733,1,1492239623,0,13,'0','10.96.196.127',13839,'Too little Slave Threads'),(734,1,1492239623,0,13,'0','10.96.196.127',13840,'Too many processes on {HOST.NAME}'),(735,1,1492239623,0,13,'0','10.96.196.127',13841,'Transaction isolation level is set to non-default value'),(736,1,1492239623,0,13,'0','10.96.196.127',13842,'Transaction isolation level is set to non-recommended value'),(737,1,1492239623,0,13,'0','10.96.196.127',13843,'Very low free disk space'),(738,1,1492239623,0,13,'0','10.96.196.127',13844,'Very low free disk space'),(739,1,1492239623,0,13,'0','10.96.196.127',13845,'Zabbix agent on {HOST.NAME} is unreachable for 5 minutes'),(740,1,1492239623,0,13,'0','10.96.196.127',13846,'Zabbix agent on {HOST.NAME} is unreachable for 5 minutes'),(741,1,1492239623,0,13,'0','10.96.196.127',13847,'Zabbix agent on {HOST.NAME} is unreachable for 5 minutes'),(742,1,1492239623,0,13,'0','10.96.196.127',13848,'Zabbix alerter processes more than 75% busy'),(743,1,1492239623,0,13,'0','10.96.196.127',13849,'Zabbix configuration syncer processes more than 75% busy'),(744,1,1492239623,0,13,'0','10.96.196.127',13850,'Zabbix configuration syncer processes more than 75% busy'),(745,1,1492239623,0,13,'0','10.96.196.127',13851,'Zabbix data sender processes more than 75% busy'),(746,1,1492239623,0,13,'0','10.96.196.127',13852,'Zabbix db watchdog processes more than 75% busy'),(747,1,1492239623,0,13,'0','10.96.196.127',13853,'Zabbix discoverer processes more than 75% busy'),(748,1,1492239623,0,13,'0','10.96.196.127',13854,'Zabbix discoverer processes more than 75% busy'),(749,1,1492239623,0,13,'0','10.96.196.127',13855,'Zabbix escalator processes more than 75% busy'),(750,1,1492239623,0,13,'0','10.96.196.127',13856,'Zabbix heartbeat sender processes more than 75% busy'),(751,1,1492239623,0,13,'0','10.96.196.127',13857,'Zabbix history syncer processes more than 75% busy'),(752,1,1492239623,0,13,'0','10.96.196.127',13858,'Zabbix history syncer processes more than 75% busy'),(753,1,1492239623,0,13,'0','10.96.196.127',13859,'Zabbix housekeeper processes more than 75% busy'),(754,1,1492239623,0,13,'0','10.96.196.127',13860,'Zabbix housekeeper processes more than 75% busy'),(755,1,1492239623,0,13,'0','10.96.196.127',13861,'Zabbix http poller processes more than 75% busy'),(756,1,1492239623,0,13,'0','10.96.196.127',13862,'Zabbix http poller processes more than 75% busy'),(757,1,1492239623,0,13,'0','10.96.196.127',13863,'Zabbix icmp pinger processes more than 75% busy'),(758,1,1492239623,0,13,'0','10.96.196.127',13864,'Zabbix icmp pinger processes more than 75% busy'),(759,1,1492239623,0,13,'0','10.96.196.127',13865,'Zabbix ipmi poller processes more than 75% busy'),(760,1,1492239623,0,13,'0','10.96.196.127',13866,'Zabbix ipmi poller processes more than 75% busy'),(761,1,1492239623,0,13,'0','10.96.196.127',13867,'Zabbix java poller processes more than 75% busy'),(762,1,1492239623,0,13,'0','10.96.196.127',13868,'Zabbix java poller processes more than 75% busy'),(763,1,1492239623,0,13,'0','10.96.196.127',13869,'Zabbix poller processes more than 75% busy'),(764,1,1492239623,0,13,'0','10.96.196.127',13870,'Zabbix poller processes more than 75% busy'),(765,1,1492239623,0,13,'0','10.96.196.127',13871,'Zabbix proxy poller processes more than 75% busy'),(766,1,1492239623,0,13,'0','10.96.196.127',13872,'Zabbix self-monitoring processes more than 75% busy'),(767,1,1492239623,0,13,'0','10.96.196.127',13873,'Zabbix self-monitoring processes more than 75% busy'),(768,1,1492239623,0,13,'0','10.96.196.127',13874,'Zabbix snmp trapper processes more than 75% busy'),(769,1,1492239623,0,13,'0','10.96.196.127',13875,'Zabbix snmp trapper processes more than 75% busy'),(770,1,1492239623,0,13,'0','10.96.196.127',13876,'Zabbix timer processes more than 75% busy'),(771,1,1492239623,0,13,'0','10.96.196.127',13877,'Zabbix trapper processes more than 75% busy'),(772,1,1492239623,0,13,'0','10.96.196.127',13878,'Zabbix trapper processes more than 75% busy'),(773,1,1492239623,0,13,'0','10.96.196.127',13879,'Zabbix unreachable poller processes more than 75% busy'),(774,1,1492239623,0,13,'0','10.96.196.127',13880,'Zabbix unreachable poller processes more than 75% busy'),(775,1,1492239623,0,13,'0','10.96.196.127',13881,'Zabbix value cache working in low memory mode'),(776,1,1492239623,0,13,'0','10.96.196.127',13882,'Zabbix vmware collector processes more than 75% busy'),(777,1,1492239623,0,13,'0','10.96.196.127',13883,'{HOST.NAME} has just been restarted'),(778,1,1492239623,0,13,'0','10.96.196.127',13884,'{HOST.NAME} has just been restarted'),(779,1,1492239823,2,13,'0','10.96.196.127',13774,'Openstack controller service cinder api'),(780,1,1492239823,2,13,'0','10.96.196.127',13775,'Openstack controller service cinder scheduler'),(781,1,1492239823,2,13,'0','10.96.196.127',13776,'Openstack controller service glance api'),(782,1,1492239823,2,13,'0','10.96.196.127',13777,'Openstack controller service glance registry'),(783,1,1492239823,2,13,'0','10.96.196.127',13778,'Openstack controller service httpd'),(784,1,1492239823,2,13,'0','10.96.196.127',13779,'Openstack controller service memcached'),(785,1,1492239823,2,13,'0','10.96.196.127',13780,'Openstack controller service neutron dhcp agent'),(786,1,1492239823,2,13,'0','10.96.196.127',13781,'Openstack controller service neutron l3 agent'),(787,1,1492239823,2,13,'0','10.96.196.127',13782,'Openstack controller service neutron metadata agent'),(788,1,1492239823,2,13,'0','10.96.196.127',13783,'Openstack controller service neutron openvswitch agent'),(789,1,1492239823,2,13,'0','10.96.196.127',13784,'Openstack controller service neutron server'),(790,1,1492239823,2,13,'0','10.96.196.127',13785,'Openstack controller service nova api'),(791,1,1492239823,2,13,'0','10.96.196.127',13786,'Openstack controller service nova cert'),(792,1,1492239823,2,13,'0','10.96.196.127',13787,'Openstack controller service nova conductor'),(793,1,1492239823,2,13,'0','10.96.196.127',13788,'Openstack controller service nova consoleauth'),(794,1,1492239823,2,13,'0','10.96.196.127',13789,'Openstack controller service nova novncproxy'),(795,1,1492239823,2,13,'0','10.96.196.127',13790,'Openstack controller service nova scheduler'),(796,1,1492239823,2,13,'0','10.96.196.127',13793,'Openstack haproxy has down'),(797,1,1492239823,2,15,'Item [openstack.serviceexist[haproxy]] [23917] Host [Template App Openstack Controller ServiceExist]','10.96.196.127',0,''),(798,1,1492239823,2,15,'Item [openstack.serviceexist[httpd]] [23918] Host [Template App Openstack Controller ServiceExist]','10.96.196.127',0,''),(799,1,1492239823,2,15,'Item [openstack.serviceexist[memcached]] [23919] Host [Template App Openstack Controller ServiceExist]','10.96.196.127',0,''),(800,1,1492239823,2,15,'Item [openstack.serviceexist[neutron-dhcp-agent]] [23920] Host [Template App Openstack Controller ServiceExist]','10.96.196.127',0,''),(801,1,1492239823,2,15,'Item [openstack.serviceexist[neutron-l3-agent]] [23921] Host [Template App Openstack Controller ServiceExist]','10.96.196.127',0,''),(802,1,1492239823,2,15,'Item [openstack.serviceexist[neutron-metadata-agent]] [23922] Host [Template App Openstack Controller ServiceExist]','10.96.196.127',0,''),(803,1,1492239823,2,15,'Item [openstack.serviceexist[neutron-openvswitch-agent]] [23923] Host [Template App Openstack Controller ServiceExist]','10.96.196.127',0,''),(804,1,1492239823,2,15,'Item [openstack.serviceexist[ neutron-server]] [23924] Host [Template App Openstack Controller ServiceExist]','10.96.196.127',0,''),(805,1,1492239823,2,15,'Item [openstack.serviceexist[openstack-cinder-api]] [23925] Host [Template App Openstack Controller ServiceExist]','10.96.196.127',0,''),(806,1,1492239823,2,15,'Item [openstack.serviceexist[openstack-cinder-scheduler]] [23926] Host [Template App Openstack Controller ServiceExist]','10.96.196.127',0,''),(807,1,1492239823,2,15,'Item [openstack.serviceexist[openstack-glance-api]] [23927] Host [Template App Openstack Controller ServiceExist]','10.96.196.127',0,''),(808,1,1492239823,2,15,'Item [openstack.serviceexist[openstack-glance-registry]] [23928] Host [Template App Openstack Controller ServiceExist]','10.96.196.127',0,''),(809,1,1492239823,2,15,'Item [openstack.serviceexist[openstack-nova-api]] [23929] Host [Template App Openstack Controller ServiceExist]','10.96.196.127',0,''),(810,1,1492239823,2,15,'Item [openstack.serviceexist[openstack-nova-cert]] [23930] Host [Template App Openstack Controller ServiceExist]','10.96.196.127',0,''),(811,1,1492239823,2,15,'Item [openstack.serviceexist[openstack-nova-conductor]] [23931] Host [Template App Openstack Controller ServiceExist]','10.96.196.127',0,''),(812,1,1492239823,2,15,'Item [openstack.serviceexist[openstack-nova-consoleauth]] [23932] Host [Template App Openstack Controller ServiceExist]','10.96.196.127',0,''),(813,1,1492239823,2,15,'Item [openstack.serviceexist[openstack-nova-novncproxy]] [23933] Host [Template App Openstack Controller ServiceExist]','10.96.196.127',0,''),(814,1,1492239823,2,15,'Item [openstack.serviceexist[openstack-nova-scheduler]] [23934] Host [Template App Openstack Controller ServiceExist]','10.96.196.127',0,''),(815,1,1492253247,1,0,'User alias [Admin] name [Zabbix] surname [Administrator]','10.96.206.88',0,''),(816,1,1492253334,1,5,'Name: Send E-mail','10.96.206.88',0,''),(817,1,1492253469,1,5,'Name: Auto registration:compute','10.96.206.88',0,''),(818,1,1492253517,1,5,'Name: Auto registration:controller','10.96.206.88',0,''),(819,1,1492253597,1,5,'Name: Auto registration:ceph','10.96.206.88',0,''),(820,1,1492253616,1,5,'Name: Auto registration:compute','10.96.206.88',0,''),(821,1,1497494728,3,0,'0','10.103.197.133',1,''),(822,1,1497494766,1,3,'Media type [Wechat]','10.103.197.133',0,''),(823,1,1497494914,0,3,'Media type [Email-163]','10.103.197.133',0,''),(824,1,1497494999,0,5,'Name: send email by 163','10.103.197.133',0,''),(825,1,1497495040,1,5,'Name: Auto registration:compute','10.103.197.133',0,''),(826,1,1497495054,1,5,'Name: Auto registration:controller','10.103.197.133',0,''),(827,1,1497495076,1,5,'Name: Auto registration:ceph','10.103.197.133',0,''),(828,1,1497495083,1,5,'Name: Auto registration:agent','10.103.197.133',0,''),(829,1,1497495087,1,5,' Actions [8] enabled','10.103.197.133',0,''),(830,1,1497495088,1,5,' Actions [9] enabled','10.103.197.133',0,''),(831,1,1497495088,1,5,' Actions [10] enabled','10.103.197.133',0,''),(832,1,1497495125,1,0,'User alias [Admin] name [Zabbix] surname [Administrator]','10.103.197.133',0,''),(833,1,1497495153,2,13,'0','10.103.197.133',13697,'Auto Increment Control is disabled'),(834,1,1497495153,2,13,'0','10.103.197.133',13698,'Binary Log Do Filter is enabled'),(835,1,1497495153,2,13,'0','10.103.197.133',13699,'Binary Log Ignore Filter is enabled'),(836,1,1497495153,2,13,'0','10.103.197.133',13700,'Binary Log is disabled'),(837,1,1497495153,2,13,'0','10.103.197.133',13701,'Binlog format MIXED with filtering'),(838,1,1497495153,2,13,'0','10.103.197.133',13702,'Binlog Statement Cache size too small'),(839,1,1497495153,2,13,'0','10.103.197.133',13703,'Binlog Transaction Cache size too small'),(840,1,1497495153,2,13,'0','10.103.197.133',13704,'Causal Reads is enabled'),(841,1,1497495153,2,13,'0','10.103.197.133',13707,'Character Set of Server is utf8'),(842,1,1497495153,2,13,'0','10.103.197.133',13708,'Cluster Configuration has changed'),(843,1,1497495153,2,13,'0','10.103.197.133',13709,'Cluster is slowed down due to slave lag'),(844,1,1497495153,2,13,'0','10.103.197.133',13710,'Cluster node status'),(845,1,1497495153,2,13,'0','10.103.197.133',13711,'Cluster size is different from expected'),(846,1,1497495153,2,13,'0','10.103.197.133',13715,'Default Storage Engine is not InnoDB'),(847,1,1497495153,2,13,'0','10.103.197.133',13717,'fpmmm Agent is down'),(848,1,1497495153,2,13,'0','10.103.197.133',13718,'fpmmm MaaS Agent is not sending data'),(849,1,1497495153,2,13,'0','10.103.197.133',13719,'fpmmm MaaS Agent is sending data again'),(850,1,1497495153,2,13,'0','10.103.197.133',13720,'fpmmm Version'),(851,1,1497495153,2,13,'0','10.103.197.133',13721,'General Log is enabled'),(852,1,1497495153,2,13,'0','10.103.197.133',13724,'InnoDB Buffer Pool Instances is too small'),(853,1,1497495153,2,13,'0','10.103.197.133',13725,'InnoDB Deadlock detected'),(854,1,1497495153,2,13,'0','10.103.197.133',13726,'InnoDB Flush Log at Transaction Commit'),(855,1,1497495153,2,13,'0','10.103.197.133',13727,'InnoDB Flush Method has changed'),(856,1,1497495153,2,13,'0','10.103.197.133',13728,'InnoDB Force Recovery is enabled'),(857,1,1497495153,2,13,'0','10.103.197.133',13729,'InnoDB Foreign Key error detected'),(858,1,1497495153,2,13,'0','10.103.197.133',13730,'InnoDB Log Buffer too small'),(859,1,1497495153,2,13,'0','10.103.197.133',13731,'InnoDB Log File size is too small'),(860,1,1497495153,2,13,'0','10.103.197.133',13732,'InnoDB Log File size is too small'),(861,1,1497495153,2,13,'0','10.103.197.133',13733,'InnoDB Plugin is enabled'),(862,1,1497495153,2,13,'0','10.103.197.133',13734,'IO thread stopped'),(863,1,1497495153,2,13,'0','10.103.197.133',13747,'Log Output is other than File'),(864,1,1497495153,2,13,'0','10.103.197.133',13748,'Log Queries not using Indexes is disabled'),(865,1,1497495153,2,13,'0','10.103.197.133',13749,'Low free disk space'),(866,1,1497495153,2,13,'0','10.103.197.133',13750,'Low free disk space'),(867,1,1497495153,2,13,'0','10.103.197.133',13754,'MySQL is down'),(868,1,1497495153,2,13,'0','10.103.197.133',13755,'MySQL is up again'),(869,1,1497495153,2,13,'0','10.103.197.133',13756,'Node is not ready'),(870,1,1497495153,2,13,'0','10.103.197.133',13758,'Old Binlog Format is still used'),(871,1,1497495153,2,13,'0','10.103.197.133',13759,'Open files high'),(872,1,1497495153,2,13,'0','10.103.197.133',13826,'Read buffer size is bigger than max. allowed packet size'),(873,1,1497495153,2,13,'0','10.103.197.133',13827,'Slave errors are skipped!'),(874,1,1497495153,2,13,'0','10.103.197.133',13828,'Slave is NOT read only'),(875,1,1497495153,2,13,'0','10.103.197.133',13829,'Slave lagging behind Master'),(876,1,1497495153,2,13,'0','10.103.197.133',13830,'Slave lagging behind Master'),(877,1,1497495153,2,13,'0','10.103.197.133',13831,'Sort buffer possibly missconfigured'),(878,1,1497495153,2,13,'0','10.103.197.133',13832,'SQL thread stopped'),(879,1,1497495153,2,13,'0','10.103.197.133',13834,'Sync Binlog is enabled'),(880,1,1497495153,2,13,'0','10.103.197.133',13835,'Table definition cache too small'),(881,1,1497495153,2,13,'0','10.103.197.133',13836,'Table open cache too small'),(882,1,1497495153,2,13,'0','10.103.197.133',13837,'Thread stack size is possibly too small'),(883,1,1497495153,2,13,'0','10.103.197.133',13838,'Thread stack size is too small'),(884,1,1497495153,2,13,'0','10.103.197.133',13839,'Too little Slave Threads'),(885,1,1497495153,2,13,'0','10.103.197.133',13841,'Transaction isolation level is set to non-default value'),(886,1,1497495153,2,13,'0','10.103.197.133',13842,'Transaction isolation level is set to non-recommended value'),(887,1,1497495153,2,13,'0','10.103.197.133',13843,'Very low free disk space'),(888,1,1497495153,2,13,'0','10.103.197.133',13844,'Very low free disk space'),(889,1,1497495153,2,4,'0','10.103.197.133',10129,'Template_FromDual.MySQL.aria'),(890,1,1497495153,2,4,'0','10.103.197.133',10130,'Template_FromDual.MySQL.fpmmm'),(891,1,1497495153,2,4,'0','10.103.197.133',10131,'Template_FromDual.MySQL.galera'),(892,1,1497495153,2,4,'0','10.103.197.133',10132,'Template_FromDual.MySQL.innodb'),(893,1,1497495153,2,4,'0','10.103.197.133',10133,'Template_FromDual.MySQL.master'),(894,1,1497495153,2,4,'0','10.103.197.133',10134,'Template_FromDual.MySQL.mysql'),(895,1,1497495153,2,4,'0','10.103.197.133',10135,'Template_FromDual.MySQL.process'),(896,1,1497495153,2,4,'0','10.103.197.133',10136,'Template_FromDual.MySQL.security'),(897,1,1497495153,2,4,'0','10.103.197.133',10137,'Template_FromDual.MySQL.server'),(898,1,1497495153,2,4,'0','10.103.197.133',10138,'Template_FromDual.MySQL.slave'),(899,1,1497495170,1,15,'0','10.103.197.133',23851,'compute node: neutron-dhcp-agent'),(900,1,1497495173,1,15,'0','10.103.197.133',23852,'compute node: neutron-l3-agent'),(901,1,1497495177,1,15,'0','10.103.197.133',23853,'compute node: neutron-metadata-agent'),(902,1,1497495187,1,15,'0','10.103.197.133',23856,'compute node: openstack-cinder-volume'),(903,1,1497495227,1,5,'Name: Auto registration:compute','10.103.197.133',0,''),(904,1,1497495242,1,5,'Name: Auto registration:controller','10.103.197.133',0,''),(905,1,1497496729,1,13,'0','10.103.197.133',13467,'Zabbix alerter processes more than 75% busy'),(906,1,1497496729,1,13,'0','10.103.197.133',13468,'Zabbix configuration syncer processes more than 75% busy'),(907,1,1497496729,1,13,'0','10.103.197.133',13469,'Zabbix db watchdog processes more than 75% busy'),(908,1,1497496729,1,13,'0','10.103.197.133',13470,'Zabbix discoverer processes more than 75% busy'),(909,1,1497496729,1,13,'0','10.103.197.133',13471,'Zabbix escalator processes more than 75% busy'),(910,1,1497496729,1,13,'0','10.103.197.133',13472,'Zabbix history syncer processes more than 75% busy'),(911,1,1497496729,1,13,'0','10.103.197.133',13473,'Zabbix housekeeper processes more than 75% busy'),(912,1,1497496729,1,13,'0','10.103.197.133',13474,'Zabbix http poller processes more than 75% busy'),(913,1,1497496729,1,13,'0','10.103.197.133',13475,'Zabbix icmp pinger processes more than 75% busy'),(914,1,1497496729,1,13,'0','10.103.197.133',13476,'Zabbix ipmi poller processes more than 75% busy'),(915,1,1497496729,1,13,'0','10.103.197.133',13477,'Zabbix java poller processes more than 75% busy'),(916,1,1497496729,1,13,'0','10.103.197.133',13479,'Zabbix poller processes more than 75% busy'),(917,1,1497496729,1,13,'0','10.103.197.133',13480,'Zabbix proxy poller processes more than 75% busy'),(918,1,1497496729,1,13,'0','10.103.197.133',13481,'Zabbix self-monitoring processes more than 75% busy'),(919,1,1497496729,1,13,'0','10.103.197.133',13482,'Zabbix snmp trapper processes more than 75% busy'),(920,1,1497496729,1,13,'0','10.103.197.133',13483,'Zabbix timer processes more than 75% busy'),(921,1,1497496729,1,13,'0','10.103.197.133',13484,'Zabbix trapper processes more than 75% busy'),(922,1,1497496729,1,13,'0','10.103.197.133',13485,'Zabbix unreachable poller processes more than 75% busy'),(923,1,1497496729,1,13,'0','10.103.197.133',13436,'Zabbix vmware collector processes more than 75% busy'),(924,1,1497496729,1,13,'0','10.103.197.133',13486,'More than 100 items having missing data for more than 10 minutes'),(925,1,1497496729,1,13,'0','10.103.197.133',13487,'Less than 25% free in the configuration cache'),(926,1,1497496729,1,13,'0','10.103.197.133',13075,'Less than 5% free in the value cache'),(927,1,1497496729,1,13,'0','10.103.197.133',13558,'Zabbix value cache working in low memory mode'),(928,1,1497496729,1,13,'0','10.103.197.133',13537,'Less than 25% free in the vmware cache'),(929,1,1497496729,1,13,'0','10.103.197.133',13488,'Less than 25% free in the history cache'),(930,1,1497496729,1,13,'0','10.103.197.133',13489,'Less than 25% free in the history index cache'),(931,1,1497496729,1,13,'0','10.103.197.133',13490,'Less than 25% free in the trends cache'),(932,1,1528252809,3,0,'0','10.212.134.200',1,''),(933,1,1528253342,1,5,'Name: Auto registration:controller','10.212.134.200',0,''),(934,1,1528253411,1,5,'Name: Auto registration:compute','10.212.134.200',0,''),(935,1,1528254400,3,0,'0','10.212.134.200',1,''),(936,1,1528254421,0,13,'0','10.212.134.200',13888,'Baseboard Temp Critical [{ITEM.VALUE}]'),(937,1,1528254421,0,13,'0','10.212.134.200',13889,'Baseboard Temp Non-Critical [{ITEM.VALUE}]'),(938,1,1528254421,0,13,'0','10.212.134.200',13890,'BB +1.05V PCH Critical [{ITEM.VALUE}]'),(939,1,1528254421,0,13,'0','10.212.134.200',13891,'BB +1.05V PCH Non-Critical [{ITEM.VALUE}]'),(940,1,1528254421,0,13,'0','10.212.134.200',13892,'BB +1.1V P1 Vccp Critical [{ITEM.VALUE}]'),(941,1,1528254421,0,13,'0','10.212.134.200',13893,'BB +1.1V P1 Vccp Non-Critical [{ITEM.VALUE}]'),(942,1,1528254421,0,13,'0','10.212.134.200',13894,'BB +1.5V P1 DDR3 Critical [{ITEM.VALUE}]'),(943,1,1528254421,0,13,'0','10.212.134.200',13895,'BB +1.5V P1 DDR3 Non-Critical [{ITEM.VALUE}]'),(944,1,1528254421,0,13,'0','10.212.134.200',13896,'BB +1.8V SM Critical [{ITEM.VALUE}]'),(945,1,1528254421,0,13,'0','10.212.134.200',13897,'BB +1.8V SM Non-Critical [{ITEM.VALUE}]'),(946,1,1528254421,0,13,'0','10.212.134.200',13898,'BB +3.3V Critical [{ITEM.VALUE}]'),(947,1,1528254421,0,13,'0','10.212.134.200',13899,'BB +3.3V Critical [{ITEM.VALUE}]'),(948,1,1528254421,0,13,'0','10.212.134.200',13900,'BB +3.3V Non-Critical [{ITEM.VALUE}]'),(949,1,1528254421,0,13,'0','10.212.134.200',13901,'BB +3.3V Non-Critical [{ITEM.VALUE}]'),(950,1,1528254421,0,13,'0','10.212.134.200',13902,'BB +3.3V STBY Critical [{ITEM.VALUE}]'),(951,1,1528254421,0,13,'0','10.212.134.200',13903,'BB +3.3V STBY Critical [{ITEM.VALUE}]'),(952,1,1528254421,0,13,'0','10.212.134.200',13904,'BB +3.3V STBY Non-Critical [{ITEM.VALUE}]'),(953,1,1528254421,0,13,'0','10.212.134.200',13905,'BB +3.3V STBY Non-Critical [{ITEM.VALUE}]'),(954,1,1528254421,0,13,'0','10.212.134.200',13906,'BB +5.0V Critical [{ITEM.VALUE}]'),(955,1,1528254421,0,13,'0','10.212.134.200',13907,'BB +5.0V Critical [{ITEM.VALUE}]'),(956,1,1528254421,0,13,'0','10.212.134.200',13908,'BB +5.0V Non-Critical [{ITEM.VALUE}]'),(957,1,1528254421,0,13,'0','10.212.134.200',13909,'BB +5.0V Non-Critical [{ITEM.VALUE}]'),(958,1,1528254421,0,13,'0','10.212.134.200',13910,'BB Ambient Temp Critical [{ITEM.VALUE}]'),(959,1,1528254421,0,13,'0','10.212.134.200',13911,'BB Ambient Temp Non-Critical [{ITEM.VALUE}]'),(960,1,1528254421,0,13,'0','10.212.134.200',13912,'Front Panel Temp Critical [{ITEM.VALUE}]'),(961,1,1528254421,0,13,'0','10.212.134.200',13913,'Front Panel Temp Non-Critical [{ITEM.VALUE}]'),(962,1,1528254421,0,13,'0','10.212.134.200',13914,'Ping loss is too high on {HOST.NAME}'),(963,1,1528254421,0,13,'0','10.212.134.200',13915,'Power'),(964,1,1528254421,0,13,'0','10.212.134.200',13916,'Power'),(965,1,1528254421,0,13,'0','10.212.134.200',13917,'Response time is too high on {HOST.NAME}'),(966,1,1528254421,0,13,'0','10.212.134.200',13918,'System Fan 2 Critical [{ITEM.VALUE}]'),(967,1,1528254421,0,13,'0','10.212.134.200',13919,'System Fan 2 Non-Critical [{ITEM.VALUE}]'),(968,1,1528254421,0,13,'0','10.212.134.200',13920,'System Fan 3 Critical [{ITEM.VALUE}]'),(969,1,1528254421,0,13,'0','10.212.134.200',13921,'System Fan 3 Non-Critical [{ITEM.VALUE}]'),(970,1,1528254421,0,13,'0','10.212.134.200',13922,'{HOST.NAME} is unavailable by ICMP'),(971,1,1528254422,0,31,'0','10.212.134.200',13923,'Free disk space is less than 20% on volume {#SNMPVALUE}'),(972,1,1528254422,0,31,'0','10.212.134.200',13924,'Operational status was changed on {HOST.NAME} interface {#SNMPVALUE}'),(973,1,1528254422,0,31,'0','10.212.134.200',13925,'Free disk space is less than 20% on volume {#SNMPVALUE}'),(974,1,1528254422,0,31,'0','10.212.134.200',13926,'Free disk space is less than 20% on volume {#SNMPVALUE}'),(975,1,1528254422,0,31,'0','10.212.134.200',13927,'Operational status was changed on {HOST.NAME} interface {#SNMPVALUE}'),(976,1,1528254422,0,31,'0','10.212.134.200',13928,'Operational status was changed on {HOST.NAME} interface {#SNMPVALUE}'),(977,1,1528254422,0,31,'0','10.212.134.200',13929,'Operational status was changed on {HOST.NAME} interface {#SNMPVALUE}'),(978,1,1528966769,3,0,'0','10.0.6.83',1,''),(979,1,1528966876,2,31,'0','10.0.6.83',13885,'Free disk space is less than 20% on volume {#FSNAME}:{13504}<20'),(980,1,1528966876,2,31,'0','10.0.6.83',13886,'Free inodes is less than 20% on volume {#FSNAME}:{13505}<20'),(981,1,1528966876,2,31,'0','10.0.6.83',13887,'Free disk space is less than 20% on volume {#FSNAME}:{13506}<20'),(982,1,1528966876,2,31,'0','10.0.6.83',13923,'Free disk space is less than 20% on volume {#SNMPVALUE}:{13542} / {13543} > 0.8'),(983,1,1528966876,2,31,'0','10.0.6.83',13924,'Operational status was changed on {HOST.NAME} interface {#SNMPVALUE}:{13544}=1'),(984,1,1528966876,2,31,'0','10.0.6.83',13925,'Free disk space is less than 20% on volume {#SNMPVALUE}:{13545} / {13546} > 0.8'),(985,1,1528966876,2,31,'0','10.0.6.83',13926,'Free disk space is less than 20% on volume {#SNMPVALUE}:{13547} / {13548} > 0.8'),(986,1,1528966876,2,31,'0','10.0.6.83',13927,'Operational status was changed on {HOST.NAME} interface {#SNMPVALUE}:{13549}=1'),(987,1,1528966876,2,31,'0','10.0.6.83',13928,'Operational status was changed on {HOST.NAME} interface {#SNMPVALUE}:{13550}=1'),(988,1,1528966876,2,31,'0','10.0.6.83',13929,'Operational status was changed on {HOST.NAME} interface {#SNMPVALUE}:{13551}=1'),(989,1,1528966876,2,13,'0','10.0.6.83',13696,'/etc/passwd has been changed on {HOST.NAME}'),(990,1,1528966876,2,13,'0','10.0.6.83',13705,'CEPH critical error'),(991,1,1528966876,2,13,'0','10.0.6.83',13706,'CEPH warning'),(992,1,1528966876,2,13,'0','10.0.6.83',13712,'Configured max number of opened files is too low on {HOST.NAME}'),(993,1,1528966876,2,13,'0','10.0.6.83',13713,'Configured max number of processes is too low on {HOST.NAME}'),(994,1,1528966876,2,13,'0','10.0.6.83',13714,'CPU interrupt time {HOST.NAME}'),(995,1,1528966876,2,13,'0','10.0.6.83',13716,'Disk I/O is overloaded on {HOST.NAME}'),(996,1,1528966876,2,13,'0','10.0.6.83',13722,'Host information was changed on {HOST.NAME}'),(997,1,1528966876,2,13,'0','10.0.6.83',13723,'Host information was changed on {HOST.NAME}'),(998,1,1528966876,2,13,'0','10.0.6.83',13735,'Lack of available memory on server {HOST.NAME}'),(999,1,1528966876,2,13,'0','10.0.6.83',13736,'Lack of free memory on server {HOST.NAME}'),(1000,1,1528966876,2,13,'0','10.0.6.83',13737,'Lack of free swap space on {HOST.NAME}'),(1001,1,1528966876,2,13,'0','10.0.6.83',13738,'Less than 5% free in the value cache'),(1002,1,1528966876,2,13,'0','10.0.6.83',13739,'Less than 25% free in the configuration cache'),(1003,1,1528966876,2,13,'0','10.0.6.83',13740,'Less than 25% free in the configuration cache'),(1004,1,1528966876,2,13,'0','10.0.6.83',13741,'Less than 25% free in the history cache'),(1005,1,1528966876,2,13,'0','10.0.6.83',13742,'Less than 25% free in the history cache'),(1006,1,1528966876,2,13,'0','10.0.6.83',13743,'Less than 25% free in the history index cache'),(1007,1,1528966876,2,13,'0','10.0.6.83',13744,'Less than 25% free in the text history cache'),(1008,1,1528966876,2,13,'0','10.0.6.83',13745,'Less than 25% free in the trends cache'),(1009,1,1528966876,2,13,'0','10.0.6.83',13746,'Less than 25% free in the vmware cache'),(1010,1,1528966876,2,13,'0','10.0.6.83',13751,'More than 100 items having missing data for more than 10 minutes'),(1011,1,1528966876,2,13,'0','10.0.6.83',13752,'More than 100 items having missing data for more than 10 minutes'),(1012,1,1528966876,2,13,'0','10.0.6.83',13753,'MySQL is down'),(1013,1,1528966876,2,13,'0','10.0.6.83',13757,'nova-novncproxy has  down'),(1014,1,1528966876,2,13,'0','10.0.6.83',13760,'openstack ceilometer-agent-notification has down'),(1015,1,1528966876,2,13,'0','10.0.6.83',13761,'openstack ceilometer-collector has down'),(1016,1,1528966876,2,13,'0','10.0.6.83',13762,'openstack ceilometer-polling has down'),(1017,1,1528966876,2,13,'0','10.0.6.83',13763,'openstack ceilometer-polling has down'),(1018,1,1528966876,2,13,'0','10.0.6.83',13764,'openstack cinder-api has down'),(1019,1,1528966876,2,13,'0','10.0.6.83',13765,'openstack cinder-scheduler has down'),(1020,1,1528966876,2,13,'0','10.0.6.83',13766,'openstack cinder-volume has down'),(1021,1,1528966876,2,13,'0','10.0.6.83',13767,'Openstack cinder process status'),(1022,1,1528966876,2,13,'0','10.0.6.83',13768,'Openstack compute service cinder volume'),(1023,1,1528966876,2,13,'0','10.0.6.83',13769,'Openstack compute service libvirtd'),(1024,1,1528966876,2,13,'0','10.0.6.83',13770,'Openstack compute service neutron l3 agent'),(1025,1,1528966876,2,13,'0','10.0.6.83',13771,'Openstack compute service neutron metadata agent'),(1026,1,1528966876,2,13,'0','10.0.6.83',13772,'Openstack compute service neutron openvswitch agent'),(1027,1,1528966876,2,13,'0','10.0.6.83',13773,'Openstack compute service nova compute'),(1028,1,1528966876,2,13,'0','10.0.6.83',13791,'openstack glance-api has down'),(1029,1,1528966876,2,13,'0','10.0.6.83',13792,'openstack glance-registry has down'),(1030,1,1528966876,2,13,'0','10.0.6.83',13794,'openstack httpd has down'),(1031,1,1528966876,2,13,'0','10.0.6.83',13795,'openstack httpd has down'),(1032,1,1528966876,2,13,'0','10.0.6.83',13796,'openstack libvirtd has down'),(1033,1,1528966876,2,13,'0','10.0.6.83',13797,'openstack memcached has down'),(1034,1,1528966876,2,13,'0','10.0.6.83',13798,'openstack mysqld has down'),(1035,1,1528966876,2,13,'0','10.0.6.83',13799,'openstack neutron-dhcp-agent has down'),(1036,1,1528966876,2,13,'0','10.0.6.83',13800,'openstack neutron-l3-agent has down'),(1037,1,1528966876,2,13,'0','10.0.6.83',13801,'openstack neutron-l3-agent has down'),(1038,1,1528966876,2,13,'0','10.0.6.83',13802,'openstack neutron-lbaasv2-agent has down'),(1039,1,1528966876,2,13,'0','10.0.6.83',13803,'openstack  neutron-metadata-agent has down'),(1040,1,1528966876,2,13,'0','10.0.6.83',13804,'openstack neutron-openvswitch-agent has down'),(1041,1,1528966876,2,13,'0','10.0.6.83',13805,'openstack neutron-openvswitch-agent has down'),(1042,1,1528966876,2,13,'0','10.0.6.83',13806,'openstack neutron-server has down'),(1043,1,1528966876,2,13,'0','10.0.6.83',13807,'Openstack neutron process status'),(1044,1,1528966876,2,13,'0','10.0.6.83',13808,'openstack nova-api has down'),(1045,1,1528966876,2,13,'0','10.0.6.83',13809,'openstack nova-cert has down'),(1046,1,1528966876,2,13,'0','10.0.6.83',13810,'openstack nova-compute has down'),(1047,1,1528966876,2,13,'0','10.0.6.83',13811,'openstack nova-conductor has down'),(1048,1,1528966876,2,13,'0','10.0.6.83',13812,'openstack nova-consoleauth has down'),(1049,1,1528966876,2,13,'0','10.0.6.83',13813,'openstack nova-novncproxy has down'),(1050,1,1528966876,2,13,'0','10.0.6.83',13814,'openstack nova-scheduler has down'),(1051,1,1528966876,2,13,'0','10.0.6.83',13815,'Openstack nova process status'),(1052,1,1528966876,2,13,'0','10.0.6.83',13816,'openstack ntpd has down'),(1053,1,1528966876,2,13,'0','10.0.6.83',13817,'openstack openvswitch has down'),(1054,1,1528966876,2,13,'0','10.0.6.83',13818,'openstack rabbitmq-server has down'),(1055,1,1528966876,2,13,'0','10.0.6.83',13819,'Openstack service haproxy has down'),(1056,1,1528966876,2,13,'0','10.0.6.83',13820,'Openstack service keepalived has down'),(1057,1,1528966876,2,13,'0','10.0.6.83',13821,'openstack xinetd has down'),(1058,1,1528966876,2,13,'0','10.0.6.83',13822,'Processor load is too high on(5min)  {HOST.NAME}'),(1059,1,1528966876,2,13,'0','10.0.6.83',13823,'Processor load is too high on (15min){HOST.NAME}'),(1060,1,1528966876,2,13,'0','10.0.6.83',13824,'Processor load is too high on {HOST.NAME}'),(1061,1,1528966876,2,13,'0','10.0.6.83',13825,'Processor load is too high on {HOST.NAME}'),(1062,1,1528966876,2,13,'0','10.0.6.83',13833,'SSH service is down on {HOST.NAME}'),(1063,1,1528966876,2,13,'0','10.0.6.83',13840,'Too many processes on {HOST.NAME}'),(1064,1,1528966876,2,13,'0','10.0.6.83',13845,'Zabbix agent on {HOST.NAME} is unreachable for 5 minutes'),(1065,1,1528966876,2,13,'0','10.0.6.83',13846,'Zabbix agent on {HOST.NAME} is unreachable for 5 minutes'),(1066,1,1528966876,2,13,'0','10.0.6.83',13847,'Zabbix agent on {HOST.NAME} is unreachable for 5 minutes'),(1067,1,1528966876,2,13,'0','10.0.6.83',13848,'Zabbix alerter processes more than 75% busy'),(1068,1,1528966876,2,13,'0','10.0.6.83',13849,'Zabbix configuration syncer processes more than 75% busy'),(1069,1,1528966876,2,13,'0','10.0.6.83',13850,'Zabbix configuration syncer processes more than 75% busy'),(1070,1,1528966876,2,13,'0','10.0.6.83',13851,'Zabbix data sender processes more than 75% busy'),(1071,1,1528966876,2,13,'0','10.0.6.83',13852,'Zabbix db watchdog processes more than 75% busy'),(1072,1,1528966876,2,13,'0','10.0.6.83',13853,'Zabbix discoverer processes more than 75% busy'),(1073,1,1528966876,2,13,'0','10.0.6.83',13854,'Zabbix discoverer processes more than 75% busy'),(1074,1,1528966876,2,13,'0','10.0.6.83',13855,'Zabbix escalator processes more than 75% busy'),(1075,1,1528966876,2,13,'0','10.0.6.83',13856,'Zabbix heartbeat sender processes more than 75% busy'),(1076,1,1528966876,2,13,'0','10.0.6.83',13857,'Zabbix history syncer processes more than 75% busy'),(1077,1,1528966876,2,13,'0','10.0.6.83',13858,'Zabbix history syncer processes more than 75% busy'),(1078,1,1528966876,2,13,'0','10.0.6.83',13859,'Zabbix housekeeper processes more than 75% busy'),(1079,1,1528966876,2,13,'0','10.0.6.83',13860,'Zabbix housekeeper processes more than 75% busy'),(1080,1,1528966876,2,13,'0','10.0.6.83',13861,'Zabbix http poller processes more than 75% busy'),(1081,1,1528966876,2,13,'0','10.0.6.83',13862,'Zabbix http poller processes more than 75% busy'),(1082,1,1528966876,2,13,'0','10.0.6.83',13863,'Zabbix icmp pinger processes more than 75% busy'),(1083,1,1528966876,2,13,'0','10.0.6.83',13864,'Zabbix icmp pinger processes more than 75% busy'),(1084,1,1528966876,2,13,'0','10.0.6.83',13865,'Zabbix ipmi poller processes more than 75% busy'),(1085,1,1528966876,2,13,'0','10.0.6.83',13866,'Zabbix ipmi poller processes more than 75% busy'),(1086,1,1528966876,2,13,'0','10.0.6.83',13867,'Zabbix java poller processes more than 75% busy'),(1087,1,1528966876,2,13,'0','10.0.6.83',13868,'Zabbix java poller processes more than 75% busy'),(1088,1,1528966876,2,13,'0','10.0.6.83',13869,'Zabbix poller processes more than 75% busy'),(1089,1,1528966876,2,13,'0','10.0.6.83',13870,'Zabbix poller processes more than 75% busy'),(1090,1,1528966876,2,13,'0','10.0.6.83',13871,'Zabbix proxy poller processes more than 75% busy'),(1091,1,1528966876,2,13,'0','10.0.6.83',13872,'Zabbix self-monitoring processes more than 75% busy'),(1092,1,1528966876,2,13,'0','10.0.6.83',13873,'Zabbix self-monitoring processes more than 75% busy'),(1093,1,1528966876,2,13,'0','10.0.6.83',13874,'Zabbix snmp trapper processes more than 75% busy'),(1094,1,1528966876,2,13,'0','10.0.6.83',13875,'Zabbix snmp trapper processes more than 75% busy'),(1095,1,1528966876,2,13,'0','10.0.6.83',13876,'Zabbix timer processes more than 75% busy'),(1096,1,1528966876,2,13,'0','10.0.6.83',13877,'Zabbix trapper processes more than 75% busy'),(1097,1,1528966876,2,13,'0','10.0.6.83',13878,'Zabbix trapper processes more than 75% busy'),(1098,1,1528966876,2,13,'0','10.0.6.83',13879,'Zabbix unreachable poller processes more than 75% busy'),(1099,1,1528966876,2,13,'0','10.0.6.83',13880,'Zabbix unreachable poller processes more than 75% busy'),(1100,1,1528966876,2,13,'0','10.0.6.83',13881,'Zabbix value cache working in low memory mode'),(1101,1,1528966876,2,13,'0','10.0.6.83',13882,'Zabbix vmware collector processes more than 75% busy'),(1102,1,1528966876,2,13,'0','10.0.6.83',13883,'{HOST.NAME} has just been restarted'),(1103,1,1528966876,2,13,'0','10.0.6.83',13884,'{HOST.NAME} has just been restarted'),(1104,1,1528966876,2,13,'0','10.0.6.83',13888,'Baseboard Temp Critical [{ITEM.VALUE}]'),(1105,1,1528966876,2,13,'0','10.0.6.83',13889,'Baseboard Temp Non-Critical [{ITEM.VALUE}]'),(1106,1,1528966876,2,13,'0','10.0.6.83',13890,'BB +1.05V PCH Critical [{ITEM.VALUE}]'),(1107,1,1528966876,2,13,'0','10.0.6.83',13891,'BB +1.05V PCH Non-Critical [{ITEM.VALUE}]'),(1108,1,1528966876,2,13,'0','10.0.6.83',13892,'BB +1.1V P1 Vccp Critical [{ITEM.VALUE}]'),(1109,1,1528966876,2,13,'0','10.0.6.83',13893,'BB +1.1V P1 Vccp Non-Critical [{ITEM.VALUE}]'),(1110,1,1528966876,2,13,'0','10.0.6.83',13894,'BB +1.5V P1 DDR3 Critical [{ITEM.VALUE}]'),(1111,1,1528966876,2,13,'0','10.0.6.83',13895,'BB +1.5V P1 DDR3 Non-Critical [{ITEM.VALUE}]'),(1112,1,1528966876,2,13,'0','10.0.6.83',13896,'BB +1.8V SM Critical [{ITEM.VALUE}]'),(1113,1,1528966876,2,13,'0','10.0.6.83',13897,'BB +1.8V SM Non-Critical [{ITEM.VALUE}]'),(1114,1,1528966876,2,13,'0','10.0.6.83',13898,'BB +3.3V Critical [{ITEM.VALUE}]'),(1115,1,1528966876,2,13,'0','10.0.6.83',13899,'BB +3.3V Critical [{ITEM.VALUE}]'),(1116,1,1528966876,2,13,'0','10.0.6.83',13900,'BB +3.3V Non-Critical [{ITEM.VALUE}]'),(1117,1,1528966876,2,13,'0','10.0.6.83',13901,'BB +3.3V Non-Critical [{ITEM.VALUE}]'),(1118,1,1528966876,2,13,'0','10.0.6.83',13902,'BB +3.3V STBY Critical [{ITEM.VALUE}]'),(1119,1,1528966876,2,13,'0','10.0.6.83',13903,'BB +3.3V STBY Critical [{ITEM.VALUE}]'),(1120,1,1528966876,2,13,'0','10.0.6.83',13904,'BB +3.3V STBY Non-Critical [{ITEM.VALUE}]'),(1121,1,1528966876,2,13,'0','10.0.6.83',13905,'BB +3.3V STBY Non-Critical [{ITEM.VALUE}]'),(1122,1,1528966876,2,13,'0','10.0.6.83',13906,'BB +5.0V Critical [{ITEM.VALUE}]'),(1123,1,1528966876,2,13,'0','10.0.6.83',13907,'BB +5.0V Critical [{ITEM.VALUE}]'),(1124,1,1528966876,2,13,'0','10.0.6.83',13908,'BB +5.0V Non-Critical [{ITEM.VALUE}]'),(1125,1,1528966876,2,13,'0','10.0.6.83',13909,'BB +5.0V Non-Critical [{ITEM.VALUE}]'),(1126,1,1528966876,2,13,'0','10.0.6.83',13910,'BB Ambient Temp Critical [{ITEM.VALUE}]'),(1127,1,1528966876,2,13,'0','10.0.6.83',13911,'BB Ambient Temp Non-Critical [{ITEM.VALUE}]'),(1128,1,1528966876,2,13,'0','10.0.6.83',13912,'Front Panel Temp Critical [{ITEM.VALUE}]'),(1129,1,1528966876,2,13,'0','10.0.6.83',13913,'Front Panel Temp Non-Critical [{ITEM.VALUE}]'),(1130,1,1528966876,2,13,'0','10.0.6.83',13914,'Ping loss is too high on {HOST.NAME}'),(1131,1,1528966876,2,13,'0','10.0.6.83',13915,'Power'),(1132,1,1528966876,2,13,'0','10.0.6.83',13916,'Power'),(1133,1,1528966876,2,13,'0','10.0.6.83',13917,'Response time is too high on {HOST.NAME}'),(1134,1,1528966876,2,13,'0','10.0.6.83',13918,'System Fan 2 Critical [{ITEM.VALUE}]'),(1135,1,1528966876,2,13,'0','10.0.6.83',13919,'System Fan 2 Non-Critical [{ITEM.VALUE}]'),(1136,1,1528966876,2,13,'0','10.0.6.83',13920,'System Fan 3 Critical [{ITEM.VALUE}]'),(1137,1,1528966876,2,13,'0','10.0.6.83',13921,'System Fan 3 Non-Critical [{ITEM.VALUE}]'),(1138,1,1528966876,2,13,'0','10.0.6.83',13922,'{HOST.NAME} is unavailable by ICMP'),(1139,1,1528966876,2,4,'0','10.0.6.83',10107,'compute node'),(1140,1,1528966876,2,4,'0','10.0.6.83',10108,'controller node'),(1141,1,1528966876,2,4,'0','10.0.6.83',10109,'dashboard'),(1142,1,1528966876,2,4,'0','10.0.6.83',10110,'haproxy'),(1143,1,1528966876,2,4,'0','10.0.6.83',10111,'lbaas'),(1144,1,1528966876,2,4,'0','10.0.6.83',10112,'memcache'),(1145,1,1528966876,2,4,'0','10.0.6.83',10113,'mysql'),(1146,1,1528966876,2,4,'0','10.0.6.83',10114,'novnc'),(1147,1,1528966876,2,4,'0','10.0.6.83',10115,'ntp'),(1148,1,1528966876,2,4,'0','10.0.6.83',10116,'rabbitmq'),(1149,1,1528966876,2,4,'0','10.0.6.83',10117,'Template App Ceph ProcessNum'),(1150,1,1528966876,2,4,'0','10.0.6.83',10118,'Template App Ceph State'),(1151,1,1528966876,2,4,'0','10.0.6.83',10119,'Template App IO State'),(1152,1,1528966876,2,4,'0','10.0.6.83',10120,'Template App MySQL'),(1153,1,1528966876,2,4,'0','10.0.6.83',10121,'Template App Openstack Compute ServiceExist'),(1154,1,1528966876,2,4,'0','10.0.6.83',10122,'Template App Openstack Controller ServiceExist'),(1155,1,1528966876,2,4,'0','10.0.6.83',10123,'Template App SSH Service'),(1156,1,1528966876,2,4,'0','10.0.6.83',10124,'Template App Zabbix Agent'),(1157,1,1528966876,2,4,'0','10.0.6.83',10125,'Template App Zabbix Proxy'),(1158,1,1528966876,2,4,'0','10.0.6.83',10126,'Template App Zabbix Server'),(1159,1,1528966876,2,4,'0','10.0.6.83',10127,'Template OS Linux - physical'),(1160,1,1528966876,2,4,'0','10.0.6.83',10128,'Template OS Windows'),(1161,1,1528966876,2,4,'0','10.0.6.83',10139,'Template ICMP Ping'),(1162,1,1528966876,2,4,'0','10.0.6.83',10140,'Template IPMI Intel SR1530'),(1163,1,1528966876,2,4,'0','10.0.6.83',10141,'Template IPMI Intel SR1630'),(1164,1,1528966876,2,4,'0','10.0.6.83',10142,'Template SNMP Disks'),(1165,1,1528966876,2,4,'0','10.0.6.83',10143,'Template SNMP Generic'),(1166,1,1528966876,2,4,'0','10.0.6.83',10144,'Template SNMP Interfaces'),(1167,1,1528966876,2,4,'0','10.0.6.83',10145,'Template SNMP Processors'),(1168,1,1528966876,2,4,'0','10.0.6.83',10146,'Template Virt VMware'),(1169,1,1528966876,2,4,'0','10.0.6.83',10147,'Template Virt VMware Guest'),(1170,1,1528966876,2,4,'0','10.0.6.83',10148,'Template Virt VMware Hypervisor'),(1171,1,1528966876,2,4,'0','10.0.6.83',10149,'Template SNMP Device'),(1172,1,1528966876,2,4,'0','10.0.6.83',10150,'Template SNMP OS Linux'),(1173,1,1528966876,2,4,'0','10.0.6.83',10151,'Template SNMP OS Windows'),(1174,1,1528966893,0,13,'0','10.0.6.83',13930,'%util on trigger'),(1175,1,1528966893,0,13,'0','10.0.6.83',13931,'await on trigger'),(1176,1,1528966893,0,13,'0','10.0.6.83',13932,'await on trigger（high）'),(1177,1,1528966893,0,13,'0','10.0.6.83',13933,'Ceph Pool fill trigger'),(1178,1,1528966893,0,13,'0','10.0.6.83',13934,'Ceph Pool fill trigger(high)'),(1179,1,1528966893,0,13,'0','10.0.6.83',13935,'Current Pending Sector on trigger'),(1180,1,1528966893,0,13,'0','10.0.6.83',13936,'Disk fill on trigger'),(1181,1,1528966893,0,13,'0','10.0.6.83',13937,'Disk fill on trigger （high）'),(1182,1,1528966893,0,13,'0','10.0.6.83',13938,'Hosts reachable trigger'),(1183,1,1528966893,0,13,'0','10.0.6.83',13939,'Network dropped packets on trigger'),(1184,1,1528966893,0,13,'0','10.0.6.83',13940,'Network errors packets on trigger'),(1185,1,1528966893,0,13,'0','10.0.6.83',13941,'Number of Monitors in state: outside quorum trigger(high)'),(1186,1,1528966893,0,13,'0','10.0.6.83',13942,'Number of OSDs in state: DOWN trigger'),(1187,1,1528966893,0,13,'0','10.0.6.83',13943,'Number of OSDs in state: IN trigger'),(1188,1,1528966893,0,13,'0','10.0.6.83',13944,'Number of OSDs in state: UP<Number of OSDs trigger'),(1189,1,1528966893,0,13,'0','10.0.6.83',13945,'Number of Placement Groups in state: active+clean <Number of Placement Groups trigger'),(1190,1,1528966893,0,13,'0','10.0.6.83',13946,'Number of Placement Groups in state: no service  trigger'),(1191,1,1528966893,0,13,'0','10.0.6.83',13947,'Number of Placement Groups in state: other trigger'),(1192,1,1528966893,0,13,'0','10.0.6.83',13948,'OS Disk list trigger'),(1193,1,1528966893,0,13,'0','10.0.6.83',13949,'Overall Ceph status error'),(1194,1,1528966893,0,13,'0','10.0.6.83',13950,'Overall Ceph status warning'),(1195,1,1528966893,0,13,'0','10.0.6.83',13951,'Raw Read Error Rate on trigger'),(1196,1,1528966893,0,13,'0','10.0.6.83',13952,'Reallocated Sector Ct on trigger'),(1197,1,1528966893,0,13,'0','10.0.6.83',13953,'SATA Disk list trigger'),(1198,1,1528966893,0,13,'0','10.0.6.83',13954,'SATA lifetime trigger'),(1199,1,1528966893,0,13,'0','10.0.6.83',13955,'SATA lifetime trigger(high)'),(1200,1,1528966893,0,13,'0','10.0.6.83',13956,'SSD Disk list trigger'),(1201,1,1528966893,0,13,'0','10.0.6.83',13957,'SSD lifetime trigger'),(1202,1,1528966893,0,13,'0','10.0.6.83',13958,'SSD lifetime trigger（high）'),(1203,1,1528966893,0,13,'0','10.0.6.83',13959,'svctm on trigger'),(1204,1,1528966893,0,13,'0','10.0.6.83',13960,'svctm on trigger(high)'),(1205,1,1528966893,0,13,'0','10.0.6.83',13961,'Total bytes fill trigger'),(1206,1,1528966893,0,13,'0','10.0.6.83',13962,'Total bytes fill trigger (high)'),(1207,1,1528966939,0,13,'0','10.0.6.83',13963,'/etc/passwd has been changed on {HOST.NAME}'),(1208,1,1528966939,0,13,'0','10.0.6.83',13964,'Baseboard Temp Critical [{ITEM.VALUE}]'),(1209,1,1528966939,0,13,'0','10.0.6.83',13965,'Baseboard Temp Non-Critical [{ITEM.VALUE}]'),(1210,1,1528966939,0,13,'0','10.0.6.83',13966,'BB +1.05V PCH Critical [{ITEM.VALUE}]'),(1211,1,1528966939,0,13,'0','10.0.6.83',13967,'BB +1.05V PCH Non-Critical [{ITEM.VALUE}]'),(1212,1,1528966939,0,13,'0','10.0.6.83',13968,'BB +1.1V P1 Vccp Critical [{ITEM.VALUE}]'),(1213,1,1528966939,0,13,'0','10.0.6.83',13969,'BB +1.1V P1 Vccp Non-Critical [{ITEM.VALUE}]'),(1214,1,1528966939,0,13,'0','10.0.6.83',13970,'BB +1.5V P1 DDR3 Critical [{ITEM.VALUE}]'),(1215,1,1528966939,0,13,'0','10.0.6.83',13971,'BB +1.5V P1 DDR3 Non-Critical [{ITEM.VALUE}]'),(1216,1,1528966939,0,13,'0','10.0.6.83',13972,'BB +1.8V SM Critical [{ITEM.VALUE}]'),(1217,1,1528966939,0,13,'0','10.0.6.83',13973,'BB +1.8V SM Non-Critical [{ITEM.VALUE}]'),(1218,1,1528966939,0,13,'0','10.0.6.83',13974,'BB +3.3V Critical [{ITEM.VALUE}]'),(1219,1,1528966939,0,13,'0','10.0.6.83',13975,'BB +3.3V Critical [{ITEM.VALUE}]'),(1220,1,1528966939,0,13,'0','10.0.6.83',13976,'BB +3.3V Non-Critical [{ITEM.VALUE}]'),(1221,1,1528966939,0,13,'0','10.0.6.83',13977,'BB +3.3V Non-Critical [{ITEM.VALUE}]'),(1222,1,1528966939,0,13,'0','10.0.6.83',13978,'BB +3.3V STBY Critical [{ITEM.VALUE}]'),(1223,1,1528966939,0,13,'0','10.0.6.83',13979,'BB +3.3V STBY Critical [{ITEM.VALUE}]'),(1224,1,1528966939,0,13,'0','10.0.6.83',13980,'BB +3.3V STBY Non-Critical [{ITEM.VALUE}]'),(1225,1,1528966939,0,13,'0','10.0.6.83',13981,'BB +3.3V STBY Non-Critical [{ITEM.VALUE}]'),(1226,1,1528966939,0,13,'0','10.0.6.83',13982,'BB +5.0V Critical [{ITEM.VALUE}]'),(1227,1,1528966939,0,13,'0','10.0.6.83',13983,'BB +5.0V Critical [{ITEM.VALUE}]'),(1228,1,1528966939,0,13,'0','10.0.6.83',13984,'BB +5.0V Non-Critical [{ITEM.VALUE}]'),(1229,1,1528966939,0,13,'0','10.0.6.83',13985,'BB +5.0V Non-Critical [{ITEM.VALUE}]'),(1230,1,1528966939,0,13,'0','10.0.6.83',13986,'BB Ambient Temp Critical [{ITEM.VALUE}]'),(1231,1,1528966939,0,13,'0','10.0.6.83',13987,'BB Ambient Temp Non-Critical [{ITEM.VALUE}]'),(1232,1,1528966939,0,13,'0','10.0.6.83',13988,'CEPH critical error'),(1233,1,1528966939,0,13,'0','10.0.6.83',13989,'CEPH warning'),(1234,1,1528966939,0,13,'0','10.0.6.83',13990,'Configured max number of opened files is too low on {HOST.NAME}'),(1235,1,1528966939,0,13,'0','10.0.6.83',13991,'Configured max number of processes is too low on {HOST.NAME}'),(1236,1,1528966939,0,13,'0','10.0.6.83',13992,'CPU interrupt time {HOST.NAME}'),(1237,1,1528966939,0,13,'0','10.0.6.83',13993,'Disk I/O is overloaded on {HOST.NAME}'),(1238,1,1528966939,0,13,'0','10.0.6.83',13994,'Front Panel Temp Critical [{ITEM.VALUE}]'),(1239,1,1528966939,0,13,'0','10.0.6.83',13995,'Front Panel Temp Non-Critical [{ITEM.VALUE}]'),(1240,1,1528966939,0,13,'0','10.0.6.83',13996,'Host information was changed on {HOST.NAME}'),(1241,1,1528966939,0,13,'0','10.0.6.83',13997,'Host information was changed on {HOST.NAME}'),(1242,1,1528966939,0,13,'0','10.0.6.83',13998,'Lack of available memory on server {HOST.NAME}'),(1243,1,1528966939,0,13,'0','10.0.6.83',13999,'Lack of free memory on server {HOST.NAME}'),(1244,1,1528966939,0,13,'0','10.0.6.83',14000,'Lack of free swap space on {HOST.NAME}'),(1245,1,1528966939,0,13,'0','10.0.6.83',14001,'Less than 5% free in the value cache'),(1246,1,1528966939,0,13,'0','10.0.6.83',14002,'Less than 25% free in the configuration cache'),(1247,1,1528966939,0,13,'0','10.0.6.83',14003,'Less than 25% free in the configuration cache'),(1248,1,1528966939,0,13,'0','10.0.6.83',14004,'Less than 25% free in the history cache'),(1249,1,1528966939,0,13,'0','10.0.6.83',14005,'Less than 25% free in the history cache'),(1250,1,1528966939,0,13,'0','10.0.6.83',14006,'Less than 25% free in the history index cache'),(1251,1,1528966939,0,13,'0','10.0.6.83',14007,'Less than 25% free in the text history cache'),(1252,1,1528966939,0,13,'0','10.0.6.83',14008,'Less than 25% free in the trends cache'),(1253,1,1528966939,0,13,'0','10.0.6.83',14009,'Less than 25% free in the vmware cache'),(1254,1,1528966939,0,13,'0','10.0.6.83',14010,'More than 100 items having missing data for more than 10 minutes'),(1255,1,1528966939,0,13,'0','10.0.6.83',14011,'More than 100 items having missing data for more than 10 minutes'),(1256,1,1528966939,0,13,'0','10.0.6.83',14012,'MySQL is down'),(1257,1,1528966939,0,13,'0','10.0.6.83',14013,'nova-novncproxy has  down'),(1258,1,1528966939,0,13,'0','10.0.6.83',14014,'openstack ceilometer-agent-notification has down'),(1259,1,1528966939,0,13,'0','10.0.6.83',14015,'openstack ceilometer-collector has down'),(1260,1,1528966939,0,13,'0','10.0.6.83',14016,'openstack ceilometer-polling has down'),(1261,1,1528966939,0,13,'0','10.0.6.83',14017,'openstack ceilometer-polling has down'),(1262,1,1528966939,0,13,'0','10.0.6.83',14018,'openstack cinder-api has down'),(1263,1,1528966939,0,13,'0','10.0.6.83',14019,'openstack cinder-scheduler has down'),(1264,1,1528966939,0,13,'0','10.0.6.83',14020,'openstack cinder-volume has down'),(1265,1,1528966939,0,13,'0','10.0.6.83',14021,'Openstack cinder process status'),(1266,1,1528966939,0,13,'0','10.0.6.83',14022,'Openstack compute service cinder volume'),(1267,1,1528966939,0,13,'0','10.0.6.83',14023,'Openstack compute service libvirtd'),(1268,1,1528966939,0,13,'0','10.0.6.83',14024,'Openstack compute service neutron l3 agent'),(1269,1,1528966939,0,13,'0','10.0.6.83',14025,'Openstack compute service neutron metadata agent'),(1270,1,1528966939,0,13,'0','10.0.6.83',14026,'Openstack compute service neutron openvswitch agent'),(1271,1,1528966939,0,13,'0','10.0.6.83',14027,'Openstack compute service nova compute'),(1272,1,1528966939,0,13,'0','10.0.6.83',14028,'openstack glance-api has down'),(1273,1,1528966939,0,13,'0','10.0.6.83',14029,'openstack glance-registry has down'),(1274,1,1528966939,0,13,'0','10.0.6.83',14030,'openstack httpd has down'),(1275,1,1528966939,0,13,'0','10.0.6.83',14031,'openstack httpd has down'),(1276,1,1528966939,0,13,'0','10.0.6.83',14032,'openstack libvirtd has down'),(1277,1,1528966939,0,13,'0','10.0.6.83',14033,'openstack memcached has down'),(1278,1,1528966939,0,13,'0','10.0.6.83',14034,'openstack mysqld has down'),(1279,1,1528966939,0,13,'0','10.0.6.83',14035,'openstack neutron-dhcp-agent has down'),(1280,1,1528966939,0,13,'0','10.0.6.83',14036,'openstack neutron-l3-agent has down'),(1281,1,1528966939,0,13,'0','10.0.6.83',14037,'openstack neutron-l3-agent has down'),(1282,1,1528966939,0,13,'0','10.0.6.83',14038,'openstack neutron-lbaasv2-agent has down'),(1283,1,1528966939,0,13,'0','10.0.6.83',14039,'openstack  neutron-metadata-agent has down'),(1284,1,1528966939,0,13,'0','10.0.6.83',14040,'openstack neutron-openvswitch-agent has down'),(1285,1,1528966939,0,13,'0','10.0.6.83',14041,'openstack neutron-openvswitch-agent has down'),(1286,1,1528966939,0,13,'0','10.0.6.83',14042,'openstack neutron-server has down'),(1287,1,1528966939,0,13,'0','10.0.6.83',14043,'Openstack neutron process status'),(1288,1,1528966939,0,13,'0','10.0.6.83',14044,'openstack nova-api has down'),(1289,1,1528966939,0,13,'0','10.0.6.83',14045,'openstack nova-cert has down'),(1290,1,1528966939,0,13,'0','10.0.6.83',14046,'openstack nova-compute has down'),(1291,1,1528966939,0,13,'0','10.0.6.83',14047,'openstack nova-conductor has down'),(1292,1,1528966939,0,13,'0','10.0.6.83',14048,'openstack nova-consoleauth has down'),(1293,1,1528966939,0,13,'0','10.0.6.83',14049,'openstack nova-novncproxy has down'),(1294,1,1528966939,0,13,'0','10.0.6.83',14050,'openstack nova-scheduler has down'),(1295,1,1528966939,0,13,'0','10.0.6.83',14051,'Openstack nova process status'),(1296,1,1528966939,0,13,'0','10.0.6.83',14052,'openstack ntpd has down'),(1297,1,1528966939,0,13,'0','10.0.6.83',14053,'openstack openvswitch has down'),(1298,1,1528966939,0,13,'0','10.0.6.83',14054,'openstack rabbitmq-server has down'),(1299,1,1528966939,0,13,'0','10.0.6.83',14055,'Openstack service haproxy has down'),(1300,1,1528966939,0,13,'0','10.0.6.83',14056,'Openstack service keepalived has down'),(1301,1,1528966939,0,13,'0','10.0.6.83',14057,'openstack xinetd has down'),(1302,1,1528966939,0,13,'0','10.0.6.83',14058,'Ping loss is too high on {HOST.NAME}'),(1303,1,1528966939,0,13,'0','10.0.6.83',14059,'Power'),(1304,1,1528966939,0,13,'0','10.0.6.83',14060,'Power'),(1305,1,1528966939,0,13,'0','10.0.6.83',14061,'Processor load is too high on(5min)  {HOST.NAME}'),(1306,1,1528966939,0,13,'0','10.0.6.83',14062,'Processor load is too high on (15min){HOST.NAME}'),(1307,1,1528966939,0,13,'0','10.0.6.83',14063,'Processor load is too high on {HOST.NAME}'),(1308,1,1528966939,0,13,'0','10.0.6.83',14064,'Processor load is too high on {HOST.NAME}'),(1309,1,1528966939,0,13,'0','10.0.6.83',14065,'Response time is too high on {HOST.NAME}'),(1310,1,1528966939,0,13,'0','10.0.6.83',14066,'SSH service is down on {HOST.NAME}'),(1311,1,1528966939,0,13,'0','10.0.6.83',14067,'System Fan 2 Critical [{ITEM.VALUE}]'),(1312,1,1528966939,0,13,'0','10.0.6.83',14068,'System Fan 2 Non-Critical [{ITEM.VALUE}]'),(1313,1,1528966939,0,13,'0','10.0.6.83',14069,'System Fan 3 Critical [{ITEM.VALUE}]'),(1314,1,1528966939,0,13,'0','10.0.6.83',14070,'System Fan 3 Non-Critical [{ITEM.VALUE}]'),(1315,1,1528966939,0,13,'0','10.0.6.83',14071,'Too many processes on {HOST.NAME}'),(1316,1,1528966939,0,13,'0','10.0.6.83',14072,'Zabbix agent on {HOST.NAME} is unreachable for 5 minutes'),(1317,1,1528966939,0,13,'0','10.0.6.83',14073,'Zabbix agent on {HOST.NAME} is unreachable for 5 minutes'),(1318,1,1528966939,0,13,'0','10.0.6.83',14074,'Zabbix agent on {HOST.NAME} is unreachable for 5 minutes'),(1319,1,1528966939,0,13,'0','10.0.6.83',14075,'Zabbix alerter processes more than 75% busy'),(1320,1,1528966939,0,13,'0','10.0.6.83',14076,'Zabbix configuration syncer processes more than 75% busy'),(1321,1,1528966939,0,13,'0','10.0.6.83',14077,'Zabbix configuration syncer processes more than 75% busy'),(1322,1,1528966939,0,13,'0','10.0.6.83',14078,'Zabbix data sender processes more than 75% busy'),(1323,1,1528966939,0,13,'0','10.0.6.83',14079,'Zabbix db watchdog processes more than 75% busy'),(1324,1,1528966939,0,13,'0','10.0.6.83',14080,'Zabbix discoverer processes more than 75% busy'),(1325,1,1528966939,0,13,'0','10.0.6.83',14081,'Zabbix discoverer processes more than 75% busy'),(1326,1,1528966939,0,13,'0','10.0.6.83',14082,'Zabbix escalator processes more than 75% busy'),(1327,1,1528966939,0,13,'0','10.0.6.83',14083,'Zabbix heartbeat sender processes more than 75% busy'),(1328,1,1528966939,0,13,'0','10.0.6.83',14084,'Zabbix history syncer processes more than 75% busy'),(1329,1,1528966939,0,13,'0','10.0.6.83',14085,'Zabbix history syncer processes more than 75% busy'),(1330,1,1528966939,0,13,'0','10.0.6.83',14086,'Zabbix housekeeper processes more than 75% busy'),(1331,1,1528966939,0,13,'0','10.0.6.83',14087,'Zabbix housekeeper processes more than 75% busy'),(1332,1,1528966939,0,13,'0','10.0.6.83',14088,'Zabbix http poller processes more than 75% busy'),(1333,1,1528966939,0,13,'0','10.0.6.83',14089,'Zabbix http poller processes more than 75% busy'),(1334,1,1528966939,0,13,'0','10.0.6.83',14090,'Zabbix icmp pinger processes more than 75% busy'),(1335,1,1528966939,0,13,'0','10.0.6.83',14091,'Zabbix icmp pinger processes more than 75% busy'),(1336,1,1528966939,0,13,'0','10.0.6.83',14092,'Zabbix ipmi poller processes more than 75% busy'),(1337,1,1528966939,0,13,'0','10.0.6.83',14093,'Zabbix ipmi poller processes more than 75% busy'),(1338,1,1528966939,0,13,'0','10.0.6.83',14094,'Zabbix java poller processes more than 75% busy'),(1339,1,1528966939,0,13,'0','10.0.6.83',14095,'Zabbix java poller processes more than 75% busy'),(1340,1,1528966939,0,13,'0','10.0.6.83',14096,'Zabbix poller processes more than 75% busy'),(1341,1,1528966939,0,13,'0','10.0.6.83',14097,'Zabbix poller processes more than 75% busy'),(1342,1,1528966939,0,13,'0','10.0.6.83',14098,'Zabbix proxy poller processes more than 75% busy'),(1343,1,1528966939,0,13,'0','10.0.6.83',14099,'Zabbix self-monitoring processes more than 75% busy'),(1344,1,1528966939,0,13,'0','10.0.6.83',14100,'Zabbix self-monitoring processes more than 75% busy'),(1345,1,1528966939,0,13,'0','10.0.6.83',14101,'Zabbix snmp trapper processes more than 75% busy'),(1346,1,1528966939,0,13,'0','10.0.6.83',14102,'Zabbix snmp trapper processes more than 75% busy'),(1347,1,1528966939,0,13,'0','10.0.6.83',14103,'Zabbix timer processes more than 75% busy'),(1348,1,1528966939,0,13,'0','10.0.6.83',14104,'Zabbix trapper processes more than 75% busy'),(1349,1,1528966939,0,13,'0','10.0.6.83',14105,'Zabbix trapper processes more than 75% busy'),(1350,1,1528966939,0,13,'0','10.0.6.83',14106,'Zabbix unreachable poller processes more than 75% busy'),(1351,1,1528966939,0,13,'0','10.0.6.83',14107,'Zabbix unreachable poller processes more than 75% busy'),(1352,1,1528966939,0,13,'0','10.0.6.83',14108,'Zabbix value cache working in low memory mode'),(1353,1,1528966939,0,13,'0','10.0.6.83',14109,'Zabbix vmware collector processes more than 75% busy'),(1354,1,1528966939,0,13,'0','10.0.6.83',14110,'{HOST.NAME} has just been restarted'),(1355,1,1528966939,0,13,'0','10.0.6.83',14111,'{HOST.NAME} has just been restarted'),(1356,1,1528966939,0,13,'0','10.0.6.83',14112,'{HOST.NAME} is unavailable by ICMP'),(1357,1,1528966940,0,31,'0','10.0.6.83',14113,'Free disk space is less than 20% on volume {#FSNAME}'),(1358,1,1528966940,0,31,'0','10.0.6.83',14114,'Free inodes is less than 20% on volume {#FSNAME}'),(1359,1,1528966940,0,31,'0','10.0.6.83',14115,'Free disk space is less than 20% on volume {#FSNAME}'),(1360,1,1528966940,0,31,'0','10.0.6.83',14116,'Free disk space is less than 20% on volume {#SNMPVALUE}'),(1361,1,1528966940,0,31,'0','10.0.6.83',14117,'Operational status was changed on {HOST.NAME} interface {#SNMPVALUE}'),(1362,1,1528966940,0,31,'0','10.0.6.83',14118,'Free disk space is less than 20% on volume {#SNMPVALUE}'),(1363,1,1528966940,0,31,'0','10.0.6.83',14119,'Free disk space is less than 20% on volume {#SNMPVALUE}'),(1364,1,1528966940,0,31,'0','10.0.6.83',14120,'Operational status was changed on {HOST.NAME} interface {#SNMPVALUE}'),(1365,1,1528966940,0,31,'0','10.0.6.83',14121,'Operational status was changed on {HOST.NAME} interface {#SNMPVALUE}'),(1366,1,1528966940,0,31,'0','10.0.6.83',14122,'Operational status was changed on {HOST.NAME} interface {#SNMPVALUE}'),(1367,1,1528967517,1,5,'Name: Auto registration:compute','10.0.6.83',0,''),(1368,1,1528967668,1,5,'Name: Auto registration:controller','10.0.6.83',0,''),(1369,1,1528967698,1,5,'Name: Auto registration:agent','10.0.6.83',0,''),(1370,1,1528967724,1,5,'Name: Auto registration:agent','10.0.6.83',0,''),(1371,1,1528967730,1,5,' Actions [10] enabled','10.0.6.83',0,''),(1372,1,1528967732,1,5,' Actions [9] enabled','10.0.6.83',0,''),(1373,1,1528967734,1,5,' Actions [8] enabled','10.0.6.83',0,''),(1374,1,1528967735,1,5,' Actions [8] disabled','10.0.6.83',0,''),(1375,1,1528967736,1,5,' Actions [9] disabled','10.0.6.83',0,''),(1376,1,1528967737,1,5,' Actions [10] disabled','10.0.6.83',0,''),(1377,1,1528967756,1,5,'Name: Auto registration:linux','10.0.6.83',0,''),(1378,1,1528968374,0,5,'Name: Auto registration:ceph','10.0.6.83',0,''),(1379,1,1528968595,1,5,'Name: Auto registration:ceph','10.0.6.83',0,''),(1380,1,1528968609,1,5,' Actions [9] enabled','10.0.6.83',0,''),(1381,1,1528968611,1,5,' Actions [8] enabled','10.0.6.83',0,''),(1382,1,1528968612,1,5,' Actions [10] enabled','10.0.6.83',0,''),(1383,1,1528968711,1,0,'User alias [Admin] name [Zabbix] surname [Administrator]','10.0.6.83',0,'');
/*!40000 ALTER TABLE `auditlog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auditlog_details`
--

DROP TABLE IF EXISTS `auditlog_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auditlog_details` (
  `auditdetailid` bigint(20) unsigned NOT NULL,
  `auditid` bigint(20) unsigned NOT NULL,
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `field_name` varchar(64) NOT NULL DEFAULT '',
  `oldvalue` text NOT NULL,
  `newvalue` text NOT NULL,
  PRIMARY KEY (`auditdetailid`),
  KEY `auditlog_details_1` (`auditid`),
  CONSTRAINT `c_auditlog_details_1` FOREIGN KEY (`auditid`) REFERENCES `auditlog` (`auditid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auditlog_details`
--

LOCK TABLES `auditlog_details` WRITE;
/*!40000 ALTER TABLE `auditlog_details` DISABLE KEYS */;
INSERT INTO `auditlog_details` VALUES (1,899,'items','status','0','1'),(2,900,'items','status','0','1'),(3,901,'items','status','0','1'),(4,902,'items','status','0','1'),(5,905,'','templateid','0','13848'),(6,906,'','templateid','0','13850'),(7,907,'','templateid','0','13852'),(8,908,'','status','0','1'),(9,908,'','templateid','0','13854'),(10,909,'','templateid','0','13855'),(11,910,'','templateid','0','13858'),(12,911,'','templateid','0','13860'),(13,912,'','templateid','0','13862'),(14,913,'','templateid','0','13864'),(15,914,'','templateid','0','13866'),(16,915,'','templateid','0','13868'),(17,916,'','templateid','0','13870'),(18,917,'','templateid','0','13871'),(19,918,'','templateid','0','13873'),(20,919,'','templateid','0','13875'),(21,920,'','templateid','0','13876'),(22,921,'','templateid','0','13878'),(23,922,'','templateid','0','13880'),(24,923,'','templateid','0','13882'),(25,924,'','templateid','0','13752'),(26,925,'','templateid','0','13740'),(27,926,'','templateid','0','13738'),(28,927,'','templateid','0','13881'),(29,928,'','templateid','0','13746'),(30,929,'','templateid','0','13742'),(31,930,'','templateid','0','13743'),(32,931,'','templateid','0','13745');
/*!40000 ALTER TABLE `auditlog_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `autoreg_host`
--

DROP TABLE IF EXISTS `autoreg_host`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `autoreg_host` (
  `autoreg_hostid` bigint(20) unsigned NOT NULL,
  `proxy_hostid` bigint(20) unsigned DEFAULT NULL,
  `host` varchar(64) NOT NULL DEFAULT '',
  `listen_ip` varchar(39) NOT NULL DEFAULT '',
  `listen_port` int(11) NOT NULL DEFAULT '0',
  `listen_dns` varchar(64) NOT NULL DEFAULT '',
  `host_metadata` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`autoreg_hostid`),
  KEY `autoreg_host_1` (`proxy_hostid`,`host`),
  CONSTRAINT `c_autoreg_host_1` FOREIGN KEY (`proxy_hostid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `autoreg_host`
--

LOCK TABLES `autoreg_host` WRITE;
/*!40000 ALTER TABLE `autoreg_host` DISABLE KEYS */;
/*!40000 ALTER TABLE `autoreg_host` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `conditions`
--

DROP TABLE IF EXISTS `conditions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `conditions` (
  `conditionid` bigint(20) unsigned NOT NULL,
  `actionid` bigint(20) unsigned NOT NULL,
  `conditiontype` int(11) NOT NULL DEFAULT '0',
  `operator` int(11) NOT NULL DEFAULT '0',
  `value` varchar(255) NOT NULL DEFAULT '',
  `value2` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`conditionid`),
  KEY `conditions_1` (`actionid`),
  CONSTRAINT `c_conditions_1` FOREIGN KEY (`actionid`) REFERENCES `actions` (`actionid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `conditions`
--

LOCK TABLES `conditions` WRITE;
/*!40000 ALTER TABLE `conditions` DISABLE KEYS */;
INSERT INTO `conditions` VALUES (2,2,10,0,'0',''),(3,2,8,0,'9',''),(4,2,12,2,'Linux',''),(5,3,16,7,'',''),(7,4,23,0,'0',''),(8,5,23,0,'2',''),(9,6,23,0,'4',''),(10,7,16,7,'',''),(12,8,24,2,'controller',''),(13,9,24,2,'compute',''),(14,10,22,2,'linux',''),(15,11,16,7,'',''),(17,12,16,7,'',''),(19,13,22,2,'ceph','');
/*!40000 ALTER TABLE `conditions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `config`
--

DROP TABLE IF EXISTS `config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `config` (
  `configid` bigint(20) unsigned NOT NULL,
  `refresh_unsupported` int(11) NOT NULL DEFAULT '0',
  `work_period` varchar(100) NOT NULL DEFAULT '1-5,00:00-24:00',
  `alert_usrgrpid` bigint(20) unsigned DEFAULT NULL,
  `event_ack_enable` int(11) NOT NULL DEFAULT '1',
  `event_expire` int(11) NOT NULL DEFAULT '7',
  `event_show_max` int(11) NOT NULL DEFAULT '100',
  `default_theme` varchar(128) NOT NULL DEFAULT 'blue-theme',
  `authentication_type` int(11) NOT NULL DEFAULT '0',
  `ldap_host` varchar(255) NOT NULL DEFAULT '',
  `ldap_port` int(11) NOT NULL DEFAULT '389',
  `ldap_base_dn` varchar(255) NOT NULL DEFAULT '',
  `ldap_bind_dn` varchar(255) NOT NULL DEFAULT '',
  `ldap_bind_password` varchar(128) NOT NULL DEFAULT '',
  `ldap_search_attribute` varchar(128) NOT NULL DEFAULT '',
  `dropdown_first_entry` int(11) NOT NULL DEFAULT '1',
  `dropdown_first_remember` int(11) NOT NULL DEFAULT '1',
  `discovery_groupid` bigint(20) unsigned NOT NULL,
  `max_in_table` int(11) NOT NULL DEFAULT '50',
  `search_limit` int(11) NOT NULL DEFAULT '1000',
  `severity_color_0` varchar(6) NOT NULL DEFAULT '97AAB3',
  `severity_color_1` varchar(6) NOT NULL DEFAULT '7499FF',
  `severity_color_2` varchar(6) NOT NULL DEFAULT 'FFC859',
  `severity_color_3` varchar(6) NOT NULL DEFAULT 'FFA059',
  `severity_color_4` varchar(6) NOT NULL DEFAULT 'E97659',
  `severity_color_5` varchar(6) NOT NULL DEFAULT 'E45959',
  `severity_name_0` varchar(32) NOT NULL DEFAULT 'Not classified',
  `severity_name_1` varchar(32) NOT NULL DEFAULT 'Information',
  `severity_name_2` varchar(32) NOT NULL DEFAULT 'Warning',
  `severity_name_3` varchar(32) NOT NULL DEFAULT 'Average',
  `severity_name_4` varchar(32) NOT NULL DEFAULT 'High',
  `severity_name_5` varchar(32) NOT NULL DEFAULT 'Disaster',
  `ok_period` int(11) NOT NULL DEFAULT '1800',
  `blink_period` int(11) NOT NULL DEFAULT '1800',
  `problem_unack_color` varchar(6) NOT NULL DEFAULT 'DC0000',
  `problem_ack_color` varchar(6) NOT NULL DEFAULT 'DC0000',
  `ok_unack_color` varchar(6) NOT NULL DEFAULT '00AA00',
  `ok_ack_color` varchar(6) NOT NULL DEFAULT '00AA00',
  `problem_unack_style` int(11) NOT NULL DEFAULT '1',
  `problem_ack_style` int(11) NOT NULL DEFAULT '1',
  `ok_unack_style` int(11) NOT NULL DEFAULT '1',
  `ok_ack_style` int(11) NOT NULL DEFAULT '1',
  `snmptrap_logging` int(11) NOT NULL DEFAULT '1',
  `server_check_interval` int(11) NOT NULL DEFAULT '10',
  `hk_events_mode` int(11) NOT NULL DEFAULT '1',
  `hk_events_trigger` int(11) NOT NULL DEFAULT '365',
  `hk_events_internal` int(11) NOT NULL DEFAULT '365',
  `hk_events_discovery` int(11) NOT NULL DEFAULT '365',
  `hk_events_autoreg` int(11) NOT NULL DEFAULT '365',
  `hk_services_mode` int(11) NOT NULL DEFAULT '1',
  `hk_services` int(11) NOT NULL DEFAULT '365',
  `hk_audit_mode` int(11) NOT NULL DEFAULT '1',
  `hk_audit` int(11) NOT NULL DEFAULT '365',
  `hk_sessions_mode` int(11) NOT NULL DEFAULT '1',
  `hk_sessions` int(11) NOT NULL DEFAULT '365',
  `hk_history_mode` int(11) NOT NULL DEFAULT '1',
  `hk_history_global` int(11) NOT NULL DEFAULT '0',
  `hk_history` int(11) NOT NULL DEFAULT '90',
  `hk_trends_mode` int(11) NOT NULL DEFAULT '1',
  `hk_trends_global` int(11) NOT NULL DEFAULT '0',
  `hk_trends` int(11) NOT NULL DEFAULT '365',
  `default_inventory_mode` int(11) NOT NULL DEFAULT '-1',
  PRIMARY KEY (`configid`),
  KEY `config_1` (`alert_usrgrpid`),
  KEY `config_2` (`discovery_groupid`),
  CONSTRAINT `c_config_1` FOREIGN KEY (`alert_usrgrpid`) REFERENCES `usrgrp` (`usrgrpid`),
  CONSTRAINT `c_config_2` FOREIGN KEY (`discovery_groupid`) REFERENCES `groups` (`groupid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `config`
--

LOCK TABLES `config` WRITE;
/*!40000 ALTER TABLE `config` DISABLE KEYS */;
INSERT INTO `config` VALUES (1,600,'1-5,09:00-18:00;',7,1,7,100,'blue-theme',0,'',389,'','','','',1,1,5,50,1000,'97AAB3','7499FF','FFC859','FFA059','E97659','E45959','Not classified','Information','Warning','Average','High','Disaster',1800,1800,'DC0000','DC0000','00AA00','00AA00',1,1,1,1,1,10,1,365,365,365,365,1,365,1,365,1,365,1,0,90,1,0,365,-1);
/*!40000 ALTER TABLE `config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `corr_condition`
--

DROP TABLE IF EXISTS `corr_condition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `corr_condition` (
  `corr_conditionid` bigint(20) unsigned NOT NULL,
  `correlationid` bigint(20) unsigned NOT NULL,
  `type` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`corr_conditionid`),
  KEY `corr_condition_1` (`correlationid`),
  CONSTRAINT `c_corr_condition_1` FOREIGN KEY (`correlationid`) REFERENCES `correlation` (`correlationid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `corr_condition`
--

LOCK TABLES `corr_condition` WRITE;
/*!40000 ALTER TABLE `corr_condition` DISABLE KEYS */;
/*!40000 ALTER TABLE `corr_condition` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `corr_condition_group`
--

DROP TABLE IF EXISTS `corr_condition_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `corr_condition_group` (
  `corr_conditionid` bigint(20) unsigned NOT NULL,
  `operator` int(11) NOT NULL DEFAULT '0',
  `groupid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`corr_conditionid`),
  KEY `corr_condition_group_1` (`groupid`),
  CONSTRAINT `c_corr_condition_group_1` FOREIGN KEY (`corr_conditionid`) REFERENCES `corr_condition` (`corr_conditionid`) ON DELETE CASCADE,
  CONSTRAINT `c_corr_condition_group_2` FOREIGN KEY (`groupid`) REFERENCES `groups` (`groupid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `corr_condition_group`
--

LOCK TABLES `corr_condition_group` WRITE;
/*!40000 ALTER TABLE `corr_condition_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `corr_condition_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `corr_condition_tag`
--

DROP TABLE IF EXISTS `corr_condition_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `corr_condition_tag` (
  `corr_conditionid` bigint(20) unsigned NOT NULL,
  `tag` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`corr_conditionid`),
  CONSTRAINT `c_corr_condition_tag_1` FOREIGN KEY (`corr_conditionid`) REFERENCES `corr_condition` (`corr_conditionid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `corr_condition_tag`
--

LOCK TABLES `corr_condition_tag` WRITE;
/*!40000 ALTER TABLE `corr_condition_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `corr_condition_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `corr_condition_tagpair`
--

DROP TABLE IF EXISTS `corr_condition_tagpair`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `corr_condition_tagpair` (
  `corr_conditionid` bigint(20) unsigned NOT NULL,
  `oldtag` varchar(255) NOT NULL DEFAULT '',
  `newtag` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`corr_conditionid`),
  CONSTRAINT `c_corr_condition_tagpair_1` FOREIGN KEY (`corr_conditionid`) REFERENCES `corr_condition` (`corr_conditionid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `corr_condition_tagpair`
--

LOCK TABLES `corr_condition_tagpair` WRITE;
/*!40000 ALTER TABLE `corr_condition_tagpair` DISABLE KEYS */;
/*!40000 ALTER TABLE `corr_condition_tagpair` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `corr_condition_tagvalue`
--

DROP TABLE IF EXISTS `corr_condition_tagvalue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `corr_condition_tagvalue` (
  `corr_conditionid` bigint(20) unsigned NOT NULL,
  `tag` varchar(255) NOT NULL DEFAULT '',
  `operator` int(11) NOT NULL DEFAULT '0',
  `value` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`corr_conditionid`),
  CONSTRAINT `c_corr_condition_tagvalue_1` FOREIGN KEY (`corr_conditionid`) REFERENCES `corr_condition` (`corr_conditionid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `corr_condition_tagvalue`
--

LOCK TABLES `corr_condition_tagvalue` WRITE;
/*!40000 ALTER TABLE `corr_condition_tagvalue` DISABLE KEYS */;
/*!40000 ALTER TABLE `corr_condition_tagvalue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `corr_operation`
--

DROP TABLE IF EXISTS `corr_operation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `corr_operation` (
  `corr_operationid` bigint(20) unsigned NOT NULL,
  `correlationid` bigint(20) unsigned NOT NULL,
  `type` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`corr_operationid`),
  KEY `corr_operation_1` (`correlationid`),
  CONSTRAINT `c_corr_operation_1` FOREIGN KEY (`correlationid`) REFERENCES `correlation` (`correlationid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `corr_operation`
--

LOCK TABLES `corr_operation` WRITE;
/*!40000 ALTER TABLE `corr_operation` DISABLE KEYS */;
/*!40000 ALTER TABLE `corr_operation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `correlation`
--

DROP TABLE IF EXISTS `correlation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `correlation` (
  `correlationid` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  `evaltype` int(11) NOT NULL DEFAULT '0',
  `status` int(11) NOT NULL DEFAULT '0',
  `formula` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`correlationid`),
  UNIQUE KEY `correlation_2` (`name`),
  KEY `correlation_1` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `correlation`
--

LOCK TABLES `correlation` WRITE;
/*!40000 ALTER TABLE `correlation` DISABLE KEYS */;
/*!40000 ALTER TABLE `correlation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dbversion`
--

DROP TABLE IF EXISTS `dbversion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dbversion` (
  `mandatory` int(11) NOT NULL DEFAULT '0',
  `optional` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dbversion`
--

LOCK TABLES `dbversion` WRITE;
/*!40000 ALTER TABLE `dbversion` DISABLE KEYS */;
INSERT INTO `dbversion` VALUES (3020000,3020001);
/*!40000 ALTER TABLE `dbversion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dchecks`
--

DROP TABLE IF EXISTS `dchecks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dchecks` (
  `dcheckid` bigint(20) unsigned NOT NULL,
  `druleid` bigint(20) unsigned NOT NULL,
  `type` int(11) NOT NULL DEFAULT '0',
  `key_` varchar(255) NOT NULL DEFAULT '',
  `snmp_community` varchar(255) NOT NULL DEFAULT '',
  `ports` varchar(255) NOT NULL DEFAULT '0',
  `snmpv3_securityname` varchar(64) NOT NULL DEFAULT '',
  `snmpv3_securitylevel` int(11) NOT NULL DEFAULT '0',
  `snmpv3_authpassphrase` varchar(64) NOT NULL DEFAULT '',
  `snmpv3_privpassphrase` varchar(64) NOT NULL DEFAULT '',
  `uniq` int(11) NOT NULL DEFAULT '0',
  `snmpv3_authprotocol` int(11) NOT NULL DEFAULT '0',
  `snmpv3_privprotocol` int(11) NOT NULL DEFAULT '0',
  `snmpv3_contextname` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`dcheckid`),
  KEY `dchecks_1` (`druleid`),
  CONSTRAINT `c_dchecks_1` FOREIGN KEY (`druleid`) REFERENCES `drules` (`druleid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dchecks`
--

LOCK TABLES `dchecks` WRITE;
/*!40000 ALTER TABLE `dchecks` DISABLE KEYS */;
INSERT INTO `dchecks` VALUES (2,2,9,'system.uname','','10050','',0,'','',0,0,0,'');
/*!40000 ALTER TABLE `dchecks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dhosts`
--

DROP TABLE IF EXISTS `dhosts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dhosts` (
  `dhostid` bigint(20) unsigned NOT NULL,
  `druleid` bigint(20) unsigned NOT NULL,
  `status` int(11) NOT NULL DEFAULT '0',
  `lastup` int(11) NOT NULL DEFAULT '0',
  `lastdown` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`dhostid`),
  KEY `dhosts_1` (`druleid`),
  CONSTRAINT `c_dhosts_1` FOREIGN KEY (`druleid`) REFERENCES `drules` (`druleid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dhosts`
--

LOCK TABLES `dhosts` WRITE;
/*!40000 ALTER TABLE `dhosts` DISABLE KEYS */;
/*!40000 ALTER TABLE `dhosts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `drules`
--

DROP TABLE IF EXISTS `drules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `drules` (
  `druleid` bigint(20) unsigned NOT NULL,
  `proxy_hostid` bigint(20) unsigned DEFAULT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `iprange` varchar(2048) NOT NULL DEFAULT '',
  `delay` int(11) NOT NULL DEFAULT '3600',
  `nextcheck` int(11) NOT NULL DEFAULT '0',
  `status` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`druleid`),
  UNIQUE KEY `drules_2` (`name`),
  KEY `drules_1` (`proxy_hostid`),
  CONSTRAINT `c_drules_1` FOREIGN KEY (`proxy_hostid`) REFERENCES `hosts` (`hostid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `drules`
--

LOCK TABLES `drules` WRITE;
/*!40000 ALTER TABLE `drules` DISABLE KEYS */;
INSERT INTO `drules` VALUES (2,NULL,'Local network','192.168.0.1-254',3600,0,1);
/*!40000 ALTER TABLE `drules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dservices`
--

DROP TABLE IF EXISTS `dservices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dservices` (
  `dserviceid` bigint(20) unsigned NOT NULL,
  `dhostid` bigint(20) unsigned NOT NULL,
  `type` int(11) NOT NULL DEFAULT '0',
  `key_` varchar(255) NOT NULL DEFAULT '',
  `value` varchar(255) NOT NULL DEFAULT '',
  `port` int(11) NOT NULL DEFAULT '0',
  `status` int(11) NOT NULL DEFAULT '0',
  `lastup` int(11) NOT NULL DEFAULT '0',
  `lastdown` int(11) NOT NULL DEFAULT '0',
  `dcheckid` bigint(20) unsigned NOT NULL,
  `ip` varchar(39) NOT NULL DEFAULT '',
  `dns` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`dserviceid`),
  UNIQUE KEY `dservices_1` (`dcheckid`,`type`,`key_`,`ip`,`port`),
  KEY `dservices_2` (`dhostid`),
  CONSTRAINT `c_dservices_1` FOREIGN KEY (`dhostid`) REFERENCES `dhosts` (`dhostid`) ON DELETE CASCADE,
  CONSTRAINT `c_dservices_2` FOREIGN KEY (`dcheckid`) REFERENCES `dchecks` (`dcheckid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dservices`
--

LOCK TABLES `dservices` WRITE;
/*!40000 ALTER TABLE `dservices` DISABLE KEYS */;
/*!40000 ALTER TABLE `dservices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `escalations`
--

DROP TABLE IF EXISTS `escalations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `escalations` (
  `escalationid` bigint(20) unsigned NOT NULL,
  `actionid` bigint(20) unsigned NOT NULL,
  `triggerid` bigint(20) unsigned DEFAULT NULL,
  `eventid` bigint(20) unsigned DEFAULT NULL,
  `r_eventid` bigint(20) unsigned DEFAULT NULL,
  `nextcheck` int(11) NOT NULL DEFAULT '0',
  `esc_step` int(11) NOT NULL DEFAULT '0',
  `status` int(11) NOT NULL DEFAULT '0',
  `itemid` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`escalationid`),
  UNIQUE KEY `escalations_1` (`actionid`,`triggerid`,`itemid`,`escalationid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `escalations`
--

LOCK TABLES `escalations` WRITE;
/*!40000 ALTER TABLE `escalations` DISABLE KEYS */;
/*!40000 ALTER TABLE `escalations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event_recovery`
--

DROP TABLE IF EXISTS `event_recovery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event_recovery` (
  `eventid` bigint(20) unsigned NOT NULL,
  `r_eventid` bigint(20) unsigned NOT NULL,
  `c_eventid` bigint(20) unsigned DEFAULT NULL,
  `correlationid` bigint(20) unsigned DEFAULT NULL,
  `userid` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`eventid`),
  KEY `event_recovery_1` (`r_eventid`),
  KEY `event_recovery_2` (`c_eventid`),
  CONSTRAINT `c_event_recovery_1` FOREIGN KEY (`eventid`) REFERENCES `events` (`eventid`) ON DELETE CASCADE,
  CONSTRAINT `c_event_recovery_2` FOREIGN KEY (`r_eventid`) REFERENCES `events` (`eventid`) ON DELETE CASCADE,
  CONSTRAINT `c_event_recovery_3` FOREIGN KEY (`c_eventid`) REFERENCES `events` (`eventid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event_recovery`
--

LOCK TABLES `event_recovery` WRITE;
/*!40000 ALTER TABLE `event_recovery` DISABLE KEYS */;
/*!40000 ALTER TABLE `event_recovery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event_tag`
--

DROP TABLE IF EXISTS `event_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event_tag` (
  `eventtagid` bigint(20) unsigned NOT NULL,
  `eventid` bigint(20) unsigned NOT NULL,
  `tag` varchar(255) NOT NULL DEFAULT '',
  `value` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`eventtagid`),
  KEY `event_tag_1` (`eventid`),
  CONSTRAINT `c_event_tag_1` FOREIGN KEY (`eventid`) REFERENCES `events` (`eventid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event_tag`
--

LOCK TABLES `event_tag` WRITE;
/*!40000 ALTER TABLE `event_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `event_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `events`
--

DROP TABLE IF EXISTS `events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `events` (
  `eventid` bigint(20) unsigned NOT NULL,
  `source` int(11) NOT NULL DEFAULT '0',
  `object` int(11) NOT NULL DEFAULT '0',
  `objectid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `clock` int(11) NOT NULL DEFAULT '0',
  `value` int(11) NOT NULL DEFAULT '0',
  `acknowledged` int(11) NOT NULL DEFAULT '0',
  `ns` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`eventid`),
  KEY `events_1` (`source`,`object`,`objectid`,`clock`),
  KEY `events_2` (`source`,`object`,`clock`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `events`
--

LOCK TABLES `events` WRITE;
/*!40000 ALTER TABLE `events` DISABLE KEYS */;
/*!40000 ALTER TABLE `events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `expressions`
--

DROP TABLE IF EXISTS `expressions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `expressions` (
  `expressionid` bigint(20) unsigned NOT NULL,
  `regexpid` bigint(20) unsigned NOT NULL,
  `expression` varchar(255) NOT NULL DEFAULT '',
  `expression_type` int(11) NOT NULL DEFAULT '0',
  `exp_delimiter` varchar(1) NOT NULL DEFAULT '',
  `case_sensitive` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`expressionid`),
  KEY `expressions_1` (`regexpid`),
  CONSTRAINT `c_expressions_1` FOREIGN KEY (`regexpid`) REFERENCES `regexps` (`regexpid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `expressions`
--

LOCK TABLES `expressions` WRITE;
/*!40000 ALTER TABLE `expressions` DISABLE KEYS */;
INSERT INTO `expressions` VALUES (1,1,'^(btrfs|ext2|ext3|ext4|jfs|reiser|xfs|ffs|ufs|jfs|jfs2|vxfs|hfs|refs|ntfs|fat32|zfs)$',3,',',0),(2,2,'^lo$',4,',',1),(3,3,'^(Physical memory|Virtual memory|Memory buffers|Cached memory|Swap space)$',4,',',1),(4,2,'^Software Loopback Interface',4,',',1);
/*!40000 ALTER TABLE `expressions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `functions`
--

DROP TABLE IF EXISTS `functions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `functions` (
  `functionid` bigint(20) unsigned NOT NULL,
  `itemid` bigint(20) unsigned NOT NULL,
  `triggerid` bigint(20) unsigned NOT NULL,
  `function` varchar(12) NOT NULL DEFAULT '',
  `parameter` varchar(255) NOT NULL DEFAULT '0',
  PRIMARY KEY (`functionid`),
  KEY `functions_1` (`triggerid`),
  KEY `functions_2` (`itemid`,`function`,`parameter`),
  CONSTRAINT `c_functions_1` FOREIGN KEY (`itemid`) REFERENCES `items` (`itemid`) ON DELETE CASCADE,
  CONSTRAINT `c_functions_2` FOREIGN KEY (`triggerid`) REFERENCES `triggers` (`triggerid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `functions`
--

LOCK TABLES `functions` WRITE;
/*!40000 ALTER TABLE `functions` DISABLE KEYS */;
INSERT INTO `functions` VALUES (12648,23620,13075,'min','10m'),(12895,23271,13486,'min','10m'),(12896,23273,13487,'min','10m'),(12897,23274,13488,'min','10m'),(12898,23275,13489,'min','10m'),(12899,23276,13490,'min','10m'),(12900,23287,13491,'nodata','5m'),(12902,23289,13493,'last','0'),(12903,23290,13494,'last','0'),(12908,23307,13499,'diff','0'),(12909,23310,13500,'last','0'),(12910,23312,13501,'diff','0'),(12911,23313,13502,'change','0'),(12912,23315,13503,'diff','0'),(12913,23316,13504,'last','0'),(12914,23282,13505,'last','0'),(12915,23284,13506,'last','0'),(12928,23288,13492,'diff','0'),(12938,23327,13509,'diff','0'),(12966,23635,13537,'min','10m'),(13030,23266,13481,'min','10m'),(13079,23296,13497,'avg','5m'),(13081,23301,13498,'avg','5m'),(13083,23292,13496,'avg','5m'),(13085,23291,13495,'avg','5m'),(13100,23252,13467,'avg','10m'),(13102,23253,13468,'avg','10m'),(13104,23254,13469,'avg','10m'),(13106,23255,13470,'avg','10m'),(13108,23256,13471,'avg','10m'),(13110,23257,13472,'avg','10m'),(13112,23258,13473,'avg','30m'),(13114,23259,13474,'avg','10m'),(13116,23260,13475,'avg','10m'),(13118,23261,13476,'avg','10m'),(13120,23262,13477,'avg','10m'),(13124,23264,13479,'avg','10m'),(13126,23265,13480,'avg','10m'),(13128,23267,13482,'avg','10m'),(13130,23268,13483,'avg','10m'),(13132,23269,13484,'avg','10m'),(13134,23270,13485,'avg','10m'),(13136,23328,13436,'avg','10m'),(13161,23662,13558,'last',''),(13552,24900,13930,'last',''),(13553,24884,13931,'last',''),(13554,24884,13932,'last',''),(13555,24928,13933,'last',''),(13556,24928,13934,'last',''),(13557,24887,13935,'last',''),(13558,24885,13936,'last',''),(13559,24885,13937,'last',''),(13560,24907,13938,'last',''),(13561,24908,13939,'last',''),(13562,24909,13940,'last',''),(13563,24912,13941,'last',''),(13564,24915,13942,'last',''),(13565,24916,13943,'last',''),(13566,24914,13943,'last',''),(13567,24917,13944,'last',''),(13568,24914,13944,'last',''),(13569,24920,13945,'last',''),(13570,24918,13945,'last',''),(13571,24921,13946,'last',''),(13572,24919,13947,'last',''),(13573,24899,13948,'diff','0'),(13574,24925,13949,'str','HEALTH_ERR'),(13575,24925,13950,'str','HEALTH_WARN'),(13576,24888,13951,'last',''),(13577,24891,13952,'last',''),(13578,24894,13953,'diff','0'),(13579,24895,13954,'last',''),(13580,24895,13955,'last',''),(13581,24896,13956,'diff','0'),(13582,24897,13957,'last',''),(13583,24897,13958,'last',''),(13584,24898,13959,'last',''),(13585,24898,13960,'last',''),(13586,25043,13961,'last',''),(13587,25043,13962,'last',''),(13588,25218,13963,'diff','0'),(13589,25183,13964,'last','0'),(13590,25183,13965,'last','0'),(13591,25184,13966,'last','0'),(13592,25184,13967,'last','0'),(13593,25185,13968,'last','0'),(13594,25185,13969,'last','0'),(13595,25186,13970,'last','0'),(13596,25186,13971,'last','0'),(13597,25175,13972,'last','0'),(13598,25175,13973,'last','0'),(13599,25176,13974,'last','0'),(13600,25187,13975,'last','0'),(13601,25176,13976,'last','0'),(13602,25187,13977,'last','0'),(13603,25177,13978,'last','0'),(13604,25188,13979,'last','0'),(13605,25177,13980,'last','0'),(13606,25188,13981,'last','0'),(13607,25178,13982,'last','0'),(13608,25189,13983,'last','0'),(13609,25178,13984,'last','0'),(13610,25189,13985,'last','0'),(13611,25179,13986,'last','0'),(13612,25179,13987,'last','0'),(13613,25093,13988,'last',''),(13614,25093,13989,'last',''),(13615,25195,13990,'last','0'),(13616,25196,13991,'last','0'),(13617,25207,13992,'avg','5m'),(13618,25208,13993,'avg','5m'),(13619,25190,13994,'last','0'),(13620,25190,13995,'last','0'),(13621,25215,13996,'diff','0'),(13622,25233,13997,'diff','0'),(13623,25219,13998,'last','0'),(13624,25235,13999,'last','0'),(13625,25231,14000,'last','0'),(13626,25163,14001,'min','10m'),(13627,25136,14002,'min','10m'),(13628,25162,14003,'min','10m'),(13629,25137,14004,'min','10m'),(13630,25168,14005,'min','10m'),(13631,25169,14006,'min','10m'),(13632,25138,14007,'min','10m'),(13633,25170,14008,'min','10m'),(13634,25167,14009,'min','10m'),(13635,25134,14010,'min','10m'),(13636,25160,14011,'min','10m'),(13637,25094,14012,'last','0'),(13638,25072,14013,'last',''),(13639,25063,14014,'last',''),(13640,25062,14015,'last',''),(13641,25055,14016,'last',''),(13642,25061,14017,'last',''),(13643,25064,14018,'last',''),(13644,25065,14019,'last',''),(13645,25056,14020,'last',''),(13646,25114,14021,'strlen',''),(13647,25112,14022,'last',''),(13648,25108,14023,'last',''),(13649,25109,14024,'last',''),(13650,25110,14025,'last',''),(13651,25111,14026,'last',''),(13652,25113,14027,'last',''),(13653,25066,14028,'last',''),(13654,25067,14029,'last',''),(13655,25059,14030,'last',''),(13656,25074,14031,'last',''),(13657,25050,14032,'last',''),(13658,25080,14033,'last',''),(13659,25081,14034,'last',''),(13660,25051,14035,'last',''),(13661,25052,14036,'last',''),(13662,25077,14037,'last',''),(13663,25078,14038,'last',''),(13664,25053,14039,'last',''),(13665,25054,14040,'last',''),(13666,25079,14041,'last',''),(13667,25060,14042,'last',''),(13668,25115,14043,'strlen',''),(13669,25068,14044,'last',''),(13670,25069,14045,'last',''),(13671,25057,14046,'last',''),(13672,25070,14047,'last',''),(13673,25071,14048,'last',''),(13674,25083,14049,'last',''),(13675,25073,14050,'last',''),(13676,25116,14051,'strlen',''),(13677,25084,14052,'last',''),(13678,25058,14053,'last',''),(13679,25085,14054,'last',''),(13680,25075,14055,'last',''),(13681,25076,14056,'last',''),(13682,25082,14057,'last',''),(13683,25173,14058,'min','5m'),(13684,25180,14059,'last','0'),(13685,25191,14060,'last','0'),(13686,25202,14061,'avg','5m'),(13687,25203,14062,'avg','5m'),(13688,25201,14063,'avg','5m'),(13689,25228,14064,'avg','5m'),(13690,25174,14065,'avg','5m'),(13691,25117,14066,'max','#3'),(13692,25192,14067,'last','0'),(13693,25192,14068,'last','0'),(13694,25193,14069,'last','0'),(13695,25193,14070,'last','0'),(13696,25227,14071,'avg','5m'),(13697,25118,14072,'nodata','5m'),(13698,25194,14073,'nodata','5m'),(13699,25221,14074,'nodata','5m'),(13700,25141,14075,'avg','10m'),(13701,25119,14076,'avg','10m'),(13702,25142,14077,'avg','10m'),(13703,25120,14078,'avg','10m'),(13704,25143,14079,'avg','10m'),(13705,25121,14080,'avg','10m'),(13706,25144,14081,'avg','10m'),(13707,25145,14082,'avg','10m'),(13708,25122,14083,'avg','10m'),(13709,25123,14084,'avg','10m'),(13710,25146,14085,'avg','10m'),(13711,25124,14086,'avg','30m'),(13712,25147,14087,'avg','30m'),(13713,25125,14088,'avg','10m'),(13714,25148,14089,'avg','10m'),(13715,25126,14090,'avg','10m'),(13716,25149,14091,'avg','10m'),(13717,25127,14092,'avg','10m'),(13718,25150,14093,'avg','10m'),(13719,25128,14094,'avg','10m'),(13720,25151,14095,'avg','10m'),(13721,25129,14096,'avg','10m'),(13722,25152,14097,'avg','10m'),(13723,25153,14098,'avg','10m'),(13724,25130,14099,'avg','10m'),(13725,25154,14100,'min','10m'),(13726,25131,14101,'avg','10m'),(13727,25155,14102,'avg','10m'),(13728,25156,14103,'avg','10m'),(13729,25132,14104,'avg','10m'),(13730,25157,14105,'avg','10m'),(13731,25133,14106,'avg','10m'),(13732,25158,14107,'avg','10m'),(13733,25166,14108,'last',''),(13734,25159,14109,'avg','10m'),(13735,25216,14110,'change','0'),(13736,25234,14111,'change','0'),(13737,25172,14112,'max','#3'),(13738,25339,14113,'last','0'),(13739,25337,14114,'last','0'),(13740,25345,14115,'last','0'),(13741,25353,14116,'last','0'),(13742,25351,14116,'last','0'),(13743,25359,14117,'diff','0'),(13744,25393,14118,'last','0'),(13745,25391,14118,'last','0'),(13746,25408,14119,'last','0'),(13747,25406,14119,'last','0'),(13748,25385,14120,'diff','0'),(13749,25399,14121,'diff','0'),(13750,25414,14122,'diff','0');
/*!40000 ALTER TABLE `functions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `globalmacro`
--

DROP TABLE IF EXISTS `globalmacro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `globalmacro` (
  `globalmacroid` bigint(20) unsigned NOT NULL,
  `macro` varchar(255) NOT NULL DEFAULT '',
  `value` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`globalmacroid`),
  UNIQUE KEY `globalmacro_1` (`macro`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `globalmacro`
--

LOCK TABLES `globalmacro` WRITE;
/*!40000 ALTER TABLE `globalmacro` DISABLE KEYS */;
INSERT INTO `globalmacro` VALUES (2,'{$SNMP_COMMUNITY}','public');
/*!40000 ALTER TABLE `globalmacro` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `globalvars`
--

DROP TABLE IF EXISTS `globalvars`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `globalvars` (
  `globalvarid` bigint(20) unsigned NOT NULL,
  `snmp_lastsize` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`globalvarid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `globalvars`
--

LOCK TABLES `globalvars` WRITE;
/*!40000 ALTER TABLE `globalvars` DISABLE KEYS */;
/*!40000 ALTER TABLE `globalvars` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `graph_discovery`
--

DROP TABLE IF EXISTS `graph_discovery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `graph_discovery` (
  `graphid` bigint(20) unsigned NOT NULL,
  `parent_graphid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`graphid`),
  KEY `graph_discovery_1` (`parent_graphid`),
  CONSTRAINT `c_graph_discovery_1` FOREIGN KEY (`graphid`) REFERENCES `graphs` (`graphid`) ON DELETE CASCADE,
  CONSTRAINT `c_graph_discovery_2` FOREIGN KEY (`parent_graphid`) REFERENCES `graphs` (`graphid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `graph_discovery`
--

LOCK TABLES `graph_discovery` WRITE;
/*!40000 ALTER TABLE `graph_discovery` DISABLE KEYS */;
/*!40000 ALTER TABLE `graph_discovery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `graph_theme`
--

DROP TABLE IF EXISTS `graph_theme`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `graph_theme` (
  `graphthemeid` bigint(20) unsigned NOT NULL,
  `theme` varchar(64) NOT NULL DEFAULT '',
  `backgroundcolor` varchar(6) NOT NULL DEFAULT '',
  `graphcolor` varchar(6) NOT NULL DEFAULT '',
  `gridcolor` varchar(6) NOT NULL DEFAULT '',
  `maingridcolor` varchar(6) NOT NULL DEFAULT '',
  `gridbordercolor` varchar(6) NOT NULL DEFAULT '',
  `textcolor` varchar(6) NOT NULL DEFAULT '',
  `highlightcolor` varchar(6) NOT NULL DEFAULT '',
  `leftpercentilecolor` varchar(6) NOT NULL DEFAULT '',
  `rightpercentilecolor` varchar(6) NOT NULL DEFAULT '',
  `nonworktimecolor` varchar(6) NOT NULL DEFAULT '',
  PRIMARY KEY (`graphthemeid`),
  UNIQUE KEY `graph_theme_1` (`theme`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `graph_theme`
--

LOCK TABLES `graph_theme` WRITE;
/*!40000 ALTER TABLE `graph_theme` DISABLE KEYS */;
INSERT INTO `graph_theme` VALUES (1,'blue-theme','FFFFFF','FFFFFF','CCD5D9','ACBBC2','ACBBC2','1F2C33','E33734','429E47','E33734','EBEBEB'),(2,'dark-theme','2B2B2B','2B2B2B','454545','4F4F4F','4F4F4F','F2F2F2','E45959','59DB8F','E45959','333333');
/*!40000 ALTER TABLE `graph_theme` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `graphs`
--

DROP TABLE IF EXISTS `graphs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `graphs` (
  `graphid` bigint(20) unsigned NOT NULL,
  `name` varchar(128) NOT NULL DEFAULT '',
  `width` int(11) NOT NULL DEFAULT '900',
  `height` int(11) NOT NULL DEFAULT '200',
  `yaxismin` double(16,4) NOT NULL DEFAULT '0.0000',
  `yaxismax` double(16,4) NOT NULL DEFAULT '100.0000',
  `templateid` bigint(20) unsigned DEFAULT NULL,
  `show_work_period` int(11) NOT NULL DEFAULT '1',
  `show_triggers` int(11) NOT NULL DEFAULT '1',
  `graphtype` int(11) NOT NULL DEFAULT '0',
  `show_legend` int(11) NOT NULL DEFAULT '1',
  `show_3d` int(11) NOT NULL DEFAULT '0',
  `percent_left` double(16,4) NOT NULL DEFAULT '0.0000',
  `percent_right` double(16,4) NOT NULL DEFAULT '0.0000',
  `ymin_type` int(11) NOT NULL DEFAULT '0',
  `ymax_type` int(11) NOT NULL DEFAULT '0',
  `ymin_itemid` bigint(20) unsigned DEFAULT NULL,
  `ymax_itemid` bigint(20) unsigned DEFAULT NULL,
  `flags` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`graphid`),
  KEY `graphs_1` (`name`),
  KEY `graphs_2` (`templateid`),
  KEY `graphs_3` (`ymin_itemid`),
  KEY `graphs_4` (`ymax_itemid`),
  CONSTRAINT `c_graphs_1` FOREIGN KEY (`templateid`) REFERENCES `graphs` (`graphid`) ON DELETE CASCADE,
  CONSTRAINT `c_graphs_2` FOREIGN KEY (`ymin_itemid`) REFERENCES `items` (`itemid`),
  CONSTRAINT `c_graphs_3` FOREIGN KEY (`ymax_itemid`) REFERENCES `items` (`itemid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `graphs`
--

LOCK TABLES `graphs` WRITE;
/*!40000 ALTER TABLE `graphs` DISABLE KEYS */;
INSERT INTO `graphs` VALUES (517,'Zabbix internal process busy %',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(518,'Zabbix data gathering process busy %',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(519,'Zabbix server performance',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(520,'Zabbix cache usage, % free',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(521,'Network traffic on {#IFNAME}',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,0,NULL,NULL,2),(522,'Disk space usage {#FSNAME}',600,340,0.0000,100.0000,NULL,0,0,2,1,1,0.0000,0.0000,0,0,NULL,NULL,2),(523,'CPU jumps',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(524,'CPU load',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,0,NULL,NULL,0),(525,'CPU utilization',900,200,0.0000,100.0000,NULL,1,0,1,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(526,'Swap usage',600,340,0.0000,100.0000,NULL,0,0,2,1,1,0.0000,0.0000,0,0,NULL,NULL,0),(528,'Value cache effectiveness',900,200,0.0000,100.0000,NULL,1,1,1,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(534,'Memory usage',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,2,NULL,23317,0),(667,'IO_asu on {#DISK_NAME}',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,2),(668,'Network traffic on {#IFNAME}',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,0,NULL,NULL,2),(669,'Disk space usage {#FSNAME}',600,340,0.0000,100.0000,NULL,0,0,2,1,1,0.0000,0.0000,0,0,NULL,NULL,2),(670,'Network traffic on {#IFNAME}',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,0,NULL,NULL,2),(671,'Disk space usage {#FSNAME}',600,340,0.0000,100.0000,NULL,0,0,2,1,1,0.0000,0.0000,0,0,NULL,NULL,2),(672,'Disk space usage {#SNMPVALUE}',600,340,0.0000,100.0000,NULL,0,0,2,1,1,0.0000,0.0000,0,0,NULL,NULL,2),(673,'Disk space usage {#SNMPVALUE}',600,340,0.0000,100.0000,672,0,0,2,1,1,0.0000,0.0000,0,0,NULL,NULL,2),(674,'Disk space usage {#SNMPVALUE}',600,340,0.0000,100.0000,672,0,0,2,1,1,0.0000,0.0000,0,0,NULL,NULL,2),(675,'Traffic on interface {#SNMPVALUE}',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,2),(676,'Traffic on interface {#SNMPVALUE}',900,200,0.0000,100.0000,675,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,2),(677,'Traffic on interface {#SNMPVALUE}',900,200,0.0000,100.0000,675,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,2),(678,'Traffic on interface {#SNMPVALUE}',900,200,0.0000,100.0000,675,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,2),(679,'compute node',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(680,'controller node',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(681,'CPU jumps',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(682,'CPU load',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,0,NULL,NULL,0),(683,'CPU load',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,0,NULL,NULL,0),(684,'CPU utilization',900,200,0.0000,100.0000,NULL,1,0,1,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(685,'Fan speed and ambient temperature',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(686,'Fan speed and temperature',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(687,'haproxy',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(688,'Memory usage',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,2,NULL,25236,0),(689,'Memory usage',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,2,NULL,25220,0),(690,'MySQL bandwidth',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(691,'mysqld',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(692,'MySQL operations',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(693,'ntp',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(694,'rabbitmq-server',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(695,'Value cache effectiveness',900,200,0.0000,100.0000,NULL,1,1,1,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(696,'Voltage',900,200,0.0000,5.5000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(697,'Voltage',900,200,0.0000,5.5000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(698,'Zabbix cache usage, % free',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(699,'Zabbix cache usage, % free',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(700,'Zabbix data gathering process busy %',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(701,'Zabbix data gathering process busy %',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(702,'Zabbix internal process busy %',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(703,'Zabbix internal process busy %',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(704,'Zabbix proxy performance',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(705,'Zabbix server performance',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0);
/*!40000 ALTER TABLE `graphs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `graphs_items`
--

DROP TABLE IF EXISTS `graphs_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `graphs_items` (
  `gitemid` bigint(20) unsigned NOT NULL,
  `graphid` bigint(20) unsigned NOT NULL,
  `itemid` bigint(20) unsigned NOT NULL,
  `drawtype` int(11) NOT NULL DEFAULT '0',
  `sortorder` int(11) NOT NULL DEFAULT '0',
  `color` varchar(6) NOT NULL DEFAULT '009600',
  `yaxisside` int(11) NOT NULL DEFAULT '0',
  `calc_fnc` int(11) NOT NULL DEFAULT '2',
  `type` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`gitemid`),
  KEY `graphs_items_1` (`itemid`),
  KEY `graphs_items_2` (`graphid`),
  CONSTRAINT `c_graphs_items_1` FOREIGN KEY (`graphid`) REFERENCES `graphs` (`graphid`) ON DELETE CASCADE,
  CONSTRAINT `c_graphs_items_2` FOREIGN KEY (`itemid`) REFERENCES `items` (`itemid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `graphs_items`
--

LOCK TABLES `graphs_items` WRITE;
/*!40000 ALTER TABLE `graphs_items` DISABLE KEYS */;
INSERT INTO `graphs_items` VALUES (1714,521,23280,5,0,'00AA00',0,2,0),(1715,521,23281,5,1,'3333FF',0,2,0),(1716,522,23285,0,0,'C80000',0,2,2),(1717,522,23283,0,1,'00C800',0,2,0),(1718,523,23298,0,0,'009900',0,2,0),(1719,523,23294,0,1,'000099',0,2,0),(1720,524,23296,0,0,'009900',0,2,0),(1721,524,23297,0,1,'000099',0,2,0),(1722,524,23295,0,2,'990000',0,2,0),(1723,525,23304,1,0,'FF5555',0,2,0),(1724,525,23303,1,1,'55FF55',0,2,0),(1725,525,23300,1,2,'009999',0,2,0),(1726,525,23302,1,3,'990099',0,2,0),(1727,525,23301,1,4,'999900',0,2,0),(1728,525,23305,1,5,'990000',0,2,0),(1729,525,23306,1,6,'000099',0,2,0),(1730,525,23299,1,7,'009900',0,2,0),(1731,526,23311,0,0,'AA0000',0,2,2),(1732,526,23309,0,1,'00AA00',0,2,0),(1792,534,23316,5,0,'00C800',0,2,0),(2240,517,23268,0,0,'00EE00',0,2,0),(2241,517,23256,0,1,'0000EE',0,2,0),(2242,517,23258,0,2,'FFAA00',0,2,0),(2243,517,23252,0,3,'00EEEE',0,2,0),(2244,517,23253,0,4,'990099',0,2,0),(2245,517,23254,0,5,'666600',0,2,0),(2246,517,23257,0,6,'EE0000',0,2,0),(2247,517,23266,0,7,'FF66FF',0,2,0),(2248,518,23269,0,0,'990099',0,2,0),(2249,518,23264,0,1,'990000',0,2,0),(2250,518,23261,0,2,'0000EE',0,2,0),(2251,518,23255,0,3,'FF33FF',0,2,0),(2252,518,23260,0,4,'009600',0,2,0),(2253,518,23259,0,5,'003300',0,2,0),(2254,518,23265,0,6,'CCCC00',0,2,0),(2255,518,23270,0,7,'33FFFF',0,2,0),(2256,518,23262,0,8,'DD0000',0,2,0),(2257,518,23267,0,9,'000099',0,2,0),(2258,518,23328,0,10,'00FF00',0,2,0),(2259,519,23277,5,0,'00C800',0,2,0),(2260,519,23272,5,1,'C80000',1,2,0),(2261,520,23276,0,0,'009900',0,2,0),(2262,520,23273,0,1,'DD0000',0,2,0),(2263,520,23275,0,2,'00DDDD',0,2,0),(2264,520,23274,0,3,'3333FF',0,2,0),(2265,520,23620,0,4,'999900',0,2,0),(2266,520,23635,0,5,'00FF00',0,2,0),(2267,528,23628,0,0,'C80000',0,2,0),(2268,528,23625,0,1,'00C800',0,2,0),(2300,667,25326,0,0,'00C800',0,2,0),(2301,667,25327,0,1,'C80000',0,2,0),(2302,667,25328,0,2,'0000C8',0,2,0),(2303,667,25329,0,3,'C800C8',0,2,0),(2304,667,25330,0,4,'00C8C8',0,2,0),(2305,667,25331,0,5,'C8C800',0,2,0),(2306,667,25332,0,6,'C8C8C8',0,2,0),(2307,667,25333,0,7,'009600',0,2,0),(2308,667,25334,0,8,'960000',0,2,0),(2309,668,25335,5,0,'00AA00',0,2,0),(2310,668,25336,5,1,'3333FF',0,2,0),(2311,669,25340,0,0,'C80000',0,2,2),(2312,669,25338,0,1,'00C800',0,2,0),(2313,670,25342,5,0,'00AA00',0,2,0),(2314,670,25343,5,1,'3333FF',0,2,0),(2315,671,25346,0,0,'C80000',0,2,2),(2316,671,25344,0,1,'00C800',0,2,0),(2317,672,25350,0,0,'00C800',0,2,2),(2318,672,25352,0,1,'C80000',0,2,0),(2319,673,25390,0,0,'00C800',0,2,2),(2320,673,25392,0,1,'C80000',0,2,0),(2321,674,25405,0,0,'00C800',0,2,2),(2322,674,25407,0,1,'C80000',0,2,0),(2323,675,25358,5,0,'00AA00',0,2,0),(2324,675,25361,5,1,'3333FF',0,2,0),(2325,676,25384,5,0,'00AA00',0,2,0),(2326,676,25387,5,1,'3333FF',0,2,0),(2327,677,25398,5,0,'00AA00',0,2,0),(2328,677,25401,5,1,'3333FF',0,2,0),(2329,678,25413,5,0,'00AA00',0,2,0),(2330,678,25416,5,1,'3333FF',0,2,0),(2331,679,25055,0,0,'1A7C11',0,2,0),(2332,679,25056,0,1,'F63100',0,2,0),(2333,679,25050,0,2,'2774A4',0,2,0),(2334,679,25051,0,3,'A54F10',0,2,0),(2335,679,25052,0,4,'FC6EA3',0,2,0),(2336,679,25053,0,5,'6C59DC',0,2,0),(2337,679,25054,0,6,'AC8C14',0,2,0),(2338,679,25057,0,7,'611F27',0,2,0),(2339,679,25058,0,9,'5CCD18',0,2,0),(2340,680,25059,0,0,'1A7C11',0,2,0),(2341,680,25060,0,1,'F63100',0,2,0),(2342,680,25061,0,2,'2774A4',0,2,0),(2343,680,25062,0,3,'A54F10',0,2,0),(2344,680,25063,0,4,'FC6EA3',0,2,0),(2345,680,25064,0,5,'6C59DC',0,2,0),(2346,680,25065,0,6,'AC8C14',0,2,0),(2347,680,25066,0,7,'611F27',0,2,0),(2348,680,25067,0,8,'F230E0',0,2,0),(2349,680,25068,0,9,'5CCD18',0,2,0),(2350,680,25069,0,10,'BB2A02',0,2,0),(2351,680,25070,0,11,'5A2B57',0,2,0),(2352,680,25071,0,12,'89ABF8',0,2,0),(2353,680,25072,0,13,'7EC25C',0,2,0),(2354,680,25073,0,14,'274482',0,2,0),(2355,681,25204,0,0,'009900',0,2,0),(2356,681,25200,0,1,'000099',0,2,0),(2357,682,25228,0,0,'009900',0,2,0),(2358,682,25229,0,1,'000099',0,2,0),(2359,682,25230,0,2,'990000',0,2,0),(2360,683,25201,0,0,'009900',0,2,0),(2361,683,25202,0,1,'000099',0,2,0),(2362,683,25203,0,2,'990000',0,2,0),(2363,684,25211,1,0,'FF5555',0,2,0),(2364,684,25210,1,1,'55FF55',0,2,0),(2365,684,25207,1,2,'009999',0,2,0),(2366,684,25209,1,3,'990099',0,2,0),(2367,684,25208,1,4,'999900',0,2,0),(2368,684,25212,1,5,'990000',0,2,0),(2369,684,25213,1,6,'000099',0,2,0),(2370,684,25206,1,7,'009900',0,2,0),(2371,685,25179,5,0,'EE0000',0,2,0),(2372,685,25182,0,1,'000000',1,2,0),(2373,686,25190,2,0,'EE0000',0,2,0),(2374,686,25183,2,1,'EE00EE',0,2,0),(2375,686,25192,0,2,'000000',1,2,0),(2376,686,25193,4,3,'000000',1,2,0),(2377,687,25075,0,0,'1A7C11',0,2,0),(2378,687,25076,0,1,'F63100',0,2,0),(2379,688,25235,5,0,'00C800',0,2,0),(2380,689,25219,5,0,'00C800',0,2,0),(2381,690,25095,5,0,'00AA00',0,2,0),(2382,690,25096,5,1,'3333FF',0,2,0),(2383,691,25081,0,0,'1A7C11',0,2,0),(2384,691,25082,0,1,'F63100',0,2,0),(2385,692,25097,0,0,'C8C800',0,2,0),(2386,692,25098,0,1,'006400',0,2,0),(2387,692,25099,0,2,'C80000',0,2,0),(2388,692,25100,0,3,'0000EE',0,2,0),(2389,692,25101,0,4,'640000',0,2,0),(2390,692,25102,0,5,'00C800',0,2,0),(2391,692,25103,0,6,'C800C8',0,2,0),(2392,693,25084,0,0,'1A7C11',0,2,0),(2393,694,25085,0,0,'1A7C11',0,2,0),(2394,695,25165,0,0,'C80000',0,2,0),(2395,695,25164,0,1,'00C800',0,2,0),(2396,696,25191,2,0,'880000',0,2,0),(2397,696,25184,0,1,'009900',0,2,0),(2398,696,25187,0,2,'00CCCC',0,2,0),(2399,696,25188,0,3,'000000',0,2,0),(2400,696,25189,0,4,'3333FF',0,2,0),(2401,697,25180,2,0,'880000',0,2,0),(2402,697,25175,0,1,'009900',0,2,0),(2403,697,25176,0,2,'00CCCC',0,2,0),(2404,697,25177,0,3,'000000',0,2,0),(2405,697,25178,0,4,'3333FF',0,2,0),(2406,697,25181,0,5,'777700',0,2,0),(2407,698,25170,0,0,'009900',0,2,0),(2408,698,25162,0,1,'DD0000',0,2,0),(2409,698,25169,0,2,'00DDDD',0,2,0),(2410,698,25168,0,3,'3333FF',0,2,0),(2411,698,25163,0,4,'999900',0,2,0),(2412,698,25167,0,5,'00FF00',0,2,0),(2413,699,25136,0,0,'DD0000',0,2,0),(2414,699,25138,0,1,'00DDDD',0,2,0),(2415,699,25137,0,2,'3333FF',0,2,0),(2416,700,25157,0,0,'990099',0,2,0),(2417,700,25152,0,1,'990000',0,2,0),(2418,700,25150,0,2,'0000EE',0,2,0),(2419,700,25144,0,3,'FF33FF',0,2,0),(2420,700,25149,0,4,'009600',0,2,0),(2421,700,25148,0,5,'003300',0,2,0),(2422,700,25153,0,6,'CCCC00',0,2,0),(2423,700,25158,0,7,'33FFFF',0,2,0),(2424,700,25151,0,8,'DD0000',0,2,0),(2425,700,25155,0,9,'000099',0,2,0),(2426,700,25159,0,10,'00FF00',0,2,0),(2427,701,25132,0,0,'990099',0,2,0),(2428,701,25129,0,1,'990000',0,2,0),(2429,701,25127,0,2,'0000EE',0,2,0),(2430,701,25121,0,3,'FF33FF',0,2,0),(2431,701,25126,0,4,'00EE00',0,2,0),(2432,701,25125,0,5,'003300',0,2,0),(2433,701,25133,0,6,'33FFFF',0,2,0),(2434,701,25128,0,7,'DD0000',0,2,0),(2435,701,25131,0,8,'000099',0,7,0),(2436,702,25156,0,0,'00EE00',0,2,0),(2437,702,25145,0,1,'0000EE',0,2,0),(2438,702,25147,0,2,'FFAA00',0,2,0),(2439,702,25141,0,3,'00EEEE',0,2,0),(2440,702,25142,0,4,'990099',0,2,0),(2441,702,25143,0,5,'666600',0,2,0),(2442,702,25146,0,6,'EE0000',0,2,0),(2443,702,25154,0,7,'FF66FF',0,2,0),(2444,703,25124,0,0,'FFAA00',0,2,0),(2445,703,25119,0,1,'990099',0,2,0),(2446,703,25123,0,2,'EE0000',0,2,0),(2447,703,25130,0,3,'FF66FF',0,2,0),(2448,703,25122,0,4,'960000',0,2,0),(2449,703,25120,0,5,'009600',0,2,0),(2450,704,25139,5,0,'00C800',0,2,0),(2451,704,25135,5,1,'C80000',1,2,0),(2452,705,25171,5,0,'00C800',0,2,0),(2453,705,25161,5,1,'C80000',1,2,0);
/*!40000 ALTER TABLE `graphs_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group_discovery`
--

DROP TABLE IF EXISTS `group_discovery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `group_discovery` (
  `groupid` bigint(20) unsigned NOT NULL,
  `parent_group_prototypeid` bigint(20) unsigned NOT NULL,
  `name` varchar(64) NOT NULL DEFAULT '',
  `lastcheck` int(11) NOT NULL DEFAULT '0',
  `ts_delete` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`groupid`),
  KEY `c_group_discovery_2` (`parent_group_prototypeid`),
  CONSTRAINT `c_group_discovery_1` FOREIGN KEY (`groupid`) REFERENCES `groups` (`groupid`) ON DELETE CASCADE,
  CONSTRAINT `c_group_discovery_2` FOREIGN KEY (`parent_group_prototypeid`) REFERENCES `group_prototype` (`group_prototypeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group_discovery`
--

LOCK TABLES `group_discovery` WRITE;
/*!40000 ALTER TABLE `group_discovery` DISABLE KEYS */;
/*!40000 ALTER TABLE `group_discovery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group_prototype`
--

DROP TABLE IF EXISTS `group_prototype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `group_prototype` (
  `group_prototypeid` bigint(20) unsigned NOT NULL,
  `hostid` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `groupid` bigint(20) unsigned DEFAULT NULL,
  `templateid` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`group_prototypeid`),
  KEY `group_prototype_1` (`hostid`),
  KEY `c_group_prototype_2` (`groupid`),
  KEY `c_group_prototype_3` (`templateid`),
  CONSTRAINT `c_group_prototype_1` FOREIGN KEY (`hostid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE,
  CONSTRAINT `c_group_prototype_2` FOREIGN KEY (`groupid`) REFERENCES `groups` (`groupid`),
  CONSTRAINT `c_group_prototype_3` FOREIGN KEY (`templateid`) REFERENCES `group_prototype` (`group_prototypeid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group_prototype`
--

LOCK TABLES `group_prototype` WRITE;
/*!40000 ALTER TABLE `group_prototype` DISABLE KEYS */;
INSERT INTO `group_prototype` VALUES (8,10190,'{#CLUSTER.NAME}',NULL,NULL),(9,10190,'{#DATACENTER.NAME}',NULL,NULL),(10,10190,'',7,NULL),(11,10191,'{#CLUSTER.NAME} (vm)',NULL,NULL),(12,10191,'{#DATACENTER.NAME} (vm)',NULL,NULL),(13,10191,'{#HV.NAME}',NULL,NULL),(14,10191,'',6,NULL);
/*!40000 ALTER TABLE `group_prototype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `groups`
--

DROP TABLE IF EXISTS `groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `groups` (
  `groupid` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `internal` int(11) NOT NULL DEFAULT '0',
  `flags` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`groupid`),
  KEY `groups_1` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `groups`
--

LOCK TABLES `groups` WRITE;
/*!40000 ALTER TABLE `groups` DISABLE KEYS */;
INSERT INTO `groups` VALUES (1,'Templates',0,0),(2,'Linux servers',0,0),(4,'Zabbix servers',0,0),(5,'Discovered hosts',1,0),(6,'Virtual machines',0,0),(7,'Hypervisors',0,0),(8,'Ceph',0,0),(9,'Openstack',0,0),(10,'Compute node',0,0),(11,'Controller node',0,0),(12,'IO_State',0,0);
/*!40000 ALTER TABLE `groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history`
--

DROP TABLE IF EXISTS `history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `history` (
  `itemid` bigint(20) unsigned NOT NULL,
  `clock` int(11) NOT NULL DEFAULT '0',
  `value` double(16,4) NOT NULL DEFAULT '0.0000',
  `ns` int(11) NOT NULL DEFAULT '0',
  KEY `history_1` (`itemid`,`clock`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history`
--

LOCK TABLES `history` WRITE;
/*!40000 ALTER TABLE `history` DISABLE KEYS */;
/*!40000 ALTER TABLE `history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history_log`
--

DROP TABLE IF EXISTS `history_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `history_log` (
  `itemid` bigint(20) unsigned NOT NULL,
  `clock` int(11) NOT NULL DEFAULT '0',
  `timestamp` int(11) NOT NULL DEFAULT '0',
  `source` varchar(64) NOT NULL DEFAULT '',
  `severity` int(11) NOT NULL DEFAULT '0',
  `value` text NOT NULL,
  `logeventid` int(11) NOT NULL DEFAULT '0',
  `ns` int(11) NOT NULL DEFAULT '0',
  KEY `history_log_1` (`itemid`,`clock`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history_log`
--

LOCK TABLES `history_log` WRITE;
/*!40000 ALTER TABLE `history_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `history_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history_str`
--

DROP TABLE IF EXISTS `history_str`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `history_str` (
  `itemid` bigint(20) unsigned NOT NULL,
  `clock` int(11) NOT NULL DEFAULT '0',
  `value` varchar(255) NOT NULL DEFAULT '',
  `ns` int(11) NOT NULL DEFAULT '0',
  KEY `history_str_1` (`itemid`,`clock`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history_str`
--

LOCK TABLES `history_str` WRITE;
/*!40000 ALTER TABLE `history_str` DISABLE KEYS */;
/*!40000 ALTER TABLE `history_str` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history_text`
--

DROP TABLE IF EXISTS `history_text`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `history_text` (
  `itemid` bigint(20) unsigned NOT NULL,
  `clock` int(11) NOT NULL DEFAULT '0',
  `value` text NOT NULL,
  `ns` int(11) NOT NULL DEFAULT '0',
  KEY `history_text_1` (`itemid`,`clock`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history_text`
--

LOCK TABLES `history_text` WRITE;
/*!40000 ALTER TABLE `history_text` DISABLE KEYS */;
/*!40000 ALTER TABLE `history_text` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history_uint`
--

DROP TABLE IF EXISTS `history_uint`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `history_uint` (
  `itemid` bigint(20) unsigned NOT NULL,
  `clock` int(11) NOT NULL DEFAULT '0',
  `value` bigint(20) unsigned NOT NULL DEFAULT '0',
  `ns` int(11) NOT NULL DEFAULT '0',
  KEY `history_uint_1` (`itemid`,`clock`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history_uint`
--

LOCK TABLES `history_uint` WRITE;
/*!40000 ALTER TABLE `history_uint` DISABLE KEYS */;
/*!40000 ALTER TABLE `history_uint` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `host_discovery`
--

DROP TABLE IF EXISTS `host_discovery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `host_discovery` (
  `hostid` bigint(20) unsigned NOT NULL,
  `parent_hostid` bigint(20) unsigned DEFAULT NULL,
  `parent_itemid` bigint(20) unsigned DEFAULT NULL,
  `host` varchar(64) NOT NULL DEFAULT '',
  `lastcheck` int(11) NOT NULL DEFAULT '0',
  `ts_delete` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`hostid`),
  KEY `c_host_discovery_2` (`parent_hostid`),
  KEY `c_host_discovery_3` (`parent_itemid`),
  CONSTRAINT `c_host_discovery_1` FOREIGN KEY (`hostid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE,
  CONSTRAINT `c_host_discovery_2` FOREIGN KEY (`parent_hostid`) REFERENCES `hosts` (`hostid`),
  CONSTRAINT `c_host_discovery_3` FOREIGN KEY (`parent_itemid`) REFERENCES `items` (`itemid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `host_discovery`
--

LOCK TABLES `host_discovery` WRITE;
/*!40000 ALTER TABLE `host_discovery` DISABLE KEYS */;
INSERT INTO `host_discovery` VALUES (10190,NULL,25313,'',0,0),(10191,NULL,25314,'',0,0);
/*!40000 ALTER TABLE `host_discovery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `host_inventory`
--

DROP TABLE IF EXISTS `host_inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `host_inventory` (
  `hostid` bigint(20) unsigned NOT NULL,
  `inventory_mode` int(11) NOT NULL DEFAULT '0',
  `type` varchar(64) NOT NULL DEFAULT '',
  `type_full` varchar(64) NOT NULL DEFAULT '',
  `name` varchar(64) NOT NULL DEFAULT '',
  `alias` varchar(64) NOT NULL DEFAULT '',
  `os` varchar(64) NOT NULL DEFAULT '',
  `os_full` varchar(255) NOT NULL DEFAULT '',
  `os_short` varchar(64) NOT NULL DEFAULT '',
  `serialno_a` varchar(64) NOT NULL DEFAULT '',
  `serialno_b` varchar(64) NOT NULL DEFAULT '',
  `tag` varchar(64) NOT NULL DEFAULT '',
  `asset_tag` varchar(64) NOT NULL DEFAULT '',
  `macaddress_a` varchar(64) NOT NULL DEFAULT '',
  `macaddress_b` varchar(64) NOT NULL DEFAULT '',
  `hardware` varchar(255) NOT NULL DEFAULT '',
  `hardware_full` text NOT NULL,
  `software` varchar(255) NOT NULL DEFAULT '',
  `software_full` text NOT NULL,
  `software_app_a` varchar(64) NOT NULL DEFAULT '',
  `software_app_b` varchar(64) NOT NULL DEFAULT '',
  `software_app_c` varchar(64) NOT NULL DEFAULT '',
  `software_app_d` varchar(64) NOT NULL DEFAULT '',
  `software_app_e` varchar(64) NOT NULL DEFAULT '',
  `contact` text NOT NULL,
  `location` text NOT NULL,
  `location_lat` varchar(16) NOT NULL DEFAULT '',
  `location_lon` varchar(16) NOT NULL DEFAULT '',
  `notes` text NOT NULL,
  `chassis` varchar(64) NOT NULL DEFAULT '',
  `model` varchar(64) NOT NULL DEFAULT '',
  `hw_arch` varchar(32) NOT NULL DEFAULT '',
  `vendor` varchar(64) NOT NULL DEFAULT '',
  `contract_number` varchar(64) NOT NULL DEFAULT '',
  `installer_name` varchar(64) NOT NULL DEFAULT '',
  `deployment_status` varchar(64) NOT NULL DEFAULT '',
  `url_a` varchar(255) NOT NULL DEFAULT '',
  `url_b` varchar(255) NOT NULL DEFAULT '',
  `url_c` varchar(255) NOT NULL DEFAULT '',
  `host_networks` text NOT NULL,
  `host_netmask` varchar(39) NOT NULL DEFAULT '',
  `host_router` varchar(39) NOT NULL DEFAULT '',
  `oob_ip` varchar(39) NOT NULL DEFAULT '',
  `oob_netmask` varchar(39) NOT NULL DEFAULT '',
  `oob_router` varchar(39) NOT NULL DEFAULT '',
  `date_hw_purchase` varchar(64) NOT NULL DEFAULT '',
  `date_hw_install` varchar(64) NOT NULL DEFAULT '',
  `date_hw_expiry` varchar(64) NOT NULL DEFAULT '',
  `date_hw_decomm` varchar(64) NOT NULL DEFAULT '',
  `site_address_a` varchar(128) NOT NULL DEFAULT '',
  `site_address_b` varchar(128) NOT NULL DEFAULT '',
  `site_address_c` varchar(128) NOT NULL DEFAULT '',
  `site_city` varchar(128) NOT NULL DEFAULT '',
  `site_state` varchar(64) NOT NULL DEFAULT '',
  `site_country` varchar(64) NOT NULL DEFAULT '',
  `site_zip` varchar(64) NOT NULL DEFAULT '',
  `site_rack` varchar(128) NOT NULL DEFAULT '',
  `site_notes` text NOT NULL,
  `poc_1_name` varchar(128) NOT NULL DEFAULT '',
  `poc_1_email` varchar(128) NOT NULL DEFAULT '',
  `poc_1_phone_a` varchar(64) NOT NULL DEFAULT '',
  `poc_1_phone_b` varchar(64) NOT NULL DEFAULT '',
  `poc_1_cell` varchar(64) NOT NULL DEFAULT '',
  `poc_1_screen` varchar(64) NOT NULL DEFAULT '',
  `poc_1_notes` text NOT NULL,
  `poc_2_name` varchar(128) NOT NULL DEFAULT '',
  `poc_2_email` varchar(128) NOT NULL DEFAULT '',
  `poc_2_phone_a` varchar(64) NOT NULL DEFAULT '',
  `poc_2_phone_b` varchar(64) NOT NULL DEFAULT '',
  `poc_2_cell` varchar(64) NOT NULL DEFAULT '',
  `poc_2_screen` varchar(64) NOT NULL DEFAULT '',
  `poc_2_notes` text NOT NULL,
  PRIMARY KEY (`hostid`),
  CONSTRAINT `c_host_inventory_1` FOREIGN KEY (`hostid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `host_inventory`
--

LOCK TABLES `host_inventory` WRITE;
/*!40000 ALTER TABLE `host_inventory` DISABLE KEYS */;
/*!40000 ALTER TABLE `host_inventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hostmacro`
--

DROP TABLE IF EXISTS `hostmacro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hostmacro` (
  `hostmacroid` bigint(20) unsigned NOT NULL,
  `hostid` bigint(20) unsigned NOT NULL,
  `macro` varchar(255) NOT NULL DEFAULT '',
  `value` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`hostmacroid`),
  UNIQUE KEY `hostmacro_1` (`hostid`,`macro`),
  CONSTRAINT `c_hostmacro_1` FOREIGN KEY (`hostid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hostmacro`
--

LOCK TABLES `hostmacro` WRITE;
/*!40000 ALTER TABLE `hostmacro` DISABLE KEYS */;
/*!40000 ALTER TABLE `hostmacro` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hosts`
--

DROP TABLE IF EXISTS `hosts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hosts` (
  `hostid` bigint(20) unsigned NOT NULL,
  `proxy_hostid` bigint(20) unsigned DEFAULT NULL,
  `host` varchar(128) NOT NULL DEFAULT '',
  `status` int(11) NOT NULL DEFAULT '0',
  `disable_until` int(11) NOT NULL DEFAULT '0',
  `error` varchar(2048) NOT NULL DEFAULT '',
  `available` int(11) NOT NULL DEFAULT '0',
  `errors_from` int(11) NOT NULL DEFAULT '0',
  `lastaccess` int(11) NOT NULL DEFAULT '0',
  `ipmi_authtype` int(11) NOT NULL DEFAULT '0',
  `ipmi_privilege` int(11) NOT NULL DEFAULT '2',
  `ipmi_username` varchar(16) NOT NULL DEFAULT '',
  `ipmi_password` varchar(20) NOT NULL DEFAULT '',
  `ipmi_disable_until` int(11) NOT NULL DEFAULT '0',
  `ipmi_available` int(11) NOT NULL DEFAULT '0',
  `snmp_disable_until` int(11) NOT NULL DEFAULT '0',
  `snmp_available` int(11) NOT NULL DEFAULT '0',
  `maintenanceid` bigint(20) unsigned DEFAULT NULL,
  `maintenance_status` int(11) NOT NULL DEFAULT '0',
  `maintenance_type` int(11) NOT NULL DEFAULT '0',
  `maintenance_from` int(11) NOT NULL DEFAULT '0',
  `ipmi_errors_from` int(11) NOT NULL DEFAULT '0',
  `snmp_errors_from` int(11) NOT NULL DEFAULT '0',
  `ipmi_error` varchar(2048) NOT NULL DEFAULT '',
  `snmp_error` varchar(2048) NOT NULL DEFAULT '',
  `jmx_disable_until` int(11) NOT NULL DEFAULT '0',
  `jmx_available` int(11) NOT NULL DEFAULT '0',
  `jmx_errors_from` int(11) NOT NULL DEFAULT '0',
  `jmx_error` varchar(2048) NOT NULL DEFAULT '',
  `name` varchar(128) NOT NULL DEFAULT '',
  `flags` int(11) NOT NULL DEFAULT '0',
  `templateid` bigint(20) unsigned DEFAULT NULL,
  `description` text NOT NULL,
  `tls_connect` int(11) NOT NULL DEFAULT '1',
  `tls_accept` int(11) NOT NULL DEFAULT '1',
  `tls_issuer` varchar(1024) NOT NULL DEFAULT '',
  `tls_subject` varchar(1024) NOT NULL DEFAULT '',
  `tls_psk_identity` varchar(128) NOT NULL DEFAULT '',
  `tls_psk` varchar(512) NOT NULL DEFAULT '',
  PRIMARY KEY (`hostid`),
  KEY `hosts_1` (`host`),
  KEY `hosts_2` (`status`),
  KEY `hosts_3` (`proxy_hostid`),
  KEY `hosts_4` (`name`),
  KEY `hosts_5` (`maintenanceid`),
  KEY `c_hosts_3` (`templateid`),
  CONSTRAINT `c_hosts_1` FOREIGN KEY (`proxy_hostid`) REFERENCES `hosts` (`hostid`),
  CONSTRAINT `c_hosts_2` FOREIGN KEY (`maintenanceid`) REFERENCES `maintenances` (`maintenanceid`),
  CONSTRAINT `c_hosts_3` FOREIGN KEY (`templateid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hosts`
--

LOCK TABLES `hosts` WRITE;
/*!40000 ALTER TABLE `hosts` DISABLE KEYS */;
INSERT INTO `hosts` VALUES (10084,NULL,'Zabbix server',1,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Zabbix server',0,NULL,'',1,1,'','','',''),(10154,NULL,'ceph',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','ceph',0,NULL,'',1,1,'','','',''),(10155,NULL,'compute node',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','compute node',0,NULL,'',1,1,'','','',''),(10156,NULL,'controller node',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','controller node',0,NULL,'',1,1,'','','',''),(10157,NULL,'dashboard',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','dashboard',0,NULL,'',1,1,'','','',''),(10158,NULL,'haproxy',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','haproxy',0,NULL,'',1,1,'','','',''),(10159,NULL,'lbaas',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','lbaas',0,NULL,'',1,1,'','','',''),(10160,NULL,'memcache',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','memcache',0,NULL,'',1,1,'','','',''),(10161,NULL,'mysql',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','mysql',0,NULL,'',1,1,'','','',''),(10162,NULL,'novnc',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','novnc',0,NULL,'',1,1,'','','',''),(10163,NULL,'ntp',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','ntp',0,NULL,'',1,1,'','','',''),(10164,NULL,'rabbitmq',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','rabbitmq',0,NULL,'',1,1,'','','',''),(10165,NULL,'Template App Ceph ProcessNum',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template App Ceph ProcessNum',0,NULL,'',1,1,'','','',''),(10166,NULL,'Template App Ceph State',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template App Ceph State',0,NULL,'',1,1,'','','',''),(10167,NULL,'Template App IO State',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template App IO State',0,NULL,'',1,1,'','','',''),(10168,NULL,'Template App MySQL',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template App MySQL',0,NULL,'',1,1,'','','',''),(10169,NULL,'Template App Openstack Compute ServiceExist',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template App Openstack Compute ServiceExist',0,NULL,'',1,1,'','','',''),(10170,NULL,'Template App Openstack Controller ServiceExist',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template App Openstack Controller ServiceExist',0,NULL,'',1,1,'','','',''),(10171,NULL,'Template App SSH Service',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template App SSH Service',0,NULL,'',1,1,'','','',''),(10172,NULL,'Template App Zabbix Agent',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template App Zabbix Agent',0,NULL,'',1,1,'','','',''),(10173,NULL,'Template App Zabbix Proxy',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template App Zabbix Proxy',0,NULL,'',1,1,'','','',''),(10174,NULL,'Template App Zabbix Server',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template App Zabbix Server',0,NULL,'',1,1,'','','',''),(10175,NULL,'Template ICMP Ping',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template ICMP Ping',0,NULL,'',1,1,'','','',''),(10176,NULL,'Template IPMI Intel SR1530',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template IPMI Intel SR1530',0,NULL,'',1,1,'','','',''),(10177,NULL,'Template IPMI Intel SR1630',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template IPMI Intel SR1630',0,NULL,'',1,1,'','','',''),(10178,NULL,'Template OS Linux - physical',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template OS Linux - physical',0,NULL,'',1,1,'','','',''),(10179,NULL,'Template OS Windows',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template OS Windows',0,NULL,'',1,1,'','','',''),(10180,NULL,'Template SNMP Disks',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template SNMP Disks',0,NULL,'',1,1,'','','',''),(10181,NULL,'Template SNMP Generic',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template SNMP Generic',0,NULL,'',1,1,'','','',''),(10182,NULL,'Template SNMP Interfaces',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template SNMP Interfaces',0,NULL,'',1,1,'','','',''),(10183,NULL,'Template SNMP Processors',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template SNMP Processors',0,NULL,'',1,1,'','','',''),(10184,NULL,'Template Virt VMware',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Virt VMware',0,NULL,'',1,1,'','','',''),(10185,NULL,'Template Virt VMware Guest',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Virt VMware Guest',0,NULL,'',1,1,'','','',''),(10186,NULL,'Template Virt VMware Hypervisor',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Virt VMware Hypervisor',0,NULL,'',1,1,'','','',''),(10187,NULL,'Template SNMP Device',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template SNMP Device',0,NULL,'',1,1,'','','',''),(10188,NULL,'Template SNMP OS Linux',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template SNMP OS Linux',0,NULL,'',1,1,'','','',''),(10189,NULL,'Template SNMP OS Windows',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template SNMP OS Windows',0,NULL,'',1,1,'','','',''),(10190,NULL,'{#HV.UUID}',0,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','{#HV.NAME}',2,NULL,'',1,1,'','','',''),(10191,NULL,'{#VM.UUID}',0,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','{#VM.NAME}',2,NULL,'',1,1,'','','','');
/*!40000 ALTER TABLE `hosts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hosts_groups`
--

DROP TABLE IF EXISTS `hosts_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hosts_groups` (
  `hostgroupid` bigint(20) unsigned NOT NULL,
  `hostid` bigint(20) unsigned NOT NULL,
  `groupid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`hostgroupid`),
  UNIQUE KEY `hosts_groups_1` (`hostid`,`groupid`),
  KEY `hosts_groups_2` (`groupid`),
  CONSTRAINT `c_hosts_groups_1` FOREIGN KEY (`hostid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE,
  CONSTRAINT `c_hosts_groups_2` FOREIGN KEY (`groupid`) REFERENCES `groups` (`groupid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hosts_groups`
--

LOCK TABLES `hosts_groups` WRITE;
/*!40000 ALTER TABLE `hosts_groups` DISABLE KEYS */;
INSERT INTO `hosts_groups` VALUES (92,10084,4),(188,10154,8),(190,10155,1),(189,10155,11),(192,10156,1),(191,10156,11),(194,10157,1),(193,10157,10),(195,10158,11),(197,10159,1),(196,10159,11),(199,10160,1),(198,10160,11),(201,10161,1),(200,10161,10),(203,10162,1),(202,10162,11),(205,10163,1),(204,10163,10),(207,10164,1),(206,10164,11),(209,10165,1),(208,10165,8),(211,10166,1),(210,10166,8),(213,10167,1),(212,10167,12),(214,10168,1),(217,10169,1),(216,10169,9),(215,10169,10),(219,10170,1),(218,10170,11),(220,10171,1),(221,10172,1),(222,10173,1),(223,10174,1),(224,10175,1),(225,10176,1),(226,10177,1),(227,10178,1),(228,10179,1),(229,10180,1),(230,10181,1),(231,10182,1),(232,10183,1),(233,10184,1),(234,10185,1),(235,10186,1),(236,10187,1),(237,10188,1),(238,10189,1);
/*!40000 ALTER TABLE `hosts_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hosts_templates`
--

DROP TABLE IF EXISTS `hosts_templates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hosts_templates` (
  `hosttemplateid` bigint(20) unsigned NOT NULL,
  `hostid` bigint(20) unsigned NOT NULL,
  `templateid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`hosttemplateid`),
  UNIQUE KEY `hosts_templates_1` (`hostid`,`templateid`),
  KEY `hosts_templates_2` (`templateid`),
  CONSTRAINT `c_hosts_templates_1` FOREIGN KEY (`hostid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE,
  CONSTRAINT `c_hosts_templates_2` FOREIGN KEY (`templateid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hosts_templates`
--

LOCK TABLES `hosts_templates` WRITE;
/*!40000 ALTER TABLE `hosts_templates` DISABLE KEYS */;
INSERT INTO `hosts_templates` VALUES (15,10187,10181),(16,10187,10182),(17,10188,10180),(18,10188,10181),(19,10188,10182),(20,10188,10183),(21,10189,10180),(22,10189,10181),(23,10189,10182),(24,10189,10183),(25,10190,10186),(26,10191,10185);
/*!40000 ALTER TABLE `hosts_templates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `housekeeper`
--

DROP TABLE IF EXISTS `housekeeper`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `housekeeper` (
  `housekeeperid` bigint(20) unsigned NOT NULL,
  `tablename` varchar(64) NOT NULL DEFAULT '',
  `field` varchar(64) NOT NULL DEFAULT '',
  `value` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`housekeeperid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `housekeeper`
--

LOCK TABLES `housekeeper` WRITE;
/*!40000 ALTER TABLE `housekeeper` DISABLE KEYS */;
/*!40000 ALTER TABLE `housekeeper` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `httpstep`
--

DROP TABLE IF EXISTS `httpstep`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `httpstep` (
  `httpstepid` bigint(20) unsigned NOT NULL,
  `httptestid` bigint(20) unsigned NOT NULL,
  `name` varchar(64) NOT NULL DEFAULT '',
  `no` int(11) NOT NULL DEFAULT '0',
  `url` varchar(2048) NOT NULL DEFAULT '',
  `timeout` int(11) NOT NULL DEFAULT '15',
  `posts` text NOT NULL,
  `required` varchar(255) NOT NULL DEFAULT '',
  `status_codes` varchar(255) NOT NULL DEFAULT '',
  `variables` text NOT NULL,
  `follow_redirects` int(11) NOT NULL DEFAULT '1',
  `retrieve_mode` int(11) NOT NULL DEFAULT '0',
  `headers` text NOT NULL,
  PRIMARY KEY (`httpstepid`),
  KEY `httpstep_1` (`httptestid`),
  CONSTRAINT `c_httpstep_1` FOREIGN KEY (`httptestid`) REFERENCES `httptest` (`httptestid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `httpstep`
--

LOCK TABLES `httpstep` WRITE;
/*!40000 ALTER TABLE `httpstep` DISABLE KEYS */;
/*!40000 ALTER TABLE `httpstep` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `httpstepitem`
--

DROP TABLE IF EXISTS `httpstepitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `httpstepitem` (
  `httpstepitemid` bigint(20) unsigned NOT NULL,
  `httpstepid` bigint(20) unsigned NOT NULL,
  `itemid` bigint(20) unsigned NOT NULL,
  `type` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`httpstepitemid`),
  UNIQUE KEY `httpstepitem_1` (`httpstepid`,`itemid`),
  KEY `httpstepitem_2` (`itemid`),
  CONSTRAINT `c_httpstepitem_1` FOREIGN KEY (`httpstepid`) REFERENCES `httpstep` (`httpstepid`) ON DELETE CASCADE,
  CONSTRAINT `c_httpstepitem_2` FOREIGN KEY (`itemid`) REFERENCES `items` (`itemid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `httpstepitem`
--

LOCK TABLES `httpstepitem` WRITE;
/*!40000 ALTER TABLE `httpstepitem` DISABLE KEYS */;
/*!40000 ALTER TABLE `httpstepitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `httptest`
--

DROP TABLE IF EXISTS `httptest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `httptest` (
  `httptestid` bigint(20) unsigned NOT NULL,
  `name` varchar(64) NOT NULL DEFAULT '',
  `applicationid` bigint(20) unsigned DEFAULT NULL,
  `nextcheck` int(11) NOT NULL DEFAULT '0',
  `delay` int(11) NOT NULL DEFAULT '60',
  `status` int(11) NOT NULL DEFAULT '0',
  `variables` text NOT NULL,
  `agent` varchar(255) NOT NULL DEFAULT 'Zabbix',
  `authentication` int(11) NOT NULL DEFAULT '0',
  `http_user` varchar(64) NOT NULL DEFAULT '',
  `http_password` varchar(64) NOT NULL DEFAULT '',
  `hostid` bigint(20) unsigned NOT NULL,
  `templateid` bigint(20) unsigned DEFAULT NULL,
  `http_proxy` varchar(255) NOT NULL DEFAULT '',
  `retries` int(11) NOT NULL DEFAULT '1',
  `ssl_cert_file` varchar(255) NOT NULL DEFAULT '',
  `ssl_key_file` varchar(255) NOT NULL DEFAULT '',
  `ssl_key_password` varchar(64) NOT NULL DEFAULT '',
  `verify_peer` int(11) NOT NULL DEFAULT '0',
  `verify_host` int(11) NOT NULL DEFAULT '0',
  `headers` text NOT NULL,
  PRIMARY KEY (`httptestid`),
  UNIQUE KEY `httptest_2` (`hostid`,`name`),
  KEY `httptest_1` (`applicationid`),
  KEY `httptest_3` (`status`),
  KEY `httptest_4` (`templateid`),
  CONSTRAINT `c_httptest_1` FOREIGN KEY (`applicationid`) REFERENCES `applications` (`applicationid`),
  CONSTRAINT `c_httptest_2` FOREIGN KEY (`hostid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE,
  CONSTRAINT `c_httptest_3` FOREIGN KEY (`templateid`) REFERENCES `httptest` (`httptestid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `httptest`
--

LOCK TABLES `httptest` WRITE;
/*!40000 ALTER TABLE `httptest` DISABLE KEYS */;
/*!40000 ALTER TABLE `httptest` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `httptestitem`
--

DROP TABLE IF EXISTS `httptestitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `httptestitem` (
  `httptestitemid` bigint(20) unsigned NOT NULL,
  `httptestid` bigint(20) unsigned NOT NULL,
  `itemid` bigint(20) unsigned NOT NULL,
  `type` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`httptestitemid`),
  UNIQUE KEY `httptestitem_1` (`httptestid`,`itemid`),
  KEY `httptestitem_2` (`itemid`),
  CONSTRAINT `c_httptestitem_1` FOREIGN KEY (`httptestid`) REFERENCES `httptest` (`httptestid`) ON DELETE CASCADE,
  CONSTRAINT `c_httptestitem_2` FOREIGN KEY (`itemid`) REFERENCES `items` (`itemid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `httptestitem`
--

LOCK TABLES `httptestitem` WRITE;
/*!40000 ALTER TABLE `httptestitem` DISABLE KEYS */;
/*!40000 ALTER TABLE `httptestitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `icon_map`
--

DROP TABLE IF EXISTS `icon_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `icon_map` (
  `iconmapid` bigint(20) unsigned NOT NULL,
  `name` varchar(64) NOT NULL DEFAULT '',
  `default_iconid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`iconmapid`),
  UNIQUE KEY `icon_map_1` (`name`),
  KEY `icon_map_2` (`default_iconid`),
  CONSTRAINT `c_icon_map_1` FOREIGN KEY (`default_iconid`) REFERENCES `images` (`imageid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `icon_map`
--

LOCK TABLES `icon_map` WRITE;
/*!40000 ALTER TABLE `icon_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `icon_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `icon_mapping`
--

DROP TABLE IF EXISTS `icon_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `icon_mapping` (
  `iconmappingid` bigint(20) unsigned NOT NULL,
  `iconmapid` bigint(20) unsigned NOT NULL,
  `iconid` bigint(20) unsigned NOT NULL,
  `inventory_link` int(11) NOT NULL DEFAULT '0',
  `expression` varchar(64) NOT NULL DEFAULT '',
  `sortorder` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`iconmappingid`),
  KEY `icon_mapping_1` (`iconmapid`),
  KEY `icon_mapping_2` (`iconid`),
  CONSTRAINT `c_icon_mapping_1` FOREIGN KEY (`iconmapid`) REFERENCES `icon_map` (`iconmapid`) ON DELETE CASCADE,
  CONSTRAINT `c_icon_mapping_2` FOREIGN KEY (`iconid`) REFERENCES `images` (`imageid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `icon_mapping`
--

LOCK TABLES `icon_mapping` WRITE;
/*!40000 ALTER TABLE `icon_mapping` DISABLE KEYS */;
/*!40000 ALTER TABLE `icon_mapping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ids`
--

DROP TABLE IF EXISTS `ids`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ids` (
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `field_name` varchar(64) NOT NULL DEFAULT '',
  `nextid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`table_name`,`field_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ids`
--

LOCK TABLES `ids` WRITE;
/*!40000 ALTER TABLE `ids` DISABLE KEYS */;
INSERT INTO `ids` VALUES ('actions','actionid',13),('applications','applicationid',575),('application_template','application_templateid',22),('auditlog','auditid',1383),('auditlog_details','auditdetailid',32),('conditions','conditionid',19),('functions','functionid',13750),('graphs','graphid',705),('graphs_items','gitemid',2453),('groups','groupid',12),('group_prototype','group_prototypeid',14),('hosts','hostid',10191),('hosts_groups','hostgroupid',238),('hosts_templates','hosttemplateid',26),('housekeeper','housekeeperid',11367),('items','itemid',25417),('items_applications','itemappid',7742),('item_condition','item_conditionid',38),('item_discovery','itemdiscoveryid',379),('media','mediaid',11),('media_type','mediatypeid',5),('opcommand_grp','opcommand_grpid',1),('opconditions','opconditionid',1),('operations','operationid',45),('opgroup','opgroupid',6),('opmessage_grp','opmessage_grpid',8),('opmessage_usr','opmessage_usrid',3),('optemplate','optemplateid',44),('profiles','profileid',59),('screens','screenid',30),('screens_items','screenitemid',99),('triggers','triggerid',14122),('trigger_depends','triggerdepid',82);
/*!40000 ALTER TABLE `ids` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `images`
--

DROP TABLE IF EXISTS `images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `images` (
  `imageid` bigint(20) unsigned NOT NULL,
  `imagetype` int(11) NOT NULL DEFAULT '0',
  `name` varchar(64) NOT NULL DEFAULT '0',
  `image` longblob NOT NULL,
  PRIMARY KEY (`imageid`),
  UNIQUE KEY `images_1` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `images`
--

LOCK TABLES `images` WRITE;
/*!40000 ALTER TABLE `images` DISABLE KEYS */;
/*!40000 ALTER TABLE `images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `interface`
--

DROP TABLE IF EXISTS `interface`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `interface` (
  `interfaceid` bigint(20) unsigned NOT NULL,
  `hostid` bigint(20) unsigned NOT NULL,
  `main` int(11) NOT NULL DEFAULT '0',
  `type` int(11) NOT NULL DEFAULT '0',
  `useip` int(11) NOT NULL DEFAULT '1',
  `ip` varchar(64) NOT NULL DEFAULT '127.0.0.1',
  `dns` varchar(64) NOT NULL DEFAULT '',
  `port` varchar(64) NOT NULL DEFAULT '10050',
  `bulk` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`interfaceid`),
  KEY `interface_1` (`hostid`,`type`),
  KEY `interface_2` (`ip`,`dns`),
  CONSTRAINT `c_interface_1` FOREIGN KEY (`hostid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `interface`
--

LOCK TABLES `interface` WRITE;
/*!40000 ALTER TABLE `interface` DISABLE KEYS */;
INSERT INTO `interface` VALUES (1,10084,1,1,1,'127.0.0.1','','10050',1);
/*!40000 ALTER TABLE `interface` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `interface_discovery`
--

DROP TABLE IF EXISTS `interface_discovery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `interface_discovery` (
  `interfaceid` bigint(20) unsigned NOT NULL,
  `parent_interfaceid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`interfaceid`),
  KEY `c_interface_discovery_2` (`parent_interfaceid`),
  CONSTRAINT `c_interface_discovery_1` FOREIGN KEY (`interfaceid`) REFERENCES `interface` (`interfaceid`) ON DELETE CASCADE,
  CONSTRAINT `c_interface_discovery_2` FOREIGN KEY (`parent_interfaceid`) REFERENCES `interface` (`interfaceid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `interface_discovery`
--

LOCK TABLES `interface_discovery` WRITE;
/*!40000 ALTER TABLE `interface_discovery` DISABLE KEYS */;
/*!40000 ALTER TABLE `interface_discovery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_application_prototype`
--

DROP TABLE IF EXISTS `item_application_prototype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_application_prototype` (
  `item_application_prototypeid` bigint(20) unsigned NOT NULL,
  `application_prototypeid` bigint(20) unsigned NOT NULL,
  `itemid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`item_application_prototypeid`),
  UNIQUE KEY `item_application_prototype_1` (`application_prototypeid`,`itemid`),
  KEY `item_application_prototype_2` (`itemid`),
  CONSTRAINT `c_item_application_prototype_1` FOREIGN KEY (`application_prototypeid`) REFERENCES `application_prototype` (`application_prototypeid`) ON DELETE CASCADE,
  CONSTRAINT `c_item_application_prototype_2` FOREIGN KEY (`itemid`) REFERENCES `items` (`itemid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_application_prototype`
--

LOCK TABLES `item_application_prototype` WRITE;
/*!40000 ALTER TABLE `item_application_prototype` DISABLE KEYS */;
/*!40000 ALTER TABLE `item_application_prototype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_condition`
--

DROP TABLE IF EXISTS `item_condition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_condition` (
  `item_conditionid` bigint(20) unsigned NOT NULL,
  `itemid` bigint(20) unsigned NOT NULL,
  `operator` int(11) NOT NULL DEFAULT '8',
  `macro` varchar(64) NOT NULL DEFAULT '',
  `value` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`item_conditionid`),
  KEY `item_condition_1` (`itemid`),
  CONSTRAINT `c_item_condition_1` FOREIGN KEY (`itemid`) REFERENCES `items` (`itemid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_condition`
--

LOCK TABLES `item_condition` WRITE;
/*!40000 ALTER TABLE `item_condition` DISABLE KEYS */;
INSERT INTO `item_condition` VALUES (19,23278,8,'{#IFNAME}','@Network interfaces for discovery'),(20,23279,8,'{#FSTYPE}','@File systems for discovery'),(30,25305,8,'{#IFNAME}','@Network interfaces for discovery'),(31,25306,8,'{#FSTYPE}','@File systems for discovery'),(32,25307,8,'{#IFNAME}','@Network interfaces for discovery'),(33,25308,8,'{#FSTYPE}','@File systems for discovery'),(34,25309,8,'{#SNMPVALUE}','@Storage devices for SNMP discovery'),(35,25320,8,'{#SNMPVALUE}','@Storage devices for SNMP discovery'),(36,25323,8,'{#SNMPVALUE}','@Storage devices for SNMP discovery'),(37,25305,8,'{#IFNAME}','^en.*'),(38,25305,8,'{#IFNAME}','^eth.*');
/*!40000 ALTER TABLE `item_condition` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_discovery`
--

DROP TABLE IF EXISTS `item_discovery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_discovery` (
  `itemdiscoveryid` bigint(20) unsigned NOT NULL,
  `itemid` bigint(20) unsigned NOT NULL,
  `parent_itemid` bigint(20) unsigned NOT NULL,
  `key_` varchar(255) NOT NULL DEFAULT '',
  `lastcheck` int(11) NOT NULL DEFAULT '0',
  `ts_delete` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`itemdiscoveryid`),
  UNIQUE KEY `item_discovery_1` (`itemid`,`parent_itemid`),
  KEY `item_discovery_2` (`parent_itemid`),
  CONSTRAINT `c_item_discovery_1` FOREIGN KEY (`itemid`) REFERENCES `items` (`itemid`) ON DELETE CASCADE,
  CONSTRAINT `c_item_discovery_2` FOREIGN KEY (`parent_itemid`) REFERENCES `items` (`itemid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_discovery`
--

LOCK TABLES `item_discovery` WRITE;
/*!40000 ALTER TABLE `item_discovery` DISABLE KEYS */;
INSERT INTO `item_discovery` VALUES (182,23280,23278,'',0,0),(183,23281,23278,'',0,0),(184,23282,23279,'',0,0),(185,23283,23279,'',0,0),(186,23284,23279,'',0,0),(187,23285,23279,'',0,0),(188,23286,23279,'',0,0),(288,25326,25304,'',0,0),(289,25327,25304,'',0,0),(290,25328,25304,'',0,0),(291,25329,25304,'',0,0),(292,25330,25304,'',0,0),(293,25331,25304,'',0,0),(294,25332,25304,'',0,0),(295,25333,25304,'',0,0),(296,25334,25304,'',0,0),(297,25335,25305,'',0,0),(298,25336,25305,'',0,0),(299,25337,25306,'',0,0),(300,25338,25306,'',0,0),(301,25339,25306,'',0,0),(302,25340,25306,'',0,0),(303,25341,25306,'',0,0),(304,25342,25307,'',0,0),(305,25343,25307,'',0,0),(306,25344,25308,'',0,0),(307,25345,25308,'',0,0),(308,25346,25308,'',0,0),(309,25347,25308,'',0,0),(310,25348,25309,'',0,0),(311,25349,25309,'',0,0),(312,25350,25309,'',0,0),(313,25351,25309,'',0,0),(314,25352,25309,'',0,0),(315,25353,25309,'',0,0),(316,25354,25310,'',0,0),(317,25355,25310,'',0,0),(318,25356,25310,'',0,0),(319,25357,25310,'',0,0),(320,25358,25310,'',0,0),(321,25359,25310,'',0,0),(322,25360,25310,'',0,0),(323,25361,25310,'',0,0),(324,25362,25311,'',0,0),(325,25363,25312,'',0,0),(326,25364,25315,'',0,0),(327,25365,25315,'',0,0),(328,25366,25315,'',0,0),(329,25367,25315,'',0,0),(330,25368,25316,'',0,0),(331,25369,25316,'',0,0),(332,25370,25316,'',0,0),(333,25371,25316,'',0,0),(334,25372,25317,'',0,0),(335,25373,25317,'',0,0),(336,25374,25317,'',0,0),(337,25375,25317,'',0,0),(338,25376,25318,'',0,0),(339,25377,25318,'',0,0),(340,25378,25318,'',0,0),(341,25379,25318,'',0,0),(342,25380,25319,'',0,0),(343,25381,25319,'',0,0),(344,25382,25319,'',0,0),(345,25383,25319,'',0,0),(346,25384,25319,'',0,0),(347,25385,25319,'',0,0),(348,25386,25319,'',0,0),(349,25387,25319,'',0,0),(350,25388,25320,'',0,0),(351,25389,25320,'',0,0),(352,25390,25320,'',0,0),(353,25391,25320,'',0,0),(354,25392,25320,'',0,0),(355,25393,25320,'',0,0),(356,25394,25321,'',0,0),(357,25395,25321,'',0,0),(358,25396,25321,'',0,0),(359,25397,25321,'',0,0),(360,25398,25321,'',0,0),(361,25399,25321,'',0,0),(362,25400,25321,'',0,0),(363,25401,25321,'',0,0),(364,25402,25322,'',0,0),(365,25403,25323,'',0,0),(366,25404,25323,'',0,0),(367,25405,25323,'',0,0),(368,25406,25323,'',0,0),(369,25407,25323,'',0,0),(370,25408,25323,'',0,0),(371,25409,25324,'',0,0),(372,25410,25324,'',0,0),(373,25411,25324,'',0,0),(374,25412,25324,'',0,0),(375,25413,25324,'',0,0),(376,25414,25324,'',0,0),(377,25415,25324,'',0,0),(378,25416,25324,'',0,0),(379,25417,25325,'',0,0);
/*!40000 ALTER TABLE `item_discovery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `items`
--

DROP TABLE IF EXISTS `items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `items` (
  `itemid` bigint(20) unsigned NOT NULL,
  `type` int(11) NOT NULL DEFAULT '0',
  `snmp_community` varchar(64) NOT NULL DEFAULT '',
  `snmp_oid` varchar(255) NOT NULL DEFAULT '',
  `hostid` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `key_` varchar(255) NOT NULL DEFAULT '',
  `delay` int(11) NOT NULL DEFAULT '0',
  `history` int(11) NOT NULL DEFAULT '90',
  `trends` int(11) NOT NULL DEFAULT '365',
  `status` int(11) NOT NULL DEFAULT '0',
  `value_type` int(11) NOT NULL DEFAULT '0',
  `trapper_hosts` varchar(255) NOT NULL DEFAULT '',
  `units` varchar(255) NOT NULL DEFAULT '',
  `multiplier` int(11) NOT NULL DEFAULT '0',
  `delta` int(11) NOT NULL DEFAULT '0',
  `snmpv3_securityname` varchar(64) NOT NULL DEFAULT '',
  `snmpv3_securitylevel` int(11) NOT NULL DEFAULT '0',
  `snmpv3_authpassphrase` varchar(64) NOT NULL DEFAULT '',
  `snmpv3_privpassphrase` varchar(64) NOT NULL DEFAULT '',
  `formula` varchar(255) NOT NULL DEFAULT '',
  `error` varchar(2048) NOT NULL DEFAULT '',
  `lastlogsize` bigint(20) unsigned NOT NULL DEFAULT '0',
  `logtimefmt` varchar(64) NOT NULL DEFAULT '',
  `templateid` bigint(20) unsigned DEFAULT NULL,
  `valuemapid` bigint(20) unsigned DEFAULT NULL,
  `delay_flex` varchar(255) NOT NULL DEFAULT '',
  `params` text NOT NULL,
  `ipmi_sensor` varchar(128) NOT NULL DEFAULT '',
  `data_type` int(11) NOT NULL DEFAULT '0',
  `authtype` int(11) NOT NULL DEFAULT '0',
  `username` varchar(64) NOT NULL DEFAULT '',
  `password` varchar(64) NOT NULL DEFAULT '',
  `publickey` varchar(64) NOT NULL DEFAULT '',
  `privatekey` varchar(64) NOT NULL DEFAULT '',
  `mtime` int(11) NOT NULL DEFAULT '0',
  `flags` int(11) NOT NULL DEFAULT '0',
  `interfaceid` bigint(20) unsigned DEFAULT NULL,
  `port` varchar(64) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  `inventory_link` int(11) NOT NULL DEFAULT '0',
  `lifetime` varchar(64) NOT NULL DEFAULT '30',
  `snmpv3_authprotocol` int(11) NOT NULL DEFAULT '0',
  `snmpv3_privprotocol` int(11) NOT NULL DEFAULT '0',
  `state` int(11) NOT NULL DEFAULT '0',
  `snmpv3_contextname` varchar(255) NOT NULL DEFAULT '',
  `evaltype` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`itemid`),
  UNIQUE KEY `items_1` (`hostid`,`key_`),
  KEY `items_3` (`status`),
  KEY `items_4` (`templateid`),
  KEY `items_5` (`valuemapid`),
  KEY `items_6` (`interfaceid`),
  CONSTRAINT `c_items_1` FOREIGN KEY (`hostid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE,
  CONSTRAINT `c_items_2` FOREIGN KEY (`templateid`) REFERENCES `items` (`itemid`) ON DELETE CASCADE,
  CONSTRAINT `c_items_3` FOREIGN KEY (`valuemapid`) REFERENCES `valuemaps` (`valuemapid`),
  CONSTRAINT `c_items_4` FOREIGN KEY (`interfaceid`) REFERENCES `interface` (`interfaceid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items`
--

LOCK TABLES `items` WRITE;
/*!40000 ALTER TABLE `items` DISABLE KEYS */;
INSERT INTO `items` VALUES (23252,5,'','',10084,'Zabbix $4 $2 processes, in %','zabbix[process,alerter,avg,busy]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(23253,5,'','',10084,'Zabbix $4 $2 processes, in %','zabbix[process,configuration syncer,avg,busy]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(23254,5,'','',10084,'Zabbix $4 $2 processes, in %','zabbix[process,db watchdog,avg,busy]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(23255,5,'','',10084,'Zabbix $4 $2 processes, in %','zabbix[process,discoverer,avg,busy]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(23256,5,'','',10084,'Zabbix $4 $2 processes, in %','zabbix[process,escalator,avg,busy]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(23257,5,'','',10084,'Zabbix $4 $2 processes, in %','zabbix[process,history syncer,avg,busy]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(23258,5,'','',10084,'Zabbix $4 $2 processes, in %','zabbix[process,housekeeper,avg,busy]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(23259,5,'','',10084,'Zabbix $4 $2 processes, in %','zabbix[process,http poller,avg,busy]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(23260,5,'','',10084,'Zabbix $4 $2 processes, in %','zabbix[process,icmp pinger,avg,busy]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(23261,5,'','',10084,'Zabbix $4 $2 processes, in %','zabbix[process,ipmi poller,avg,busy]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(23262,5,'','',10084,'Zabbix $4 $2 processes, in %','zabbix[process,java poller,avg,busy]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(23264,5,'','',10084,'Zabbix $4 $2 processes, in %','zabbix[process,poller,avg,busy]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(23265,5,'','',10084,'Zabbix $4 $2 processes, in %','zabbix[process,proxy poller,avg,busy]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(23266,5,'','',10084,'Zabbix $4 $2 processes, in %','zabbix[process,self-monitoring,avg,busy]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(23267,5,'','',10084,'Zabbix $4 $2 processes, in %','zabbix[process,snmp trapper,avg,busy]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(23268,5,'','',10084,'Zabbix $4 $2 processes, in %','zabbix[process,timer,avg,busy]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(23269,5,'','',10084,'Zabbix $4 $2 processes, in %','zabbix[process,trapper,avg,busy]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(23270,5,'','',10084,'Zabbix $4 $2 processes, in %','zabbix[process,unreachable poller,avg,busy]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(23271,5,'','',10084,'Zabbix queue over $2','zabbix[queue,10m]',600,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(23272,5,'','',10084,'Zabbix queue','zabbix[queue]',600,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(23273,5,'','',10084,'Zabbix configuration cache, % free','zabbix[rcache,buffer,pfree]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(23274,5,'','',10084,'Zabbix $2 write cache, % free','zabbix[wcache,history,pfree]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(23275,5,'','',10084,'Zabbix history index cache, % free','zabbix[wcache,index,pfree]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(23276,5,'','',10084,'Zabbix $2 write cache, % free','zabbix[wcache,trend,pfree]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(23277,5,'','',10084,'Values processed by Zabbix server per second','zabbix[wcache,values]',60,7,365,0,0,'','',0,1,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(23278,0,'','',10084,'Network interface discovery','net.if.discovery',3600,90,0,0,4,'','',0,0,'',0,'','','','',0,'',NULL,NULL,'','','',0,0,'','','','',0,1,1,'','Discovery of network interfaces as defined in global regular expression \"Network interfaces for discovery\".',0,'30',0,0,0,'',0),(23279,0,'','',10084,'Mounted filesystem discovery','vfs.fs.discovery',3600,90,0,0,4,'','',0,0,'',0,'','','','',0,'',NULL,NULL,'','','',0,0,'','','','',0,1,1,'','Discovery of file systems of different types as defined in global regular expression \"File systems for discovery\".',0,'30',0,0,0,'',0),(23280,0,'','',10084,'Incoming network traffic on $1','net.if.in[{#IFNAME}]',60,7,365,0,3,'','bps',1,1,'',0,'','','8','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,1,'','',0,'0',0,0,0,'',0),(23281,0,'','',10084,'Outgoing network traffic on $1','net.if.out[{#IFNAME}]',60,7,365,0,3,'','bps',1,1,'',0,'','','8','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,1,'','',0,'0',0,0,0,'',0),(23282,0,'','',10084,'Free inodes on $1 (percentage)','vfs.fs.inode[{#FSNAME},pfree]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,1,'','',0,'0',0,0,0,'',0),(23283,0,'','',10084,'Free disk space on $1','vfs.fs.size[{#FSNAME},free]',60,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,1,'','',0,'0',0,0,0,'',0),(23284,0,'','',10084,'Free disk space on $1 (percentage)','vfs.fs.size[{#FSNAME},pfree]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,1,'','',0,'0',0,0,0,'',0),(23285,0,'','',10084,'Total disk space on $1','vfs.fs.size[{#FSNAME},total]',3600,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,1,'','',0,'0',0,0,0,'',0),(23286,0,'','',10084,'Used disk space on $1','vfs.fs.size[{#FSNAME},used]',60,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,1,'','',0,'0',0,0,0,'',0),(23287,0,'','',10084,'Agent ping','agent.ping',60,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,10,'','','',0,0,'','','','',0,0,1,'','The agent always returns 1 for this item. It could be used in combination with nodata() for availability check.',0,'0',0,0,0,'',0),(23288,0,'','',10084,'Version of zabbix_agent(d) running','agent.version',3600,7,0,0,1,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,1,'','',0,'0',0,0,0,'',0),(23289,0,'','',10084,'Maximum number of opened files','kernel.maxfiles',3600,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,1,'','It could be increased by using sysctrl utility or modifying file /etc/sysctl.conf.',0,'0',0,0,0,'',0),(23290,0,'','',10084,'Maximum number of processes','kernel.maxproc',3600,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,1,'','It could be increased by using sysctrl utility or modifying file /etc/sysctl.conf.',0,'0',0,0,0,'',0),(23291,0,'','',10084,'Number of running processes','proc.num[,,run]',60,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,1,'','Number of processes in running state.',0,'0',0,0,0,'',0),(23292,0,'','',10084,'Number of processes','proc.num[]',60,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,1,'','Total number of processes in any state.',0,'0',0,0,0,'',0),(23293,0,'','',10084,'Host boot time','system.boottime',600,7,365,0,3,'','unixtime',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,1,'','',0,'0',0,0,0,'',0),(23294,0,'','',10084,'Interrupts per second','system.cpu.intr',60,7,365,0,3,'','ips',0,1,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,1,'','',0,'0',0,0,0,'',0),(23295,0,'','',10084,'Processor load (15 min average per core)','system.cpu.load[percpu,avg15]',60,7,365,0,0,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,1,'','The processor load is calculated as system CPU load divided by number of CPU cores.',0,'0',0,0,0,'',0),(23296,0,'','',10084,'Processor load (1 min average per core)','system.cpu.load[percpu,avg1]',60,7,365,0,0,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,1,'','The processor load is calculated as system CPU load divided by number of CPU cores.',0,'0',0,0,0,'',0),(23297,0,'','',10084,'Processor load (5 min average per core)','system.cpu.load[percpu,avg5]',60,7,365,0,0,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,1,'','The processor load is calculated as system CPU load divided by number of CPU cores.',0,'0',0,0,0,'',0),(23298,0,'','',10084,'Context switches per second','system.cpu.switches',60,7,365,0,3,'','sps',0,1,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,1,'','',0,'0',0,0,0,'',0),(23299,0,'','',10084,'CPU $2 time','system.cpu.util[,idle]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,1,'','The time the CPU has spent doing nothing.',0,'0',0,0,0,'',0),(23300,0,'','',10084,'CPU $2 time','system.cpu.util[,interrupt]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,1,'','The amount of time the CPU has been servicing hardware interrupts.',0,'0',0,0,0,'',0),(23301,0,'','',10084,'CPU $2 time','system.cpu.util[,iowait]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,1,'','Amount of time the CPU has been waiting for I/O to complete.',0,'0',0,0,0,'',0),(23302,0,'','',10084,'CPU $2 time','system.cpu.util[,nice]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,1,'','The time the CPU has spent running users\' processes that have been niced.',0,'0',0,0,0,'',0),(23303,0,'','',10084,'CPU $2 time','system.cpu.util[,softirq]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,1,'','The amount of time the CPU has been servicing software interrupts.',0,'0',0,0,0,'',0),(23304,0,'','',10084,'CPU $2 time','system.cpu.util[,steal]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,1,'','The amount of CPU \'stolen\' from this virtual machine by the hypervisor for other tasks (such as running another virtual machine).',0,'0',0,0,0,'',0),(23305,0,'','',10084,'CPU $2 time','system.cpu.util[,system]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,1,'','The time the CPU has spent running the kernel and its processes.',0,'0',0,0,0,'',0),(23306,0,'','',10084,'CPU $2 time','system.cpu.util[,user]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,1,'','The time the CPU has spent running users\' processes that are not niced.',0,'0',0,0,0,'',0),(23307,0,'','',10084,'Host name','system.hostname',3600,7,0,0,1,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,1,'','System host name.',3,'0',0,0,0,'',0),(23308,0,'','',10084,'Host local time','system.localtime',60,7,365,0,3,'','unixtime',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,1,'','',0,'0',0,0,0,'',0),(23309,0,'','',10084,'Free swap space','system.swap.size[,free]',60,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,1,'','',0,'0',0,0,0,'',0),(23310,0,'','',10084,'Free swap space in %','system.swap.size[,pfree]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,1,'','',0,'0',0,0,0,'',0),(23311,0,'','',10084,'Total swap space','system.swap.size[,total]',3600,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,1,'','',0,'0',0,0,0,'',0),(23312,0,'','',10084,'System information','system.uname',3600,7,0,0,1,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,1,'','The information as normally returned by \'uname -a\'.',5,'0',0,0,0,'',0),(23313,0,'','',10084,'System uptime','system.uptime',600,7,365,0,3,'','uptime',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,1,'','',0,'0',0,0,0,'',0),(23314,0,'','',10084,'Number of logged in users','system.users.num',60,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,1,'','Number of users who are currently logged in.',0,'0',0,0,0,'',0),(23315,0,'','',10084,'Checksum of $1','vfs.file.cksum[/etc/passwd]',3600,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,1,'','',0,'0',0,0,0,'',0),(23316,0,'','',10084,'Available memory','vm.memory.size[available]',60,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,1,'','Available memory is defined as free+cached+buffers memory.',0,'0',0,0,0,'',0),(23317,0,'','',10084,'Total memory','vm.memory.size[total]',3600,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,1,'','',0,'0',0,0,0,'',0),(23327,0,'','',10084,'Host name of zabbix_agentd running','agent.hostname',3600,7,0,0,1,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,1,'','',0,'30',0,0,0,'',0),(23328,5,'','',10084,'Zabbix $4 $2 processes, in %','zabbix[process,vmware collector,avg,busy]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(23620,5,'','',10084,'Zabbix value cache, % free','zabbix[vcache,buffer,pfree]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(23625,5,'','',10084,'Zabbix value cache hits','zabbix[vcache,cache,hits]',60,7,365,0,0,'','vps',0,1,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(23628,5,'','',10084,'Zabbix value cache misses','zabbix[vcache,cache,misses]',60,7,365,0,0,'','vps',0,1,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(23635,5,'','',10084,'Zabbix vmware cache, % free','zabbix[vmware,buffer,pfree]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(23662,5,'','',10084,'Zabbix value cache operating mode','zabbix[vcache,cache,mode]',60,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,15,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24705,0,'','',10084,'Get  zabbix database size','get-zabbix-database-size',86400,180,0,0,1,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,1,'','',0,'30',0,0,0,'',0),(24882,2,'','',10154,'avgqu-sz on $1','ceph.disk.avgqu',0,90,365,1,0,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24883,2,'','',10154,'avgrq-sz on $1','ceph.disk.avgrq',0,90,365,1,0,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24884,2,'','',10154,'await on $1','ceph.disk.await',0,90,365,1,0,'','ms',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24885,2,'','',10154,'Disk fill on $1','ceph.disk.fill',0,90,365,1,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24886,2,'','',10154,'Disk Health on $1','ceph.disk.health',0,90,0,1,1,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24887,2,'','',10154,'Current Pending Sector on $1','ceph.disk.pend_sec',0,90,365,1,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24888,2,'','',10154,'Raw Read Error Rate on $1','ceph.disk.raw_read_error',0,90,365,1,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24889,2,'','',10154,'rkB/s on $1','ceph.disk.rd',0,90,365,1,0,'','kb',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24890,2,'','',10154,'r/s on $1','ceph.disk.rd_op',0,90,365,1,0,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24891,2,'','',10154,'Reallocated Sector Ct on $1','ceph.disk.realloc_sec',0,90,365,1,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24892,2,'','',10154,'rrqm/s on $1','ceph.disk.rrqm',0,90,365,1,0,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24893,2,'','',10154,'r_await on $1','ceph.disk.r_await',0,90,365,1,0,'','ms',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24894,2,'','',10154,'SATA Disk list','ceph.disk.sata_disk_list',0,90,0,0,4,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24895,2,'','',10154,'SATA lifetime','ceph.disk.sata_lifetime',0,90,365,0,3,'','hours',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24896,2,'','',10154,'SSD Disk list','ceph.disk.ssd_disk_list',0,90,0,0,4,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24897,2,'','',10154,'SSD lifetime','ceph.disk.ssd_lifetime',0,90,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24898,2,'','',10154,'svctm on $1','ceph.disk.svctm',0,90,365,1,0,'','ms',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24899,2,'','',10154,'OS Disk list','ceph.disk.system_disk_list',0,90,0,0,4,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24900,2,'','',10154,'%util on $1','ceph.disk.util',0,90,365,1,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24901,2,'','',10154,'wkB/s on $1','ceph.disk.wr',0,90,365,1,0,'','kb',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24902,2,'','',10154,'wrqm/s on $1','ceph.disk.wrqm',0,90,365,1,0,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24903,2,'','',10154,'w/s on $1','ceph.disk.wr_op',0,90,365,1,0,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24904,2,'','',10154,'w_await on $1','ceph.disk.w_await',0,90,365,1,0,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24905,2,'','',10154,'Ceph log data','ceph.log_data',0,90,0,0,4,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24906,2,'','',10154,'Ceph Cluster network','ceph.net.cluster_network',0,90,0,0,1,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24907,2,'','',10154,'Hosts reachable','ceph.net.hosts_unreachable',0,90,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24908,2,'','',10154,'Network dropped packets on $1','ceph.net.packets_dropped',0,90,365,1,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24909,2,'','',10154,'Network errors packets on $1','ceph.net.packets_error',0,90,365,1,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24910,2,'','',10154,'Ceph Public network','ceph.net.public_network',0,90,0,0,1,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24911,2,'','',10154,'Number of Monitors','ceph.num_mon',0,90,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24912,2,'','',10154,'Number of Monitors in state: outside quorum','ceph.num_mon_outquorum',0,90,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24913,2,'','',10154,'Number of Monitors in state: quorum','ceph.num_mon_quorum',0,90,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24914,2,'','',10154,'Number of OSDs','ceph.num_osd',0,90,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24915,2,'','',10154,'Number of OSDs in state: DOWN','ceph.num_osd_down',0,90,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24916,2,'','',10154,'Number of OSDs in state: IN','ceph.num_osd_in',0,90,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24917,2,'','',10154,'Number of OSDs in state: UP','ceph.num_osd_up',0,90,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24918,2,'','',10154,'Number of Placement Groups','ceph.num_pg',0,90,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24919,2,'','',10154,'Number of Placement Groups in state: other','ceph.num_pg_abnormal',0,90,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24920,2,'','',10154,'Number of Placement Groups in state: active+clean','ceph.num_pg_clean',0,90,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24921,2,'','',10154,'Number of Placement Groups in state: no service','ceph.num_pg_noserve',0,90,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24922,2,'','',10154,'Number of Pools','ceph.num_pools',0,90,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24923,2,'','',10154,'Ceph osd perf','ceph.osd_perf',0,90,0,0,4,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24924,2,'','',10154,'Ceph OSD tree','ceph.osd_tree',0,90,0,0,4,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24925,2,'','',10154,'Overall Ceph status','ceph.overall_status',0,90,0,0,4,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24926,2,'','',10154,'Overal Ceph status (numeric)','ceph.overall_status_int',0,90,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24927,2,'','',10154,'Ceph Pool bytes','ceph.pool_bytes',0,90,365,0,3,'','kb',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24928,2,'','',10154,'Ceph Pool fill','ceph.pool_fill',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24929,2,'','',10154,'Ceph Pool fill0','ceph.pool_fill0',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24930,2,'','',10154,'Ceph Pool fill1','ceph.pool_fill1',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24931,2,'','',10154,'Ceph Pool fill2','ceph.pool_fill2',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24932,2,'','',10154,'Ceph Pool fill3','ceph.pool_fill3',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24933,2,'','',10154,'Ceph Pool fill4','ceph.pool_fill4',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24934,2,'','',10154,'Ceph Pool fill5','ceph.pool_fill5',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24935,2,'','',10154,'Ceph Pool fill6','ceph.pool_fill6',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24936,2,'','',10154,'Ceph Pool fill7','ceph.pool_fill7',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24937,2,'','',10154,'Ceph Pool fill8','ceph.pool_fill8',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24938,2,'','',10154,'Ceph Pool fill9','ceph.pool_fill9',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24939,2,'','',10154,'Ceph Pool fill10','ceph.pool_fill10',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24940,2,'','',10154,'Ceph Pool fill11','ceph.pool_fill11',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24941,2,'','',10154,'Ceph Pool fill12','ceph.pool_fill12',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24942,2,'','',10154,'Ceph Pool fill13','ceph.pool_fill13',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24943,2,'','',10154,'Ceph Pool fill14','ceph.pool_fill14',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24944,2,'','',10154,'Ceph Pool fill15','ceph.pool_fill15',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24945,2,'','',10154,'Ceph Pool fill16','ceph.pool_fill16',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24946,2,'','',10154,'Ceph Pool fill17','ceph.pool_fill17',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24947,2,'','',10154,'Ceph Pool fill18','ceph.pool_fill18',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24948,2,'','',10154,'Ceph Pool fill19','ceph.pool_fill19',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24949,2,'','',10154,'Ceph Pool fill20','ceph.pool_fill20',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24950,2,'','',10154,'Ceph Pool fill21','ceph.pool_fill21',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24951,2,'','',10154,'Ceph Pool fill22','ceph.pool_fill22',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24952,2,'','',10154,'Ceph Pool fill23','ceph.pool_fill23',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24953,2,'','',10154,'Ceph Pool fill24','ceph.pool_fill24',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24954,2,'','',10154,'Ceph Pool fill25','ceph.pool_fill25',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24955,2,'','',10154,'Ceph Pool fill26','ceph.pool_fill26',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24956,2,'','',10154,'Ceph Pool fill27','ceph.pool_fill27',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24957,2,'','',10154,'Ceph Pool fill28','ceph.pool_fill28',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24958,2,'','',10154,'Ceph Pool fill29','ceph.pool_fill29',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24959,2,'','',10154,'Ceph Pool fill30','ceph.pool_fill30',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24960,2,'','',10154,'Ceph Pool fill31','ceph.pool_fill31',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24961,2,'','',10154,'Ceph Pool fill32','ceph.pool_fill32',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24962,2,'','',10154,'Ceph Pool fill33','ceph.pool_fill33',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24963,2,'','',10154,'Ceph Pool fill34','ceph.pool_fill34',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24964,2,'','',10154,'Ceph Pool fill35','ceph.pool_fill35',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24965,2,'','',10154,'Ceph Pool fill36','ceph.pool_fill36',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24966,2,'','',10154,'Ceph Pool fill37','ceph.pool_fill37',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24967,2,'','',10154,'Ceph Pool fill38','ceph.pool_fill38',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24968,2,'','',10154,'Ceph Pool fill39','ceph.pool_fill39',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24969,2,'','',10154,'Ceph Pool fill40','ceph.pool_fill40',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24970,2,'','',10154,'Ceph Pool fill41','ceph.pool_fill41',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24971,2,'','',10154,'Ceph Pool fill42','ceph.pool_fill42',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24972,2,'','',10154,'Ceph Pool fill43','ceph.pool_fill43',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24973,2,'','',10154,'Ceph Pool fill44','ceph.pool_fill44',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24974,2,'','',10154,'Ceph Pool fill45','ceph.pool_fill45',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24975,2,'','',10154,'Ceph Pool fill46','ceph.pool_fill46',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24976,2,'','',10154,'Ceph Pool fill47','ceph.pool_fill47',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24977,2,'','',10154,'Ceph Pool fill48','ceph.pool_fill48',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24978,2,'','',10154,'Ceph Pool fill49','ceph.pool_fill49',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24979,2,'','',10154,'Ceph Pool fill50','ceph.pool_fill50',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24980,2,'','',10154,'Ceph Pool fill51','ceph.pool_fill51',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24981,2,'','',10154,'Ceph Pool fill52','ceph.pool_fill52',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24982,2,'','',10154,'Ceph Pool fill53','ceph.pool_fill53',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24983,2,'','',10154,'Ceph Pool fill54','ceph.pool_fill54',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24984,2,'','',10154,'Ceph Pool fill55','ceph.pool_fill55',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24985,2,'','',10154,'Ceph Pool fill56','ceph.pool_fill56',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24986,2,'','',10154,'Ceph Pool fill57','ceph.pool_fill57',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24987,2,'','',10154,'Ceph Pool fill58','ceph.pool_fill58',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24988,2,'','',10154,'Ceph Pool fill59','ceph.pool_fill59',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24989,2,'','',10154,'Ceph Pool fill60','ceph.pool_fill60',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24990,2,'','',10154,'Ceph Pool fill61','ceph.pool_fill61',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24991,2,'','',10154,'Ceph Pool fill62','ceph.pool_fill62',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24992,2,'','',10154,'Ceph Pool fill63','ceph.pool_fill63',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24993,2,'','',10154,'Ceph Pool fill64','ceph.pool_fill64',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24994,2,'','',10154,'Ceph Pool fill65','ceph.pool_fill65',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24995,2,'','',10154,'Ceph Pool fill66','ceph.pool_fill66',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24996,2,'','',10154,'Ceph Pool fill67','ceph.pool_fill67',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24997,2,'','',10154,'Ceph Pool fill68','ceph.pool_fill68',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24998,2,'','',10154,'Ceph Pool fill69','ceph.pool_fill69',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(24999,2,'','',10154,'Ceph Pool fill70','ceph.pool_fill70',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25000,2,'','',10154,'Ceph Pool fill71','ceph.pool_fill71',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25001,2,'','',10154,'Ceph Pool fill72','ceph.pool_fill72',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25002,2,'','',10154,'Ceph Pool fill73','ceph.pool_fill73',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25003,2,'','',10154,'Ceph Pool fill74','ceph.pool_fill74',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25004,2,'','',10154,'Ceph Pool fill75','ceph.pool_fill75',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25005,2,'','',10154,'Ceph Pool fill76','ceph.pool_fill76',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25006,2,'','',10154,'Ceph Pool fill77','ceph.pool_fill77',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25007,2,'','',10154,'Ceph Pool fill78','ceph.pool_fill78',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25008,2,'','',10154,'Ceph Pool fill79','ceph.pool_fill79',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25009,2,'','',10154,'Ceph Pool fill80','ceph.pool_fill80',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25010,2,'','',10154,'Ceph Pool fill81','ceph.pool_fill81',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25011,2,'','',10154,'Ceph Pool fill82','ceph.pool_fill82',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25012,2,'','',10154,'Ceph Pool fill83','ceph.pool_fill83',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25013,2,'','',10154,'Ceph Pool fill84','ceph.pool_fill84',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25014,2,'','',10154,'Ceph Pool fill85','ceph.pool_fill85',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25015,2,'','',10154,'Ceph Pool fill86','ceph.pool_fill86',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25016,2,'','',10154,'Ceph Pool fill87','ceph.pool_fill87',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25017,2,'','',10154,'Ceph Pool fill88','ceph.pool_fill88',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25018,2,'','',10154,'Ceph Pool fill89','ceph.pool_fill89',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25019,2,'','',10154,'Ceph Pool fill90','ceph.pool_fill90',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25020,2,'','',10154,'Ceph Pool fill91','ceph.pool_fill91',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25021,2,'','',10154,'Ceph Pool fill92','ceph.pool_fill92',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25022,2,'','',10154,'Ceph Pool fill93','ceph.pool_fill93',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25023,2,'','',10154,'Ceph Pool fill94','ceph.pool_fill94',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25024,2,'','',10154,'Ceph Pool fill95','ceph.pool_fill95',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25025,2,'','',10154,'Ceph Pool fill96','ceph.pool_fill96',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25026,2,'','',10154,'Ceph Pool fill97','ceph.pool_fill97',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25027,2,'','',10154,'Ceph Pool fill98','ceph.pool_fill98',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25028,2,'','',10154,'Ceph Pool fill99','ceph.pool_fill99',0,90,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25029,2,'','',10154,'Ceph Pool list','ceph.pool_list',0,90,0,0,4,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25030,2,'','',10154,'Ceph Pool clones','ceph.pool_num_clones',0,90,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25031,2,'','',10154,'Ceph Pool copies','ceph.pool_num_copies',0,90,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25032,2,'','',10154,'Ceph Pool degraded','ceph.pool_num_degraded',0,90,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25033,2,'','',10154,'Ceph Pool objects','ceph.pool_num_objects',0,90,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25034,2,'','',10154,'Ceph Pool rd ops','ceph.pool_ops_rd',0,90,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25035,2,'','',10154,'Ceph Pool wr ops','ceph.pool_ops_wr',0,90,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25036,2,'','',10154,'Ceph Pool rd','ceph.pool_rd',0,90,365,0,3,'','kb',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25037,2,'','',10154,'Ceph Pool wr','ceph.pool_wr',0,90,365,0,3,'','kb',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25038,2,'','',10154,'Ceph Read bandwidth','ceph.read_bw',0,90,365,0,3,'','b',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25039,2,'','',10154,'Ceph Read operations','ceph.read_iops',0,90,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25040,2,'','',10154,'Ceph Recover bandwidth','ceph.recovery_bw',0,90,365,0,3,'','b',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25041,2,'','',10154,'Total bytes available','ceph.total_avail_bytes',0,90,365,0,3,'','b',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25042,2,'','',10154,'Total bytes','ceph.total_bytes',0,90,365,0,3,'','b',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25043,2,'','',10154,'Total bytes fill','ceph.total_fill_bytes',0,90,365,0,0,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25044,2,'','',10154,'Total number of objects','ceph.total_objects',0,90,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25045,2,'','',10154,'Total bytes used','ceph.total_used_bytes',0,90,365,0,3,'','b',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25046,2,'','',10154,'Ceph Write bandwidth','ceph.write_bw',0,90,365,0,3,'','b',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25047,2,'','',10154,'Ceph Write operations','ceph.write_iops',0,90,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25048,2,'','',10154,'Ceph Scrub bandwidth','TBD',0,90,365,0,3,'','b',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25049,0,'','',10154,'ceph disk discovery','ceph.disk.scan',3600,90,0,0,4,'','',0,0,'',0,'','','','',0,'',NULL,NULL,'','','',0,0,'','','','',0,1,NULL,'','depend on command `iostat -dyx`',0,'1',0,0,0,'',0),(25050,0,'','',10155,'libvirtd','openstack.serviceexist[libvirtd]',60,180,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25051,0,'','',10155,'neutron-dhcp-agent','openstack.serviceexist[neutron-dhcp-agent]',60,180,365,1,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25052,0,'','',10155,'neutron-l3-agent','openstack.serviceexist[neutron-l3-agent]',60,180,365,1,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25053,0,'','',10155,'neutron-metadata-agent','openstack.serviceexist[neutron-metadata-agent]',60,180,365,1,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25054,0,'','',10155,'neutron-openvswitch-agent','openstack.serviceexist[neutron-openvswitch-agent]',60,180,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25055,0,'','',10155,'openstack-ceilometer-compute','openstack.serviceexist[openstack-ceilometer-compute]',60,180,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25056,0,'','',10155,'openstack-cinder-volume','openstack.serviceexist[openstack-cinder-volume]',60,180,365,1,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25057,0,'','',10155,'openstack-nova-compute','openstack.serviceexist[openstack-nova-compute]',60,180,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25058,0,'','',10155,'openvswitch','openstack.serviceexist[openvswitch]',60,180,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25059,0,'','',10156,'httpd','openstack.serviceexist[httpd]',60,180,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25060,0,'','',10156,'neutron-server','openstack.serviceexist[neutron-server]',60,180,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25061,0,'','',10156,'openstack-ceilometer-central','openstack.serviceexist[openstack-ceilometer-central]',60,180,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25062,0,'','',10156,'openstack-ceilometer-collector','openstack.serviceexist[openstack-ceilometer-collector]',60,180,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25063,0,'','',10156,'openstack-ceilometer-notification','openstack.serviceexist[openstack-ceilometer-notification]',60,180,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25064,0,'','',10156,'openstack-cinder-api','openstack.serviceexist[openstack-cinder-api]',60,180,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25065,0,'','',10156,'openstack-cinder-scheduler','openstack.serviceexist[openstack-cinder-scheduler]',60,180,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25066,0,'','',10156,'openstack-glance-api','openstack.serviceexist[openstack-glance-api]',60,180,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25067,0,'','',10156,'openstack-glance-registry','openstack.serviceexist[openstack-glance-registry]',60,180,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25068,0,'','',10156,'openstack-nova-api','openstack.serviceexist[openstack-nova-api]',60,180,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25069,0,'','',10156,'openstack-nova-cert','openstack.serviceexist[openstack-nova-cert]',60,180,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25070,0,'','',10156,'openstack-nova-conductor','openstack.serviceexist[openstack-nova-conductor]',60,180,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25071,0,'','',10156,'openstack-nova-consoleauth','openstack.serviceexist[openstack-nova-consoleauth]',60,180,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25072,0,'','',10156,'openstack-nova-novncproxy','openstack.serviceexist[openstack-nova-novncproxy]',60,180,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25073,0,'','',10156,'openstack-nova-scheduler','openstack.serviceexist[openstack-nova-scheduler]',60,180,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25074,0,'','',10157,'httpd','openstack.serviceexist[httpd]',60,180,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25075,0,'','',10158,'Openstack service haproxy','openstack.serviceexist[haproxy]',60,180,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25076,0,'','',10158,'Openstack service keepalived','openstack.serviceexist[keepalived]',60,180,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25077,0,'','',10159,'neutron-l3-agent','openstack.serviceexist[neutron-l3-agent]',60,180,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25078,0,'','',10159,'neutron-lbaasv2-agent','openstack.serviceexist[neutron-lbaasv2-agent]',60,180,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25079,0,'','',10159,'neutron-openvswitch-agent','openstack.serviceexist[neutron-openvswitch-agent]',60,180,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25080,0,'','',10160,'memcached','openstack.serviceexist[memcached]',60,180,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25081,0,'','',10161,'mysqld','openstack.serviceexist[mysqldi]',60,180,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25082,0,'','',10161,'xinetd','openstack.serviceexist[xinetd]',60,180,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25083,0,'','',10162,'nova-novncproxy','openstack.serviceexist[nova-novncproxy]',60,180,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25084,0,'','',10163,'ntpd','openstack.serviceexist[ntpd]',60,180,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25085,0,'','',10164,'rabbitmq-server','openstack.serviceexist[rabbitmq-server]',60,180,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25086,0,'','',10165,'ceph-pronum','ceph.pnum[ceph]',60,180,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25087,0,'','',10166,'CEPH_osd_df','ceph.osd_df',60,180,0,0,1,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25088,0,'','',10166,'CEPH_osd_perf','ceph.osd_perf',60,180,0,0,1,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25089,0,'','',10166,'CEPH_osd_pool_stats','ceph.osd_pool_stats',60,180,0,0,1,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25090,0,'','',10166,'CEPH_osd_tree','ceph.osd_tree',60,180,0,0,1,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25091,0,'','',10166,'CEPH_pg_stat','ceph.pg_stat',60,180,0,0,1,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25092,0,'','',10166,'CEPH_status','ceph.status',60,180,0,0,1,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25093,0,'','',10166,'Ceph_warn','ceph.warn',60,180,0,0,1,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25094,0,'','',10168,'MySQL status','mysql.ping',60,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,1,'','','',0,0,'','','','',0,0,NULL,'','It requires user parameter mysql.ping, which is defined in userparameter_mysql.conf.\r\n\r\n0 - MySQL server is down\r\n1 - MySQL server is up',0,'30',0,0,0,'',0),(25095,0,'','',10168,'MySQL bytes received per second','mysql.status[Bytes_received]',60,7,365,0,0,'','Bps',0,1,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','The number of bytes received from all clients. \r\n\r\nIt requires user parameter mysql.status[*], which is defined in \r\nuserparameter_mysql.conf.',0,'30',0,0,0,'',0),(25096,0,'','',10168,'MySQL bytes sent per second','mysql.status[Bytes_sent]',60,7,365,0,0,'','Bps',0,1,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','The number of bytes sent to all clients.\r\n\r\nIt requires user parameter mysql.status[*], which is defined in userparameter_mysql.conf.',0,'30',0,0,0,'',0),(25097,0,'','',10168,'MySQL begin operations per second','mysql.status[Com_begin]',60,7,365,0,0,'','qps',0,1,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','It requires user parameter mysql.status[*], which is defined in userparameter_mysql.conf.',0,'30',0,0,0,'',0),(25098,0,'','',10168,'MySQL commit operations per second','mysql.status[Com_commit]',60,7,365,0,0,'','qps',0,1,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','It requires user parameter mysql.status[*], which is defined in userparameter_mysql.conf.',0,'30',0,0,0,'',0),(25099,0,'','',10168,'MySQL delete operations per second','mysql.status[Com_delete]',60,7,365,0,0,'','qps',0,1,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','It requires user parameter mysql.status[*], which is defined in userparameter_mysql.conf.',0,'30',0,0,0,'',0),(25100,0,'','',10168,'MySQL insert operations per second','mysql.status[Com_insert]',60,7,365,0,0,'','qps',0,1,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','It requires user parameter mysql.status[*], which is defined in userparameter_mysql.conf.',0,'30',0,0,0,'',0),(25101,0,'','',10168,'MySQL rollback operations per second','mysql.status[Com_rollback]',60,7,365,0,0,'','qps',0,1,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','It requires user parameter mysql.status[*], which is defined in userparameter_mysql.conf.',0,'30',0,0,0,'',0),(25102,0,'','',10168,'MySQL select operations per second','mysql.status[Com_select]',60,7,365,0,0,'','qps',0,1,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','It requires user parameter mysql.status[*], which is defined in userparameter_mysql.conf.',0,'30',0,0,0,'',0),(25103,0,'','',10168,'MySQL update operations per second','mysql.status[Com_update]',60,7,365,0,0,'','qps',0,1,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','It requires user parameter mysql.status[*], which is defined in userparameter_mysql.conf.',0,'30',0,0,0,'',0),(25104,0,'','',10168,'MySQL queries per second','mysql.status[Questions]',60,7,365,0,0,'','qps',0,1,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','It requires user parameter mysql.status[*], which is defined in userparameter_mysql.conf.',0,'30',0,0,0,'',0),(25105,0,'','',10168,'MySQL slow queries','mysql.status[Slow_queries]',60,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','It requires user parameter mysql.status[*], which is defined in userparameter_mysql.conf.',0,'30',0,0,0,'',0),(25106,0,'','',10168,'MySQL uptime','mysql.status[Uptime]',60,7,365,0,3,'','uptime',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','It requires user parameter mysql.status[*], which is defined in userparameter_mysql.conf.',0,'30',0,0,0,'',0),(25107,0,'','',10168,'MySQL version','mysql.version',3600,7,0,0,1,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','It requires user parameter mysql.version, which is defined in userparameter_mysql.conf.',0,'30',0,0,0,'',0),(25108,0,'','',10169,'Openstack_service_libvirtd','openstack.serviceexist[libvirtd]',60,180,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25109,0,'','',10169,'Openstack_service_neutron_l3_agent','openstack.serviceexist[ neutron-l3-agent]',60,180,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25110,0,'','',10169,'Openstack_service_neutron_metadata_agent','openstack.serviceexist[neutron-metadata-agent]',60,180,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25111,0,'','',10169,'Openstack_service_neutron_openvswitch_agent','openstack.serviceexist[neutron-openvswitch-agent]',60,180,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25112,0,'','',10169,'Openstack_service_cinder_volume','openstack.serviceexist[openstack-cinder-volume]',60,180,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25113,0,'','',10169,'Openstack_service_nova_compute','openstack.serviceexist[openstack-nova-compute]',60,180,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25114,0,'','',10170,'check cinder process status','check-process-status-openstack[cinder]',120,90,0,0,1,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25115,0,'','',10170,'check neutron process status','check-process-status-openstack[neutron]',120,90,0,0,1,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25116,0,'','',10170,'check nova process status','check-process-status-openstack[nova]',30,90,0,0,4,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25117,3,'','',10171,'SSH service is running','net.tcp.service[ssh]',60,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,1,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25118,7,'','',10172,'Agent ping','agent.ping',60,180,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,10,'','','',0,0,'','','','',0,0,NULL,'','The agent always returns 1 for this item. It could be used in combination with nodata() for availability check.',0,'30',0,0,0,'',0),(25119,5,'','',10173,'Zabbix $4 $2 processes, in %','zabbix[process,configuration syncer,avg,busy]',60,180,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25120,5,'','',10173,'Zabbix $4 $2 processes, in %','zabbix[process,data sender,avg,busy]',60,180,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25121,5,'','',10173,'Zabbix $4 $2 processes, in %','zabbix[process,discoverer,avg,busy]',60,180,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25122,5,'','',10173,'Zabbix $4 $2 processes, in %','zabbix[process,heartbeat sender,avg,busy]',60,180,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25123,5,'','',10173,'Zabbix $4 $2 processes, in %','zabbix[process,history syncer,avg,busy]',60,180,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25124,5,'','',10173,'Zabbix $4 $2 processes, in %','zabbix[process,housekeeper,avg,busy]',60,180,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25125,5,'','',10173,'Zabbix $4 $2 processes, in %','zabbix[process,http poller,avg,busy]',60,180,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25126,5,'','',10173,'Zabbix $4 $2 processes, in %','zabbix[process,icmp pinger,avg,busy]',60,180,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25127,5,'','',10173,'Zabbix $4 $2 processes, in %','zabbix[process,ipmi poller,avg,busy]',60,180,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25128,5,'','',10173,'Zabbix $4 $2 processes, in %','zabbix[process,java poller,avg,busy]',60,180,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25129,5,'','',10173,'Zabbix $4 $2 processes, in %','zabbix[process,poller,avg,busy]',60,180,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25130,5,'','',10173,'Zabbix $4 $2 processes, in %','zabbix[process,self-monitoring,avg,busy]',60,180,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25131,5,'','',10173,'Zabbix $4 $2 processes, in %','zabbix[process,snmp trapper,avg,busy]',60,180,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25132,5,'','',10173,'Zabbix $4 $2 processes, in %','zabbix[process,trapper,avg,busy]',60,180,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25133,5,'','',10173,'Zabbix $4 $2 processes, in %','zabbix[process,unreachable poller,avg,busy]',60,180,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25134,5,'','',10173,'Zabbix queue over $2','zabbix[queue,10m]',600,180,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25135,5,'','',10173,'Zabbix queue','zabbix[queue]',60,180,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25136,5,'','',10173,'Zabbix configuration cache, % free','zabbix[rcache,buffer,pfree]',60,180,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25137,5,'','',10173,'Zabbix $2 write cache, % free','zabbix[wcache,history,pfree]',60,180,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25138,5,'','',10173,'Zabbix $2 write cache, % free','zabbix[wcache,text,pfree]',60,180,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25139,5,'','',10173,'Values processed by Zabbix proxy per second','zabbix[wcache,values]',60,180,365,0,0,'','',0,1,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25140,0,'','',10174,'Get  zabbix database size','get-zabbix-database-size',86400,180,0,0,1,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25141,5,'','',10174,'Zabbix $4 $2 processes, in %','zabbix[process,alerter,avg,busy]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25142,5,'','',10174,'Zabbix $4 $2 processes, in %','zabbix[process,configuration syncer,avg,busy]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25143,5,'','',10174,'Zabbix $4 $2 processes, in %','zabbix[process,db watchdog,avg,busy]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25144,5,'','',10174,'Zabbix $4 $2 processes, in %','zabbix[process,discoverer,avg,busy]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25145,5,'','',10174,'Zabbix $4 $2 processes, in %','zabbix[process,escalator,avg,busy]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25146,5,'','',10174,'Zabbix $4 $2 processes, in %','zabbix[process,history syncer,avg,busy]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25147,5,'','',10174,'Zabbix $4 $2 processes, in %','zabbix[process,housekeeper,avg,busy]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25148,5,'','',10174,'Zabbix $4 $2 processes, in %','zabbix[process,http poller,avg,busy]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25149,5,'','',10174,'Zabbix $4 $2 processes, in %','zabbix[process,icmp pinger,avg,busy]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25150,5,'','',10174,'Zabbix $4 $2 processes, in %','zabbix[process,ipmi poller,avg,busy]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25151,5,'','',10174,'Zabbix $4 $2 processes, in %','zabbix[process,java poller,avg,busy]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25152,5,'','',10174,'Zabbix $4 $2 processes, in %','zabbix[process,poller,avg,busy]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25153,5,'','',10174,'Zabbix $4 $2 processes, in %','zabbix[process,proxy poller,avg,busy]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25154,5,'','',10174,'Zabbix $4 $2 processes, in %','zabbix[process,self-monitoring,avg,busy]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25155,5,'','',10174,'Zabbix $4 $2 processes, in %','zabbix[process,snmp trapper,avg,busy]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25156,5,'','',10174,'Zabbix $4 $2 processes, in %','zabbix[process,timer,avg,busy]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25157,5,'','',10174,'Zabbix $4 $2 processes, in %','zabbix[process,trapper,avg,busy]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25158,5,'','',10174,'Zabbix $4 $2 processes, in %','zabbix[process,unreachable poller,avg,busy]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25159,5,'','',10174,'Zabbix $4 $2 processes, in %','zabbix[process,vmware collector,avg,busy]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25160,5,'','',10174,'Zabbix queue over $2','zabbix[queue,10m]',600,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25161,5,'','',10174,'Zabbix queue','zabbix[queue]',600,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25162,5,'','',10174,'Zabbix configuration cache, % free','zabbix[rcache,buffer,pfree]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25163,5,'','',10174,'Zabbix value cache, % free','zabbix[vcache,buffer,pfree]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25164,5,'','',10174,'Zabbix value cache hits','zabbix[vcache,cache,hits]',60,7,365,0,0,'','vps',0,1,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25165,5,'','',10174,'Zabbix value cache misses','zabbix[vcache,cache,misses]',60,7,365,0,0,'','vps',0,1,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25166,5,'','',10174,'Zabbix value cache operating mode','zabbix[vcache,cache,mode]',60,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,15,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25167,5,'','',10174,'Zabbix vmware cache, % free','zabbix[vmware,buffer,pfree]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25168,5,'','',10174,'Zabbix $2 write cache, % free','zabbix[wcache,history,pfree]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25169,5,'','',10174,'Zabbix history index cache, % free','zabbix[wcache,index,pfree]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25170,5,'','',10174,'Zabbix $2 write cache, % free','zabbix[wcache,trend,pfree]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25171,5,'','',10174,'Values processed by Zabbix server per second','zabbix[wcache,values]',60,7,365,0,0,'','',0,1,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25172,3,'','',10175,'ICMP ping','icmpping',60,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,1,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25173,3,'','',10175,'ICMP loss','icmppingloss',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25174,3,'','',10175,'ICMP response time','icmppingsec',60,7,365,0,0,'','s',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25175,12,'','',10176,'BB +1.8V SM','bb_1.8v_sm',60,7,365,0,0,'','V',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','BB +1.8V SM',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25176,12,'','',10176,'BB +3.3V','bb_3.3v',60,7,365,0,0,'','V',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','BB +3.3V',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25177,12,'','',10176,'BB +3.3V STBY','bb_3.3v_stby',60,7,365,0,0,'','V',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','BB +3.3V STBY',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25178,12,'','',10176,'BB +5.0V','bb_5.0v',60,7,365,0,0,'','V',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','BB +5.0V',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25179,12,'','',10176,'BB Ambient Temp','bb_ambient_temp',60,7,365,0,0,'','C',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','BB Ambient Temp',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25180,12,'','',10176,'Power','power',60,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','power',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25181,12,'','',10176,'Processor Vcc','processor_vcc',60,7,365,0,0,'','V',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','Processor Vcc',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25182,12,'','',10176,'System Fan 3','system_fan_3',60,7,365,0,0,'','RPM',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','System Fan 3',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25183,12,'','',10177,'Baseboard Temp','baseboard_temp',60,7,365,0,0,'','C',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','Baseboard Temp',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25184,12,'','',10177,'BB +1.05V PCH','bb_1.05v_pch',60,7,365,0,0,'','V',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','BB +1.05V PCH',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25185,12,'','',10177,'BB +1.1V P1 Vccp','bb_1.1v_p1_vccp',60,7,365,0,0,'','V',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','BB +1.1V P1 Vccp',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25186,12,'','',10177,'BB +1.5V P1 DDR3','bb_1.5v_p1_ddr3',60,7,365,0,0,'','V',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','BB +1.5V P1 DDR3',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25187,12,'','',10177,'BB +3.3V','bb_3.3v',60,7,365,0,0,'','V',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','BB +3.3V',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25188,12,'','',10177,'BB +3.3V STBY','bb_3.3v_stby',60,7,365,0,0,'','V',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','BB +3.3V STBY',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25189,12,'','',10177,'BB +5.0V','bb_5.0v',60,7,365,0,0,'','V',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','BB +5.0V',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25190,12,'','',10177,'Front Panel Temp','front_panel_temp',60,7,365,0,0,'','C',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','Front Panel Temp',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25191,12,'','',10177,'Power','power',60,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','power',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25192,12,'','',10177,'System Fan 2','system_fan_2',60,7,365,0,0,'','RPM',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','System Fan 2',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25193,12,'','',10177,'System Fan 3','system_fan_3',60,7,365,0,0,'','RPM',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','System Fan 3',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25194,7,'','',10178,'Agent ping','agent.ping',60,180,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,10,'','','',0,0,'','','','',0,0,NULL,'','The agent always returns 1 for this item. It could be used in combination with nodata() for availability check.',0,'30',0,0,0,'',0),(25195,7,'','',10178,'Maximum number of opened files','kernel.maxfiles',3600,180,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','Maximum number of opened files',0,'30',0,0,0,'',0),(25196,7,'','',10178,'Maximum number of processes','kernel.maxproc',3600,180,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','Maximum number of processes',0,'30',0,0,0,'',0),(25197,7,'','',10178,'Host boot time','system.boottime',600,180,365,0,3,'','unixtime',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','Host boot time',0,'30',0,0,0,'',0),(25198,7,'','',10178,'Highload CPU index','system.cpu.highload[CpuNumber]',60,180,365,0,0,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','The index of the first CPU reaching 100%',0,'30',0,0,0,'',0),(25199,7,'','',10178,'Total highload CPU number','system.cpu.highload[CpuTotal]',60,180,365,0,0,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25200,7,'','',10178,'Interrupts per second','system.cpu.intr',60,180,365,0,3,'','ips',0,1,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','Interrupts per second',0,'30',0,0,0,'',0),(25201,7,'','',10178,'Processor load (1 min average per core)','system.cpu.load[percpu,avg1]',60,180,365,0,0,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','The processor load is calculated as system CPU load divided by number of CPU cores.(1 minute)',0,'30',0,0,0,'',0),(25202,7,'','',10178,'Processor load (5 min average per core)','system.cpu.load[percpu,avg5]',60,180,365,0,0,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','The processor load is calculated as system CPU load divided by number of CPU cores.(5 minutes)',0,'30',0,0,0,'',0),(25203,7,'','',10178,'Processor load (15 min average per core)','system.cpu.load[percpu,avg15]',60,180,365,0,0,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','The processor load is calculated as system CPU load divided by number of CPU cores.(15 minutes)',0,'30',0,0,0,'',0),(25204,7,'','',10178,'Context switches per second','system.cpu.switches',600,180,365,0,3,'','sps',0,1,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','Context switches per second on host',0,'30',0,0,0,'',0),(25205,7,'','',10178,'Highload CPU process','system.cpu.top',60,180,0,0,1,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','The first process id whose CPU reaches100%',0,'30',0,0,0,'',0),(25206,7,'','',10178,'CPU $2 time','system.cpu.util[,idle]',120,180,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','The time the CPU has spent doing nothing.',0,'30',0,0,0,'',0),(25207,7,'','',10178,'CPU $2 time','system.cpu.util[,interrupt]',60,180,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','Hardware interrupt time.',0,'30',0,0,0,'',0),(25208,7,'','',10178,'CPU $2 time','system.cpu.util[,iowait]',60,180,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','CPU iowait time',0,'30',0,0,0,'',0),(25209,7,'','',10178,'CPU $2 time','system.cpu.util[,nice]',120,180,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','CPU nice time',0,'30',0,0,0,'',0),(25210,7,'','',10178,'CPU $2 time','system.cpu.util[,softirq]',60,180,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','Software interrupt time',0,'30',0,0,0,'',0),(25211,7,'','',10178,'CPU $2 time','system.cpu.util[,steal]',60,180,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','The amount of CPU \'stolen\' from this virtual machine by the hypervisor for other tasks (such as running another virtual machine).',0,'30',0,0,0,'',0),(25212,7,'','',10178,'CPU $2 time','system.cpu.util[,system]',120,180,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','CPU system time',0,'30',0,0,0,'',0),(25213,7,'','',10178,'CPU $2 time','system.cpu.util[,user]',120,180,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','CPU time spent in user space',0,'30',0,0,0,'',0),(25214,7,'','',10178,'Host name','system.hostname',3600,14,0,0,1,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','Host name',3,'30',0,0,0,'',0),(25215,7,'','',10178,'System information','system.uname',3600,180,0,0,1,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','The information as normally returned by \'uname -a\'.',5,'30',0,0,0,'',0),(25216,7,'','',10178,'System uptime','system.uptime',600,180,365,0,3,'','uptime',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','System uptime',0,'30',0,0,0,'',0),(25217,7,'','',10178,'Number of logged in users','system.users.num',60,180,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','Number of logged in users',0,'30',0,0,0,'',0),(25218,7,'','',10178,'Checksum of $1','vfs.file.cksum[/etc/passwd]',60,3,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','Check whether the password is changed',0,'30',0,0,0,'',0),(25219,7,'','',10178,'Available memory','vm.memory.size[available]',60,180,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','Available memory',0,'30',0,0,0,'',0),(25220,7,'','',10178,'Total memory','vm.memory.size[total]',3600,180,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25221,7,'','',10179,'Agent ping','agent.ping',60,180,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,10,'','','',0,0,'','','','',0,0,NULL,'','The agent always returns 1 for this item. It could be used in combination with nodata() for availability check.',0,'30',0,0,0,'',0),(25222,0,'','',10179,'File read bytes per second','perf_counter[\\2\\16]',60,180,365,0,0,'','Bps',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','Full counter name: \\System\\File Read Bytes/sec',0,'30',0,0,0,'',0),(25223,0,'','',10179,'File write bytes per second','perf_counter[\\2\\18]',60,180,365,0,0,'','Bps',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','Full counter name: \\System\\File Write Bytes/sec',0,'30',0,0,0,'',0),(25224,0,'','',10179,'Number of threads','perf_counter[\\2\\250]',60,180,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','Full counter name: \\System\\Threads',0,'30',0,0,0,'',0),(25225,0,'','',10179,'Average disk read queue length','perf_counter[\\234(_Total)\\1402]',60,180,365,0,0,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','Full counter name: \\PhysicalDisk(_Total)\\Avg. Disk Read Queue Length',0,'30',0,0,0,'',0),(25226,0,'','',10179,'Average disk write queue length','perf_counter[\\234(_Total)\\1404]',60,180,365,0,0,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','Full counter name: \\PhysicalDisk(_Total)\\Avg. Disk Write Queue Length',0,'30',0,0,0,'',0),(25227,0,'','',10179,'Number of processes','proc.num[]',60,180,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25228,0,'','',10179,'Processor load (1 min average)','system.cpu.load[percpu,avg1]',60,180,365,0,0,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25229,0,'','',10179,'Processor load (5 min average)','system.cpu.load[percpu,avg5]',60,180,365,0,0,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25230,0,'','',10179,'Processor load (15 min average)','system.cpu.load[percpu,avg15]',60,180,365,0,0,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25231,0,'','',10179,'Free swap space','system.swap.size[,free]',60,180,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25232,0,'','',10179,'Total swap space','system.swap.size[,total]',3600,180,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25233,0,'','',10179,'System information','system.uname',3600,180,0,0,1,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',5,'30',0,0,0,'',0),(25234,0,'','',10179,'System uptime','system.uptime',60,180,365,0,3,'','uptime',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25235,0,'','',10179,'Free memory','vm.memory.size[free]',60,180,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25236,0,'','',10179,'Total memory','vm.memory.size[total]',3600,180,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25237,4,'{$SNMP_COMMUNITY}','SNMPv2-MIB::sysContact.0',10181,'Device contact details','sysContact',3600,7,0,0,1,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','The textual identification of the contact person for this managed node, together with information on how to contact this person.  If no contact information is known, the value is the zero-length string.',23,'30',0,0,0,'',0),(25238,4,'{$SNMP_COMMUNITY}','SNMPv2-MIB::sysDescr.0',10181,'Device description','sysDescr',3600,7,0,0,1,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','A textual description of the entity.  This value should include the full name and version identification of the system\'s hardware type, software operating-system, and networking software.',14,'30',0,0,0,'',0),(25239,4,'{$SNMP_COMMUNITY}','SNMPv2-MIB::sysLocation.0',10181,'Device location','sysLocation',3600,7,0,0,1,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','The physical location of this node (e.g., `telephone closet, 3rd floor\').  If the location is unknown, the value is the zero-length string.',24,'30',0,0,0,'',0),(25240,4,'{$SNMP_COMMUNITY}','SNMPv2-MIB::sysName.0',10181,'Device name','sysName',3600,7,0,0,1,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','An administratively-assigned name for this managed node. By convention, this is the node\'s fully-qualified domain name.  If the name is unknown, the value is the zero-length string.',3,'30',0,0,0,'',0),(25241,4,'{$SNMP_COMMUNITY}','SNMPv2-MIB::sysUpTime.0',10181,'Device uptime','sysUpTime',60,7,365,0,3,'','uptime',1,0,'',0,'','','0.01','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','The time since the network management portion of the system was last re-initialized.',0,'30',0,0,0,'',0),(25242,4,'{$SNMP_COMMUNITY}','IF-MIB::ifNumber.0',10182,'Number of network interfaces','ifNumber',3600,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,NULL,'','The number of network interfaces (regardless of their current state) present on this system.',0,'30',0,0,0,'',0),(25243,3,'','',10184,'Event log','vmware.eventlog[{$URL}]',60,90,0,0,2,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25244,3,'','',10184,'Full name','vmware.fullname[{$URL}]',3600,90,0,0,1,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25245,3,'','',10184,'Version','vmware.version[{$URL}]',3600,90,0,0,1,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25246,3,'','',10185,'Cluster name','vmware.vm.cluster.name[{$URL},{HOST.HOST}]',3600,90,0,0,1,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,0,NULL,'','Cluster name of the guest VM.',0,'30',0,0,0,'',0),(25247,3,'','',10185,'Number of virtual CPUs','vmware.vm.cpu.num[{$URL},{HOST.HOST}]',60,90,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,0,NULL,'','Number of virtual CPUs assigned to the guest.',0,'30',0,0,0,'',0),(25248,3,'','',10185,'CPU ready','vmware.vm.cpu.ready[{$URL},{HOST.HOST}]',60,90,365,0,3,'','ms',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,0,NULL,'','Time that the virtual machine was ready, but could not get scheduled to run on the physical CPU during last measurement interval (VMware vCenter/ESXi Server performance counter sampling interval - 20 seconds)',0,'30',0,0,0,'',0),(25249,3,'','',10185,'CPU usage','vmware.vm.cpu.usage[{$URL},{HOST.HOST}]',60,90,365,0,3,'','Hz',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,0,NULL,'','Current upper-bound on CPU usage. The upper-bound is based on the host the virtual machine is current running on, as well as limits configured on the virtual machine itself or any parent resource pool. Valid while the virtual machine is running.',0,'30',0,0,0,'',0),(25250,3,'','',10185,'Datacenter name','vmware.vm.datacenter.name[{$URL},{HOST.HOST}]',60,90,0,0,1,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,0,NULL,'','Datacenter name of the guest VM.',0,'30',0,0,0,'',0),(25251,3,'','',10185,'Hypervisor name','vmware.vm.hv.name[{$URL},{HOST.HOST}]',3600,90,0,0,1,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,0,NULL,'','Hypervisor name of the guest VM.',0,'30',0,0,0,'',0),(25252,3,'','',10185,'Ballooned memory','vmware.vm.memory.size.ballooned[{$URL},{HOST.HOST}]',60,90,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,0,NULL,'','The amount of guest physical memory that is currently reclaimed through the balloon driver.',0,'30',0,0,0,'',0),(25253,3,'','',10185,'Compressed memory','vmware.vm.memory.size.compressed[{$URL},{HOST.HOST}]',60,90,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,0,NULL,'','The amount of memory currently in the compression cache for this VM.',0,'30',0,0,0,'',0),(25254,3,'','',10185,'Private memory','vmware.vm.memory.size.private[{$URL},{HOST.HOST}]',60,90,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,0,NULL,'','Amount of memory backed by host memory and not being shared.',0,'30',0,0,0,'',0),(25255,3,'','',10185,'Shared memory','vmware.vm.memory.size.shared[{$URL},{HOST.HOST}]',60,90,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,0,NULL,'','The amount of guest physical memory shared through transparent page sharing.',0,'30',0,0,0,'',0),(25256,3,'','',10185,'Swapped memory','vmware.vm.memory.size.swapped[{$URL},{HOST.HOST}]',60,90,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,0,NULL,'','The amount of guest physical memory swapped out to the VM\'s swap device by ESX.',0,'30',0,0,0,'',0),(25257,3,'','',10185,'Guest memory usage','vmware.vm.memory.size.usage.guest[{$URL},{HOST.HOST}]',60,90,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,0,NULL,'','The amount of guest physical memory that is being used by the VM.',0,'30',0,0,0,'',0),(25258,3,'','',10185,'Host memory usage','vmware.vm.memory.size.usage.host[{$URL},{HOST.HOST}]',60,90,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,0,NULL,'','The amount of host physical memory allocated to the VM, accounting for saving from memory sharing with other VMs.',0,'30',0,0,0,'',0),(25259,3,'','',10185,'Memory size','vmware.vm.memory.size[{$URL},{HOST.HOST}]',60,90,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,0,NULL,'','Total size of configured memory.',0,'30',0,0,0,'',0),(25260,3,'','',10185,'Power state','vmware.vm.powerstate[{$URL},{HOST.HOST}]',60,90,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,12,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,0,NULL,'','The current power state of the virtual machine.',0,'30',0,0,0,'',0),(25261,3,'','',10185,'Committed storage space','vmware.vm.storage.committed[{$URL},{HOST.HOST}]',60,90,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,0,NULL,'','Total storage space, in bytes, committed to this virtual machine across all datastores.',0,'30',0,0,0,'',0),(25262,3,'','',10185,'Uncommitted storage space','vmware.vm.storage.uncommitted[{$URL},{HOST.HOST}]',60,90,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,0,NULL,'','Additional storage space, in bytes, potentially used by this virtual machine on all datastores.',0,'30',0,0,0,'',0),(25263,3,'','',10185,'Unshared storage space','vmware.vm.storage.unshared[{$URL},{HOST.HOST}]',60,90,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,0,NULL,'','Total storage space, in bytes, occupied by the virtual machine across all datastores, that is not shared with any other virtual machine.',0,'30',0,0,0,'',0),(25264,3,'','',10185,'Uptime','vmware.vm.uptime[{$URL},{HOST.HOST}]',60,90,365,0,3,'','uptime',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,0,NULL,'','System uptime.',0,'30',0,0,0,'',0),(25265,3,'','',10186,'Cluster name','vmware.hv.cluster.name[{$URL},{HOST.HOST}]',3600,90,0,0,1,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,0,NULL,'','Cluster name of the guest VM.',0,'30',0,0,0,'',0),(25266,3,'','',10186,'CPU usage','vmware.hv.cpu.usage[{$URL},{HOST.HOST}]',60,90,365,0,3,'','Hz',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,0,NULL,'','Aggregated CPU usage across all cores on the host in Hz. This is only available if the host is connected.',0,'30',0,0,0,'',0),(25267,3,'','',10186,'Datacenter name','vmware.hv.datacenter.name[{$URL},{HOST.HOST}]',60,90,0,0,1,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,0,NULL,'','Datacenter name of the hypervisor.',0,'30',0,0,0,'',0),(25268,3,'','',10186,'Full name','vmware.hv.fullname[{$URL},{HOST.HOST}]',3600,90,0,0,1,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,0,NULL,'','The complete product name, including the version information.',0,'30',0,0,0,'',0),(25269,3,'','',10186,'CPU frequency','vmware.hv.hw.cpu.freq[{$URL},{HOST.HOST}]',3600,90,365,0,3,'','Hz',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,0,NULL,'','The speed of the CPU cores. This is an average value if there are multiple speeds. The product of CPU frequency and number of cores is approximately equal to the sum of the MHz for all the individual cores on the host.',0,'30',0,0,0,'',0),(25270,3,'','',10186,'CPU model','vmware.hv.hw.cpu.model[{$URL},{HOST.HOST}]',3600,90,0,0,1,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,0,NULL,'','The CPU model.',0,'30',0,0,0,'',0),(25271,3,'','',10186,'CPU cores','vmware.hv.hw.cpu.num[{$URL},{HOST.HOST}]',3600,90,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,0,NULL,'','Number of physical CPU cores on the host. Physical CPU cores are the processors contained by a CPU package.',0,'30',0,0,0,'',0),(25272,3,'','',10186,'CPU threads','vmware.hv.hw.cpu.threads[{$URL},{HOST.HOST}]',3600,90,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,0,NULL,'','Number of physical CPU threads on the host.',0,'30',0,0,0,'',0),(25273,3,'','',10186,'Total memory','vmware.hv.hw.memory[{$URL},{HOST.HOST}]',3600,90,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,0,NULL,'','The physical memory size.',0,'30',0,0,0,'',0),(25274,3,'','',10186,'Model','vmware.hv.hw.model[{$URL},{HOST.HOST}]',3600,90,0,0,1,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,0,NULL,'','The system model identification.',0,'30',0,0,0,'',0),(25275,3,'','',10186,'Bios UUID','vmware.hv.hw.uuid[{$URL},{HOST.HOST}]',3600,90,0,0,1,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,0,NULL,'','The hardware BIOS identification.',0,'30',0,0,0,'',0),(25276,3,'','',10186,'Vendor','vmware.hv.hw.vendor[{$URL},{HOST.HOST}]',3600,90,0,0,1,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,0,NULL,'','The hardware vendor identification.',0,'30',0,0,0,'',0),(25277,3,'','',10186,'Ballooned memory','vmware.hv.memory.size.ballooned[{$URL},{HOST.HOST}]',60,90,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,0,NULL,'','The amount of guest physical memory that is currently reclaimed through the balloon driver. Sum of all guest VMs.',0,'30',0,0,0,'',0),(25278,3,'','',10186,'Used memory','vmware.hv.memory.used[{$URL},{HOST.HOST}]',60,90,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,0,NULL,'','Physical memory usage on the host.',0,'30',0,0,0,'',0),(25279,3,'','',10186,'Number of bytes received','vmware.hv.network.in[{$URL},{HOST.HOST},bps]',60,90,365,0,3,'','Bps',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25280,3,'','',10186,'Number of bytes transmitted','vmware.hv.network.out[{$URL},{HOST.HOST},bps]',60,90,365,0,3,'','Bps',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,0,NULL,'','',0,'30',0,0,0,'',0),(25281,3,'','',10186,'Health state rollup','vmware.hv.sensor.health.state[{$URL},{HOST.HOST}]',60,90,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,13,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,0,NULL,'','The host health state rollup sensor value: gray - unknown, ok, red - it has a problem, yellow - it might have a problem.',0,'30',0,0,0,'',0),(25282,3,'','',10186,'Overall status','vmware.hv.status[{$URL},{HOST.HOST}]',60,90,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,13,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,0,NULL,'','The overall alarm status of the host: gray - unknown, ok, red - it has a problem, yellow - it might have a problem.',0,'30',0,0,0,'',0),(25283,3,'','',10186,'Uptime','vmware.hv.uptime[{$URL},{HOST.HOST}]',3600,90,365,0,3,'','uptime',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,0,NULL,'','System uptime.',0,'30',0,0,0,'',0),(25284,3,'','',10186,'Version','vmware.hv.version[{$URL},{HOST.HOST}]',3600,90,0,0,1,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,0,NULL,'','Dot-separated version string.',0,'30',0,0,0,'',0),(25285,3,'','',10186,'Number of guest VMs','vmware.hv.vm.num[{$URL},{HOST.HOST}]',3600,90,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,0,NULL,'','Number of guest virtual machines.',0,'30',0,0,0,'',0),(25286,4,'{$SNMP_COMMUNITY}','SNMPv2-MIB::sysContact.0',10187,'Device contact details','sysContact',3600,7,0,0,1,'','',0,0,'',0,'','','1','',0,'',25237,NULL,'','','',0,0,'','','','',0,0,NULL,'','The textual identification of the contact person for this managed node, together with information on how to contact this person.  If no contact information is known, the value is the zero-length string.',23,'30',0,0,0,'',0),(25287,4,'{$SNMP_COMMUNITY}','SNMPv2-MIB::sysDescr.0',10187,'Device description','sysDescr',3600,7,0,0,1,'','',0,0,'',0,'','','1','',0,'',25238,NULL,'','','',0,0,'','','','',0,0,NULL,'','A textual description of the entity.  This value should include the full name and version identification of the system\'s hardware type, software operating-system, and networking software.',14,'30',0,0,0,'',0),(25288,4,'{$SNMP_COMMUNITY}','SNMPv2-MIB::sysLocation.0',10187,'Device location','sysLocation',3600,7,0,0,1,'','',0,0,'',0,'','','1','',0,'',25239,NULL,'','','',0,0,'','','','',0,0,NULL,'','The physical location of this node (e.g., `telephone closet, 3rd floor\').  If the location is unknown, the value is the zero-length string.',24,'30',0,0,0,'',0),(25289,4,'{$SNMP_COMMUNITY}','SNMPv2-MIB::sysName.0',10187,'Device name','sysName',3600,7,0,0,1,'','',0,0,'',0,'','','1','',0,'',25240,NULL,'','','',0,0,'','','','',0,0,NULL,'','An administratively-assigned name for this managed node. By convention, this is the node\'s fully-qualified domain name.  If the name is unknown, the value is the zero-length string.',3,'30',0,0,0,'',0),(25290,4,'{$SNMP_COMMUNITY}','SNMPv2-MIB::sysUpTime.0',10187,'Device uptime','sysUpTime',60,7,365,0,3,'','uptime',1,0,'',0,'','','0.01','',0,'',25241,NULL,'','','',0,0,'','','','',0,0,NULL,'','The time since the network management portion of the system was last re-initialized.',0,'30',0,0,0,'',0),(25291,4,'{$SNMP_COMMUNITY}','IF-MIB::ifNumber.0',10187,'Number of network interfaces','ifNumber',3600,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',25242,NULL,'','','',0,0,'','','','',0,0,NULL,'','The number of network interfaces (regardless of their current state) present on this system.',0,'30',0,0,0,'',0),(25292,4,'{$SNMP_COMMUNITY}','SNMPv2-MIB::sysContact.0',10188,'Device contact details','sysContact',3600,7,0,0,1,'','',0,0,'',0,'','','1','',0,'',25237,NULL,'','','',0,0,'','','','',0,0,NULL,'','The textual identification of the contact person for this managed node, together with information on how to contact this person.  If no contact information is known, the value is the zero-length string.',23,'30',0,0,0,'',0),(25293,4,'{$SNMP_COMMUNITY}','SNMPv2-MIB::sysDescr.0',10188,'Device description','sysDescr',3600,7,0,0,1,'','',0,0,'',0,'','','1','',0,'',25238,NULL,'','','',0,0,'','','','',0,0,NULL,'','A textual description of the entity.  This value should include the full name and version identification of the system\'s hardware type, software operating-system, and networking software.',14,'30',0,0,0,'',0),(25294,4,'{$SNMP_COMMUNITY}','SNMPv2-MIB::sysLocation.0',10188,'Device location','sysLocation',3600,7,0,0,1,'','',0,0,'',0,'','','1','',0,'',25239,NULL,'','','',0,0,'','','','',0,0,NULL,'','The physical location of this node (e.g., `telephone closet, 3rd floor\').  If the location is unknown, the value is the zero-length string.',24,'30',0,0,0,'',0),(25295,4,'{$SNMP_COMMUNITY}','SNMPv2-MIB::sysName.0',10188,'Device name','sysName',3600,7,0,0,1,'','',0,0,'',0,'','','1','',0,'',25240,NULL,'','','',0,0,'','','','',0,0,NULL,'','An administratively-assigned name for this managed node. By convention, this is the node\'s fully-qualified domain name.  If the name is unknown, the value is the zero-length string.',3,'30',0,0,0,'',0),(25296,4,'{$SNMP_COMMUNITY}','SNMPv2-MIB::sysUpTime.0',10188,'Device uptime','sysUpTime',60,7,365,0,3,'','uptime',1,0,'',0,'','','0.01','',0,'',25241,NULL,'','','',0,0,'','','','',0,0,NULL,'','The time since the network management portion of the system was last re-initialized.',0,'30',0,0,0,'',0),(25297,4,'{$SNMP_COMMUNITY}','IF-MIB::ifNumber.0',10188,'Number of network interfaces','ifNumber',3600,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',25242,NULL,'','','',0,0,'','','','',0,0,NULL,'','The number of network interfaces (regardless of their current state) present on this system.',0,'30',0,0,0,'',0),(25298,4,'{$SNMP_COMMUNITY}','SNMPv2-MIB::sysContact.0',10189,'Device contact details','sysContact',3600,7,0,0,1,'','',0,0,'',0,'','','1','',0,'',25237,NULL,'','','',0,0,'','','','',0,0,NULL,'','The textual identification of the contact person for this managed node, together with information on how to contact this person.  If no contact information is known, the value is the zero-length string.',23,'30',0,0,0,'',0),(25299,4,'{$SNMP_COMMUNITY}','SNMPv2-MIB::sysDescr.0',10189,'Device description','sysDescr',3600,7,0,0,1,'','',0,0,'',0,'','','1','',0,'',25238,NULL,'','','',0,0,'','','','',0,0,NULL,'','A textual description of the entity.  This value should include the full name and version identification of the system\'s hardware type, software operating-system, and networking software.',14,'30',0,0,0,'',0),(25300,4,'{$SNMP_COMMUNITY}','SNMPv2-MIB::sysLocation.0',10189,'Device location','sysLocation',3600,7,0,0,1,'','',0,0,'',0,'','','1','',0,'',25239,NULL,'','','',0,0,'','','','',0,0,NULL,'','The physical location of this node (e.g., `telephone closet, 3rd floor\').  If the location is unknown, the value is the zero-length string.',24,'30',0,0,0,'',0),(25301,4,'{$SNMP_COMMUNITY}','SNMPv2-MIB::sysName.0',10189,'Device name','sysName',3600,7,0,0,1,'','',0,0,'',0,'','','1','',0,'',25240,NULL,'','','',0,0,'','','','',0,0,NULL,'','An administratively-assigned name for this managed node. By convention, this is the node\'s fully-qualified domain name.  If the name is unknown, the value is the zero-length string.',3,'30',0,0,0,'',0),(25302,4,'{$SNMP_COMMUNITY}','SNMPv2-MIB::sysUpTime.0',10189,'Device uptime','sysUpTime',60,7,365,0,3,'','uptime',1,0,'',0,'','','0.01','',0,'',25241,NULL,'','','',0,0,'','','','',0,0,NULL,'','The time since the network management portion of the system was last re-initialized.',0,'30',0,0,0,'',0),(25303,4,'{$SNMP_COMMUNITY}','IF-MIB::ifNumber.0',10189,'Number of network interfaces','ifNumber',3600,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',25242,NULL,'','','',0,0,'','','','',0,0,NULL,'','The number of network interfaces (regardless of their current state) present on this system.',0,'30',0,0,0,'',0),(25304,0,'','',10167,'IO_discover','io.scandisk',60,90,0,0,4,'','',0,0,'',0,'','','','',0,'',NULL,NULL,'','','',0,0,'','','','',0,1,NULL,'','',0,'30',0,0,0,'',0),(25305,0,'','',10178,'Network interface discovery','net.if.discovery',60,90,0,0,4,'','',0,0,'',0,'','','','',0,'',NULL,NULL,'','','',0,0,'','','','',0,1,NULL,'','Discovery of network interfaces as defined in global regular expression \"Network interfaces for discovery\".',0,'30',0,0,0,'',1),(25306,0,'','',10178,'Mounted filesystem discovery','vfs.fs.discovery',3600,90,0,0,4,'','',0,0,'',0,'','','','',0,'',NULL,NULL,'','','',0,0,'','','','',0,1,NULL,'','Discovery of file systems of different types as defined in global regular expression \"File systems for discovery\".',0,'30',0,0,0,'',0),(25307,0,'','',10179,'Network interface discovery','net.if.discovery',3600,90,0,0,4,'','',0,0,'',0,'','','','',0,'',NULL,NULL,'','','',0,0,'','','','',0,1,NULL,'','Discovery of network interfaces as defined in global regular expression \"Network interfaces for discovery\".',0,'30',0,0,0,'',0),(25308,0,'','',10179,'Mounted filesystem discovery','vfs.fs.discovery',3600,90,0,0,4,'','',0,0,'',0,'','','','',0,'',NULL,NULL,'','','',0,0,'','','','',0,1,NULL,'','Discovery of file systems of different types as defined in global regular expression \"File systems for discovery\".',0,'30',0,0,0,'',0),(25309,4,'{$SNMP_COMMUNITY}','discovery[{#SNMPVALUE},HOST-RESOURCES-MIB::hrStorageDescr]',10180,'Disk partitions','hrStorageDescr',3600,90,0,0,4,'','',0,0,'',0,'','','','',0,'',NULL,NULL,'','','',0,0,'','','','',0,1,NULL,'','The rule will discover all disk partitions matching the global regexp \"Storage devices for SNMP discovery\".\r\n\r\n{$SNMP_COMMUNITY} is a global macro.',0,'30',0,0,0,'',0),(25310,4,'{$SNMP_COMMUNITY}','discovery[{#SNMPVALUE},IF-MIB::ifDescr]',10182,'Network interfaces','ifDescr',3600,90,0,0,4,'','',0,0,'',0,'','','','',0,'',NULL,NULL,'','','',0,0,'','','','',0,1,NULL,'','You may also consider using IF-MIB::ifType or IF-MIB::ifAlias for discovery depending on your filtering needs.\r\n\r\n{$SNMP_COMMUNITY} is a global macro.',0,'30',0,0,0,'',0),(25311,4,'{$SNMP_COMMUNITY}','discovery[{#SNMPVALUE},HOST-RESOURCES-MIB::hrProcessorLoad]',10183,'Processors','hrProcessorLoad',3600,90,0,0,4,'','',0,0,'',0,'','','','',0,'',NULL,NULL,'','','',0,0,'','','','',0,1,NULL,'','{$SNMP_COMMUNITY} is a global macro.',0,'30',0,0,0,'',0),(25312,3,'','',10184,'Discover VMware clusters','vmware.cluster.discovery[{$URL}]',3600,90,0,0,4,'','',0,0,'',0,'','','','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,1,NULL,'','Discovery of clusters',0,'30',0,0,0,'',0),(25313,3,'','',10184,'Discover VMware hypervisors','vmware.hv.discovery[{$URL}]',3600,90,0,0,4,'','',0,0,'',0,'','','','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,1,NULL,'','Discovery of hypervisors.',0,'30',0,0,0,'',0),(25314,3,'','',10184,'Discover VMware VMs','vmware.vm.discovery[{$URL}]',3600,90,0,0,4,'','',0,0,'',0,'','','','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,1,NULL,'','Discovery of guest virtual machines.',0,'30',0,0,0,'',0),(25315,3,'','',10185,'Network device discovery','vmware.vm.net.if.discovery[{$URL},{HOST.HOST}]',3600,90,0,0,4,'','',0,0,'',0,'','','','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,1,NULL,'','Discovery of all network devices.',0,'30',0,0,0,'',0),(25316,3,'','',10185,'Disk device discovery','vmware.vm.vfs.dev.discovery[{$URL},{HOST.HOST}]',3600,90,0,0,4,'','',0,0,'',0,'','','','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,1,NULL,'','Discovery of all disk devices.',0,'30',0,0,0,'',0),(25317,3,'','',10185,'Mounted filesystem discovery','vmware.vm.vfs.fs.discovery[{$URL},{HOST.HOST}]',3600,90,0,0,4,'','',0,0,'',0,'','','','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,1,NULL,'','Discovery of all guest file systems.',0,'30',0,0,0,'',0),(25318,3,'','',10186,'Datastore discovery','vmware.hv.datastore.discovery[{$URL},{HOST.HOST}]',3600,90,0,0,4,'','',0,0,'',0,'','','','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,1,NULL,'','',0,'30',0,0,0,'',0),(25319,4,'{$SNMP_COMMUNITY}','discovery[{#SNMPVALUE},IF-MIB::ifDescr]',10187,'Network interfaces','ifDescr',3600,90,0,0,4,'','',0,0,'',0,'','','','',0,'',25310,NULL,'','','',0,0,'','','','',0,1,NULL,'','You may also consider using IF-MIB::ifType or IF-MIB::ifAlias for discovery depending on your filtering needs.\r\n\r\n{$SNMP_COMMUNITY} is a global macro.',0,'30',0,0,0,'',0),(25320,4,'{$SNMP_COMMUNITY}','discovery[{#SNMPVALUE},HOST-RESOURCES-MIB::hrStorageDescr]',10188,'Disk partitions','hrStorageDescr',3600,90,0,0,4,'','',0,0,'',0,'','','','',0,'',25309,NULL,'','','',0,0,'','','','',0,1,NULL,'','The rule will discover all disk partitions matching the global regexp \"Storage devices for SNMP discovery\".\r\n\r\n{$SNMP_COMMUNITY} is a global macro.',0,'30',0,0,0,'',0),(25321,4,'{$SNMP_COMMUNITY}','discovery[{#SNMPVALUE},IF-MIB::ifDescr]',10188,'Network interfaces','ifDescr',3600,90,0,0,4,'','',0,0,'',0,'','','','',0,'',25310,NULL,'','','',0,0,'','','','',0,1,NULL,'','You may also consider using IF-MIB::ifType or IF-MIB::ifAlias for discovery depending on your filtering needs.\r\n\r\n{$SNMP_COMMUNITY} is a global macro.',0,'30',0,0,0,'',0),(25322,4,'{$SNMP_COMMUNITY}','discovery[{#SNMPVALUE},HOST-RESOURCES-MIB::hrProcessorLoad]',10188,'Processors','hrProcessorLoad',3600,90,0,0,4,'','',0,0,'',0,'','','','',0,'',25311,NULL,'','','',0,0,'','','','',0,1,NULL,'','{$SNMP_COMMUNITY} is a global macro.',0,'30',0,0,0,'',0),(25323,4,'{$SNMP_COMMUNITY}','discovery[{#SNMPVALUE},HOST-RESOURCES-MIB::hrStorageDescr]',10189,'Disk partitions','hrStorageDescr',3600,90,0,0,4,'','',0,0,'',0,'','','','',0,'',25309,NULL,'','','',0,0,'','','','',0,1,NULL,'','The rule will discover all disk partitions matching the global regexp \"Storage devices for SNMP discovery\".\r\n\r\n{$SNMP_COMMUNITY} is a global macro.',0,'30',0,0,0,'',0),(25324,4,'{$SNMP_COMMUNITY}','discovery[{#SNMPVALUE},IF-MIB::ifDescr]',10189,'Network interfaces','ifDescr',3600,90,0,0,4,'','',0,0,'',0,'','','','',0,'',25310,NULL,'','','',0,0,'','','','',0,1,NULL,'','You may also consider using IF-MIB::ifType or IF-MIB::ifAlias for discovery depending on your filtering needs.\r\n\r\n{$SNMP_COMMUNITY} is a global macro.',0,'30',0,0,0,'',0),(25325,4,'{$SNMP_COMMUNITY}','discovery[{#SNMPVALUE},HOST-RESOURCES-MIB::hrProcessorLoad]',10189,'Processors','hrProcessorLoad',3600,90,0,0,4,'','',0,0,'',0,'','','','',0,'',25311,NULL,'','','',0,0,'','','','',0,1,NULL,'','{$SNMP_COMMUNITY} is a global macro.',0,'30',0,0,0,'',0),(25326,0,'','',10167,'IO_avgqu-sz on $1','io.avgqu-sz[{#DISK_NAME}]',10,180,365,0,0,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,NULL,'','',0,'30',0,0,0,'',0),(25327,0,'','',10167,'IO_avgrq-sz on $1','io.avgrq-sz[{#DISK_NAME}]',10,180,365,0,0,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,NULL,'','',0,'30',0,0,0,'',0),(25328,0,'','',10167,'IO_await on $1','io.await[{#DISK_NAME}]',10,180,365,0,0,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,NULL,'','',0,'30',0,0,0,'',0),(25329,0,'','',10167,'IO_rMBps on $1','io.rMBps[{#DISK_NAME}]',10,180,365,0,0,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,NULL,'','',0,'30',0,0,0,'',0),(25330,0,'','',10167,'IO_rps on $1','io.rps[{#DISK_NAME}]',10,180,365,0,0,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,NULL,'','',0,'30',0,0,0,'',0),(25331,0,'','',10167,'IO_svctm on $1','io.svctm[{#DISK_NAME}]',10,180,365,0,0,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,NULL,'','',0,'30',0,0,0,'',0),(25332,0,'','',10167,'IO_util on $1','io.util[{#DISK_NAME}]',10,180,365,0,0,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,NULL,'','',0,'30',0,0,0,'',0),(25333,0,'','',10167,'IO_wMBps on $1','io.wMBps[{#DISK_NAME}]',10,180,365,0,0,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,NULL,'','',0,'30',0,0,0,'',0),(25334,0,'','',10167,'IO_wps on $1','io.wps[{#DISK_NAME}]',10,180,365,0,0,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,NULL,'','',0,'30',0,0,0,'',0),(25335,0,'','',10178,'Incoming network traffic on $1','net.if.in[{#IFNAME}]',40,180,365,0,3,'','bps',1,1,'',0,'','','8','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,NULL,'','',0,'30',0,0,0,'',0),(25336,0,'','',10178,'Outgoing network traffic on $1','net.if.out[{#IFNAME}]',50,180,365,0,3,'','bps',1,1,'',0,'','','8','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,NULL,'','',0,'30',0,0,0,'',0),(25337,0,'','',10178,'Free inodes on $1 (percentage)','vfs.fs.inode[{#FSNAME},pfree]',60,180,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,NULL,'','',0,'30',0,0,0,'',0),(25338,0,'','',10178,'Free disk space on $1','vfs.fs.size[{#FSNAME},free]',60,180,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,NULL,'','',0,'30',0,0,0,'',0),(25339,0,'','',10178,'Free disk space on $1 (percentage)','vfs.fs.size[{#FSNAME},pfree]',60,180,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,NULL,'','',0,'30',0,0,0,'',0),(25340,0,'','',10178,'Total disk space on $1','vfs.fs.size[{#FSNAME},total]',3600,180,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,NULL,'','',0,'30',0,0,0,'',0),(25341,0,'','',10178,'Used disk space on $1','vfs.fs.size[{#FSNAME},used]',60,180,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,NULL,'','',0,'30',0,0,0,'',0),(25342,0,'','',10179,'Incoming network traffic on $1','net.if.in[{#IFNAME}]',60,180,365,0,3,'','bps',1,1,'',0,'','','8','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,NULL,'','',0,'30',0,0,0,'',0),(25343,0,'','',10179,'Outgoing network traffic on $1','net.if.out[{#IFNAME}]',60,180,365,0,3,'','bps',1,1,'',0,'','','8','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,NULL,'','',0,'30',0,0,0,'',0),(25344,0,'','',10179,'Free disk space on $1','vfs.fs.size[{#FSNAME},free]',60,180,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,NULL,'','',0,'30',0,0,0,'',0),(25345,0,'','',10179,'Free disk space on $1 (percentage)','vfs.fs.size[{#FSNAME},pfree]',60,180,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,NULL,'','',0,'30',0,0,0,'',0),(25346,0,'','',10179,'Total disk space on $1','vfs.fs.size[{#FSNAME},total]',3600,180,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,NULL,'','',0,'30',0,0,0,'',0),(25347,0,'','',10179,'Used disk space on $1','vfs.fs.size[{#FSNAME},used]',60,180,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,NULL,'','',0,'30',0,0,0,'',0),(25348,4,'{$SNMP_COMMUNITY}','HOST-RESOURCES-MIB::hrStorageAllocationUnits.{#SNMPINDEX}',10180,'Allocation units for storage $1','hrStorageAllocationUnits[{#SNMPVALUE}]',3600,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,NULL,'','The size, in bytes, of the data objects allocated from this pool.  If this entry is monitoring sectors, blocks, buffers, or packets, for example, this number will commonly be greater than one.  Otherwise this number will typically be one.',0,'30',0,0,0,'',0),(25349,4,'{$SNMP_COMMUNITY}','HOST-RESOURCES-MIB::hrStorageDescr.{#SNMPINDEX}',10180,'Description of storage $1','hrStorageDescr[{#SNMPVALUE}]',3600,7,0,0,1,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,NULL,'','A description of the type and instance of the storage described by this entry.',0,'30',0,0,0,'',0),(25350,15,'','',10180,'Total disk space on $1','hrStorageSizeInBytes[{#SNMPVALUE}]',3600,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','last(\"hrStorageSize[{#SNMPVALUE}]\") * last(\"hrStorageAllocationUnits[{#SNMPVALUE}]\")','',0,0,'','','','',0,2,NULL,'','This is a calculated item, we need it to get total disk space in bytes.',0,'30',0,0,0,'',0),(25351,4,'{$SNMP_COMMUNITY}','HOST-RESOURCES-MIB::hrStorageSize.{#SNMPINDEX}',10180,'Total disk space on $1 in units','hrStorageSize[{#SNMPVALUE}]',3600,7,365,0,3,'','units',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,NULL,'','The size of the storage represented by this entry, in units of hrStorageAllocationUnits. This object is writable to allow remote configuration of the size of the storage area in those cases where such an operation makes sense and is possible on the underlying system. For example, the amount of main memory allocated to a buffer pool might be modified or the amount of disk space allocated to virtual memory might be modified.',0,'30',0,0,0,'',0),(25352,15,'','',10180,'Used disk space on $1','hrStorageUsedInBytes[{#SNMPVALUE}]',60,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','last(\"hrStorageUsed[{#SNMPVALUE}]\") * last(\"hrStorageAllocationUnits[{#SNMPVALUE}]\")','',0,0,'','','','',0,2,NULL,'','This is a calculated item, we need it to get used disk space in bytes.',0,'30',0,0,0,'',0),(25353,4,'{$SNMP_COMMUNITY}','HOST-RESOURCES-MIB::hrStorageUsed.{#SNMPINDEX}',10180,'Used disk space on $1 in units','hrStorageUsed[{#SNMPVALUE}]',60,7,365,0,3,'','units',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,NULL,'','The amount of the storage represented by this entry that is allocated, in units of hrStorageAllocationUnits.',0,'30',0,0,0,'',0),(25354,4,'{$SNMP_COMMUNITY}','IF-MIB::ifAdminStatus.{#SNMPINDEX}',10182,'Admin status of interface $1','ifAdminStatus[{#SNMPVALUE}]',60,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,11,'','','',0,0,'','','','',0,2,NULL,'','The desired state of the interface.',0,'30',0,0,0,'',0),(25355,4,'{$SNMP_COMMUNITY}','IF-MIB::ifAlias.{#SNMPINDEX}',10182,'Alias of interface $1','ifAlias[{#SNMPVALUE}]',3600,7,0,0,1,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,NULL,'','',0,'30',0,0,0,'',0),(25356,4,'{$SNMP_COMMUNITY}','IF-MIB::ifDescr.{#SNMPINDEX}',10182,'Description of interface $1','ifDescr[{#SNMPVALUE}]',3600,7,0,0,1,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,NULL,'','A textual string containing information about the interface.  This string should include the name of the manufacturer, the product name and the version of the interface hardware/software.',0,'30',0,0,0,'',0),(25357,4,'{$SNMP_COMMUNITY}','IF-MIB::ifInErrors.{#SNMPINDEX}',10182,'Inbound errors on interface $1','ifInErrors[{#SNMPVALUE}]',60,7,365,0,3,'','',0,1,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,NULL,'','For packet-oriented interfaces, the number of inbound packets that contained errors preventing them from being deliverable to a higher-layer protocol.  For character-oriented or fixed-length interfaces, the number of inbound transmission units that contained errors preventing them from being deliverable to a higher-layer protocol.',0,'30',0,0,0,'',0),(25358,4,'{$SNMP_COMMUNITY}','IF-MIB::ifInOctets.{#SNMPINDEX}',10182,'Incoming traffic on interface $1','ifInOctets[{#SNMPVALUE}]',60,7,365,0,3,'','bps',1,1,'',0,'','','8','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,NULL,'','The number of octets in valid MAC frames received on this interface, including the MAC header and FCS.',0,'30',0,0,0,'',0),(25359,4,'{$SNMP_COMMUNITY}','IF-MIB::ifOperStatus.{#SNMPINDEX}',10182,'Operational status of interface $1','ifOperStatus[{#SNMPVALUE}]',60,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,8,'','','',0,0,'','','','',0,2,NULL,'','The current operational state of the interface.',0,'30',0,0,0,'',0),(25360,4,'{$SNMP_COMMUNITY}','IF-MIB::ifOutErrors.{#SNMPINDEX}',10182,'Outbound errors on interface $1','ifOutErrors[{#SNMPVALUE}]',60,7,365,0,3,'','',0,1,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,NULL,'','For packet-oriented interfaces, the number of outbound packets that could not be transmitted because of errors. For character-oriented or fixed-length interfaces, the number of outbound transmission units that could not be transmitted because of errors.',0,'30',0,0,0,'',0),(25361,4,'{$SNMP_COMMUNITY}','IF-MIB::ifOutOctets.{#SNMPINDEX}',10182,'Outgoing traffic on interface $1','ifOutOctets[{#SNMPVALUE}]',60,7,365,0,3,'','bps',1,1,'',0,'','','8','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,NULL,'','The number of octets transmitted in MAC frames on this interface, including the MAC header and FCS.',0,'30',0,0,0,'',0),(25362,4,'{$SNMP_COMMUNITY}','HOST-RESOURCES-MIB::hrProcessorLoad.{#SNMPINDEX}',10183,'Utilization of processor #$1','hrProcessorLoad[{#SNMPINDEX}]',60,7,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,NULL,'','The average, over the last minute, of the percentage of time that this processor was not idle. Implementations may approximate this one minute smoothing period if necessary.',0,'30',0,0,0,'',0),(25363,3,'','',10184,'Status of \"$2\" cluster','vmware.cluster.status[{$URL},{#CLUSTER.NAME}]',60,90,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,13,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,2,NULL,'','',0,'30',0,0,0,'',0),(25364,3,'','',10185,'Number of bytes received on interface {#IFDESC}','vmware.vm.net.if.in[{$URL},{HOST.HOST},{#IFNAME},bps]',60,90,365,0,3,'','Bps',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,2,NULL,'','',0,'30',0,0,0,'',0),(25365,3,'','',10185,'Number of packets received on interface {#IFDESC}','vmware.vm.net.if.in[{$URL},{HOST.HOST},{#IFNAME},pps]',60,90,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,2,NULL,'','',0,'30',0,0,0,'',0),(25366,3,'','',10185,'Number of bytes transmitted on interface {#IFDESC}','vmware.vm.net.if.out[{$URL},{HOST.HOST},{#IFNAME},bps]',60,90,365,0,3,'','Bps',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,2,NULL,'','',0,'30',0,0,0,'',0),(25367,3,'','',10185,'Number of packets transmitted on interface {#IFDESC}','vmware.vm.net.if.out[{$URL},{HOST.HOST},{#IFNAME},pps]',60,90,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,2,NULL,'','',0,'30',0,0,0,'',0),(25368,3,'','',10185,'Average number of bytes read from the disk {#DISKDESC}','vmware.vm.vfs.dev.read[{$URL},{HOST.HOST},{#DISKNAME},bps]',60,90,365,0,3,'','Bps',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,2,NULL,'','',0,'30',0,0,0,'',0),(25369,3,'','',10185,'Average number of reads from the disk {#DISKDESC}','vmware.vm.vfs.dev.read[{$URL},{HOST.HOST},{#DISKNAME},ops]',60,90,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,2,NULL,'','',0,'30',0,0,0,'',0),(25370,3,'','',10185,'Average number of bytes written to the disk {#DISKDESC}','vmware.vm.vfs.dev.write[{$URL},{HOST.HOST},{#DISKNAME},bps]',60,90,365,0,3,'','Bps',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,2,NULL,'','',0,'30',0,0,0,'',0),(25371,3,'','',10185,'Average number of writes to the disk {#DISKDESC}','vmware.vm.vfs.dev.write[{$URL},{HOST.HOST},{#DISKNAME},ops]',60,90,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,2,NULL,'','',0,'30',0,0,0,'',0),(25372,3,'','',10185,'Free disk space on {#FSNAME}','vmware.vm.vfs.fs.size[{$URL},{HOST.HOST},{#FSNAME},free]',60,90,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,2,NULL,'','',0,'30',0,0,0,'',0),(25373,3,'','',10185,'Free disk space on {#FSNAME} (percentage)','vmware.vm.vfs.fs.size[{$URL},{HOST.HOST},{#FSNAME},pfree]',60,90,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,2,NULL,'','',0,'30',0,0,0,'',0),(25374,3,'','',10185,'Total disk space on {#FSNAME}','vmware.vm.vfs.fs.size[{$URL},{HOST.HOST},{#FSNAME},total]',3600,90,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,2,NULL,'','',0,'30',0,0,0,'',0),(25375,3,'','',10185,'Used disk space on {#FSNAME}','vmware.vm.vfs.fs.size[{$URL},{HOST.HOST},{#FSNAME},used]',60,90,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,2,NULL,'','',0,'30',0,0,0,'',0),(25376,3,'','',10186,'Average read latency of the datastore $3','vmware.hv.datastore.read[{$URL},{HOST.HOST},{#DATASTORE},latency]',60,90,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,2,NULL,'','',0,'30',0,0,0,'',0),(25377,3,'','',10186,'Free space on datastore $3 (percentage)','vmware.hv.datastore.size[{$URL},{HOST.HOST},{#DATASTORE},pfree]',60,90,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,2,NULL,'','',0,'30',0,0,0,'',0),(25378,3,'','',10186,'Total size of datastore $3','vmware.hv.datastore.size[{$URL},{HOST.HOST},{#DATASTORE}]',60,90,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,2,NULL,'','',0,'30',0,0,0,'',0),(25379,3,'','',10186,'Average write latency of the datastore $3','vmware.hv.datastore.write[{$URL},{HOST.HOST},{#DATASTORE},latency]',60,90,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,2,NULL,'','',0,'30',0,0,0,'',0),(25380,4,'{$SNMP_COMMUNITY}','IF-MIB::ifAdminStatus.{#SNMPINDEX}',10187,'Admin status of interface $1','ifAdminStatus[{#SNMPVALUE}]',60,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',25354,11,'','','',0,0,'','','','',0,2,NULL,'','The desired state of the interface.',0,'30',0,0,0,'',0),(25381,4,'{$SNMP_COMMUNITY}','IF-MIB::ifAlias.{#SNMPINDEX}',10187,'Alias of interface $1','ifAlias[{#SNMPVALUE}]',3600,7,0,0,1,'','',0,0,'',0,'','','1','',0,'',25355,NULL,'','','',0,0,'','','','',0,2,NULL,'','',0,'30',0,0,0,'',0),(25382,4,'{$SNMP_COMMUNITY}','IF-MIB::ifDescr.{#SNMPINDEX}',10187,'Description of interface $1','ifDescr[{#SNMPVALUE}]',3600,7,0,0,1,'','',0,0,'',0,'','','1','',0,'',25356,NULL,'','','',0,0,'','','','',0,2,NULL,'','A textual string containing information about the interface.  This string should include the name of the manufacturer, the product name and the version of the interface hardware/software.',0,'30',0,0,0,'',0),(25383,4,'{$SNMP_COMMUNITY}','IF-MIB::ifInErrors.{#SNMPINDEX}',10187,'Inbound errors on interface $1','ifInErrors[{#SNMPVALUE}]',60,7,365,0,3,'','',0,1,'',0,'','','1','',0,'',25357,NULL,'','','',0,0,'','','','',0,2,NULL,'','For packet-oriented interfaces, the number of inbound packets that contained errors preventing them from being deliverable to a higher-layer protocol.  For character-oriented or fixed-length interfaces, the number of inbound transmission units that contained errors preventing them from being deliverable to a higher-layer protocol.',0,'30',0,0,0,'',0),(25384,4,'{$SNMP_COMMUNITY}','IF-MIB::ifInOctets.{#SNMPINDEX}',10187,'Incoming traffic on interface $1','ifInOctets[{#SNMPVALUE}]',60,7,365,0,3,'','bps',1,1,'',0,'','','8','',0,'',25358,NULL,'','','',0,0,'','','','',0,2,NULL,'','The number of octets in valid MAC frames received on this interface, including the MAC header and FCS.',0,'30',0,0,0,'',0),(25385,4,'{$SNMP_COMMUNITY}','IF-MIB::ifOperStatus.{#SNMPINDEX}',10187,'Operational status of interface $1','ifOperStatus[{#SNMPVALUE}]',60,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',25359,8,'','','',0,0,'','','','',0,2,NULL,'','The current operational state of the interface.',0,'30',0,0,0,'',0),(25386,4,'{$SNMP_COMMUNITY}','IF-MIB::ifOutErrors.{#SNMPINDEX}',10187,'Outbound errors on interface $1','ifOutErrors[{#SNMPVALUE}]',60,7,365,0,3,'','',0,1,'',0,'','','1','',0,'',25360,NULL,'','','',0,0,'','','','',0,2,NULL,'','For packet-oriented interfaces, the number of outbound packets that could not be transmitted because of errors. For character-oriented or fixed-length interfaces, the number of outbound transmission units that could not be transmitted because of errors.',0,'30',0,0,0,'',0),(25387,4,'{$SNMP_COMMUNITY}','IF-MIB::ifOutOctets.{#SNMPINDEX}',10187,'Outgoing traffic on interface $1','ifOutOctets[{#SNMPVALUE}]',60,7,365,0,3,'','bps',1,1,'',0,'','','8','',0,'',25361,NULL,'','','',0,0,'','','','',0,2,NULL,'','The number of octets transmitted in MAC frames on this interface, including the MAC header and FCS.',0,'30',0,0,0,'',0),(25388,4,'{$SNMP_COMMUNITY}','HOST-RESOURCES-MIB::hrStorageAllocationUnits.{#SNMPINDEX}',10188,'Allocation units for storage $1','hrStorageAllocationUnits[{#SNMPVALUE}]',3600,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',25348,NULL,'','','',0,0,'','','','',0,2,NULL,'','The size, in bytes, of the data objects allocated from this pool.  If this entry is monitoring sectors, blocks, buffers, or packets, for example, this number will commonly be greater than one.  Otherwise this number will typically be one.',0,'30',0,0,0,'',0),(25389,4,'{$SNMP_COMMUNITY}','HOST-RESOURCES-MIB::hrStorageDescr.{#SNMPINDEX}',10188,'Description of storage $1','hrStorageDescr[{#SNMPVALUE}]',3600,7,0,0,1,'','',0,0,'',0,'','','1','',0,'',25349,NULL,'','','',0,0,'','','','',0,2,NULL,'','A description of the type and instance of the storage described by this entry.',0,'30',0,0,0,'',0),(25390,15,'','',10188,'Total disk space on $1','hrStorageSizeInBytes[{#SNMPVALUE}]',3600,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',25350,NULL,'','last(\"hrStorageSize[{#SNMPVALUE}]\") * last(\"hrStorageAllocationUnits[{#SNMPVALUE}]\")','',0,0,'','','','',0,2,NULL,'','This is a calculated item, we need it to get total disk space in bytes.',0,'30',0,0,0,'',0),(25391,4,'{$SNMP_COMMUNITY}','HOST-RESOURCES-MIB::hrStorageSize.{#SNMPINDEX}',10188,'Total disk space on $1 in units','hrStorageSize[{#SNMPVALUE}]',3600,7,365,0,3,'','units',0,0,'',0,'','','1','',0,'',25351,NULL,'','','',0,0,'','','','',0,2,NULL,'','The size of the storage represented by this entry, in units of hrStorageAllocationUnits. This object is writable to allow remote configuration of the size of the storage area in those cases where such an operation makes sense and is possible on the underlying system. For example, the amount of main memory allocated to a buffer pool might be modified or the amount of disk space allocated to virtual memory might be modified.',0,'30',0,0,0,'',0),(25392,15,'','',10188,'Used disk space on $1','hrStorageUsedInBytes[{#SNMPVALUE}]',60,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',25352,NULL,'','last(\"hrStorageUsed[{#SNMPVALUE}]\") * last(\"hrStorageAllocationUnits[{#SNMPVALUE}]\")','',0,0,'','','','',0,2,NULL,'','This is a calculated item, we need it to get used disk space in bytes.',0,'30',0,0,0,'',0),(25393,4,'{$SNMP_COMMUNITY}','HOST-RESOURCES-MIB::hrStorageUsed.{#SNMPINDEX}',10188,'Used disk space on $1 in units','hrStorageUsed[{#SNMPVALUE}]',60,7,365,0,3,'','units',0,0,'',0,'','','1','',0,'',25353,NULL,'','','',0,0,'','','','',0,2,NULL,'','The amount of the storage represented by this entry that is allocated, in units of hrStorageAllocationUnits.',0,'30',0,0,0,'',0),(25394,4,'{$SNMP_COMMUNITY}','IF-MIB::ifAdminStatus.{#SNMPINDEX}',10188,'Admin status of interface $1','ifAdminStatus[{#SNMPVALUE}]',60,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',25354,11,'','','',0,0,'','','','',0,2,NULL,'','The desired state of the interface.',0,'30',0,0,0,'',0),(25395,4,'{$SNMP_COMMUNITY}','IF-MIB::ifAlias.{#SNMPINDEX}',10188,'Alias of interface $1','ifAlias[{#SNMPVALUE}]',3600,7,0,0,1,'','',0,0,'',0,'','','1','',0,'',25355,NULL,'','','',0,0,'','','','',0,2,NULL,'','',0,'30',0,0,0,'',0),(25396,4,'{$SNMP_COMMUNITY}','IF-MIB::ifDescr.{#SNMPINDEX}',10188,'Description of interface $1','ifDescr[{#SNMPVALUE}]',3600,7,0,0,1,'','',0,0,'',0,'','','1','',0,'',25356,NULL,'','','',0,0,'','','','',0,2,NULL,'','A textual string containing information about the interface.  This string should include the name of the manufacturer, the product name and the version of the interface hardware/software.',0,'30',0,0,0,'',0),(25397,4,'{$SNMP_COMMUNITY}','IF-MIB::ifInErrors.{#SNMPINDEX}',10188,'Inbound errors on interface $1','ifInErrors[{#SNMPVALUE}]',60,7,365,0,3,'','',0,1,'',0,'','','1','',0,'',25357,NULL,'','','',0,0,'','','','',0,2,NULL,'','For packet-oriented interfaces, the number of inbound packets that contained errors preventing them from being deliverable to a higher-layer protocol.  For character-oriented or fixed-length interfaces, the number of inbound transmission units that contained errors preventing them from being deliverable to a higher-layer protocol.',0,'30',0,0,0,'',0),(25398,4,'{$SNMP_COMMUNITY}','IF-MIB::ifInOctets.{#SNMPINDEX}',10188,'Incoming traffic on interface $1','ifInOctets[{#SNMPVALUE}]',60,7,365,0,3,'','bps',1,1,'',0,'','','8','',0,'',25358,NULL,'','','',0,0,'','','','',0,2,NULL,'','The number of octets in valid MAC frames received on this interface, including the MAC header and FCS.',0,'30',0,0,0,'',0),(25399,4,'{$SNMP_COMMUNITY}','IF-MIB::ifOperStatus.{#SNMPINDEX}',10188,'Operational status of interface $1','ifOperStatus[{#SNMPVALUE}]',60,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',25359,8,'','','',0,0,'','','','',0,2,NULL,'','The current operational state of the interface.',0,'30',0,0,0,'',0),(25400,4,'{$SNMP_COMMUNITY}','IF-MIB::ifOutErrors.{#SNMPINDEX}',10188,'Outbound errors on interface $1','ifOutErrors[{#SNMPVALUE}]',60,7,365,0,3,'','',0,1,'',0,'','','1','',0,'',25360,NULL,'','','',0,0,'','','','',0,2,NULL,'','For packet-oriented interfaces, the number of outbound packets that could not be transmitted because of errors. For character-oriented or fixed-length interfaces, the number of outbound transmission units that could not be transmitted because of errors.',0,'30',0,0,0,'',0),(25401,4,'{$SNMP_COMMUNITY}','IF-MIB::ifOutOctets.{#SNMPINDEX}',10188,'Outgoing traffic on interface $1','ifOutOctets[{#SNMPVALUE}]',60,7,365,0,3,'','bps',1,1,'',0,'','','8','',0,'',25361,NULL,'','','',0,0,'','','','',0,2,NULL,'','The number of octets transmitted in MAC frames on this interface, including the MAC header and FCS.',0,'30',0,0,0,'',0),(25402,4,'{$SNMP_COMMUNITY}','HOST-RESOURCES-MIB::hrProcessorLoad.{#SNMPINDEX}',10188,'Utilization of processor #$1','hrProcessorLoad[{#SNMPINDEX}]',60,7,365,0,3,'','%',0,0,'',0,'','','1','',0,'',25362,NULL,'','','',0,0,'','','','',0,2,NULL,'','The average, over the last minute, of the percentage of time that this processor was not idle. Implementations may approximate this one minute smoothing period if necessary.',0,'30',0,0,0,'',0),(25403,4,'{$SNMP_COMMUNITY}','HOST-RESOURCES-MIB::hrStorageAllocationUnits.{#SNMPINDEX}',10189,'Allocation units for storage $1','hrStorageAllocationUnits[{#SNMPVALUE}]',3600,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',25348,NULL,'','','',0,0,'','','','',0,2,NULL,'','The size, in bytes, of the data objects allocated from this pool.  If this entry is monitoring sectors, blocks, buffers, or packets, for example, this number will commonly be greater than one.  Otherwise this number will typically be one.',0,'30',0,0,0,'',0),(25404,4,'{$SNMP_COMMUNITY}','HOST-RESOURCES-MIB::hrStorageDescr.{#SNMPINDEX}',10189,'Description of storage $1','hrStorageDescr[{#SNMPVALUE}]',3600,7,0,0,1,'','',0,0,'',0,'','','1','',0,'',25349,NULL,'','','',0,0,'','','','',0,2,NULL,'','A description of the type and instance of the storage described by this entry.',0,'30',0,0,0,'',0),(25405,15,'','',10189,'Total disk space on $1','hrStorageSizeInBytes[{#SNMPVALUE}]',3600,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',25350,NULL,'','last(\"hrStorageSize[{#SNMPVALUE}]\") * last(\"hrStorageAllocationUnits[{#SNMPVALUE}]\")','',0,0,'','','','',0,2,NULL,'','This is a calculated item, we need it to get total disk space in bytes.',0,'30',0,0,0,'',0),(25406,4,'{$SNMP_COMMUNITY}','HOST-RESOURCES-MIB::hrStorageSize.{#SNMPINDEX}',10189,'Total disk space on $1 in units','hrStorageSize[{#SNMPVALUE}]',3600,7,365,0,3,'','units',0,0,'',0,'','','1','',0,'',25351,NULL,'','','',0,0,'','','','',0,2,NULL,'','The size of the storage represented by this entry, in units of hrStorageAllocationUnits. This object is writable to allow remote configuration of the size of the storage area in those cases where such an operation makes sense and is possible on the underlying system. For example, the amount of main memory allocated to a buffer pool might be modified or the amount of disk space allocated to virtual memory might be modified.',0,'30',0,0,0,'',0),(25407,15,'','',10189,'Used disk space on $1','hrStorageUsedInBytes[{#SNMPVALUE}]',60,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',25352,NULL,'','last(\"hrStorageUsed[{#SNMPVALUE}]\") * last(\"hrStorageAllocationUnits[{#SNMPVALUE}]\")','',0,0,'','','','',0,2,NULL,'','This is a calculated item, we need it to get used disk space in bytes.',0,'30',0,0,0,'',0),(25408,4,'{$SNMP_COMMUNITY}','HOST-RESOURCES-MIB::hrStorageUsed.{#SNMPINDEX}',10189,'Used disk space on $1 in units','hrStorageUsed[{#SNMPVALUE}]',60,7,365,0,3,'','units',0,0,'',0,'','','1','',0,'',25353,NULL,'','','',0,0,'','','','',0,2,NULL,'','The amount of the storage represented by this entry that is allocated, in units of hrStorageAllocationUnits.',0,'30',0,0,0,'',0),(25409,4,'{$SNMP_COMMUNITY}','IF-MIB::ifAdminStatus.{#SNMPINDEX}',10189,'Admin status of interface $1','ifAdminStatus[{#SNMPVALUE}]',60,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',25354,11,'','','',0,0,'','','','',0,2,NULL,'','The desired state of the interface.',0,'30',0,0,0,'',0),(25410,4,'{$SNMP_COMMUNITY}','IF-MIB::ifAlias.{#SNMPINDEX}',10189,'Alias of interface $1','ifAlias[{#SNMPVALUE}]',3600,7,0,0,1,'','',0,0,'',0,'','','1','',0,'',25355,NULL,'','','',0,0,'','','','',0,2,NULL,'','',0,'30',0,0,0,'',0),(25411,4,'{$SNMP_COMMUNITY}','IF-MIB::ifDescr.{#SNMPINDEX}',10189,'Description of interface $1','ifDescr[{#SNMPVALUE}]',3600,7,0,0,1,'','',0,0,'',0,'','','1','',0,'',25356,NULL,'','','',0,0,'','','','',0,2,NULL,'','A textual string containing information about the interface.  This string should include the name of the manufacturer, the product name and the version of the interface hardware/software.',0,'30',0,0,0,'',0),(25412,4,'{$SNMP_COMMUNITY}','IF-MIB::ifInErrors.{#SNMPINDEX}',10189,'Inbound errors on interface $1','ifInErrors[{#SNMPVALUE}]',60,7,365,0,3,'','',0,1,'',0,'','','1','',0,'',25357,NULL,'','','',0,0,'','','','',0,2,NULL,'','For packet-oriented interfaces, the number of inbound packets that contained errors preventing them from being deliverable to a higher-layer protocol.  For character-oriented or fixed-length interfaces, the number of inbound transmission units that contained errors preventing them from being deliverable to a higher-layer protocol.',0,'30',0,0,0,'',0),(25413,4,'{$SNMP_COMMUNITY}','IF-MIB::ifInOctets.{#SNMPINDEX}',10189,'Incoming traffic on interface $1','ifInOctets[{#SNMPVALUE}]',60,7,365,0,3,'','bps',1,1,'',0,'','','8','',0,'',25358,NULL,'','','',0,0,'','','','',0,2,NULL,'','The number of octets in valid MAC frames received on this interface, including the MAC header and FCS.',0,'30',0,0,0,'',0),(25414,4,'{$SNMP_COMMUNITY}','IF-MIB::ifOperStatus.{#SNMPINDEX}',10189,'Operational status of interface $1','ifOperStatus[{#SNMPVALUE}]',60,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',25359,8,'','','',0,0,'','','','',0,2,NULL,'','The current operational state of the interface.',0,'30',0,0,0,'',0),(25415,4,'{$SNMP_COMMUNITY}','IF-MIB::ifOutErrors.{#SNMPINDEX}',10189,'Outbound errors on interface $1','ifOutErrors[{#SNMPVALUE}]',60,7,365,0,3,'','',0,1,'',0,'','','1','',0,'',25360,NULL,'','','',0,0,'','','','',0,2,NULL,'','For packet-oriented interfaces, the number of outbound packets that could not be transmitted because of errors. For character-oriented or fixed-length interfaces, the number of outbound transmission units that could not be transmitted because of errors.',0,'30',0,0,0,'',0),(25416,4,'{$SNMP_COMMUNITY}','IF-MIB::ifOutOctets.{#SNMPINDEX}',10189,'Outgoing traffic on interface $1','ifOutOctets[{#SNMPVALUE}]',60,7,365,0,3,'','bps',1,1,'',0,'','','8','',0,'',25361,NULL,'','','',0,0,'','','','',0,2,NULL,'','The number of octets transmitted in MAC frames on this interface, including the MAC header and FCS.',0,'30',0,0,0,'',0),(25417,4,'{$SNMP_COMMUNITY}','HOST-RESOURCES-MIB::hrProcessorLoad.{#SNMPINDEX}',10189,'Utilization of processor #$1','hrProcessorLoad[{#SNMPINDEX}]',60,7,365,0,3,'','%',0,0,'',0,'','','1','',0,'',25362,NULL,'','','',0,0,'','','','',0,2,NULL,'','The average, over the last minute, of the percentage of time that this processor was not idle. Implementations may approximate this one minute smoothing period if necessary.',0,'30',0,0,0,'',0);
/*!40000 ALTER TABLE `items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `items_applications`
--

DROP TABLE IF EXISTS `items_applications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `items_applications` (
  `itemappid` bigint(20) unsigned NOT NULL,
  `applicationid` bigint(20) unsigned NOT NULL,
  `itemid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`itemappid`),
  UNIQUE KEY `items_applications_1` (`applicationid`,`itemid`),
  KEY `items_applications_2` (`itemid`),
  CONSTRAINT `c_items_applications_1` FOREIGN KEY (`applicationid`) REFERENCES `applications` (`applicationid`) ON DELETE CASCADE,
  CONSTRAINT `c_items_applications_2` FOREIGN KEY (`itemid`) REFERENCES `items` (`itemid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items_applications`
--

LOCK TABLES `items_applications` WRITE;
/*!40000 ALTER TABLE `items_applications` DISABLE KEYS */;
INSERT INTO `items_applications` VALUES (7004,345,23252),(7005,345,23253),(7006,345,23254),(7007,345,23255),(7008,345,23256),(7009,345,23257),(7010,345,23258),(7011,345,23259),(7012,345,23260),(7013,345,23261),(7014,345,23262),(7015,345,23264),(7016,345,23265),(7017,345,23266),(7018,345,23267),(7019,345,23268),(7020,345,23269),(7021,345,23270),(7023,345,23271),(7024,345,23272),(7025,345,23273),(7031,345,23274),(7032,345,23275),(7033,345,23276),(7034,345,23277),(7022,345,23328),(7026,345,23620),(7027,345,23625),(7028,345,23628),(7030,345,23635),(7029,345,23662),(7003,345,24705),(5468,346,23294),(5470,346,23295),(5472,346,23296),(5474,346,23297),(5476,346,23298),(5478,346,23299),(5480,346,23300),(5482,346,23301),(5484,346,23302),(5486,346,23303),(5488,346,23304),(5490,346,23305),(5492,346,23306),(5455,347,23282),(5456,347,23283),(5457,347,23284),(5458,347,23285),(5459,347,23286),(5467,348,23293),(5495,348,23307),(5497,348,23308),(5502,348,23312),(5504,348,23313),(5498,349,23309),(5499,349,23310),(5500,349,23311),(5508,349,23316),(5509,349,23317),(5453,350,23280),(5454,350,23281),(5462,351,23289),(5463,351,23290),(5466,351,23293),(5494,351,23307),(5496,351,23308),(5501,351,23312),(5503,351,23313),(5505,351,23314),(5469,352,23294),(5471,352,23295),(5473,352,23296),(5475,352,23297),(5477,352,23298),(5479,352,23299),(5481,352,23300),(5483,352,23301),(5485,352,23302),(5487,352,23303),(5489,352,23304),(5491,352,23305),(5493,352,23306),(5464,353,23291),(5465,353,23292),(5506,354,23314),(5507,354,23315),(5460,355,23287),(5461,355,23288),(5523,355,23327),(7199,497,24882),(7200,497,24883),(7201,497,24884),(7202,497,24885),(7203,497,24886),(7204,497,24887),(7205,497,24888),(7206,497,24889),(7207,497,24890),(7208,497,24891),(7209,497,24892),(7210,497,24893),(7211,497,24894),(7212,497,24895),(7213,497,24896),(7214,497,24897),(7215,497,24898),(7216,497,24899),(7217,497,24900),(7218,497,24901),(7219,497,24902),(7220,497,24903),(7221,497,24904),(7222,497,24905),(7223,497,24906),(7224,497,24907),(7225,497,24908),(7226,497,24909),(7227,497,24910),(7228,497,24911),(7229,497,24912),(7230,497,24913),(7231,497,24914),(7232,497,24915),(7233,497,24916),(7234,497,24917),(7235,497,24918),(7236,497,24919),(7237,497,24920),(7238,497,24921),(7239,497,24922),(7240,497,24923),(7241,497,24924),(7242,497,24925),(7243,497,24926),(7244,497,24927),(7245,497,24928),(7246,497,24929),(7247,497,24930),(7248,497,24931),(7249,497,24932),(7250,497,24933),(7251,497,24934),(7252,497,24935),(7253,497,24936),(7254,497,24937),(7255,497,24938),(7256,497,24939),(7257,497,24940),(7258,497,24941),(7259,497,24942),(7260,497,24943),(7261,497,24944),(7262,497,24945),(7263,497,24946),(7264,497,24947),(7265,497,24948),(7266,497,24949),(7267,497,24950),(7268,497,24951),(7269,497,24952),(7270,497,24953),(7271,497,24954),(7272,497,24955),(7273,497,24956),(7274,497,24957),(7275,497,24958),(7276,497,24959),(7277,497,24960),(7278,497,24961),(7279,497,24962),(7280,497,24963),(7281,497,24964),(7282,497,24965),(7283,497,24966),(7284,497,24967),(7285,497,24968),(7286,497,24969),(7287,497,24970),(7288,497,24971),(7289,497,24972),(7290,497,24973),(7291,497,24974),(7292,497,24975),(7293,497,24976),(7294,497,24977),(7295,497,24978),(7296,497,24979),(7297,497,24980),(7298,497,24981),(7299,497,24982),(7300,497,24983),(7301,497,24984),(7302,497,24985),(7303,497,24986),(7304,497,24987),(7305,497,24988),(7306,497,24989),(7307,497,24990),(7308,497,24991),(7309,497,24992),(7310,497,24993),(7311,497,24994),(7312,497,24995),(7313,497,24996),(7314,497,24997),(7315,497,24998),(7316,497,24999),(7317,497,25000),(7318,497,25001),(7319,497,25002),(7320,497,25003),(7321,497,25004),(7322,497,25005),(7323,497,25006),(7324,497,25007),(7325,497,25008),(7326,497,25009),(7327,497,25010),(7328,497,25011),(7329,497,25012),(7330,497,25013),(7331,497,25014),(7332,497,25015),(7333,497,25016),(7334,497,25017),(7335,497,25018),(7336,497,25019),(7337,497,25020),(7338,497,25021),(7339,497,25022),(7340,497,25023),(7341,497,25024),(7342,497,25025),(7343,497,25026),(7344,497,25027),(7345,497,25028),(7346,497,25029),(7347,497,25030),(7348,497,25031),(7349,497,25032),(7350,497,25033),(7351,497,25034),(7352,497,25035),(7353,497,25036),(7354,497,25037),(7355,497,25038),(7356,497,25039),(7357,497,25040),(7358,497,25041),(7359,497,25042),(7360,497,25043),(7361,497,25044),(7362,497,25045),(7363,497,25046),(7364,497,25047),(7365,497,25048),(7366,498,25050),(7367,498,25051),(7368,498,25052),(7369,498,25053),(7370,498,25054),(7371,498,25055),(7372,498,25056),(7373,498,25057),(7374,498,25058),(7375,499,25059),(7376,499,25060),(7377,499,25061),(7378,499,25062),(7379,499,25063),(7380,499,25064),(7381,499,25065),(7382,499,25066),(7383,499,25067),(7384,499,25068),(7385,499,25069),(7386,499,25070),(7387,499,25071),(7388,499,25072),(7389,499,25073),(7390,500,25074),(7391,501,25075),(7392,501,25076),(7393,502,25077),(7394,502,25078),(7395,502,25079),(7396,503,25080),(7397,504,25081),(7398,504,25082),(7399,505,25083),(7400,506,25084),(7401,507,25085),(7402,508,25086),(7403,509,25087),(7404,509,25088),(7405,509,25089),(7406,509,25090),(7407,509,25091),(7408,509,25092),(7409,509,25093),(7651,510,25326),(7652,510,25327),(7653,510,25328),(7654,510,25329),(7655,510,25330),(7656,510,25331),(7657,510,25332),(7658,510,25333),(7659,510,25334),(7410,511,25094),(7411,511,25095),(7412,511,25096),(7413,511,25097),(7414,511,25098),(7415,511,25099),(7416,511,25100),(7417,511,25101),(7418,511,25102),(7419,511,25103),(7420,511,25104),(7421,511,25105),(7422,511,25106),(7423,511,25107),(7424,512,25108),(7425,512,25109),(7426,512,25110),(7427,512,25111),(7428,512,25112),(7429,512,25113),(7430,513,25114),(7431,513,25115),(7432,513,25116),(7433,514,25117),(7434,515,25118),(7435,516,25119),(7436,516,25120),(7437,516,25121),(7438,516,25122),(7439,516,25123),(7440,516,25124),(7441,516,25125),(7442,516,25126),(7443,516,25127),(7444,516,25128),(7445,516,25129),(7446,516,25130),(7447,516,25131),(7448,516,25132),(7449,516,25133),(7450,516,25134),(7451,516,25135),(7452,516,25136),(7453,516,25137),(7454,516,25138),(7455,516,25139),(7456,517,25140),(7457,517,25141),(7458,517,25142),(7459,517,25143),(7460,517,25144),(7461,517,25145),(7462,517,25146),(7463,517,25147),(7464,517,25148),(7465,517,25149),(7466,517,25150),(7467,517,25151),(7468,517,25152),(7469,517,25153),(7470,517,25154),(7471,517,25155),(7472,517,25156),(7473,517,25157),(7474,517,25158),(7475,517,25159),(7476,517,25160),(7477,517,25161),(7478,517,25162),(7479,517,25163),(7480,517,25164),(7481,517,25165),(7482,517,25166),(7483,517,25167),(7484,517,25168),(7485,517,25169),(7486,517,25170),(7487,517,25171),(7488,518,25172),(7489,518,25173),(7490,518,25174),(7498,519,25182),(7495,520,25179),(7491,521,25175),(7492,521,25176),(7493,521,25177),(7494,521,25178),(7496,521,25180),(7497,521,25181),(7508,522,25192),(7509,522,25193),(7499,523,25183),(7506,523,25190),(7500,524,25184),(7501,524,25185),(7502,524,25186),(7503,524,25187),(7504,524,25188),(7505,524,25189),(7507,524,25191),(7517,525,25200),(7519,525,25201),(7521,525,25202),(7523,525,25203),(7525,525,25204),(7528,525,25206),(7530,525,25207),(7532,525,25208),(7534,525,25209),(7536,525,25210),(7538,525,25211),(7540,525,25212),(7542,525,25213),(7662,526,25337),(7663,526,25338),(7664,526,25339),(7665,526,25340),(7666,526,25341),(7513,527,25197),(7544,527,25214),(7546,527,25215),(7548,527,25216),(7553,528,25219),(7554,528,25220),(7660,529,25335),(7661,529,25336),(7511,530,25195),(7512,530,25196),(7514,530,25197),(7545,530,25214),(7547,530,25215),(7549,530,25216),(7550,530,25217),(7518,531,25200),(7520,531,25201),(7522,531,25202),(7524,531,25203),(7526,531,25204),(7529,531,25206),(7531,531,25207),(7533,531,25208),(7535,531,25209),(7537,531,25210),(7539,531,25211),(7541,531,25212),(7543,531,25213),(7515,533,25198),(7516,533,25199),(7527,533,25205),(7551,534,25217),(7552,534,25218),(7510,535,25194),(7566,536,25228),(7568,536,25229),(7570,536,25230),(7556,537,25222),(7558,537,25223),(7561,537,25225),(7563,537,25226),(7669,537,25344),(7670,537,25345),(7671,537,25346),(7672,537,25347),(7574,538,25233),(7576,538,25234),(7572,539,25231),(7573,539,25232),(7577,539,25235),(7578,539,25236),(7667,540,25342),(7668,540,25343),(7560,541,25224),(7575,541,25233),(7557,542,25222),(7559,542,25223),(7562,542,25225),(7564,542,25226),(7567,542,25228),(7569,542,25229),(7571,542,25230),(7565,543,25227),(7555,544,25221),(7673,545,25348),(7674,545,25349),(7675,545,25350),(7676,545,25351),(7677,545,25352),(7678,545,25353),(7579,546,25237),(7580,546,25238),(7581,546,25239),(7582,546,25240),(7583,546,25241),(7584,547,25242),(7679,547,25354),(7680,547,25355),(7681,547,25356),(7682,547,25357),(7683,547,25358),(7684,547,25359),(7685,547,25360),(7686,547,25361),(7687,548,25362),(7688,549,25363),(7586,550,25244),(7587,550,25245),(7585,551,25243),(7589,552,25247),(7590,552,25248),(7591,552,25249),(7693,553,25368),(7694,553,25369),(7695,553,25370),(7696,553,25371),(7697,554,25372),(7698,554,25373),(7699,554,25374),(7700,554,25375),(7588,555,25246),(7592,555,25250),(7593,555,25251),(7602,555,25260),(7606,555,25264),(7689,556,25364),(7690,556,25365),(7691,556,25366),(7692,556,25367),(7594,557,25252),(7595,557,25253),(7596,557,25254),(7597,557,25255),(7598,557,25256),(7599,557,25257),(7600,557,25258),(7601,557,25259),(7603,559,25261),(7604,559,25262),(7605,559,25263),(7608,560,25266),(7611,560,25269),(7613,560,25270),(7615,560,25271),(7617,560,25272),(7701,561,25376),(7702,561,25377),(7703,561,25378),(7704,561,25379),(7607,562,25265),(7609,562,25267),(7610,562,25268),(7628,562,25281),(7629,562,25282),(7630,562,25283),(7631,562,25284),(7632,562,25285),(7612,563,25269),(7614,563,25270),(7616,563,25271),(7618,563,25272),(7619,563,25273),(7621,563,25274),(7622,563,25275),(7623,563,25276),(7620,564,25273),(7624,564,25277),(7625,564,25278),(7626,565,25279),(7627,565,25280),(7633,566,25286),(7634,566,25287),(7635,566,25288),(7636,566,25289),(7637,566,25290),(7638,567,25291),(7705,567,25380),(7706,567,25381),(7707,567,25382),(7708,567,25383),(7709,567,25384),(7710,567,25385),(7711,567,25386),(7712,567,25387),(7713,568,25388),(7714,568,25389),(7715,568,25390),(7716,568,25391),(7717,568,25392),(7718,568,25393),(7639,569,25292),(7640,569,25293),(7641,569,25294),(7642,569,25295),(7643,569,25296),(7644,570,25297),(7719,570,25394),(7720,570,25395),(7721,570,25396),(7722,570,25397),(7723,570,25398),(7724,570,25399),(7725,570,25400),(7726,570,25401),(7727,571,25402),(7728,572,25403),(7729,572,25404),(7730,572,25405),(7731,572,25406),(7732,572,25407),(7733,572,25408),(7645,573,25298),(7646,573,25299),(7647,573,25300),(7648,573,25301),(7649,573,25302),(7650,574,25303),(7734,574,25409),(7735,574,25410),(7736,574,25411),(7737,574,25412),(7738,574,25413),(7739,574,25414),(7740,574,25415),(7741,574,25416),(7742,575,25417);
/*!40000 ALTER TABLE `items_applications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `maintenances`
--

DROP TABLE IF EXISTS `maintenances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `maintenances` (
  `maintenanceid` bigint(20) unsigned NOT NULL,
  `name` varchar(128) NOT NULL DEFAULT '',
  `maintenance_type` int(11) NOT NULL DEFAULT '0',
  `description` text NOT NULL,
  `active_since` int(11) NOT NULL DEFAULT '0',
  `active_till` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`maintenanceid`),
  UNIQUE KEY `maintenances_2` (`name`),
  KEY `maintenances_1` (`active_since`,`active_till`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maintenances`
--

LOCK TABLES `maintenances` WRITE;
/*!40000 ALTER TABLE `maintenances` DISABLE KEYS */;
/*!40000 ALTER TABLE `maintenances` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `maintenances_groups`
--

DROP TABLE IF EXISTS `maintenances_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `maintenances_groups` (
  `maintenance_groupid` bigint(20) unsigned NOT NULL,
  `maintenanceid` bigint(20) unsigned NOT NULL,
  `groupid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`maintenance_groupid`),
  UNIQUE KEY `maintenances_groups_1` (`maintenanceid`,`groupid`),
  KEY `maintenances_groups_2` (`groupid`),
  CONSTRAINT `c_maintenances_groups_1` FOREIGN KEY (`maintenanceid`) REFERENCES `maintenances` (`maintenanceid`) ON DELETE CASCADE,
  CONSTRAINT `c_maintenances_groups_2` FOREIGN KEY (`groupid`) REFERENCES `groups` (`groupid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maintenances_groups`
--

LOCK TABLES `maintenances_groups` WRITE;
/*!40000 ALTER TABLE `maintenances_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `maintenances_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `maintenances_hosts`
--

DROP TABLE IF EXISTS `maintenances_hosts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `maintenances_hosts` (
  `maintenance_hostid` bigint(20) unsigned NOT NULL,
  `maintenanceid` bigint(20) unsigned NOT NULL,
  `hostid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`maintenance_hostid`),
  UNIQUE KEY `maintenances_hosts_1` (`maintenanceid`,`hostid`),
  KEY `maintenances_hosts_2` (`hostid`),
  CONSTRAINT `c_maintenances_hosts_1` FOREIGN KEY (`maintenanceid`) REFERENCES `maintenances` (`maintenanceid`) ON DELETE CASCADE,
  CONSTRAINT `c_maintenances_hosts_2` FOREIGN KEY (`hostid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maintenances_hosts`
--

LOCK TABLES `maintenances_hosts` WRITE;
/*!40000 ALTER TABLE `maintenances_hosts` DISABLE KEYS */;
/*!40000 ALTER TABLE `maintenances_hosts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `maintenances_windows`
--

DROP TABLE IF EXISTS `maintenances_windows`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `maintenances_windows` (
  `maintenance_timeperiodid` bigint(20) unsigned NOT NULL,
  `maintenanceid` bigint(20) unsigned NOT NULL,
  `timeperiodid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`maintenance_timeperiodid`),
  UNIQUE KEY `maintenances_windows_1` (`maintenanceid`,`timeperiodid`),
  KEY `maintenances_windows_2` (`timeperiodid`),
  CONSTRAINT `c_maintenances_windows_1` FOREIGN KEY (`maintenanceid`) REFERENCES `maintenances` (`maintenanceid`) ON DELETE CASCADE,
  CONSTRAINT `c_maintenances_windows_2` FOREIGN KEY (`timeperiodid`) REFERENCES `timeperiods` (`timeperiodid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maintenances_windows`
--

LOCK TABLES `maintenances_windows` WRITE;
/*!40000 ALTER TABLE `maintenances_windows` DISABLE KEYS */;
/*!40000 ALTER TABLE `maintenances_windows` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mappings`
--

DROP TABLE IF EXISTS `mappings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mappings` (
  `mappingid` bigint(20) unsigned NOT NULL,
  `valuemapid` bigint(20) unsigned NOT NULL,
  `value` varchar(64) NOT NULL DEFAULT '',
  `newvalue` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`mappingid`),
  KEY `mappings_1` (`valuemapid`),
  CONSTRAINT `c_mappings_1` FOREIGN KEY (`valuemapid`) REFERENCES `valuemaps` (`valuemapid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mappings`
--

LOCK TABLES `mappings` WRITE;
/*!40000 ALTER TABLE `mappings` DISABLE KEYS */;
INSERT INTO `mappings` VALUES (1,1,'0','Down'),(2,1,'1','Up'),(3,2,'0','not available'),(4,2,'1','available'),(5,2,'2','unknown'),(13,6,'1','Other'),(14,6,'2','OK'),(15,6,'3','Degraded'),(17,7,'1','Other'),(18,7,'2','Unknown'),(19,7,'3','OK'),(20,7,'4','NonCritical'),(21,7,'5','Critical'),(22,7,'6','NonRecoverable'),(23,5,'1','unknown'),(24,5,'2','batteryNormal'),(25,5,'3','batteryLow'),(26,4,'1','unknown'),(27,4,'2','notInstalled'),(28,4,'3','ok'),(29,4,'4','failed'),(30,4,'5','highTemperature'),(31,4,'6','replaceImmediately'),(32,4,'7','lowCapacity'),(33,3,'0','Running'),(34,3,'1','Paused'),(35,3,'3','Pause pending'),(36,3,'4','Continue pending'),(37,3,'5','Stop pending'),(38,3,'6','Stopped'),(39,3,'7','Unknown'),(40,3,'255','No such service'),(41,3,'2','Start pending'),(49,9,'1','unknown'),(50,9,'2','running'),(51,9,'3','warning'),(52,9,'4','testing'),(53,9,'5','down'),(61,8,'1','up'),(62,8,'2','down'),(63,8,'3','testing'),(64,8,'4','unknown'),(65,8,'5','dormant'),(66,8,'6','notPresent'),(67,8,'7','lowerLayerDown'),(68,10,'1','Up'),(69,11,'1','up'),(70,11,'2','down'),(71,11,'3','testing'),(72,12,'0','poweredOff'),(73,12,'1','poweredOn'),(74,12,'2','suspended'),(75,13,'0','gray'),(76,13,'1','green'),(77,13,'2','yellow'),(78,13,'3','red'),(79,14,'0','normal'),(80,14,'1','in maintenance'),(81,14,'2','no data collection'),(82,15,'0','Normal'),(83,15,'1','Low memory'),(84,16,'0','Automatic'),(85,16,'1','Automatic delayed'),(86,16,'2','Manual'),(87,16,'3','Disabled'),(88,16,'4','Unknown'),(89,17,'100','Continue'),(90,17,'101','Switching Protocols'),(91,17,'102','Processing'),(92,17,'200','OK'),(93,17,'201','Created'),(94,17,'202','Accepted'),(95,17,'203','Non-Authoritative Information'),(96,17,'204','No Content'),(97,17,'205','Reset Content'),(98,17,'206','Partial Content'),(99,17,'207','Multi-Status'),(100,17,'208','Already Reported'),(101,17,'226','IM Used'),(102,17,'300','Multiple Choices'),(103,17,'301','Moved Permanently'),(104,17,'302','Found'),(105,17,'303','See Other'),(106,17,'304','Not Modified'),(107,17,'305','Use Proxy'),(108,17,'306','Switch Proxy'),(109,17,'307','Temporary Redirect'),(110,17,'308','Permanent Redirect/Resume Incomplete'),(111,17,'400','Bad Request'),(112,17,'401','Unauthorized'),(113,17,'402','Payment Required'),(114,17,'403','Forbidden'),(115,17,'404','Not Found'),(116,17,'405','Method Not Allowed'),(117,17,'406','Not Acceptable'),(118,17,'407','Proxy Authentication Required'),(119,17,'408','Request Timeout'),(120,17,'409','Conflict'),(121,17,'410','Gone'),(122,17,'411','Length Required'),(123,17,'412','Precondition Failed'),(124,17,'413','Payload Too Large'),(125,17,'414','Request-URI Too Long'),(126,17,'415','Unsupported Media Type'),(127,17,'416','Requested Range Not Satisfiable'),(128,17,'417','Expectation Failed'),(129,17,'418','I\'m a Teapot'),(130,17,'419','Authentication Timeout'),(131,17,'420','Method Failure/Enhance Your Calm'),(132,17,'421','Misdirected Request'),(133,17,'422','Unprocessable Entity'),(134,17,'423','Locked'),(135,17,'424','Failed Dependency'),(136,17,'426','Upgrade Required'),(137,17,'428','Precondition Required'),(138,17,'429','Too Many Requests'),(139,17,'431','Request Header Fields Too Large'),(140,17,'440','Login Timeout'),(141,17,'444','No Response'),(142,17,'449','Retry With'),(143,17,'450','Blocked by Windows Parental Controls'),(144,17,'451','Unavailable for Legal Reasons/Redirect'),(145,17,'494','Request Header Too Large'),(146,17,'495','Cert Error'),(147,17,'496','No Cert'),(148,17,'497','HTTP to HTTPS'),(149,17,'498','Token Expired/Invalid'),(150,17,'499','Client Closed Request/Token Required'),(151,17,'500','Internal Server Error'),(152,17,'501','Not Implemented'),(153,17,'502','Bad Gateway'),(154,17,'503','Service Unavailable'),(155,17,'504','Gateway Timeout'),(156,17,'505','HTTP Version Not Supported'),(157,17,'506','Variant Also Negotiates'),(158,17,'507','Insufficient Storage'),(159,17,'508','Loop Detected'),(160,17,'509','Bandwidth Limit Exceeded'),(161,17,'510','Not Extended'),(162,17,'511','Network Authentication Required'),(163,17,'520','Unknown Error'),(164,17,'598','Network Read Timeout Error'),(165,17,'599','Network Connect Timeout Error');
/*!40000 ALTER TABLE `mappings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `media`
--

DROP TABLE IF EXISTS `media`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `media` (
  `mediaid` bigint(20) unsigned NOT NULL,
  `userid` bigint(20) unsigned NOT NULL,
  `mediatypeid` bigint(20) unsigned NOT NULL,
  `sendto` varchar(100) NOT NULL DEFAULT '',
  `active` int(11) NOT NULL DEFAULT '0',
  `severity` int(11) NOT NULL DEFAULT '63',
  `period` varchar(100) NOT NULL DEFAULT '1-7,00:00-24:00',
  PRIMARY KEY (`mediaid`),
  KEY `media_1` (`userid`),
  KEY `media_2` (`mediatypeid`),
  CONSTRAINT `c_media_1` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`) ON DELETE CASCADE,
  CONSTRAINT `c_media_2` FOREIGN KEY (`mediatypeid`) REFERENCES `media_type` (`mediatypeid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media`
--

LOCK TABLES `media` WRITE;
/*!40000 ALTER TABLE `media` DISABLE KEYS */;
INSERT INTO `media` VALUES (11,1,4,'lihao',0,63,'1-7,00:00-24:00');
/*!40000 ALTER TABLE `media` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `media_type`
--

DROP TABLE IF EXISTS `media_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `media_type` (
  `mediatypeid` bigint(20) unsigned NOT NULL,
  `type` int(11) NOT NULL DEFAULT '0',
  `description` varchar(100) NOT NULL DEFAULT '',
  `smtp_server` varchar(255) NOT NULL DEFAULT '',
  `smtp_helo` varchar(255) NOT NULL DEFAULT '',
  `smtp_email` varchar(255) NOT NULL DEFAULT '',
  `exec_path` varchar(255) NOT NULL DEFAULT '',
  `gsm_modem` varchar(255) NOT NULL DEFAULT '',
  `username` varchar(255) NOT NULL DEFAULT '',
  `passwd` varchar(255) NOT NULL DEFAULT '',
  `status` int(11) NOT NULL DEFAULT '0',
  `smtp_port` int(11) NOT NULL DEFAULT '25',
  `smtp_security` int(11) NOT NULL DEFAULT '0',
  `smtp_verify_peer` int(11) NOT NULL DEFAULT '0',
  `smtp_verify_host` int(11) NOT NULL DEFAULT '0',
  `smtp_authentication` int(11) NOT NULL DEFAULT '0',
  `exec_params` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`mediatypeid`),
  UNIQUE KEY `media_type_1` (`description`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media_type`
--

LOCK TABLES `media_type` WRITE;
/*!40000 ALTER TABLE `media_type` DISABLE KEYS */;
INSERT INTO `media_type` VALUES (1,1,'Email','mail.company.com','company.com','zabbix@company.com','Email.py','','','',0,25,0,0,0,0,'{ALERT.SENDTO}\n{ALERT.SUBJECT}\n{ALERT.MESSAGE}\n'),(2,3,'Jabber','','','','','','jabber@company.com','zabbix',0,25,0,0,0,0,''),(3,2,'SMS','','','','','/dev/ttyS0','','',0,25,0,0,0,0,''),(4,1,'Wechat','','','','Wechat.py','','','',0,25,0,0,0,0,'{ALERT.SENDTO}\n{ALERT.SUBJECT}\n{ALERT.MESSAGE}\n'),(5,0,'Email-163','smtp.163.com','163','telecomopenstack@163.com','','','telecomopenstack','Openstack2016',0,25,0,0,0,1,'');
/*!40000 ALTER TABLE `media_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opcommand`
--

DROP TABLE IF EXISTS `opcommand`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `opcommand` (
  `operationid` bigint(20) unsigned NOT NULL,
  `type` int(11) NOT NULL DEFAULT '0',
  `scriptid` bigint(20) unsigned DEFAULT NULL,
  `execute_on` int(11) NOT NULL DEFAULT '0',
  `port` varchar(64) NOT NULL DEFAULT '',
  `authtype` int(11) NOT NULL DEFAULT '0',
  `username` varchar(64) NOT NULL DEFAULT '',
  `password` varchar(64) NOT NULL DEFAULT '',
  `publickey` varchar(64) NOT NULL DEFAULT '',
  `privatekey` varchar(64) NOT NULL DEFAULT '',
  `command` text NOT NULL,
  PRIMARY KEY (`operationid`),
  KEY `opcommand_1` (`scriptid`),
  CONSTRAINT `c_opcommand_1` FOREIGN KEY (`operationid`) REFERENCES `operations` (`operationid`) ON DELETE CASCADE,
  CONSTRAINT `c_opcommand_2` FOREIGN KEY (`scriptid`) REFERENCES `scripts` (`scriptid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opcommand`
--

LOCK TABLES `opcommand` WRITE;
/*!40000 ALTER TABLE `opcommand` DISABLE KEYS */;
/*!40000 ALTER TABLE `opcommand` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opcommand_grp`
--

DROP TABLE IF EXISTS `opcommand_grp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `opcommand_grp` (
  `opcommand_grpid` bigint(20) unsigned NOT NULL,
  `operationid` bigint(20) unsigned NOT NULL,
  `groupid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`opcommand_grpid`),
  KEY `opcommand_grp_1` (`operationid`),
  KEY `opcommand_grp_2` (`groupid`),
  CONSTRAINT `c_opcommand_grp_1` FOREIGN KEY (`operationid`) REFERENCES `operations` (`operationid`) ON DELETE CASCADE,
  CONSTRAINT `c_opcommand_grp_2` FOREIGN KEY (`groupid`) REFERENCES `groups` (`groupid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opcommand_grp`
--

LOCK TABLES `opcommand_grp` WRITE;
/*!40000 ALTER TABLE `opcommand_grp` DISABLE KEYS */;
/*!40000 ALTER TABLE `opcommand_grp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opcommand_hst`
--

DROP TABLE IF EXISTS `opcommand_hst`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `opcommand_hst` (
  `opcommand_hstid` bigint(20) unsigned NOT NULL,
  `operationid` bigint(20) unsigned NOT NULL,
  `hostid` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`opcommand_hstid`),
  KEY `opcommand_hst_1` (`operationid`),
  KEY `opcommand_hst_2` (`hostid`),
  CONSTRAINT `c_opcommand_hst_1` FOREIGN KEY (`operationid`) REFERENCES `operations` (`operationid`) ON DELETE CASCADE,
  CONSTRAINT `c_opcommand_hst_2` FOREIGN KEY (`hostid`) REFERENCES `hosts` (`hostid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opcommand_hst`
--

LOCK TABLES `opcommand_hst` WRITE;
/*!40000 ALTER TABLE `opcommand_hst` DISABLE KEYS */;
/*!40000 ALTER TABLE `opcommand_hst` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opconditions`
--

DROP TABLE IF EXISTS `opconditions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `opconditions` (
  `opconditionid` bigint(20) unsigned NOT NULL,
  `operationid` bigint(20) unsigned NOT NULL,
  `conditiontype` int(11) NOT NULL DEFAULT '0',
  `operator` int(11) NOT NULL DEFAULT '0',
  `value` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`opconditionid`),
  KEY `opconditions_1` (`operationid`),
  CONSTRAINT `c_opconditions_1` FOREIGN KEY (`operationid`) REFERENCES `operations` (`operationid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opconditions`
--

LOCK TABLES `opconditions` WRITE;
/*!40000 ALTER TABLE `opconditions` DISABLE KEYS */;
/*!40000 ALTER TABLE `opconditions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `operations`
--

DROP TABLE IF EXISTS `operations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `operations` (
  `operationid` bigint(20) unsigned NOT NULL,
  `actionid` bigint(20) unsigned NOT NULL,
  `operationtype` int(11) NOT NULL DEFAULT '0',
  `esc_period` int(11) NOT NULL DEFAULT '0',
  `esc_step_from` int(11) NOT NULL DEFAULT '1',
  `esc_step_to` int(11) NOT NULL DEFAULT '1',
  `evaltype` int(11) NOT NULL DEFAULT '0',
  `recovery` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`operationid`),
  KEY `operations_1` (`actionid`),
  CONSTRAINT `c_operations_1` FOREIGN KEY (`actionid`) REFERENCES `actions` (`actionid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `operations`
--

LOCK TABLES `operations` WRITE;
/*!40000 ALTER TABLE `operations` DISABLE KEYS */;
INSERT INTO `operations` VALUES (2,2,4,0,1,1,0,0),(3,3,0,0,1,1,0,0),(4,4,0,0,1,1,0,0),(5,5,0,0,1,1,0,0),(6,6,0,0,1,1,0,0),(9,7,0,0,1,1,0,0),(14,9,2,0,1,1,0,0),(15,9,4,0,1,1,0,0),(17,10,2,0,1,1,0,0),(21,11,0,0,1,1,0,0),(26,12,0,0,1,1,0,0),(29,3,11,0,1,1,0,1),(30,4,11,0,1,1,0,1),(31,5,11,0,1,1,0,1),(32,6,11,0,1,1,0,1),(33,7,11,0,1,1,0,1),(34,11,11,0,1,1,0,1),(35,12,11,0,1,1,0,1),(36,8,2,0,1,1,0,0),(37,8,4,0,1,1,0,0),(40,9,6,0,1,1,0,0),(41,8,6,0,1,1,0,0),(42,10,6,0,1,1,0,0),(43,13,2,0,1,1,0,0),(44,13,4,0,1,1,0,0),(45,13,6,0,1,1,0,0);
/*!40000 ALTER TABLE `operations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opgroup`
--

DROP TABLE IF EXISTS `opgroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `opgroup` (
  `opgroupid` bigint(20) unsigned NOT NULL,
  `operationid` bigint(20) unsigned NOT NULL,
  `groupid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`opgroupid`),
  UNIQUE KEY `opgroup_1` (`operationid`,`groupid`),
  KEY `opgroup_2` (`groupid`),
  CONSTRAINT `c_opgroup_1` FOREIGN KEY (`operationid`) REFERENCES `operations` (`operationid`) ON DELETE CASCADE,
  CONSTRAINT `c_opgroup_2` FOREIGN KEY (`groupid`) REFERENCES `groups` (`groupid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opgroup`
--

LOCK TABLES `opgroup` WRITE;
/*!40000 ALTER TABLE `opgroup` DISABLE KEYS */;
INSERT INTO `opgroup` VALUES (1,2,2),(3,15,9),(5,37,9),(6,44,8);
/*!40000 ALTER TABLE `opgroup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opinventory`
--

DROP TABLE IF EXISTS `opinventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `opinventory` (
  `operationid` bigint(20) unsigned NOT NULL,
  `inventory_mode` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`operationid`),
  CONSTRAINT `c_opinventory_1` FOREIGN KEY (`operationid`) REFERENCES `operations` (`operationid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opinventory`
--

LOCK TABLES `opinventory` WRITE;
/*!40000 ALTER TABLE `opinventory` DISABLE KEYS */;
/*!40000 ALTER TABLE `opinventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opmessage`
--

DROP TABLE IF EXISTS `opmessage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `opmessage` (
  `operationid` bigint(20) unsigned NOT NULL,
  `default_msg` int(11) NOT NULL DEFAULT '0',
  `subject` varchar(255) NOT NULL DEFAULT '',
  `message` text NOT NULL,
  `mediatypeid` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`operationid`),
  KEY `opmessage_1` (`mediatypeid`),
  CONSTRAINT `c_opmessage_1` FOREIGN KEY (`operationid`) REFERENCES `operations` (`operationid`) ON DELETE CASCADE,
  CONSTRAINT `c_opmessage_2` FOREIGN KEY (`mediatypeid`) REFERENCES `media_type` (`mediatypeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opmessage`
--

LOCK TABLES `opmessage` WRITE;
/*!40000 ALTER TABLE `opmessage` DISABLE KEYS */;
INSERT INTO `opmessage` VALUES (3,1,'{TRIGGER.STATUS}: {TRIGGER.NAME}','Trigger: {TRIGGER.NAME}\r\nTrigger status: {TRIGGER.STATUS}\r\nTrigger severity: {TRIGGER.SEVERITY}\r\nTrigger URL: {TRIGGER.URL}\r\n\r\nItem values:\r\n\r\n1. {ITEM.NAME1} ({HOST.NAME1}:{ITEM.KEY1}): {ITEM.VALUE1}\r\n2. {ITEM.NAME2} ({HOST.NAME2}:{ITEM.KEY2}): {ITEM.VALUE2}\r\n3. {ITEM.NAME3} ({HOST.NAME3}:{ITEM.KEY3}): {ITEM.VALUE3}',NULL),(4,1,'','',NULL),(5,1,'','',NULL),(6,1,'','',NULL),(9,1,'{TRIGGER.STATUS}: {TRIGGER.NAME}','Trigger: {TRIGGER.NAME}\r\nTrigger status: {TRIGGER.STATUS}\r\nTrigger severity: {TRIGGER.SEVERITY}\r\nTrigger URL: {TRIGGER.URL}\r\n\r\nItem values:\r\n\r\n1. {ITEM.NAME1} ({HOST.NAME1}:{ITEM.KEY1}): {ITEM.VALUE1}\r\n2. {ITEM.NAME2} ({HOST.NAME2}:{ITEM.KEY2}): {ITEM.VALUE2}\r\n3. {ITEM.NAME3} ({HOST.NAME3}:{ITEM.KEY3}): {ITEM.VALUE3}\r\n\r\nOriginal event ID: {EVENT.ID}',1),(21,1,'{TRIGGER.STATUS}: {TRIGGER.NAME}','Trigger: {TRIGGER.NAME}\r\nTrigger status: {TRIGGER.STATUS}\r\nTrigger severity: {TRIGGER.SEVERITY}\r\nTrigger URL: {TRIGGER.URL}\r\n\r\nItem values:\r\n\r\n1. {ITEM.NAME1} ({HOST.NAME1}:{ITEM.KEY1}): {ITEM.VALUE1}\r\n2. {ITEM.NAME2} ({HOST.NAME2}:{ITEM.KEY2}): {ITEM.VALUE2}\r\n3. {ITEM.NAME3} ({HOST.NAME3}:{ITEM.KEY3}): {ITEM.VALUE3}\r\n\r\nOriginal event ID: {EVENT.ID}',4),(26,1,'{TRIGGER.STATUS}: {TRIGGER.NAME}','Trigger: {TRIGGER.NAME}\r\nTrigger status: {TRIGGER.STATUS}\r\nTrigger severity: {TRIGGER.SEVERITY}\r\nTrigger URL: {TRIGGER.URL}\r\n\r\nItem values:\r\n\r\n1. {ITEM.NAME1} ({HOST.NAME1}:{ITEM.KEY1}): {ITEM.VALUE1}\r\n2. {ITEM.NAME2} ({HOST.NAME2}:{ITEM.KEY2}): {ITEM.VALUE2}\r\n3. {ITEM.NAME3} ({HOST.NAME3}:{ITEM.KEY3}): {ITEM.VALUE3}\r\n\r\nOriginal event ID: {EVENT.ID}',5),(29,1,'{TRIGGER.STATUS}: {TRIGGER.NAME}','Trigger: {TRIGGER.NAME}\r\nTrigger status: {TRIGGER.STATUS}\r\nTrigger severity: {TRIGGER.SEVERITY}\r\nTrigger URL: {TRIGGER.URL}\r\n\r\nItem values:\r\n\r\n1. {ITEM.NAME1} ({HOST.NAME1}:{ITEM.KEY1}): {ITEM.VALUE1}\r\n2. {ITEM.NAME2} ({HOST.NAME2}:{ITEM.KEY2}): {ITEM.VALUE2}\r\n3. {ITEM.NAME3} ({HOST.NAME3}:{ITEM.KEY3}): {ITEM.VALUE3}\r\n\r\nOriginal event ID: {EVENT.ID}',NULL),(30,1,'{ITEM.STATE}: {HOST.NAME}:{ITEM.NAME}','Host: {HOST.NAME}\r\nItem: {ITEM.NAME}\r\nKey: {ITEM.KEY}\r\nState: {ITEM.STATE}',NULL),(31,1,'{LLDRULE.STATE}: {HOST.NAME}:{LLDRULE.NAME}','Host: {HOST.NAME}\r\nLow level discovery rule: {LLDRULE.NAME}\r\nKey: {LLDRULE.KEY}\r\nState: {LLDRULE.STATE}',NULL),(32,1,'{TRIGGER.STATE}: {TRIGGER.NAME}','Trigger name: {TRIGGER.NAME}\r\nExpression: {TRIGGER.EXPRESSION}\r\nState: {TRIGGER.STATE}',NULL),(33,1,'Cluster故障恢复: {HOST.IP}  {TRIGGER.STATUS}: {TRIGGER.NAME}','Trigger: {TRIGGER.NAME}\r\nTrigger status: {TRIGGER.STATUS}\r\nTrigger severity: {TRIGGER.SEVERITY}\r\n\r\nItem values:\r\n\r\n{ITEM.NAME1} ({HOST.NAME1}:{ITEM.KEY1}): {ITEM.VALUE1}\r\n\r\nOriginal event ID: {EVENT.ID}',NULL),(34,1,'Cluster: {HOST.IP}  {TRIGGER.STATUS}: {TRIGGER.NAME}','Trigger: {TRIGGER.NAME}\r\nTrigger status: {TRIGGER.STATUS}\r\nTrigger severity: {TRIGGER.SEVERITY}\r\n\r\nItem values:\r\n\r\n{ITEM.NAME1} ({HOST.NAME1}:{ITEM.KEY1}): {ITEM.VALUE1}\r\n\r\nOriginal event ID: {EVENT.ID}',NULL),(35,1,'Cluster故障恢复: {HOST.IP}  {TRIGGER.STATUS}: {TRIGGER.NAME}','Trigger: {TRIGGER.NAME}\r\nTrigger status: {TRIGGER.STATUS}\r\nTrigger severity: {TRIGGER.SEVERITY}\r\n\r\nItem values:\r\n\r\n{ITEM.NAME1} ({HOST.NAME1}:{ITEM.KEY1}): {ITEM.VALUE1}\r\n\r\nOriginal event ID: {EVENT.ID}',NULL);
/*!40000 ALTER TABLE `opmessage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opmessage_grp`
--

DROP TABLE IF EXISTS `opmessage_grp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `opmessage_grp` (
  `opmessage_grpid` bigint(20) unsigned NOT NULL,
  `operationid` bigint(20) unsigned NOT NULL,
  `usrgrpid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`opmessage_grpid`),
  UNIQUE KEY `opmessage_grp_1` (`operationid`,`usrgrpid`),
  KEY `opmessage_grp_2` (`usrgrpid`),
  CONSTRAINT `c_opmessage_grp_1` FOREIGN KEY (`operationid`) REFERENCES `operations` (`operationid`) ON DELETE CASCADE,
  CONSTRAINT `c_opmessage_grp_2` FOREIGN KEY (`usrgrpid`) REFERENCES `usrgrp` (`usrgrpid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opmessage_grp`
--

LOCK TABLES `opmessage_grp` WRITE;
/*!40000 ALTER TABLE `opmessage_grp` DISABLE KEYS */;
INSERT INTO `opmessage_grp` VALUES (1,3,7),(2,4,7),(3,5,7),(4,6,7),(6,9,7),(7,21,7),(8,26,7);
/*!40000 ALTER TABLE `opmessage_grp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opmessage_usr`
--

DROP TABLE IF EXISTS `opmessage_usr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `opmessage_usr` (
  `opmessage_usrid` bigint(20) unsigned NOT NULL,
  `operationid` bigint(20) unsigned NOT NULL,
  `userid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`opmessage_usrid`),
  UNIQUE KEY `opmessage_usr_1` (`operationid`,`userid`),
  KEY `opmessage_usr_2` (`userid`),
  CONSTRAINT `c_opmessage_usr_1` FOREIGN KEY (`operationid`) REFERENCES `operations` (`operationid`) ON DELETE CASCADE,
  CONSTRAINT `c_opmessage_usr_2` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opmessage_usr`
--

LOCK TABLES `opmessage_usr` WRITE;
/*!40000 ALTER TABLE `opmessage_usr` DISABLE KEYS */;
INSERT INTO `opmessage_usr` VALUES (1,9,1),(2,21,1),(3,26,1);
/*!40000 ALTER TABLE `opmessage_usr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `optemplate`
--

DROP TABLE IF EXISTS `optemplate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `optemplate` (
  `optemplateid` bigint(20) unsigned NOT NULL,
  `operationid` bigint(20) unsigned NOT NULL,
  `templateid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`optemplateid`),
  UNIQUE KEY `optemplate_1` (`operationid`,`templateid`),
  KEY `optemplate_2` (`templateid`),
  CONSTRAINT `c_optemplate_1` FOREIGN KEY (`operationid`) REFERENCES `operations` (`operationid`) ON DELETE CASCADE,
  CONSTRAINT `c_optemplate_2` FOREIGN KEY (`templateid`) REFERENCES `hosts` (`hostid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `optemplate`
--

LOCK TABLES `optemplate` WRITE;
/*!40000 ALTER TABLE `optemplate` DISABLE KEYS */;
INSERT INTO `optemplate` VALUES (28,40,10155),(27,40,10163),(29,40,10178),(30,41,10156),(37,41,10158),(31,41,10160),(32,41,10161),(33,41,10162),(34,41,10163),(35,41,10164),(36,41,10178),(38,42,10178),(39,45,10154),(44,45,10163),(42,45,10167),(43,45,10178);
/*!40000 ALTER TABLE `optemplate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `problem`
--

DROP TABLE IF EXISTS `problem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `problem` (
  `eventid` bigint(20) unsigned NOT NULL,
  `source` int(11) NOT NULL DEFAULT '0',
  `object` int(11) NOT NULL DEFAULT '0',
  `objectid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `clock` int(11) NOT NULL DEFAULT '0',
  `ns` int(11) NOT NULL DEFAULT '0',
  `r_eventid` bigint(20) unsigned DEFAULT NULL,
  `r_clock` int(11) NOT NULL DEFAULT '0',
  `r_ns` int(11) NOT NULL DEFAULT '0',
  `correlationid` bigint(20) unsigned DEFAULT NULL,
  `userid` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`eventid`),
  KEY `problem_1` (`source`,`object`,`objectid`),
  KEY `problem_2` (`r_clock`),
  KEY `c_problem_2` (`r_eventid`),
  CONSTRAINT `c_problem_1` FOREIGN KEY (`eventid`) REFERENCES `events` (`eventid`) ON DELETE CASCADE,
  CONSTRAINT `c_problem_2` FOREIGN KEY (`r_eventid`) REFERENCES `events` (`eventid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `problem`
--

LOCK TABLES `problem` WRITE;
/*!40000 ALTER TABLE `problem` DISABLE KEYS */;
/*!40000 ALTER TABLE `problem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `problem_tag`
--

DROP TABLE IF EXISTS `problem_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `problem_tag` (
  `problemtagid` bigint(20) unsigned NOT NULL,
  `eventid` bigint(20) unsigned NOT NULL,
  `tag` varchar(255) NOT NULL DEFAULT '',
  `value` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`problemtagid`),
  KEY `problem_tag_1` (`eventid`),
  KEY `problem_tag_2` (`tag`,`value`),
  CONSTRAINT `c_problem_tag_1` FOREIGN KEY (`eventid`) REFERENCES `problem` (`eventid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `problem_tag`
--

LOCK TABLES `problem_tag` WRITE;
/*!40000 ALTER TABLE `problem_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `problem_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profiles`
--

DROP TABLE IF EXISTS `profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `profiles` (
  `profileid` bigint(20) unsigned NOT NULL,
  `userid` bigint(20) unsigned NOT NULL,
  `idx` varchar(96) NOT NULL DEFAULT '',
  `idx2` bigint(20) unsigned NOT NULL DEFAULT '0',
  `value_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `value_int` int(11) NOT NULL DEFAULT '0',
  `value_str` varchar(255) NOT NULL DEFAULT '',
  `source` varchar(96) NOT NULL DEFAULT '',
  `type` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`profileid`),
  KEY `profiles_1` (`userid`,`idx`,`idx2`),
  KEY `profiles_2` (`userid`,`profileid`),
  CONSTRAINT `c_profiles_1` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profiles`
--

LOCK TABLES `profiles` WRITE;
/*!40000 ALTER TABLE `profiles` DISABLE KEYS */;
INSERT INTO `profiles` VALUES (1,1,'web.menu.config.last',0,0,0,'hosts.php','',3),(2,1,'web.templates.php.groupid',0,0,0,'','',1),(3,1,'web.latest.groupid',0,0,0,'','',1),(4,1,'web.templates.php.sort',0,0,0,'name','',3),(5,1,'web.templates.php.sortorder',0,0,0,'ASC','',3),(6,1,'web.paging.lastpage',0,0,0,'hosts.php','',3),(7,1,'web.items.filter_groupid',0,0,0,'','',1),(8,1,'web.items.filter_hostid',0,10154,0,'','',1),(9,1,'web.items.filter_application',0,0,0,'','',3),(10,1,'web.items.filter_name',0,0,0,'','',3),(11,1,'web.items.filter_type',0,0,-1,'','',2),(12,1,'web.items.filter_key',0,0,0,'','',3),(13,1,'web.items.filter_snmp_community',0,0,0,'','',3),(14,1,'web.items.filter_snmpv3_securityname',0,0,0,'','',3),(15,1,'web.items.filter_snmp_oid',0,0,0,'','',3),(16,1,'web.items.filter_port',0,0,0,'','',3),(17,1,'web.items.filter_value_type',0,0,-1,'','',2),(18,1,'web.items.filter_data_type',0,0,-1,'','',2),(19,1,'web.items.filter_delay',0,0,0,'','',3),(20,1,'web.items.filter_history',0,0,0,'','',3),(21,1,'web.items.filter_trends',0,0,0,'','',3),(22,1,'web.items.filter_status',0,0,-1,'','',2),(23,1,'web.items.filter_state',0,0,-1,'','',2),(24,1,'web.items.filter_templated_items',0,0,-1,'','',2),(25,1,'web.items.filter_with_triggers',0,0,-1,'','',2),(26,1,'web.items.filter_ipmi_sensor',0,0,0,'','',3),(27,1,'web.items.subfilter_apps',0,0,0,'','',3),(28,1,'web.items.subfilter_types',0,0,0,'','',3),(29,1,'web.items.subfilter_value_types',0,0,0,'','',3),(30,1,'web.items.subfilter_status',0,0,0,'','',3),(31,1,'web.items.subfilter_state',0,0,0,'','',3),(32,1,'web.items.subfilter_templated_items',0,0,0,'','',3),(33,1,'web.items.subfilter_with_triggers',0,0,0,'','',3),(34,1,'web.items.subfilter_hosts',0,0,0,'','',3),(35,1,'web.items.subfilter_interval',0,0,0,'','',3),(36,1,'web.items.subfilter_history',0,0,0,'','',3),(37,1,'web.items.subfilter_trends',0,0,0,'','',3),(38,1,'web.items.php.sort',0,0,0,'name','',3),(39,1,'web.items.php.sortorder',0,0,0,'ASC','',3),(40,1,'web.media_type.php.sort',0,0,0,'description','',3),(41,1,'web.media_types.php.sortorder',0,0,0,'ASC','',3),(42,1,'web.actionconf.php.sort',0,0,0,'name','',3),(43,1,'web.actionconf.php.sortorder',0,0,0,'ASC','',3),(44,1,'web.reports.groupid',0,1,0,'','',1),(45,1,'web.actionconf.eventsource',0,0,2,'','',2),(46,1,'web.config.groupid',0,0,0,'','',1),(47,1,'web.hosts.php.sort',0,0,0,'name','',3),(48,1,'web.hosts.php.sortorder',0,0,0,'ASC','',3),(49,1,'web.menu.admin.last',0,0,0,'users.php','',3),(50,1,'web.users.filter.usrgrpid',0,0,0,'','',1),(51,1,'web.users.php.sort',0,0,0,'alias','',3),(52,1,'web.users.php.sortorder',0,0,0,'ASC','',3),(53,1,'web.paging.page',0,0,1,'','',2),(54,1,'web.scripts.php.sort',0,0,0,'name','',3),(55,1,'web.scripts.php.sortorder',0,0,0,'ASC','',3),(56,1,'web.problem.sort',0,0,0,'clock','',3),(57,1,'web.problem.sortorder',0,0,0,'DESC','',3),(58,1,'web.host_discovery.php.sort',0,0,0,'name','',3),(59,1,'web.host_discovery.php.sortorder',0,0,0,'ASC','',3);
/*!40000 ALTER TABLE `profiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proxy_autoreg_host`
--

DROP TABLE IF EXISTS `proxy_autoreg_host`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `proxy_autoreg_host` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `clock` int(11) NOT NULL DEFAULT '0',
  `host` varchar(64) NOT NULL DEFAULT '',
  `listen_ip` varchar(39) NOT NULL DEFAULT '',
  `listen_port` int(11) NOT NULL DEFAULT '0',
  `listen_dns` varchar(64) NOT NULL DEFAULT '',
  `host_metadata` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `proxy_autoreg_host_1` (`clock`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proxy_autoreg_host`
--

LOCK TABLES `proxy_autoreg_host` WRITE;
/*!40000 ALTER TABLE `proxy_autoreg_host` DISABLE KEYS */;
/*!40000 ALTER TABLE `proxy_autoreg_host` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proxy_dhistory`
--

DROP TABLE IF EXISTS `proxy_dhistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `proxy_dhistory` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `clock` int(11) NOT NULL DEFAULT '0',
  `druleid` bigint(20) unsigned NOT NULL,
  `type` int(11) NOT NULL DEFAULT '0',
  `ip` varchar(39) NOT NULL DEFAULT '',
  `port` int(11) NOT NULL DEFAULT '0',
  `key_` varchar(255) NOT NULL DEFAULT '',
  `value` varchar(255) NOT NULL DEFAULT '',
  `status` int(11) NOT NULL DEFAULT '0',
  `dcheckid` bigint(20) unsigned DEFAULT NULL,
  `dns` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `proxy_dhistory_1` (`clock`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proxy_dhistory`
--

LOCK TABLES `proxy_dhistory` WRITE;
/*!40000 ALTER TABLE `proxy_dhistory` DISABLE KEYS */;
/*!40000 ALTER TABLE `proxy_dhistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proxy_history`
--

DROP TABLE IF EXISTS `proxy_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `proxy_history` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `itemid` bigint(20) unsigned NOT NULL,
  `clock` int(11) NOT NULL DEFAULT '0',
  `timestamp` int(11) NOT NULL DEFAULT '0',
  `source` varchar(64) NOT NULL DEFAULT '',
  `severity` int(11) NOT NULL DEFAULT '0',
  `value` longtext NOT NULL,
  `logeventid` int(11) NOT NULL DEFAULT '0',
  `ns` int(11) NOT NULL DEFAULT '0',
  `state` int(11) NOT NULL DEFAULT '0',
  `lastlogsize` bigint(20) unsigned NOT NULL DEFAULT '0',
  `mtime` int(11) NOT NULL DEFAULT '0',
  `flags` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `proxy_history_1` (`clock`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proxy_history`
--

LOCK TABLES `proxy_history` WRITE;
/*!40000 ALTER TABLE `proxy_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `proxy_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `regexps`
--

DROP TABLE IF EXISTS `regexps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `regexps` (
  `regexpid` bigint(20) unsigned NOT NULL,
  `name` varchar(128) NOT NULL DEFAULT '',
  `test_string` text NOT NULL,
  PRIMARY KEY (`regexpid`),
  UNIQUE KEY `regexps_1` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `regexps`
--

LOCK TABLES `regexps` WRITE;
/*!40000 ALTER TABLE `regexps` DISABLE KEYS */;
INSERT INTO `regexps` VALUES (1,'File systems for discovery','ext3'),(2,'Network interfaces for discovery','eth0'),(3,'Storage devices for SNMP discovery','/boot');
/*!40000 ALTER TABLE `regexps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rights`
--

DROP TABLE IF EXISTS `rights`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rights` (
  `rightid` bigint(20) unsigned NOT NULL,
  `groupid` bigint(20) unsigned NOT NULL,
  `permission` int(11) NOT NULL DEFAULT '0',
  `id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`rightid`),
  KEY `rights_1` (`groupid`),
  KEY `rights_2` (`id`),
  CONSTRAINT `c_rights_1` FOREIGN KEY (`groupid`) REFERENCES `usrgrp` (`usrgrpid`) ON DELETE CASCADE,
  CONSTRAINT `c_rights_2` FOREIGN KEY (`id`) REFERENCES `groups` (`groupid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rights`
--

LOCK TABLES `rights` WRITE;
/*!40000 ALTER TABLE `rights` DISABLE KEYS */;
/*!40000 ALTER TABLE `rights` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `screen_user`
--

DROP TABLE IF EXISTS `screen_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `screen_user` (
  `screenuserid` bigint(20) unsigned NOT NULL,
  `screenid` bigint(20) unsigned NOT NULL,
  `userid` bigint(20) unsigned NOT NULL,
  `permission` int(11) NOT NULL DEFAULT '2',
  PRIMARY KEY (`screenuserid`),
  UNIQUE KEY `screen_user_1` (`screenid`,`userid`),
  KEY `c_screen_user_2` (`userid`),
  CONSTRAINT `c_screen_user_1` FOREIGN KEY (`screenid`) REFERENCES `screens` (`screenid`) ON DELETE CASCADE,
  CONSTRAINT `c_screen_user_2` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `screen_user`
--

LOCK TABLES `screen_user` WRITE;
/*!40000 ALTER TABLE `screen_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `screen_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `screen_usrgrp`
--

DROP TABLE IF EXISTS `screen_usrgrp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `screen_usrgrp` (
  `screenusrgrpid` bigint(20) unsigned NOT NULL,
  `screenid` bigint(20) unsigned NOT NULL,
  `usrgrpid` bigint(20) unsigned NOT NULL,
  `permission` int(11) NOT NULL DEFAULT '2',
  PRIMARY KEY (`screenusrgrpid`),
  UNIQUE KEY `screen_usrgrp_1` (`screenid`,`usrgrpid`),
  KEY `c_screen_usrgrp_2` (`usrgrpid`),
  CONSTRAINT `c_screen_usrgrp_1` FOREIGN KEY (`screenid`) REFERENCES `screens` (`screenid`) ON DELETE CASCADE,
  CONSTRAINT `c_screen_usrgrp_2` FOREIGN KEY (`usrgrpid`) REFERENCES `usrgrp` (`usrgrpid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `screen_usrgrp`
--

LOCK TABLES `screen_usrgrp` WRITE;
/*!40000 ALTER TABLE `screen_usrgrp` DISABLE KEYS */;
/*!40000 ALTER TABLE `screen_usrgrp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `screens`
--

DROP TABLE IF EXISTS `screens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `screens` (
  `screenid` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `hsize` int(11) NOT NULL DEFAULT '1',
  `vsize` int(11) NOT NULL DEFAULT '1',
  `templateid` bigint(20) unsigned DEFAULT NULL,
  `userid` bigint(20) unsigned DEFAULT NULL,
  `private` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`screenid`),
  KEY `screens_1` (`templateid`),
  KEY `c_screens_3` (`userid`),
  CONSTRAINT `c_screens_1` FOREIGN KEY (`templateid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE,
  CONSTRAINT `c_screens_3` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `screens`
--

LOCK TABLES `screens` WRITE;
/*!40000 ALTER TABLE `screens` DISABLE KEYS */;
INSERT INTO `screens` VALUES (16,'Zabbix server',2,2,NULL,1,0),(26,'MySQL performance',2,1,10168,NULL,1),(27,'Zabbix proxy health',2,2,10173,NULL,1),(28,'Zabbix server health',2,3,10174,NULL,1),(29,'System performance',2,3,10178,NULL,1),(30,'System performance',2,2,10179,NULL,1);
/*!40000 ALTER TABLE `screens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `screens_items`
--

DROP TABLE IF EXISTS `screens_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `screens_items` (
  `screenitemid` bigint(20) unsigned NOT NULL,
  `screenid` bigint(20) unsigned NOT NULL,
  `resourcetype` int(11) NOT NULL DEFAULT '0',
  `resourceid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `width` int(11) NOT NULL DEFAULT '320',
  `height` int(11) NOT NULL DEFAULT '200',
  `x` int(11) NOT NULL DEFAULT '0',
  `y` int(11) NOT NULL DEFAULT '0',
  `colspan` int(11) NOT NULL DEFAULT '1',
  `rowspan` int(11) NOT NULL DEFAULT '1',
  `elements` int(11) NOT NULL DEFAULT '25',
  `valign` int(11) NOT NULL DEFAULT '0',
  `halign` int(11) NOT NULL DEFAULT '0',
  `style` int(11) NOT NULL DEFAULT '0',
  `url` varchar(255) NOT NULL DEFAULT '',
  `dynamic` int(11) NOT NULL DEFAULT '0',
  `sort_triggers` int(11) NOT NULL DEFAULT '0',
  `application` varchar(255) NOT NULL DEFAULT '',
  `max_columns` int(11) NOT NULL DEFAULT '3',
  PRIMARY KEY (`screenitemid`),
  KEY `screens_items_1` (`screenid`),
  CONSTRAINT `c_screens_items_1` FOREIGN KEY (`screenid`) REFERENCES `screens` (`screenid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `screens_items`
--

LOCK TABLES `screens_items` WRITE;
/*!40000 ALTER TABLE `screens_items` DISABLE KEYS */;
INSERT INTO `screens_items` VALUES (44,16,2,1,500,100,0,0,2,1,0,0,0,0,'',0,0,'',3),(45,16,0,524,400,156,0,1,1,1,0,0,0,0,'',0,0,'',3),(46,16,0,525,400,100,1,1,1,1,0,0,0,0,'',0,0,'',3),(82,26,0,692,500,200,0,0,1,1,0,1,0,0,'',0,0,'',3),(83,26,0,690,500,270,1,0,1,1,0,1,0,0,'',0,0,'',3),(84,27,0,704,500,212,0,0,1,1,0,1,0,0,'',0,0,'',3),(85,27,0,701,500,100,1,0,1,1,0,1,0,0,'',0,0,'',3),(86,27,0,703,500,100,0,1,1,1,0,1,0,0,'',0,0,'',3),(87,27,0,699,500,128,1,1,1,1,0,1,0,0,'',0,0,'',3),(88,28,0,705,500,212,0,0,1,1,0,1,0,0,'',0,0,'',3),(89,28,0,700,500,100,1,0,1,1,0,1,0,0,'',0,0,'',3),(90,28,0,702,555,114,0,1,1,1,0,1,0,0,'',0,0,'',3),(91,28,0,698,500,128,1,1,1,1,0,1,0,0,'',0,0,'',3),(92,28,0,695,500,160,0,2,2,1,0,0,0,0,'',0,0,'',3),(93,29,0,683,500,120,0,0,1,1,0,1,0,0,'',0,0,'',3),(94,29,0,684,500,148,1,0,1,1,0,1,0,0,'',0,0,'',3),(95,29,0,689,500,100,0,1,1,1,0,0,0,0,'',0,0,'',3),(96,30,0,682,500,100,0,0,1,1,0,0,0,0,'',0,0,'',3),(97,30,0,688,500,100,1,0,1,1,0,0,0,0,'',0,0,'',3),(98,30,1,25227,500,100,0,1,1,1,0,0,0,0,'',0,0,'',3),(99,30,1,25224,500,100,1,1,1,1,0,0,0,0,'',0,0,'',3);
/*!40000 ALTER TABLE `screens_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scripts`
--

DROP TABLE IF EXISTS `scripts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scripts` (
  `scriptid` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `command` varchar(255) NOT NULL DEFAULT '',
  `host_access` int(11) NOT NULL DEFAULT '2',
  `usrgrpid` bigint(20) unsigned DEFAULT NULL,
  `groupid` bigint(20) unsigned DEFAULT NULL,
  `description` text NOT NULL,
  `confirmation` varchar(255) NOT NULL DEFAULT '',
  `type` int(11) NOT NULL DEFAULT '0',
  `execute_on` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`scriptid`),
  UNIQUE KEY `scripts_3` (`name`),
  KEY `scripts_1` (`usrgrpid`),
  KEY `scripts_2` (`groupid`),
  CONSTRAINT `c_scripts_1` FOREIGN KEY (`usrgrpid`) REFERENCES `usrgrp` (`usrgrpid`),
  CONSTRAINT `c_scripts_2` FOREIGN KEY (`groupid`) REFERENCES `groups` (`groupid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scripts`
--

LOCK TABLES `scripts` WRITE;
/*!40000 ALTER TABLE `scripts` DISABLE KEYS */;
INSERT INTO `scripts` VALUES (1,'Ping','/bin/ping -c 3 {HOST.CONN} 2>&1',2,NULL,NULL,'','',0,1),(2,'Traceroute','/bin/traceroute {HOST.CONN} 2>&1',2,NULL,NULL,'','',0,1),(3,'Detect operating system','sudo /usr/bin/nmap -O {HOST.CONN} 2>&1',2,7,NULL,'','',0,1);
/*!40000 ALTER TABLE `scripts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service_alarms`
--

DROP TABLE IF EXISTS `service_alarms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `service_alarms` (
  `servicealarmid` bigint(20) unsigned NOT NULL,
  `serviceid` bigint(20) unsigned NOT NULL,
  `clock` int(11) NOT NULL DEFAULT '0',
  `value` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`servicealarmid`),
  KEY `service_alarms_1` (`serviceid`,`clock`),
  KEY `service_alarms_2` (`clock`),
  CONSTRAINT `c_service_alarms_1` FOREIGN KEY (`serviceid`) REFERENCES `services` (`serviceid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service_alarms`
--

LOCK TABLES `service_alarms` WRITE;
/*!40000 ALTER TABLE `service_alarms` DISABLE KEYS */;
/*!40000 ALTER TABLE `service_alarms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `services`
--

DROP TABLE IF EXISTS `services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `services` (
  `serviceid` bigint(20) unsigned NOT NULL,
  `name` varchar(128) NOT NULL DEFAULT '',
  `status` int(11) NOT NULL DEFAULT '0',
  `algorithm` int(11) NOT NULL DEFAULT '0',
  `triggerid` bigint(20) unsigned DEFAULT NULL,
  `showsla` int(11) NOT NULL DEFAULT '0',
  `goodsla` double(16,4) NOT NULL DEFAULT '99.9000',
  `sortorder` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`serviceid`),
  KEY `services_1` (`triggerid`),
  CONSTRAINT `c_services_1` FOREIGN KEY (`triggerid`) REFERENCES `triggers` (`triggerid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `services`
--

LOCK TABLES `services` WRITE;
/*!40000 ALTER TABLE `services` DISABLE KEYS */;
/*!40000 ALTER TABLE `services` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `services_links`
--

DROP TABLE IF EXISTS `services_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `services_links` (
  `linkid` bigint(20) unsigned NOT NULL,
  `serviceupid` bigint(20) unsigned NOT NULL,
  `servicedownid` bigint(20) unsigned NOT NULL,
  `soft` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`linkid`),
  UNIQUE KEY `services_links_2` (`serviceupid`,`servicedownid`),
  KEY `services_links_1` (`servicedownid`),
  CONSTRAINT `c_services_links_1` FOREIGN KEY (`serviceupid`) REFERENCES `services` (`serviceid`) ON DELETE CASCADE,
  CONSTRAINT `c_services_links_2` FOREIGN KEY (`servicedownid`) REFERENCES `services` (`serviceid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `services_links`
--

LOCK TABLES `services_links` WRITE;
/*!40000 ALTER TABLE `services_links` DISABLE KEYS */;
/*!40000 ALTER TABLE `services_links` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `services_times`
--

DROP TABLE IF EXISTS `services_times`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `services_times` (
  `timeid` bigint(20) unsigned NOT NULL,
  `serviceid` bigint(20) unsigned NOT NULL,
  `type` int(11) NOT NULL DEFAULT '0',
  `ts_from` int(11) NOT NULL DEFAULT '0',
  `ts_to` int(11) NOT NULL DEFAULT '0',
  `note` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`timeid`),
  KEY `services_times_1` (`serviceid`,`type`,`ts_from`,`ts_to`),
  CONSTRAINT `c_services_times_1` FOREIGN KEY (`serviceid`) REFERENCES `services` (`serviceid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `services_times`
--

LOCK TABLES `services_times` WRITE;
/*!40000 ALTER TABLE `services_times` DISABLE KEYS */;
/*!40000 ALTER TABLE `services_times` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sessions` (
  `sessionid` varchar(32) NOT NULL DEFAULT '',
  `userid` bigint(20) unsigned NOT NULL,
  `lastaccess` int(11) NOT NULL DEFAULT '0',
  `status` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`sessionid`),
  KEY `sessions_1` (`userid`,`status`),
  CONSTRAINT `c_sessions_1` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
INSERT INTO `sessions` VALUES ('12f318655be71b6b6fd662e91b52b698',1,1528968744,0),('1c84cba6bfab10f050924e7376151ec6',1,1497496842,0),('231067150840172d402e9319ce292cf6',2,1528968393,0),('96edf3aca33afaba9c6533826814cf56',2,1528966764,0),('9ffb6cb7f6b4abf713ff0cd788083568',1,1528254540,0),('c84523c2a46330a42474b6e7daed3d09',2,1528968393,0),('f5332b32c1abb88c928593fd21d9ac4b',1,1528253856,0);
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `slides`
--

DROP TABLE IF EXISTS `slides`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `slides` (
  `slideid` bigint(20) unsigned NOT NULL,
  `slideshowid` bigint(20) unsigned NOT NULL,
  `screenid` bigint(20) unsigned NOT NULL,
  `step` int(11) NOT NULL DEFAULT '0',
  `delay` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`slideid`),
  KEY `slides_1` (`slideshowid`),
  KEY `slides_2` (`screenid`),
  CONSTRAINT `c_slides_1` FOREIGN KEY (`slideshowid`) REFERENCES `slideshows` (`slideshowid`) ON DELETE CASCADE,
  CONSTRAINT `c_slides_2` FOREIGN KEY (`screenid`) REFERENCES `screens` (`screenid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `slides`
--

LOCK TABLES `slides` WRITE;
/*!40000 ALTER TABLE `slides` DISABLE KEYS */;
/*!40000 ALTER TABLE `slides` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `slideshow_user`
--

DROP TABLE IF EXISTS `slideshow_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `slideshow_user` (
  `slideshowuserid` bigint(20) unsigned NOT NULL,
  `slideshowid` bigint(20) unsigned NOT NULL,
  `userid` bigint(20) unsigned NOT NULL,
  `permission` int(11) NOT NULL DEFAULT '2',
  PRIMARY KEY (`slideshowuserid`),
  UNIQUE KEY `slideshow_user_1` (`slideshowid`,`userid`),
  KEY `c_slideshow_user_2` (`userid`),
  CONSTRAINT `c_slideshow_user_1` FOREIGN KEY (`slideshowid`) REFERENCES `slideshows` (`slideshowid`) ON DELETE CASCADE,
  CONSTRAINT `c_slideshow_user_2` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `slideshow_user`
--

LOCK TABLES `slideshow_user` WRITE;
/*!40000 ALTER TABLE `slideshow_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `slideshow_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `slideshow_usrgrp`
--

DROP TABLE IF EXISTS `slideshow_usrgrp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `slideshow_usrgrp` (
  `slideshowusrgrpid` bigint(20) unsigned NOT NULL,
  `slideshowid` bigint(20) unsigned NOT NULL,
  `usrgrpid` bigint(20) unsigned NOT NULL,
  `permission` int(11) NOT NULL DEFAULT '2',
  PRIMARY KEY (`slideshowusrgrpid`),
  UNIQUE KEY `slideshow_usrgrp_1` (`slideshowid`,`usrgrpid`),
  KEY `c_slideshow_usrgrp_2` (`usrgrpid`),
  CONSTRAINT `c_slideshow_usrgrp_1` FOREIGN KEY (`slideshowid`) REFERENCES `slideshows` (`slideshowid`) ON DELETE CASCADE,
  CONSTRAINT `c_slideshow_usrgrp_2` FOREIGN KEY (`usrgrpid`) REFERENCES `usrgrp` (`usrgrpid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `slideshow_usrgrp`
--

LOCK TABLES `slideshow_usrgrp` WRITE;
/*!40000 ALTER TABLE `slideshow_usrgrp` DISABLE KEYS */;
/*!40000 ALTER TABLE `slideshow_usrgrp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `slideshows`
--

DROP TABLE IF EXISTS `slideshows`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `slideshows` (
  `slideshowid` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `delay` int(11) NOT NULL DEFAULT '0',
  `userid` bigint(20) unsigned NOT NULL,
  `private` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`slideshowid`),
  UNIQUE KEY `slideshows_1` (`name`),
  KEY `c_slideshows_3` (`userid`),
  CONSTRAINT `c_slideshows_3` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `slideshows`
--

LOCK TABLES `slideshows` WRITE;
/*!40000 ALTER TABLE `slideshows` DISABLE KEYS */;
/*!40000 ALTER TABLE `slideshows` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sysmap_element_url`
--

DROP TABLE IF EXISTS `sysmap_element_url`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sysmap_element_url` (
  `sysmapelementurlid` bigint(20) unsigned NOT NULL,
  `selementid` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`sysmapelementurlid`),
  UNIQUE KEY `sysmap_element_url_1` (`selementid`,`name`),
  CONSTRAINT `c_sysmap_element_url_1` FOREIGN KEY (`selementid`) REFERENCES `sysmaps_elements` (`selementid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sysmap_element_url`
--

LOCK TABLES `sysmap_element_url` WRITE;
/*!40000 ALTER TABLE `sysmap_element_url` DISABLE KEYS */;
/*!40000 ALTER TABLE `sysmap_element_url` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sysmap_url`
--

DROP TABLE IF EXISTS `sysmap_url`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sysmap_url` (
  `sysmapurlid` bigint(20) unsigned NOT NULL,
  `sysmapid` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL DEFAULT '',
  `elementtype` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`sysmapurlid`),
  UNIQUE KEY `sysmap_url_1` (`sysmapid`,`name`),
  CONSTRAINT `c_sysmap_url_1` FOREIGN KEY (`sysmapid`) REFERENCES `sysmaps` (`sysmapid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sysmap_url`
--

LOCK TABLES `sysmap_url` WRITE;
/*!40000 ALTER TABLE `sysmap_url` DISABLE KEYS */;
/*!40000 ALTER TABLE `sysmap_url` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sysmap_user`
--

DROP TABLE IF EXISTS `sysmap_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sysmap_user` (
  `sysmapuserid` bigint(20) unsigned NOT NULL,
  `sysmapid` bigint(20) unsigned NOT NULL,
  `userid` bigint(20) unsigned NOT NULL,
  `permission` int(11) NOT NULL DEFAULT '2',
  PRIMARY KEY (`sysmapuserid`),
  UNIQUE KEY `sysmap_user_1` (`sysmapid`,`userid`),
  KEY `c_sysmap_user_2` (`userid`),
  CONSTRAINT `c_sysmap_user_1` FOREIGN KEY (`sysmapid`) REFERENCES `sysmaps` (`sysmapid`) ON DELETE CASCADE,
  CONSTRAINT `c_sysmap_user_2` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sysmap_user`
--

LOCK TABLES `sysmap_user` WRITE;
/*!40000 ALTER TABLE `sysmap_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `sysmap_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sysmap_usrgrp`
--

DROP TABLE IF EXISTS `sysmap_usrgrp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sysmap_usrgrp` (
  `sysmapusrgrpid` bigint(20) unsigned NOT NULL,
  `sysmapid` bigint(20) unsigned NOT NULL,
  `usrgrpid` bigint(20) unsigned NOT NULL,
  `permission` int(11) NOT NULL DEFAULT '2',
  PRIMARY KEY (`sysmapusrgrpid`),
  UNIQUE KEY `sysmap_usrgrp_1` (`sysmapid`,`usrgrpid`),
  KEY `c_sysmap_usrgrp_2` (`usrgrpid`),
  CONSTRAINT `c_sysmap_usrgrp_1` FOREIGN KEY (`sysmapid`) REFERENCES `sysmaps` (`sysmapid`) ON DELETE CASCADE,
  CONSTRAINT `c_sysmap_usrgrp_2` FOREIGN KEY (`usrgrpid`) REFERENCES `usrgrp` (`usrgrpid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sysmap_usrgrp`
--

LOCK TABLES `sysmap_usrgrp` WRITE;
/*!40000 ALTER TABLE `sysmap_usrgrp` DISABLE KEYS */;
/*!40000 ALTER TABLE `sysmap_usrgrp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sysmaps`
--

DROP TABLE IF EXISTS `sysmaps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sysmaps` (
  `sysmapid` bigint(20) unsigned NOT NULL,
  `name` varchar(128) NOT NULL DEFAULT '',
  `width` int(11) NOT NULL DEFAULT '600',
  `height` int(11) NOT NULL DEFAULT '400',
  `backgroundid` bigint(20) unsigned DEFAULT NULL,
  `label_type` int(11) NOT NULL DEFAULT '2',
  `label_location` int(11) NOT NULL DEFAULT '0',
  `highlight` int(11) NOT NULL DEFAULT '1',
  `expandproblem` int(11) NOT NULL DEFAULT '1',
  `markelements` int(11) NOT NULL DEFAULT '0',
  `show_unack` int(11) NOT NULL DEFAULT '0',
  `grid_size` int(11) NOT NULL DEFAULT '50',
  `grid_show` int(11) NOT NULL DEFAULT '1',
  `grid_align` int(11) NOT NULL DEFAULT '1',
  `label_format` int(11) NOT NULL DEFAULT '0',
  `label_type_host` int(11) NOT NULL DEFAULT '2',
  `label_type_hostgroup` int(11) NOT NULL DEFAULT '2',
  `label_type_trigger` int(11) NOT NULL DEFAULT '2',
  `label_type_map` int(11) NOT NULL DEFAULT '2',
  `label_type_image` int(11) NOT NULL DEFAULT '2',
  `label_string_host` varchar(255) NOT NULL DEFAULT '',
  `label_string_hostgroup` varchar(255) NOT NULL DEFAULT '',
  `label_string_trigger` varchar(255) NOT NULL DEFAULT '',
  `label_string_map` varchar(255) NOT NULL DEFAULT '',
  `label_string_image` varchar(255) NOT NULL DEFAULT '',
  `iconmapid` bigint(20) unsigned DEFAULT NULL,
  `expand_macros` int(11) NOT NULL DEFAULT '0',
  `severity_min` int(11) NOT NULL DEFAULT '0',
  `userid` bigint(20) unsigned NOT NULL,
  `private` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`sysmapid`),
  UNIQUE KEY `sysmaps_1` (`name`),
  KEY `sysmaps_2` (`backgroundid`),
  KEY `sysmaps_3` (`iconmapid`),
  KEY `c_sysmaps_3` (`userid`),
  CONSTRAINT `c_sysmaps_1` FOREIGN KEY (`backgroundid`) REFERENCES `images` (`imageid`),
  CONSTRAINT `c_sysmaps_2` FOREIGN KEY (`iconmapid`) REFERENCES `icon_map` (`iconmapid`),
  CONSTRAINT `c_sysmaps_3` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sysmaps`
--

LOCK TABLES `sysmaps` WRITE;
/*!40000 ALTER TABLE `sysmaps` DISABLE KEYS */;
INSERT INTO `sysmaps` VALUES (1,'Local network',680,200,NULL,0,0,1,1,1,0,50,1,1,0,2,2,2,2,2,'','','','','',NULL,1,0,1,0);
/*!40000 ALTER TABLE `sysmaps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sysmaps_elements`
--

DROP TABLE IF EXISTS `sysmaps_elements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sysmaps_elements` (
  `selementid` bigint(20) unsigned NOT NULL,
  `sysmapid` bigint(20) unsigned NOT NULL,
  `elementid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `elementtype` int(11) NOT NULL DEFAULT '0',
  `iconid_off` bigint(20) unsigned DEFAULT NULL,
  `iconid_on` bigint(20) unsigned DEFAULT NULL,
  `label` varchar(2048) NOT NULL DEFAULT '',
  `label_location` int(11) NOT NULL DEFAULT '-1',
  `x` int(11) NOT NULL DEFAULT '0',
  `y` int(11) NOT NULL DEFAULT '0',
  `iconid_disabled` bigint(20) unsigned DEFAULT NULL,
  `iconid_maintenance` bigint(20) unsigned DEFAULT NULL,
  `elementsubtype` int(11) NOT NULL DEFAULT '0',
  `areatype` int(11) NOT NULL DEFAULT '0',
  `width` int(11) NOT NULL DEFAULT '200',
  `height` int(11) NOT NULL DEFAULT '200',
  `viewtype` int(11) NOT NULL DEFAULT '0',
  `use_iconmap` int(11) NOT NULL DEFAULT '1',
  `application` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`selementid`),
  KEY `sysmaps_elements_1` (`sysmapid`),
  KEY `sysmaps_elements_2` (`iconid_off`),
  KEY `sysmaps_elements_3` (`iconid_on`),
  KEY `sysmaps_elements_4` (`iconid_disabled`),
  KEY `sysmaps_elements_5` (`iconid_maintenance`),
  CONSTRAINT `c_sysmaps_elements_1` FOREIGN KEY (`sysmapid`) REFERENCES `sysmaps` (`sysmapid`) ON DELETE CASCADE,
  CONSTRAINT `c_sysmaps_elements_2` FOREIGN KEY (`iconid_off`) REFERENCES `images` (`imageid`),
  CONSTRAINT `c_sysmaps_elements_3` FOREIGN KEY (`iconid_on`) REFERENCES `images` (`imageid`),
  CONSTRAINT `c_sysmaps_elements_4` FOREIGN KEY (`iconid_disabled`) REFERENCES `images` (`imageid`),
  CONSTRAINT `c_sysmaps_elements_5` FOREIGN KEY (`iconid_maintenance`) REFERENCES `images` (`imageid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sysmaps_elements`
--

LOCK TABLES `sysmaps_elements` WRITE;
/*!40000 ALTER TABLE `sysmaps_elements` DISABLE KEYS */;
INSERT INTO `sysmaps_elements` VALUES (1,1,10084,0,185,NULL,'{HOST.NAME}\r\n{HOST.CONN}',0,111,61,NULL,NULL,0,0,200,200,0,0,'');
/*!40000 ALTER TABLE `sysmaps_elements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sysmaps_link_triggers`
--

DROP TABLE IF EXISTS `sysmaps_link_triggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sysmaps_link_triggers` (
  `linktriggerid` bigint(20) unsigned NOT NULL,
  `linkid` bigint(20) unsigned NOT NULL,
  `triggerid` bigint(20) unsigned NOT NULL,
  `drawtype` int(11) NOT NULL DEFAULT '0',
  `color` varchar(6) NOT NULL DEFAULT '000000',
  PRIMARY KEY (`linktriggerid`),
  UNIQUE KEY `sysmaps_link_triggers_1` (`linkid`,`triggerid`),
  KEY `sysmaps_link_triggers_2` (`triggerid`),
  CONSTRAINT `c_sysmaps_link_triggers_1` FOREIGN KEY (`linkid`) REFERENCES `sysmaps_links` (`linkid`) ON DELETE CASCADE,
  CONSTRAINT `c_sysmaps_link_triggers_2` FOREIGN KEY (`triggerid`) REFERENCES `triggers` (`triggerid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sysmaps_link_triggers`
--

LOCK TABLES `sysmaps_link_triggers` WRITE;
/*!40000 ALTER TABLE `sysmaps_link_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `sysmaps_link_triggers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sysmaps_links`
--

DROP TABLE IF EXISTS `sysmaps_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sysmaps_links` (
  `linkid` bigint(20) unsigned NOT NULL,
  `sysmapid` bigint(20) unsigned NOT NULL,
  `selementid1` bigint(20) unsigned NOT NULL,
  `selementid2` bigint(20) unsigned NOT NULL,
  `drawtype` int(11) NOT NULL DEFAULT '0',
  `color` varchar(6) NOT NULL DEFAULT '000000',
  `label` varchar(2048) NOT NULL DEFAULT '',
  PRIMARY KEY (`linkid`),
  KEY `sysmaps_links_1` (`sysmapid`),
  KEY `sysmaps_links_2` (`selementid1`),
  KEY `sysmaps_links_3` (`selementid2`),
  CONSTRAINT `c_sysmaps_links_1` FOREIGN KEY (`sysmapid`) REFERENCES `sysmaps` (`sysmapid`) ON DELETE CASCADE,
  CONSTRAINT `c_sysmaps_links_2` FOREIGN KEY (`selementid1`) REFERENCES `sysmaps_elements` (`selementid`) ON DELETE CASCADE,
  CONSTRAINT `c_sysmaps_links_3` FOREIGN KEY (`selementid2`) REFERENCES `sysmaps_elements` (`selementid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sysmaps_links`
--

LOCK TABLES `sysmaps_links` WRITE;
/*!40000 ALTER TABLE `sysmaps_links` DISABLE KEYS */;
/*!40000 ALTER TABLE `sysmaps_links` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task`
--

DROP TABLE IF EXISTS `task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `task` (
  `taskid` bigint(20) unsigned NOT NULL,
  `type` int(11) NOT NULL,
  PRIMARY KEY (`taskid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task`
--

LOCK TABLES `task` WRITE;
/*!40000 ALTER TABLE `task` DISABLE KEYS */;
/*!40000 ALTER TABLE `task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task_close_problem`
--

DROP TABLE IF EXISTS `task_close_problem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `task_close_problem` (
  `taskid` bigint(20) unsigned NOT NULL,
  `acknowledgeid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`taskid`),
  CONSTRAINT `c_task_close_problem_1` FOREIGN KEY (`taskid`) REFERENCES `task` (`taskid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_close_problem`
--

LOCK TABLES `task_close_problem` WRITE;
/*!40000 ALTER TABLE `task_close_problem` DISABLE KEYS */;
/*!40000 ALTER TABLE `task_close_problem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `timeperiods`
--

DROP TABLE IF EXISTS `timeperiods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `timeperiods` (
  `timeperiodid` bigint(20) unsigned NOT NULL,
  `timeperiod_type` int(11) NOT NULL DEFAULT '0',
  `every` int(11) NOT NULL DEFAULT '1',
  `month` int(11) NOT NULL DEFAULT '0',
  `dayofweek` int(11) NOT NULL DEFAULT '0',
  `day` int(11) NOT NULL DEFAULT '0',
  `start_time` int(11) NOT NULL DEFAULT '0',
  `period` int(11) NOT NULL DEFAULT '0',
  `start_date` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`timeperiodid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `timeperiods`
--

LOCK TABLES `timeperiods` WRITE;
/*!40000 ALTER TABLE `timeperiods` DISABLE KEYS */;
/*!40000 ALTER TABLE `timeperiods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trends`
--

DROP TABLE IF EXISTS `trends`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trends` (
  `itemid` bigint(20) unsigned NOT NULL,
  `clock` int(11) NOT NULL DEFAULT '0',
  `num` int(11) NOT NULL DEFAULT '0',
  `value_min` double(16,4) NOT NULL DEFAULT '0.0000',
  `value_avg` double(16,4) NOT NULL DEFAULT '0.0000',
  `value_max` double(16,4) NOT NULL DEFAULT '0.0000',
  PRIMARY KEY (`itemid`,`clock`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trends`
--

LOCK TABLES `trends` WRITE;
/*!40000 ALTER TABLE `trends` DISABLE KEYS */;
/*!40000 ALTER TABLE `trends` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trends_uint`
--

DROP TABLE IF EXISTS `trends_uint`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trends_uint` (
  `itemid` bigint(20) unsigned NOT NULL,
  `clock` int(11) NOT NULL DEFAULT '0',
  `num` int(11) NOT NULL DEFAULT '0',
  `value_min` bigint(20) unsigned NOT NULL DEFAULT '0',
  `value_avg` bigint(20) unsigned NOT NULL DEFAULT '0',
  `value_max` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`itemid`,`clock`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trends_uint`
--

LOCK TABLES `trends_uint` WRITE;
/*!40000 ALTER TABLE `trends_uint` DISABLE KEYS */;
/*!40000 ALTER TABLE `trends_uint` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trigger_depends`
--

DROP TABLE IF EXISTS `trigger_depends`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trigger_depends` (
  `triggerdepid` bigint(20) unsigned NOT NULL,
  `triggerid_down` bigint(20) unsigned NOT NULL,
  `triggerid_up` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`triggerdepid`),
  UNIQUE KEY `trigger_depends_1` (`triggerid_down`,`triggerid_up`),
  KEY `trigger_depends_2` (`triggerid_up`),
  CONSTRAINT `c_trigger_depends_1` FOREIGN KEY (`triggerid_down`) REFERENCES `triggers` (`triggerid`) ON DELETE CASCADE,
  CONSTRAINT `c_trigger_depends_2` FOREIGN KEY (`triggerid_up`) REFERENCES `triggers` (`triggerid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trigger_depends`
--

LOCK TABLES `trigger_depends` WRITE;
/*!40000 ALTER TABLE `trigger_depends` DISABLE KEYS */;
INSERT INTO `trigger_depends` VALUES (42,13964,14060),(43,13965,13964),(44,13965,14060),(45,13966,14060),(46,13967,13966),(47,13967,14060),(48,13968,14060),(49,13969,13968),(50,13969,14060),(51,13970,14060),(52,13971,13970),(53,13971,14060),(54,13972,14059),(55,13973,13972),(56,13973,14059),(57,13974,14059),(58,13975,14060),(59,13976,13974),(60,13976,14059),(61,13977,13975),(62,13977,14060),(63,13980,13978),(64,13981,13979),(65,13982,14059),(66,13983,14060),(67,13984,13982),(68,13984,14059),(69,13985,13983),(70,13985,14060),(71,13987,13986),(72,13994,14060),(73,13995,13994),(74,13995,14060),(75,14058,14112),(76,14065,14112),(77,14067,14060),(78,14068,14060),(79,14068,14067),(80,14069,14060),(81,14070,14060),(82,14070,14069);
/*!40000 ALTER TABLE `trigger_depends` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trigger_discovery`
--

DROP TABLE IF EXISTS `trigger_discovery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trigger_discovery` (
  `triggerid` bigint(20) unsigned NOT NULL,
  `parent_triggerid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`triggerid`),
  KEY `trigger_discovery_1` (`parent_triggerid`),
  CONSTRAINT `c_trigger_discovery_1` FOREIGN KEY (`triggerid`) REFERENCES `triggers` (`triggerid`) ON DELETE CASCADE,
  CONSTRAINT `c_trigger_discovery_2` FOREIGN KEY (`parent_triggerid`) REFERENCES `triggers` (`triggerid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trigger_discovery`
--

LOCK TABLES `trigger_discovery` WRITE;
/*!40000 ALTER TABLE `trigger_discovery` DISABLE KEYS */;
/*!40000 ALTER TABLE `trigger_discovery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trigger_tag`
--

DROP TABLE IF EXISTS `trigger_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trigger_tag` (
  `triggertagid` bigint(20) unsigned NOT NULL,
  `triggerid` bigint(20) unsigned NOT NULL,
  `tag` varchar(255) NOT NULL DEFAULT '',
  `value` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`triggertagid`),
  KEY `trigger_tag_1` (`triggerid`),
  CONSTRAINT `c_trigger_tag_1` FOREIGN KEY (`triggerid`) REFERENCES `triggers` (`triggerid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trigger_tag`
--

LOCK TABLES `trigger_tag` WRITE;
/*!40000 ALTER TABLE `trigger_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `trigger_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `triggers`
--

DROP TABLE IF EXISTS `triggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `triggers` (
  `triggerid` bigint(20) unsigned NOT NULL,
  `expression` varchar(2048) NOT NULL DEFAULT '',
  `description` varchar(255) NOT NULL DEFAULT '',
  `url` varchar(255) NOT NULL DEFAULT '',
  `status` int(11) NOT NULL DEFAULT '0',
  `value` int(11) NOT NULL DEFAULT '0',
  `priority` int(11) NOT NULL DEFAULT '0',
  `lastchange` int(11) NOT NULL DEFAULT '0',
  `comments` text NOT NULL,
  `error` varchar(128) NOT NULL DEFAULT '',
  `templateid` bigint(20) unsigned DEFAULT NULL,
  `type` int(11) NOT NULL DEFAULT '0',
  `state` int(11) NOT NULL DEFAULT '0',
  `flags` int(11) NOT NULL DEFAULT '0',
  `recovery_mode` int(11) NOT NULL DEFAULT '0',
  `recovery_expression` varchar(2048) NOT NULL DEFAULT '',
  `correlation_mode` int(11) NOT NULL DEFAULT '0',
  `correlation_tag` varchar(255) NOT NULL DEFAULT '',
  `manual_close` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`triggerid`),
  KEY `triggers_1` (`status`),
  KEY `triggers_2` (`value`,`lastchange`),
  KEY `triggers_3` (`templateid`),
  CONSTRAINT `c_triggers_1` FOREIGN KEY (`templateid`) REFERENCES `triggers` (`triggerid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `triggers`
--

LOCK TABLES `triggers` WRITE;
/*!40000 ALTER TABLE `triggers` DISABLE KEYS */;
INSERT INTO `triggers` VALUES (13075,'{12648}<5','Less than 5% free in the value cache','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(13436,'({TRIGGER.VALUE}=0 and {13136}>75) or ({TRIGGER.VALUE}=1 and {13136}>65)','Zabbix vmware collector processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(13467,'({TRIGGER.VALUE}=0 and {13100}>75) or ({TRIGGER.VALUE}=1 and {13100}>65)','Zabbix alerter processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(13468,'({TRIGGER.VALUE}=0 and {13102}>75) or ({TRIGGER.VALUE}=1 and {13102}>65)','Zabbix configuration syncer processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(13469,'({TRIGGER.VALUE}=0 and {13104}>75) or ({TRIGGER.VALUE}=1 and {13104}>65)','Zabbix db watchdog processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(13470,'({TRIGGER.VALUE}=0 and {13106}>75) or ({TRIGGER.VALUE}=1 and {13106}>65)','Zabbix discoverer processes more than 75% busy','',1,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(13471,'({TRIGGER.VALUE}=0 and {13108}>75) or ({TRIGGER.VALUE}=1 and {13108}>65)','Zabbix escalator processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(13472,'({TRIGGER.VALUE}=0 and {13110}>75) or ({TRIGGER.VALUE}=1 and {13110}>65)','Zabbix history syncer processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(13473,'({TRIGGER.VALUE}=0 and {13112}>75) or ({TRIGGER.VALUE}=1 and {13112}>65)','Zabbix housekeeper processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(13474,'({TRIGGER.VALUE}=0 and {13114}>75) or ({TRIGGER.VALUE}=1 and {13114}>65)','Zabbix http poller processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(13475,'({TRIGGER.VALUE}=0 and {13116}>75) or ({TRIGGER.VALUE}=1 and {13116}>65)','Zabbix icmp pinger processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(13476,'({TRIGGER.VALUE}=0 and {13118}>75) or ({TRIGGER.VALUE}=1 and {13118}>65)','Zabbix ipmi poller processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(13477,'({TRIGGER.VALUE}=0 and {13120}>75) or ({TRIGGER.VALUE}=1 and {13120}>65)','Zabbix java poller processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(13479,'({TRIGGER.VALUE}=0 and {13124}>75) or ({TRIGGER.VALUE}=1 and {13124}>65)','Zabbix poller processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(13480,'({TRIGGER.VALUE}=0 and {13126}>75) or ({TRIGGER.VALUE}=1 and {13126}>65)','Zabbix proxy poller processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(13481,'({TRIGGER.VALUE}=0 and {13030}>75) or ({TRIGGER.VALUE}=1 and {13030}>65)','Zabbix self-monitoring processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(13482,'({TRIGGER.VALUE}=0 and {13128}>75) or ({TRIGGER.VALUE}=1 and {13128}>65)','Zabbix snmp trapper processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(13483,'({TRIGGER.VALUE}=0 and {13130}>75) or ({TRIGGER.VALUE}=1 and {13130}>65)','Zabbix timer processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(13484,'({TRIGGER.VALUE}=0 and {13132}>75) or ({TRIGGER.VALUE}=1 and {13132}>65)','Zabbix trapper processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(13485,'({TRIGGER.VALUE}=0 and {13134}>75) or ({TRIGGER.VALUE}=1 and {13134}>65)','Zabbix unreachable poller processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(13486,'{12895}>100','More than 100 items having missing data for more than 10 minutes','',0,0,2,0,'zabbix[queue,10m] item is collecting data about how many items are missing data for more than 10 minutes (next parameter)','',NULL,0,0,0,0,'',0,'',0),(13487,'{12896}<25','Less than 25% free in the configuration cache','',0,0,3,0,'Consider increasing CacheSize in the zabbix_server.conf configuration file','',NULL,0,0,0,0,'',0,'',0),(13488,'{12897}<25','Less than 25% free in the history cache','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(13489,'{12898}<25','Less than 25% free in the history index cache','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(13490,'{12899}<25','Less than 25% free in the trends cache','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(13491,'{12900}=1','Zabbix agent on {HOST.NAME} is unreachable for 5 minutes','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(13492,'{12928}>0','Version of zabbix_agent(d) was changed on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0,0,'',0,'',0),(13493,'{12902}<1024','Configured max number of opened files is too low on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0,0,'',0,'',0),(13494,'{12903}<256','Configured max number of processes is too low on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0,0,'',0,'',0),(13495,'{13085}>30','Too many processes running on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0),(13496,'{13083}>300','Too many processes on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0),(13497,'{13079}>5','Processor load is too high on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0),(13498,'{13081}>20','Disk I/O is overloaded on {HOST.NAME}','',0,0,2,0,'OS spends significant time waiting for I/O (input/output) operations. It could be indicator of performance issues with storage system.','',NULL,0,0,0,0,'',0,'',0),(13499,'{12908}>0','Hostname was changed on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0,0,'',0,'',0),(13500,'{12909}<50','Lack of free swap space on {HOST.NAME}','',0,0,2,0,'It probably means that the systems requires more physical memory.','',NULL,0,0,0,0,'',0,'',0),(13501,'{12910}>0','Host information was changed on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0,0,'',0,'',0),(13502,'{12911}<0','{HOST.NAME} has just been restarted','',0,0,1,0,'','',NULL,0,0,0,0,'',0,'',0),(13503,'{12912}>0','/etc/passwd has been changed on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0),(13504,'{12913}<20M','Lack of available memory on server {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(13505,'{12914}<20','Free inodes is less than 20% on volume {#FSNAME}','',0,0,2,0,'','',NULL,0,0,2,0,'',0,'',0),(13506,'{12915}<20','Free disk space is less than 20% on volume {#FSNAME}','',0,0,2,0,'','',NULL,0,0,2,0,'',0,'',0),(13509,'{12938}>0','Host name of zabbix_agentd was changed on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0,0,'',0,'',0),(13537,'{12966}<25','Less than 25% free in the vmware cache','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(13558,'{13161}=1','Zabbix value cache working in low memory mode','',0,0,4,0,'','',NULL,0,0,0,0,'',0,'',0),(13930,'{13552}>80','%util on trigger','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0),(13931,'{13553}>100','await on trigger','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0),(13932,'{13554}>300','await on trigger（high）','',0,0,4,0,'','',NULL,0,0,0,0,'',0,'',0),(13933,'{13555}>0.6','Ceph Pool fill trigger','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0),(13934,'{13556}>0.75','Ceph Pool fill trigger(high)','',0,0,4,0,'','',NULL,0,0,0,0,'',0,'',0),(13935,'{13557}<>0','Current Pending Sector on trigger','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0),(13936,'{13558}>0.6','Disk fill on trigger','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0),(13937,'{13559}>0.8','Disk fill on trigger （high）','',0,0,4,0,'','',NULL,0,0,0,0,'',0,'',0),(13938,'{13560}<>0','Hosts reachable trigger','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0),(13939,'{13561}>0','Network dropped packets on trigger','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0),(13940,'{13562}>0','Network errors packets on trigger','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0),(13941,'{13563}<{13563}/2+1','Number of Monitors in state: outside quorum trigger(high)','',0,0,4,0,'','',NULL,0,0,0,0,'',0,'',0),(13942,'{13564}<>0','Number of OSDs in state: DOWN trigger','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0),(13943,'{13565}<{13566}','Number of OSDs in state: IN trigger','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0),(13944,'{13567}<{13568}','Number of OSDs in state: UP<Number of OSDs trigger','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0),(13945,'{13569}<{13570}','Number of Placement Groups in state: active+clean <Number of Placement Groups trigger','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0),(13946,'{13571}<>0','Number of Placement Groups in state: no service  trigger','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0),(13947,'{13572}<>0','Number of Placement Groups in state: other trigger','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0),(13948,'{13573}>0','OS Disk list trigger','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0),(13949,'{13574}=1','Overall Ceph status error','',0,0,4,0,'','',NULL,0,0,0,0,'',0,'',0),(13950,'{13575}=1','Overall Ceph status warning','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0),(13951,'{13576}<>0','Raw Read Error Rate on trigger','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0),(13952,'{13577}<>0','Reallocated Sector Ct on trigger','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0),(13953,'{13578}>0','SATA Disk list trigger','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0),(13954,'{13579}<1000','SATA lifetime trigger','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0),(13955,'{13580}<500','SATA lifetime trigger(high)','',0,0,4,0,'','',NULL,0,0,0,0,'',0,'',0),(13956,'{13581}>0','SSD Disk list trigger','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0),(13957,'{13582}>0.6','SSD lifetime trigger','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0),(13958,'{13583}>0.75','SSD lifetime trigger（high）','',0,0,4,0,'','',NULL,0,0,0,0,'',0,'',0),(13959,'{13584}>100','svctm on trigger','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0),(13960,'{13585}>300','svctm on trigger(high)','',0,0,4,0,'','',NULL,0,0,0,0,'',0,'',0),(13961,'{13586}>0.6','Total bytes fill trigger','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0),(13962,'{13587}>0.75','Total bytes fill trigger (high)','',0,0,4,0,'','',NULL,0,0,0,0,'',0,'',0),(13963,'{13588}>0','/etc/passwd has been changed on {HOST.NAME}','',0,0,3,0,'Password has been changed','',NULL,0,0,0,0,'',0,'',0),(13964,'{13589}<5 or {13589}>90','Baseboard Temp Critical [{ITEM.VALUE}]','',0,0,5,0,'','',NULL,0,0,0,0,'',0,'',0),(13965,'{13590}<10 or {13590}>83','Baseboard Temp Non-Critical [{ITEM.VALUE}]','',0,0,4,0,'','',NULL,0,0,0,0,'',0,'',0),(13966,'{13591}<0.953 or {13591}>1.149','BB +1.05V PCH Critical [{ITEM.VALUE}]','',0,0,5,0,'','',NULL,0,0,0,0,'',0,'',0),(13967,'{13592}<0.985 or {13592}>1.117','BB +1.05V PCH Non-Critical [{ITEM.VALUE}]','',0,0,4,0,'','',NULL,0,0,0,0,'',0,'',0),(13968,'{13593}<0.683 or {13593}>1.543','BB +1.1V P1 Vccp Critical [{ITEM.VALUE}]','',0,0,5,0,'','',NULL,0,0,0,0,'',0,'',0),(13969,'{13594}<0.708 or {13594}>1.501','BB +1.1V P1 Vccp Non-Critical [{ITEM.VALUE}]','',0,0,4,0,'','',NULL,0,0,0,0,'',0,'',0),(13970,'{13595}<1.362 or {13595}>1.635','BB +1.5V P1 DDR3 Critical [{ITEM.VALUE}]','',0,0,5,0,'','',NULL,0,0,0,0,'',0,'',0),(13971,'{13596}<1.401 or {13596}>1.589','BB +1.5V P1 DDR3 Non-Critical [{ITEM.VALUE}]','',0,0,4,0,'','',NULL,0,0,0,0,'',0,'',0),(13972,'{13597}<1.597 or {13597}>2.019','BB +1.8V SM Critical [{ITEM.VALUE}]','',0,0,5,0,'','',NULL,0,0,0,0,'',0,'',0),(13973,'{13598}<1.646 or {13598}>1.960','BB +1.8V SM Non-Critical [{ITEM.VALUE}]','',0,0,4,0,'','',NULL,0,0,0,0,'',0,'',0),(13974,'{13599}<2.876 or {13599}>3.729','BB +3.3V Critical [{ITEM.VALUE}]','',0,0,5,0,'','',NULL,0,0,0,0,'',0,'',0),(13975,'{13600}<2.982 or {13600}>3.625','BB +3.3V Critical [{ITEM.VALUE}]','',0,0,5,0,'','',NULL,0,0,0,0,'',0,'',0),(13976,'{13601}<2.970 or {13601}>3.618','BB +3.3V Non-Critical [{ITEM.VALUE}]','',0,0,4,0,'','',NULL,0,0,0,0,'',0,'',0),(13977,'{13602}<3.067 or {13602}>3.525','BB +3.3V Non-Critical [{ITEM.VALUE}]','',0,0,4,0,'','',NULL,0,0,0,0,'',0,'',0),(13978,'{13603}<2.876 or {13603}>3.729','BB +3.3V STBY Critical [{ITEM.VALUE}]','',0,0,5,0,'','',NULL,0,0,0,0,'',0,'',0),(13979,'{13604}<2.982 or {13604}>3.625','BB +3.3V STBY Critical [{ITEM.VALUE}]','',0,0,5,0,'','',NULL,0,0,0,0,'',0,'',0),(13980,'{13605}<2.970 or {13605}>3.618','BB +3.3V STBY Non-Critical [{ITEM.VALUE}]','',0,0,4,0,'','',NULL,0,0,0,0,'',0,'',0),(13981,'{13606}<3.067 or {13606}>3.525','BB +3.3V STBY Non-Critical [{ITEM.VALUE}]','',0,0,4,0,'','',NULL,0,0,0,0,'',0,'',0),(13982,'{13607}<4.362 or {13607}>5.663','BB +5.0V Critical [{ITEM.VALUE}]','',0,0,5,0,'','',NULL,0,0,0,0,'',0,'',0),(13983,'{13608}<4.471 or {13608}>5.538','BB +5.0V Critical [{ITEM.VALUE}]','',0,0,5,0,'','',NULL,0,0,0,0,'',0,'',0),(13984,'{13609}<4.483 or {13609}>5.495','BB +5.0V Non-Critical [{ITEM.VALUE}]','',0,0,4,0,'','',NULL,0,0,0,0,'',0,'',0),(13985,'{13610}<4.630 or {13610}>5.380','BB +5.0V Non-Critical [{ITEM.VALUE}]','',0,0,4,0,'','',NULL,0,0,0,0,'',0,'',0),(13986,'{13611}<5 or {13611}>66','BB Ambient Temp Critical [{ITEM.VALUE}]','',0,0,5,0,'','',NULL,0,0,0,0,'',0,'',0),(13987,'{13612}<10 or {13612}>61','BB Ambient Temp Non-Critical [{ITEM.VALUE}]','',0,0,4,0,'','',NULL,0,0,0,0,'',0,'',0),(13988,'{13613}=1','CEPH critical error','',0,0,3,0,'CEPH encounters a citical issue needing immediate fix.','',NULL,0,0,0,0,'',0,'',0),(13989,'{13614}=2','CEPH warning','',0,0,2,0,'CEPH is in wrong status, but still can run normally now.','',NULL,0,0,0,0,'',0,'',0),(13990,'{13615}<1024','Configured max number of opened files is too low on {HOST.NAME}','',0,0,1,0,'Configured max number of opened files is too low','',NULL,0,0,0,0,'',0,'',0),(13991,'{13616}<256','Configured max number of processes is too low on {HOST.NAME}','',0,0,1,0,'Configured max number of processes is too low','',NULL,0,0,0,0,'',0,'',0),(13992,'{13617}>20','CPU interrupt time {HOST.NAME}','',0,0,2,0,'CPU interrupt time','',NULL,0,0,0,0,'',0,'',0),(13993,'{13618}>35','Disk I/O is overloaded on {HOST.NAME}','',0,0,2,0,'OS spends significant time waiting for I/O (input/output) operations. It could be indicator of performance issues with storage system.','',NULL,0,0,0,0,'',0,'',0),(13994,'{13619}<0 or {13619}>48','Front Panel Temp Critical [{ITEM.VALUE}]','',0,0,5,0,'','',NULL,0,0,0,0,'',0,'',0),(13995,'{13620}<5 or {13620}>44','Front Panel Temp Non-Critical [{ITEM.VALUE}]','',0,0,4,0,'','',NULL,0,0,0,0,'',0,'',0),(13996,'{13621}>0','Host information was changed on {HOST.NAME}','',0,0,1,0,'Host information was changed','',NULL,0,0,0,0,'',0,'',0),(13997,'{13622}>0','Host information was changed on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(13998,'{13623}<1000M','Lack of available memory on server {HOST.NAME}','',0,0,3,0,'Lack of available memory','',NULL,0,0,0,0,'',0,'',0),(13999,'{13624}<10000','Lack of free memory on server {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(14000,'{13625}<100000','Lack of free swap space on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(14001,'{13626}<5','Less than 5% free in the value cache','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(14002,'{13627}<25','Less than 25% free in the configuration cache','',0,0,3,0,'Consider increasing CacheSize in the zabbix_server.conf configuration file','',NULL,0,0,0,0,'',0,'',0),(14003,'{13628}<25','Less than 25% free in the configuration cache','',0,0,3,0,'Consider increasing CacheSize in the zabbix_server.conf configuration file','',NULL,0,0,0,0,'',0,'',0),(14004,'{13629}<25','Less than 25% free in the history cache','',0,0,3,0,'Less than 25% free in the history cache','',NULL,0,0,0,0,'',0,'',0),(14005,'{13630}<25','Less than 25% free in the history cache','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(14006,'{13631}<25','Less than 25% free in the history index cache','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(14007,'{13632}<25','Less than 25% free in the text history cache','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(14008,'{13633}<25','Less than 25% free in the trends cache','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(14009,'{13634}<25','Less than 25% free in the vmware cache','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(14010,'{13635}>100','More than 100 items having missing data for more than 10 minutes','',0,0,2,0,'zabbix[queue,10m] item is collecting data about how many items are missing data for more than 10 minutes (next parameter)','',NULL,0,0,0,0,'',0,'',0),(14011,'{13636}>100','More than 100 items having missing data for more than 10 minutes','',0,0,2,0,'zabbix[queue,10m] item is collecting data about how many items are missing data for more than 10 minutes (next parameter)','',NULL,0,0,0,0,'',0,'',0),(14012,'{13637}=0','MySQL is down','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0),(14013,'{13638}=0','nova-novncproxy has  down','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(14014,'{13639}=0','openstack ceilometer-agent-notification has down','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(14015,'{13640}=0','openstack ceilometer-collector has down','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(14016,'{13641}<>1','openstack ceilometer-polling has down','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(14017,'{13642}=0','openstack ceilometer-polling has down','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(14018,'{13643}=0','openstack cinder-api has down','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(14019,'{13644}=0','openstack cinder-scheduler has down','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(14020,'{13645}<>1','openstack cinder-volume has down','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(14021,'{13646}>1','Openstack cinder process status','',0,0,3,0,'The service of cinder which is down','',NULL,0,0,0,0,'',0,'',0),(14022,'{13647}=0','Openstack compute service cinder volume','',0,0,3,0,'Openstack compute service cinder volume error','',NULL,0,0,0,0,'',0,'',0),(14023,'{13648}=0','Openstack compute service libvirtd','',0,0,3,0,'Openstack compute service libvirtd error','',NULL,0,0,0,0,'',0,'',0),(14024,'{13649}=0','Openstack compute service neutron l3 agent','',0,0,3,0,'Openstack compute service neutron l3 agent','',NULL,0,0,0,0,'',0,'',0),(14025,'{13650}=0','Openstack compute service neutron metadata agent','',0,0,3,0,'Openstack compute service neutron metadata agent error','',NULL,0,0,0,0,'',0,'',0),(14026,'{13651}=0','Openstack compute service neutron openvswitch agent','',0,0,3,0,'Openstack compute service neutron openvswitch agent error','',NULL,0,0,0,0,'',0,'',0),(14027,'{13652}=0','Openstack compute service nova compute','',0,0,3,0,'Openstack compute service nova compute status','',NULL,0,0,0,0,'',0,'',0),(14028,'{13653}=0','openstack glance-api has down','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(14029,'{13654}=0','openstack glance-registry has down','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(14030,'{13655}=0','openstack httpd has down','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(14031,'{13656}=0','openstack httpd has down','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(14032,'{13657}<>1','openstack libvirtd has down','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(14033,'{13658}=0','openstack memcached has down','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(14034,'{13659}=0','openstack mysqld has down','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(14035,'{13660}<>1','openstack neutron-dhcp-agent has down','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(14036,'{13661}=0','openstack neutron-l3-agent has down','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(14037,'{13662}=0','openstack neutron-l3-agent has down','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(14038,'{13663}=0','openstack neutron-lbaasv2-agent has down','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(14039,'{13664}=0','openstack  neutron-metadata-agent has down','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(14040,'{13665}=0','openstack neutron-openvswitch-agent has down','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(14041,'{13666}=0','openstack neutron-openvswitch-agent has down','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(14042,'{13667}=0','openstack neutron-server has down','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(14043,'{13668}>1','Openstack neutron process status','',0,0,3,0,'The service of neutron which is down','',NULL,0,0,0,0,'',0,'',0),(14044,'{13669}=0','openstack nova-api has down','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(14045,'{13670}=0','openstack nova-cert has down','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(14046,'{13671}=0','openstack nova-compute has down','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(14047,'{13672}=0','openstack nova-conductor has down','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(14048,'{13673}=0','openstack nova-consoleauth has down','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(14049,'{13674}=0','openstack nova-novncproxy has down','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(14050,'{13675}=0','openstack nova-scheduler has down','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(14051,'{13676}<>1','Openstack nova process status','',0,0,3,0,'The service of nova which is down','',NULL,0,0,0,0,'',0,'',0),(14052,'{13677}=0','openstack ntpd has down','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(14053,'{13678}=0','openstack openvswitch has down','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(14054,'{13679}=0','openstack rabbitmq-server has down','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(14055,'{13680}=0','Openstack service haproxy has down','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(14056,'{13681}=0','Openstack service keepalived has down','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(14057,'{13682}=0','openstack xinetd has down','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(14058,'{13683}>20','Ping loss is too high on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0),(14059,'{13684}=0','Power','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0),(14060,'{13685}=0','Power','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0),(14061,'{13686}>5','Processor load is too high on(5min)  {HOST.NAME}','',0,0,2,0,'Processor load is too high (5min)','',NULL,0,0,0,0,'',0,'',0),(14062,'{13687}>5','Processor load is too high on (15min){HOST.NAME}','',0,0,2,0,'Processor load is too high(15min)','',NULL,0,0,0,0,'',0,'',0),(14063,'{13688}>5','Processor load is too high on {HOST.NAME}','',0,0,2,0,'Processor load is too high （1min）','',NULL,0,0,0,0,'',0,'',0),(14064,'{13689}>5','Processor load is too high on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(14065,'{13690}>0.15','Response time is too high on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0,0,'',0,'',0),(14066,'{13691}=0','SSH service is down on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(14067,'{13692}<324','System Fan 2 Critical [{ITEM.VALUE}]','',0,0,5,0,'','',NULL,0,0,0,0,'',0,'',0),(14068,'{13693}<378','System Fan 2 Non-Critical [{ITEM.VALUE}]','',0,0,4,0,'','',NULL,0,0,0,0,'',0,'',0),(14069,'{13694}<324','System Fan 3 Critical [{ITEM.VALUE}]','',0,0,5,0,'','',NULL,0,0,0,0,'',0,'',0),(14070,'{13695}<378','System Fan 3 Non-Critical [{ITEM.VALUE}]','',0,0,4,0,'','',NULL,0,0,0,0,'',0,'',0),(14071,'{13696}>300','Too many processes on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(14072,'{13697}=1','Zabbix agent on {HOST.NAME} is unreachable for 5 minutes','',0,0,3,0,'Zabbix agent is unreachable for 5 minutes','',NULL,0,0,0,0,'',0,'',0),(14073,'{13698}=1','Zabbix agent on {HOST.NAME} is unreachable for 5 minutes','',0,0,3,0,'Zabbix agent is unreachable for 5 minutes','',NULL,0,0,0,0,'',0,'',0),(14074,'{13699}=1','Zabbix agent on {HOST.NAME} is unreachable for 5 minutes','',0,0,3,0,'Zabbix agent is unreachable for 5 minutes','',NULL,0,0,0,0,'',0,'',0),(14075,'({TRIGGER.VALUE}=0 and {13700}>75) or ({TRIGGER.VALUE}=1 and {13700}>65)','Zabbix alerter processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(14076,'({TRIGGER.VALUE}=0 and {13701}>75) or ({TRIGGER.VALUE}=1 and {13701}>65)','Zabbix configuration syncer processes more than 75% busy','',0,0,3,0,'Zabbix configuration syncer processes more than 75% busy','',NULL,0,0,0,0,'',0,'',0),(14077,'({TRIGGER.VALUE}=0 and {13702}>75) or ({TRIGGER.VALUE}=1 and {13702}>65)','Zabbix configuration syncer processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(14078,'({TRIGGER.VALUE}=0 and {13703}>75) or ({TRIGGER.VALUE}=1 and {13703}>65)','Zabbix data sender processes more than 75% busy','',0,0,3,0,'Zabbix data sender processes more than 75% busy','',NULL,0,0,0,0,'',0,'',0),(14079,'({TRIGGER.VALUE}=0 and {13704}>75) or ({TRIGGER.VALUE}=1 and {13704}>65)','Zabbix db watchdog processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(14080,'({TRIGGER.VALUE}=0 and {13705}>75) or ({TRIGGER.VALUE}=1 and {13705}>65)','Zabbix discoverer processes more than 75% busy','',0,0,3,0,'Zabbix discoverer processes more than 75% busy','',NULL,0,0,0,0,'',0,'',0),(14081,'({TRIGGER.VALUE}=0 and {13706}>75) or ({TRIGGER.VALUE}=1 and {13706}>65)','Zabbix discoverer processes more than 75% busy','',1,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(14082,'({TRIGGER.VALUE}=0 and {13707}>75) or ({TRIGGER.VALUE}=1 and {13707}>65)','Zabbix escalator processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(14083,'({TRIGGER.VALUE}=0 and {13708}>75) or ({TRIGGER.VALUE}=1 and {13708}>65)','Zabbix heartbeat sender processes more than 75% busy','',0,0,3,0,'Zabbix heartbeat sender processes more than 75% busy','',NULL,0,0,0,0,'',0,'',0),(14084,'({TRIGGER.VALUE}=0 and {13709}>75) or ({TRIGGER.VALUE}=1 and {13709}>65)','Zabbix history syncer processes more than 75% busy','',0,0,3,0,'Zabbix history syncer processes more than 75% busy','',NULL,0,0,0,0,'',0,'',0),(14085,'({TRIGGER.VALUE}=0 and {13710}>75) or ({TRIGGER.VALUE}=1 and {13710}>65)','Zabbix history syncer processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(14086,'({TRIGGER.VALUE}=0 and {13711}>75) or ({TRIGGER.VALUE}=1 and {13711}>65)','Zabbix housekeeper processes more than 75% busy','',0,0,3,0,'Zabbix housekeeper processes more than 75% busy','',NULL,0,0,0,0,'',0,'',0),(14087,'({TRIGGER.VALUE}=0 and {13712}>75) or ({TRIGGER.VALUE}=1 and {13712}>65)','Zabbix housekeeper processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(14088,'({TRIGGER.VALUE}=0 and {13713}>75) or ({TRIGGER.VALUE}=1 and {13713}>65)','Zabbix http poller processes more than 75% busy','',0,0,3,0,'Zabbix http poller processes more than 75% busy','',NULL,0,0,0,0,'',0,'',0),(14089,'({TRIGGER.VALUE}=0 and {13714}>75) or ({TRIGGER.VALUE}=1 and {13714}>65)','Zabbix http poller processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(14090,'({TRIGGER.VALUE}=0 and {13715}>75) or ({TRIGGER.VALUE}=1 and {13715}>65)','Zabbix icmp pinger processes more than 75% busy','',0,0,3,0,'Zabbix icmp pinger processes more than 75% busy','',NULL,0,0,0,0,'',0,'',0),(14091,'({TRIGGER.VALUE}=0 and {13716}>75) or ({TRIGGER.VALUE}=1 and {13716}>65)','Zabbix icmp pinger processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(14092,'({TRIGGER.VALUE}=0 and {13717}>75) or ({TRIGGER.VALUE}=1 and {13717}>65)','Zabbix ipmi poller processes more than 75% busy','',0,0,3,0,'Zabbix ipmi poller processes more than 75% busy','',NULL,0,0,0,0,'',0,'',0),(14093,'({TRIGGER.VALUE}=0 and {13718}>75) or ({TRIGGER.VALUE}=1 and {13718}>65)','Zabbix ipmi poller processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(14094,'({TRIGGER.VALUE}=0 and {13719}>75) or ({TRIGGER.VALUE}=1 and {13719}>65)','Zabbix java poller processes more than 75% busy','',0,0,3,0,'Zabbix java poller processes more than 75% busy','',NULL,0,0,0,0,'',0,'',0),(14095,'({TRIGGER.VALUE}=0 and {13720}>75) or ({TRIGGER.VALUE}=1 and {13720}>65)','Zabbix java poller processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(14096,'({TRIGGER.VALUE}=0 and {13721}>75) or ({TRIGGER.VALUE}=1 and {13721}>65)','Zabbix poller processes more than 75% busy','',0,0,3,0,'Zabbix poller processes more than 75% busy','',NULL,0,0,0,0,'',0,'',0),(14097,'({TRIGGER.VALUE}=0 and {13722}>75) or ({TRIGGER.VALUE}=1 and {13722}>65)','Zabbix poller processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(14098,'({TRIGGER.VALUE}=0 and {13723}>75) or ({TRIGGER.VALUE}=1 and {13723}>65)','Zabbix proxy poller processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(14099,'({TRIGGER.VALUE}=0 and {13724}>75) or ({TRIGGER.VALUE}=1 and {13724}>65)','Zabbix self-monitoring processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(14100,'({TRIGGER.VALUE}=0 and {13725}>75) or ({TRIGGER.VALUE}=1 and {13725}>65)','Zabbix self-monitoring processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(14101,'({TRIGGER.VALUE}=0 and {13726}>75) or ({TRIGGER.VALUE}=1 and {13726}>65)','Zabbix snmp trapper processes more than 75% busy','',0,0,3,0,'Zabbix snmp trapper processes more than 75% busy','',NULL,0,0,0,0,'',0,'',0),(14102,'({TRIGGER.VALUE}=0 and {13727}>75) or ({TRIGGER.VALUE}=1 and {13727}>65)','Zabbix snmp trapper processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(14103,'({TRIGGER.VALUE}=0 and {13728}>75) or ({TRIGGER.VALUE}=1 and {13728}>65)','Zabbix timer processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(14104,'({TRIGGER.VALUE}=0 and {13729}>75) or ({TRIGGER.VALUE}=1 and {13729}>65)','Zabbix trapper processes more than 75% busy','',0,0,3,0,'Zabbix trapper processes more than 75% busy','',NULL,0,0,0,0,'',0,'',0),(14105,'({TRIGGER.VALUE}=0 and {13730}>75) or ({TRIGGER.VALUE}=1 and {13730}>65)','Zabbix trapper processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(14106,'({TRIGGER.VALUE}=0 and {13731}>75) or ({TRIGGER.VALUE}=1 and {13731}>65)','Zabbix unreachable poller processes more than 75% busy','',0,0,3,0,'Zabbix unreachable poller processes more than 75% busy','',NULL,0,0,0,0,'',0,'',0),(14107,'({TRIGGER.VALUE}=0 and {13732}>75) or ({TRIGGER.VALUE}=1 and {13732}>65)','Zabbix unreachable poller processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(14108,'{13733}=1','Zabbix value cache working in low memory mode','',0,0,4,0,'','',NULL,0,0,0,0,'',0,'',0),(14109,'({TRIGGER.VALUE}=0 and {13734}>75) or ({TRIGGER.VALUE}=1 and {13734}>65)','Zabbix vmware collector processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(14110,'{13735}<0','{HOST.NAME} has just been restarted','',0,0,3,0,'Server just been restarted','',NULL,0,0,0,0,'',0,'',0),(14111,'{13736}<0','{HOST.NAME} has just been restarted','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(14112,'{13737}=0','{HOST.NAME} is unavailable by ICMP','',0,0,3,0,'','',NULL,0,0,0,0,'',0,'',0),(14113,'{13738}<20','Free disk space is less than 20% on volume {#FSNAME}','',0,0,2,0,'Free disk space is less than 20% on volume {#FSNAME}','',NULL,0,0,2,0,'',0,'',0),(14114,'{13739}<20','Free inodes is less than 20% on volume {#FSNAME}','',0,0,2,0,'Free inodes is less than 20% on volume {#FSNAME}','',NULL,0,0,2,0,'',0,'',0),(14115,'{13740}<20','Free disk space is less than 20% on volume {#FSNAME}','',0,0,2,0,'','',NULL,0,0,2,0,'',0,'',0),(14116,'{13741} / {13742} > 0.8','Free disk space is less than 20% on volume {#SNMPVALUE}','',0,0,2,0,'','',NULL,0,0,2,0,'',0,'',0),(14117,'{13743}=1','Operational status was changed on {HOST.NAME} interface {#SNMPVALUE}','',0,0,1,0,'','',NULL,0,0,2,0,'',0,'',0),(14118,'{13744} / {13745} > 0.8','Free disk space is less than 20% on volume {#SNMPVALUE}','',0,0,2,0,'','',14116,0,0,2,0,'',0,'',0),(14119,'{13746} / {13747} > 0.8','Free disk space is less than 20% on volume {#SNMPVALUE}','',0,0,2,0,'','',14116,0,0,2,0,'',0,'',0),(14120,'{13748}=1','Operational status was changed on {HOST.NAME} interface {#SNMPVALUE}','',0,0,1,0,'','',14117,0,0,2,0,'',0,'',0),(14121,'{13749}=1','Operational status was changed on {HOST.NAME} interface {#SNMPVALUE}','',0,0,1,0,'','',14117,0,0,2,0,'',0,'',0),(14122,'{13750}=1','Operational status was changed on {HOST.NAME} interface {#SNMPVALUE}','',0,0,1,0,'','',14117,0,0,2,0,'',0,'',0);
/*!40000 ALTER TABLE `triggers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `userid` bigint(20) unsigned NOT NULL,
  `alias` varchar(100) NOT NULL DEFAULT '',
  `name` varchar(100) NOT NULL DEFAULT '',
  `surname` varchar(100) NOT NULL DEFAULT '',
  `passwd` char(32) NOT NULL DEFAULT '',
  `url` varchar(255) NOT NULL DEFAULT '',
  `autologin` int(11) NOT NULL DEFAULT '0',
  `autologout` int(11) NOT NULL DEFAULT '900',
  `lang` varchar(5) NOT NULL DEFAULT 'en_GB',
  `refresh` int(11) NOT NULL DEFAULT '30',
  `type` int(11) NOT NULL DEFAULT '1',
  `theme` varchar(128) NOT NULL DEFAULT 'default',
  `attempt_failed` int(11) NOT NULL DEFAULT '0',
  `attempt_ip` varchar(39) NOT NULL DEFAULT '',
  `attempt_clock` int(11) NOT NULL DEFAULT '0',
  `rows_per_page` int(11) NOT NULL DEFAULT '50',
  PRIMARY KEY (`userid`),
  UNIQUE KEY `users_1` (`alias`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Admin','Zabbix','Administrator','5fce1b3e34b520afeffb37ce08c7cd66','',1,0,'en_GB',30,3,'default',0,'',0,50),(2,'guest','','','d41d8cd98f00b204e9800998ecf8427e','',0,900,'en_GB',30,1,'default',0,'',0,50);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_groups`
--

DROP TABLE IF EXISTS `users_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_groups` (
  `id` bigint(20) unsigned NOT NULL,
  `usrgrpid` bigint(20) unsigned NOT NULL,
  `userid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_groups_1` (`usrgrpid`,`userid`),
  KEY `users_groups_2` (`userid`),
  CONSTRAINT `c_users_groups_1` FOREIGN KEY (`usrgrpid`) REFERENCES `usrgrp` (`usrgrpid`) ON DELETE CASCADE,
  CONSTRAINT `c_users_groups_2` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_groups`
--

LOCK TABLES `users_groups` WRITE;
/*!40000 ALTER TABLE `users_groups` DISABLE KEYS */;
INSERT INTO `users_groups` VALUES (4,7,1),(2,8,2);
/*!40000 ALTER TABLE `users_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usrgrp`
--

DROP TABLE IF EXISTS `usrgrp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usrgrp` (
  `usrgrpid` bigint(20) unsigned NOT NULL,
  `name` varchar(64) NOT NULL DEFAULT '',
  `gui_access` int(11) NOT NULL DEFAULT '0',
  `users_status` int(11) NOT NULL DEFAULT '0',
  `debug_mode` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`usrgrpid`),
  UNIQUE KEY `usrgrp_1` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usrgrp`
--

LOCK TABLES `usrgrp` WRITE;
/*!40000 ALTER TABLE `usrgrp` DISABLE KEYS */;
INSERT INTO `usrgrp` VALUES (7,'Zabbix administrators',0,0,0),(8,'Guests',0,0,0),(9,'Disabled',0,1,0),(11,'Enabled debug mode',0,0,1),(12,'No access to the frontend',2,0,0);
/*!40000 ALTER TABLE `usrgrp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `valuemaps`
--

DROP TABLE IF EXISTS `valuemaps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `valuemaps` (
  `valuemapid` bigint(20) unsigned NOT NULL,
  `name` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`valuemapid`),
  UNIQUE KEY `valuemaps_1` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `valuemaps`
--

LOCK TABLES `valuemaps` WRITE;
/*!40000 ALTER TABLE `valuemaps` DISABLE KEYS */;
INSERT INTO `valuemaps` VALUES (4,'APC Battery Replacement Status'),(5,'APC Battery Status'),(7,'Dell Open Manage System Status'),(2,'Host availability'),(6,'HP Insight System Status'),(17,'HTTP response status code'),(14,'Maintenance status'),(1,'Service state'),(9,'SNMP device status (hrDeviceStatus)'),(11,'SNMP interface status (ifAdminStatus)'),(8,'SNMP interface status (ifOperStatus)'),(15,'Value cache operating mode'),(13,'VMware status'),(12,'VMware VirtualMachinePowerState'),(16,'Windows service startup type'),(3,'Windows service state'),(10,'Zabbix agent ping status');
/*!40000 ALTER TABLE `valuemaps` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-06-14 17:32:30