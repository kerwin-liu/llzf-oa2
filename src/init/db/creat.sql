/*
SQLyog  v12.2.6 (64 bit)
MySQL - 5.6.21-log : Database - llzf-pro
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`llzf-pro` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `llzf-pro`;

/*Table structure for table `t_admin` */

DROP TABLE IF EXISTS `t_admin`;

CREATE TABLE `t_admin` (
  `admin_id` int(11) NOT NULL COMMENT 'id',
  `NAME` varchar(20) DEFAULT NULL COMMENT '登录名',
  `PASSWORD` varchar(6) DEFAULT NULL COMMENT '登录密码',
  `TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '预留字段1',
  `admin_rese2` char(10) DEFAULT NULL COMMENT '预留字段2',
  PRIMARY KEY (`admin_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='管理员';

/*Table structure for table `t_admin_member` */

DROP TABLE IF EXISTS `t_admin_member`;

CREATE TABLE `t_admin_member` (
  `admin_id` int(11) DEFAULT NULL COMMENT 'id',
  `member_id` int(11) DEFAULT NULL COMMENT '编号',
  `member_password` int(11) DEFAULT NULL COMMENT '员工密码',
  KEY `FK_Reference_1` (`admin_id`),
  CONSTRAINT `FK_Reference_1` FOREIGN KEY (`admin_id`) REFERENCES `t_admin` (`admin_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `t_client` */

DROP TABLE IF EXISTS `t_client`;

CREATE TABLE `t_client` (
  `client_id` int(11) NOT NULL COMMENT 'id',
  `NAME` varchar(30) DEFAULT NULL COMMENT '姓名',
  `card` varchar(20) DEFAULT NULL COMMENT '身份证',
  `TYPE` int(11) DEFAULT NULL COMMENT '类型',
  `sex` varchar(10) DEFAULT NULL COMMENT '性别',
  `phone` varchar(11) DEFAULT NULL COMMENT '电话',
  `qq` varchar(15) DEFAULT NULL COMMENT 'qq',
  `qqqnc` varchar(20) DEFAULT NULL COMMENT 'qq昵称',
  `weixin` varchar(30) DEFAULT NULL COMMENT '微信',
  `funds` varchar(100) DEFAULT NULL COMMENT '资金',
  `address` varchar(50) DEFAULT NULL COMMENT '地址',
  `remark` varchar(500) DEFAULT NULL COMMENT '描述',
  `TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `member_id` int(11) DEFAULT NULL COMMENT '员工id',
  `ip` varchar(40) DEFAULT NULL COMMENT '追踪ip',
  PRIMARY KEY (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='客户表';

/*Table structure for table `t_client_log` */

DROP TABLE IF EXISTS `t_client_log`;

CREATE TABLE `t_client_log` (
  `client_id` int(11) DEFAULT NULL,
  `client_log` varchar(500) DEFAULT NULL,
  `TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY `FK_Reference_6` (`client_id`),
  CONSTRAINT `FK_Reference_6` FOREIGN KEY (`client_id`) REFERENCES `t_client` (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `t_department` */

DROP TABLE IF EXISTS `t_department`;

CREATE TABLE `t_department` (
  `member_id` int(11) DEFAULT NULL COMMENT '编号',
  `admin_id` int(11) DEFAULT NULL COMMENT 'id',
  `deparentment_id` int(11) DEFAULT NULL COMMENT '部门id',
  KEY `FK_Reference_7` (`admin_id`),
  CONSTRAINT `FK_Reference_7` FOREIGN KEY (`admin_id`) REFERENCES `t_admin` (`admin_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `t_member` */

DROP TABLE IF EXISTS `t_member`;

CREATE TABLE `t_member` (
  `member_id` int(11) NOT NULL COMMENT '编号',
  `number` int(11) DEFAULT NULL COMMENT '工号',
  `NAME` varchar(30) DEFAULT NULL COMMENT '姓名',
  `sex` varchar(10) DEFAULT NULL COMMENT '性别',
  `phone` varchar(11) DEFAULT NULL COMMENT '手机',
  `card` varchar(20) DEFAULT NULL COMMENT '身份证',
  `qq` varchar(15) DEFAULT NULL COMMENT 'qq',
  `wexin` varchar(30) DEFAULT NULL COMMENT '微信账号',
  `groups` varchar(30) DEFAULT NULL COMMENT '管理分组',
  `permissions` int(11) DEFAULT NULL COMMENT '权限',
  `qqnc` varchar(20) DEFAULT NULL COMMENT 'qq昵称',
  `address` varchar(50) DEFAULT NULL COMMENT '住址',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `OPEN` tinyint(1) DEFAULT NULL COMMENT '是否开通账号',
  PRIMARY KEY (`member_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='员工表：编号，工号，姓名，性别，手机，身份证，QQ，微信账号，管理分组';

/*Table structure for table `t_member_client` */

DROP TABLE IF EXISTS `t_member_client`;

CREATE TABLE `t_member_client` (
  `member_id` int(11) DEFAULT NULL,
  `client_id` int(11) DEFAULT NULL,
  KEY `FK_Reference_4` (`member_id`),
  CONSTRAINT `FK_Reference_4` FOREIGN KEY (`member_id`) REFERENCES `t_member` (`member_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `id` int(10) NOT NULL COMMENT '主键',
  `userName` varchar(50) DEFAULT NULL COMMENT '用户名',
  `password` varchar(50) DEFAULT NULL COMMENT '密码',
  `salt` varchar(10) DEFAULT NULL COMMENT '盐值',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
