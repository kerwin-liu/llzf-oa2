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

/*Data for the table `t_admin` */

insert  into `t_admin`(`admin_id`,`NAME`,`PASSWORD`,`TIME`,`admin_rese2`) values 
(1,'admin','123456','2017-10-13 11:42:10',NULL);

/*Data for the table `t_admin_member` */

/*Data for the table `t_client` */

/*Data for the table `t_client_log` */

/*Data for the table `t_department` */

/*Data for the table `t_member` */

/*Data for the table `t_member_client` */

/*Data for the table `user` */

insert  into `user`(`id`,`userName`,`password`,`salt`) values 
(1,NULL,NULL,NULL);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
