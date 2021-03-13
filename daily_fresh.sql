/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50711
Source Host           : localhost:3306
Source Database       : daily_fresh

Target Server Type    : MYSQL
Target Server Version : 50711
File Encoding         : 65001

Date: 2021-03-13 15:50:23
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for auth_group
-- ----------------------------
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_group
-- ----------------------------

-- ----------------------------
-- Table structure for auth_group_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_group_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for auth_permission
-- ----------------------------
DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_permission
-- ----------------------------
INSERT INTO `auth_permission` VALUES ('1', 'Can add log entry', '1', 'add_logentry');
INSERT INTO `auth_permission` VALUES ('2', 'Can change log entry', '1', 'change_logentry');
INSERT INTO `auth_permission` VALUES ('3', 'Can delete log entry', '1', 'delete_logentry');
INSERT INTO `auth_permission` VALUES ('4', 'Can view log entry', '1', 'view_logentry');
INSERT INTO `auth_permission` VALUES ('5', 'Can add permission', '2', 'add_permission');
INSERT INTO `auth_permission` VALUES ('6', 'Can change permission', '2', 'change_permission');
INSERT INTO `auth_permission` VALUES ('7', 'Can delete permission', '2', 'delete_permission');
INSERT INTO `auth_permission` VALUES ('8', 'Can view permission', '2', 'view_permission');
INSERT INTO `auth_permission` VALUES ('9', 'Can add group', '3', 'add_group');
INSERT INTO `auth_permission` VALUES ('10', 'Can change group', '3', 'change_group');
INSERT INTO `auth_permission` VALUES ('11', 'Can delete group', '3', 'delete_group');
INSERT INTO `auth_permission` VALUES ('12', 'Can view group', '3', 'view_group');
INSERT INTO `auth_permission` VALUES ('13', 'Can add content type', '4', 'add_contenttype');
INSERT INTO `auth_permission` VALUES ('14', 'Can change content type', '4', 'change_contenttype');
INSERT INTO `auth_permission` VALUES ('15', 'Can delete content type', '4', 'delete_contenttype');
INSERT INTO `auth_permission` VALUES ('16', 'Can view content type', '4', 'view_contenttype');
INSERT INTO `auth_permission` VALUES ('17', 'Can add session', '5', 'add_session');
INSERT INTO `auth_permission` VALUES ('18', 'Can change session', '5', 'change_session');
INSERT INTO `auth_permission` VALUES ('19', 'Can delete session', '5', 'delete_session');
INSERT INTO `auth_permission` VALUES ('20', 'Can view session', '5', 'view_session');
INSERT INTO `auth_permission` VALUES ('21', 'Can add 用户', '6', 'add_user');
INSERT INTO `auth_permission` VALUES ('22', 'Can change 用户', '6', 'change_user');
INSERT INTO `auth_permission` VALUES ('23', 'Can delete 用户', '6', 'delete_user');
INSERT INTO `auth_permission` VALUES ('24', 'Can view 用户', '6', 'view_user');
INSERT INTO `auth_permission` VALUES ('25', 'Can add 地址', '7', 'add_address');
INSERT INTO `auth_permission` VALUES ('26', 'Can change 地址', '7', 'change_address');
INSERT INTO `auth_permission` VALUES ('27', 'Can delete 地址', '7', 'delete_address');
INSERT INTO `auth_permission` VALUES ('28', 'Can view 地址', '7', 'view_address');
INSERT INTO `auth_permission` VALUES ('29', 'Can add 商品SPU', '8', 'add_goods');
INSERT INTO `auth_permission` VALUES ('30', 'Can change 商品SPU', '8', 'change_goods');
INSERT INTO `auth_permission` VALUES ('31', 'Can delete 商品SPU', '8', 'delete_goods');
INSERT INTO `auth_permission` VALUES ('32', 'Can view 商品SPU', '8', 'view_goods');
INSERT INTO `auth_permission` VALUES ('33', 'Can add 商品', '9', 'add_goodssku');
INSERT INTO `auth_permission` VALUES ('34', 'Can change 商品', '9', 'change_goodssku');
INSERT INTO `auth_permission` VALUES ('35', 'Can delete 商品', '9', 'delete_goodssku');
INSERT INTO `auth_permission` VALUES ('36', 'Can view 商品', '9', 'view_goodssku');
INSERT INTO `auth_permission` VALUES ('37', 'Can add 商品种类', '10', 'add_goodstype');
INSERT INTO `auth_permission` VALUES ('38', 'Can change 商品种类', '10', 'change_goodstype');
INSERT INTO `auth_permission` VALUES ('39', 'Can delete 商品种类', '10', 'delete_goodstype');
INSERT INTO `auth_permission` VALUES ('40', 'Can view 商品种类', '10', 'view_goodstype');
INSERT INTO `auth_permission` VALUES ('41', 'Can add 主页促销活动', '11', 'add_indexpromotionbanner');
INSERT INTO `auth_permission` VALUES ('42', 'Can change 主页促销活动', '11', 'change_indexpromotionbanner');
INSERT INTO `auth_permission` VALUES ('43', 'Can delete 主页促销活动', '11', 'delete_indexpromotionbanner');
INSERT INTO `auth_permission` VALUES ('44', 'Can view 主页促销活动', '11', 'view_indexpromotionbanner');
INSERT INTO `auth_permission` VALUES ('45', 'Can add 主页分类展示商品', '12', 'add_indextypegoodsbanner');
INSERT INTO `auth_permission` VALUES ('46', 'Can change 主页分类展示商品', '12', 'change_indextypegoodsbanner');
INSERT INTO `auth_permission` VALUES ('47', 'Can delete 主页分类展示商品', '12', 'delete_indextypegoodsbanner');
INSERT INTO `auth_permission` VALUES ('48', 'Can view 主页分类展示商品', '12', 'view_indextypegoodsbanner');
INSERT INTO `auth_permission` VALUES ('49', 'Can add 首页轮播商品', '13', 'add_indexgoodsbanner');
INSERT INTO `auth_permission` VALUES ('50', 'Can change 首页轮播商品', '13', 'change_indexgoodsbanner');
INSERT INTO `auth_permission` VALUES ('51', 'Can delete 首页轮播商品', '13', 'delete_indexgoodsbanner');
INSERT INTO `auth_permission` VALUES ('52', 'Can view 首页轮播商品', '13', 'view_indexgoodsbanner');
INSERT INTO `auth_permission` VALUES ('53', 'Can add 商品图片', '14', 'add_goodsimage');
INSERT INTO `auth_permission` VALUES ('54', 'Can change 商品图片', '14', 'change_goodsimage');
INSERT INTO `auth_permission` VALUES ('55', 'Can delete 商品图片', '14', 'delete_goodsimage');
INSERT INTO `auth_permission` VALUES ('56', 'Can view 商品图片', '14', 'view_goodsimage');
INSERT INTO `auth_permission` VALUES ('57', 'Can add 订单商品', '15', 'add_ordergoods');
INSERT INTO `auth_permission` VALUES ('58', 'Can change 订单商品', '15', 'change_ordergoods');
INSERT INTO `auth_permission` VALUES ('59', 'Can delete 订单商品', '15', 'delete_ordergoods');
INSERT INTO `auth_permission` VALUES ('60', 'Can view 订单商品', '15', 'view_ordergoods');
INSERT INTO `auth_permission` VALUES ('61', 'Can add 订单', '16', 'add_orderinfo');
INSERT INTO `auth_permission` VALUES ('62', 'Can change 订单', '16', 'change_orderinfo');
INSERT INTO `auth_permission` VALUES ('63', 'Can delete 订单', '16', 'delete_orderinfo');
INSERT INTO `auth_permission` VALUES ('64', 'Can view 订单', '16', 'view_orderinfo');

-- ----------------------------
-- Table structure for df_address
-- ----------------------------
DROP TABLE IF EXISTS `df_address`;
CREATE TABLE `df_address` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `receiver` varchar(20) NOT NULL,
  `addr` varchar(256) NOT NULL,
  `zip_code` varchar(6) DEFAULT NULL,
  `phone` varchar(11) NOT NULL,
  `is_default` tinyint(1) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `df_address_user_id_5e6a5c8a_fk_df_user_id` (`user_id`),
  CONSTRAINT `df_address_user_id_5e6a5c8a_fk_df_user_id` FOREIGN KEY (`user_id`) REFERENCES `df_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of df_address
-- ----------------------------
INSERT INTO `df_address` VALUES ('1', '2019-10-20 12:05:51.962210', '2019-10-20 12:05:51.962210', '0', '小王', '北京市昌平区', '100000', '13207168553', '1', '12');
INSERT INTO `df_address` VALUES ('2', '2019-10-20 12:07:25.952279', '2019-10-20 12:07:25.952279', '0', '老王', '北京市西三旗', '100000', '13207168553', '0', '12');
INSERT INTO `df_address` VALUES ('3', '2019-10-27 08:40:55.625807', '2019-10-27 08:40:55.625807', '0', '小王', '武汉洪山区', '420016', '13207168553', '1', '16');
INSERT INTO `df_address` VALUES ('4', '2019-10-27 08:45:58.085440', '2019-10-27 08:45:58.085440', '0', '老王', '北京', '111111', '13207168553', '0', '16');

-- ----------------------------
-- Table structure for df_goods
-- ----------------------------
DROP TABLE IF EXISTS `df_goods`;
CREATE TABLE `df_goods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `name` varchar(20) NOT NULL,
  `detail` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of df_goods
