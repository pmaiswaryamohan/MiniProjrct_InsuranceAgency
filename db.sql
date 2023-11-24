/*
SQLyog Community v13.0.1 (64 bit)
MySQL - 8.0.22 : Database - insurance_agency
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`insurance_agency` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `insurance_agency`;

/*Table structure for table `auth_group` */

DROP TABLE IF EXISTS `auth_group`;

CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `auth_group` */

/*Table structure for table `auth_group_permissions` */

DROP TABLE IF EXISTS `auth_group_permissions`;

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

/*Data for the table `auth_group_permissions` */

/*Table structure for table `auth_permission` */

DROP TABLE IF EXISTS `auth_permission`;

CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `auth_permission` */

/*Table structure for table `auth_user` */

DROP TABLE IF EXISTS `auth_user`;

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `auth_user` */

insert  into `auth_user`(`id`,`password`,`last_login`,`is_superuser`,`username`,`first_name`,`last_name`,`email`,`is_staff`,`is_active`,`date_joined`) values 
(1,'pbkdf2_sha256$260000$BCt5Vri48w5230PdURSf8x$GbGCei5q2acUVa8/5SGfqx7LJJ2Mt5rkeBacWIy78V0=','2023-11-08 11:18:26.254481',1,'admin','','','admin@gmail.com',1,1,'2023-11-08 11:14:03.766575');

/*Table structure for table `auth_user_groups` */

DROP TABLE IF EXISTS `auth_user_groups`;

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

/*Data for the table `auth_user_groups` */

/*Table structure for table `auth_user_user_permissions` */

DROP TABLE IF EXISTS `auth_user_user_permissions`;

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

/*Data for the table `auth_user_user_permissions` */

/*Table structure for table `django_admin_log` */

DROP TABLE IF EXISTS `django_admin_log`;

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

/*Data for the table `django_admin_log` */

/*Table structure for table `django_content_type` */

DROP TABLE IF EXISTS `django_content_type`;

CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `django_content_type` */

/*Table structure for table `django_migrations` */

DROP TABLE IF EXISTS `django_migrations`;

CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `django_migrations` */

/*Table structure for table `django_session` */

DROP TABLE IF EXISTS `django_session`;

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `django_session` */

insert  into `django_session`(`session_key`,`session_data`,`expire_date`) values 
('qaynauzto13n9bn7b4t1q2ob9bvsa17l','.eJxVjj0OwyAUg-_CHCH-KR279wzoAY-SNgIpJFPVuzdIGdrJkv3Z8pt42Lfi946rnxO5Ek6mXy9AfGEdQXpCfTQaW93WOdCB0DPt9N4SLreT_Rso0MvR1hKkYsizc9aYrBSTSmsetY0582AEamGzA2G5DgxQsYzOBXcBZlM08hhdxj8xkTiUf75Usjtt:1r0gcO:b7UlophpW02ITWJszAoi_yq5tyTpsXYVS0q0OB_8mI4','2023-11-22 11:21:08.589294');

/*Table structure for table `insurance_app_claim_table` */

DROP TABLE IF EXISTS `insurance_app_claim_table`;

CREATE TABLE `insurance_app_claim_table` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `claim` varchar(100) NOT NULL,
  `description` varchar(100) NOT NULL,
  `document` varchar(100) NOT NULL,
  `date` date NOT NULL,
  `status` varchar(100) NOT NULL,
  `POLICY_id` bigint NOT NULL,
  `USER_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `insurance_app_claim__POLICY_id_96f5d622_fk_insurance` (`POLICY_id`),
  KEY `insurance_app_claim__USER_id_38086031_fk_insurance` (`USER_id`),
  CONSTRAINT `insurance_app_claim__POLICY_id_96f5d622_fk_insurance` FOREIGN KEY (`POLICY_id`) REFERENCES `insurance_app_policy_table` (`id`),
  CONSTRAINT `insurance_app_claim__USER_id_38086031_fk_insurance` FOREIGN KEY (`USER_id`) REFERENCES `insurance_app_user_table` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `insurance_app_claim_table` */

insert  into `insurance_app_claim_table`(`id`,`claim`,`description`,`document`,`date`,`status`,`POLICY_id`,`USER_id`) values 
(1,'Claim 1','For the Family','img2_XFNAVlB.jpeg','2023-11-08','Accepted',1,1);

/*Table structure for table `insurance_app_complaints_table` */

DROP TABLE IF EXISTS `insurance_app_complaints_table`;

CREATE TABLE `insurance_app_complaints_table` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `complaint` varchar(100) NOT NULL,
  `date` date NOT NULL,
  `reply` varchar(100) NOT NULL,
  `USER_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `insurance_app_compla_USER_id_32c06545_fk_insurance` (`USER_id`),
  CONSTRAINT `insurance_app_compla_USER_id_32c06545_fk_insurance` FOREIGN KEY (`USER_id`) REFERENCES `insurance_app_user_table` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `insurance_app_complaints_table` */

