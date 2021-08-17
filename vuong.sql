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

 Date: 17/08/2021 12:19:05
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
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of Drafts
-- ----------------------------
BEGIN;
INSERT INTO `Drafts` VALUES (1, 3, 1, 'Nội dung chưa phù hợp', '2021-08-16 21:55:19');
INSERT INTO `Drafts` VALUES (2, 8, 2, 'nội dung kích thích', '2021-08-16 22:14:58');
INSERT INTO `Drafts` VALUES (3, 15, 3, 'ảnh đại diện không đúng', '2021-08-16 22:17:07');
INSERT INTO `Drafts` VALUES (4, 18, 4, 'nội dung cần dài hơn', '2021-08-16 22:18:02');
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of Editors
-- ----------------------------
BEGIN;
INSERT INTO `Editors` VALUES (1, 'Editor 1', 'edt1', '$2a$10$PVQowrDoFnb61ixyiNRVl.Ntlu4l9aeqbFCRjTjzi353/Fy83fN7S', '10 Truong Chinh', '1997-08-16', 'editor1@gmail.com', 3);
INSERT INTO `Editors` VALUES (2, 'Editor 2', 'edt2', '$2a$10$rSqL5/s/ns5TsczY59CZZOglkbRR1FRo9Qp0ogImNgqjKbbbr1ns2', '10 Pham Ngu Lao', '2000-08-16', 'editor2@gmail.com', 5);
INSERT INTO `Editors` VALUES (3, 'Editor 3', 'edt3', '$2a$10$PVQowrDoFnb61ixyiNRVl.Ntlu4l9aeqbFCRjTjzi353/Fy83fN7S', '21 Phạm Ngũ Lão', '1994-02-16', 'editor3@gmail.com', 6);
INSERT INTO `Editors` VALUES (4, 'Editor 4', 'edt4', '$2a$10$PVQowrDoFnb61ixyiNRVl.Ntlu4l9aeqbFCRjTjzi353/Fy83fN7S', '24 Duy Anh', '1999-08-21', 'editor4@gmail.com', 7);
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
INSERT INTO `PostTag` VALUES (18, 1);
INSERT INTO `PostTag` VALUES (8, 2);
INSERT INTO `PostTag` VALUES (10, 2);
INSERT INTO `PostTag` VALUES (11, 2);
INSERT INTO `PostTag` VALUES (12, 2);
INSERT INTO `PostTag` VALUES (13, 2);
INSERT INTO `PostTag` VALUES (14, 2);
INSERT INTO `PostTag` VALUES (15, 2);
INSERT INTO `PostTag` VALUES (16, 2);
INSERT INTO `PostTag` VALUES (19, 2);
INSERT INTO `PostTag` VALUES (20, 2);
INSERT INTO `PostTag` VALUES (7, 3);
INSERT INTO `PostTag` VALUES (1, 4);
INSERT INTO `PostTag` VALUES (2, 4);
INSERT INTO `PostTag` VALUES (3, 4);
INSERT INTO `PostTag` VALUES (4, 4);
INSERT INTO `PostTag` VALUES (5, 4);
INSERT INTO `PostTag` VALUES (6, 6);
INSERT INTO `PostTag` VALUES (7, 6);
INSERT INTO `PostTag` VALUES (8, 6);
INSERT INTO `PostTag` VALUES (9, 6);
INSERT INTO `PostTag` VALUES (10, 6);
INSERT INTO `PostTag` VALUES (11, 7);
INSERT INTO `PostTag` VALUES (12, 7);
INSERT INTO `PostTag` VALUES (13, 7);
INSERT INTO `PostTag` VALUES (16, 7);
INSERT INTO `PostTag` VALUES (17, 7);
INSERT INTO `PostTag` VALUES (19, 7);
INSERT INTO `PostTag` VALUES (12, 8);
INSERT INTO `PostTag` VALUES (14, 8);
INSERT INTO `PostTag` VALUES (15, 8);
INSERT INTO `PostTag` VALUES (16, 8);
INSERT INTO `PostTag` VALUES (19, 8);
INSERT INTO `PostTag` VALUES (20, 8);
INSERT INTO `PostTag` VALUES (2, 9);
INSERT INTO `PostTag` VALUES (1, 10);
INSERT INTO `PostTag` VALUES (2, 10);
INSERT INTO `PostTag` VALUES (3, 10);
INSERT INTO `PostTag` VALUES (5, 10);
INSERT INTO `PostTag` VALUES (6, 10);
INSERT INTO `PostTag` VALUES (8, 10);
INSERT INTO `PostTag` VALUES (9, 10);
INSERT INTO `PostTag` VALUES (10, 10);
INSERT INTO `PostTag` VALUES (20, 10);
INSERT INTO `PostTag` VALUES (4, 32);
INSERT INTO `PostTag` VALUES (11, 33);
INSERT INTO `PostTag` VALUES (12, 33);
INSERT INTO `PostTag` VALUES (14, 33);
INSERT INTO `PostTag` VALUES (15, 33);
INSERT INTO `PostTag` VALUES (17, 33);
INSERT INTO `PostTag` VALUES (18, 33);
INSERT INTO `PostTag` VALUES (19, 33);
INSERT INTO `PostTag` VALUES (3, 34);
INSERT INTO `PostTag` VALUES (4, 34);
INSERT INTO `PostTag` VALUES (7, 35);
INSERT INTO `PostTag` VALUES (9, 35);
INSERT INTO `PostTag` VALUES (20, 35);
INSERT INTO `PostTag` VALUES (18, 36);
INSERT INTO `PostTag` VALUES (19, 36);
INSERT INTO `PostTag` VALUES (5, 37);
INSERT INTO `PostTag` VALUES (6, 37);
INSERT INTO `PostTag` VALUES (8, 37);
INSERT INTO `PostTag` VALUES (9, 37);
INSERT INTO `PostTag` VALUES (13, 38);
INSERT INTO `PostTag` VALUES (16, 38);
INSERT INTO `PostTag` VALUES (17, 38);
INSERT INTO `PostTag` VALUES (18, 38);
INSERT INTO `PostTag` VALUES (19, 38);
INSERT INTO `PostTag` VALUES (20, 38);
COMMIT;