-- ----------------------------
INSERT INTO `df_goods` VALUES ('1', '2019-10-24 06:34:35.653824', '2019-10-24 06:34:35.653824', '0', '草莓', '<p><span style=\"font-size: 10px;\">很不错的草莓</span></p>');
INSERT INTO `df_goods` VALUES ('2', '2019-10-24 06:35:17.054244', '2019-10-24 06:35:17.054244', '0', '葡萄', '<p>很不错的葡萄</p>');
INSERT INTO `df_goods` VALUES ('3', '2019-10-24 06:35:38.938127', '2019-10-24 06:35:38.938127', '0', '柠檬', '<p>很不错的柠檬</p>');
INSERT INTO `df_goods` VALUES ('4', '2019-10-24 06:36:00.334625', '2019-10-24 06:36:00.334625', '0', '奇异果', '');
INSERT INTO `df_goods` VALUES ('5', '2019-10-24 06:36:41.533043', '2019-10-24 06:36:41.533043', '0', '大青虾', '');
INSERT INTO `df_goods` VALUES ('6', '2019-10-24 06:36:54.828668', '2019-10-24 06:36:54.828668', '0', '秋刀鱼', '');
INSERT INTO `df_goods` VALUES ('7', '2019-10-24 06:37:06.598817', '2019-10-24 06:37:06.598817', '0', '扇贝', '');
INSERT INTO `df_goods` VALUES ('8', '2019-10-24 06:37:23.522541', '2019-10-24 06:37:23.522541', '0', '基围虾', '');
INSERT INTO `df_goods` VALUES ('9', '2019-10-24 06:37:36.000548', '2019-10-24 06:37:36.000548', '0', '猪肉', '');
INSERT INTO `df_goods` VALUES ('10', '2019-10-24 06:37:48.958614', '2019-10-24 06:37:48.958614', '0', '牛肉', '');
INSERT INTO `df_goods` VALUES ('11', '2019-10-24 06:38:07.779001', '2019-10-24 06:38:07.779001', '0', '羊肉', '');
INSERT INTO `df_goods` VALUES ('12', '2019-10-24 06:38:22.281134', '2019-10-24 06:38:22.281134', '0', '牛排', '');
INSERT INTO `df_goods` VALUES ('13', '2019-10-24 06:38:40.579989', '2019-10-24 06:38:40.579989', '0', '鸡蛋', '');
INSERT INTO `df_goods` VALUES ('14', '2019-10-24 06:38:58.459715', '2019-10-24 06:38:58.459715', '0', '鸡肉', '');
INSERT INTO `df_goods` VALUES ('15', '2019-10-24 06:39:12.127449', '2019-10-24 06:39:12.127449', '0', '鸭蛋', '');
INSERT INTO `df_goods` VALUES ('16', '2019-10-24 06:39:26.711038', '2019-10-24 06:39:26.711038', '0', '鸡腿', '');
INSERT INTO `df_goods` VALUES ('17', '2019-10-24 06:39:39.689842', '2019-10-24 06:39:39.689842', '0', '白菜', '');
INSERT INTO `df_goods` VALUES ('18', '2019-10-24 06:39:54.427539', '2019-10-24 06:39:54.427539', '0', '芹菜', '');
INSERT INTO `df_goods` VALUES ('19', '2019-10-24 06:40:14.708789', '2019-10-24 06:40:14.708789', '0', '香菜', '');
INSERT INTO `df_goods` VALUES ('20', '2019-10-24 06:40:27.568987', '2019-10-24 06:40:27.568987', '0', '冬瓜', '');
INSERT INTO `df_goods` VALUES ('21', '2019-10-24 06:40:40.112305', '2019-10-24 06:40:40.112305', '0', '鱼丸', '');
INSERT INTO `df_goods` VALUES ('22', '2019-10-24 06:40:52.668637', '2019-10-24 06:40:52.668637', '0', '蟹棒', '');
INSERT INTO `df_goods` VALUES ('23', '2019-10-24 06:41:06.770408', '2019-10-24 06:41:06.770408', '0', '虾丸', '');
INSERT INTO `df_goods` VALUES ('24', '2019-10-24 06:41:20.915174', '2019-10-24 06:41:20.915174', '0', '速冻水饺', '');
INSERT INTO `df_goods` VALUES ('25', '2019-10-24 06:41:32.786612', '2019-10-24 06:41:32.786612', '0', '芒果', '');
INSERT INTO `df_goods` VALUES ('26', '2019-10-24 06:41:46.307572', '2019-10-24 06:41:46.307572', '0', '鹌鹑蛋', '');
INSERT INTO `df_goods` VALUES ('27', '2019-10-24 06:41:59.747890', '2019-10-24 06:41:59.747890', '0', '鹅蛋', '');
INSERT INTO `df_goods` VALUES ('28', '2019-10-24 06:42:14.290892', '2019-10-24 06:42:14.290892', '0', '红辣椒', '');

-- ----------------------------
-- Table structure for df_goods_image
-- ----------------------------
DROP TABLE IF EXISTS `df_goods_image`;
CREATE TABLE `df_goods_image` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `image` varchar(100) NOT NULL,
  `sku_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `df_goods_image_sku_id_f8dc96ea_fk_df_goods_sku_id` (`sku_id`),
  CONSTRAINT `df_goods_image_sku_id_f8dc96ea_fk_df_goods_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `df_goods_sku` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of df_goods_image
-- ----------------------------

-- ----------------------------
-- Table structure for df_goods_sku
-- ----------------------------
DROP TABLE IF EXISTS `df_goods_sku`;
CREATE TABLE `df_goods_sku` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `name` varchar(20) NOT NULL,
  `desc` varchar(256) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `unite` varchar(20) NOT NULL,
  `image` varchar(100) NOT NULL,
  `stock` int(11) NOT NULL,
  `sales` int(11) NOT NULL,
  `status` smallint(6) NOT NULL,
  `goods_id` int(11) NOT NULL,
  `type_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `df_goods_sku_goods_id_31622280_fk_df_goods_id` (`goods_id`),
  KEY `df_goods_sku_type_id_576de3b4_fk_df_goods_type_id` (`type_id`),
  CONSTRAINT `df_goods_sku_goods_id_31622280_fk_df_goods_id` FOREIGN KEY (`goods_id`) REFERENCES `df_goods` (`id`),
  CONSTRAINT `df_goods_sku_type_id_576de3b4_fk_df_goods_type_id` FOREIGN KEY (`type_id`) REFERENCES `df_goods_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of df_goods_sku
