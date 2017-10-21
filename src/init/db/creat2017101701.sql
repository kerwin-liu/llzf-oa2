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

/*Table structure for table `department` */

DROP TABLE IF EXISTS `department`;

CREATE TABLE `department` (
  `id` bigint(20) NOT NULL COMMENT '部门id',
  `name` varchar(50) DEFAULT NULL COMMENT '部门名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `department` */

insert  into `department`(`id`,`name`) values 

(1,'部门一'),

(2,'部门二');

/*Table structure for table `member` */

DROP TABLE IF EXISTS `member`;

CREATE TABLE `member` (
  `member_id` bigint(20) NOT NULL COMMENT '编号',
  `number` int(11) DEFAULT NULL COMMENT '工号',
  `NAME` varchar(30) DEFAULT NULL COMMENT '姓名',
  `sex` varchar(10) DEFAULT NULL COMMENT '性别 0:男 1:女',
  `phone` varchar(11) DEFAULT NULL COMMENT '手机',
  `card` varchar(20) DEFAULT NULL COMMENT '身份证',
  `qq` varchar(15) DEFAULT NULL COMMENT 'qq',
  `wexin` varchar(30) DEFAULT NULL COMMENT '微信账号',
  `groups` bigint(20) DEFAULT NULL COMMENT '管理分组',
  `permissions` bigint(20) DEFAULT NULL,
  `qqnc` varchar(20) DEFAULT NULL COMMENT 'qq昵称',
  `address` varchar(50) DEFAULT NULL COMMENT '住址',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `OPEN` varchar(1) DEFAULT NULL COMMENT '是否开通账号 0：停用 1：启用',
  `creat_user_id` bigint(20) DEFAULT NULL COMMENT '增加此员工的用户id',
  PRIMARY KEY (`member_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='员工表：编号，工号，姓名，性别，手机，身份证，QQ，微信账号，管理分组';

/*Data for the table `member` */

insert  into `member`(`member_id`,`number`,`NAME`,`sex`,`phone`,`card`,`qq`,`wexin`,`groups`,`permissions`,`qqnc`,`address`,`remark`,`TIME`,`OPEN`,`creat_user_id`) values 

(1,1,'admin','0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-10-15 21:48:21','2',NULL),

(15082170235410000,1,'张三','0','12345678901','11111111111111111','123456789','weixin',2,2,'qq昵称','地址',NULL,'2017-10-17 13:10:23',NULL,1),

(15082170759150001,1,'李四','0','12345678901','11111111111111111','123456789','weixin',1,2,'qq昵称','地址',NULL,'2017-10-17 13:11:15',NULL,1),

(15082170897370002,1,'李四1','0','12345678901','11111111111111111','123456789','weixin',1,3,'qq昵称','地址',NULL,'2017-10-17 13:11:29',NULL,1),

(15082170950960003,1,'李四2','0','12345678901','11111111111111111','123456789','weixin',1,3,'qq昵称','地址',NULL,'2017-10-17 13:11:35',NULL,1),

(15082170986940004,1,'李四3','0','12345678901','11111111111111111','123456789','weixin',1,3,'qq昵称','地址',NULL,'2017-10-17 13:11:38',NULL,1),

(15082171013090005,1,'李四4','0','12345678901','11111111111111111','123456789','weixin',1,3,'qq昵称','地址',NULL,'2017-10-17 13:11:41',NULL,1),

(15082171038140006,1,'李四5','0','12345678901','11111111111111111','123456789','weixin',1,3,'qq昵称','地址',NULL,'2017-10-17 13:11:43',NULL,1),

(15082171076980007,1,'李四6','0','12345678901','11111111111111111','123456789','weixin',1,3,'qq昵称','地址',NULL,'2017-10-17 13:11:47',NULL,1),

(15082171103020008,1,'李四7','0','12345678901','11111111111111111','123456789','weixin',1,3,'qq昵称','地址',NULL,'2017-10-17 13:11:50',NULL,1),

(15082171128230009,1,'李四8','0','12345678901','11111111111111111','123456789','weixin',1,3,'qq昵称','地址',NULL,'2017-10-17 13:11:52',NULL,1),

(15082171150470010,1,'李四9','0','12345678901','11111111111111111','123456789','weixin',1,3,'qq昵称','地址',NULL,'2017-10-17 13:11:55',NULL,1),

(15082171185320011,1,'李四10','0','12345678901','11111111111111111','123456789','weixin',1,3,'qq昵称','地址',NULL,'2017-10-17 13:11:58',NULL,1),

(15082171209320012,1,'李四11','0','12345678901','11111111111111111','123456789','weixin',1,3,'qq昵称','地址',NULL,'2017-10-17 13:12:00',NULL,1),

(15082171242140013,1,'李四12','0','12345678901','11111111111111111','123456789','weixin',1,3,'qq昵称','地址',NULL,'2017-10-17 13:12:04',NULL,1),

(15082171270020014,1,'李四13','0','12345678901','11111111111111111','123456789','weixin',1,3,'qq昵称','地址',NULL,'2017-10-17 13:12:07',NULL,1);

/*Table structure for table `member_department` */

DROP TABLE IF EXISTS `member_department`;

CREATE TABLE `member_department` (
  `member_id` bigint(20) NOT NULL COMMENT '员工id',
  `department_id` bigint(20) DEFAULT NULL COMMENT '部门id',
  PRIMARY KEY (`member_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `member_department` */

insert  into `member_department`(`member_id`,`department_id`) values 

(15082170235410000,2),

(15082170759150001,1),

(15082170897370002,1),

(15082170950960003,1),

(15082170986940004,1),

(15082171013090005,1),

(15082171038140006,1),

(15082171076980007,1),

(15082171103020008,1),

(15082171128230009,1),

(15082171150470010,1),

(15082171185320011,1),

(15082171209320012,1),

(15082171242140013,1),

(15082171270020014,1);

/*Table structure for table `member_role` */

DROP TABLE IF EXISTS `member_role`;

CREATE TABLE `member_role` (
  `member_id` bigint(20) NOT NULL COMMENT '编号',
  `role_id` bigint(20) DEFAULT NULL COMMENT '员工角色权限',
  PRIMARY KEY (`member_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `member_role` */

insert  into `member_role`(`member_id`,`role_id`) values 

(1,1),

(15082170235410000,2),

(15082170759150001,2),

(15082170897370002,3),

(15082170950960003,3),

(15082170986940004,3),

(15082171013090005,3),

(15082171038140006,3),

(15082171076980007,3),

(15082171103020008,3),

(15082171128230009,3),

(15082171150470010,3),

(15082171185320011,3),

(15082171209320012,3),

(15082171242140013,3),

(15082171270020014,3);

/*Table structure for table `role` */

DROP TABLE IF EXISTS `role`;

CREATE TABLE `role` (
  `id` bigint(20) NOT NULL COMMENT '主键id',
  `name` varchar(50) DEFAULT NULL COMMENT '名称',
  `rdescribe` varchar(50) DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `role` */

insert  into `role`(`id`,`name`,`rdescribe`) values

(1,'admin','管理员'),

(2,'minister','主管'),

(3,'employee','业务员');

/*Table structure for table `t_client` */

DROP TABLE IF EXISTS `t_client`;

CREATE TABLE `t_client` (
  `client_id` bigint(20) NOT NULL COMMENT 'id',
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
  `member_id` bigint(20) DEFAULT NULL COMMENT '员工id',
  `ip` varchar(40) DEFAULT NULL COMMENT '追踪ip',
  PRIMARY KEY (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='客户表';

/*Data for the table `t_client` */

/*Table structure for table `t_client_log` */

DROP TABLE IF EXISTS `t_client_log`;

CREATE TABLE `t_client_log` (
  `client_id` bigint(20) DEFAULT NULL,
  `client_log` varchar(500) DEFAULT NULL,
  `TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY `FK_Reference_6` (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_client_log` */

/*Table structure for table `t_member_client` */

DROP TABLE IF EXISTS `t_member_client`;

CREATE TABLE `t_member_client` (
  `member_id` bigint(20) DEFAULT NULL,
  `client_id` bigint(20) NOT NULL,
  PRIMARY KEY (`client_id`),
  KEY `FK_Reference_4` (`member_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_member_client` */

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `id` bigint(20) NOT NULL COMMENT '主键id',
  `user_name` varchar(20) DEFAULT NULL COMMENT '用户名',
  `password` varchar(20) DEFAULT NULL COMMENT '密码',
  `status` int(1) DEFAULT '1' COMMENT '状态；0：停用，1：启用',
  `creat_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `creat_user_id` bigint(20) DEFAULT NULL COMMENT '创建此用户的用户id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `user` */

insert  into `user`(`id`,`user_name`,`password`,`status`,`creat_time`,`creat_user_id`) values 

(1,'admin','123',1,'2017-10-16 11:46:48',1),

(15082174885520000,'xaEWzY73','e7wH4sRD',1,'2017-10-17 13:18:08',1),

(15082178104690000,'ABqEVV75','LtKo31N5',1,'2017-10-17 13:23:30',1),

(15082178578700001,'acseqB27','Ro3E9uzF',1,'2017-10-17 13:24:21',1);

/*Table structure for table `user_member` */

DROP TABLE IF EXISTS `user_member`;

CREATE TABLE `user_member` (
  `user_id` bigint(20) NOT NULL COMMENT '用户id',
  `member_id` bigint(20) NOT NULL COMMENT '员工id',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `user_member` */

insert  into `user_member`(`user_id`,`member_id`) values 

(1,1),

(15082174885520000,15082170235410000),

(15082178104690000,15082170759150001),

(15082178578700001,15082170897370002);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
