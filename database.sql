/*
 Navicat Premium Data Transfer

 Source Server         : newspaper
 Source Server Type    : MySQL
 Source Server Version : 50732
 Source Host           : localhost:8889
 Source Schema         : newspaper

 Target Server Type    : MySQL
 Target Server Version : 50732
 File Encoding         : 65001

 Date: 27/07/2021 00:37:41
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for Admins
-- ----------------------------
DROP TABLE IF EXISTS `Admins`;
CREATE TABLE `Admins` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(50) NOT NULL,
  `UserName` varchar(50) NOT NULL,
  `Password` varchar(255) NOT NULL,
  `Address` varchar(255) DEFAULT NULL,
  `BirthDay` date DEFAULT NULL,
  `Email` varchar(255) NOT NULL,
  PRIMARY KEY (`ID`) USING BTREE,
  UNIQUE KEY `AdminUniqueUsername` (`UserName`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of Admins
-- ----------------------------
BEGIN;
INSERT INTO `Admins` VALUES (1, 'Admin 1', 'adm1', '$2a$10$n1IhX5nX.9XzEao.cb9LUOIBGtV.RE0bwSciiqohxTfdzjKkWPv0G', '10 Truong Chinh', NULL, 'hieuflong@gmail.com');
INSERT INTO `Admins` VALUES (2, 'Admin 2', 'admin', '$2a$10$9VYfnavcm1XMvikacJA5GOGvFz5bOY6mPBorehYZuAFNh.x7w590.', NULL, NULL, 'admin@gmail.com');
COMMIT;

-- ----------------------------
-- Table structure for Categories
-- ----------------------------
DROP TABLE IF EXISTS `Categories`;
CREATE TABLE `Categories` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `ParentID` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `CategorieUniqueName` (`Name`),
  KEY `Cat_ParentID` (`ParentID`),
  CONSTRAINT `CatParent` FOREIGN KEY (`ParentID`) REFERENCES `Categories` (`ID`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of Categories
-- ----------------------------
BEGIN;
INSERT INTO `Categories` VALUES (1, 'Giao thông', 8);
INSERT INTO `Categories` VALUES (2, 'Giải trí', NULL);
INSERT INTO `Categories` VALUES (3, 'Hải sản', 4);
INSERT INTO `Categories` VALUES (4, 'Kinh doanh', NULL);
INSERT INTO `Categories` VALUES (5, 'Nông sản', 4);
INSERT INTO `Categories` VALUES (6, 'Phim ảnh', 2);
INSERT INTO `Categories` VALUES (7, 'Chuyện của Sao', 2);
INSERT INTO `Categories` VALUES (8, 'Thời sự', NULL);
INSERT INTO `Categories` VALUES (9, 'Chính trị', 8);
INSERT INTO `Categories` VALUES (10, 'Du lịch', NULL);
INSERT INTO `Categories` VALUES (11, 'Du lịch Trong Nước', 10);
INSERT INTO `Categories` VALUES (12, 'Du lịch Thế Giới', 10);
INSERT INTO `Categories` VALUES (13, 'Sức khỏe', NULL);
INSERT INTO `Categories` VALUES (14, 'Dinh Dưỡng', 13);
INSERT INTO `Categories` VALUES (15, 'Bệnh tật', 13);
INSERT INTO `Categories` VALUES (16, 'Thể thao', NULL);
INSERT INTO `Categories` VALUES (17, 'Bóng đá', 16);
INSERT INTO `Categories` VALUES (18, 'Các môn khác', 16);
COMMIT;

-- ----------------------------
-- Table structure for Comments
-- ----------------------------
DROP TABLE IF EXISTS `Comments`;
CREATE TABLE `Comments` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ReaderID` int(11) DEFAULT NULL,
  `PostID` int(11) NOT NULL,
  `PubTime` datetime NOT NULL,
  `Content` longtext NOT NULL,
  `RoleReaderID` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `Readers_ReaderIReader_ReaderID` (`ReaderID`),
  KEY `Post_PostID` (`PostID`),
  CONSTRAINT `CommentPost` FOREIGN KEY (`PostID`) REFERENCES `Posts` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `CommentReader` FOREIGN KEY (`ReaderID`) REFERENCES `Readers` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of Comments
-- ----------------------------
BEGIN;
INSERT INTO `Comments` VALUES (1, 1, 4, '2021-06-24 21:50:36', 'Bài viết hay', 'reader');
INSERT INTO `Comments` VALUES (2, 2, 7, '2021-06-24 21:51:27', 'Thật sự đỉnh, không thể tin được luôn.', 'reader');
INSERT INTO `Comments` VALUES (9, 1, 24, '2021-07-08 00:00:00', 'reader1', 'writer');
INSERT INTO `Comments` VALUES (10, 2, 7, '2021-07-11 00:00:00', 'alo', 'writer');
INSERT INTO `Comments` VALUES (11, 1, 7, '2021-07-11 00:00:00', 'alo', 'guest');
COMMIT;

-- ----------------------------
-- Table structure for Drafts
-- ----------------------------
DROP TABLE IF EXISTS `Drafts`;
CREATE TABLE `Drafts` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `PostID` int(11) NOT NULL,
  `EditorID` int(11) NOT NULL,
  `Note` mediumtext NOT NULL,
  `RateTime` datetime NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `Posts_PostID` (`PostID`),
  KEY `Editors_EditorID` (`EditorID`),
  CONSTRAINT `DraftEditor` FOREIGN KEY (`EditorID`) REFERENCES `Editors` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `DraftPost` FOREIGN KEY (`PostID`) REFERENCES `Posts` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of Drafts
-- ----------------------------
BEGIN;
INSERT INTO `Drafts` VALUES (1, 4, 1, 'Không đúng tiêu đề', '2021-07-06 01:18:12');
INSERT INTO `Drafts` VALUES (2, 18, 2, 'Tóm tắt cần ngắn gọn', '2021-07-15 05:04:30');
INSERT INTO `Drafts` VALUES (3, 20, 1, 'Thông tin quá ngắn', '2021-07-18 05:04:55');
INSERT INTO `Drafts` VALUES (4, 24, 2, 'Chưa có ảnh hợp lý', '2021-07-19 05:05:16');
COMMIT;

-- ----------------------------
-- Table structure for Editors
-- ----------------------------
DROP TABLE IF EXISTS `Editors`;
CREATE TABLE `Editors` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(50) NOT NULL,
  `UserName` varchar(50) NOT NULL,
  `Password` varchar(255) NOT NULL,
  `Address` varchar(255) DEFAULT NULL,
  `BirthDay` date DEFAULT NULL,
  `Email` varchar(255) NOT NULL,
  `CatID` int(11) NOT NULL,
  PRIMARY KEY (`ID`) USING BTREE,
  UNIQUE KEY `EditorUniqueUsername` (`UserName`),
  KEY `cat_catID` (`CatID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of Editors
-- ----------------------------
BEGIN;
INSERT INTO `Editors` VALUES (1, 'Editor 1', 'edt1', '$2a$10$PVQowrDoFnb61ixyiNRVl.Ntlu4l9aeqbFCRjTjzi353/Fy83fN7S', '10 Truong Chinh', NULL, 'hieuflong@gmail.com', 1);
INSERT INTO `Editors` VALUES (2, 'Editor 2', 'edt2', '$2a$10$rSqL5/s/ns5TsczY59CZZOglkbRR1FRo9Qp0ogImNgqjKbbbr1ns2', '10 Pham Ngu Lao', NULL, 'editor@gmail.com', 4);
COMMIT;

-- ----------------------------
-- Table structure for FacebookAcount
-- ----------------------------
DROP TABLE IF EXISTS `FacebookAcount`;
CREATE TABLE `FacebookAcount` (
  `FbID` char(255) NOT NULL,
  `ReaderID` int(11) NOT NULL,
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`ID`) USING BTREE,
  KEY `FbReader` (`ReaderID`),
  CONSTRAINT `FbReader` FOREIGN KEY (`ReaderID`) REFERENCES `Readers` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of FacebookAcount
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for GoogleAcount
-- ----------------------------
DROP TABLE IF EXISTS `GoogleAcount`;
CREATE TABLE `GoogleAcount` (
  `GoogleID` char(255) NOT NULL,
  `ReaderID` int(11) NOT NULL,
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`ID`) USING BTREE,
  KEY `GoogleReader` (`ReaderID`),
  CONSTRAINT `GoogleReader` FOREIGN KEY (`ReaderID`) REFERENCES `Readers` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of GoogleAcount
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for PostTag
-- ----------------------------
DROP TABLE IF EXISTS `PostTag`;
CREATE TABLE `PostTag` (
  `PostID` int(11) NOT NULL,
  `TagID` int(11) NOT NULL,
  PRIMARY KEY (`PostID`,`TagID`),
  KEY `tag_idTag` (`TagID`),
  CONSTRAINT `PostTag1` FOREIGN KEY (`PostID`) REFERENCES `Posts` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `PostTag2` FOREIGN KEY (`TagID`) REFERENCES `Tags` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of PostTag
-- ----------------------------
BEGIN;
INSERT INTO `PostTag` VALUES (7, 2);
INSERT INTO `PostTag` VALUES (24, 5);
INSERT INTO `PostTag` VALUES (26, 5);
INSERT INTO `PostTag` VALUES (26, 8);
INSERT INTO `PostTag` VALUES (5, 10);
INSERT INTO `PostTag` VALUES (1, 11);
INSERT INTO `PostTag` VALUES (12, 11);
INSERT INTO `PostTag` VALUES (21, 11);
INSERT INTO `PostTag` VALUES (22, 11);
INSERT INTO `PostTag` VALUES (26, 11);
INSERT INTO `PostTag` VALUES (11, 12);
INSERT INTO `PostTag` VALUES (11, 14);
INSERT INTO `PostTag` VALUES (14, 15);
INSERT INTO `PostTag` VALUES (14, 16);
INSERT INTO `PostTag` VALUES (14, 17);
INSERT INTO `PostTag` VALUES (22, 18);
INSERT INTO `PostTag` VALUES (26, 18);
INSERT INTO `PostTag` VALUES (22, 19);
INSERT INTO `PostTag` VALUES (22, 20);
INSERT INTO `PostTag` VALUES (21, 23);
INSERT INTO `PostTag` VALUES (21, 24);
INSERT INTO `PostTag` VALUES (19, 25);
COMMIT;

-- ----------------------------
-- Table structure for Posts
-- ----------------------------
DROP TABLE IF EXISTS `Posts`;
CREATE TABLE `Posts` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Title` varchar(255) NOT NULL,
  `WriterID` int(11) NOT NULL,
  `EditorID` int(11) NOT NULL,
  `CatID` int(11) NOT NULL,
  `StateID` int(11) NOT NULL DEFAULT '0',
  `Content` longtext NOT NULL,
  `Abstract` mediumtext NOT NULL,
  `WriteTime` datetime NOT NULL,
  `PubTime` datetime DEFAULT NULL,
  `Views` int(10) unsigned NOT NULL DEFAULT '0',
  `Premium` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `PostUniqueTitleWriter` (`Title`,`WriterID`),
  KEY `Posts_Categories` (`CatID`),
  KEY `Writers_Cat` (`WriterID`),
  FULLTEXT KEY `Abstract_Content` (`Abstract`,`Content`),
  FULLTEXT KEY `Title` (`Title`),
  FULLTEXT KEY `Title_Abstract_Content` (`Title`,`Abstract`,`Content`),
  CONSTRAINT `PostCat` FOREIGN KEY (`CatID`) REFERENCES `Categories` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `PostWriter` FOREIGN KEY (`WriterID`) REFERENCES `Writers` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of Posts
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for Readers
-- ----------------------------
DROP TABLE IF EXISTS `Readers`;
CREATE TABLE `Readers` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(50) NOT NULL,
  `UserName` varchar(50) NOT NULL,
  `Password` varchar(255) NOT NULL,
  `Address` varchar(255) DEFAULT NULL,
  `BirthDay` date DEFAULT NULL,
  `Email` varchar(255) NOT NULL,
  `ExpTime` datetime DEFAULT NULL,
  `OTP` int(11) NOT NULL,
  `SubPremium` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ReadersUniqueUsername` (`UserName`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of Readers
-- ----------------------------
BEGIN;
INSERT INTO `Readers` VALUES (1, 'Vuong Nguyen Thi Minh', 'rd1', '$2a$10$PVQowrDoFnb61ixyiNRVl.Ntlu4l9aeqbFCRjTjzi353/Fy83fN7S', '10 Truong Chinh', NULL, 'hieuflong@gmail.com', NULL, -1, 0);
INSERT INTO `Readers` VALUES (2, 'Trinh', 'rd2', '$2a$10$PVQowrDoFnb61ixyiNRVl.Ntlu4l9aeqbFCRjTjzi353/Fy83fN7S', '10 Truong Chinh', NULL, 'hieuflong@gmail.com', '2021-06-21 00:00:00', -1, 0);
INSERT INTO `Readers` VALUES (3, 'Vuong Nguyen Thi Minh', 'vuong', '$2a$10$yXSzv2J2YSJsgoOaOZ8Px.zHQK058tr8s0yBz7WvBheE6HB.v2l4i', '227 Nguyen Van Cu, District 5,', '2000-06-16', 'thienthanvodanh2000@gmail.com', NULL, -1, 0);
INSERT INTO `Readers` VALUES (4, 'Vuong Nguyen Thi Minh', 'wrt3', '$2a$10$h8sIJeTXpj.BNiEecsJ/ZOq44cnUHwyyyCGmtXIHLHngdU2PATNni', '227 Nguyen Van Cu, District 5,', '2021-07-07', 'hello@gmail.com', NULL, -1, 0);
INSERT INTO `Readers` VALUES (8, 'Vuong Nguyen Thi Minh', 'vuong2000', '$2a$10$..xUaY3mfiJd4lFN0v4QH.2RWl0daz0qdbKViwiUuFCJGmIp9KMVe', '227 Nguyen Van Cu, District 5,', '2021-07-20', 'thinhvuong9700@gmail.com', NULL, -1, 0);
INSERT INTO `Readers` VALUES (9, 'VuongHieuTrinh Newspaper', 'newspaper.vuonghieutrinh@gmail.com', '$2a$10$ZYXvXy4r09oMeK.9la9mGOnsu3499IB5wpnZGb8dr3rKORVfMx5Ti', NULL, NULL, 'newspaper.vuonghieutrinh@gmail.com', NULL, -1, 0);
COMMIT;

-- ----------------------------
-- Table structure for Tags
-- ----------------------------
DROP TABLE IF EXISTS `Tags`;
CREATE TABLE `Tags` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(50) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `TagUniqueName` (`Name`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of Tags
-- ----------------------------
BEGIN;
INSERT INTO `Tags` VALUES (15, 'amthuc');
INSERT INTO `Tags` VALUES (1, 'baucu');
INSERT INTO `Tags` VALUES (19, 'bongdaVietNam');
INSERT INTO `Tags` VALUES (16, 'chaua');
INSERT INTO `Tags` VALUES (25, 'congnghe');
INSERT INTO `Tags` VALUES (23, 'daihoc');
INSERT INTO `Tags` VALUES (14, 'danhlamthangcanh');
INSERT INTO `Tags` VALUES (24, 'diemchuan');
INSERT INTO `Tags` VALUES (18, 'doituyenquocgia');
INSERT INTO `Tags` VALUES (35, 'draft');
INSERT INTO `Tags` VALUES (2, 'drama');
INSERT INTO `Tags` VALUES (12, 'dulich');
INSERT INTO `Tags` VALUES (27, 'giaovien');
INSERT INTO `Tags` VALUES (4, 'haisan');
INSERT INTO `Tags` VALUES (36, 'hehe');
INSERT INTO `Tags` VALUES (3, 'hoinghi');
INSERT INTO `Tags` VALUES (5, 'kinhdi');
INSERT INTO `Tags` VALUES (17, 'monngon');
INSERT INTO `Tags` VALUES (6, 'nongsan');
INSERT INTO `Tags` VALUES (7, 'quocte');
INSERT INTO `Tags` VALUES (9, 'tainan');
INSERT INTO `Tags` VALUES (21, 'thidau');
INSERT INTO `Tags` VALUES (22, 'thpt');
INSERT INTO `Tags` VALUES (8, 'tinhcam');
INSERT INTO `Tags` VALUES (26, 'toanhoc');
INSERT INTO `Tags` VALUES (10, 'trongnuoc');
INSERT INTO `Tags` VALUES (11, 'vientuong');
INSERT INTO `Tags` VALUES (20, 'worldcup');
COMMIT;

-- ----------------------------
-- Table structure for Writers
-- ----------------------------
DROP TABLE IF EXISTS `Writers`;
CREATE TABLE `Writers` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(50) NOT NULL,
  `NickName` varchar(50) DEFAULT NULL,
  `UserName` varchar(50) NOT NULL,
  `Password` varchar(255) NOT NULL,
  `Address` varchar(255) DEFAULT NULL,
  `BirthDay` date DEFAULT NULL,
  `Email` varchar(255) NOT NULL,
  `Active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`ID`) USING BTREE,
  UNIQUE KEY `WriterUniqueUsername` (`UserName`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of Writers
-- ----------------------------
BEGIN;
INSERT INTO `Writers` VALUES (1, 'Writer 1', 'Huan Hoa Hong', 'wrt1', '$2a$10$PVQowrDoFnb61ixyiNRVl.Ntlu4l9aeqbFCRjTjzi353/Fy83fN7S', '10 Truong Chinh', NULL, 'hieuflong@gmail.com', 1);
INSERT INTO `Writers` VALUES (2, 'Writer 2', 'Cuc Bach Mai', 'wrt2', '$2a$10$VmT9wfxpoOAvz9e/kVJCkOvkON1CvhJULiDy5gTfkixFczsHe9xke', '20 An Duong Vuong', NULL, 'wrt@gmail.com', 1);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