-- ----------------------------
INSERT INTO `df_goods_sku` VALUES ('1', '2019-10-24 06:47:20.471572', '2019-10-24 06:47:20.471572', '0', '草莓 500g', '草莓简介', '10.00', '500g', 'group1\\M00/00/00/wKgBZ12xSPmALE48AAAljHPuXJg8197550', '98', '0', '1', '1', '2');
INSERT INTO `df_goods_sku` VALUES ('2', '2019-10-24 06:51:50.334539', '2019-10-24 06:51:50.334539', '0', '盒装草莓', '草莓简介', '20.00', '盒', 'group1\\M00/00/00/wKgBZ12xSgeALUeyAAEc8FlxEvU6445586', '10', '0', '1', '1', '2');
INSERT INTO `df_goods_sku` VALUES ('3', '2019-10-24 06:53:08.617022', '2019-10-24 06:53:08.617022', '0', '葡萄', '葡萄简介', '20.00', '500g', 'group1\\M00/00/00/wKgBZ12xSlaAcyFkAAAjjiYTEkw8273552', '6', '1', '1', '2', '2');
INSERT INTO `df_goods_sku` VALUES ('4', '2019-10-24 06:54:05.883338', '2019-10-24 06:54:05.883338', '0', '柠檬', '柠檬简介', '32.00', '500g', 'group1\\M00/00/00/wKgBZ12xSo-AYTf3AAAgnaeGwNQ9618374', '12', '0', '1', '3', '2');
INSERT INTO `df_goods_sku` VALUES ('5', '2019-10-24 06:55:20.149577', '2019-11-05 03:27:45.611905', '0', '奇异果', '奇异果简介', '12.12', '500g', 'group1\\M00/00/00/wKgBZ12xStmAS5BUAAAeuLYy0pU4108767', '12', '0', '1', '4', '2');
INSERT INTO `df_goods_sku` VALUES ('6', '2019-10-24 06:56:52.089266', '2019-10-24 06:56:52.089266', '0', '大青虾', '大青虾简介', '34.00', '500g', 'group1\\M00/00/00/wKgBZ12xSzWAMUaLAAA5OS4Kl4c3460715', '12', '0', '1', '5', '3');
INSERT INTO `df_goods_sku` VALUES ('7', '2019-10-24 06:58:03.362155', '2019-10-24 06:58:03.362155', '0', '北海道秋刀鱼', '北海道秋刀鱼简介', '50.00', '500g', 'group1\\M00/00/00/wKgBZ12xS3yALpn1AAAkaP_7_180191039', '13', '2', '1', '6', '3');
INSERT INTO `df_goods_sku` VALUES ('8', '2019-10-24 06:58:59.396925', '2019-10-24 06:58:59.396925', '0', '扇贝', '扇贝简介', '56.60', '500g', 'group1\\M00/00/00/wKgBZ12xS7SAD6jwAAAk8WCqqmI1261138', '11', '2', '1', '7', '3');
INSERT INTO `df_goods_sku` VALUES ('9', '2019-10-24 06:59:54.128204', '2019-10-24 06:59:54.128204', '0', '基围虾', '基围虾简介', '100.90', '500g', 'group1\\M00/00/00/wKgBZ12xS-uALNWIAAAk0DN4-yE1987959', '14', '0', '1', '8', '3');
INSERT INTO `df_goods_sku` VALUES ('10', '2019-10-24 07:01:21.781674', '2019-10-28 06:17:40.355765', '0', '猪肉', '猪肉简介', '23.99', '500g', 'group1\\M00/00/00/wKgBZ12xTEOAVj_OAAEVpb1YHUE8528721', '96', '4', '1', '9', '1');
INSERT INTO `df_goods_sku` VALUES ('11', '2019-10-24 07:02:58.731187', '2019-10-24 07:04:50.471034', '0', '牛肉', '牛肉简介', '34.99', '500g', 'group1\\M00/00/00/wKgBZ12xTROAEf-dAAEExAU4yXU1284067', '100', '0', '1', '10', '1');
INSERT INTO `df_goods_sku` VALUES ('12', '2019-10-24 07:04:35.591375', '2019-10-24 07:04:35.591375', '0', '羊肉', '羊肉简介', '56.99', '500g', 'group1\\M00/00/00/wKgBZ12xTQSAeYDxAAB6NOQDrpk3381187', '98', '2', '1', '11', '1');
INSERT INTO `df_goods_sku` VALUES ('13', '2019-10-24 07:06:32.960092', '2019-10-24 07:06:32.960092', '0', '牛排', '牛排简介', '99.99', '500g', 'group1\\M00/00/00/wKgBZ12xTXqAOIjmAACwa3rCDPQ2635549', '99', '1', '1', '12', '1');
INSERT INTO `df_goods_sku` VALUES ('14', '2019-10-24 07:07:43.142838', '2019-10-24 07:07:43.142838', '0', '盒装鸡蛋', '盒装鸡蛋简介', '23.00', '500g', 'group1\\M00/00/00/wKgBZ12xTcCAEWp1AADUKbwLSqY5644852', '100', '0', '1', '13', '4');
INSERT INTO `df_goods_sku` VALUES ('15', '2019-10-24 07:09:13.187494', '2019-11-05 03:45:31.013606', '0', '鸡肉', '鸡肉简介', '32.00', '500g', 'group1\\M00/00/00/wKgBZ12xThqAJ9WmAADUY5hC_sI8787194', '100', '0', '1', '14', '1');
INSERT INTO `df_goods_sku` VALUES ('16', '2019-10-24 07:10:19.076184', '2019-10-24 07:10:19.076184', '0', '鸭蛋', '鸭蛋简介', '45.00', '盒', 'group1\\M00/00/00/wKgBZ12xTlyAScdAAAFC_2tSkFo4447092', '121', '0', '1', '15', '4');
INSERT INTO `df_goods_sku` VALUES ('17', '2019-10-24 07:11:49.320401', '2019-10-28 08:16:40.020431', '0', '鸡腿', '鸡腿', '45.00', '500g', 'group1\\M00/00/00/wKgBZ12xTraAXgaqAAA2_p7G96w0325700', '99', '12', '1', '16', '1');
INSERT INTO `df_goods_sku` VALUES ('18', '2019-10-24 07:12:52.967113', '2019-10-24 07:12:52.967113', '0', '白菜', '白菜简介', '4.50', '500g', 'group1\\M00/00/00/wKgBZ12xTvaAMkQGAADWHYeKaNI5443262', '99', '1', '1', '17', '5');
INSERT INTO `df_goods_sku` VALUES ('19', '2019-10-24 07:13:46.537714', '2019-10-24 07:13:46.537714', '0', '芹菜', '芹菜', '3.50', '500g', 'group1\\M00/00/00/wKgBZ12xTyuALwBmAACIrzuaK645990790', '12', '0', '1', '18', '5');
INSERT INTO `df_goods_sku` VALUES ('20', '2019-10-24 07:15:15.064026', '2019-10-24 07:15:15.064026', '0', '香菜', '香菜', '7.90', '500g', 'group1\\M00/00/00/wKgBZ12xT4SAe7VqAACNpHC0IEY4007577', '100', '0', '1', '19', '5');
INSERT INTO `df_goods_sku` VALUES ('21', '2019-10-24 07:16:19.169298', '2019-10-24 07:16:19.169298', '0', '冬瓜', '冬瓜', '12.99', '500g', 'group1\\M00/00/00/wKgBZ12xT8SADWI8AAENHrNG1-s3287614', '100', '0', '1', '20', '5');
INSERT INTO `df_goods_sku` VALUES ('22', '2019-10-24 07:17:15.292630', '2019-10-24 07:17:15.292630', '0', '鱼丸', '鱼丸', '66.00', '500g', 'group1\\M00/00/00/wKgBZ12xT_yAfWWeAADZQphQJ2o2382361', '12', '0', '1', '21', '6');
INSERT INTO `df_goods_sku` VALUES ('23', '2019-10-24 07:18:07.441605', '2019-10-24 07:18:07.441605', '0', '蟹棒', '蟹棒', '68.00', '500g', 'group1\\M00/00/00/wKgBZ12xUDCAOSTRAABxy5vKkgY1011769', '100', '0', '1', '22', '6');
INSERT INTO `df_goods_sku` VALUES ('24', '2019-10-24 07:18:59.396748', '2019-10-24 07:18:59.396748', '0', '虾丸', '虾丸', '89.99', '500g', 'group1\\M00/00/00/wKgBZ12xUGSAMs4mAABICav_wjk8607469', '100', '0', '1', '23', '6');
INSERT INTO `df_goods_sku` VALUES ('25', '2019-10-24 07:20:01.187757', '2019-10-24 07:20:01.187757', '0', '速冻水饺', '速冻水饺', '20.00', '袋', 'group1\\M00/00/00/wKgBZ12xUKKAFKvwAACMoBJXjDs8706942', '100', '0', '1', '24', '6');
INSERT INTO `df_goods_sku` VALUES ('26', '2019-10-24 07:22:04.576133', '2019-10-28 07:36:24.238349', '0', '越南芒果', '新鲜越南芒果', '29.90', '2.5kg', 'group1\\M00/00/00/wKgBZ12xUR2AGdOnAAByzTJcTjM2984151', '85', '15', '1', '25', '2');
INSERT INTO `df_goods_sku` VALUES ('27', '2019-10-24 07:23:46.367840', '2019-10-24 07:23:46.367840', '0', '鹌鹑蛋', '鹌鹑蛋', '39.80', '126枚', 'group1\\M00/00/00/wKgBZ12xUYOAT4r0AAGZ6KapWiA8918755', '100', '0', '1', '26', '4');
INSERT INTO `df_goods_sku` VALUES ('28', '2019-10-24 07:24:36.211401', '2019-10-24 07:24:36.211401', '0', '鹅蛋', '鹅蛋', '49.90', '6枚', 'group1\\M00/00/00/wKgBZ12xUbWAXogTAADg_NUp5b43274979', '80', '0', '1', '27', '4');
INSERT INTO `df_goods_sku` VALUES ('29', '2019-10-24 07:25:45.614158', '2019-10-24 07:25:45.614158', '0', '红辣椒', '红辣椒', '11.00', '2.5kg', 'group1\\M00/00/00/wKgBZ12xUfqAIFt0AAHXO8pdocY0278694', '150', '0', '1', '28', '5');