insert  into `insurance_app_complaints_table`(`id`,`complaint`,`date`,`reply`,`USER_id`) values 
(1,'Need more policies','2023-11-08','Ok',1),
(2,'Hiii','2023-11-08','pending',1);

/*Table structure for table `insurance_app_feedback_table` */

DROP TABLE IF EXISTS `insurance_app_feedback_table`;

CREATE TABLE `insurance_app_feedback_table` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `feedback` varchar(100) NOT NULL,
  `date` date NOT NULL,
  `USER_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `insurance_app_feedba_USER_id_c72e1339_fk_insurance` (`USER_id`),
  CONSTRAINT `insurance_app_feedba_USER_id_c72e1339_fk_insurance` FOREIGN KEY (`USER_id`) REFERENCES `insurance_app_user_table` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `insurance_app_feedback_table` */

insert  into `insurance_app_feedback_table`(`id`,`feedback`,`date`,`USER_id`) values 
(1,'Good','2023-11-08',1);

/*Table structure for table `insurance_app_login_table` */

DROP TABLE IF EXISTS `insurance_app_login_table`;

CREATE TABLE `insurance_app_login_table` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `username` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `type` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `insurance_app_login_table` */

insert  into `insurance_app_login_table`(`id`,`username`,`password`,`type`) values 
(1,'admin','123','admin'),
(2,'john','John@1234','user');

/*Table structure for table `insurance_app_policy_table` */

DROP TABLE IF EXISTS `insurance_app_policy_table`;

CREATE TABLE `insurance_app_policy_table` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `policy_detials` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `insurance_app_policy_table` */

insert  into `insurance_app_policy_table`(`id`,`name`,`policy_detials`) values 
(1,'Life Insurance','Life Time'),
(2,'Vehicle','5 years');

/*Table structure for table `insurance_app_rating_table` */

DROP TABLE IF EXISTS `insurance_app_rating_table`;

CREATE TABLE `insurance_app_rating_table` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `rating` varchar(100) NOT NULL,
  `date` date NOT NULL,
  `USER_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `insurance_app_rating_USER_id_91a142cb_fk_insurance` (`USER_id`),
  CONSTRAINT `insurance_app_rating_USER_id_91a142cb_fk_insurance` FOREIGN KEY (`USER_id`) REFERENCES `insurance_app_user_table` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `insurance_app_rating_table` */

insert  into `insurance_app_rating_table`(`id`,`rating`,`date`,`USER_id`) values 
(1,'4','2023-11-08',1);

/*Table structure for table `insurance_app_reqpolicy_table` */

DROP TABLE IF EXISTS `insurance_app_reqpolicy_table`;

CREATE TABLE `insurance_app_reqpolicy_table` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `status` varchar(100) NOT NULL,
  `POLICY_id` bigint NOT NULL,
  `USER_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `insurance_app_reqpol_POLICY_id_18d2b883_fk_insurance` (`POLICY_id`),
  KEY `insurance_app_reqpol_USER_id_350dae6d_fk_insurance` (`USER_id`),
  CONSTRAINT `insurance_app_reqpol_POLICY_id_18d2b883_fk_insurance` FOREIGN KEY (`POLICY_id`) REFERENCES `insurance_app_policy_table` (`id`),
  CONSTRAINT `insurance_app_reqpol_USER_id_350dae6d_fk_insurance` FOREIGN KEY (`USER_id`) REFERENCES `insurance_app_user_table` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `insurance_app_reqpolicy_table` */

insert  into `insurance_app_reqpolicy_table`(`id`,`date`,`status`,`POLICY_id`,`USER_id`) values 
(1,'2023-11-08','Accepted',1,1),
(2,'2023-11-08','pending',2,1);

/*Table structure for table `insurance_app_user_table` */

DROP TABLE IF EXISTS `insurance_app_user_table`;

CREATE TABLE `insurance_app_user_table` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `place` varchar(100) NOT NULL,
  `post` varchar(100) NOT NULL,
  `pin` int NOT NULL,
  `phone` bigint NOT NULL,
  `email` varchar(100) NOT NULL,
  `photo` varchar(100) NOT NULL,
  `proof` varchar(100) NOT NULL,
  `LOGIN_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `insurance_app_user_t_LOGIN_id_2a7d28f6_fk_insurance` (`LOGIN_id`),
  CONSTRAINT `insurance_app_user_t_LOGIN_id_2a7d28f6_fk_insurance` FOREIGN KEY (`LOGIN_id`) REFERENCES `insurance_app_login_table` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `insurance_app_user_table` */

insert  into `insurance_app_user_table`(`id`,`first_name`,`last_name`,`place`,`post`,`pin`,`phone`,`email`,`photo`,`proof`,`LOGIN_id`) values 
(1,'John','Joseph','Calicut','Calicut',654321,9876543213,'john@gmail.com','img3.jpeg','img4_fJuqejw (1).jpeg',2);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