-- ----------------------------
-- Table structure for Posts
-- ----------------------------
DROP TABLE IF EXISTS `Posts`;
CREATE TABLE `Posts` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Title` varchar(255) NOT NULL,
  `WriterID` int(11) NOT NULL,
  `EditorID` int(11) DEFAULT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of Posts
-- ----------------------------
BEGIN;
INSERT INTO `Posts` VALUES (1, 'Nhiều loại hải sản có giá rẻ chưa từng có, cua biển chỉ từ 120.000 đồng/kg', 1, 1, 3, 1, '<p>Từ khi dịch bệnh Covid-19 diễn biến phức tạp, h&agrave;ng loạt nh&agrave; h&agrave;ng, qu&aacute;n ăn của hầu hết c&aacute;c địa phương phải đ&oacute;ng cửa, đồng thời dừng đ&oacute;n kh&aacute;ch du lịch ngoại tỉnh. V&igrave; vậy, nhiều loại hải sản của c&aacute;c t&agrave;u đ&aacute;nh bắt v&agrave; của c&aacute;c hộ d&acirc;n nu&ocirc;i trồng thủy hải sản rơi v&agrave;o t&igrave;nh trạng rớt gi&aacute; chưa từng c&oacute;.</p>\r\n<p>Tại Quảng Ninh, gi&aacute; h&agrave;u nu&ocirc;i tại b&egrave; giảm mạnh chỉ c&ograve;n khoảng 5-7.000 đồng/kg, ngao hai cồi cũng chỉ v&agrave;o khoảng 25-30.000 đồng/kg; bề bề giảm từ 300.000 đồng xuống chỉ c&ograve;n từ 130-180.000 đồng/kg; cua biển giảm từ 550-600.000 đồng/kg xuống c&ograve;n từ 300-350.000 đồng/kg.</p>', 'Việc vận chuyển gặp nhiều khó khăn cùng với sức mua kém đã khiến cho thị trường tiêu thụ hải sản giảm mạnh, kéo theo giá các mặt hàng này liên tục giảm sâu.', '2021-06-16 11:16:21', '2021-08-16 00:00:00', 12, 1);
INSERT INTO `Posts` VALUES (2, 'Tàu thu mua hải sản chìm trên biển Quảng Trị, 2 thuyền viên mất tích', 1, NULL, 3, 0, '<p>Theo đ&oacute;, khoảng 5h ng&agrave;y 27-5, trong lúc tu&acirc;̀n tra tr&ecirc;n bi&ecirc;̉n, các chi&ecirc;́n sĩ Đ&ocirc;̀n bi&ecirc;n phòng C&acirc;̀n Thạnh, B&ocirc;̣ đ&ocirc;̣i bi&ecirc;n phòng TP.HCM nhận được tin t&agrave;u k&eacute;o LA-50418 trong l&uacute;c di chuyển từ Long An về B&agrave; Rịa - Vũng T&agrave;u, đến khu vực TP.HCM thì bị mắc cạn v&agrave; bị s&agrave; lan k&eacute;o ph&iacute;a sau chạy l&ecirc;n đ&acirc;m tr&uacute;ng.</p>\r\n<p>Sự cố khiến t&agrave;u k&eacute;o bị vỡ đu&ocirc;i, ph&aacute; nước ch&igrave;m tr&ecirc;n biển.</p>\r\n<p>Theo đại &uacute;y Nguyễn Quốc Th&agrave;nh - ph&oacute; đồn trưởng Đồn bi&ecirc;n ph&ograve;ng Cần Thạnh, Bộ đội bi&ecirc;n ph&ograve;ng TP.HCM, sau khi ti&ecirc;́p c&acirc;̣n hi&ecirc;̣n trường, đơn vị đã nhanh chóng chăm s&oacute;c sức khỏe cho các c&aacute;c thuyền vi&ecirc;n.</p>\r\n<div id=\"zone-jnvk0c1v\">\r\n<div id=\"share-jnvk0cro\"></div>\r\n</div>\r\n<p>Hiện tại phương tiện bị ch&igrave;m đang được neo lại bằng phao b&egrave;, phao tr&ograve;n để đ&aacute;nh dấu vị tr&iacute;, phối hợp với c&aacute;c phương tiện được tăng cường để trục vớt.</p>', 'Một chiếc tàu thu mua hải sản gặp nạn tại vùng biển Quảng Trị. 7 thuyền viên đã được cứu, lực lượng chức năng đang tìm kiếm 2 người còn lại.', '2021-08-16 12:28:29', NULL, 0, 0);
INSERT INTO `Posts` VALUES (3, 'Khơi mở tiềm năng phát triển ngành thủy sản: Bài 2 - Tạo “cú huých” để phát triển bền vững', 1, 1, 3, -1, '<p>Trong những năm qua, tranh thủ sự hỗ trợ của Trung ương, c&aacute;c dự &aacute;n của c&aacute;c tổ chức quốc tế v&agrave; của tỉnh, c&aacute;c địa phương ven biển đ&atilde; được đầu tư ph&aacute;t triển cơ sở hạ tầng c&aacute;c v&ugrave;ng NTTS. Ti&ecirc;u biểu l&agrave;, ho&agrave;n th&agrave;nh v&agrave; đưa v&agrave;o sử dụng c&aacute;c dự &aacute;n: Trung t&acirc;m Nghi&ecirc;n cứu v&agrave; Sản xuất giống thủy sản Thanh H&oacute;a (quy m&ocirc; 50 triệu con giống/năm), khu NTTS Hoằng Phong (Hoằng H&oacute;a), v&ugrave;ng NTTS Đ&ocirc;ng - Phong - Ngọc (H&agrave; Trung); khu neo đậu tr&aacute;nh tr&uacute; b&atilde;o Lạch Trường (Hoằng H&oacute;a), khu neo đậu tr&aacute;nh tr&uacute; b&atilde;o s&ocirc;ng L&yacute; (Quảng Xương), cơ sở hạ tầng v&ugrave;ng NTTS c&aacute;c x&atilde; Minh Lộc v&agrave; H&ograve;a Lộc (Hậu Lộc), đầu tư 2 bến c&aacute; Hoằng Phụ v&agrave; Hải Ch&acirc;u... Th&ocirc;ng qua c&aacute;c cơ chế, ch&iacute;nh s&aacute;ch ph&aacute;t triển thủy sản; khuyến ngư, hỗ trợ con giống, vốn, chuyển giao khoa học - kỹ thuật... tạo động lực cho ngư d&acirc;n sản xuất. B&ecirc;n cạnh đ&oacute;, việc đầu tư của c&aacute;c tổ chức, c&aacute; nh&acirc;n v&agrave;o lĩnh vực thủy sản cũng tăng nhanh v&agrave; xuất hiện nhiều m&ocirc; h&igrave;nh khai th&aacute;c, NTTS, chế biến thủy sản theo hướng sản xuất h&agrave;ng h&oacute;a mang lại hiệu quả kinh tế cao. Nhiều m&ocirc; h&igrave;nh ph&aacute;t triển nu&ocirc;i th&acirc;m canh, si&ecirc;u th&acirc;m canh, nu&ocirc;i trong nh&agrave; m&agrave;ng, nu&ocirc;i bể... đối với t&ocirc;m thẻ ch&acirc;n trắng; nu&ocirc;i t&ocirc;m h&ugrave;m, c&aacute; gi&ograve; ở khu vực biển H&ograve;n M&ecirc;; đa dạng h&oacute;a đối tượng nu&ocirc;i trong nu&ocirc;i nước lợ... Nh&acirc;n giống v&agrave; đưa v&agrave;o sản xuất một số lo&agrave;i thủy sản c&oacute; gi&aacute; trị kinh tế cao, như: t&ocirc;m s&uacute;, cua xanh, ngao Bến Tre, c&aacute; lăng chấm, c&aacute; dốc, c&aacute; bống bớp, h&agrave;u Th&aacute;i B&igrave;nh Dương...</p>\r\n<p>Nhiệm vụ mục ti&ecirc;u đặt ra cho ng&agrave;nh thủy sản l&agrave; rất nặng nề, nhưng với tiềm năng v&agrave; lợi thế sẵn c&oacute;, đồng thời được sự quan t&acirc;m l&atilde;nh đạo, chỉ đạo của Tỉnh ủy, UBND tỉnh, sự nỗ lực của ng&agrave;nh n&ocirc;ng nghiệp, c&aacute;c huyện, thị x&atilde;, th&agrave;nh phố v&agrave; ngư d&acirc;n trong tỉnh, tin tưởng rằng ng&agrave;nh thủy sản sẽ khắc phục kh&oacute; khăn, thực hiện thắng lợi nhiệm vụ, mục ti&ecirc;u m&agrave; Nghị quyết Đại hội Đảng bộ tỉnh lần thứ XIX đề ra.</p>', 'Để thủy sản phát triển thành một ngành sản xuất hàng hóa lớn, giá trị gia tăng cao và bền vững, rất cần “cú huých” để các địa phương ven biển phát triển nuôi trồng thủy sản (NTTS) theo hướng CNH, HĐH.', '2021-06-16 12:32:02', NULL, 0, 0);
INSERT INTO `Posts` VALUES (4, 'Muốn biết cá có tươi ngon hay không, chỉ cần để ý 5 điểm này', 1, NULL, 3, 0, '<h2><strong>Ngửi m&ugrave;i c&aacute;</strong></h2>\r\n<p><img src=\"https://thumb.connect360.vn/unsafe/660x0/quanlytin.emdep.vn/Share/Image/2021/08/13/1-ways-to-check-the-freshness-of-fish-113802634.jpg\" alt=\"Muốn biết c&aacute; c&oacute; tươi ngon kh&ocirc;ng h&atilde;y để 5 dấu hiệu n&agrave;y\" width=\"700\" /></p>\r\n<p>Theo c&aacute;c chuy&ecirc;n gia, đ&acirc;y l&agrave; c&aacute;ch tốt nhất để biết c&aacute; c&ograve;n tươi hay kh&ocirc;ng. Khi mua c&aacute;, bạn h&atilde;y chọn c&aacute; c&oacute; m&ugrave;i thơm nhẹ v&agrave; kh&ocirc;ng c&oacute; m&ugrave;i tanh, chua.&nbsp;C&aacute; s&ocirc;ng, c&aacute; biển tươi c&oacute; m&ugrave;i nước nhẹ, m&ugrave;i tanh nồng chứng tỏ c&aacute; đ&atilde; thiu hoặc đ&atilde; được bảo quản bằng h&oacute;a chất.&nbsp;</p>\r\n<h2><strong>Nh&igrave;n mắt c&aacute;</strong></h2>\r\n<p><img src=\"https://thumb.connect360.vn/unsafe/658x0/quanlytin.emdep.vn/Share/Image/2021/08/13/2-ways-to-check-the-freshness-of-fish-113811339.jpg\" alt=\"Muốn biết c&aacute; c&oacute; tươi ngon kh&ocirc;ng h&atilde;y để 5 dấu hiệu n&agrave;y\" width=\"700\" /></p>\r\n<p>Mắt c&aacute; kh&ocirc;ng n&oacute;i dối.&nbsp;Điều n&agrave;y nghe c&oacute; vẻ kỳ lạ nhưng lại rất đ&uacute;ng. C&aacute; tươi ngon l&agrave; mắt c&aacute; kh&ocirc;ng c&oacute; lớp xỉn m&agrave;u trắng hoặc kh&ocirc;ng bị trũng, mắt c&aacute; tươi b&oacute;ng, mờ v&agrave; s&aacute;ng.&nbsp;Mắt c&aacute; c&oacute; vẩn đục chứng tỏ c&aacute; đ&atilde; bị thiu hoặc thối rữa.</p>\r\n<h2><strong>Để &yacute; thịt c&aacute;</strong></h2>\r\n<p><img src=\"https://thumb.connect360.vn/unsafe/656x0/quanlytin.emdep.vn/Share/Image/2021/08/13/3-ways-to-check-the-freshness-of-fish-113819638.jpg\" alt=\"Muốn biết c&aacute; c&oacute; tươi ngon kh&ocirc;ng h&atilde;y để 5 dấu hiệu n&agrave;y\" width=\"700\" /></p>\r\n<p>C&aacute; tươi kh&ocirc;ng chỉ tươi ngon cả b&ecirc;n trong lẫn b&ecirc;n ngo&agrave;i m&agrave; c&ograve;n c&oacute; m&agrave;u s&aacute;ng, b&oacute;ng v&agrave; kh&ocirc;ng bị xỉn m&agrave;u. Thịt c&aacute; tươi lu&ocirc;n săn lại khi chạm v&agrave;o v&agrave; c&oacute; vẻ ngo&agrave;i như kim loại tự nhi&ecirc;n.&nbsp;Hơn nữa, da c&aacute; tươi căng v&agrave; c&oacute; vảy. C&aacute; tươi l&agrave; vảy c&aacute; kh&ocirc;ng bị bong ra tự nhi&ecirc;n.&nbsp;C&aacute; ươn thường xỉn m&agrave;u v&agrave; dễ bong vảy.</p>\r\n<p>&nbsp;</p>', 'Một số mẹo dưới đây sẽ giúp bạn kiểm tra độ tươi của cá.\r\n1. Ngửi mùi cá\r\n2. Nhìn mắt cá\r\n3. Để ý thịt cá', '2021-07-16 12:36:41', NULL, 0, 0);
INSERT INTO `Posts` VALUES (5, 'Khơi mở tiềm năng phát triển ngành thủy sản: Bài 1 - Tiềm năng còn bỏ ngõ', 1, NULL, 3, 0, '<p class=\"pBody\">Thanh H&oacute;a c&oacute; bờ biển d&agrave;i 102 km, với v&ugrave;ng biển rộng 17.000km2, l&agrave; một trong những ngư trường quan trọng, c&oacute; t&iacute;nh đa dạng sinh học cao. Dọc bờ biển Thanh H&oacute;a c&oacute; 7 cửa lạch lớn nhỏ; trong đ&oacute;, c&oacute; 5 cửa lạch lớn l&agrave;: Lạch Sung, Lạch Trường, Lạch Hới, Lạch Gh&eacute;p, Lạch Bạng, đ&atilde; tạo n&ecirc;n h&agrave;ng ngh&igrave;n ha nu&ocirc;i trồng thủy sản v&agrave; l&agrave; một trong những tỉnh c&oacute; tiềm năng nu&ocirc;i trồng thủy sản lớn nhất v&ugrave;ng Bắc Trung bộ. V&ugrave;ng ven biển gồm 6 huyện, thị x&atilde;, th&agrave;nh phố, với 45 x&atilde;, phường v&agrave; l&agrave; nơi tập trung ph&aacute;t triển kinh tế thủy sản của tỉnh, bao gồm nu&ocirc;i trồng, khai th&aacute;c, dịch vụ hậu cần v&agrave; chế biến thủy sản, thu h&uacute;t khoảng 26.000 lao động tham gia trực tiếp tr&ecirc;n biển.</p>\r\n<p class=\"pBody\">Ph&aacute;t huy tiềm năng, thế mạnh về biển, c&ugrave;ng với sự chỉ đạo của Trung ương, của tỉnh, kinh tế thủy sản ở c&aacute;c địa phương ven biển đ&atilde; c&oacute; những bước ph&aacute;t triển tr&ecirc;n tất cả c&aacute;c lĩnh vực khai th&aacute;c, nu&ocirc;i trồng, chế biến. Đến nay, diện t&iacute;ch nu&ocirc;i trồng thủy sản to&agrave;n tỉnh đạt 19.500 ha, trong đ&oacute;, nước ngọt 14.110 ha; nước mặn, lợ 5.350 ha... Trong khai th&aacute;c hải sản, to&agrave;n tỉnh c&oacute; 6.840 t&agrave;u c&aacute;, trong đ&oacute;, 4.578 t&agrave;u c&oacute; chiều d&agrave;i dưới 12m, 976 t&agrave;u c&oacute; chiều d&agrave;i từ 12m đến dưới 15m v&agrave; 1.286 t&agrave;u c&oacute; chiều d&agrave;i từ 15m trở l&ecirc;n. H&agrave;ng năm, sản lượng khai th&aacute;c v&agrave; nu&ocirc;i trồng thủy sản to&agrave;n tỉnh 187.000 tấn, trong đ&oacute;, khai th&aacute;c 130.000 tấn, nu&ocirc;i trồng 57.000 tấn. Với sản lượng khai th&aacute;c v&agrave; nu&ocirc;i trồng thủy sản h&agrave;ng năm của tỉnh l&agrave; nguồn nguy&ecirc;n liệu cung cấp cho hơn 1.000 cơ sở chế biến thủy sản đang hoạt động tại c&aacute;c địa phương ven biển v&agrave; 81 doanh nghiệp chuy&ecirc;n chế biến, kinh doanh xuất khẩu thủy sản, với tổng c&ocirc;ng suất khoảng 280.000 tấn/năm. Nhiều mặt h&agrave;ng chế biến thủy sản của tỉnh đ&atilde; tham gia xuất khẩu đến c&aacute;c thị trường c&aacute;c nước Trung Quốc, H&agrave;n Quốc, Nhật Bản, Th&aacute;i Lan, Ph&aacute;p, Mỹ, T&acirc;y Ban Nha... Tuy nhi&ecirc;n, so với tiềm năng, lợi thế v&agrave; y&ecirc;u cầu ph&aacute;t triển kinh tế thủy sản của tỉnh chưa tương xứng v&agrave; c&ograve;n gặp nhiều kh&oacute; khăn, th&aacute;ch thức. Hiện nay, th&aacute;ch thức lớn nhất trong ph&aacute;t triển thủy sản đ&oacute; l&agrave; hạ tầng c&aacute;c cảng c&aacute;, khu neo đậu tr&aacute;nh tr&uacute; b&atilde;o, với cầu cảng, luồng lạch ở c&aacute;c địa phương ven biển hiện nay qu&aacute; tải so với năng lực t&agrave;u c&aacute; trong tỉnh. Với số lượng t&agrave;u c&aacute; c&ocirc;ng suất lớn tăng nhanh, từ năm 2015 đến nay với c&aacute;c ch&iacute;nh s&aacute;ch ph&aacute;t triển thủy sản theo Nghị định số 67/2014/NĐ-CP, số t&agrave;u khai th&aacute;c hải sản đ&oacute;ng mới c&oacute; c&ocirc;ng suất hơn 400CV tăng nhanh. Trong khi cơ sở hạ tầng dịch vụ nghề c&aacute; hiện c&oacute; chưa đ&aacute;p ứng y&ecirc;u cầu neo đậu, bốc dỡ sản phẩm, g&acirc;y kh&oacute; khăn cho t&agrave;u ra v&agrave;o cảng, l&agrave;m hạn chế đến hiệu quả khai th&aacute;c, quản l&yacute; t&agrave;u c&aacute;, cảng c&aacute;, khu neo đậu tr&aacute;nh tr&uacute; b&atilde;o cho t&agrave;u c&aacute;. C&aacute;c khu ph&acirc;n loại hải sản, c&ocirc;ng tr&igrave;nh xử l&yacute; chất thải, nước thải tại c&aacute;c cảng c&aacute; chưa đ&aacute;p ứng y&ecirc;u cầu vệ sinh an to&agrave;n thực phẩm, bảo vệ m&ocirc;i trường l&agrave;m ảnh hưởng nghi&ecirc;m trọng đến chất lượng sản phẩm sau khai th&aacute;c, g&acirc;y t&aacute;c động xấu đến m&ocirc;i trường xung quanh cảng c&aacute;. Việc quản l&yacute;, gi&aacute;m s&aacute;t nguồn gốc, xuất xứ hải sản c&ograve;n hạn chế g&acirc;y ảnh hưởng lớn đến c&ocirc;ng t&aacute;c chống khai th&aacute;c bất hợp ph&aacute;p, kh&ocirc;ng b&aacute;o c&aacute;o v&agrave; kh&ocirc;ng theo quy định. Hệ thống th&ocirc;ng tin gi&aacute;m s&aacute;t t&agrave;u c&aacute; hiện c&oacute; của tỉnh chưa bảo đảm an to&agrave;n cho người v&agrave; t&agrave;u c&aacute; khi hoạt động tr&ecirc;n biển, nhất l&agrave; trong m&ugrave;a mưa b&atilde;o. Trạm bờ quản l&yacute; t&agrave;u c&aacute; của tỉnh hiện nay c&oacute; quy m&ocirc; nhỏ, chưa đồng bộ v&agrave; chưa đ&aacute;p ứng được nhu cầu tiếp nhận, xử l&yacute; th&ocirc;ng tin quản l&yacute; khai th&aacute;c hải sản hiện nay.&nbsp;</p>\r\n<p class=\"pBody\">Với những kh&oacute; khăn, th&aacute;ch thức của ng&agrave;nh thủy sản đang gặp phải, đặt ra y&ecirc;u cầu cho c&aacute;c cấp, ng&agrave;nh chức năng v&agrave; c&aacute;c địa phương phải x&aacute;c định cụ thể c&aacute;c mục ti&ecirc;u, nhiệm vụ v&agrave; giải ph&aacute;p chủ yếu tạo th&agrave;nh &ldquo;c&uacute; hu&yacute;ch&rdquo; để n&acirc;ng cao hiệu quả nu&ocirc;i trồng, khai th&aacute;c hải sản, ph&aacute;t huy được tối đa tiềm năng, lợi thế của tỉnh tr&ecirc;n lĩnh vực n&agrave;y.</p>', 'Thanh Hóa là một trong những địa phương có điều kiện thuận lợi trong phát triển nghề khai thác, nuôi trồng và chế biến thủy sản. Vì vậy, để khai thác tiềm năng, lợi thế nhằm phát triển thủy sản trở thành ngành sản xuất hàng hóa lớn mà mục tiêu Nghị quyết Đại hội Đảng bộ tỉnh lần thứ XIX, nhiệm kỳ 2020-2025 đề ra, cần có giải pháp căn cơ, đột phá để phát triển bền vững.', '2021-08-16 12:38:26', NULL, 0, 0);
INSERT INTO `Posts` VALUES (6, 'Xuất khẩu thủy sản sang EU tụt mạnh do \'thẻ vàng\'', 2, 2, 5, 1, '<p>Ng&agrave;y 16/8, Thứ trưởng&nbsp;<a class=\"autotag\" href=\"https://nongnghiep.vn/bo-nn-ptnt-tag36128/\" target=\"_blank\" rel=\"follow noopener\">Bộ NN-PTNT</a>&nbsp;Ph&ugrave;ng Đức Tiến chủ tr&igrave; cuộc họp x&acirc;y dựng Đề &aacute;n Ph&ograve;ng, chống khai th&aacute;c hải sản bấp hợp ph&aacute;p, kh&ocirc;ng b&aacute;o c&aacute;o v&agrave; kh&ocirc;ng theo quy định (<a class=\"autotag\" href=\"https://nongnghiep.vn/iuu-tag81635/\" target=\"_blank\" rel=\"follow noopener\">IUU</a>) đến năm 2025.</p>\r\n<figure class=\"expNoEdit\"><img class=\"lazyload loaded\" title=\"4-van-de-yeu-kem-cua-nganh-thuy-san-200530_20210816_408.jpg\" src=\"https://media.ex-cdn.com/EXP/media.nongnghiep.vn/files/benlc/2021/08/16/4-van-de-yeu-kem-cua-nganh-thuy-san-200530_20210816_408.jpg\" alt=\"Hạ tầng nghề c&aacute; yếu k&eacute;m l&agrave; một trong những nguy&ecirc;n nh&acirc;n rất kh&oacute; khăn cho việc khắc phục \'thẻ v&agrave;ng\' của Việt Nam. Ảnh: KS.\" width=\"680\" height=\"453\" data-src=\"https://media.ex-cdn.com/EXP/media.nongnghiep.vn/files/benlc/2021/08/16/4-van-de-yeu-kem-cua-nganh-thuy-san-200530_20210816_408.jpg\" data-was-processed=\"true\" />\r\n<figcaption>\r\n<p class=\"expEdit h2\">Hạ tầng nghề c&aacute; yếu k&eacute;m l&agrave; một trong những nguy&ecirc;n nh&acirc;n rất kh&oacute; khăn cho việc khắc phục \"thẻ v&agrave;ng\" của Việt Nam. Ảnh:&nbsp;<em>KS.</em></p>\r\n</figcaption>\r\n</figure>\r\n<p>Sau gần 4 năm triển khai thực hiện chống khai th&aacute;c IUU, Ch&iacute;nh phủ, Thủ tướng Ch&iacute;nh phủ đ&atilde; v&agrave; đang tập trung chỉ đạo c&aacute;c bộ, ban, ng&agrave;nh v&agrave; UBND 28 tỉnh, th&agrave;nh phố trực thuộc Trung ương ven biển triển khai c&aacute;c giải ph&aacute;p để thực hiện khuyến nghị của&nbsp;<a class=\"autotag\" href=\"https://nongnghiep.vn/ec-tag716/\" target=\"_blank\" rel=\"follow noopener\">EC</a>&nbsp;nhằm sớm gỡ cảnh b&aacute;o \"thẻ v&agrave;ng\". Tuy vậy, c&ocirc;ng t&aacute;c chống khai th&aacute;c IUU, gỡ cảnh b&aacute;o &ldquo;thẻ v&agrave;ng&rdquo; của EC vẫn c&ograve;n nhiều tồn tại, hạn chế.</p>\r\n<p>Thứ trưởng Ph&ugrave;ng Đức Tiến cho rằng muốn gỡ được \"<a class=\"autotag\" href=\"https://nongnghiep.vn/the-vang-tag47148/\" target=\"_blank\" rel=\"follow noopener\">thẻ v&agrave;ng</a>\", cần phải tự đặt c&acirc;u hỏi tại sao lại bị EC r&uacute;t \"thẻ v&agrave;ng\", qua đ&oacute; Thứ trưởng đ&atilde; chỉ ra những thực trạng của ng&agrave;nh khai th&aacute;c thủy sản của Việt Nam.</p>\r\n<p>Thực trạng nhức nhối nhất hiện nay l&agrave; lực lượng đội t&agrave;u lớn, dẫn đến cường lực khai th&aacute;c c&oacute; mật độ qu&aacute; đ&ocirc;ng. Lực lượng ngư d&acirc;n chưa được đ&agrave;o tạo, c&ograve;n theo truyền thống &ldquo;cha truyền con nối&rdquo;, &yacute; thức chấp h&agrave;nh ph&aacute;p luật chưa cao.</p>\r\n<p>Thực trạng hạ tầng thủy sản c&ograve;n yếu k&eacute;m. Cần phải khẳng định sẽ kh&ocirc;ng thể gỡ được \"thẻ v&agrave;ng\" nếu kh&ocirc;ng đầu tư, n&acirc;ng cấp, cải thiện cơ sở hạ tầng, v&igrave; hạ tầng yếu k&eacute;m sẽ kh&ocirc;ng thể quản l&yacute; tốt đội t&agrave;u cũng như kh&ocirc;ng thể truy xuất nguồn gốc. B&ecirc;n cạnh đ&oacute;, c&aacute;c khu tr&aacute;nh tr&uacute; b&atilde;o vẫn chưa đảm bảo được c&ocirc;ng suất cũng như c&aacute;c ti&ecirc;u ch&iacute;; c&aacute;c&nbsp;<a class=\"autotag\" href=\"https://nongnghiep.vn/cang-ca-tag50631/\" target=\"_blank\" rel=\"follow noopener\">cảng c&aacute;</a>&nbsp;chưa được quản l&yacute; chặt chẽ, s&aacute;t sao...</p>', 'Việc EC áp \"thẻ vàng\" đối với ngành thủy sản đã khiến cho xuất khẩu thủy sản của Việt Nam sang thị trường Châu Âu sụt giảm liên tục từ năm 2017 đến nay.', '2021-08-16 20:52:41', '2021-08-17 00:00:00', 39, 0);
INSERT INTO `Posts` VALUES (7, 'Đưa nông sản đất Cảng lên sàn thương mại điện tử', 2, NULL, 5, 0, '<p>Tại hội nghị, c&aacute;c đơn vị được phổ biến một số ch&iacute;nh s&aacute;ch ưu đ&atilde;i cước c&ugrave;ng những hỗ trợ triển khai c&aacute;c chương tr&igrave;nh marketing tr&ecirc;n s&agrave;n&nbsp;<a class=\"autotag\" href=\"https://nongnghiep.vn/thuong-mai-dien-tu-tag45352/\" target=\"_blank\" rel=\"follow noopener\">thương mại điện tử</a>&nbsp;Postmart.vn v&agrave; s&agrave;n Voso.vn.</p>\r\n<p>Đại diện s&agrave;n thương mại điện tử Postmart.vn v&agrave; Voso.vn cho biết, th&ocirc;ng qua s&agrave;n thương mại điện tử doanh nghiệp c&oacute; thể tự tạo gian h&agrave;ng v&agrave; b&aacute;n hoặc mua c&aacute;c sản phẩm, nguy&ecirc;n liệu.</p>\r\n<p>C&ograve;n đối với người ti&ecirc;u d&ugrave;ng, c&oacute; thể ngồi tại nh&agrave; v&agrave;o c&aacute;c s&agrave;n thương mại điện tử để mua được sản phẩm thương hiệu uy t&iacute;n, chất lượng tốt, gi&aacute; cả ph&ugrave; hợp m&agrave; m&igrave;nh mong muốn.</p>\r\n<p>C&aacute;c đơn vị sở hữu s&agrave;n thương mại điện tử cam kết hỗ trợ tối đa cho doanh nghiệp khi 2 b&ecirc;n k&yacute; kết hợp đồng hợp t&aacute;c với những ưu đ&atilde;i kh&aacute;c biệt so với kh&aacute;ch h&agrave;ng th&ocirc;ng thường, nhất l&agrave; về gi&aacute; cả, thời gian chuyển h&agrave;ng h&oacute;a cũng như khối lượng vận chuyển kh&ocirc;ng giới hạn.</p>\r\n<p>&ldquo;Trong t&igrave;nh h&igrave;nh dịch bệnh Covid-19 như hiện nay, s&agrave;n thương mại điện tử của ch&uacute;ng t&ocirc;i sẽ hỗ trợ người d&acirc;n rất hữu hiệu trong việc ti&ecirc;u thụ n&ocirc;ng sản&rdquo;, &ocirc;ng Nguyễn Th&aacute;i Ho&agrave;ng &ndash; Gi&aacute;m đốc Viettel Post Hải Ph&ograve;ng khẳng định.</p>\r\n<figure class=\"expNoEdit\"><img class=\"lazyload loaded\" title=\"img_8939-194106_195.jpg\" src=\"https://media.ex-cdn.com/EXP/media.nongnghiep.vn/files/muoidv/2021/08/16/img_8939-194106_195.jpg\" alt=\"Đại diện Bưu điện TP Hải Ph&ograve;ng th&ocirc;ng tin những ưu đ&atilde;i hỗ trợ doanh nghiệp đưa sản phẩm n&ocirc;ng nghiệp l&ecirc;n s&agrave;n Postmart. Ảnh: Đinh Mười.\" width=\"680\" height=\"453\" data-src=\"https://media.ex-cdn.com/EXP/media.nongnghiep.vn/files/muoidv/2021/08/16/img_8939-194106_195.jpg\" data-was-processed=\"true\" /></figure>', 'Chiều 16/8, Sở NN-PTNT Hải Phòng tổ chức Hội nghị kết nối hỗ trợ doanh nghiệp đưa nông sản đất Cảng lên sàn thương mại điện tử.', '2021-08-16 20:54:02', NULL, 0, 0);
INSERT INTO `Posts` VALUES (8, 'Hiểm họa cây cần độc chết người lây lan khắp nơi', 2, 2, 5, -1, '<h3>Ph&aacute;t t&aacute;n nhanh</h3>\r\n<p>C&aacute;c nh&agrave; khoa học Mỹ vừa cảnh b&aacute;o, lo&agrave;i thực vật x&acirc;m lấn độc hại -&nbsp;<a class=\"autotag\" href=\"https://nongnghiep.vn/cay-can-doc-poison-hemlock-tag140008/\" rel=\"follow\">c&acirc;y cần độc (poison hemlock)</a>&nbsp;c&oacute; nguồn gốc từ ch&acirc;u &Acirc;u trong v&agrave;i năm gần đ&acirc;y đ&atilde; xuất hiện ở khắp c&aacute;c ch&acirc;u lục, đe dọa ph&aacute; vỡ hệ sinh th&aacute;i bản địa v&agrave; nguy hiểm hơn c&oacute; thể g&acirc;y chết người v&agrave; vật nu&ocirc;i nếu v&ocirc; t&igrave;nh ăn phải.</p>\r\n<p>Dan Shaver, chuy&ecirc;n gia Cơ quan Bảo tồn T&agrave;i nguy&ecirc;n Thi&ecirc;n nhi&ecirc;n bang Indiana cho biết: &ldquo;Việc ph&aacute; bỏ v&agrave; di chuyển n&oacute; đem đi ti&ecirc;u hủy khiến t&ocirc;i e ngại v&igrave; lo&agrave;i c&acirc;y n&agrave;y chứa rất nhiều độc tố v&agrave; g&acirc;y nhiều rủi ro nguy hiểm đối với trẻ em, vật nu&ocirc;i v&agrave; những người chưa biết n&oacute;&rdquo;.</p>\r\n<p>N&oacute; đặc biệt dễ mọc v&agrave; b&ugrave;ng nổ theo cấp số nh&acirc;n ở những khu đất ẩm ướt v&agrave; kh&ocirc;ng được quản l&yacute;, cho d&ugrave; đ&oacute; l&agrave; một g&oacute;c phố kh&ocirc;ng bị cắt cỏ hay chung sống với c&aacute;c lo&agrave;i c&acirc;y thụ phấn kh&aacute;c.</p>\r\n<p>Kevin Tungesvick, một nh&agrave; sinh th&aacute;i học cao cấp của Eco Logic, một c&ocirc;ng ty phục hồi m&ocirc;i trường cho biết, ở bang Indiana, lo&agrave;i thực vật x&acirc;m hại n&agrave;y đ&atilde; l&acirc;y lan qu&aacute; rộng, rất &iacute;t cơ hội để c&oacute; thể bị ti&ecirc;u diệt.&nbsp; V&igrave; vậy mục ti&ecirc;u l&agrave; cố gắng quản l&yacute; v&agrave; kiểm so&aacute;t n&oacute; ở mức tối đa c&oacute; thể - để bảo vệ cả m&ocirc;i trường v&agrave; sức khỏe cộng đồng.</p>\r\n<p>Hồi th&aacute;ng 6, Jason Hartschuh thuộc Đại học Mở bang Ohio cho biết, c&acirc;y cần độc poison hemlock nguy hiểm đ&atilde; xuất hiện \"khắp nơi\" ở Ohio v&agrave; năm nay c&oacute; thể thấy r&otilde; hơn bao giờ hết.&nbsp;</p>\r\n<h4>Cảnh b&aacute;o đ&aacute;ng lo ngại</h4>\r\n<p>Dưới đ&acirc;y l&agrave; những điều bạn cần biết về lo&agrave;i c&acirc;y chết người n&agrave;y, bao gồm những t&aacute;c động độc hại m&agrave; n&oacute; c&oacute; thể g&acirc;y ra, c&aacute;ch ph&aacute;t hiện v&agrave; c&aacute;ch loại bỏ n&oacute;.</p>\r\n<figure class=\"expNoEdit\"><img class=\"lazyload loaded\" title=\"poison-hemlock-root-03022017-k_peterson-img_0600-1106_20210804_459.jpg\" src=\"https://media.ex-cdn.com/EXP/media.nongnghiep.vn/files/bao_in/2021/08/04/poison-hemlock-root-03022017-k_peterson-img_0600-1106_20210804_459-111821.jpeg\" alt=\"C&aacute;c chuy&ecirc;n gia khuy&ecirc;n n&ecirc;n thận trọng xử l&yacute;, kiểm so&aacute;t c&acirc;y cần độc. Ảnh: Noxious weeds\" width=\"680\" height=\"906\" data-src=\"https://media.ex-cdn.com/EXP/media.nongnghiep.vn/files/bao_in/2021/08/04/poison-hemlock-root-03022017-k_peterson-img_0600-1106_20210804_459-111821.jpeg\" data-was-processed=\"true\" /></figure>', 'Loài thực vật xâm lấn tên là cần độc (poison hemlock) với hàm lượng độc tố từ rễ đến lá, hoa có thể gây chết người và vật nuôi đang lan rộng khắp nơi.', '2021-07-16 20:57:31', NULL, 0, 0);
INSERT INTO `Posts` VALUES (9, 'Chất lượng giống: Cú hích cho rừng gỗ lớn', 2, NULL, 5, 0, '<p><a class=\"autotag\" href=\"https://nongnghiep.vn/tuyen-quang-tag136487/\" target=\"_blank\" rel=\"follow noopener\">Tuy&ecirc;n Quang</a>&nbsp;hiện đ&atilde; x&acirc;y dựng được khoảng 40.000 ha&nbsp;<a class=\"autotag\" href=\"https://nongnghiep.vn/rung-go-lon-tag54563/\" target=\"_blank\" rel=\"follow noopener\">rừng gỗ lớn</a>&nbsp;(trong tổng diện t&iacute;ch rừng sản xuất khoảng 140.700 ha). Với định hướng n&acirc;ng cao chất lượng rừng, hằng năm Tuy&ecirc;n Quang triển khai thực hiện trồng khoảng 1.000 ha rừng giống chất lượng cao.</p>\r\n<p>Hiện nay, tại một số địa phương trong tỉnh, tập qu&aacute;n canh t&aacute;c, lựa chọn nguồn giống c&acirc;y l&acirc;m nghiệp chủ yếu vẫn dựa v&agrave;o c&aacute;c cơ sở tự sản xuất hoặc từ c&aacute;c nguồn cung cấp tr&ocirc;i nổi tr&ecirc;n thị trường kh&ocirc;ng được kiểm so&aacute;t.</p>\r\n<figure class=\"expNoEdit\"><img class=\"lazyload loaded\" title=\"chat-luong-giong-cu-hich-cho-rung-go-lon-1508_20210811_722.jpg\" src=\"https://media.ex-cdn.com/EXP/media.nongnghiep.vn/files/bao_in/2021/08/11/chat-luong-giong-cu-hich-cho-rung-go-lon-1508_20210811_722-152838.jpeg\" alt=\"Koe nu&ocirc;i lai nu&ocirc;i cấy m&ocirc; đang khẳng định được ưu thế vượt trội v&agrave; thay thế c&aacute;c giống cũ tại Tuy&ecirc;n Quang. Ảnh: Đ&agrave;o Thanh.\" width=\"680\" height=\"465\" data-src=\"https://media.ex-cdn.com/EXP/media.nongnghiep.vn/files/bao_in/2021/08/11/chat-luong-giong-cu-hich-cho-rung-go-lon-1508_20210811_722-152838.jpeg\" data-was-processed=\"true\" />\r\n<figcaption>\r\n<p class=\"expEdit h2\">Koe nu&ocirc;i lai nu&ocirc;i cấy m&ocirc; đang khẳng định được ưu thế vượt trội v&agrave; thay thế c&aacute;c giống cũ tại Tuy&ecirc;n Quang. Ảnh:&nbsp;<em>Đ&agrave;o Thanh.</em></p>\r\n</figcaption>\r\n</figure>\r\n<p>Do đ&oacute;, một số diện t&iacute;ch&nbsp;<a class=\"autotag\" href=\"https://nongnghiep.vn/cay-keo-tag13516/\" target=\"_blank\" rel=\"follow noopener\">c&acirc;y keo</a>&nbsp;của người d&acirc;n đến kỳ thu hoạch kh&ocirc;ng đảm bảo năng suất, chất lượng, thậm ch&iacute; chết yểu. Giải ph&aacute;p được UBND tỉnh cũng như ng&agrave;nh NN-PTNT tỉnh Tuy&ecirc;n Quang đưa ra l&agrave; tăng cường nghi&ecirc;n cứu, ứng dụng khoa học c&ocirc;ng nghệ, đồng bộ c&aacute;c kh&acirc;u trong chuỗi gi&aacute; trị l&acirc;m sản từ sản xuất, khai th&aacute;c, chế biến.</p>\r\n<p>Đặc biệt, tỉnh khuyến kh&iacute;ch tạo bước đột ph&aacute; về giống, n&acirc;ng cao năng suất, chất lượng rừng trồng, ph&aacute;t triển v&ugrave;ng nguy&ecirc;n liệu gỗ lớn, c&ocirc;ng nghệ chế biến l&acirc;m sản; tăng cường năng lực đổi mới cơ chế, h&igrave;nh thức, phương ph&aacute;p khuyến l&acirc;m; đẩy mạnh hợp t&aacute;c quốc tế trong nghi&ecirc;n cứu, đ&agrave;o tạo v&agrave;&nbsp;<a class=\"autotag\" href=\"https://nongnghiep.vn/khuyen-lam-tag140458/\" rel=\"follow\">khuyến l&acirc;m</a>.</p>\r\n<p>&Ocirc;ng Triệu Đăng Khoa, Chi cục ph&oacute; Chi cục Kiểm l&acirc;m tỉnh Tuy&ecirc;n Quang cho biết, ch&iacute;nh s&aacute;ch hỗ trợ giống&nbsp;<a class=\"autotag\" href=\"https://nongnghiep.vn/cay-lam-nghiep-tag88660/\" target=\"_blank\" rel=\"follow noopener\">c&acirc;y l&acirc;m nghiệp</a>&nbsp;chất lượng cao tr&ecirc;n địa b&agrave;n tỉnh Tuy&ecirc;n Quang được thực hiện trong 4 năm từ năm 2018 đến năm 2021. Để đảm bảo nguồn giống được ph&acirc;n bổ đến c&aacute;c hộ d&acirc;n, Chi cục đ&atilde; chỉ đạo c&aacute;c bộ phận chuy&ecirc;n m&ocirc;n triển khai tuy&ecirc;n truyền, r&agrave; so&aacute;t, x&aacute;c định đối tượng, lập hồ sơ, tr&igrave;nh duyệt dự to&aacute;n kinh ph&iacute; để tổ chức cấp c&acirc;y giống cho nh&acirc;n d&acirc;n trồng rừng, đảm bảo kịp thời vụ trồng rừng trong từng năm.</p>\r\n<p>Do giống c&acirc;y keo lai được sản xuất bằng phương ph&aacute;p nu&ocirc;i cấy m&ocirc; v&agrave; c&acirc;y&nbsp;<a class=\"autotag\" href=\"https://nongnghiep.vn/keo-tai-tuong-tag140430/\" target=\"_blank\" rel=\"follow noopener\">keo tai tượng</a>&nbsp;được gieo ươm từ hạt giống nhập ngoại n&ecirc;n khi triển khai v&agrave;o trồng thực tế c&oacute; những ưu điểm nổi bật. Với c&acirc;y nu&ocirc;i cấy m&ocirc;, do c&acirc;y mẹ được tuyển chọn l&agrave; những c&acirc;y keo lai vượt trội nhất để lấy chồi sinh trưởng nh&acirc;n giống m&ocirc;, n&ecirc;n c&acirc;y con c&oacute; sức kh&aacute;ng bệnh tốt, nhất l&agrave; những loại bệnh thường gặp ở keo như thối nấm cổ rễ, s&acirc;u keo ăn l&aacute;, bệnh th&acirc;n trắng...</p>', 'Tuyên Quang xem chất lượng giống đặc biệt quan trọng để nâng cao chất lượng rừng. Tỉnh đã có nhiều chính sách hỗ trợ, đẩy nhanh tiến độ trồng các giống mới chất lượng cao.', '2021-08-16 20:59:16', NULL, 0, 0);
INSERT INTO `Posts` VALUES (10, 'Nửa năm, hơn 300 ha rừng Thừa Thiên - Huế bị cháy', 2, NULL, 5, 0, '<p>Tại hội nghị đ&aacute;nh gi&aacute; c&ocirc;ng t&aacute;c quản l&yacute;,&nbsp;<a class=\"autotag\" href=\"https://nongnghiep.vn/bao-ve-rung-tag79354/\" target=\"_blank\" rel=\"follow noopener\">bảo vệ rừng</a>&nbsp;(QLBVR) v&agrave; ph&ograve;ng ch&aacute;y chữa ch&aacute;y rừng (PCCCR) năm 2020 &ndash; 2021 của tỉnh Thừa Thi&ecirc;n - Huế vừa qua, Ban Chỉ đạo Chương tr&igrave;nh mục ti&ecirc;u ph&aacute;t triển l&acirc;m nghiệp bền vững Thừa Thi&ecirc;n - Huế cho biết 7 th&aacute;ng đầu năm 2021, lực lượng&nbsp;<a class=\"autotag\" href=\"https://nongnghiep.vn/kiem-lam-tag61908/\" target=\"_blank\" rel=\"follow noopener\">kiểm l&acirc;m</a>&nbsp;v&agrave; c&aacute;c đơn vị chủ rừng ph&aacute;t hiện v&agrave; xử l&yacute; 12 vụ ph&aacute; rừng với h&agrave;nh vi lấy đất sản xuất với diện t&iacute;ch 1,73 ha.</p>\r\n<figure class=\"expNoEdit\"><img class=\"lazyload loaded\" title=\"anh-1-2218_20210805_817.jpg\" src=\"https://media.ex-cdn.com/EXP/media.nongnghiep.vn/files/bao_in/2021/08/10/anh-1-2218_20210805_817-183632.jpeg\" alt=\"L&atilde;nh đạo tỉnh Thừa Thi&ecirc;n - Huế tặng bằng khen cho nhiều c&aacute; nh&acirc;n, tổ chức c&oacute; th&agrave;nh t&iacute;ch trong c&ocirc;ng t&aacute;c quản l&yacute;, bảo vệ v&agrave; ph&ograve;ng ch&aacute;y chữa ch&aacute;y rừng. Ảnh: T.T\" width=\"680\" height=\"411\" data-src=\"https://media.ex-cdn.com/EXP/media.nongnghiep.vn/files/bao_in/2021/08/10/anh-1-2218_20210805_817-183632.jpeg\" data-was-processed=\"true\" />\r\n<figcaption>\r\n<p class=\"expEdit h2\">L&atilde;nh đạo tỉnh Thừa Thi&ecirc;n - Huế tặng bằng khen cho nhiều c&aacute; nh&acirc;n, tổ chức c&oacute; th&agrave;nh t&iacute;ch trong c&ocirc;ng t&aacute;c quản l&yacute;, bảo vệ v&agrave; ph&ograve;ng ch&aacute;y chữa ch&aacute;y rừng. Ảnh:&nbsp;<em>T.T</em></p>\r\n</figcaption>\r\n</figure>\r\n<p>Cơ quan chức năng cũng đ&atilde; ph&aacute;t hiện v&agrave; xử l&yacute; 206 vụ vi phạm l&acirc;m luật, tịch thu gần 100 m3 gỗ; trong đ&oacute;, đ&atilde; khởi tố 3 vụ &aacute;n h&igrave;nh sự với 12 bị can về tội hủy hoại rừng.</p>\r\n<p>Về c&ocirc;ng t&aacute;c&nbsp;<a class=\"autotag\" href=\"https://nongnghiep.vn/pcccr-tag98190/\" target=\"_blank\" rel=\"follow noopener\">PCCCR</a>, t&igrave;nh h&igrave;nh thời tiết tiếp tục diễn biến phức tạp, nắng n&oacute;ng k&eacute;o d&agrave;i l&agrave;m xảy ra 32 vụ ch&aacute;y rừng, tổng diện t&iacute;ch thiệt hại 313 ha rừng c&aacute;c loại, với tổng số tiền 31,3 tỷ đồng&hellip;</p>\r\n<p>C&ocirc;ng t&aacute;c quản l&yacute; rừng bền vững chưa được quan t&acirc;m đ&uacute;ng mức. Nạn ph&aacute; rừng, lấn chiếm rừng vẫn c&ograve;n xảy ra. Việc phối hợp giữa c&aacute;c đơn vị trong chữa ch&aacute;y rừng c&ograve;n chưa được nhịp nh&agrave;ng...</p>\r\n<p>Để tăng cường c&ocirc;ng t&aacute;c QLBVR thời gian tới, Ph&oacute; Chủ tịch UBND tỉnh Thừa Thi&ecirc;n - Huế đề nghị c&aacute;c địa phương, chủ rừng v&agrave; c&aacute;c ng&agrave;nh tiếp tục triển khai thực hiện Chỉ thị 13-CT/TW của Ban B&iacute; thư về tăng cường sự l&atilde;nh đạo của Đảng đối với c&ocirc;ng t&aacute;c quản l&yacute; bảo vệ v&agrave; ph&aacute;t triển rừng, tạo n&ecirc;n sự chuyển biến mạnh mẽ của to&agrave;n thể x&atilde; hội đối với c&ocirc;ng t&aacute;c QLBVR&nbsp; -PCCCR.</p>\r\n<p>Đồng thời, n&acirc;ng cao tr&aacute;ch nhiệm của ch&iacute;nh quyền địa phương c&aacute;c cấp trong hoạt động quản l&yacute; nh&agrave; nước về rừng v&agrave; đất rừng. R&agrave; so&aacute;t lực lượng, phương tiện, vật tư, kinh ph&iacute; để kịp thời bổ sung đảm bảo thực hiện tốt phương ch&acirc;m &ldquo;4 tại chỗ v&agrave; 5 sẵn s&agrave;ng&rdquo;.</p>\r\n<p>Dịp n&agrave;y, UBND tỉnh Thừa Thi&ecirc;n - Huế đ&atilde; tặng bằng khen cho 11 tập thể v&agrave; 41 c&aacute; nh&acirc;n đ&atilde; c&oacute; th&agrave;nh t&iacute;ch trong c&ocirc;ng t&aacute;c chữa ch&aacute;y rừng.</p>', 'Trong khoảng nửa năm 2021, hơn 300 ha rừng các loại ở tỉnh Thừa Thiên - Huế đã bị cháy, tổng thiệt hại khoảng 31,3 tỷ đồng.', '2021-02-16 21:00:49', NULL, 0, 0);
INSERT INTO `Posts` VALUES (11, 'Huyền thoại meme nhí Ông Ngoại Tuổi 30 sau 13 năm', 2, NULL, 6, 0, '<p>Phim điện ảnh<em>&nbsp;&Ocirc;ng ngoại tuổi 30 (Scandal Makers)&nbsp;</em>với sự tham gia của Cha Tae Hyun, Park Bo Young, Wang Suk Hyun ra mắt năm 2008. Phim xoay quanh&nbsp;Nam Hyun Soo (Cha Tae Hyun), từng l&agrave; một thần tượng tuổi vị th&agrave;nh ni&ecirc;n v&agrave; hiện l&agrave; ph&aacute;t thanh vi&ecirc;n. Một ng&agrave;y nọ, c&ocirc; g&aacute;i trẻ t&ecirc;n&nbsp;Jae In (Park Bo Young) dắt theo cậu con trai&nbsp;Ki Dong (Wang Suk Hyun) t&igrave;m đến nh&agrave; Hyun Soo, tự nhận l&agrave; con g&aacute;i của anh c&ugrave;ng ch&aacute;u ngoại. Hai mẹ con Jae In đ&atilde; l&agrave;m đảo lộn cuộc sống của Hyun Soo, khiến anh đối mặt với scandal lớn nhất cuộc đời.</p>\r\n<p>Wang Suk Hyun thủ vai Ki Dong khi mới 5 tuổi. Cậu nh&oacute;c chinh phục kh&aacute;n giả với vẻ ngo&agrave;i lanh lợi, đ&aacute;ng y&ecirc;u c&ugrave;ng nụ cười nhếch m&eacute;p đặc trưng. Nhờ<em>&nbsp;&Ocirc;ng ngoại tuổi 30,&nbsp;</em>Wang Suk Hyun một bước trở th&agrave;nh sao nh&iacute; được h&acirc;m mộ nhất nh&igrave; H&agrave;n Quốc.</p>\r\n<p>Cậu b&eacute; c&ograve;n nhận được giải thưởng&nbsp;<em>Ng&ocirc;i sao thiếu ni&ecirc;n</em>&nbsp;(Korea Junior Star Awards) lần thứ 2 d&agrave;nh cho những diễn vi&ecirc;n triển vọng dưới 23 tuổi. Đồng thời li&ecirc;n tục xuất hiện tr&ecirc;n thảm đỏ c&aacute;c sự kiện danh gi&aacute;, đ&oacute;ng quảng c&aacute;o v&agrave; lồng tiếng phim. D&ugrave; c&ograve;n nhỏ tuổi, Wang vẫn thể hiện năng khiếu diễn xuất tự nhi&ecirc;n, chịu kh&oacute; học thoại qua c&aacute;c đoạn băng ghi &acirc;m v&agrave; kh&ocirc;ng hề l&uacute;ng t&uacute;ng trước m&aacute;y quay.</p>\r\n<p>Những tưởng đ&acirc;y sẽ l&agrave; bệ ph&oacute;ng ho&agrave;n hảo cho sự nghiệp diễn xuất m&agrave; bất cứ diễn vi&ecirc;n n&agrave;o cũng ao ước. Tuy nhi&ecirc;n Wang đ&atilde; bỏ lỡ mất cơ hội ph&aacute;t triển qu&yacute; gi&aacute; n&agrave;y, cậu b&eacute; nhận đ&oacute;ng rất &iacute;t phim, d&ugrave; vẫn thu h&uacute;t một lượng người h&acirc;m mộ đ&ocirc;ng đảo, thậm ch&iacute; Wang c&ograve;n bị fan cuồng đe dọa chỉ v&igrave; kh&ocirc;ng thể gặp được cậu ở ngo&agrave;i đời.</p>', 'Thành công tới sớm, sao nhí Ông Ngoại Tuổi 30 khi trưởng thành lại không giữ được phong độ của mình.', '2021-03-16 21:04:39', NULL, 0, 0);
INSERT INTO `Posts` VALUES (12, 'Rầm rộ cái kết bị cắt bỏ của anime Vô Diện sau 20 năm', 2, NULL, 6, 0, '<p>Một con ma hiền l&agrave;nh, c&oacute; một bản chất tốt đẹp, một linh hồn ẩn hiện v&ocirc; định kho&aacute;c l&ecirc;n m&igrave;nh m&agrave;u đen s&acirc;u h&uacute;t, đeo một chiếc mặt nạ vừa vui vừa buồn ch&iacute;nh l&agrave; điều tạo n&ecirc;n sức h&uacute;t ri&ecirc;ng cho nh&acirc;n vật V&ocirc; diện trong phim. Đặc biệt g&acirc;y &aacute;m ảnh nhất c&oacute; thể kể tới cảnh quay V&ocirc; diện đứng lặng lẽ một m&igrave;nh dưới mưa hay l&uacute;c hắn lẽo đẽo đi theo Chihiro một c&aacute;ch chậm r&atilde;i, từ tốn.</p>\r\n<p>Quay trở lại với<em>&nbsp;V&ugrave;ng đất linh hồn</em>, t&aacute;c phẩm thuộc h&agrave;ng kinh điển n&agrave;y đ&atilde; mang về những th&agrave;nh c&ocirc;ng ngo&agrave;i mong đợi cho đạo diễn Miyazaki Hayao v&agrave; cả Studio Ghibli. Ng&agrave;y ra mắt,&nbsp;<em>V&ugrave;ng đất linh hồn</em>&nbsp;trở th&agrave;nh bộ phim ăn kh&aacute;ch nhất mọi thời đại tại Nhật Bản, vượt qua cả si&ecirc;u phẩm Titanic. Năm 2001, si&ecirc;u phẩm n&agrave;y c&ograve;n được vinh danh tại lễ trao giải Oscar cho phim hoạt h&igrave;nh xuất sắc nhất, đồng thời gi&agrave;nh vị tr&iacute; thứ 4 trong danh s&aacute;ch 100 bộ phim hay nhất thế kỷ 21 do BBC b&igrave;nh chọn.</p>\r\n<p>Spirited Away l&agrave; bộ phim kể về cuộc phi&ecirc;u lưu của c&ocirc; b&eacute; bướng bỉnh Chihiro khi c&ocirc; b&eacute; v&ocirc; t&igrave;nh lạc v&agrave;o một thế giới ho&agrave;n to&agrave;n xa lạ, nơi được gọi l&agrave; Thế Giới Linh Hồn với sự hiện diện những con ma, những con quỷ v&ocirc; c&ugrave;ng k&igrave; dị. Tại đ&acirc;y, Chihiro đ&atilde; c&oacute; một chuyến phi&ecirc;u lưu v&ocirc; c&ugrave;ng k&igrave; th&uacute;, l&agrave;m quen với những người bạn mới v&agrave; trải qua biết bao hiểm nguy để cứu tho&aacute;t bố mẹ m&igrave;nh.</p>\r\n<p>Nh&acirc;n vật ch&iacute;nh trong tr&iacute;ch đoạn kinh điển của Spirited Away ch&iacute;nh l&agrave; No-Face, một sinh vật k&igrave; lạ thường xuy&ecirc;n mang những m&oacute;n đồ qu&yacute; gi&aacute; ra để ch&agrave;o mời mọi người v&agrave; sau đ&oacute; sẽ... nuốt sống họ. Duy chỉ c&oacute; Chihiro th&igrave; tỏ ra thờ ơ với những c&aacute;m dỗ của No-Face v&agrave; c&oacute; lẽ cũng ch&iacute;nh v&igrave; l&yacute; do n&agrave;y m&agrave; No-Face đ&atilde; lẽo đẽo đi theo c&ocirc; b&eacute; trong cuộc h&agrave;nh tr&igrave;nh n&agrave;y.</p>', 'Nhiều khán giả khẳng định đã từng xem qua cái kết này của Vô Diện ngoài rạp.', '2021-08-16 21:08:12', NULL, 0, 0);
INSERT INTO `Posts` VALUES (13, 'Liam Hemsworth trở lại đóng phim sau thời gian nghỉ dịch', 2, NULL, 6, 0, '<p>Loạt h&igrave;nh paparazzi của&nbsp;<em>Daily Mail</em>&nbsp;đăng tải ng&agrave;y 16/8 cho thấy Liam Hemsworth diện trang phục đơn giản, để r&acirc;u tr&ecirc;n phim trường dự &aacute;n mới. Đ&oacute; l&agrave;&nbsp;<em>Poker Face</em>, một t&aacute;c phẩm kinh dị do Russell Crowe đạo diễn.</p>\r\n<p>Theo nguồn tin, địa điểm ghi h&igrave;nh ở thị trấn ven biển Kiama, c&aacute;ch th&agrave;nh phố Sydney, Australia 120 km. \"Hemsworth n&oacute;i chuyện s&ocirc;i nổi với nh&acirc;n vi&ecirc;n đo&agrave;n phim. Anh ấy đi dạo quanh ng&ocirc;i biệt thự để t&igrave;m hiểu v&agrave; l&agrave;m quen với bối cảnh\" - tờ b&aacute;o Anh viết.</p>\r\n<p><em>Poker Face&nbsp;</em>đ&aacute;nh dấu sự trở lại m&agrave;n ảnh của em trai \"Thần Sấm\" sau thời gian d&agrave;i nghỉ dịch, tận hưởng hạnh ph&uacute;c b&ecirc;n bạn g&aacute;i Gabriella Brooks. T&aacute;c phẩm gần nhất anh g&oacute;p mặt l&agrave; phim tội phạm giật g&acirc;n&nbsp;<em>Arkansas</em>&nbsp;(2020).</p>\r\n<p>Nguồn tin từ&nbsp;<em>The Daily Telegraph</em>&nbsp;tiết lộ Elsa Pataky - chị d&acirc;u của Hemsworth - cũng \"lặng lẽ được th&ecirc;m t&ecirc;n v&agrave;o d&agrave;n diễn vi&ecirc;n\". Trong phim mới&nbsp;<em>Poker Face</em>, Liam Hemsworth được giới thiệu thủ vai ch&iacute;nh.</p>\r\n<p>Ng&ocirc;i sao sinh năm 1990 trước đ&oacute; kh&ocirc;ng chia sẻ về dự &aacute;n mới, bởi anh vốn l&agrave; người k&iacute;n tiếng, th&iacute;ch tạo bất ngờ cho kh&aacute;n giả. Tuần trước, một nh&acirc;n vi&ecirc;n si&ecirc;u thị đ&atilde; rất hạnh ph&uacute;c khi gặp Hemsworth v&agrave; chụp h&igrave;nh với anh.</p>\r\n<p>Jamee Louise Burazin, 23 tuổi, nhớ lại cuộc gặp với sao&nbsp;<em>The Hunger Games</em>: \"Liam l&agrave; một trong những diễn vi&ecirc;n t&ocirc;i y&ecirc;u th&iacute;ch nhất. Được gặp anh ấy ngo&agrave;i đời, t&ocirc;i gần như bị đơ\". Burazin c&ograve;n nhận x&eacute;t t&agrave;i tử lịch sự v&agrave; tốt bụng.</p>\r\n<p>Kể từ l&uacute;c ly h&ocirc;n Miley Cyrus, Liam Hemsworth đ&atilde; rời Mỹ v&agrave; trở về Australia sống gần gia đ&igrave;nh anh trai. Anh ở lại qu&ecirc; đến nay mới tiếp tục c&ocirc;ng việc đ&oacute;ng phim. Thời gian qua, t&agrave;i tử tận hưởng hạnh ph&uacute;c b&ecirc;n t&igrave;nh mới.</p>\r\n<div id=\"innerarticle\" data-count=\"3\">\r\n<article class=\"article-item related\" data-tracker=\"zingweb_article_innerarticle1\">\r\n<p class=\"article-thumbnail\">&nbsp;</p>\r\n</article>\r\n</div>', 'Trong tác phẩm đang bấm máy, Liam Hemsworth thủ vai chính. Elsa Pataky cũng tham gia phim này.', '2021-06-16 21:10:57', NULL, 0, 0);
INSERT INTO `Posts` VALUES (14, 'Vì sao phim Hàn Quốc thời nay chỉ khoảng 16 tập?', 2, 3, 6, 1, '<p>Theo&nbsp;<em>SCMP,&nbsp;</em>ng&agrave;nh c&ocirc;ng nghiệp phim truyền h&igrave;nh của H&agrave;n Quốc c&oacute; nhiều thay đổi trong những năm qua. Để tối ưu h&oacute;a đối tượng kh&aacute;n giả, c&aacute;c nh&agrave; sản xuất phim dần chọn lọc, r&uacute;t ngắn thời lượng c&aacute;c tập phim. Những bộ phim d&agrave;i l&ecirc; th&ecirc; chỉ c&ograve;n trong qu&aacute; khứ.</p>\r\n<p>Tuy nhi&ecirc;n, mọi thứ lại đang bị lung lay bởi sự xuất hiện của c&aacute;c ứng dụng ph&aacute;t trực tuyến. Từ việc kết th&uacute;c bộ phim chỉ sau v&agrave;i chục tập, phim H&agrave;n dần chạy theo thị hiếu của phim Mỹ, ph&aacute;t triển m&ugrave;a tiếp theo hoặc c&aacute;c phần tiền truyện, ăn theo. Đ&acirc;y l&agrave; điều hiếm thấy của K-drama trong qu&aacute; khứ.</p>\r\n<h3>Phim H&agrave;n Quốc dần r&uacute;t ngắn thời lượng</h3>\r\n<p>Hầu hết phim truyền h&igrave;nh H&agrave;n Quốc được chiếu v&agrave;o khung giờ v&agrave;ng l&agrave; buổi tối, chiếu hai tập li&ecirc;n tiếp/tuần. Mỗi bộ phim sẽ xuất hiện tr&ecirc;n s&oacute;ng truyền h&igrave;nh khoảng hai th&aacute;ng.</p>\r\n<p>So với phim truyền h&igrave;nh phương T&acirc;y, nh&agrave; đ&agrave;i chỉ ph&aacute;t một tập/tuần, phim k&eacute;o d&agrave;i li&ecirc;n tục từ 4-6 th&aacute;ng. Điều đ&oacute; gi&uacute;p họ dễ d&agrave;ng để kh&aacute;n giả phụ thuộc phim, đồng thời đủ thời gian th&ecirc;m thắt những t&igrave;nh tiết mới, sản xuất những phần tiếp theo.</p>\r\n<h3>Xu hướng sản xuất phim thay đổi</h3>\r\n<p>Theo&nbsp;<em>SCMP,</em>&nbsp;những năm trước đ&acirc;y, sự kh&aacute;c biệt lớn nhất giữa phim truyền h&igrave;nh H&agrave;n Quốc v&agrave; phương T&acirc;y l&agrave; c&aacute;c m&ugrave;a ph&aacute;t s&oacute;ng. C&aacute;c bộ phim K-drama thường l&agrave; c&acirc;u chuyện kh&eacute;p k&iacute;n trong một m&ugrave;a, d&ugrave; phim c&oacute; sự đ&oacute;n tiếp nồng nhiệt của kh&aacute;n giả.</p>\r\n<p>Song, những năm gần đ&acirc;y, điều đ&oacute; đ&atilde; v&agrave; đang thay đổi. Một số chương tr&igrave;nh truyền h&igrave;nh ăn kh&aacute;ch như&nbsp;<em>Mật danh Iris</em>&nbsp;đ&atilde; c&oacute; phần ăn theo l&agrave;<em>&nbsp;Athena: Goddess of War.</em>&nbsp;Thậm ch&iacute; series được t&oacute;m gọn th&agrave;nh phi&ecirc;n bản ra rạp l&agrave;&nbsp;<em>Iris: The Movie.</em></p>', 'Trong xu hướng phát triển mới, phim Hàn Quốc có thời lượng từ 16-20 tập. Thay vào đó, nhà sản xuất kéo dài nhiều mùa, sản xuất phần tiền truyện.', '2021-05-16 21:16:53', '2022-05-16 00:00:00', 21, 1);
INSERT INTO `Posts` VALUES (15, '\'Thiên Long Bát Bộ 2021\' lạm dụng slow motion, \'kỹ xảo 3 xu\' khiến khán giả phát bực', 2, 3, 6, -1, '<p><em>Thi&ecirc;n Long B&aacute;t Bộ</em>&nbsp;bản 2021 vừa l&ecirc;n s&oacute;ng những tập đầu ti&ecirc;n từ 14/8 vừa qua. Bộ phim được kỳ vọng sẽ tiếp nối sự th&agrave;nh c&ocirc;ng của phi&ecirc;n bản kinh điển 2003. Nhưng qua tập mở m&agrave;n, kh&aacute;n giả đều ngao ng&aacute;n v&agrave; c&oacute; trải nghiệm tệ hại về phi&ecirc;n bản n&agrave;y, kh&ocirc;ng chỉ về d&agrave;n diễn vi&ecirc;n m&agrave; c&ograve;n bởi \"kĩ xảo 3 xu\" v&agrave; lạm dụng slow motion (quay chậm) trong c&aacute;c ph&acirc;n cảnh v&otilde; thuật.</p>\r\n<p>Hầu hết c&aacute;c tuyến nh&acirc;n vật đều được giới thiệu trong tập 1 của phim. Ph&acirc;n đoạn Kiều Phong (Dương Hựu Ninh) v&agrave; Mộ Dung Phục (Cao Th&aacute;i Vũ) quyết chiến, hay Đo&agrave;n Ch&iacute;nh Thuần - Tần Hồng Mi&ecirc;n - Đao Bạch Phượng gặp lại... đều khiến người xem ph&aacute;t bực v&igrave; l&ecirc; th&ecirc;, sử dụng qu&aacute; nhiều hiệu ứng zoom, quay chậm để diễn tả cảnh đấu v&otilde;.</p>\r\n<table class=\"picture\" align=\"center\">\r\n<tbody>\r\n<tr>\r\n<td class=\"pic\"><a class=\"photo\" href=\"https://image2.tienphong.vn/Uploaded/2021/neg-sleclyr/2021_08_16/giphy-3264.gif\" data-desc=\"Ph&acirc;n đoạn Mộc Uyển Thanh bị Nam Hải Ngạc Thần truy đuổi, Đo&agrave;n Dự bị bắt đứng ra bảo vệ ăn &quot;gạch đ&aacute;&quot; v&igrave; cảnh đằng sau kh&ocirc;ng thể giả hơn\" data-index=\"0\"><img class=\"cms-photo lazyloaded\" src=\"https://image2.tienphong.vn/Uploaded/2021/neg-sleclyr/2021_08_16/giphy-3264.gif\" alt=\"\'Thi&ecirc;n Long B&aacute;t Bộ 2021\' lạm dụng slow motion, \'kỹ xảo 3 xu\' khiến kh&aacute;n giả ph&aacute;t bực ảnh 1\" data-image-id=\"2854401\" data-width=\"480\" data-height=\"270\" data-src=\"https://image2.tienphong.vn/Uploaded/2021/neg-sleclyr/2021_08_16/giphy-3264.gif\" /></a></td>\r\n</tr>\r\n<tr>\r\n<td class=\"caption\">Ph&acirc;n đoạn Mộc Uyển Thanh bị Nam Hải Ngạc Thần truy đuổi, Đo&agrave;n Dự bị bắt đứng ra bảo vệ ăn \"gạch đ&aacute;\" v&igrave; cảnh đằng sau kh&ocirc;ng thể giả hơn</td>\r\n</tr>\r\n</tbody>\r\n</table>', 'TPO - Ngay sau khi phát sóng tập đầu tiên, Thiên Long Bát Bộ 2021 nhận phản ứng gay gắt từ người xem vì lạm dụng kỹ thuật slow motion (quay chậm), thêm vào đó là kỹ xảo lỗi thời không có điểm nhấn.', '2021-08-16 21:21:06', NULL, 0, 0);
INSERT INTO `Posts` VALUES (16, '\"Mẹ đơn thân\" Alessandra Ambrosio tình cảm khoác tay bạn trai đi ăn tối', 1, NULL, 7, 0, '<p>H&ocirc;m 15/8, Alessandra Ambrosio v&agrave; bạn trai Richard Lee c&ugrave;ng nhau đi ăn tối tại nh&agrave; h&agrave;ng ở California</p>\r\n<p>Cựu người mẫu trang điểm nhẹ nh&agrave;ng, đeo phụ kiện sang chảnh ra phố.</p>\r\n<p>C&ocirc; diện chiếc đầm cut-out m&agrave;u xanh l&aacute; c&acirc;y nổi bật, kho&aacute;c tay bạn trai ra phố.</p>', 'Cựu người mẫu Alessandra Ambrosio đeo phụ kiện sang chảnh, diện đầm cut-out màu xanh gợi cảm đi ăn tối cùng bạn trai mới ở California.', '2021-02-16 21:25:25', NULL, 0, 0);
INSERT INTO `Posts` VALUES (17, 'Song Hye Kyo khoe thân hình “siêu mỏng” trên bìa VOGUE khiến fan xém chút không nhận ra', 1, NULL, 7, 0, '<p>Ng&agrave;y 18.7 vừa qua, Charlene Co của tờ&nbsp;<em>Hong Kong Tatler</em>&nbsp;đ&atilde; tung ra b&agrave;i phỏng vấn đầu ti&ecirc;n với nữ diễn vi&ecirc;n Song Hye Kyo - Đ&acirc;y l&agrave; thời điểm cực nhạy cảm sau th&ocirc;ng tin của vụ ly h&ocirc;n &ldquo;ngh&igrave;n tỷ&rdquo; giữa Song Joong Ki v&agrave; Song Hye Kyo.&nbsp;</p>\r\n<p>Kh&aacute;c với h&igrave;nh ảnh x&otilde;a t&oacute;c mềm mại mọi khi, lần n&agrave;y Song Hye Kyo mang đến một diện mạo ho&agrave;n to&agrave;n kh&aacute;c với t&oacute;c b&uacute;i chặt ph&iacute;a sau đầu, kh&ocirc;ng để m&aacute;i, khoe trọn đường n&eacute;t thanh t&uacute;, sắc n&eacute;t của khu&ocirc;n mặt.</p>\r\n<p>Bức ảnh được chụp v&agrave;o thời điểm b&igrave;nh minh l&uacute;c 5 giờ 23 ph&uacute;t s&aacute;ng tại Gangnam, Seoul với h&agrave;m &yacute; về một sự khởi đầu ho&agrave;n to&agrave;n mới trong sự nghiệp của Song Hye Kyo.</p>', 'Xuất hiện trên bìa tạp chí VOGUE Hàn số tháng 9 với hai phiên bản, Song Hye Kyo mặc trang phục khá đơn giản nhưng lại khoe thân hình và thần thái chuẩn \"đại minh tinh châu Á\"!', '2021-04-16 21:29:00', NULL, 0, 0);
INSERT INTO `Posts` VALUES (18, 'Dương Mịch ‘hack tuổi’ đỉnh cao, đôi chân thon nuột đến khó tin', 1, 4, 7, -2, '<table class=\"picture\" align=\"center\">\r\n<tbody>\r\n<tr>\r\n<td class=\"caption\">Nhiều người khen ng&ocirc;i sao \"Người phi&ecirc;n dịch\" c&oacute; đ&ocirc;i ch&acirc;n thon gọn, thẳng tắp, kh&ocirc;ng c&oacute; sự kh&aacute;c biệt lớn về k&iacute;ch cỡ giữa đ&ugrave;i v&agrave; bắp ch&acirc;n, d&ugrave; gầy nhưng kh&ocirc;ng lộ đầu củ lạc. Tuy nhi&ecirc;n, một bộ phận cho rằng, ch&acirc;n của Dương Mịch qu&aacute; khẳng khiu.</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<table class=\"picture\" align=\"center\">\r\n<tbody>\r\n<tr>\r\n<td class=\"pic\">&nbsp;</td>\r\n</tr>\r\n<tr>\r\n<td class=\"pic\"><a class=\"photo\" href=\"https://image2.tienphong.vn/Uploaded/2021/zaugtn/2021_08_16/tien-phong-duongmich10-4263.gif\" data-desc=\"Với gương mặt n&agrave;y, kh&ocirc;ng ai nghĩ Dương Mịch đ&atilde; U40. Hiện tại, c&ocirc; được xếp v&agrave;o danh s&aacute;ch qu&yacute; c&ocirc; độc th&acirc;n ho&agrave;ng kim bậc nhất C-biz.\" data-index=\"8\"><img class=\"cms-photo lazyloaded\" src=\"https://image2.tienphong.vn/Uploaded/2021/zaugtn/2021_08_16/tien-phong-duongmich10-4263.gif\" alt=\"Dương Mịch &lsquo;hack tuổi&rsquo; đỉnh cao, đ&ocirc;i ch&acirc;n thon nuột đến kh&oacute; tin ảnh 9\" data-image-id=\"2854228\" data-width=\"480\" data-height=\"548\" data-src=\"https://image2.tienphong.vn/Uploaded/2021/zaugtn/2021_08_16/tien-phong-duongmich10-4263.gif\" /></a></td>\r\n</tr>\r\n<tr>\r\n<td class=\"caption\">Với gương mặt n&agrave;y, kh&ocirc;ng ai nghĩ Dương Mịch đ&atilde; U40. Hiện tại, c&ocirc; được xếp v&agrave;o danh s&aacute;ch qu&yacute; c&ocirc; độc th&acirc;n ho&agrave;ng kim bậc nhất C-biz.</td>\r\n</tr>\r\n</tbody>\r\n</table>', 'Dương Mịch xứng đáng là một trong nhưng “thánh hack tuổi” của showbiz Hoa ngữ, không chỉ gương mặt mà cả vóc dáng.', '2021-08-16 21:33:51', NULL, 0, 0);
INSERT INTO `Posts` VALUES (19, 'Sau Tiểu Hý, xuất hiện cô nàng 9X chỉ \"nhảy cho vui\" vẫn khiến netizen bắn tim tưng bừng', 1, NULL, 7, 0, '<p>C&ocirc; n&agrave;ng 9X đến từ H&agrave; Nội c&oacute; t&ecirc;n thật l&agrave; Ho&agrave;ng Thu Phương. K&ecirc;nh TikTok @<em>phuongku101</em>&nbsp;hiện thu h&uacute;t 1 triệu lượt&nbsp;<em>follow</em>&nbsp;v&agrave; hơn 10 triệu lượt &ldquo;thả tim&rdquo; từ cư d&acirc;n mạng.</p>\r\n<table class=\"picture\" align=\"center\">\r\n<tbody>\r\n<tr>\r\n<td class=\"pic\"><a class=\"photo\" href=\"https://image2.tienphong.vn/w1000/Uploaded/2021/sse-xtyssfj/2021_08_16/tik1-8031.jpg\" data-desc=\"Dự đo&aacute;n số người theo d&otilde;i t&agrave;i khoản TikTok của Phương Ku sẽ c&ograve;n tăng &quot;ch&oacute;ng mặt&quot;.\" data-index=\"0\"><img class=\"cms-photo lazyloaded\" src=\"https://image2.tienphong.vn/w645/Uploaded/2021/sse-xtyssfj/2021_08_16/tik1-8031.jpg\" alt=\"Sau Tiểu H&yacute;, xuất hiện c&ocirc; n&agrave;ng 9X chỉ &quot;nhảy cho vui&quot; vẫn khiến netizen bắn tim tưng bừng ảnh 1\" data-image-id=\"2854575\" data-width=\"627\" data-height=\"1205\" data-src=\"https://image2.tienphong.vn/w645/Uploaded/2021/sse-xtyssfj/2021_08_16/tik1-8031.jpg\" /></a></td>\r\n</tr>\r\n<tr>\r\n<td class=\"caption\">\r\n<p>Dự đo&aacute;n số người theo d&otilde;i t&agrave;i khoản TikTok của Phương Ku sẽ c&ograve;n tăng \"ch&oacute;ng mặt\".</p>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<p>Chỉ với ch&acirc;n m&aacute;y v&agrave; chiếc điện thoại th&ocirc;ng minh, Phương Ku thu h&uacute;t h&agrave;ng triệu lượt xem cho mỗi&nbsp;<em>clip</em>. Vẫn l&agrave; những giai điệu thịnh h&agrave;nh được nhiều TikToker kh&aacute;c sử dụng, điều đặc biệt ở c&ocirc; n&agrave;ng 9X n&agrave;y ch&iacute;nh l&agrave; vũ đạo đi&ecirc;u luyện, gương mặt ưa nh&igrave;n v&agrave; v&ograve;ng eo thon gọn.</p>\r\n<p>Đoạn clip gần đ&acirc;y của Phương Ku khi nh&uacute;n nhảy tr&ecirc;n nền nhạc của ca kh&uacute;c&nbsp;<em>Độ Tộc 2</em>&nbsp;(MV đang chiếm vị tr&iacute; No.1 Top Trending YouTube) đ&atilde; thu h&uacute;t hơn 3,2 triệu lượt xem v&agrave; hơn 379K lượt thả tim từ&nbsp;<em>netizen</em>.</p>\r\n<p>Chọn trang phục đơn giản với chiếc &aacute;o trễ vai khoe kh&eacute;o v&ograve;ng eo v&agrave; v&aacute;y đen năng động, c&ocirc; n&agrave;ng 9x khiến&nbsp;<em>netizen</em>&nbsp;rần rần v&igrave; vừa xinh vừa giỏi vũ đạo:&nbsp;<em>&ldquo;Đ&ocirc;i mắt biết cười. Nh&igrave;n thần th&aacute;i chị n&agrave;y xong l&agrave; y&ecirc;u đời l&ecirc;n hẳn&rdquo;, &ldquo;Nhảy cuốn qu&aacute; chừng&rdquo;, &ldquo;Kiểu g&igrave; cũng th&agrave;nh trend, kh&ocirc;ng thừa một động t&aacute;c n&agrave;o lu&ocirc;n&rdquo;...</em></p>\r\n<p>Phương Ku được dự đo&aacute;n sẽ &ldquo;so&aacute;n ng&ocirc;i&rdquo; của Tiểu H&yacute;. Đoạn clip tổng hợp vũ đạo của Phương Ku tr&ecirc;n một&nbsp;<em>page</em>&nbsp;ở Facebook đ&atilde; thu h&uacute;t hơn 70K lượt&nbsp;<em>react&nbsp;</em>v&agrave; 8K b&igrave;nh luận từ cư d&acirc;n mạng.</p>\r\n<table class=\"picture\" align=\"center\">\r\n<tbody>\r\n<tr>\r\n<td class=\"pic\"><a class=\"photo\" href=\"https://image2.tienphong.vn/w1000/Uploaded/2021/sse-xtyssfj/2021_08_16/tik6-7662.jpg\" data-desc=\"Sau Tiểu H&yacute;, xuất hiện c&ocirc; n&agrave;ng 9X chỉ &quot;nhảy cho vui&quot; vẫn khiến netizen bắn tim tưng bừng\" data-index=\"1\"><img class=\"cms-photo lazyloaded\" src=\"https://image2.tienphong.vn/w645/Uploaded/2021/sse-xtyssfj/2021_08_16/tik6-7662.jpg\" alt=\"Sau Tiểu H&yacute;, xuất hiện c&ocirc; n&agrave;ng 9X chỉ &quot;nhảy cho vui&quot; vẫn khiến netizen bắn tim tưng bừng ảnh 2\" data-image-id=\"2854588\" data-width=\"1170\" data-height=\"2048\" data-src=\"https://image2.tienphong.vn/w645/Uploaded/2021/sse-xtyssfj/2021_08_16/tik6-7662.jpg\" /></a></td>\r\n</tr>\r\n</tbody>\r\n</table>', 'Sau Tiểu Hý, cô nàng có nickname Phương Ku bất ngờ gây sốt với “dân chơi hệ TikTok” qua những clip nhảy điêu luyện trên nền nhạc là những giai điệu \"hot trend\" vô cùng bắt tai của giới trẻ hiện nay.', '2021-01-16 21:36:45', NULL, 0, 0);
INSERT INTO `Posts` VALUES (20, 'Trấn Thành, Trúc Nhân hào hứng bắt trend \"mặt thân thiện\" trên TikTok: Cái kết quá \"toang\"', 1, 4, 7, 1, '<p>Để gi&uacute;p mọi người c&oacute; được n&eacute;t mặt th&acirc;n thiện v&agrave; tr&aacute;nh bị hiểu lầm l&agrave; kh&oacute; gần, TikToker Ho&agrave;ng Hiệp quay&nbsp;<em>clip</em>&nbsp;để hướng dẫn v&ocirc; c&ugrave;ng cụ thể. Đầu ti&ecirc;n, bạn h&atilde;y mở mắt hờ hững, hơi nhướn ch&acirc;n m&agrave;y v&agrave; sau đ&oacute; mũi mở to tạo cảm gi&aacute;c gần gũi, ấm &aacute;p. Cuối c&ugrave;ng l&agrave; mỉm cười v&agrave; kh&ocirc;ng h&eacute; răng để c&oacute; n&eacute;t mặt th&acirc;n thiện.</p>\r\n<p>Nghe qua l&yacute; thuyết thấy kh&ocirc;ng hề kh&oacute; ch&uacute;t n&agrave;o, nhiều sao Việt v&agrave; netizen đ&atilde; h&agrave;o hứng quay&nbsp;<em>clip</em>&nbsp;l&agrave;m theo để c&oacute; được n&eacute;t mặt th&acirc;n thiện.</p>\r\n<p>MC Trấn Th&agrave;nh cũng nhanh ch&oacute;ng &ldquo;bắt trend&rdquo; v&agrave; tuần tự l&agrave;m đ&uacute;ng c&aacute;c bước theo hướng dẫn. Tuy nhi&ecirc;n, th&agrave;nh quả sau c&ugrave;ng của nam nghệ sĩ lại khiến nhiều&nbsp;<em>netizen</em>&nbsp;&ldquo;ngơ ng&aacute;c, ngỡ ng&agrave;ng rồi bật ngửa&rdquo; v&igrave; giống... cười đểu hơn l&agrave; th&acirc;n thiện.</p>\r\n<article class=\"col content-col\">\r\n<div class=\"row justify-content-between article\">\r\n<div class=\"col-27 article-content\">\r\n<div class=\"article__body cms-body\">\r\n<table class=\"picture\" align=\"center\">\r\n<tbody>\r\n<tr>\r\n<td class=\"pic\"><a class=\"photo\" href=\"https://image2.tienphong.vn/w1000/Uploaded/2021/sse-xtyssfj/2021_08_07/thanh5-8229.jpg\" data-desc=\"MC Trấn Th&agrave;nh trước v&agrave; sau khi bắt trend &quot;gương mặt th&acirc;n thiện&quot;, thực h&agrave;nh kh&aacute;c l&yacute; thuyết một trời một vực!\" data-index=\"0\"><img class=\"cms-photo lazyloaded\" src=\"https://image2.tienphong.vn/w645/Uploaded/2021/sse-xtyssfj/2021_08_07/thanh5-8229.jpg\" alt=\"Trấn Th&agrave;nh, Tr&uacute;c Nh&acirc;n h&agrave;o hứng bắt trend &quot;mặt th&acirc;n thiện&quot; tr&ecirc;n TikTok: C&aacute;i kết qu&aacute; &quot;toang&quot; ảnh 1\" data-image-id=\"2843421\" data-width=\"900\" data-height=\"600\" data-src=\"https://image2.tienphong.vn/w645/Uploaded/2021/sse-xtyssfj/2021_08_07/thanh5-8229.jpg\" /></a></td>\r\n</tr>\r\n<tr>\r\n<td class=\"caption\">\r\n<p>MC Trấn Th&agrave;nh trước v&agrave; sau khi bắt&nbsp;<em>trend</em>&nbsp;\"gương mặt th&acirc;n thiện\", thực h&agrave;nh kh&aacute;c l&yacute; thuyết một trời một vực!</p>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<p>Tương tự, d&ugrave; đ&atilde; &ldquo;đọc kỹ hướng dẫn trước khi sử dụng&rdquo; nhưng kết quả gương mặt th&acirc;n thiện của ca sĩ Tr&uacute;c Nh&acirc;n cũng bị phản t&aacute;c dụng. Đoạn nhạc kịch t&iacute;nh cuối clip đ&atilde; hiện l&ecirc;n cả một \"bầu trời x&eacute;o xắt\" tr&ecirc;n gương mặt giọng ca&nbsp;<em>S&aacute;ng Mắt Chưa</em>&nbsp;thay v&igrave; biểu cảm th&acirc;n thiện.</p>\r\n</div>\r\n</div>\r\n</div>\r\n</article>', 'Ở nhà giãn cách xã hội, nhiều sao Việt hào hứng bắt trend “Cách để làm nét mặt thân thiện” trên TikTok. Dù mọi người đã làm đúng theo hướng dẫn “không trượt phát nào” nhưng cái kết lại... \"toang quá toang\"!', '2021-08-16 21:40:17', '2021-08-16 00:00:00', 12, 0);
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
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of Tags
-- ----------------------------
BEGIN;
INSERT INTO `Tags` VALUES (32, 'amthuc');
INSERT INTO `Tags` VALUES (36, 'beauty');
INSERT INTO `Tags` VALUES (33, 'chaua');
INSERT INTO `Tags` VALUES (35, 'congnghe');
INSERT INTO `Tags` VALUES (2, 'drama');
INSERT INTO `Tags` VALUES (4, 'haisan');
INSERT INTO `Tags` VALUES (3, 'hoinghi');
INSERT INTO `Tags` VALUES (37, 'khaithac');
INSERT INTO `Tags` VALUES (5, 'kinhdi');
INSERT INTO `Tags` VALUES (34, 'monngon');
INSERT INTO `Tags` VALUES (6, 'nongsan');
INSERT INTO `Tags` VALUES (1, 'phauthuat');
INSERT INTO `Tags` VALUES (7, 'quocte');
INSERT INTO `Tags` VALUES (38, 'starstory');
INSERT INTO `Tags` VALUES (9, 'tainan');
INSERT INTO `Tags` VALUES (8, 'tinhcam');
INSERT INTO `Tags` VALUES (10, 'trongnuoc');
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
INSERT INTO `Writers` VALUES (1, 'Writer 1', 'Huan Hoa Hong', 'wrt1', '$2a$10$PVQowrDoFnb61ixyiNRVl.Ntlu4l9aeqbFCRjTjzi353/Fy83fN7S', '10 Truong Chinh', '2000-01-01', 'wrt1@gmail.com', 1);
INSERT INTO `Writers` VALUES (2, 'Writer 2', 'Cuc Bach Mai', 'wrt2', '$2a$10$VmT9wfxpoOAvz9e/kVJCkOvkON1CvhJULiDy5gTfkixFczsHe9xke', '20 An Duong Vuong', '1998-03-21', 'wrt2@gmail.com', 1);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