-- ----------------------------
-- Table structure for df_goods_type
-- ----------------------------
DROP TABLE IF EXISTS `df_goods_type`;
CREATE TABLE `df_goods_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `name` varchar(20) NOT NULL,
  `logo` varchar(20) NOT NULL,
  `image` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of df_goods_type
-- ----------------------------
INSERT INTO `df_goods_type` VALUES ('1', '2019-10-23 03:12:46.422244', '2019-10-23 03:12:46.422244', '0', '猪牛羊肉', 'meet', 'group1\\M00/00/00/wKgBZ12vxS-AIwi1AAAy1Tlm9So3169261');
INSERT INTO `df_goods_type` VALUES ('2', '2019-10-23 13:01:33.201368', '2019-10-23 13:01:33.201368', '0', '新鲜水果', 'fruit', 'group1\\M00/00/00/wKgBZ12wTy6AP55JAAAmv27pX4k9056982');
INSERT INTO `df_goods_type` VALUES ('3', '2019-10-23 13:02:18.860034', '2019-10-23 13:02:18.860034', '0', '海鲜水产', 'seafood', 'group1\\M00/00/00/wKgBZ12wT1uALdZJAABHr3RQqFs4049664');
INSERT INTO `df_goods_type` VALUES ('4', '2019-10-23 13:03:26.178883', '2019-10-23 13:03:26.178883', '0', '禽类蛋品', 'egg', 'group1\\M00/00/00/wKgBZ12wT5-AQqitAAAqR4DoSUg7740127');
INSERT INTO `df_goods_type` VALUES ('5', '2019-10-23 13:04:11.875371', '2019-10-23 13:04:11.875371', '0', '新鲜蔬菜', 'vegetables', 'group1\\M00/00/00/wKgBZ12wT8yAUq2LAAA-0ZoYkpM3859458');
INSERT INTO `df_goods_type` VALUES ('6', '2019-10-23 13:04:40.738542', '2019-10-23 13:04:40.738542', '0', '速冻食品', 'ice', 'group1\\M00/00/00/wKgBZ12wT-mAQTIoAAA3sZPrVzQ6060037');

-- ----------------------------
-- Table structure for df_index_banner
-- ----------------------------
DROP TABLE IF EXISTS `df_index_banner`;
CREATE TABLE `df_index_banner` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `image` varchar(100) NOT NULL,
  `index` smallint(6) NOT NULL,
  `sku_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `df_index_banner_sku_id_57f2798e_fk_df_goods_sku_id` (`sku_id`),
  CONSTRAINT `df_index_banner_sku_id_57f2798e_fk_df_goods_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `df_goods_sku` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of df_index_banner
-- ----------------------------
INSERT INTO `df_index_banner` VALUES ('1', '2019-10-24 07:28:38.293698', '2019-10-24 07:28:38.293698', '0', 'group1\\M00/00/00/wKgBZ12xUqeAK8fbAACpB-LsCdE1942828', '0', '3');
INSERT INTO `df_index_banner` VALUES ('2', '2019-10-24 07:29:13.634818', '2019-10-24 07:29:13.634818', '0', 'group1\\M00/00/00/wKgBZ12xUsqANxMqAAC3B-z8J2c3141639', '1', '26');
INSERT INTO `df_index_banner` VALUES ('3', '2019-10-24 07:29:35.430849', '2019-10-24 07:29:35.431849', '0', 'group1\\M00/00/00/wKgBZ12xUuCAAdk7AAETwXb_pso3601560', '2', '13');
INSERT INTO `df_index_banner` VALUES ('4', '2019-10-24 07:29:49.186443', '2019-10-24 07:29:49.186443', '0', 'group1\\M00/00/00/wKgBZ12xUu6AE7gLAAD0akkXmFo4619801', '3', '9');

-- ----------------------------
-- Table structure for df_index_promotion
-- ----------------------------
DROP TABLE IF EXISTS `df_index_promotion`;
CREATE TABLE `df_index_promotion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `name` varchar(20) NOT NULL,
  `url` varchar(256) NOT NULL,
  `image` varchar(100) NOT NULL,
  `index` smallint(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of df_index_promotion
-- ----------------------------
INSERT INTO `df_index_promotion` VALUES ('1', '2019-10-23 12:15:52.339534', '2019-10-23 12:15:52.339534', '0', '盛夏尝鲜季', '#', 'group1\\M00/00/00/wKgBZ12wRHmAeiZVAAA98yvCs1I2555248', '1');
INSERT INTO `df_index_promotion` VALUES ('2', '2019-10-23 12:16:33.502827', '2019-10-23 12:21:35.482007', '0', '吃货暑假趴', '#', 'group1\\M00/00/00/wKgBZ12wRKKAKemkAAA2pLUeB600024777', '0');

-- ----------------------------
-- Table structure for df_index_type_goods
-- ----------------------------
DROP TABLE IF EXISTS `df_index_type_goods`;
CREATE TABLE `df_index_type_goods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `display_type` smallint(6) NOT NULL,
  `index` smallint(6) NOT NULL,
  `sku_id` int(11) NOT NULL,
  `type_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `df_index_type_goods_sku_id_0a8a17db_fk_df_goods_sku_id` (`sku_id`),
  KEY `df_index_type_goods_type_id_35192ffd_fk_df_goods_type_id` (`type_id`),
  CONSTRAINT `df_index_type_goods_sku_id_0a8a17db_fk_df_goods_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `df_goods_sku` (`id`),
  CONSTRAINT `df_index_type_goods_type_id_35192ffd_fk_df_goods_type_id` FOREIGN KEY (`type_id`) REFERENCES `df_goods_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of df_index_type_goods
-- ----------------------------
INSERT INTO `df_index_type_goods` VALUES ('1', '2019-10-24 07:32:52.762090', '2019-10-24 11:53:23.391929', '0', '1', '0', '10', '1');
INSERT INTO `df_index_type_goods` VALUES ('2', '2019-10-24 07:33:52.801736', '2019-10-24 11:36:00.460093', '0', '1', '1', '17', '1');
INSERT INTO `df_index_type_goods` VALUES ('3', '2019-10-24 07:34:09.666902', '2019-10-24 07:34:21.667054', '0', '1', '2', '12', '1');
INSERT INTO `df_index_type_goods` VALUES ('4', '2019-10-24 07:34:34.542947', '2019-10-24 07:34:34.542947', '0', '1', '3', '13', '1');
INSERT INTO `df_index_type_goods` VALUES ('5', '2019-10-24 07:35:16.881379', '2019-10-24 07:35:16.881379', '0', '0', '0', '15', '1');
INSERT INTO `df_index_type_goods` VALUES ('6', '2019-10-24 07:35:43.866359', '2019-10-24 07:35:43.866359', '0', '1', '0', '1', '2');
INSERT INTO `df_index_type_goods` VALUES ('7', '2019-10-24 07:35:55.526899', '2019-10-24 07:35:55.526899', '0', '1', '1', '3', '2');
INSERT INTO `df_index_type_goods` VALUES ('8', '2019-10-24 07:36:10.273974', '2019-10-24 07:36:10.273974', '0', '1', '2', '5', '2');
INSERT INTO `df_index_type_goods` VALUES ('9', '2019-10-24 07:36:27.769641', '2019-10-24 07:36:27.769641', '0', '1', '3', '4', '2');
INSERT INTO `df_index_type_goods` VALUES ('10', '2019-10-24 07:36:51.755557', '2019-10-24 07:36:51.755557', '0', '0', '0', '2', '2');
INSERT INTO `df_index_type_goods` VALUES ('11', '2019-10-24 07:37:59.696419', '2019-10-24 07:37:59.696419', '0', '1', '0', '6', '3');
INSERT INTO `df_index_type_goods` VALUES ('12', '2019-10-24 07:38:11.338945', '2019-10-24 07:38:11.338945', '0', '1', '1', '7', '3');
INSERT INTO `df_index_type_goods` VALUES ('13', '2019-10-24 07:38:24.849886', '2019-10-24 07:38:24.849886', '0', '1', '2', '8', '3');
INSERT INTO `df_index_type_goods` VALUES ('14', '2019-10-24 07:38:37.522260', '2019-10-24 07:38:37.522260', '0', '1', '3', '9', '3');
INSERT INTO `df_index_type_goods` VALUES ('15', '2019-10-24 07:39:01.781887', '2019-10-24 07:39:01.781887', '0', '0', '0', '9', '3');
INSERT INTO `df_index_type_goods` VALUES ('16', '2019-10-24 07:39:14.324057', '2019-10-24 07:39:14.324057', '0', '0', '1', '8', '3');
INSERT INTO `df_index_type_goods` VALUES ('17', '2019-10-24 07:40:21.891957', '2019-10-24 07:40:21.891957', '0', '1', '0', '14', '4');
INSERT INTO `df_index_type_goods` VALUES ('18', '2019-10-24 07:40:40.676216', '2019-10-24 07:40:40.676216', '0', '1', '1', '16', '4');
INSERT INTO `df_index_type_goods` VALUES ('19', '2019-10-24 07:41:06.189423', '2019-10-24 07:41:06.189423', '0', '1', '2', '27', '4');
INSERT INTO `df_index_type_goods` VALUES ('20', '2019-10-24 07:41:27.808176', '2019-10-24 07:41:27.808176', '0', '1', '3', '28', '4');
INSERT INTO `df_index_type_goods` VALUES ('21', '2019-10-24 07:41:49.548968', '2019-10-24 07:41:49.548968', '0', '0', '0', '14', '4');
INSERT INTO `df_index_type_goods` VALUES ('22', '2019-10-24 07:42:03.090790', '2019-10-24 07:42:14.912532', '0', '0', '1', '28', '4');
INSERT INTO `df_index_type_goods` VALUES ('23', '2019-10-24 07:42:56.032087', '2019-10-24 07:42:56.032087', '0', '1', '0', '18', '5');
INSERT INTO `df_index_type_goods` VALUES ('24', '2019-10-24 07:43:09.318213', '2019-10-24 07:43:09.318213', '0', '1', '1', '19', '5');
INSERT INTO `df_index_type_goods` VALUES ('25', '2019-10-24 07:43:23.398180', '2019-10-24 07:43:23.398180', '0', '1', '2', '20', '5');
INSERT INTO `df_index_type_goods` VALUES ('26', '2019-10-24 07:43:36.645155', '2019-10-24 07:43:36.645155', '0', '1', '3', '29', '5');
INSERT INTO `df_index_type_goods` VALUES ('27', '2019-10-24 07:44:07.739480', '2019-10-24 07:44:07.739480', '0', '0', '0', '20', '5');
INSERT INTO `df_index_type_goods` VALUES ('28', '2019-10-24 07:44:17.664170', '2019-10-24 07:44:17.664170', '0', '0', '1', '19', '5');
INSERT INTO `df_index_type_goods` VALUES ('29', '2019-10-24 07:44:38.853242', '2019-10-24 07:44:38.853242', '0', '1', '0', '22', '6');
INSERT INTO `df_index_type_goods` VALUES ('30', '2019-10-24 07:44:49.247479', '2019-10-24 07:44:49.247479', '0', '1', '1', '23', '6');
INSERT INTO `df_index_type_goods` VALUES ('31', '2019-10-24 07:45:02.103719', '2019-10-24 07:45:02.103719', '0', '1', '2', '24', '6');
INSERT INTO `df_index_type_goods` VALUES ('32', '2019-10-24 07:45:13.060815', '2019-10-24 07:45:13.060815', '0', '1', '3', '25', '6');
INSERT INTO `df_index_type_goods` VALUES ('33', '2019-10-24 07:45:24.953184', '2019-10-24 07:45:24.953184', '0', '0', '0', '23', '6');
INSERT INTO `df_index_type_goods` VALUES ('34', '2019-10-24 07:45:35.322965', '2019-10-24 07:45:35.322965', '0', '0', '1', '25', '6');

-- ----------------------------
-- Table structure for df_order_goods
-- ----------------------------
DROP TABLE IF EXISTS `df_order_goods`;
CREATE TABLE `df_order_goods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `count` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `comment` varchar(256) NOT NULL,
  `order_id` varchar(128) NOT NULL,
  `sku_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `df_order_goods_order_id_6958ee23_fk_df_order_info_order_id` (`order_id`),
  KEY `df_order_goods_sku_id_b7d6e04e_fk_df_goods_sku_id` (`sku_id`),
  CONSTRAINT `df_order_goods_order_id_6958ee23_fk_df_order_info_order_id` FOREIGN KEY (`order_id`) REFERENCES `df_order_info` (`order_id`),
  CONSTRAINT `df_order_goods_sku_id_b7d6e04e_fk_df_goods_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `df_goods_sku` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of df_order_goods
-- ----------------------------
INSERT INTO `df_order_goods` VALUES ('23', '2019-11-01 09:46:42.688138', '2019-11-03 07:28:05.748993', '0', '1', '23.99', '赞', '2019110117464216', '10');
INSERT INTO `df_order_goods` VALUES ('24', '2019-11-01 09:46:42.691138', '2019-11-03 07:28:05.754994', '0', '1', '45.00', '好吃', '2019110117464216', '17');
INSERT INTO `df_order_goods` VALUES ('25', '2019-11-01 09:50:41.640382', '2019-11-03 07:25:01.104851', '0', '1', '99.99', '赞', '2019110117504116', '13');
INSERT INTO `df_order_goods` VALUES ('26', '2019-11-02 05:00:39.785461', '2019-11-02 05:00:39.785461', '0', '2', '56.99', '', '2019110213003916', '12');
INSERT INTO `df_order_goods` VALUES ('27', '2019-11-02 05:01:00.092070', '2019-11-02 05:01:00.092070', '0', '1', '4.50', '', '2019110213010016', '18');

-- ----------------------------
-- Table structure for df_order_info
-- ----------------------------
DROP TABLE IF EXISTS `df_order_info`;
CREATE TABLE `df_order_info` (
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `order_id` varchar(128) NOT NULL,
  `pay_method` smallint(6) NOT NULL,
  `total_count` int(11) NOT NULL,
  `total_price` decimal(10,2) NOT NULL,
  `transit_price` decimal(10,2) NOT NULL,
  `order_status` smallint(6) NOT NULL,
  `trade_no` varchar(128) NOT NULL,
  `addr_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`order_id`),
  KEY `df_order_info_addr_id_70c3726e_fk_df_address_id` (`addr_id`),
  KEY `df_order_info_user_id_ac1e5bf5_fk_df_user_id` (`user_id`),
  CONSTRAINT `df_order_info_addr_id_70c3726e_fk_df_address_id` FOREIGN KEY (`addr_id`) REFERENCES `df_address` (`id`),
  CONSTRAINT `df_order_info_user_id_ac1e5bf5_fk_df_user_id` FOREIGN KEY (`user_id`) REFERENCES `df_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of df_order_info
-- ----------------------------
INSERT INTO `df_order_info` VALUES ('2019-11-01 09:46:42.683137', '2019-11-03 07:28:05.755994', '0', '2019110117464216', '3', '2', '68.99', '10.00', '5', '2019110122001459991000010411', '3', '16');
INSERT INTO `df_order_info` VALUES ('2019-11-01 09:50:41.636381', '2019-11-03 07:25:01.112853', '0', '2019110117504116', '3', '1', '99.99', '10.00', '5', '2019110122001459991000010412', '3', '16');
INSERT INTO `df_order_info` VALUES ('2019-11-02 05:00:39.777459', '2019-11-02 05:00:39.786461', '0', '2019110213003916', '3', '2', '113.98', '10.00', '1', '', '3', '16');
INSERT INTO `df_order_info` VALUES ('2019-11-02 05:01:00.088068', '2019-11-02 05:01:00.093069', '0', '2019110213010016', '3', '1', '4.50', '10.00', '1', '', '3', '16');

-- ----------------------------
-- Table structure for df_user
-- ----------------------------
DROP TABLE IF EXISTS `df_user`;
CREATE TABLE `df_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of df_user
-- ----------------------------
INSERT INTO `df_user` VALUES ('1', 'pbkdf2_sha256$150000$NK6wZZV5cOiS$18q89UNqK6t35n5TYgG/9X9E9WRWMvi9cFm2MoLq11I=', null, '0', 'smart', '', '', '843296031@qq.com', '0', '0', '2019-10-19 06:20:08.409514', '2019-10-19 06:20:08.534860', '2019-10-19 06:20:08.564779', '0');
INSERT INTO `df_user` VALUES ('2', 'pbkdf2_sha256$150000$fSI5EJDgHSb1$HspTgsSw2Aqvuhgj3HvYHalHkEaciFlBX9TlEsQK2oU=', null, '0', 'smart1', '', '', '843296031@qq.com', '0', '0', '2019-10-19 06:26:25.169923', '2019-10-19 06:26:25.269947', '2019-10-19 06:26:25.285645', '0');
INSERT INTO `df_user` VALUES ('3', 'pbkdf2_sha256$150000$iQRmQM3ASXyN$zQLOBpx/DDPhBWybYp3BFHHjs1QOvKkzwMQO1K6YLDg=', null, '0', 'smart2', '', '', '843296031@qq.com', '0', '0', '2019-10-19 06:26:53.505194', '2019-10-19 06:26:53.605217', '2019-10-19 06:26:53.607044', '0');
INSERT INTO `df_user` VALUES ('4', 'pbkdf2_sha256$150000$gFbexynXhRu9$7Qn4soL/SY4dy+VcT7ZfCvb3CvrImVKQSwZEOlRrfMU=', null, '0', 'smart3', '', '', '843296031@qq.com', '0', '0', '2019-10-19 06:34:33.895617', '2019-10-19 06:34:33.992640', '2019-10-19 06:34:34.001423', '0');
INSERT INTO `df_user` VALUES ('5', 'pbkdf2_sha256$150000$nCQluCpBM91K$7UHelSEu3S3VQ8X4u0UEArUl5vxYW2ShzfRfg91aho4=', null, '0', 'smart4', '', '', '843296031@qq.com', '0', '0', '2019-10-19 06:36:28.473637', '2019-10-19 06:36:28.572660', '2019-10-19 06:36:28.580708', '0');
INSERT INTO `df_user` VALUES ('6', 'pbkdf2_sha256$150000$LWWGvZWxqpCb$rnVOBwz8coe/mnC6MQCSuKLw7Bov150dfJ8be4TIv6M=', null, '0', 'smart5', '', '', 'liupengfeizh@163.com', '0', '0', '2019-10-19 08:55:45.025779', '2019-10-19 08:55:45.124703', '2019-10-19 08:55:45.133705', '0');
INSERT INTO `df_user` VALUES ('7', 'pbkdf2_sha256$150000$BiNXyewWmKXG$9YbMLaOdRvd+iVrxSBv7xPfis99mdB7T9ItI4BrCHsA=', null, '0', 'smart6', '', '', 'liupengfeizh@yeah.net', '0', '0', '2019-10-19 08:57:33.071510', '2019-10-19 08:57:33.174534', '2019-10-19 08:57:33.182536', '0');
INSERT INTO `df_user` VALUES ('8', 'pbkdf2_sha256$150000$Qz7CPi9FW8CB$lviTE+1MxXJ5l9Lwpl9HkhIaHDUGJB78tXenaqAvNqY=', null, '0', 'smart7', '', '', 'liupengfeizh@yeah.net', '0', '0', '2019-10-19 09:22:08.913430', '2019-10-19 09:22:09.013454', '2019-10-19 09:22:09.021457', '0');
INSERT INTO `df_user` VALUES ('9', 'pbkdf2_sha256$150000$1kUhgtut3I9I$e+zLnA7PiBCS305fEYBohkBu2kOCvsCWrm5PZCHlAPU=', null, '0', 'smart8', '', '', 'liupengfeizh@yeah.net', '0', '0', '2019-10-19 09:35:46.604108', '2019-10-19 09:35:46.705132', '2019-10-19 09:35:46.712796', '0');
INSERT INTO `df_user` VALUES ('10', 'pbkdf2_sha256$150000$n50SLjeW4aJ6$+dR+jknj+2q++JD8T3mcbSbPvqk16ow4XZjaIO+xrEM=', null, '0', 'smart9', '', '', 'liupengfeizh@yeah.net', '0', '0', '2019-10-19 09:43:51.447116', '2019-10-19 09:43:51.546139', '2019-10-19 09:43:51.549140', '0');
INSERT INTO `df_user` VALUES ('11', 'pbkdf2_sha256$150000$e6ycx00VokrX$eilwVhkuyC/5ieghpqv0E/itKeCbvShqC9KxHGaTyJY=', null, '0', 'smart10', '', '', 'liupengfeizh@yeah.net', '0', '0', '2019-10-19 09:53:31.781785', '2019-10-19 09:53:31.880808', '2019-10-19 09:53:31.889812', '0');
INSERT INTO `df_user` VALUES ('12', 'pbkdf2_sha256$150000$MylfWsPvg9rm$cf2L40igIgGYajZNzOLRx5YU6YgTN/HPJ1TPJPSaMVE=', '2019-10-28 08:13:25.017958', '0', 'smart11', '', '', 'liupengfeizh@yeah.net', '0', '1', '2019-10-19 09:55:42.601292', '2019-10-19 09:55:42.702314', '2019-10-19 10:03:44.324600', '0');
INSERT INTO `df_user` VALUES ('13', 'pbkdf2_sha256$150000$csXVTEQiJpaK$ixEwWDkGce96r9jhSuP2vRyDR3JfHM7JvD37YK+ZDD4=', '2019-10-20 04:35:38.740768', '0', 'smart12', '', '', 'liupengfeizh@yeah.net', '0', '1', '2019-10-19 10:14:15.315540', '2019-10-19 10:14:15.415564', '2019-10-19 10:14:42.463220', '0');
INSERT INTO `df_user` VALUES ('14', 'pbkdf2_sha256$150000$63w7nenRSYty$NPAO1aXUcxZmnl8E5oW+O7vm+3PuWmWQA/QGAj4NpG4=', null, '0', 'smart13', '', '', 'liupengfeizh@yeah.net', '0', '1', '2019-10-19 12:53:38.040945', '2019-10-19 12:53:38.141968', '2019-10-19 12:54:41.178392', '0');
INSERT INTO `df_user` VALUES ('15', 'pbkdf2_sha256$150000$7AOVmDfb8UB9$ryW1tcLtkZNhjIg7Ek0iLqDEV4dYddzo5jeo5quPvZE=', null, '0', 'smart14', '', '', 'liupengfeizh@yeah.net', '0', '0', '2019-10-20 04:44:49.742692', '2019-10-20 04:44:49.842716', '2019-10-20 04:44:49.867721', '0');
INSERT INTO `df_user` VALUES ('16', 'pbkdf2_sha256$150000$qVz3uXrB8kv0$lVr8zI66iZT8yNWwT0vKGpoYy2uvf6ZyXxpnT2E39C0=', '2019-11-05 03:07:28.872141', '1', 'admin', '', '', '843296031@qq.com', '1', '1', '2019-10-21 07:43:15.835448', '2019-10-21 07:43:15.934477', '2019-10-21 07:43:15.934477', '0');
INSERT INTO `df_user` VALUES ('17', 'pbkdf2_sha256$150000$JMnQW1Mp3fSR$f8p5fgNLZOiSLpmx+OKyeawTmhsN4rA1EJzrvhp4xcs=', null, '1', 'admin1', '', '', '843296031@qq.com', '1', '1', '2019-10-23 13:20:35.506410', '2019-10-23 13:20:35.605453', '2019-10-23 13:20:35.605453', '0');

