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
-- Table structure for Posts
-- ----------------------------
DROP TABLE IF EXISTS `Posts`;
CREATE TABLE `Posts` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Title` varchar(255) NOT NULL,
  `WriterID` int(11) NOT NULL,
  `EditorID` int(11),
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


SET FOREIGN_KEY_CHECKS = 1;
