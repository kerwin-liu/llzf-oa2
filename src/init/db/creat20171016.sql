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
  `id` int(11) DEFAULT NULL COMMENT '部门id',
  `name` varchar(50) DEFAULT NULL COMMENT '部门名称'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `department` */

insert  into `department`(`id`,`name`) values 
(1,'部门一'),
(2,'部门二');

/*Table structure for table `member` */

DROP TABLE IF EXISTS `member`;

CREATE TABLE `member` (
  `member_id` int(11) NOT NULL COMMENT '编号',
  `number` int(11) DEFAULT NULL COMMENT '工号',
  `NAME` varchar(30) DEFAULT NULL COMMENT '姓名',
  `sex` varchar(10) DEFAULT NULL COMMENT '性别 0:男 1:女',
  `phone` varchar(11) DEFAULT NULL COMMENT '手机',
  `card` varchar(20) DEFAULT NULL COMMENT '身份证',
  `qq` varchar(15) DEFAULT NULL COMMENT 'qq',
  `wexin` varchar(30) DEFAULT NULL COMMENT '微信账号',
  `groups` varchar(30) DEFAULT NULL COMMENT '管理分组',
  `qqnc` varchar(20) DEFAULT NULL COMMENT 'qq昵称',
  `address` varchar(50) DEFAULT NULL COMMENT '住址',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `OPEN` varchar(1) DEFAULT NULL COMMENT '是否开通账号 0：停用 1：启用',
  `creat_user_id` int(11) DEFAULT NULL COMMENT '增加此员工的用户id',
  PRIMARY KEY (`member_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='员工表：编号，工号，姓名，性别，手机，身份证，QQ，微信账号，管理分组';

/*Data for the table `member` */

insert  into `member`(`member_id`,`number`,`NAME`,`sex`,`phone`,`card`,`qq`,`wexin`,`groups`,`qqnc`,`address`,`remark`,`TIME`,`OPEN`,`creat_user_id`) values 
(1,1,'admin','0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-10-15 21:48:21','2',NULL);

/*Table structure for table `member_department` */

DROP TABLE IF EXISTS `member_department`;

CREATE TABLE `member_department` (
  `member_id` int(11) NOT NULL COMMENT '员工id',
  `department_id` int(11) DEFAULT NULL COMMENT '部门id'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `member_department` */

/*Table structure for table `member_role` */

DROP TABLE IF EXISTS `member_role`;

CREATE TABLE `member_role` (
  `member_id` int(11) DEFAULT NULL COMMENT '编号',
  `role_id` int(11) DEFAULT NULL COMMENT '员工角色权限'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `member_role` */

insert  into `member_role`(`member_id`,`role_id`) values 
(1,1);

/*Table structure for table `role` */

DROP TABLE IF EXISTS `role`;

CREATE TABLE `role` (
  `id` int(11) NOT NULL COMMENT '主键id',
  `name` varchar(50) DEFAULT NULL COMMENT '名称',
  `describe` varchar(50) DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `role` */

insert  into `role`(`id`,`name`,`describe`) values 
(1,'admin','管理员'),
(2,'minister','主管'),
(3,'employee','业务员');

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

/*Data for the table `t_client` */

/*Table structure for table `t_client_log` */

DROP TABLE IF EXISTS `t_client_log`;

CREATE TABLE `t_client_log` (
  `client_id` int(11) DEFAULT NULL,
  `client_log` varchar(500) DEFAULT NULL,
  `TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY `FK_Reference_6` (`client_id`),
  CONSTRAINT `FK_Reference_6` FOREIGN KEY (`client_id`) REFERENCES `t_client` (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_client_log` */

/*Table structure for table `t_member_client` */

DROP TABLE IF EXISTS `t_member_client`;

CREATE TABLE `t_member_client` (
  `member_id` int(11) DEFAULT NULL,
  `client_id` int(11) DEFAULT NULL,
  KEY `FK_Reference_4` (`member_id`),
  CONSTRAINT `FK_Reference_4` FOREIGN KEY (`member_id`) REFERENCES `member` (`member_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_member_client` */

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `id` int(11) NOT NULL COMMENT '主键id',
  `user_name` varchar(20) DEFAULT NULL COMMENT '用户名',
  `password` varchar(20) DEFAULT NULL COMMENT '密码',
  `status` int(1) DEFAULT '1' COMMENT '状态；0：停用，1：启用',
  `creat_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `creat_user_id` int(11) DEFAULT NULL COMMENT '创建此用户的用户id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `user` */

insert  into `user`(`id`,`user_name`,`password`,`status`,`creat_time`,`creat_user_id`) values 
(1,'admin','123',1,'2017-10-16 11:46:48',1);

/*Table structure for table `user_member` */

DROP TABLE IF EXISTS `user_member`;

CREATE TABLE `user_member` (
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `member_id` int(11) NOT NULL COMMENT '员工id',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `user_member` */

insert  into `user_member`(`user_id`,`member_id`) values 
(1,1);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