-- ----------------------------
-- Table structure for df_user_groups
-- ----------------------------
DROP TABLE IF EXISTS `df_user_groups`;
CREATE TABLE `df_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `df_user_groups_user_id_group_id_80e5ab91_uniq` (`user_id`,`group_id`),
  KEY `df_user_groups_group_id_36f24e94_fk_auth_group_id` (`group_id`),
  CONSTRAINT `df_user_groups_group_id_36f24e94_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `df_user_groups_user_id_a816b098_fk_df_user_id` FOREIGN KEY (`user_id`) REFERENCES `df_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of df_user_groups
-- ----------------------------

-- ----------------------------
-- Table structure for df_user_user_permissions
-- ----------------------------
DROP TABLE IF EXISTS `df_user_user_permissions`;
CREATE TABLE `df_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `df_user_user_permissions_user_id_permission_id_b22997de_uniq` (`user_id`,`permission_id`),
  KEY `df_user_user_permiss_permission_id_40a6cb2d_fk_auth_perm` (`permission_id`),
  CONSTRAINT `df_user_user_permiss_permission_id_40a6cb2d_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `df_user_user_permissions_user_id_b5f6551b_fk_df_user_id` FOREIGN KEY (`user_id`) REFERENCES `df_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of df_user_user_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for django_admin_log
