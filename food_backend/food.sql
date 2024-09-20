/*
 Navicat Premium Data Transfer

 Source Server         : mysql
 Source Server Type    : MySQL
 Source Server Version : 80300 (8.3.0)
 Source Host           : localhost:3306
 Source Schema         : food

 Target Server Type    : MySQL
 Target Server Version : 80300 (8.3.0)
 File Encoding         : 65001

 Date: 20/09/2024 22:42:22
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for auth_group
-- ----------------------------
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of auth_group
-- ----------------------------
BEGIN;
INSERT INTO `auth_group` (`id`, `name`) VALUES (2, '文章管理组');
INSERT INTO `auth_group` (`id`, `name`) VALUES (1, '食品管理组');
COMMIT;

-- ----------------------------
-- Table structure for auth_group_permissions
-- ----------------------------
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
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of auth_group_permissions
-- ----------------------------
BEGIN;
INSERT INTO `auth_group_permissions` (`id`, `group_id`, `permission_id`) VALUES (1, 1, 29);
INSERT INTO `auth_group_permissions` (`id`, `group_id`, `permission_id`) VALUES (2, 1, 30);
INSERT INTO `auth_group_permissions` (`id`, `group_id`, `permission_id`) VALUES (3, 1, 31);
INSERT INTO `auth_group_permissions` (`id`, `group_id`, `permission_id`) VALUES (4, 1, 32);
INSERT INTO `auth_group_permissions` (`id`, `group_id`, `permission_id`) VALUES (5, 1, 33);
INSERT INTO `auth_group_permissions` (`id`, `group_id`, `permission_id`) VALUES (6, 1, 34);
INSERT INTO `auth_group_permissions` (`id`, `group_id`, `permission_id`) VALUES (7, 1, 35);
INSERT INTO `auth_group_permissions` (`id`, `group_id`, `permission_id`) VALUES (8, 1, 36);
INSERT INTO `auth_group_permissions` (`id`, `group_id`, `permission_id`) VALUES (9, 1, 37);
INSERT INTO `auth_group_permissions` (`id`, `group_id`, `permission_id`) VALUES (10, 1, 38);
INSERT INTO `auth_group_permissions` (`id`, `group_id`, `permission_id`) VALUES (11, 1, 39);
INSERT INTO `auth_group_permissions` (`id`, `group_id`, `permission_id`) VALUES (12, 1, 40);
INSERT INTO `auth_group_permissions` (`id`, `group_id`, `permission_id`) VALUES (13, 1, 41);
INSERT INTO `auth_group_permissions` (`id`, `group_id`, `permission_id`) VALUES (14, 1, 42);
INSERT INTO `auth_group_permissions` (`id`, `group_id`, `permission_id`) VALUES (15, 1, 43);
INSERT INTO `auth_group_permissions` (`id`, `group_id`, `permission_id`) VALUES (16, 1, 44);
INSERT INTO `auth_group_permissions` (`id`, `group_id`, `permission_id`) VALUES (17, 1, 45);
INSERT INTO `auth_group_permissions` (`id`, `group_id`, `permission_id`) VALUES (18, 1, 46);
INSERT INTO `auth_group_permissions` (`id`, `group_id`, `permission_id`) VALUES (19, 1, 47);
INSERT INTO `auth_group_permissions` (`id`, `group_id`, `permission_id`) VALUES (20, 1, 48);
INSERT INTO `auth_group_permissions` (`id`, `group_id`, `permission_id`) VALUES (21, 1, 49);
INSERT INTO `auth_group_permissions` (`id`, `group_id`, `permission_id`) VALUES (22, 1, 50);
INSERT INTO `auth_group_permissions` (`id`, `group_id`, `permission_id`) VALUES (23, 1, 51);
INSERT INTO `auth_group_permissions` (`id`, `group_id`, `permission_id`) VALUES (24, 1, 52);
INSERT INTO `auth_group_permissions` (`id`, `group_id`, `permission_id`) VALUES (26, 2, 53);
INSERT INTO `auth_group_permissions` (`id`, `group_id`, `permission_id`) VALUES (27, 2, 54);
INSERT INTO `auth_group_permissions` (`id`, `group_id`, `permission_id`) VALUES (28, 2, 55);
INSERT INTO `auth_group_permissions` (`id`, `group_id`, `permission_id`) VALUES (29, 2, 56);
INSERT INTO `auth_group_permissions` (`id`, `group_id`, `permission_id`) VALUES (30, 2, 57);
INSERT INTO `auth_group_permissions` (`id`, `group_id`, `permission_id`) VALUES (31, 2, 58);
INSERT INTO `auth_group_permissions` (`id`, `group_id`, `permission_id`) VALUES (32, 2, 59);
INSERT INTO `auth_group_permissions` (`id`, `group_id`, `permission_id`) VALUES (33, 2, 60);
INSERT INTO `auth_group_permissions` (`id`, `group_id`, `permission_id`) VALUES (34, 2, 61);
INSERT INTO `auth_group_permissions` (`id`, `group_id`, `permission_id`) VALUES (35, 2, 62);
INSERT INTO `auth_group_permissions` (`id`, `group_id`, `permission_id`) VALUES (36, 2, 63);
INSERT INTO `auth_group_permissions` (`id`, `group_id`, `permission_id`) VALUES (25, 2, 64);
COMMIT;

-- ----------------------------
-- Table structure for auth_permission
-- ----------------------------
DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of auth_permission
-- ----------------------------
BEGIN;
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (1, 'Can add log entry', 1, 'add_logentry');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (2, 'Can change log entry', 1, 'change_logentry');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (3, 'Can delete log entry', 1, 'delete_logentry');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (4, 'Can view log entry', 1, 'view_logentry');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (5, 'Can add permission', 2, 'add_permission');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (6, 'Can change permission', 2, 'change_permission');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (7, 'Can delete permission', 2, 'delete_permission');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (8, 'Can view permission', 2, 'view_permission');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (9, 'Can add group', 3, 'add_group');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (10, 'Can change group', 3, 'change_group');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (11, 'Can delete group', 3, 'delete_group');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (12, 'Can view group', 3, 'view_group');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (13, 'Can add user', 4, 'add_user');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (14, 'Can change user', 4, 'change_user');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (15, 'Can delete user', 4, 'delete_user');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (16, 'Can view user', 4, 'view_user');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (17, 'Can add content type', 5, 'add_contenttype');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (18, 'Can change content type', 5, 'change_contenttype');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (19, 'Can delete content type', 5, 'delete_contenttype');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (20, 'Can view content type', 5, 'view_contenttype');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (21, 'Can add session', 6, 'add_session');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (22, 'Can change session', 6, 'change_session');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (23, 'Can delete session', 6, 'delete_session');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (24, 'Can view session', 6, 'view_session');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (25, 'Can add 广告', 7, 'add_ad');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (26, 'Can change 广告', 7, 'change_ad');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (27, 'Can delete 广告', 7, 'delete_ad');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (28, 'Can view 广告', 7, 'view_ad');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (29, 'Can add 食品分类', 8, 'add_category');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (30, 'Can change 食品分类', 8, 'change_category');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (31, 'Can delete 食品分类', 8, 'delete_category');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (32, 'Can view 食品分类', 8, 'view_category');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (33, 'Can add 食品信息', 9, 'add_food');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (34, 'Can change 食品信息', 9, 'change_food');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (35, 'Can delete 食品信息', 9, 'delete_food');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (36, 'Can view 食品信息', 9, 'view_food');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (37, 'Can add 食品厂商', 10, 'add_manufacturer');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (38, 'Can change 食品厂商', 10, 'change_manufacturer');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (39, 'Can delete 食品厂商', 10, 'delete_manufacturer');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (40, 'Can view 食品厂商', 10, 'view_manufacturer');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (41, 'Can add 食品营养', 11, 'add_nutrition');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (42, 'Can change 食品营养', 11, 'change_nutrition');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (43, 'Can delete 食品营养', 11, 'delete_nutrition');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (44, 'Can view 食品营养', 11, 'view_nutrition');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (45, 'Can add 食品评价', 12, 'add_review');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (46, 'Can change 食品评价', 12, 'change_review');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (47, 'Can delete 食品评价', 12, 'delete_review');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (48, 'Can view 食品评价', 12, 'view_review');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (49, 'Can add 食品价格', 13, 'add_price');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (50, 'Can change 食品价格', 13, 'change_price');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (51, 'Can delete 食品价格', 13, 'delete_price');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (52, 'Can view 食品价格', 13, 'view_price');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (53, 'Can add 食品文章', 14, 'add_article');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (54, 'Can change 食品文章', 14, 'change_article');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (55, 'Can delete 食品文章', 14, 'delete_article');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (56, 'Can view 食品文章', 14, 'view_article');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (57, 'Can add 文章分类', 15, 'add_category');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (58, 'Can change 文章分类', 15, 'change_category');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (59, 'Can delete 文章分类', 15, 'delete_category');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (60, 'Can view 文章分类', 15, 'view_category');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (61, 'Can add 文章评论', 16, 'add_comment');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (62, 'Can change 文章评论', 16, 'change_comment');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (63, 'Can delete 文章评论', 16, 'delete_comment');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (64, 'Can view 文章评论', 16, 'view_comment');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (65, 'Can add 个人资料', 17, 'add_profile');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (66, 'Can change 个人资料', 17, 'change_profile');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (67, 'Can delete 个人资料', 17, 'delete_profile');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (68, 'Can view 个人资料', 17, 'view_profile');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (69, 'Can add attachment', 18, 'add_attachment');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (70, 'Can change attachment', 18, 'change_attachment');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (71, 'Can delete attachment', 18, 'delete_attachment');
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (72, 'Can view attachment', 18, 'view_attachment');
COMMIT;

-- ----------------------------
-- Table structure for auth_user
-- ----------------------------
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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of auth_user
-- ----------------------------
BEGIN;
INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES (1, 'pbkdf2_sha256$600000$qi2tQyZzyroyND44lcAxKU$3VRAjQ8qnPfve04nhFMl8sqOs20xf0WFh/9i1sA7uNU=', '2024-09-20 22:33:27.978542', 1, 'root', '', '', 'root@163.com', 1, 1, '2024-05-20 16:41:28.002104');
INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES (2, 'pbkdf2_sha256$600000$qi2tQyZzyroyND44lcAxKU$3VRAjQ8qnPfve04nhFMl8sqOs20xf0WFh/9i1sA7uNU=', '2024-06-02 10:09:14.825912', 0, 'admin', '', '', 'admin@163.com', 1, 1, '2024-05-20 17:30:00.000000');
INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES (4, 'pbkdf2_sha256$600000$qn08tFRWhmSyOELAGtsakB$uKYeF1KApengnY6sBl0eaKd1hIP7wbyMrIAnQHBWoKI=', '2024-06-02 10:13:04.617306', 0, 'cwj', '', '', 'unjun0228@163.com', 0, 1, '2024-06-01 23:42:00.723292');
INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES (8, 'pbkdf2_sha256$600000$HbHfumKb72jqHgig7YBqO2$4upuWpWKdk4J4Gr9yTOxZobiCJCSlxC61MIjmhiGp3g=', '2024-06-04 09:11:09.161267', 0, 'user', '', '', '2755836193@qq.com', 0, 1, '2024-06-04 09:11:01.466563');
COMMIT;

-- ----------------------------
-- Table structure for auth_user_groups
-- ----------------------------
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of auth_user_groups
-- ----------------------------
BEGIN;
INSERT INTO `auth_user_groups` (`id`, `user_id`, `group_id`) VALUES (1, 2, 1);
INSERT INTO `auth_user_groups` (`id`, `user_id`, `group_id`) VALUES (2, 2, 2);
COMMIT;

-- ----------------------------
-- Table structure for auth_user_user_permissions
-- ----------------------------
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

-- ----------------------------
-- Records of auth_user_user_permissions
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for banner_ad
-- ----------------------------
DROP TABLE IF EXISTS `banner_ad`;
CREATE TABLE `banner_ad` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(200) NOT NULL,
  `desc` longtext,
  `link` varchar(200) DEFAULT NULL,
  `img` varchar(100) DEFAULT NULL,
  `order` int NOT NULL,
  `create_time` datetime(6) DEFAULT NULL,
  `update_time` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of banner_ad
-- ----------------------------
BEGIN;
INSERT INTO `banner_ad` (`id`, `title`, `desc`, `link`, `img`, `order`, `create_time`, `update_time`) VALUES (1, '广告01', '', NULL, 'banner/file/97c110b5ce7945dfa5d67f044593c2b5.jpg', 0, '2024-05-20 16:47:57.375027', '2024-06-01 08:18:38.950892');
INSERT INTO `banner_ad` (`id`, `title`, `desc`, `link`, `img`, `order`, `create_time`, `update_time`) VALUES (2, '广告02', '', NULL, 'banner/file/954327c77c8443a098fbf0a1e0f706a6.jpg', 0, '2024-05-20 16:48:11.083261', '2024-06-01 08:18:44.942726');
INSERT INTO `banner_ad` (`id`, `title`, `desc`, `link`, `img`, `order`, `create_time`, `update_time`) VALUES (3, '广告03', '', NULL, 'banner/file/98b31895dfd541fbb5d2f70332d91d4c.jpg', 0, '2024-05-20 16:48:26.344354', '2024-06-01 08:18:52.679371');
COMMIT;

-- ----------------------------
-- Table structure for django_admin_log
-- ----------------------------
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
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of django_admin_log
-- ----------------------------
BEGIN;
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (1, '2024-06-02 09:55:41.073988', '1', '食品管理组', 1, '[{\"added\": {}}]', 3, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (2, '2024-06-02 09:55:52.545175', '2', 'admin', 2, '[{\"changed\": {\"fields\": [\"Groups\", \"Last login\"]}}]', 4, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (3, '2024-06-02 09:56:59.385479', '2', '文章管理组', 1, '[{\"added\": {}}]', 3, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (4, '2024-06-02 09:57:12.546203', '2', 'admin', 2, '[{\"changed\": {\"fields\": [\"Groups\", \"Last login\"]}}]', 4, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (5, '2024-06-02 10:15:44.718273', '1', '<奥利奥><2024-06-01>的价格', 1, '[{\"added\": {}}]', 13, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (6, '2024-06-02 10:15:54.230581', '2', '<奥利奥><2024-06-02>的价格', 1, '[{\"added\": {}}]', 13, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (7, '2024-06-02 10:16:02.961338', '3', '<奥利奥><2024-06-03>的价格', 1, '[{\"added\": {}}]', 13, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (8, '2024-06-02 10:16:19.040577', '4', '<冰红茶><2024-06-01>的价格', 1, '[{\"added\": {}}]', 13, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (9, '2024-06-02 10:16:25.967560', '5', '<冰红茶><2024-06-02>的价格', 1, '[{\"added\": {}}]', 13, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (10, '2024-06-02 10:16:33.917438', '6', '<冰红茶><2024-06-03>的价格', 1, '[{\"added\": {}}]', 13, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (11, '2024-06-02 10:16:41.602334', '7', '<喝开水><2024-06-01>的价格', 1, '[{\"added\": {}}]', 13, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (12, '2024-06-02 10:16:48.880135', '8', '<喝开水><2024-06-02>的价格', 1, '[{\"added\": {}}]', 13, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (13, '2024-06-02 10:17:06.113644', '9', '<喝开水><2024-06-03>的价格', 1, '[{\"added\": {}}]', 13, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (14, '2024-06-02 10:18:57.610228', '10', '<亲嘴烧><2024-06-01>的价格', 1, '[{\"added\": {}}]', 13, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (15, '2024-06-02 10:19:06.205745', '11', '<亲嘴烧><2024-06-02>的价格', 1, '[{\"added\": {}}]', 13, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (16, '2024-06-02 10:19:15.362848', '12', '<亲嘴烧><2024-06-03>的价格', 1, '[{\"added\": {}}]', 13, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (17, '2024-06-02 10:19:24.119096', '13', '<AD钙奶><2024-06-01>的价格', 1, '[{\"added\": {}}]', 13, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (18, '2024-06-02 10:19:31.742657', '14', '<AD钙奶><2024-06-02>的价格', 1, '[{\"added\": {}}]', 13, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (19, '2024-06-02 10:19:40.533867', '15', '<AD钙奶><2024-06-03>的价格', 1, '[{\"added\": {}}]', 13, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (20, '2024-06-02 10:21:27.263215', '8', '旺仔牛奶', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (21, '2024-06-02 10:24:00.023540', '1', '旺仔牛奶的营养信息', 1, '[{\"added\": {}}]', 11, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (22, '2024-06-02 10:24:28.284533', '8', '旺仔牛奶', 2, '[{\"changed\": {\"fields\": [\"\\u98df\\u54c1\\u63cf\\u8ff0\", \"\\u5b58\\u50a8\\u6761\\u4ef6\", \"\\u98df\\u7269\\u8425\\u517b\\u4fe1\\u606f\"]}}]', 9, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (23, '2024-06-02 10:25:29.419294', '16', '<旺仔牛奶><2024-06-26>的价格', 1, '[{\"added\": {}}]', 13, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (24, '2024-06-02 10:25:41.265252', '17', '<旺仔牛奶><2024-06-28>的价格', 1, '[{\"added\": {}}]', 13, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (25, '2024-06-02 10:25:51.385556', '18', '<旺仔牛奶><2024-06-29>的价格', 1, '[{\"added\": {}}]', 13, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (26, '2024-06-02 10:26:05.364747', '19', '<旺仔牛奶><2024-06-30>的价格', 1, '[{\"added\": {}}]', 13, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (27, '2024-06-02 10:26:32.969166', '20', '<旺仔牛奶><2024-06-27>的价格', 1, '[{\"added\": {}}]', 13, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (28, '2024-06-02 10:26:53.509350', '8', '旺仔牛奶', 2, '[]', 9, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (29, '2024-06-02 10:33:35.310869', '1', '旺旺集团', 1, '[{\"added\": {}}]', 10, 1);
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES (30, '2024-06-02 10:33:47.298425', '8', '旺仔牛奶', 2, '[{\"changed\": {\"fields\": [\"\\u6240\\u5c5e\\u5382\\u5546\"]}}]', 9, 1);
COMMIT;

-- ----------------------------
-- Table structure for django_content_type
-- ----------------------------
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of django_content_type
-- ----------------------------
BEGIN;
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (1, 'admin', 'logentry');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (3, 'auth', 'group');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (2, 'auth', 'permission');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (4, 'auth', 'user');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (7, 'banner', 'ad');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (5, 'contenttypes', 'contenttype');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (18, 'django_summernote', 'attachment');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (8, 'food', 'category');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (9, 'food', 'food');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (10, 'food', 'manufacturer');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (11, 'food', 'nutrition');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (13, 'food', 'price');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (12, 'food', 'review');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (14, 'forum', 'article');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (15, 'forum', 'category');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (16, 'forum', 'comment');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (6, 'sessions', 'session');
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (17, 'user', 'profile');
COMMIT;

-- ----------------------------
-- Table structure for django_migrations
-- ----------------------------
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of django_migrations
-- ----------------------------
BEGIN;
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (1, 'contenttypes', '0001_initial', '2024-06-01 08:50:02.750118');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (2, 'auth', '0001_initial', '2024-06-01 08:50:02.873567');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (3, 'admin', '0001_initial', '2024-06-01 08:50:02.905090');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (4, 'admin', '0002_logentry_remove_auto_add', '2024-06-01 08:50:02.909574');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (5, 'admin', '0003_logentry_add_action_flag_choices', '2024-06-01 08:50:02.913229');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (6, 'contenttypes', '0002_remove_content_type_name', '2024-06-01 08:50:02.932227');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (7, 'auth', '0002_alter_permission_name_max_length', '2024-06-01 08:50:02.943486');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (8, 'auth', '0003_alter_user_email_max_length', '2024-06-01 08:50:02.952296');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (9, 'auth', '0004_alter_user_username_opts', '2024-06-01 08:50:02.957188');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (10, 'auth', '0005_alter_user_last_login_null', '2024-06-01 08:50:02.968857');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (11, 'auth', '0006_require_contenttypes_0002', '2024-06-01 08:50:02.969965');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (12, 'auth', '0007_alter_validators_add_error_messages', '2024-06-01 08:50:02.974213');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (13, 'auth', '0008_alter_user_username_max_length', '2024-06-01 08:50:02.987426');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (14, 'auth', '0009_alter_user_last_name_max_length', '2024-06-01 08:50:03.002106');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (15, 'auth', '0010_alter_group_name_max_length', '2024-06-01 08:50:03.009155');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (16, 'auth', '0011_update_proxy_permissions', '2024-06-01 08:50:03.012766');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (17, 'auth', '0012_alter_user_first_name_max_length', '2024-06-01 08:50:03.026165');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (18, 'banner', '0001_initial', '2024-06-01 08:50:03.029982');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (19, 'django_summernote', '0001_initial', '2024-06-01 08:50:03.033521');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (20, 'django_summernote', '0002_update-help_text', '2024-06-01 08:50:03.034882');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (21, 'django_summernote', '0003_alter_attachment_id', '2024-06-01 08:50:03.042462');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (22, 'food', '0001_initial', '2024-06-01 08:50:03.177339');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (23, 'forum', '0001_initial', '2024-06-01 08:50:03.320573');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (24, 'sessions', '0001_initial', '2024-06-01 08:50:03.327300');
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (25, 'user', '0001_initial', '2024-06-01 08:50:03.350285');
COMMIT;

-- ----------------------------
-- Table structure for django_session
-- ----------------------------
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of django_session
-- ----------------------------
BEGIN;
INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES ('8hqsi7soyczrf2mimu5x8qxsi8i2re9k', '.eJxVjEEOwiAQRe_C2hCcggWX7nsGMsMMUjU0Ke3KeHfbpAvd_vfef6uI61Li2mSOI6urOqvT70aYnlJ3wA-s90mnqS7zSHpX9EGbHiaW1-1w_w4KtrLVBBlMBm8o2y6jEcnWusDBCnhGJguEBqCHFFyfElII9pJki1wHPqjPF_nvOC4:1sDP8O:4uEpfIPeWyVE4as1euY5Cu6xVNXsoHWVeQWNALurGSA', '2024-06-15 21:51:00.337289');
INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES ('khl5sxzutgr6fvobdzx7ds46bff28qvw', '.eJzNV8FymzAQ_ZUM58QGIUDk2Hu_oHQ8kpBsEkAeAc14Mvn3asFNbFUBgt2pL5bRin373sLu8uptaNfuNl0j9KbIvUcv8O5P9xjlz6IGQ_5E661acVW3umArOLI6WpvVd5WL8tvx7JmDHW125m6GJPIlIj6TOJTUF0JiHKV5igUiOc0ZRoz6CCWIp1HCOWVpimMuzE1RiEgKTitRd43x9eM187gBrGklMu_xLvMYrWuhM-_e_P_YzbIuEomEBWNqloTRABbsx8PZwrAZzkra3En6QPPBUAGfBkyLwbAUABb7sfwbDLCKWqrB0uny1PWa5uvBwLSgOdddxd5juZje2_3duJuZgb_9BJsocjAFvo_sjcCBRBjF_cKDHpBwQAoJgSXB4Sdxw5P00OwKUTrzcwbRu8m6NI58EENwPOK0sRIAz-16q1W3n5mBaxBy6PRVErb22OEziVAfFQoTiDhH8cdVglh_ZbI2FjFXW5dgYPu_el2Lm61jZG-EA_h5RYD7HfXADgoD8zhK01nv6ofTsWK010oWpfgi-ugr3nxSnExZqop6SPYRdmbSryHEjKQvYWjnN7E3YlfCpVK5Q_KU5EMd7R_uGeV4vy_FAy3b6TzPQlzSco5ZBf_Dz7yUXkDVkclFNOxMpa5M1Z2ZVtoC7p8Qj2AUwVWQsDkx8I4Ju3ucavkOfAOCLqNm6Rv4Ln21-FWIl2lxGR_KPps1YXBVmWGvHZF3wL0FbRcys9UNXOrudcFdtd16X4SEAhiTkM8J4Wl_GBG2h7wBXZeQsjVFLk05bcVW6cOkrBHyYW5I-Ly3pqQHM0X0s-OIvH_Qb0DhS_jZSjvHoorWnaS87bRzPLKiCQmCJcLxnGheqBY7ZUaDEa1P8W9B78UMbbWx3fqIe0gxPCd1jyPSD8lU-FOMISqm1PP0tEJ1W3DnVHoOd9HAYtitj0CLsruIuetbbQklO6XOMfOsDY5gXre7gq7HIzek67X6bPLFnmCxGYplhNC1ekKv9iVN4d_IfQlRW3Jib5ivau_tNxzSWns:1srehR:w22ifsIGuHiq9nftaYX6HS5oPuVqJccQhZdm54KG_9Q', '2024-10-04 22:33:33.005407');
INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES ('l64gksqzoqyxz6fe9lyn95yleaxgbdnv', '.eJzNltuOmzAQhl8l4joHcMxpL3vfJyiraGyPE3YBRwa6ilZ599oh3SYUASWpxE0meGz__j9jD5_ODurqsKtL1LtUOC8OcZa3bQz4OxY2Id6g2Ks1V0WlU7a2XdbXbLn-rgRm36597yY4QHkwoxmRxJUkcpmkWwkuoqTUj0VMkUQCBKOEgUtISHjsh5wDi2MacDSD_C2JYjtpjkVdmrl-fCYON4IF5Jg4L4vEkUqJxFmaf3_akqSOIyFN8Cn3TAgZXAJ1g6Zvarxcx0O5kLCC4zHDFWRVk8-tqdL2mKhIJdoQuIH8W9EKpoVUTabWWZPYgMjTYmPnb36aPNMIgus6Z18LepbV83LRP9tIG-dXm8NU2JTnuqSZ-J5bUZu3p0rt-AF4ESW-ffJCNmYNvGZY9rD8Ep4B0GnW2ny3XXw1_kzxYxgu4_QSGIxagcrN4at68Da6c2A70VmbLu2ie9Qpx-FjjzK0otGWj1nC2_HUA_YiOQOuU0y1mfpdTDlUuFf6NIjVJ8aI8cPHnZoMTqhXe63qYw_e3-ozIPyIvzbpoIt0DkUtgVe1Rj1MexsRG3wajFnNB2g8KFPxe1jf6s-B92SHbdphu8Hrwi-V8TnIPfAje85CQHfIsV0VU-p9-GsFdJXyrOvmupd76IPFuNtchSbt7iTnHbs8yVJ7B-POq-q2DPZoPre6Wq7XLjPi-qQ667n_WBNabprL0ifkWTXhQvuRovB_cD9itI3ca7_s0fnVOf8C6vhklQ:1sDaTD:DU9WK5dj4TdV9StM3ScMHoo1JjPSmaM0Fha3d78ABFk', '2024-06-16 09:57:15.436128');
INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES ('qztvusebhnq7srhu9hift0wowbc8kgug', '.eJzNV8FymzAQ_ZUM58QGIUDk2Hu_oHQ8kpBsEkAeAc14Mvn3asFNbFUBgt2pL5bRin373sLu8uptaNfuNl0j9KbIvUcv8O5P9xjlz6IGQ_5E661acVW3umArOLI6WpvVd5WL8tvx7JmDHW125m6GJPIlIj6TOJTUF0JiHKV5igUiOc0ZRoz6CCWIp1HCOWVpimMuzE1RiEgKTitRd43x9eM187gBrGklMu_xLvMYrWuhM-_e_P_YzbIuEomEBWNqloTRABbsx8PZwrAZzkra3En6QPPBUAGfBkyLwbAUABb7sfwbDLCKWqrB0uny1PWa5uvBwLSgOdddxd5juZje2_3duJuZgb_9BJsocjAFvo_sjcCBRBjF_cKDHpBwQAoJgSXB4Sdxw5P00OwKUTrzcwbRu8m6NI58EENwPOK0sRIAz-16q1W3n5mBaxBy6PRVErb22OEziVAfFQoTiDhH8cdVglh_ZbI2FjFXW5dgYPu_el2Lm61jZG-EA_h5RYD7HfXADgoD8zhK01nv6ofTsWK010oWpfgi-ugr3nxSnExZqop6SPYRdmbSryHEjKQvYWjnN7E3YlfCpVK5Q_KU5EMd7R_uGeV4vy_FAy3b6TzPQlzSco5ZBf_Dz7yUXkDVkclFNOxMpa5M1Z2ZVtoC7p8Qj2AUwVWQsDkx8I4Ju3ucavkOfAOCLqNm6Rv4Ln21-FWIl2lxGR_KPps1YXBVmWGvHZF3wL0FbRcys9UNXOrudcFdtd16X4SEAhiTkM8J4Wl_GBG2h7wBXZeQsjVFLk05bcVW6cOkrBHyYW5I-Ly3pqQHM0X0s-OIvH_Qb0DhS_jZSjvHoorWnaS87bRzPLKiCQmCJcLxnGheqBY7ZUaDEa1P8W9B78UMbbWx3fqIe0gxPCd1jyPSD8lU-FOMISqm1PP0tEJ1W3DnVHoOd9HAYtitj0CLsruIuetbbQklO6XOMfOsDY5gXre7gq7HIzek67X6bPLFnmCxGYplhNC1ekKv9iVN4d_IfQlRW3Jib5ivau_tNxzSWns:1sIeut:qFSKy3Y-l1l7fTU4fipiu12L3OsXXgN_gWRUxBP4iqU', '2024-06-30 09:42:47.944406');
COMMIT;

-- ----------------------------
-- Table structure for django_summernote_attachment
-- ----------------------------
DROP TABLE IF EXISTS `django_summernote_attachment`;
CREATE TABLE `django_summernote_attachment` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `file` varchar(100) NOT NULL,
  `uploaded` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of django_summernote_attachment
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for food_category
-- ----------------------------
DROP TABLE IF EXISTS `food_category`;
CREATE TABLE `food_category` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `slug` varchar(120) DEFAULT NULL,
  `desc` longtext,
  `order` int NOT NULL,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of food_category
-- ----------------------------
BEGIN;
INSERT INTO `food_category` (`id`, `name`, `slug`, `desc`, `order`, `create_time`, `update_time`) VALUES (1, '饮料', 'yin-liao', '', 0, '2024-05-20 17:28:23.838425', '2024-05-20 17:28:23.838450');
INSERT INTO `food_category` (`id`, `name`, `slug`, `desc`, `order`, `create_time`, `update_time`) VALUES (2, '水果', 'shui-guo', '', 0, '2024-05-20 17:28:28.255389', '2024-05-20 17:28:28.255438');
INSERT INTO `food_category` (`id`, `name`, `slug`, `desc`, `order`, `create_time`, `update_time`) VALUES (3, '饼干', 'bing-gan', '', 0, '2024-05-22 05:22:58.086870', '2024-05-22 05:22:58.086912');
COMMIT;

-- ----------------------------
-- Table structure for food_food
-- ----------------------------
DROP TABLE IF EXISTS `food_food`;
CREATE TABLE `food_food` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `slug` varchar(120) DEFAULT NULL,
  `img` varchar(100) DEFAULT NULL,
  `desc` longtext,
  `shelf_life` varchar(20) DEFAULT NULL,
  `storage_conditions` longtext,
  `order` int NOT NULL,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `category_id` bigint DEFAULT NULL,
  `manufacturer_id` bigint DEFAULT NULL,
  `nutrition_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`),
  UNIQUE KEY `nutrition_id` (`nutrition_id`),
  KEY `food_food_manufacturer_id_b3998243_fk_food_manufacturer_id` (`manufacturer_id`),
  KEY `food_food_category_id_c9dc1a8a_fk_food_category_id` (`category_id`),
  CONSTRAINT `food_food_category_id_c9dc1a8a_fk_food_category_id` FOREIGN KEY (`category_id`) REFERENCES `food_category` (`id`),
  CONSTRAINT `food_food_manufacturer_id_b3998243_fk_food_manufacturer_id` FOREIGN KEY (`manufacturer_id`) REFERENCES `food_manufacturer` (`id`),
  CONSTRAINT `food_food_nutrition_id_3347bfd8_fk_food_nutrition_id` FOREIGN KEY (`nutrition_id`) REFERENCES `food_nutrition` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of food_food
-- ----------------------------
BEGIN;
INSERT INTO `food_food` (`id`, `name`, `slug`, `img`, `desc`, `shelf_life`, `storage_conditions`, `order`, `create_time`, `update_time`, `category_id`, `manufacturer_id`, `nutrition_id`) VALUES (2, '奥利奥', 'ao-li-ao', 'food/file/213deaeca95342c9bf1a30614a53b927.jpeg', '', NULL, '', 0, '2024-05-20 17:59:59.768458', '2024-05-29 07:31:52.772336', 3, NULL, NULL);
INSERT INTO `food_food` (`id`, `name`, `slug`, `img`, `desc`, `shelf_life`, `storage_conditions`, `order`, `create_time`, `update_time`, `category_id`, `manufacturer_id`, `nutrition_id`) VALUES (3, '冰红茶', 'bing-hong-cha', 'food/file/1577f588aa2c4383b656b3848b1fbb9c.jpeg', '', NULL, '', 0, '2024-05-22 05:31:02.904676', '2024-06-01 06:03:45.900984', 1, NULL, NULL);
INSERT INTO `food_food` (`id`, `name`, `slug`, `img`, `desc`, `shelf_life`, `storage_conditions`, `order`, `create_time`, `update_time`, `category_id`, `manufacturer_id`, `nutrition_id`) VALUES (4, '喝开水', 'he-kai-shui', 'food/file/6b50b1f8b8534c10b614a03c841678dc.jpeg', '', NULL, '', 0, '2024-05-22 05:31:14.233683', '2024-06-01 22:11:37.753653', 1, NULL, NULL);
INSERT INTO `food_food` (`id`, `name`, `slug`, `img`, `desc`, `shelf_life`, `storage_conditions`, `order`, `create_time`, `update_time`, `category_id`, `manufacturer_id`, `nutrition_id`) VALUES (5, '亲嘴烧', 'qin-zui-shao', 'food/file/40c493dc2296436cb1e39d3247e5b4bf.jpeg', '', NULL, '', 0, '2024-05-22 05:31:27.249594', '2024-06-02 09:44:21.143097', NULL, NULL, NULL);
INSERT INTO `food_food` (`id`, `name`, `slug`, `img`, `desc`, `shelf_life`, `storage_conditions`, `order`, `create_time`, `update_time`, `category_id`, `manufacturer_id`, `nutrition_id`) VALUES (6, 'AD钙奶', 'adgai-nai', 'food/file/593ccb4998a54f62b137864ad67c60a2.jpeg', '', NULL, '', 0, '2024-05-22 05:31:43.006512', '2024-06-03 23:30:51.878275', NULL, NULL, NULL);
INSERT INTO `food_food` (`id`, `name`, `slug`, `img`, `desc`, `shelf_life`, `storage_conditions`, `order`, `create_time`, `update_time`, `category_id`, `manufacturer_id`, `nutrition_id`) VALUES (7, '大辣棒', 'da-la-bang', 'food/file/039b1da2080f4c86b32bf56e9b16c3a7.jpeg', '', NULL, '', 0, '2024-05-22 05:31:59.352553', '2024-05-31 08:30:12.110900', NULL, NULL, NULL);
INSERT INTO `food_food` (`id`, `name`, `slug`, `img`, `desc`, `shelf_life`, `storage_conditions`, `order`, `create_time`, `update_time`, `category_id`, `manufacturer_id`, `nutrition_id`) VALUES (8, '旺仔牛奶', 'wang-zi-niu-nai', 'food/file/a96dbfe9b6a14d3792c5772fa35a1f8d.jpeg', '请你喝牛奶，忘掉那个崽。', '12个月', '常温保存，避免阳光直射', 1000, '2024-06-02 10:21:27.260611', '2024-06-04 09:11:23.918209', 1, 1, 1);
COMMIT;

-- ----------------------------
-- Table structure for food_food_liked_by
-- ----------------------------
DROP TABLE IF EXISTS `food_food_liked_by`;
CREATE TABLE `food_food_liked_by` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `food_id` bigint NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `food_food_liked_by_food_id_user_id_bf0c5b26_uniq` (`food_id`,`user_id`),
  KEY `food_food_liked_by_user_id_543a84bf_fk_auth_user_id` (`user_id`),
  CONSTRAINT `food_food_liked_by_food_id_805b7ead_fk_food_food_id` FOREIGN KEY (`food_id`) REFERENCES `food_food` (`id`),
  CONSTRAINT `food_food_liked_by_user_id_543a84bf_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of food_food_liked_by
-- ----------------------------
BEGIN;
INSERT INTO `food_food_liked_by` (`id`, `food_id`, `user_id`) VALUES (8, 8, 8);
COMMIT;

-- ----------------------------
-- Table structure for food_manufacturer
-- ----------------------------
DROP TABLE IF EXISTS `food_manufacturer`;
CREATE TABLE `food_manufacturer` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `desc` longtext,
  `website` varchar(200) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `email` varchar(254) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of food_manufacturer
-- ----------------------------
BEGIN;
INSERT INTO `food_manufacturer` (`id`, `name`, `desc`, `website`, `address`, `phone`, `email`) VALUES (1, '旺旺集团', '旺旺集团成立于1962年，前身为宜兰食品工业股份有限公司。1983年创立旺旺品牌，且于90年代初期即赴大陆投资设厂。', 'https://wantwant.vn/cn/about.html', '中国上海', '+86 021-61151111', 'wwvntrading@want-want.com');
COMMIT;

-- ----------------------------
-- Table structure for food_nutrition
-- ----------------------------
DROP TABLE IF EXISTS `food_nutrition`;
CREATE TABLE `food_nutrition` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `ingredient_name` longtext,
  `calories` double DEFAULT NULL,
  `protein` double DEFAULT NULL,
  `fat` double DEFAULT NULL,
  `carbohydrates` double DEFAULT NULL,
  `fiber` double DEFAULT NULL,
  `update_time` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of food_nutrition
-- ----------------------------
BEGIN;
INSERT INTO `food_nutrition` (`id`, `name`, `ingredient_name`, `calories`, `protein`, `fat`, `carbohydrates`, `fiber`, `update_time`) VALUES (1, '旺仔牛奶', '复原乳（80%）（水、全脂乳粉、炼乳）、水、白砂糖、食品添加剂（蔗糖脂肪酸酯、单硬脂酸甘油酯）、炼乳香精。', 97, 174, 5.9, 6.4, 0, '2024-06-02 10:24:00.021479');
COMMIT;

-- ----------------------------
-- Table structure for food_price
-- ----------------------------
DROP TABLE IF EXISTS `food_price`;
CREATE TABLE `food_price` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `price` double DEFAULT NULL,
  `discount` double DEFAULT NULL,
  `create_time` date NOT NULL,
  `food_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `food_price_food_id_6f6c9812_fk_food_food_id` (`food_id`),
  CONSTRAINT `food_price_food_id_6f6c9812_fk_food_food_id` FOREIGN KEY (`food_id`) REFERENCES `food_food` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of food_price
-- ----------------------------
BEGIN;
INSERT INTO `food_price` (`id`, `price`, `discount`, `create_time`, `food_id`) VALUES (1, 5, 5, '2024-06-01', 2);
INSERT INTO `food_price` (`id`, `price`, `discount`, `create_time`, `food_id`) VALUES (2, 5, 5, '2024-06-02', 2);
INSERT INTO `food_price` (`id`, `price`, `discount`, `create_time`, `food_id`) VALUES (3, 5, 5, '2024-06-03', 2);
INSERT INTO `food_price` (`id`, `price`, `discount`, `create_time`, `food_id`) VALUES (4, 3, 3, '2024-06-01', 3);
INSERT INTO `food_price` (`id`, `price`, `discount`, `create_time`, `food_id`) VALUES (5, 3, 3, '2024-06-02', 3);
INSERT INTO `food_price` (`id`, `price`, `discount`, `create_time`, `food_id`) VALUES (6, 3, 3, '2024-06-03', 3);
INSERT INTO `food_price` (`id`, `price`, `discount`, `create_time`, `food_id`) VALUES (7, 2, 2, '2024-06-01', 4);
INSERT INTO `food_price` (`id`, `price`, `discount`, `create_time`, `food_id`) VALUES (8, 2, 2, '2024-06-02', 4);
INSERT INTO `food_price` (`id`, `price`, `discount`, `create_time`, `food_id`) VALUES (9, 2, 2, '2024-06-03', 4);
INSERT INTO `food_price` (`id`, `price`, `discount`, `create_time`, `food_id`) VALUES (10, 1, 1, '2024-06-01', 5);
INSERT INTO `food_price` (`id`, `price`, `discount`, `create_time`, `food_id`) VALUES (11, 1, 1, '2024-06-02', 5);
INSERT INTO `food_price` (`id`, `price`, `discount`, `create_time`, `food_id`) VALUES (12, 1, 1, '2024-06-03', 5);
INSERT INTO `food_price` (`id`, `price`, `discount`, `create_time`, `food_id`) VALUES (13, 2, 2, '2024-06-01', 6);
INSERT INTO `food_price` (`id`, `price`, `discount`, `create_time`, `food_id`) VALUES (14, 2, 2, '2024-06-02', 6);
INSERT INTO `food_price` (`id`, `price`, `discount`, `create_time`, `food_id`) VALUES (15, 2, 2, '2024-06-03', 6);
INSERT INTO `food_price` (`id`, `price`, `discount`, `create_time`, `food_id`) VALUES (16, 3.5, 3.5, '2024-06-26', 8);
INSERT INTO `food_price` (`id`, `price`, `discount`, `create_time`, `food_id`) VALUES (17, 3.6, 3.6, '2024-06-28', 8);
INSERT INTO `food_price` (`id`, `price`, `discount`, `create_time`, `food_id`) VALUES (18, 4, 4, '2024-06-29', 8);
INSERT INTO `food_price` (`id`, `price`, `discount`, `create_time`, `food_id`) VALUES (19, 5, 5, '2024-06-30', 8);
INSERT INTO `food_price` (`id`, `price`, `discount`, `create_time`, `food_id`) VALUES (20, 4, 4, '2024-06-27', 8);
COMMIT;

-- ----------------------------
-- Table structure for food_review
-- ----------------------------
DROP TABLE IF EXISTS `food_review`;
CREATE TABLE `food_review` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `rating` double DEFAULT NULL,
  `body` longtext,
  `create_time` datetime(6) NOT NULL,
  `food_id` bigint DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `food_review_food_id_1318714e_fk_food_food_id` (`food_id`),
  KEY `food_review_user_id_493cf997_fk_auth_user_id` (`user_id`),
  CONSTRAINT `food_review_food_id_1318714e_fk_food_food_id` FOREIGN KEY (`food_id`) REFERENCES `food_food` (`id`),
  CONSTRAINT `food_review_user_id_493cf997_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of food_review
-- ----------------------------
BEGIN;
INSERT INTO `food_review` (`id`, `rating`, `body`, `create_time`, `food_id`, `user_id`) VALUES (7, 5, '12', '2024-06-04 08:00:34.607625', 8, 1);
INSERT INTO `food_review` (`id`, `rating`, `body`, `create_time`, `food_id`, `user_id`) VALUES (8, 4, '123', '2024-06-04 09:11:39.728575', 8, 8);
COMMIT;

-- ----------------------------
-- Table structure for forum_article
-- ----------------------------
DROP TABLE IF EXISTS `forum_article`;
CREATE TABLE `forum_article` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(250) NOT NULL,
  `slug` varchar(120) DEFAULT NULL,
  `img` varchar(100) DEFAULT NULL,
  `summary` longtext,
  `body` longtext NOT NULL,
  `views` int DEFAULT NULL,
  `status` varchar(1) DEFAULT NULL,
  `is_top` tinyint(1) DEFAULT NULL,
  `update_time` datetime(6) NOT NULL,
  `create_time` datetime(6) NOT NULL,
  `author_id` int NOT NULL,
  `category_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`),
  KEY `forum_article_category_id_2ae80cd3_fk_forum_category_id` (`category_id`),
  KEY `forum_article_author_id_0b5f413f_fk_auth_user_id` (`author_id`),
  CONSTRAINT `forum_article_author_id_0b5f413f_fk_auth_user_id` FOREIGN KEY (`author_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `forum_article_category_id_2ae80cd3_fk_forum_category_id` FOREIGN KEY (`category_id`) REFERENCES `forum_category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of forum_article
-- ----------------------------
BEGIN;
INSERT INTO `forum_article` (`id`, `title`, `slug`, `img`, `summary`, `body`, `views`, `status`, `is_top`, `update_time`, `create_time`, `author_id`, `category_id`) VALUES (2, '食品安全的首要任务：了解食品标签的重要性', 'shi-pin-an-quan-de-shou-yao-ren-wu-liao-jie-shi-pin-biao-qian-de-zhong-yao-xing', 'article/file/f7135d8f3da24a91a71290956b73b6c1.jpeg', '在当今社会，食品安全已成为人们关注的热点问题。本文重点介绍了食品标签的重要性，如何通过阅读食品标签来了解食品成分、营养价值、生产日期和保质期等信息，以及这些信息对消费者选择健康食品的影响。文章旨在提高公众的食品安全意识，促使消费者做出更明智的食品选择。', '<p class=\"MsoNormal\" align=\"justify\" style=\"margin: 0pt; text-align: justify; font-family: Calibri; font-size: 10.5pt; color: rgb(0, 0, 0); text-indent: 21pt; line-height: 21px; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;\"><span style=\"font-family: 宋体; line-height: 24px; letter-spacing: 0pt; font-size: 12pt; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;\">在现代社会，食品安全问题频发，消费者越来越关注所购买食品的质量和安全性。食品标签作为消费者了解食品信息的重要途径，其意义不容忽视。食品标签上的信息包括食品成分、营养成分表、添加剂名称、生产日期和保质期等，这些信息对于消费者选择健康、安全的食品至关重要。</span><span style=\"line-height: 24px; letter-spacing: 0pt; font-size: 12pt;\"><o:p></o:p></span></p><p class=\"MsoNormal\" align=\"justify\" style=\"margin: 0pt; text-align: justify; font-family: Calibri; font-size: 10.5pt; color: rgb(0, 0, 0); text-indent: 21pt; line-height: 21px; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;\"><span style=\"font-family: 宋体; line-height: 24px; letter-spacing: 0pt; font-size: 12pt; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;\">首先，食品成分列表能够帮助消费者识别出可能对特定人群有害的成分，比如过敏原。其次，营养成分表提供了食品的能量和主要营养素含量，对于追求健康饮食的消费者来说，这是判断食品是否符合其营养需求的关键信息。此外，通过检查生产日期和保质期，消费者可以避免购买过期或即将过期的食品，从而减少食物中毒的风险。</span><span style=\"line-height: 24px; letter-spacing: 0pt; font-size: 12pt;\"><o:p></o:p></span></p><p class=\"MsoNormal\" align=\"justify\" style=\"margin: 0pt; text-align: justify; font-family: Calibri; font-size: 10.5pt; color: rgb(0, 0, 0); text-indent: 21pt; line-height: 21px; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;\"><span style=\"font-family: 宋体; line-height: 24px; letter-spacing: 0pt; font-size: 12pt; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;\">然而，尽管食品标签提供了丰富的信息，但调查显示很多消费者在购物时很少或根本不查看食品标签。这种现象的原因多样，包括标签信息复杂难懂、消费者缺乏相关知识、或是简单地因为急于购物。因此，提高公众对食品标签重要性的认识，以及如何正确阅读和理解这些信息，显得尤为重要。</span><span style=\"line-height: 24px; letter-spacing: 0pt; font-size: 12pt;\"><o:p></o:p></span></p><p class=\"MsoNormal\" align=\"justify\" style=\"margin: 0pt; text-align: justify; font-family: Calibri; font-size: 10.5pt; color: rgb(0, 0, 0); text-indent: 21pt; line-height: 21px; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;\"><span style=\"font-family: 宋体; line-height: 24px; letter-spacing: 0pt; font-size: 12pt; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;\">为了改变这一现状，政府和相关机构应加强对食品标签的宣传教育，简化标签信息，使其更加易懂。同时，消费者也应主动学习相关知识，提高自我保护意识，确保每次购买的都是安全、健康的食品。</span><span style=\"line-height: 24px; letter-spacing: 0pt; font-size: 12pt;\"><o:p></o:p></span></p><p class=\"MsoNormal\" align=\"justify\" style=\"margin: 0pt; text-align: justify; font-family: Calibri; font-size: 10.5pt; color: rgb(0, 0, 0); text-indent: 21pt; line-height: 21px; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;\"><span style=\"font-family: 宋体; line-height: 24px; letter-spacing: 0pt; font-size: 12pt; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;\">通过上述措施，我们可以构建一个更加安全、透明的食品环境，为消费者的健康提供更有力的保障。</span><span style=\"line-height: 24px; letter-spacing: 0pt; font-size: 12pt;\"><o:p></o:p></span></p><p class=\"MsoNormal\" style=\"margin: 0pt 0pt 0.0001pt; text-align: justify; font-family: Calibri; font-size: 10.5pt; color: rgb(0, 0, 0); line-height: 21px;\"><span style=\"line-height: 24px; font-size: 12pt;\">&nbsp;</span></p>', 28, 'p', 0, '2024-06-02 10:46:18.830402', '2024-03-16 16:27:04.860927', 1, 4);
INSERT INTO `forum_article` (`id`, `title`, `slug`, `img`, `summary`, `body`, `views`, `status`, `is_top`, `update_time`, `create_time`, `author_id`, `category_id`) VALUES (3, '探索超级食物：营养丰富的食品对健康的影响', 'tan-suo-chao-ji-shi-wu-ying-yang-feng-fu-de-shi-pin-dui-jian-kang-de-ying-xiang', 'article/file/03b281fe55f546e3ae38752c968508d0.jpeg', '本文深入探讨了所谓的\"超级食物\"及其对人体健康的积极影响。超级食物通常指那些富含维生素、矿物质、抗氧化剂和其他营养成分的食品，它们对于提高免疫力、预防疾病、改善心血管健康等方面有着显著的好处。文章通过列举几种典型的超级食物，如蓝莓、绿茶、鲑鱼等，展示了它们的营养价值和对健康的潜在益处，鼓励读者将这些食物纳入日常饮食中。', '<p class=\"MsoNormal\" align=\"justify\" style=\"margin: 0pt; text-align: justify; font-family: Calibri; font-size: 10.5pt; color: rgb(0, 0, 0); text-indent: 21pt; line-height: 21px; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;\"><span style=\"font-family: 宋体; line-height: 24px; letter-spacing: 0pt; font-size: 12pt; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;\"><font face=\"宋体\">在健康和营养领域，</font><font face=\"宋体\">\"超级食物\"一词越来越流行。它指的是那些营养密度高，对健康特别有益的食品。尽管没有官方的定义，但超级食物通常富含对人体有益的维生素、矿物质、抗氧化剂、纤维和其他营养成分。这些食物的健康益处范围广泛，从提高免疫力到预防慢性疾病等等。</font></span><span style=\"line-height: 24px; letter-spacing: 0pt; font-size: 12pt;\"><o:p></o:p></span></p><p class=\"MsoNormal\" align=\"justify\" style=\"margin: 0pt; text-align: justify; font-family: Calibri; font-size: 10.5pt; color: rgb(0, 0, 0); text-indent: 21pt; line-height: 21px; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;\"><span style=\"font-family: 宋体; line-height: 24px; letter-spacing: 0pt; font-size: 12pt; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;\"><font face=\"宋体\">蓝莓：被广泛认为是超级食物的典范，富含维生素</font><font face=\"宋体\">C和K，以及纤维和抗氧化剂。研究表明，蓝莓有助于心脏健康，改善记忆力和认知功能，甚至可能有助于对抗某些类型的癌症。</font></span><span style=\"line-height: 24px; letter-spacing: 0pt; font-size: 12pt;\"><o:p></o:p></span></p><p class=\"MsoNormal\" align=\"justify\" style=\"margin: 0pt; text-align: justify; font-family: Calibri; font-size: 10.5pt; color: rgb(0, 0, 0); text-indent: 21pt; line-height: 21px; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;\"><span style=\"font-family: 宋体; line-height: 24px; letter-spacing: 0pt; font-size: 12pt; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;\">绿茶：是另一种超级食物，富含强大的抗氧化剂，如儿茶素，有助于减少炎症和预防癌症。绿茶还被认为可以促进心脏健康，提高脂肪燃烧速度，从而有助于体重管理。</span><span style=\"line-height: 24px; letter-spacing: 0pt; font-size: 12pt;\"><o:p></o:p></span></p><p class=\"MsoNormal\" align=\"justify\" style=\"margin: 0pt; text-align: justify; font-family: Calibri; font-size: 10.5pt; color: rgb(0, 0, 0); text-indent: 21pt; line-height: 21px; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;\"><span style=\"font-family: 宋体; line-height: 24px; letter-spacing: 0pt; font-size: 12pt; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;\"><font face=\"宋体\">鲑鱼：是一种富含</font><font face=\"宋体\">omega-3脂肪酸的超级食物，对心脏健康特别有益。Omega-3可以帮助降低血压，减少心脏病发作的风险，并改善大脑健康。</font></span><span style=\"line-height: 24px; letter-spacing: 0pt; font-size: 12pt;\"><o:p></o:p></span></p><p class=\"MsoNormal\" align=\"justify\" style=\"margin: 0pt; text-align: justify; font-family: Calibri; font-size: 10.5pt; color: rgb(0, 0, 0); text-indent: 21pt; line-height: 21px; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;\"><span style=\"font-family: 宋体; line-height: 24px; letter-spacing: 0pt; font-size: 12pt; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;\">除了这些，还有许多其他食物也被认为是超级食物，如菠菜、坚果、种子、大蒜和番茄等。将这些食物纳入日常饮食，可以显著提高营养摄入量，促进健康和福祉。</span><span style=\"line-height: 24px; letter-spacing: 0pt; font-size: 12pt;\"><o:p></o:p></span></p><p class=\"MsoNormal\" align=\"justify\" style=\"margin: 0pt; text-align: justify; font-family: Calibri; font-size: 10.5pt; color: rgb(0, 0, 0); text-indent: 21pt; line-height: 21px; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;\"><span style=\"font-family: 宋体; line-height: 24px; letter-spacing: 0pt; font-size: 12pt; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;\">然而，重要的是要记住，没有任何单一食物可以提供所有的营养需求。健康的饮食应该包括多种食物，以确保获得各种营养素。最终，超级食物可以是营养丰富饮食的一部分，但平衡饮食和健康的生活方式才是关键。</span><span style=\"line-height: 24px; letter-spacing: 0pt; font-size: 12pt;\"><o:p></o:p></span></p><p class=\"MsoNormal\" style=\"margin: 0pt 0pt 0.0001pt; text-align: justify; font-family: Calibri; font-size: 10.5pt; color: rgb(0, 0, 0); line-height: 21px;\"><span style=\"line-height: 24px; font-size: 12pt;\">&nbsp;</span></p>', 12, 'p', 1, '2024-05-31 05:26:05.428155', '2024-03-16 16:28:11.228181', 1, 1);
INSERT INTO `forum_article` (`id`, `title`, `slug`, `img`, `summary`, `body`, `views`, `status`, `is_top`, `update_time`, `create_time`, `author_id`, `category_id`) VALUES (4, '品味营养：探索顶级牛奶品牌的独特之处', 'pin-wei-ying-yang-tan-suo-ding-ji-niu-nai-pin-pai-de-du-te-zhi-chu', 'article/file/5809552ae04545f88c7b97c11416ef42.jpeg', '本文深入探讨了市场上几款顶级牛奶品牌，分析它们的特点、营养价值以及如何在众多选择中找到适合您的牛奶。从有机牧场到创新的包装方式，每个品牌都有其独特之处，旨在满足消费者对健康、口感和质量的高标准。通过比较不同品牌的生产过程、营养成分和口味，本文旨在帮助读者做出更明智的选择，享受牛奶带来的健康益处。', '<p class=\"MsoNormal\" align=\"justify\" style=\"margin: 0pt; text-align: justify; font-family: Calibri; font-size: 10.5pt; color: rgb(0, 0, 0); text-indent: 21pt; line-height: 21pt; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;\"><span style=\"font-family: 宋体; letter-spacing: 0pt; font-size: 12pt; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;\"><font face=\"宋体\">牛奶作为最受欢迎的日常饮品之一，不仅口感丰富，还富含多种对人体有益的营养成分，如蛋白质、钙、维生素</font><font face=\"宋体\">D等。市场上众多牛奶品牌提供了各式各样的选择，但如何挑选出最适合自己的呢？</font></span><span style=\"letter-spacing: 0pt; font-size: 12pt;\"><o:p></o:p></span></p><p class=\"MsoNormal\" align=\"justify\" style=\"margin: 0pt; text-align: justify; font-family: Calibri; font-size: 10.5pt; color: rgb(0, 0, 0); text-indent: 21pt; line-height: 21pt; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;\"><span style=\"font-family: 宋体; letter-spacing: 0pt; font-size: 12pt; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;\">1. 有机牛奶品牌： 有机牛奶因其高标准的生产流程和对动物福利的重视而受到消费者的青睐。这些品牌的牛奶来自未经转基因处理且饲养在自然条件下的牛，不使用人工激素或抗生素。</span><span style=\"letter-spacing: 0pt; font-size: 12pt;\"><o:p></o:p></span></p><p class=\"MsoNormal\" align=\"justify\" style=\"margin: 0pt; text-align: justify; font-family: Calibri; font-size: 10.5pt; color: rgb(0, 0, 0); text-indent: 21pt; line-height: 21pt; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;\"><span style=\"font-family: 宋体; letter-spacing: 0pt; font-size: 12pt; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;\">2. 草饲牛奶品牌： 草饲牛奶是从只吃草的牛中挤出的牛奶，相较于常规牛奶，它含有更高比例的Omega-3脂肪酸和维生素E。</span><span style=\"letter-spacing: 0pt; font-size: 12pt;\"><o:p></o:p></span></p><p class=\"MsoNormal\" align=\"justify\" style=\"margin: 0pt; text-align: justify; font-family: Calibri; font-size: 10.5pt; color: rgb(0, 0, 0); text-indent: 21pt; line-height: 21pt; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;\"><span style=\"font-family: 宋体; letter-spacing: 0pt; font-size: 12pt; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;\">3. 特殊营养配方牛奶： 针对特定人群的需求，一些品牌推出了富含额外营养成分的牛奶，如增加了维生素D、钙或蛋白质的牛奶。</span><span style=\"letter-spacing: 0pt; font-size: 12pt;\"><o:p></o:p></span></p><p class=\"MsoNormal\" align=\"justify\" style=\"margin: 0pt; text-align: justify; font-family: Calibri; font-size: 10.5pt; color: rgb(0, 0, 0); text-indent: 21pt; line-height: 21pt; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;\"><span style=\"font-family: 宋体; letter-spacing: 0pt; font-size: 12pt; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;\">4. 口味和质量： 不同品牌的牛奶在口味和质量上也有所区别，有些品牌注重牛奶的自然甜味，有些则专注于口感的丰富多样。</span><span style=\"letter-spacing: 0pt; font-size: 12pt;\"><o:p></o:p></span></p><p class=\"MsoNormal\" align=\"justify\" style=\"margin: 0pt; text-align: justify; font-family: Calibri; font-size: 10.5pt; color: rgb(0, 0, 0); text-indent: 21pt; line-height: 21pt; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;\"><span style=\"font-family: 宋体; letter-spacing: 0pt; font-size: 12pt; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;\">5. 环保和包装： 现代消费者越来越重视环保，因此，使用可持续材料和环保包装的牛奶品牌受到特别的欢迎。</span><span style=\"letter-spacing: 0pt; font-size: 12pt;\"><o:p></o:p></span></p><p class=\"MsoNormal\" align=\"justify\" style=\"margin: 0pt; text-align: justify; font-family: Calibri; font-size: 10.5pt; color: rgb(0, 0, 0); text-indent: 21pt; line-height: 21pt; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;\"><span style=\"font-family: 宋体; letter-spacing: 0pt; font-size: 12pt; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;\">在选择牛奶品牌时，消费者应考虑自己的健康需求、口味偏好以及对环保的关注。了解不同品牌的特点和价值主张可以帮助消费者做出更符合自身需求的选择。</span><span style=\"letter-spacing: 0pt; font-size: 12pt;\"><o:p></o:p></span></p>', 20, 'p', 0, '2024-05-31 06:22:15.445595', '2024-03-16 16:30:04.526055', 1, 2);
INSERT INTO `forum_article` (`id`, `title`, `slug`, `img`, `summary`, `body`, `views`, `status`, `is_top`, `update_time`, `create_time`, `author_id`, `category_id`) VALUES (5, '如何通过选择本地生产的食品支持可持续发展', 'ben-di-shi-pin-de-li-liang-ru-he-tong-guo-xuan-ze-ben-di-sheng-chan-de-shi-pin-zhi-chi-ke-chi-xu-fa-zhan', 'article/file/d84f09ef1d5e4364b42ae66d9f2763d3.jpeg', '本文探索了选择本地生产的食品对环境和社区可持续发展的积极影响。通过支持本地农场和生产商，消费者不仅可以享受到更新鲜、更健康的食品，还能减少运输食品过程中的碳排放，促进当地经济发展。文章还讨论了本地食品对保护生物多样性和维持农业生态系统平衡的重要性，鼓励读者更多地了解和选择本地食品。', '<p class=\"MsoNormal\" align=\"justify\" style=\"margin: 0pt; text-align: justify; font-family: Calibri; font-size: 10.5pt; color: rgb(0, 0, 0); text-indent: 21pt; line-height: 1.5; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;\"><span style=\"font-family: 宋体; line-height: 24px; letter-spacing: 0pt; font-size: 12pt; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;\">在全球化的今天，我们的餐桌上充斥着来自世界各地的食品。然而，这种便利背后隐藏着环境代价，包括高碳排放和生物多样性的丧失。转向本地食品不仅能够帮助减轻这些问题，还能为我们带来更健康的生活方式和更强大的社区。</span></p><p class=\"MsoNormal\" align=\"justify\" style=\"margin: 0pt; text-align: justify; font-family: Calibri; font-size: 10.5pt; color: rgb(0, 0, 0); text-indent: 21pt; line-height: 1.5; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;\"><span style=\"line-height: 24px; letter-spacing: 0pt; font-size: 12pt;\"><o:p></o:p></span></p><p class=\"MsoNormal\" align=\"justify\" style=\"margin: 0pt; text-align: justify; font-family: Calibri; font-size: 10.5pt; color: rgb(0, 0, 0); text-indent: 21pt; line-height: 21px; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;\"><span style=\"font-family: 宋体; line-height: 24px; letter-spacing: 0pt; font-size: 12pt; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;\"><font face=\"宋体\">选择本地食品的好处</font><font face=\"宋体\">:</font></span><span style=\"line-height: 24px; letter-spacing: 0pt; font-size: 12pt;\"><o:p></o:p></span></p><p class=\"MsoNormal\" align=\"justify\" style=\"margin: 0pt; text-align: justify; font-family: Calibri; font-size: 10.5pt; color: rgb(0, 0, 0); text-indent: 21pt; line-height: 21px; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;\"><span style=\"font-family: 宋体; line-height: 24px; letter-spacing: 0pt; font-size: 12pt; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;\">1.&nbsp;环境可持续性：本地食品的运输距离短，因此产生的碳足迹较小。此外，本地农场往往采用更可持续的农业实践，有助于保护土壤和水资源。</span></p><p class=\"MsoNormal\" align=\"justify\" style=\"margin: 0pt; text-align: justify; font-family: Calibri; font-size: 10.5pt; color: rgb(0, 0, 0); text-indent: 21pt; line-height: 21px; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;\"><span style=\"line-height: 24px; letter-spacing: 0pt; font-size: 12pt;\"><o:p></o:p></span></p><p class=\"MsoNormal\" align=\"justify\" style=\"margin: 0pt; text-align: justify; font-family: Calibri; font-size: 10.5pt; color: rgb(0, 0, 0); text-indent: 21pt; line-height: 21px; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;\"><span style=\"font-family: 宋体; line-height: 24px; letter-spacing: 0pt; font-size: 12pt; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;\">2.&nbsp;新鲜度和营养价值：本地食品通常在收获后不久就会被消费，这意味着它们更新鲜，营养保持得也更好。</span></p><p class=\"MsoNormal\" align=\"justify\" style=\"margin: 0pt; text-align: justify; font-family: Calibri; font-size: 10.5pt; color: rgb(0, 0, 0); text-indent: 21pt; line-height: 21px; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;\"><span style=\"line-height: 24px; letter-spacing: 0pt; font-size: 12pt;\"><o:p></o:p></span></p><p class=\"MsoNormal\" align=\"justify\" style=\"margin: 0pt; text-align: justify; font-family: Calibri; font-size: 10.5pt; color: rgb(0, 0, 0); text-indent: 21pt; line-height: 21px; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;\"><span style=\"font-family: 宋体; line-height: 24px; letter-spacing: 0pt; font-size: 12pt; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;\">3.&nbsp;支持当地经济：购买本地食品直接支持本地农民和生产者，有助于增强当地经济，创造就业机会。</span></p><p class=\"MsoNormal\" align=\"justify\" style=\"margin: 0pt; text-align: justify; font-family: Calibri; font-size: 10.5pt; color: rgb(0, 0, 0); text-indent: 21pt; line-height: 21px; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;\"><span style=\"line-height: 24px; letter-spacing: 0pt; font-size: 12pt;\"><o:p></o:p></span></p><p class=\"MsoNormal\" align=\"justify\" style=\"margin: 0pt; text-align: justify; font-family: Calibri; font-size: 10.5pt; color: rgb(0, 0, 0); text-indent: 21pt; line-height: 21px; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;\"><span style=\"font-family: 宋体; line-height: 24px; letter-spacing: 0pt; font-size: 12pt; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;\">4.&nbsp;促进社区联系：通过本地市场和农场，消费者可以直接与食品生产者交流，增强社区内的联系和互动。</span></p><p class=\"MsoNormal\" align=\"justify\" style=\"margin: 0pt; text-align: justify; font-family: Calibri; font-size: 10.5pt; color: rgb(0, 0, 0); text-indent: 21pt; line-height: 21px; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;\"><span style=\"line-height: 24px; letter-spacing: 0pt; font-size: 12pt;\"><o:p></o:p></span></p><p class=\"MsoNormal\" align=\"justify\" style=\"margin: 0pt; text-align: justify; font-family: Calibri; font-size: 10.5pt; color: rgb(0, 0, 0); text-indent: 21pt; line-height: 21px; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;\"><span style=\"font-family: 宋体; line-height: 24px; letter-spacing: 0pt; font-size: 12pt; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;\">尽管选择本地食品有诸多好处，但也存在一些挑战，如价格可能高于大规模生产的食品，以及可获得性的季节性变化。然而，通过计划性购买和利用季节性食物，这些挑战是可以克服的。</span></p><p class=\"MsoNormal\" align=\"justify\" style=\"margin: 0pt; text-align: justify; font-family: Calibri; font-size: 10.5pt; color: rgb(0, 0, 0); text-indent: 21pt; line-height: 21px; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;\"><span style=\"line-height: 24px; letter-spacing: 0pt; font-size: 12pt;\"><o:p></o:p></span></p><p class=\"MsoNormal\" align=\"justify\" style=\"margin: 0pt; text-align: justify; font-family: Calibri; font-size: 10.5pt; color: rgb(0, 0, 0); text-indent: 21pt; line-height: 21px; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;\"><span style=\"font-family: 宋体; line-height: 24px; letter-spacing: 0pt; font-size: 12pt; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;\">鼓励消费者了解本地食品来源，参与当地食品系统，不仅有助于个人健康，也是对全球环境责任的体现。选择本地食品，我们每个人都能为推动可持续发展做出贡献。</span><span style=\"line-height: 24px; letter-spacing: 0pt; font-size: 12pt;\"><o:p></o:p></span></p><p class=\"MsoNormal\" style=\"margin: 0pt 0pt 0.0001pt; text-align: justify; font-family: Calibri; font-size: 10.5pt; color: rgb(0, 0, 0); line-height: 21px;\"><span style=\"line-height: 24px; font-size: 12pt;\">&nbsp;</span></p>', 37, 'p', 0, '2024-06-01 21:45:28.340694', '2024-03-16 16:30:31.183405', 1, 3);
INSERT INTO `forum_article` (`id`, `title`, `slug`, `img`, `summary`, `body`, `views`, `status`, `is_top`, `update_time`, `create_time`, `author_id`, `category_id`) VALUES (6, '源自大地恩惠的健康秘诀', 'yuan-zi-da-di-en-hui-de-jian-kang-mi-jue', 'article/file/f03805faa75249ef9165c6397166bbc8.jpeg', '大家都认识羽衣甘蓝吗?羽衣甘蓝属于绿黄色蔬菜,均衡地富含了维生素、矿物质、膳食纤维等现代人缺乏的营养素,所以又被称为“蔬菜之王”。', '<p><span style=\"font-family: 微软雅黑, 宋体, serif; font-size: 16px;\">&nbsp; &nbsp; 大家都认识羽衣甘蓝吗?羽衣甘蓝属于绿黄色蔬菜,均衡地富含了维生素、矿物质、膳食纤维等现代人缺乏的营养素,所以又被称为“蔬菜之王”。</span></p><p><span style=\"font-family: 微软雅黑, 宋体, serif; font-size: 16px;\">　近年来,人们发现羽衣甘蓝中含有GABA,这种成分具有降低高血压的功效。 GABA 是一种称为γ-氨基丁酸的氨基酸,存在于蔬菜和糙米中。然而,在保健食品中,通常添加的是通过发酵方法工业生产的GABA。因此,多年来一直研究香料和香草等各种食品的日本爱思必食品株式会社,利用其技术和经验,开发了边补充营养边降血压的新概念青汁,名为“100%有机羽衣甘蓝青汁粉”。该产品在日本获得了机能性表示食品的认证,这表明它具有特定的健康作用。 *机能性表示食品是日本独有的认证,允许食品被标记为具有特定的健康目的。与声称具有保健功效的食品不同,它们并不是用来治疗或预防疾病的。</span></p><p><span style=\"font-family: 微软雅黑, 宋体, serif; font-size: 16px;\">　爱思必食品株式会社作为一家拥有100多年历史的食品制造商,除了是日本第一家成功制造出咖喱粉的公司外,本着“给每个家庭带来自然和幸福的生活。”的企业理念,他们的芥末和咖喱等香料相关产品也已经走进日本和世界各地的餐桌上。 “一直以来,我们在追求美味的同时,也希望支持人们的健康,所以我们也正专注于健康食品的研发。 ”该公司的产品研发负责人中村先生说道。</span></p><p><span style=\"font-family: 微软雅黑, 宋体, serif; font-size: 16px;\">　据了解,通过与不使用农药和化肥的有机JAS认证指定农场签约,并且仅使用了冬季收获的羽衣甘蓝,才能够制作出即使没有添加任何多余原料却也营养丰富,味道甘甜,易于饮用的“100%羽衣甘蓝青汁粉”。在制作方法上也有讲究。通过将生鲜羽衣甘蓝仔细干燥后直接使用微粉碎技术,最大程度的保留了生鲜羽衣甘蓝的营养成分。由于不是榨汁,因此也可期待从中摄取到果汁中不含有的不溶性膳食纤维。</span></p><p><span style=\"font-family: 微软雅黑, 宋体, serif; font-size: 16px;\">　现代的中国在饮食结果上发生了不少变化,笔者认为油的摄取过多和蔬菜的摄取不足是大多数人常有的问题。随之而来的是生活习惯病等各种健康风险的增加。现在,爱思必株式会社的“100% 有机羽衣甘蓝青汁粉”已进驻国内电商。何不试着在日常膳食中融入“100% 有机羽衣甘蓝青汁粉”,轻松管理您与家人的营养补充和健康呢?</span><span style=\"font-family: 微软雅黑, 宋体, serif; font-size: 16px;\"><br></span><span style=\"font-family: 微软雅黑, 宋体, serif; font-size: 16px;\"><br></span><span style=\"font-family: 微软雅黑, 宋体, serif; font-size: 16px;\"><br></span><span style=\"font-family: 微软雅黑, 宋体, serif; font-size: 16px;\"><br></span><br></p>', 32, 'p', 0, '2024-06-01 18:58:59.252289', '2024-03-22 10:49:07.571735', 1, 4);
INSERT INTO `forum_article` (`id`, `title`, `slug`, `img`, `summary`, `body`, `views`, `status`, `is_top`, `update_time`, `create_time`, `author_id`, `category_id`) VALUES (7, '萃茶拾光《追光吧哥哥》人气IP奶茶，get明星同款奶茶', 'cui-cha-shi-guang-zhui-guang-ba-ge-ge-ren-qi-ipnai-cha-getming-xing-tong-kuan-nai-cha', 'article/file/f589666115434bd182e1a1ffc4c99ba2.png', '追光而上，寸步不让。是萃茶拾光与《追光吧哥哥》对于目标一致的追求。最近爆火的综艺《追光吧哥哥》为影视行业带来一股热流，一群不服输的男人，用他们的汗水，向世人展示男性在这个时代应有的态度。三代男性艺人汇聚在同一档综艺节目中，为“追光”写下最有力的注解。萃茶拾光奶茶与《追光吧哥哥》破界合作，萃茶拾光，不断追光。', '<p><span style=\"font-family: 微软雅黑, 宋体, serif; font-size: 16px;\">&nbsp; &nbsp; &nbsp; &nbsp; 萃茶拾光，不避锋芒。萃茶拾光与《追光吧哥哥》的合作实现跨越屏幕的品牌破圈，用综艺发声，对上Z时代的精神频道，不断迎接新的机遇与挑战。萃茶拾光奶茶精选优质高山茶，低温萃茶技术、资深供应商原料支持，一站式把控，做高品质奶茶坚持者。</span><br></p><p style=\"padding: 5px 0px; margin-bottom: 0px; font-family: 微软雅黑, 宋体, serif; font-size: 16px;\">　　强强联合，萃茶拾光坚持原叶萃茶工艺，将中国传统茶文化与现代制茶技术相结合，严选用料，给予消费者全新的茶饮体验。秉承茶人本心，重塑中国茶饮新定义，创造具有“萃茶拾光”品牌个性的匠心茶饮。《追光吧哥哥》一经播出，网络话题阅读量近50亿，讨论量近600万，平台收视率同期第二，吸引了一批忠实的观众和流量。2021年，萃茶拾光与《追光吧哥哥》强强联合，借流量之势，成为助力2021茶饮市场发展的重要一员。</p><p style=\"padding: 5px 0px; margin-bottom: 0px; font-family: 微软雅黑, 宋体, serif; font-size: 16px;\">　　在定位上，《追光吧哥哥》的目标人群是70/80/90的女性观众，而萃茶拾光产品的受众是80/90/00的女性，目标人群有大部分重合，也可以实现宣传效果的最大化。</p><p style=\"padding: 5px 0px; margin-bottom: 0px; font-family: 微软雅黑, 宋体, serif; font-size: 16px;\">　　萃茶拾光在产品优势上，以谷物小料入茶，做有料的奶茶青年。萃茶拾光采用藜麦、燕麦、血糯米、薏仁等天然谷物入茶。对于小料的选择上，不仅仅有市面上常规的小料更有银耳、布蕾、南瓜、酒酿等新奇小料，在加料上更具趣味性和灵活性。下面就来介绍一下萃茶拾光的一些主打产品的选料和口味。</p><p style=\"padding: 5px 0px; margin-bottom: 0px; font-family: 微软雅黑, 宋体, serif; font-size: 16px;\">&nbsp; &nbsp; &nbsp; &nbsp; 勇敢“追光”， 萃茶拾光和《追光吧哥哥》破壁合作，同时与19家卫视达成战略合作，展播品牌稳收黄金流量。与《乘风波浪的姐姐》联合推广，借助节目的热度让更多人的知道萃茶拾光，观众变顾客，把高品质的健康奶茶推向更加大的市场。<br></p>', 66, 'p', 0, '2024-06-02 10:47:21.639441', '2024-03-22 10:54:21.861439', 2, 5);
INSERT INTO `forum_article` (`id`, `title`, `slug`, `img`, `summary`, `body`, `views`, `status`, `is_top`, `update_time`, `create_time`, `author_id`, `category_id`) VALUES (8, '强势曝光！这家欧扎克宝藏麦片藏不住了', 'qiang-shi-pu-guang-zhe-jia-ou-zha-ke-bao-cang-mai-pian-cang-bu-zhu-liao', 'article/file/238b72ed61244b52822b256bffc76ee9.png', '最近刮起了一阵吃麦片的大风潮,要低脂又要能量,要瘦身也要健康的小姐姐小哥哥们纷纷抛弃了豆浆油条,投向香喷喷的麦片,这家高营养巨美味的欧扎克麦片再也藏不住了,好评不断,月销过万,明星力推,火的不要不要的!', '<p style=\"padding: 5px 0px; margin-bottom: 0px; font-family: 微软雅黑, 宋体, serif; font-size: 16px;\">&nbsp; &nbsp; &nbsp; &nbsp; 健康营养。欧扎克麦片是来自澳洲阳光维度带麦源,是一款全天然材料的麦片,并且欧扎克现已通过ISO 9001 质量管理体系认证,ISO 22000 食品安全管理体系认证,HACCP 危害分析与关键控制点体系认证,是全家人都可以安全食用的麦片!欧扎克麦片不含防腐剂和色素,而且是低糖食品,能为瘦身和运动达人提供所需能量。澳大利亚是得天独厚的乳制品生产国,严监管和高标准的生产使得麦片成为世界闻名的营养早餐,各个国家的新中产都倾向于开始用健康麦片做早餐,打开各类健身、养生达人的ins、微博,更是清一色的麦片早餐。这款麦片口感是松松脆脆的,还带着一丝香甜,不会很腻又增加了麦片的口感,減少了传统麦片干巴巴的感觉,营养价值十分丰富,低卡低热量!</p><p style=\"padding: 5px 0px; margin-bottom: 0px; font-family: 微软雅黑, 宋体, serif; font-size: 16px;\">　&nbsp; &nbsp;有颜有料。作为一个“选择困难症外加什么都想要”患者,每次选择欧扎克家的产品,都是要抓毛的节奏,因为口味和款式实在是太多了,每一样看起来都很不错!!如果你原味麦片吃够的话,就选欧扎克水果麦片吧,酸奶果粒麦片、小麦薄脆麦片、玫瑰草莓坚果麦片、可可坚果麦片、榴莲椰脆坚果麦片……小孩子才做选择,这些我们都要了!欧扎克麦片配料也超足超实诚,除了香脆饱满的麦片和酸奶块,还有各种水果坚果,蓝莓、蔓越莓干、提子干、椰子片、扁桃仁、南瓜籽仁、腰果、榛子……正因为它包含的食物品种很多,所以颜色形状特别上镜,随便加点酸奶、水果什么的,不用滤镜都自带格调,满满的包装,真的看了就心动,老少皆宜家庭必备。</p><p style=\"padding: 5px 0px; margin-bottom: 0px; font-family: 微软雅黑, 宋体, serif; font-size: 16px;\">&nbsp; &nbsp; &nbsp; &nbsp;方便快捷。欧扎克水果麦片营养全面,开袋后扑鼻而来可以闻到麦片的甜味,这种甜味不是那种香精堆砌起来甜到齁鼻的感觉,而是比较诱人食欲的自然甜香味。干吃的话可以直接尝到酥脆的麦片混合水果干后的嚼劲和层次感,是最佳的看剧零食。又能加牛奶当营养早餐,泡上牛奶后刚好中和了麦片的甜味,也给牛奶增加多了燕麦香气。还可以在基础的燕麦上增加其他配料,采取多种做法,在赶走饥饿感的同时走花路!</p><p style=\"padding: 5px 0px; margin-bottom: 0px; font-family: 微软雅黑, 宋体, serif; font-size: 16px;\">&nbsp; &nbsp; &nbsp; &nbsp;选择欧扎克,让你变瘦、变美、变健康!</p>', 612, 'p', 0, '2024-06-04 09:12:08.373490', '2024-03-22 15:25:50.578900', 2, 1);
INSERT INTO `forum_article` (`id`, `title`, `slug`, `img`, `summary`, `body`, `views`, `status`, `is_top`, `update_time`, `create_time`, `author_id`, `category_id`) VALUES (9, '我爱奥利奥饼干', '1-1', 'article/file/c8d267f0e03e40c8a0006b9be7567c6f.png', '奥利奥饼干是一种风靡全球的甜点，由两片巧克力味的饼干和夹心的白色奶油构成。', '<p><span style=\"color: rgb(13, 13, 13); font-family: Söhne, ui-sans-serif, system-ui, -apple-system, &quot;Segoe UI&quot;, Roboto, Ubuntu, Cantarell, &quot;Noto Sans&quot;, sans-serif, &quot;Helvetica Neue&quot;, Arial, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;, &quot;Noto Color Emoji&quot;; font-size: 16px; white-space-collapse: preserve;\">这种饼干最初由纳贝斯科公司于1912年在美国推出，很快就成为了家喻户晓的零食。奥利奥饼干的特点是口感丰富，既可以直接食用，也可以浸泡在牛奶中享用，使其变得柔软，口感更佳。此外，奥利奥还经常被用作其他甜品的配料，如冰淇淋、奶昔和蛋糕等，增添了无穷的风味和乐趣。奥利奥不仅仅是一种饼干，它已经成为了一种文化象征，激发了无数美食创意和甜蜜的回忆。</span></p><p><span style=\"color: rgb(13, 13, 13); font-family: Söhne, ui-sans-serif, system-ui, -apple-system, &quot;Segoe UI&quot;, Roboto, Ubuntu, Cantarell, &quot;Noto Sans&quot;, sans-serif, &quot;Helvetica Neue&quot;, Arial, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;, &quot;Noto Color Emoji&quot;; font-size: 16px; white-space-collapse: preserve;\"><br></span><span style=\"color: rgb(13, 13, 13); font-family: Söhne, ui-sans-serif, system-ui, -apple-system, &quot;Segoe UI&quot;, Roboto, Ubuntu, Cantarell, &quot;Noto Sans&quot;, sans-serif, &quot;Helvetica Neue&quot;, Arial, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;, &quot;Noto Color Emoji&quot;; font-size: 16px; white-space-collapse: preserve;\">奥利奥饼干不仅仅是一种普通的饼干，它已经成为了全球甜点文化的一个重要标志。自1912年由美国的纳贝斯科公司首次推出以来，这种独特的黑白夹心饼干迅速风靡全球，成为许多人心中不可或缺的甜点选择。</span></p><p><span style=\"color: rgb(13, 13, 13); font-family: Söhne, ui-sans-serif, system-ui, -apple-system, &quot;Segoe UI&quot;, Roboto, Ubuntu, Cantarell, &quot;Noto Sans&quot;, sans-serif, &quot;Helvetica Neue&quot;, Arial, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;, &quot;Noto Color Emoji&quot;; font-size: 16px; white-space-collapse: preserve;\"><br></span><span style=\"color: rgb(13, 13, 13); font-family: Söhne, ui-sans-serif, system-ui, -apple-system, &quot;Segoe UI&quot;, Roboto, Ubuntu, Cantarell, &quot;Noto Sans&quot;, sans-serif, &quot;Helvetica Neue&quot;, Arial, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;, &quot;Noto Color Emoji&quot;; font-size: 16px; white-space-collapse: preserve;\">奥利奥的独特之处在于其结构：两片圆形的巧克力饼干夹着一层细腻的奶油。这种简单而经典的组合，不仅味道丰富，还带来了独特的口感体验。饼干本身采用的是巧克力味道，略带些许苦味，与中间的甜奶油形成了完美的味觉平衡，这种对比也正是奥利奥吸引人的地方之一。</span></p><p><span style=\"color: rgb(13, 13, 13); font-family: Söhne, ui-sans-serif, system-ui, -apple-system, &quot;Segoe UI&quot;, Roboto, Ubuntu, Cantarell, &quot;Noto Sans&quot;, sans-serif, &quot;Helvetica Neue&quot;, Arial, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;, &quot;Noto Color Emoji&quot;; font-size: 16px; white-space-collapse: preserve;\"><br></span><span style=\"color: rgb(13, 13, 13); font-family: Söhne, ui-sans-serif, system-ui, -apple-system, &quot;Segoe UI&quot;, Roboto, Ubuntu, Cantarell, &quot;Noto Sans&quot;, sans-serif, &quot;Helvetica Neue&quot;, Arial, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;, &quot;Noto Color Emoji&quot;; font-size: 16px; white-space-collapse: preserve;\">奥利奥饼干的食用方式多样，可以直接食用，也可以将饼干分开，先舔食中间的奶油，再享用饼干。此外，许多人喜欢将奥利奥浸泡在牛奶中，待饼干吸饱牛奶变得柔软后再食用，这种方式可以让饼干的口感更加细腻，奶油的味道也更加浓郁。</span></p><p><span style=\"color: rgb(13, 13, 13); font-family: Söhne, ui-sans-serif, system-ui, -apple-system, &quot;Segoe UI&quot;, Roboto, Ubuntu, Cantarell, &quot;Noto Sans&quot;, sans-serif, &quot;Helvetica Neue&quot;, Arial, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;, &quot;Noto Color Emoji&quot;; font-size: 16px; white-space-collapse: preserve;\"><br></span><span style=\"color: rgb(13, 13, 13); font-family: Söhne, ui-sans-serif, system-ui, -apple-system, &quot;Segoe UI&quot;, Roboto, Ubuntu, Cantarell, &quot;Noto Sans&quot;, sans-serif, &quot;Helvetica Neue&quot;, Arial, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;, &quot;Noto Color Emoji&quot;; font-size: 16px; white-space-collapse: preserve;\">除了直接食用，奥利奥也常常被用作其他甜品的材料。例如，在制作奶昔时添加几片奥利奥饼干，可以让奶昔拥有浓郁的巧克力味和奶油味，口感更加丰富。奥利奥冰淇淋和奥利奥蛋糕也是深受欢迎的变体，这些甜品将奥利奥的风味发挥到了极致。</span></p><p><span style=\"color: rgb(13, 13, 13); font-family: Söhne, ui-sans-serif, system-ui, -apple-system, &quot;Segoe UI&quot;, Roboto, Ubuntu, Cantarell, &quot;Noto Sans&quot;, sans-serif, &quot;Helvetica Neue&quot;, Arial, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;, &quot;Noto Color Emoji&quot;; font-size: 16px; white-space-collapse: preserve;\"><br></span><span style=\"color: rgb(13, 13, 13); font-family: Söhne, ui-sans-serif, system-ui, -apple-system, &quot;Segoe UI&quot;, Roboto, Ubuntu, Cantarell, &quot;Noto Sans&quot;, sans-serif, &quot;Helvetica Neue&quot;, Arial, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;, &quot;Noto Color Emoji&quot;; font-size: 16px; white-space-collapse: preserve;\">在全球范围内，奥利奥还推出了多种口味的变种，如双层奶油、花生酱、薄荷味等，这些新口味的推出满足了不同消费者的口味需求，使品牌保持了持续的活力和市场竞争力。此外，奥利奥在不同的地区还推出了符合当地风味的特殊版，如在中国市场推出的绿茶味奥利奥，都极大地丰富了奥利奥的产品线，并吸引了更多的消费者。</span></p><p><span style=\"color: rgb(13, 13, 13); font-family: Söhne, ui-sans-serif, system-ui, -apple-system, &quot;Segoe UI&quot;, Roboto, Ubuntu, Cantarell, &quot;Noto Sans&quot;, sans-serif, &quot;Helvetica Neue&quot;, Arial, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;, &quot;Noto Color Emoji&quot;; font-size: 16px; white-space-collapse: preserve;\"><br></span><span style=\"color: rgb(13, 13, 13); font-family: Söhne, ui-sans-serif, system-ui, -apple-system, &quot;Segoe UI&quot;, Roboto, Ubuntu, Cantarell, &quot;Noto Sans&quot;, sans-serif, &quot;Helvetica Neue&quot;, Arial, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;, &quot;Noto Color Emoji&quot;; font-size: 16px; white-space-collapse: preserve;\">奥利奥饼干不只是一种美味的零食，它已经成为了一个文化现象，无论是在电影、电视节目中的出现，还是在社交媒体上的各种创意食谱分享，奥利奥都以其独特的魅力赢得了全球范围内消费者的喜爱和追随。这种从一种简单的饼干演变为全球文化象征的过程，证明了奥利奥不仅仅是食品产业的一个成功案例，更是一个品牌传播和市场营销的典范。</span></p><p><br></p>', 22, 'd', 0, '2024-04-17 15:11:45.199590', '2024-04-17 01:32:21.983895', 2, 2);
INSERT INTO `forum_article` (`id`, `title`, `slug`, `img`, `summary`, `body`, `views`, `status`, `is_top`, `update_time`, `create_time`, `author_id`, `category_id`) VALUES (10, '绿色蔬菜：健康饮食的基石', '3', 'article/file/46365fb5d1ce4eaaba176305ce3c007f.jpeg', '绿色蔬菜是一类富含必需营养素的食物，对维持健康和预防疾病具有至关重要的作用。它们不仅颜色诱人、口感多样，而且营养价值高，是每个人饮食中不可或缺的部分。', '<p><span style=\"color: rgb(13, 13, 13); font-family: Söhne, ui-sans-serif, system-ui, -apple-system, &quot;Segoe UI&quot;, Roboto, Ubuntu, Cantarell, &quot;Noto Sans&quot;, sans-serif, &quot;Helvetica Neue&quot;, Arial, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;, &quot;Noto Color Emoji&quot;; font-size: 16px; white-space-collapse: preserve;\">绿色蔬菜包括一系列广泛的植物，如菠菜、西兰花、青椒和甘蓝等。这些蔬菜的共同特点是它们含有丰富的维生素和矿物质，如维生素A、C，以及铁、钾和钙。这些营养素对于增强免疫系统、维护视力和骨骼健康、以及促进血液循环等都有极好的效果。</span></p><p><span style=\"color: rgb(13, 13, 13); font-family: Söhne, ui-sans-serif, system-ui, -apple-system, &quot;Segoe UI&quot;, Roboto, Ubuntu, Cantarell, &quot;Noto Sans&quot;, sans-serif, &quot;Helvetica Neue&quot;, Arial, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;, &quot;Noto Color Emoji&quot;; font-size: 16px; white-space-collapse: preserve;\">此外，绿色蔬菜还富含抗氧化剂，特别是各种类黄酮和硫化物，这些化合物能帮助身体抵御自由基的损害，降低患慢性疾病如心脏病和某些类型癌症的风险。常见的绿色蔬菜，如羽衣甘蓝和西兰花，就是这类营养成分的优良来源。</span></p><p><span style=\"color: rgb(13, 13, 13); font-family: Söhne, ui-sans-serif, system-ui, -apple-system, &quot;Segoe UI&quot;, Roboto, Ubuntu, Cantarell, &quot;Noto Sans&quot;, sans-serif, &quot;Helvetica Neue&quot;, Arial, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;, &quot;Noto Color Emoji&quot;; font-size: 16px; white-space-collapse: preserve;\">绿色蔬菜不仅健康，其烹饪方式也十分多样。它们可以生食，如制作沙拉，也可以通过蒸、炒、烤等方式烹调。这种灵活性使得绿色蔬菜能够轻松融入日常饮食中，丰富我们的餐桌。例如，一份炒菠菜可以作为快速晚餐的一部分，既简单又营养；而西兰花搭配轻奶酪则可以作为一道美味的低脂肪主菜。</span></p><p><span style=\"color: rgb(13, 13, 13); font-family: Söhne, ui-sans-serif, system-ui, -apple-system, &quot;Segoe UI&quot;, Roboto, Ubuntu, Cantarell, &quot;Noto Sans&quot;, sans-serif, &quot;Helvetica Neue&quot;, Arial, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;, &quot;Noto Color Emoji&quot;; font-size: 16px; white-space-collapse: preserve;\">在现代快节奏的生活中，保持均衡的饮食越来越显得重要。绿色蔬菜因其低热量和高纤维的特性，非常适合那些寻求健康生活方式的人群。食用足够的绿色蔬菜有助于控制体重、提高饱腹感，同时还能提供身体运作所需的关键营养。</span></p><p><span style=\"color: rgb(13, 13, 13); font-family: Söhne, ui-sans-serif, system-ui, -apple-system, &quot;Segoe UI&quot;, Roboto, Ubuntu, Cantarell, &quot;Noto Sans&quot;, sans-serif, &quot;Helvetica Neue&quot;, Arial, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, &quot;Segoe UI Symbol&quot;, &quot;Noto Color Emoji&quot;; font-size: 16px; white-space-collapse: preserve;\">总结来说，绿色蔬菜不仅是健康饮食的重要组成部分，也是维护全身健康的基石。它们的多功能性和营养价值使其成为任何健康饮食计划中不可或缺的元素。无论是作为主菜还是配菜，绿色蔬菜都能为我们的饮食增添色彩和活力，同时带来深远的健康益处。</span><br></p>', 29, 'r', 0, '2024-04-17 16:30:35.019738', '2024-04-17 01:33:01.252621', 2, 3);
INSERT INTO `forum_article` (`id`, `title`, `slug`, `img`, `summary`, `body`, `views`, `status`, `is_top`, `update_time`, `create_time`, `author_id`, `category_id`) VALUES (11, '探索超级食物：营养丰富的食品对健康的影响', 'tan-suo-chao-ji-shi-wu-ying-yang-feng-fu-de-shi-pin-dui-jian-kang-de-ying-xiang-1', 'article/file/673bd76440bc4b04b566bd06b18dc511.jpeg', '本文深入探讨了所谓的\"超级食物\"及其对人体健康的积极影响。超级食物通常指那些富含维生素、矿物质、抗氧化剂和其他营养成分的食品，它们对于提高免疫力、预防疾病、改善心血管健康等方面有着显著的好处。文章通过列举几种典型的超级食物，如蓝莓、绿茶、鲑鱼等，展示了它们的营养价值和对健康的潜在益处，鼓励读者将这些食物纳入日常饮食中。', '<p class=\"MsoNormal\" align=\"justify\" style=\"margin: 0pt; font-size: 10.5pt; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; text-align: justify; font-family: Calibri; color: rgb(0, 0, 0); text-indent: 21pt; line-height: 21px;\"><span style=\"font-family: 宋体; line-height: 24px; letter-spacing: 0pt; font-size: 12pt; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;\"><font face=\"宋体\">在健康和营养领域，</font><font face=\"宋体\">\"超级食物\"一词越来越流行。它指的是那些营养密度高，对健康特别有益的食品。尽管没有官方的定义，但超级食物通常富含对人体有益的维生素、矿物质、抗氧化剂、纤维和其他营养成分。这些食物的健康益处范围广泛，从提高免疫力到预防慢性疾病等等。</font></span><span style=\"line-height: 24px; letter-spacing: 0pt; font-size: 12pt;\"><o:p></o:p></span></p><p class=\"MsoNormal\" align=\"justify\" style=\"margin: 0pt; font-size: 10.5pt; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; text-align: justify; font-family: Calibri; color: rgb(0, 0, 0); text-indent: 21pt; line-height: 21px;\"><span style=\"font-family: 宋体; line-height: 24px; letter-spacing: 0pt; font-size: 12pt; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;\"><font face=\"宋体\">蓝莓：被广泛认为是超级食物的典范，富含维生素</font><font face=\"宋体\">C和K，以及纤维和抗氧化剂。研究表明，蓝莓有助于心脏健康，改善记忆力和认知功能，甚至可能有助于对抗某些类型的癌症。</font></span><span style=\"line-height: 24px; letter-spacing: 0pt; font-size: 12pt;\"><o:p></o:p></span></p><p class=\"MsoNormal\" align=\"justify\" style=\"margin: 0pt; font-size: 10.5pt; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; text-align: justify; font-family: Calibri; color: rgb(0, 0, 0); text-indent: 21pt; line-height: 21px;\"><span style=\"font-family: 宋体; line-height: 24px; letter-spacing: 0pt; font-size: 12pt; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;\">绿茶：是另一种超级食物，富含强大的抗氧化剂，如儿茶素，有助于减少炎症和预防癌症。绿茶还被认为可以促进心脏健康，提高脂肪燃烧速度，从而有助于体重管理。</span><span style=\"line-height: 24px; letter-spacing: 0pt; font-size: 12pt;\"><o:p></o:p></span></p><p class=\"MsoNormal\" align=\"justify\" style=\"margin: 0pt; font-size: 10.5pt; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; text-align: justify; font-family: Calibri; color: rgb(0, 0, 0); text-indent: 21pt; line-height: 21px;\"><span style=\"font-family: 宋体; line-height: 24px; letter-spacing: 0pt; font-size: 12pt; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;\"><font face=\"宋体\">鲑鱼：是一种富含</font><font face=\"宋体\">omega-3脂肪酸的超级食物，对心脏健康特别有益。Omega-3可以帮助降低血压，减少心脏病发作的风险，并改善大脑健康。</font></span><span style=\"line-height: 24px; letter-spacing: 0pt; font-size: 12pt;\"><o:p></o:p></span></p><p class=\"MsoNormal\" align=\"justify\" style=\"margin: 0pt; font-size: 10.5pt; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; text-align: justify; font-family: Calibri; color: rgb(0, 0, 0); text-indent: 21pt; line-height: 21px;\"><span style=\"font-family: 宋体; line-height: 24px; letter-spacing: 0pt; font-size: 12pt; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;\">除了这些，还有许多其他食物也被认为是超级食物，如菠菜、坚果、种子、大蒜和番茄等。将这些食物纳入日常饮食，可以显著提高营养摄入量，促进健康和福祉。</span><span style=\"line-height: 24px; letter-spacing: 0pt; font-size: 12pt;\"><o:p></o:p></span></p><p class=\"MsoNormal\" align=\"justify\" style=\"margin: 0pt; font-size: 10.5pt; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; text-align: justify; font-family: Calibri; color: rgb(0, 0, 0); text-indent: 21pt; line-height: 21px;\"><span style=\"font-family: 宋体; line-height: 24px; letter-spacing: 0pt; font-size: 12pt; background-image: initial; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial;\">然而，重要的是要记住，没有任何单一食物可以提供所有的营养需求。健康的饮食应该包括多种食物，以确保获得各种营养素。最终，超级食物可以是营养丰富饮食的一部分，但平衡饮食和健康的生活方式才是关键。</span><span style=\"line-height: 24px; letter-spacing: 0pt; font-size: 12pt;\"><o:p></o:p></span></p><p class=\"MsoNormal\" style=\"margin: 0pt 0pt 0.0001pt; font-size: 10.5pt; text-align: justify; font-family: Calibri; color: rgb(0, 0, 0); line-height: 21px;\"><span style=\"line-height: 24px; font-size: 12pt;\">&nbsp;</span></p>', 1, 'r', 0, '2024-04-24 14:47:19.293681', '2024-04-24 14:47:19.293708', 2, 4);
INSERT INTO `forum_article` (`id`, `title`, `slug`, `img`, `summary`, `body`, `views`, `status`, `is_top`, `update_time`, `create_time`, `author_id`, `category_id`) VALUES (12, '123', '123', 'article/file/9cece922b09542879911e7fdea06c684.JPG', '123', '<p>123123</p><p><br></p><p>213213213123</p><p> &nbsp;</p>', 0, 'r', 0, '2024-06-04 09:13:07.841281', '2024-06-04 09:13:07.839319', 8, NULL);
COMMIT;

-- ----------------------------
-- Table structure for forum_article_liked_by
-- ----------------------------
DROP TABLE IF EXISTS `forum_article_liked_by`;
CREATE TABLE `forum_article_liked_by` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `article_id` bigint NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `forum_article_liked_by_article_id_user_id_9a45a573_uniq` (`article_id`,`user_id`),
  KEY `forum_article_liked_by_user_id_d36f99af_fk_auth_user_id` (`user_id`),
  CONSTRAINT `forum_article_liked_by_article_id_8dccdb88_fk_forum_article_id` FOREIGN KEY (`article_id`) REFERENCES `forum_article` (`id`),
  CONSTRAINT `forum_article_liked_by_user_id_d36f99af_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of forum_article_liked_by
-- ----------------------------
BEGIN;
INSERT INTO `forum_article_liked_by` (`id`, `article_id`, `user_id`) VALUES (2, 2, 1);
INSERT INTO `forum_article_liked_by` (`id`, `article_id`, `user_id`) VALUES (34, 8, 1);
INSERT INTO `forum_article_liked_by` (`id`, `article_id`, `user_id`) VALUES (35, 8, 8);
COMMIT;

-- ----------------------------
-- Table structure for forum_article_voted_by
-- ----------------------------
DROP TABLE IF EXISTS `forum_article_voted_by`;
CREATE TABLE `forum_article_voted_by` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `article_id` bigint NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `forum_article_voted_by_article_id_user_id_5600f1b3_uniq` (`article_id`,`user_id`),
  KEY `forum_article_voted_by_user_id_96f28666_fk_auth_user_id` (`user_id`),
  CONSTRAINT `forum_article_voted_by_article_id_36585be1_fk_forum_article_id` FOREIGN KEY (`article_id`) REFERENCES `forum_article` (`id`),
  CONSTRAINT `forum_article_voted_by_user_id_96f28666_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of forum_article_voted_by
-- ----------------------------
BEGIN;
INSERT INTO `forum_article_voted_by` (`id`, `article_id`, `user_id`) VALUES (20, 7, 1);
INSERT INTO `forum_article_voted_by` (`id`, `article_id`, `user_id`) VALUES (19, 8, 1);
COMMIT;

-- ----------------------------
-- Table structure for forum_category
-- ----------------------------
DROP TABLE IF EXISTS `forum_category`;
CREATE TABLE `forum_category` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(10) NOT NULL,
  `slug` varchar(120) DEFAULT NULL,
  `desc` longtext,
  `order` int NOT NULL,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of forum_category
-- ----------------------------
BEGIN;
INSERT INTO `forum_category` (`id`, `name`, `slug`, `desc`, `order`, `create_time`, `update_time`) VALUES (1, '食品安全论坛', 'shi-pin-an-quan-lun-tan', '食品安全论坛', 0, '2024-05-25 16:16:15.758817', '2024-05-25 16:16:15.758849');
INSERT INTO `forum_category` (`id`, `name`, `slug`, `desc`, `order`, `create_time`, `update_time`) VALUES (2, '水果论坛', 'shui-guo-lun-tan', '水果论坛', 0, '2024-05-25 16:16:52.885701', '2024-05-25 16:16:52.885748');
INSERT INTO `forum_category` (`id`, `name`, `slug`, `desc`, `order`, `create_time`, `update_time`) VALUES (3, '酒论坛', 'jiu-lun-tan', '酒论坛', 0, '2024-05-25 16:16:58.411554', '2024-05-25 16:16:58.411614');
INSERT INTO `forum_category` (`id`, `name`, `slug`, `desc`, `order`, `create_time`, `update_time`) VALUES (4, '烟论坛', 'yan-lun-tan', '烟论坛', 0, '2024-05-25 16:17:03.623447', '2024-05-25 16:17:03.623480');
INSERT INTO `forum_category` (`id`, `name`, `slug`, `desc`, `order`, `create_time`, `update_time`) VALUES (5, '食品安全论坛', 'shi-pin-an-quan-lun-tan-1', '食品安全论坛', 0, '2024-05-25 16:17:08.968273', '2024-05-25 16:17:08.968348');
INSERT INTO `forum_category` (`id`, `name`, `slug`, `desc`, `order`, `create_time`, `update_time`) VALUES (6, '美味论坛', 'mei-wei-lun-tan', '美味论坛', 0, '2024-05-25 16:17:14.616082', '2024-05-25 16:17:14.616131');
COMMIT;

-- ----------------------------
-- Table structure for forum_comment
-- ----------------------------
DROP TABLE IF EXISTS `forum_comment`;
CREATE TABLE `forum_comment` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `body` longtext NOT NULL,
  `ip` varchar(50) DEFAULT NULL,
  `create_time` datetime(6) NOT NULL,
  `active` tinyint(1) NOT NULL,
  `article_id` bigint NOT NULL,
  `author_id` int NOT NULL,
  `parent_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `forum_comment_article_id_b032bdce_fk_forum_article_id` (`article_id`),
  KEY `forum_comment_author_id_9e60eecd_fk_auth_user_id` (`author_id`),
  KEY `forum_comment_parent_id_4c29b530_fk_forum_comment_id` (`parent_id`),
  CONSTRAINT `forum_comment_article_id_b032bdce_fk_forum_article_id` FOREIGN KEY (`article_id`) REFERENCES `forum_article` (`id`),
  CONSTRAINT `forum_comment_author_id_9e60eecd_fk_auth_user_id` FOREIGN KEY (`author_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `forum_comment_parent_id_4c29b530_fk_forum_comment_id` FOREIGN KEY (`parent_id`) REFERENCES `forum_comment` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of forum_comment
-- ----------------------------
BEGIN;
INSERT INTO `forum_comment` (`id`, `body`, `ip`, `create_time`, `active`, `article_id`, `author_id`, `parent_id`) VALUES (5, '123', '127.0.0.1', '2024-06-01 10:38:48.043486', 1, 8, 1, NULL);
INSERT INTO `forum_comment` (`id`, `body`, `ip`, `create_time`, `active`, `article_id`, `author_id`, `parent_id`) VALUES (10, '123', '127.0.0.1', '2024-06-01 10:41:56.616098', 1, 8, 1, 5);
INSERT INTO `forum_comment` (`id`, `body`, `ip`, `create_time`, `active`, `article_id`, `author_id`, `parent_id`) VALUES (11, '123', '127.0.0.1', '2024-06-01 10:42:01.574142', 1, 8, 1, 10);
INSERT INTO `forum_comment` (`id`, `body`, `ip`, `create_time`, `active`, `article_id`, `author_id`, `parent_id`) VALUES (12, '123', '127.0.0.1', '2024-06-01 10:46:59.470946', 1, 8, 1, NULL);
INSERT INTO `forum_comment` (`id`, `body`, `ip`, `create_time`, `active`, `article_id`, `author_id`, `parent_id`) VALUES (13, '123', '127.0.0.1', '2024-06-01 10:47:01.026224', 1, 8, 1, NULL);
INSERT INTO `forum_comment` (`id`, `body`, `ip`, `create_time`, `active`, `article_id`, `author_id`, `parent_id`) VALUES (14, '123', '127.0.0.1', '2024-06-04 09:12:05.474629', 1, 8, 8, NULL);
INSERT INTO `forum_comment` (`id`, `body`, `ip`, `create_time`, `active`, `article_id`, `author_id`, `parent_id`) VALUES (15, '123', '127.0.0.1', '2024-06-04 09:12:12.295192', 1, 8, 8, 14);
INSERT INTO `forum_comment` (`id`, `body`, `ip`, `create_time`, `active`, `article_id`, `author_id`, `parent_id`) VALUES (16, '123', '127.0.0.1', '2024-06-04 09:12:15.331658', 1, 8, 8, 15);
COMMIT;

-- ----------------------------
-- Table structure for user_profile
-- ----------------------------
DROP TABLE IF EXISTS `user_profile`;
CREATE TABLE `user_profile` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(120) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `wechat` varchar(50) DEFAULT NULL,
  `qq` varchar(50) DEFAULT NULL,
  `bio` longtext,
  `avatar` varchar(100) DEFAULT NULL,
  `update_time` datetime(6) NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `user_profile_user_id_8fdce8e2_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of user_profile
-- ----------------------------
BEGIN;
INSERT INTO `user_profile` (`id`, `title`, `phone`, `wechat`, `qq`, `bio`, `avatar`, `update_time`, `user_id`) VALUES (1, NULL, '18555059572', '', '', '这个人很懒，什么都没有留下', 'user/file/92659a137f5a4701a5da7d0c3a1d1c6d.JPG', '2024-09-20 22:33:27.982476', 1);
INSERT INTO `user_profile` (`id`, `title`, `phone`, `wechat`, `qq`, `bio`, `avatar`, `update_time`, `user_id`) VALUES (2, NULL, '18555059573', NULL, NULL, '这个人很懒，什么都没有留下', 'user/avatar.png', '2024-06-02 10:09:14.828115', 2);
INSERT INTO `user_profile` (`id`, `title`, `phone`, `wechat`, `qq`, `bio`, `avatar`, `update_time`, `user_id`) VALUES (4, '', '', '', '', '这个人很懒，什么都没有留下', 'user/avatar.png', '2024-06-02 10:13:04.620613', 4);
INSERT INTO `user_profile` (`id`, `title`, `phone`, `wechat`, `qq`, `bio`, `avatar`, `update_time`, `user_id`) VALUES (8, '', '', '', '', '这个人很懒，什么都没有留下', 'user/avatar.png', '2024-06-04 09:11:09.165432', 8);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