-- ----------------------------
DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_df_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_df_user_id` FOREIGN KEY (`user_id`) REFERENCES `df_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=117 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_admin_log
-- ----------------------------
INSERT INTO `django_admin_log` VALUES ('1', '2019-10-23 03:12:46.527270', '1', '猪牛羊肉', '1', '[{\"added\": {}}]', '10', '16');
INSERT INTO `django_admin_log` VALUES ('2', '2019-10-23 12:15:52.549587', '1', '盛夏尝鲜季', '1', '[{\"added\": {}}]', '11', '16');
INSERT INTO `django_admin_log` VALUES ('3', '2019-10-23 12:16:33.511829', '2', '吃货暑假趴', '1', '[{\"added\": {}}]', '11', '16');
INSERT INTO `django_admin_log` VALUES ('4', '2019-10-23 12:21:35.483007', '2', '吃货暑假趴', '2', '[{\"changed\": {\"fields\": [\"index\"]}}]', '11', '16');
INSERT INTO `django_admin_log` VALUES ('5', '2019-10-23 13:01:33.418422', '2', '新鲜水果', '1', '[{\"added\": {}}]', '10', '16');
INSERT INTO `django_admin_log` VALUES ('6', '2019-10-23 13:02:18.875038', '3', '海鲜水产', '1', '[{\"added\": {}}]', '10', '16');
INSERT INTO `django_admin_log` VALUES ('7', '2019-10-23 13:03:26.202888', '4', '禽类蛋品', '1', '[{\"added\": {}}]', '10', '16');
INSERT INTO `django_admin_log` VALUES ('8', '2019-10-23 13:04:11.891374', '5', '新鲜蔬菜', '1', '[{\"added\": {}}]', '10', '16');
INSERT INTO `django_admin_log` VALUES ('9', '2019-10-23 13:04:40.762548', '6', '速冻食品', '1', '[{\"added\": {}}]', '10', '16');
INSERT INTO `django_admin_log` VALUES ('10', '2019-10-24 06:34:35.655824', '1', '草莓', '1', '[{\"added\": {}}]', '8', '16');
INSERT INTO `django_admin_log` VALUES ('11', '2019-10-24 06:35:17.056245', '2', '葡萄', '1', '[{\"added\": {}}]', '8', '16');
INSERT INTO `django_admin_log` VALUES ('12', '2019-10-24 06:35:38.939128', '3', '柠檬', '1', '[{\"added\": {}}]', '8', '16');
INSERT INTO `django_admin_log` VALUES ('13', '2019-10-24 06:36:00.335626', '4', '奇异果', '1', '[{\"added\": {}}]', '8', '16');
INSERT INTO `django_admin_log` VALUES ('14', '2019-10-24 06:36:41.534417', '5', '大青虾', '1', '[{\"added\": {}}]', '8', '16');
INSERT INTO `django_admin_log` VALUES ('15', '2019-10-24 06:36:54.829668', '6', '秋刀鱼', '1', '[{\"added\": {}}]', '8', '16');
INSERT INTO `django_admin_log` VALUES ('16', '2019-10-24 06:37:06.600422', '7', '扇贝', '1', '[{\"added\": {}}]', '8', '16');
INSERT INTO `django_admin_log` VALUES ('17', '2019-10-24 06:37:23.523661', '8', '基围虾', '1', '[{\"added\": {}}]', '8', '16');
INSERT INTO `django_admin_log` VALUES ('18', '2019-10-24 06:37:36.001548', '9', '猪肉', '1', '[{\"added\": {}}]', '8', '16');
INSERT INTO `django_admin_log` VALUES ('19', '2019-10-24 06:37:48.960614', '10', '牛肉', '1', '[{\"added\": {}}]', '8', '16');
INSERT INTO `django_admin_log` VALUES ('20', '2019-10-24 06:38:07.781001', '11', '羊肉', '1', '[{\"added\": {}}]', '8', '16');
INSERT INTO `django_admin_log` VALUES ('21', '2019-10-24 06:38:22.282134', '12', '牛排', '1', '[{\"added\": {}}]', '8', '16');
INSERT INTO `django_admin_log` VALUES ('22', '2019-10-24 06:38:40.581990', '13', '鸡蛋', '1', '[{\"added\": {}}]', '8', '16');
INSERT INTO `django_admin_log` VALUES ('23', '2019-10-24 06:38:58.461076', '14', '鸡肉', '1', '[{\"added\": {}}]', '8', '16');
INSERT INTO `django_admin_log` VALUES ('24', '2019-10-24 06:39:12.129450', '15', '鸭蛋', '1', '[{\"added\": {}}]', '8', '16');
INSERT INTO `django_admin_log` VALUES ('25', '2019-10-24 06:39:26.713039', '16', '鸡腿', '1', '[{\"added\": {}}]', '8', '16');
INSERT INTO `django_admin_log` VALUES ('26', '2019-10-24 06:39:39.690841', '17', '白菜', '1', '[{\"added\": {}}]', '8', '16');
INSERT INTO `django_admin_log` VALUES ('27', '2019-10-24 06:39:54.428539', '18', '芹菜', '1', '[{\"added\": {}}]', '8', '16');
INSERT INTO `django_admin_log` VALUES ('28', '2019-10-24 06:40:14.710789', '19', '香菜', '1', '[{\"added\": {}}]', '8', '16');
INSERT INTO `django_admin_log` VALUES ('29', '2019-10-24 06:40:27.569986', '20', '冬瓜', '1', '[{\"added\": {}}]', '8', '16');
INSERT INTO `django_admin_log` VALUES ('30', '2019-10-24 06:40:40.113305', '21', '鱼丸', '1', '[{\"added\": {}}]', '8', '16');
INSERT INTO `django_admin_log` VALUES ('31', '2019-10-24 06:40:52.679640', '22', '蟹棒', '1', '[{\"added\": {}}]', '8', '16');
INSERT INTO `django_admin_log` VALUES ('32', '2019-10-24 06:41:06.771665', '23', '虾丸', '1', '[{\"added\": {}}]', '8', '16');
INSERT INTO `django_admin_log` VALUES ('33', '2019-10-24 06:41:20.916236', '24', '速冻水饺', '1', '[{\"added\": {}}]', '8', '16');
INSERT INTO `django_admin_log` VALUES ('34', '2019-10-24 06:41:32.788146', '25', '芒果', '1', '[{\"added\": {}}]', '8', '16');
INSERT INTO `django_admin_log` VALUES ('35', '2019-10-24 06:41:46.308570', '26', '鹌鹑蛋', '1', '[{\"added\": {}}]', '8', '16');
INSERT INTO `django_admin_log` VALUES ('36', '2019-10-24 06:41:59.748720', '27', '鹅蛋', '1', '[{\"added\": {}}]', '8', '16');
INSERT INTO `django_admin_log` VALUES ('37', '2019-10-24 06:42:14.292177', '28', '红辣椒', '1', '[{\"added\": {}}]', '8', '16');
INSERT INTO `django_admin_log` VALUES ('38', '2019-10-24 06:47:20.603602', '1', '草莓 500g', '1', '[{\"added\": {}}]', '9', '16');
INSERT INTO `django_admin_log` VALUES ('39', '2019-10-24 06:51:50.351543', '2', '盒装草莓', '1', '[{\"added\": {}}]', '9', '16');
INSERT INTO `django_admin_log` VALUES ('40', '2019-10-24 06:53:08.641027', '3', '葡萄', '1', '[{\"added\": {}}]', '9', '16');
INSERT INTO `django_admin_log` VALUES ('41', '2019-10-24 06:54:05.897341', '4', '柠檬', '1', '[{\"added\": {}}]', '9', '16');
INSERT INTO `django_admin_log` VALUES ('42', '2019-10-24 06:55:20.154578', '5', '奇异果', '1', '[{\"added\": {}}]', '9', '16');
INSERT INTO `django_admin_log` VALUES ('43', '2019-10-24 06:56:52.093267', '6', '大青虾', '1', '[{\"added\": {}}]', '9', '16');
INSERT INTO `django_admin_log` VALUES ('44', '2019-10-24 06:58:03.375158', '7', '北海道秋刀鱼', '1', '[{\"added\": {}}]', '9', '16');
INSERT INTO `django_admin_log` VALUES ('45', '2019-10-24 06:58:59.400926', '8', '扇贝', '1', '[{\"added\": {}}]', '9', '16');
INSERT INTO `django_admin_log` VALUES ('46', '2019-10-24 06:59:54.151294', '9', '基围虾', '1', '[{\"added\": {}}]', '9', '16');
INSERT INTO `django_admin_log` VALUES ('47', '2019-10-24 07:01:21.785675', '10', '猪肉', '1', '[{\"added\": {}}]', '9', '16');
INSERT INTO `django_admin_log` VALUES ('48', '2019-10-24 07:02:58.754197', '11', '牛肉', '1', '[{\"added\": {}}]', '9', '16');
INSERT INTO `django_admin_log` VALUES ('49', '2019-10-24 07:04:35.606377', '12', '羊肉', '1', '[{\"added\": {}}]', '9', '16');
INSERT INTO `django_admin_log` VALUES ('50', '2019-10-24 07:04:50.500044', '11', '牛肉', '2', '[{\"changed\": {\"fields\": [\"image\"]}}]', '9', '16');
INSERT INTO `django_admin_log` VALUES ('51', '2019-10-24 07:06:32.965093', '13', '牛排', '1', '[{\"added\": {}}]', '9', '16');
INSERT INTO `django_admin_log` VALUES ('52', '2019-10-24 07:07:43.147840', '14', '盒装鸡蛋', '1', '[{\"added\": {}}]', '9', '16');
INSERT INTO `django_admin_log` VALUES ('53', '2019-10-24 07:09:13.210500', '15', '鸡肉', '1', '[{\"added\": {}}]', '9', '16');
INSERT INTO `django_admin_log` VALUES ('54', '2019-10-24 07:10:19.081185', '16', '鸭蛋', '1', '[{\"added\": {}}]', '9', '16');
INSERT INTO `django_admin_log` VALUES ('55', '2019-10-24 07:11:49.334466', '17', '鸡腿', '1', '[{\"added\": {}}]', '9', '16');
INSERT INTO `django_admin_log` VALUES ('56', '2019-10-24 07:12:52.972115', '18', '白菜', '1', '[{\"added\": {}}]', '9', '16');
INSERT INTO `django_admin_log` VALUES ('57', '2019-10-24 07:13:46.541717', '19', '芹菜', '1', '[{\"added\": {}}]', '9', '16');
INSERT INTO `django_admin_log` VALUES ('58', '2019-10-24 07:15:15.079030', '20', '香菜', '1', '[{\"added\": {}}]', '9', '16');
INSERT INTO `django_admin_log` VALUES ('59', '2019-10-24 07:16:19.173299', '21', '冬瓜', '1', '[{\"added\": {}}]', '9', '16');
INSERT INTO `django_admin_log` VALUES ('60', '2019-10-24 07:17:15.298632', '22', '鱼丸', '1', '[{\"added\": {}}]', '9', '16');
INSERT INTO `django_admin_log` VALUES ('61', '2019-10-24 07:18:07.456608', '23', '蟹棒', '1', '[{\"added\": {}}]', '9', '16');
INSERT INTO `django_admin_log` VALUES ('62', '2019-10-24 07:18:59.400749', '24', '虾丸', '1', '[{\"added\": {}}]', '9', '16');
INSERT INTO `django_admin_log` VALUES ('63', '2019-10-24 07:20:01.191759', '25', '速冻水饺', '1', '[{\"added\": {}}]', '9', '16');
INSERT INTO `django_admin_log` VALUES ('64', '2019-10-24 07:22:04.581135', '26', '越南芒果', '1', '[{\"added\": {}}]', '9', '16');
INSERT INTO `django_admin_log` VALUES ('65', '2019-10-24 07:23:46.372842', '27', '鹌鹑蛋', '1', '[{\"added\": {}}]', '9', '16');
INSERT INTO `django_admin_log` VALUES ('66', '2019-10-24 07:24:36.225404', '28', '鹅蛋', '1', '[{\"added\": {}}]', '9', '16');
INSERT INTO `django_admin_log` VALUES ('67', '2019-10-24 07:25:45.641170', '29', '红辣椒', '1', '[{\"added\": {}}]', '9', '16');
INSERT INTO `django_admin_log` VALUES ('68', '2019-10-24 07:28:38.488742', '1', '葡萄', '1', '[{\"added\": {}}]', '13', '16');
INSERT INTO `django_admin_log` VALUES ('69', '2019-10-24 07:29:13.640818', '2', '越南芒果', '1', '[{\"added\": {}}]', '13', '16');
INSERT INTO `django_admin_log` VALUES ('70', '2019-10-24 07:29:35.436850', '3', '牛排', '1', '[{\"added\": {}}]', '13', '16');
INSERT INTO `django_admin_log` VALUES ('71', '2019-10-24 07:29:49.192444', '4', '基围虾', '1', '[{\"added\": {}}]', '13', '16');
INSERT INTO `django_admin_log` VALUES ('72', '2019-10-24 07:32:52.765091', '1', '猪牛羊肉 - 草莓 500g', '1', '[{\"added\": {}}]', '12', '16');
INSERT INTO `django_admin_log` VALUES ('73', '2019-10-24 07:33:26.643792', '1', '猪牛羊肉 - 猪肉', '2', '[{\"changed\": {\"fields\": [\"sku\"]}}]', '12', '16');
INSERT INTO `django_admin_log` VALUES ('74', '2019-10-24 07:33:52.803736', '2', '猪牛羊肉 - 鸡腿', '1', '[{\"added\": {}}]', '12', '16');
INSERT INTO `django_admin_log` VALUES ('75', '2019-10-24 07:34:09.668903', '3', '猪牛羊肉 - 羊肉', '1', '[{\"added\": {}}]', '12', '16');
INSERT INTO `django_admin_log` VALUES ('76', '2019-10-24 07:34:17.038851', '2', '猪牛羊肉 - 鸡腿', '2', '[{\"changed\": {\"fields\": [\"index\"]}}]', '12', '16');
INSERT INTO `django_admin_log` VALUES ('77', '2019-10-24 07:34:21.669054', '3', '猪牛羊肉 - 羊肉', '2', '[{\"changed\": {\"fields\": [\"index\"]}}]', '12', '16');
INSERT INTO `django_admin_log` VALUES ('78', '2019-10-24 07:34:34.543947', '4', '猪牛羊肉 - 牛排', '1', '[{\"added\": {}}]', '12', '16');
INSERT INTO `django_admin_log` VALUES ('79', '2019-10-24 07:35:16.883380', '5', '猪牛羊肉 - 鸡肉', '1', '[{\"added\": {}}]', '12', '16');
INSERT INTO `django_admin_log` VALUES ('80', '2019-10-24 07:35:43.868360', '6', '新鲜水果 - 草莓 500g', '1', '[{\"added\": {}}]', '12', '16');
INSERT INTO `django_admin_log` VALUES ('81', '2019-10-24 07:35:55.527900', '7', '新鲜水果 - 葡萄', '1', '[{\"added\": {}}]', '12', '16');
INSERT INTO `django_admin_log` VALUES ('82', '2019-10-24 07:36:10.275882', '8', '新鲜水果 - 奇异果', '1', '[{\"added\": {}}]', '12', '16');
INSERT INTO `django_admin_log` VALUES ('83', '2019-10-24 07:36:27.771642', '9', '新鲜水果 - 柠檬', '1', '[{\"added\": {}}]', '12', '16');
INSERT INTO `django_admin_log` VALUES ('84', '2019-10-24 07:36:51.758559', '10', '新鲜水果 - 盒装草莓', '1', '[{\"added\": {}}]', '12', '16');
INSERT INTO `django_admin_log` VALUES ('85', '2019-10-24 07:37:59.698419', '11', '海鲜水产 - 大青虾', '1', '[{\"added\": {}}]', '12', '16');
INSERT INTO `django_admin_log` VALUES ('86', '2019-10-24 07:38:11.340945', '12', '海鲜水产 - 北海道秋刀鱼', '1', '[{\"added\": {}}]', '12', '16');
INSERT INTO `django_admin_log` VALUES ('87', '2019-10-24 07:38:24.851887', '13', '海鲜水产 - 扇贝', '1', '[{\"added\": {}}]', '12', '16');
INSERT INTO `django_admin_log` VALUES ('88', '2019-10-24 07:38:37.525260', '14', '海鲜水产 - 基围虾', '1', '[{\"added\": {}}]', '12', '16');
INSERT INTO `django_admin_log` VALUES ('89', '2019-10-24 07:39:01.783887', '15', '海鲜水产 - 基围虾', '1', '[{\"added\": {}}]', '12', '16');
INSERT INTO `django_admin_log` VALUES ('90', '2019-10-24 07:39:14.326057', '16', '海鲜水产 - 扇贝', '1', '[{\"added\": {}}]', '12', '16');
INSERT INTO `django_admin_log` VALUES ('91', '2019-10-24 07:40:21.892957', '17', '禽类蛋品 - 盒装鸡蛋', '1', '[{\"added\": {}}]', '12', '16');
INSERT INTO `django_admin_log` VALUES ('92', '2019-10-24 07:40:40.678216', '18', '禽类蛋品 - 鸭蛋', '1', '[{\"added\": {}}]', '12', '16');
INSERT INTO `django_admin_log` VALUES ('93', '2019-10-24 07:41:06.191424', '19', '禽类蛋品 - 鹌鹑蛋', '1', '[{\"added\": {}}]', '12', '16');
INSERT INTO `django_admin_log` VALUES ('94', '2019-10-24 07:41:27.810177', '20', '禽类蛋品 - 鹅蛋', '1', '[{\"added\": {}}]', '12', '16');
INSERT INTO `django_admin_log` VALUES ('95', '2019-10-24 07:41:49.550969', '21', '禽类蛋品 - 盒装鸡蛋', '1', '[{\"added\": {}}]', '12', '16');
INSERT INTO `django_admin_log` VALUES ('96', '2019-10-24 07:42:03.092792', '22', '禽类蛋品 - 鹅蛋', '1', '[{\"added\": {}}]', '12', '16');
INSERT INTO `django_admin_log` VALUES ('97', '2019-10-24 07:42:14.914532', '22', '禽类蛋品 - 鹅蛋', '2', '[{\"changed\": {\"fields\": [\"index\"]}}]', '12', '16');
INSERT INTO `django_admin_log` VALUES ('98', '2019-10-24 07:42:56.034088', '23', '新鲜蔬菜 - 白菜', '1', '[{\"added\": {}}]', '12', '16');
INSERT INTO `django_admin_log` VALUES ('99', '2019-10-24 07:43:09.320214', '24', '新鲜蔬菜 - 芹菜', '1', '[{\"added\": {}}]', '12', '16');
INSERT INTO `django_admin_log` VALUES ('100', '2019-10-24 07:43:23.399179', '25', '新鲜蔬菜 - 香菜', '1', '[{\"added\": {}}]', '12', '16');
INSERT INTO `django_admin_log` VALUES ('101', '2019-10-24 07:43:36.647156', '26', '新鲜蔬菜 - 红辣椒', '1', '[{\"added\": {}}]', '12', '16');
INSERT INTO `django_admin_log` VALUES ('102', '2019-10-24 07:44:07.740480', '27', '新鲜蔬菜 - 香菜', '1', '[{\"added\": {}}]', '12', '16');
INSERT INTO `django_admin_log` VALUES ('103', '2019-10-24 07:44:17.666170', '28', '新鲜蔬菜 - 芹菜', '1', '[{\"added\": {}}]', '12', '16');
INSERT INTO `django_admin_log` VALUES ('104', '2019-10-24 07:44:38.856243', '29', '速冻食品 - 鱼丸', '1', '[{\"added\": {}}]', '12', '16');
INSERT INTO `django_admin_log` VALUES ('105', '2019-10-24 07:44:49.249480', '30', '速冻食品 - 蟹棒', '1', '[{\"added\": {}}]', '12', '16');
INSERT INTO `django_admin_log` VALUES ('106', '2019-10-24 07:45:02.105719', '31', '速冻食品 - 虾丸', '1', '[{\"added\": {}}]', '12', '16');
INSERT INTO `django_admin_log` VALUES ('107', '2019-10-24 07:45:13.061815', '32', '速冻食品 - 速冻水饺', '1', '[{\"added\": {}}]', '12', '16');
INSERT INTO `django_admin_log` VALUES ('108', '2019-10-24 07:45:24.955185', '33', '速冻食品 - 蟹棒', '1', '[{\"added\": {}}]', '12', '16');
INSERT INTO `django_admin_log` VALUES ('109', '2019-10-24 07:45:35.324966', '34', '速冻食品 - 速冻水饺', '1', '[{\"added\": {}}]', '12', '16');
INSERT INTO `django_admin_log` VALUES ('110', '2019-10-24 11:26:49.145228', '1', '猪牛羊肉 - 猪肉', '2', '[{\"changed\": {\"fields\": [\"index\"]}}]', '12', '16');
INSERT INTO `django_admin_log` VALUES ('111', '2019-10-24 11:31:28.075980', '1', '猪牛羊肉 - 猪肉', '2', '[{\"changed\": {\"fields\": [\"index\"]}}]', '12', '16');
INSERT INTO `django_admin_log` VALUES ('112', '2019-10-24 11:33:22.334475', '2', '猪牛羊肉 - 鸡腿', '2', '[{\"changed\": {\"fields\": [\"index\"]}}]', '12', '16');
INSERT INTO `django_admin_log` VALUES ('113', '2019-10-24 11:36:00.461093', '2', '猪牛羊肉 - 鸡腿', '2', '[{\"changed\": {\"fields\": [\"index\"]}}]', '12', '16');
INSERT INTO `django_admin_log` VALUES ('114', '2019-10-24 11:53:23.589974', '1', '猪牛羊肉 - 猪肉', '2', '[]', '12', '16');
INSERT INTO `django_admin_log` VALUES ('115', '2019-11-05 03:27:46.432092', '5', '奇异果', '2', '[{\"changed\": {\"fields\": [\"stock\", \"sales\"]}}]', '9', '16');
INSERT INTO `django_admin_log` VALUES ('116', '2019-11-05 03:45:31.051614', '15', '鸡肉', '2', '[{\"changed\": {\"fields\": [\"type\"]}}]', '9', '16');

-- ----------------------------
-- Table structure for django_content_type
-- ----------------------------
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_content_type
-- ----------------------------
INSERT INTO `django_content_type` VALUES ('1', 'admin', 'logentry');
INSERT INTO `django_content_type` VALUES ('3', 'auth', 'group');
INSERT INTO `django_content_type` VALUES ('2', 'auth', 'permission');
INSERT INTO `django_content_type` VALUES ('4', 'contenttypes', 'contenttype');
INSERT INTO `django_content_type` VALUES ('8', 'goods', 'goods');
INSERT INTO `django_content_type` VALUES ('14', 'goods', 'goodsimage');
INSERT INTO `django_content_type` VALUES ('9', 'goods', 'goodssku');
INSERT INTO `django_content_type` VALUES ('10', 'goods', 'goodstype');
INSERT INTO `django_content_type` VALUES ('13', 'goods', 'indexgoodsbanner');
INSERT INTO `django_content_type` VALUES ('11', 'goods', 'indexpromotionbanner');
INSERT INTO `django_content_type` VALUES ('12', 'goods', 'indextypegoodsbanner');
INSERT INTO `django_content_type` VALUES ('15', 'order', 'ordergoods');
INSERT INTO `django_content_type` VALUES ('16', 'order', 'orderinfo');
INSERT INTO `django_content_type` VALUES ('5', 'sessions', 'session');
INSERT INTO `django_content_type` VALUES ('7', 'user', 'address');
INSERT INTO `django_content_type` VALUES ('6', 'user', 'user');

-- ----------------------------
-- Table structure for django_migrations
-- ----------------------------
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_migrations
-- ----------------------------
INSERT INTO `django_migrations` VALUES ('1', 'contenttypes', '0001_initial', '2019-10-19 05:51:55.467411');
INSERT INTO `django_migrations` VALUES ('2', 'contenttypes', '0002_remove_content_type_name', '2019-10-19 05:51:55.601622');
INSERT INTO `django_migrations` VALUES ('3', 'auth', '0001_initial', '2019-10-19 05:51:55.766559');
INSERT INTO `django_migrations` VALUES ('4', 'auth', '0002_alter_permission_name_max_length', '2019-10-19 05:51:56.121449');
INSERT INTO `django_migrations` VALUES ('5', 'auth', '0003_alter_user_email_max_length', '2019-10-19 05:51:56.128449');
INSERT INTO `django_migrations` VALUES ('6', 'auth', '0004_alter_user_username_opts', '2019-10-19 05:51:56.134451');
INSERT INTO `django_migrations` VALUES ('7', 'auth', '0005_alter_user_last_login_null', '2019-10-19 05:51:56.140145');
INSERT INTO `django_migrations` VALUES ('8', 'auth', '0006_require_contenttypes_0002', '2019-10-19 05:51:56.142145');
INSERT INTO `django_migrations` VALUES ('9', 'auth', '0007_alter_validators_add_error_messages', '2019-10-19 05:51:56.148147');
INSERT INTO `django_migrations` VALUES ('10', 'auth', '0008_alter_user_username_max_length', '2019-10-19 05:51:56.153148');
INSERT INTO `django_migrations` VALUES ('11', 'auth', '0009_alter_user_last_name_max_length', '2019-10-19 05:51:56.159149');
INSERT INTO `django_migrations` VALUES ('12', 'auth', '0010_alter_group_name_max_length', '2019-10-19 05:51:56.245179');
INSERT INTO `django_migrations` VALUES ('13', 'auth', '0011_update_proxy_permissions', '2019-10-19 05:51:56.258180');
INSERT INTO `django_migrations` VALUES ('14', 'user', '0001_initial', '2019-10-19 05:51:56.447461');
INSERT INTO `django_migrations` VALUES ('15', 'admin', '0001_initial', '2019-10-19 05:51:57.109535');
INSERT INTO `django_migrations` VALUES ('16', 'admin', '0002_logentry_remove_auto_add', '2019-10-19 05:51:57.277848');
INSERT INTO `django_migrations` VALUES ('17', 'admin', '0003_logentry_add_action_flag_choices', '2019-10-19 05:51:57.287850');
INSERT INTO `django_migrations` VALUES ('18', 'goods', '0001_initial', '2019-10-19 05:51:57.746937');
INSERT INTO `django_migrations` VALUES ('19', 'order', '0001_initial', '2019-10-19 05:51:58.309820');
INSERT INTO `django_migrations` VALUES ('20', 'order', '0002_auto_20191019_1351', '2019-10-19 05:51:58.628834');
INSERT INTO `django_migrations` VALUES ('21', 'sessions', '0001_initial', '2019-10-19 05:51:59.113417');

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_session
-- ----------------------------
INSERT INTO `django_session` VALUES ('1z7pgafhbz1de6kf03fvkdmi4fadwwgs', 'NTk4ZjgwYjcyMmZiMjRmYjE2YTJiMzMzNTJjZjEwZjlkMTc2MTM1Zjp7Il9hdXRoX3VzZXJfaWQiOiIxMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiODY2N2YyZGUyZDc4NjE4OWI1ODgzZjQ0YmIzNGFmNzg3OTMxZGMxYiJ9', '2019-11-03 04:42:58.833929');
