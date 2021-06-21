/*
 Navicat Premium Data Transfer

 Source Server         : newspaper
 Source Server Type    : MySQL
 Source Server Version : 50726
 Source Host           : localhost:8889
 Source Schema         : newspaper

 Target Server Type    : MySQL
 Target Server Version : 50726
 File Encoding         : 65001

 Date: 22/06/2021 00:30:26
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for Admins
-- ----------------------------
DROP TABLE IF EXISTS `Admins`;
CREATE TABLE `Admins` (
  `ID` char(5) NOT NULL,
  `Name` varchar(50) NOT NULL,
  `UserName` varchar(255) NOT NULL,
  `Password` varchar(255) NOT NULL,
  `Address` varchar(255) DEFAULT NULL,
  `BirthDay` date DEFAULT NULL,
  `Email` varchar(255) NOT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of Admins
-- ----------------------------
BEGIN;
INSERT INTO `Admins` VALUES ('1', 'Admin 1', 'adm1', '$2a$10$n1IhX5nX.9XzEao.cb9LUOIBGtV.RE0bwSciiqohxTfdzjKkWPv0G', '10 Truong Chinh', NULL, 'hieuflong@gmail.com');
INSERT INTO `Admins` VALUES ('2', 'Admin 2', 'admin', '$2a$10$9VYfnavcm1XMvikacJA5GOGvFz5bOY6mPBorehYZuAFNh.x7w590.', NULL, NULL, 'admin@gmail.com');
COMMIT;

-- ----------------------------
-- Table structure for Categories
-- ----------------------------
DROP TABLE IF EXISTS `Categories`;
CREATE TABLE `Categories` (
  `ID` char(5) NOT NULL,
  `Name` varchar(255) NOT NULL,
  `ParentID` char(5) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `Cat_ParentID` (`ParentID`),
  CONSTRAINT `Cat_ParentID` FOREIGN KEY (`ParentID`) REFERENCES `Categories` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of Categories
-- ----------------------------
BEGIN;
INSERT INTO `Categories` VALUES ('1', 'Thuc Pham', NULL);
INSERT INTO `Categories` VALUES ('catHS', 'Hải sản', 'catKD');
INSERT INTO `Categories` VALUES ('catKD', 'Kinh doanh', NULL);
INSERT INTO `Categories` VALUES ('catNS', 'Nông sản', 'catKD');
COMMIT;

-- ----------------------------
-- Table structure for Comments
-- ----------------------------
DROP TABLE IF EXISTS `Comments`;
CREATE TABLE `Comments` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ReaderID` char(5) DEFAULT NULL,
  `PostID` char(5) NOT NULL,
  `PubTime` datetime NOT NULL,
  `Content` longtext NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `Readers_ReaderIReader_ReaderID` (`ReaderID`),
  KEY `Post_PostID` (`PostID`),
  CONSTRAINT `Post_PostID` FOREIGN KEY (`PostID`) REFERENCES `Posts` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `Readers_ReaderIReader_ReaderID` FOREIGN KEY (`ReaderID`) REFERENCES `Readers` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of Comments
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for Drafts
-- ----------------------------
DROP TABLE IF EXISTS `Drafts`;
CREATE TABLE `Drafts` (
  `ID` char(5) NOT NULL,
  `PostID` char(5) NOT NULL,
  `EditorID` char(5) NOT NULL,
  `Note` mediumtext NOT NULL,
  `RateTime` mediumtext NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `Posts_PostID` (`PostID`),
  KEY `Editors_EditorID` (`EditorID`),
  CONSTRAINT `Editors_EditorID` FOREIGN KEY (`EditorID`) REFERENCES `Editors` (`ID`),
  CONSTRAINT `Posts_PostID` FOREIGN KEY (`PostID`) REFERENCES `Posts` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of Drafts
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for Editors
-- ----------------------------
DROP TABLE IF EXISTS `Editors`;
CREATE TABLE `Editors` (
  `ID` char(5) NOT NULL,
  `Name` varchar(50) NOT NULL,
  `UserName` varchar(255) NOT NULL,
  `Password` varchar(255) NOT NULL,
  `Address` varchar(255) DEFAULT NULL,
  `BirthDay` date DEFAULT NULL,
  `Email` varchar(255) NOT NULL,
  `CatID` char(5) NOT NULL,
  PRIMARY KEY (`ID`) USING BTREE,
  KEY `cat_catID` (`CatID`),
  CONSTRAINT `cat_catID` FOREIGN KEY (`CatID`) REFERENCES `Categories` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of Editors
-- ----------------------------
BEGIN;
INSERT INTO `Editors` VALUES ('1', 'Editor 1', 'edt1', '$2a$10$PVQowrDoFnb61ixyiNRVl.Ntlu4l9aeqbFCRjTjzi353/Fy83fN7S', '10 Truong Chinh', NULL, 'hieuflong@gmail.com', '1');
INSERT INTO `Editors` VALUES ('2', 'Editor 2', 'edt2', '$2a$10$rSqL5/s/ns5TsczY59CZZOglkbRR1FRo9Qp0ogImNgqjKbbbr1ns2', '10 Pham Ngu Lao', NULL, 'editor@gmail.com', 'catKD');
COMMIT;

-- ----------------------------
-- Table structure for PostTag
-- ----------------------------
DROP TABLE IF EXISTS `PostTag`;
CREATE TABLE `PostTag` (
  `PostID` char(5) NOT NULL,
  `TagID` char(5) NOT NULL,
  PRIMARY KEY (`PostID`,`TagID`),
  KEY `tag_idTag` (`TagID`),
  CONSTRAINT `post_idPost` FOREIGN KEY (`PostID`) REFERENCES `Posts` (`ID`),
  CONSTRAINT `tag_idTag` FOREIGN KEY (`TagID`) REFERENCES `Tags` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of PostTag
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for Posts
-- ----------------------------
DROP TABLE IF EXISTS `Posts`;
CREATE TABLE `Posts` (
  `ID` char(5) NOT NULL,
  `Title` varchar(255) NOT NULL,
  `WriterID` char(5) NOT NULL,
  `CatID` char(5) NOT NULL,
  `StateID` int(11) NOT NULL,
  `Content` longtext NOT NULL,
  `Abstract` mediumtext NOT NULL,
  `WriteTime` datetime NOT NULL,
  `PubTime` datetime DEFAULT NULL,
  `Views` int(10) unsigned NOT NULL,
  `Avatar` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `Posts_Categories` (`CatID`),
  KEY `Writers_Cat` (`WriterID`),
  CONSTRAINT `Posts_Categories` FOREIGN KEY (`CatID`) REFERENCES `Categories` (`ID`),
  CONSTRAINT `Writers_Cat` FOREIGN KEY (`WriterID`) REFERENCES `Writers` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of Posts
-- ----------------------------
BEGIN;
INSERT INTO `Posts` VALUES ('bv1', 'Đường sắt giảm giá vận chuyển nông sản', '1', 'catNS', 0, 'Tổng công ty Đường sắt Việt Nam (VNR) giảm 50% giá cước toa xe để hỗ trợ nông dân vận chuyển hàng nông sản.\r\nNgày 11/6, lãnh đạo Tổng công ty Đường sắt Việt Nam (VNR) cho hay, đơn vị này sẽ hỗ trợ người dân các tỉnh Bắc Giang, Bắc Ninh, Vĩnh Phúc, Hải Dương, Hưng Yên vận chuyển hàng nông sản đi các tỉnh miền Trung, Nam bằng tàu hỏa. Đây là các vùng dịch mà bà con đang gặp nhiều khó khăn trong việc vận chuyển, lưu thông hàng hóa.\r\nTheo đó, từ 11/6 đến 31/7, VNR giảm giá cước vận chuyển tối đa là 50%, đồng thời sử dụng các toa xe chuyên dụng và container lạnh bảo ôn vận chuyển hàng nông sản để đảm bảo chất lượng.\r\n\"Ngành đường sắt cũng chịu ảnh hưởng nặng bởi dịch Covid-19, song chúng tôi vẫn hướng về bà con vùng dịch bằng nguồn lực hiện có\", lãnh đạo VNR nói.\r\n5 tháng qua, hành khách đi tàu giảm hơn 1,1 triệu lượt, chỉ bằng 64% cùng kỳ năm trước. Doanh thu đạt hơn 400 tỷ đồng, bằng 51%.\r\nTrong tháng 5, ngành đường sắt đã cắt giảm 393 đoàn tàu, trong đó tàu Thống Nhất là 38 đoàn, tàu khách địa phương là 355 đoàn. Đến nay, toàn mạng lưới hiện chỉ chạy một đôi tàu Thống nhất là SE7/8, tàu địa phương không chạy.', 'Tổng công ty Đường sắt Việt Nam (VNR) giảm 50% giá cước toa xe để hỗ trợ nông dân vận chuyển hàng nông sản.', '2021-06-21 22:16:47', NULL, 0, NULL);
INSERT INTO `Posts` VALUES ('bv2', '2,5 tấn vải Bắc Giang được Quản lý thị trường bán trong vài giờ', '1', 'catNS', 1, 'Sáng nay, 2,5 tấn vải của Bắc Giang đã được quản lý thị trường tỉnh Hoà Bình phối hợp với doanh nghiệp bán hết trong vòng vài giờ.\r\nĐây là chuyến hàng đầu tiên Đội Quản lý thị trường số 3 (Cục Quản lý thị trường Hoà Bình) triển khai, được vận chuyển từ tâm dịch Bắc Giang trong ngày hôm qua (29/5), để giúp bà con nông dân nơi đây tiêu thụ.\r\n\"Ngoài việc tạo điều kiện thuận lợi lưu thông hàng hóa, quản lý thị trường vào cuộc hỗ trợ tiêu thụ nông sản ùn ứ cho Bắc Giang đã thể hiện trách nhiệm với cộng đồng, góp phần phòng, chống Covid-19\" ông Nguyễn Bá Thức - Cục trưởng Cục Quản lý thị trường Hoà Bình nói.\r\nÔng Nguyễn Mạnh Trường - Đội phó Đội Quản lý thị trường số 3 (Cục Quản lý thị trường Hoà Bình) cho biết, giá vải đơn vị thu mua tại vườn của bà con Bắc Giang là 17.000 đồng một kg và được bán tại điểm hỗ trợ tiêu thụ nông sản Bắc Giang là 20.000 đồng mỗi kg.\r\nÔng Trường cho hay, mỗi kg vải quản lý thị trường vẫn phải bù lỗ, nhưng giúp được bà con nông dân trong lúc này thì đó là việc nên làm. \"Người dân nằm trong vùng dịch đã rất khổ rồi, nếu giá bán thấp quá, họ chẳng còn gì\", ông chia sẻ.\r\nCũng theo Đội phó Quản lý thị trường số 3, hiện vận chuyển, tiêu thụ hàng hoá của Bắc Giang đang gặp nhiều khó khăn, nhất là vận chuyển nông sản từ tỉnh này sang các địa phương khác và ngược lại. Mất 8 tiếng đồng hồ một chuyến xe vải Bắc Giang - Hoà Bình mới có thể quay đầu về vị trí xuất phát do phải tuân thủ các biện pháp khử khuẩn, phòng chống dịch.\r\nMỗi chuyến xe đi vào vùng dịch, lái xe sẽ phải thực hiện đầy đủ các bước khai báo y tế, khử khuẩn phương tiện. Đến Bắc Giang, xe của quản lý thị trường sẽ thực hiện trung chuyển tại Cục Quản lý thị trường tỉnh này. Các khâu thu mua, bốc xếp, khử khuẩn đều được thực hiện nghiêm ngặt. Xe khi về tới Hoà Bình lại được khử khuẩn, khai báo y tế theo quy định phòng dịch\", ông Trường chia sẻ.\r\nDự kiến mỗi tuần sẽ có 2 chuyến hàng với tổng khối lượng khoảng 5 tấn được vận chuyển về tiêu thụ tại điểm bán hàng của Đội Quản lý thị trường số 3.\r\n\"Chúng tôi sẽ thực hiện thí điểm, nếu hiệu quả có thể nhân rộng mô hình này tại một số đội trên địa bàn Hòa Bình\", ông Nguyễn Bá Thức - Cục trưởng Cục Quản lý thị trường Hòa Bình nói thêm.\r\nNgoài vải, quản lý thị trường Hoà Bình cũng giúp bà con Bắc Giang tiêu thụ một số loại nông sản. Theo ông Trường, khoảng 600 kg nông sản rau củ quả đã được đơn vị này hỗ trợ nông dân vùng dịch tiêu thụ trong ngày 29/5.\r\nTheo kế hoạch, mô hình trên sẽ được triển khai và nhân rộng tại nhiều tỉnh thành nhằm hỗ trợ nông dân tại vùng dịch tiêu thụ nông sản đến vụ thu hoạch.\r\nTại Hà Nội, vài ngày nay một số nhóm thiện nguyện cũng giúp bà con Bắc Giang tiêu thụ các mặt hàng nông sản như vải, dưa hấu...đang vào vụ, nhưng diễn biến Covid-19 phức tạp khiến việc mua bán chậm. Mỗi kg vải thiều sớm Bắc Giang được các nhóm thiện nguyện vận chuyển đưa về Hà Nội bán tại một số điểm trong thành phố với giá 20.000 đồng một kg; dưa hấu 6.000-7.000 đồng mỗi kg.\r\nTheo chị Nguyễn Thị Nhung (huyện Tân Yên, Bắc Giang), hiện hợp tác xã của huyện có gần 7.000 tấn vải và đã tiêu thụ được một nửa. Thời tiết nắng nóng, vải bắt đầu vào vụ thu hoạch nên không thể để lâu. Sự chung tay tiêu thụ vải của nhóm thiện nguyện giúp bà con trồng vải vơi phần nào nỗi lo ứ đọng hàng. Các chuyến xe hỗ trợ tiêu thụ vải đều được chính quyền xã hỗ trợ khử khuẩn hàng hoá, xe, lái xe khai báo y tế...\r\nNgoài các nhóm thiện nguyện, một số doanh nghiệp lớn cũng chung tay tiêu thụ vải thiều Bắc Giang. Như Tập đoàn Than, khoáng sản Việt Nam (TKV) mới đây đã có văn bản gửi tỉnh Bắc Giang đề nghị được mua 180 tấn vải thiều, giúp tỉnh này tiêu thụ vải khi mùa thu hoạch chính vụ đang tới.\r\nTheo báo cáo của tỉnh Bắc Giang, đến hết ngày 29/5, tổng sản lượng vải tiêu thụ đạt gần 14.500 tấn, trong đó tiêu thụ trong nước xấp xỉ 10.000 tấn, gần 4.400 tấn xuất khẩu. Giá thu mua bình quân 22.000-32.000 đồng một kg, tuỳ loại. Giá bán vải loại 1 đạt tiêu chuẩn VietGap, GlobalGap 30.000-35.000 đồng một kg.\r\nTuy nhiên, tỉnh Bắc Giang cho biết, việc lưu thông qua các chốt kiểm soát của các tỉnh vẫn khó khăn, container vận chuyển khan hiếm và giá thành vận chuyển cao.\r\nÔng Trần Duy Đông - Vụ trưởng Vụ Thị trường trong nước cho biết, đơn vị này đang phối hợp với tỉnh để gỡ \"ách tắc\" lưu thông hàng nông sản Bắc Giang tại một số địa phương.\r\nRiêng với vải thiều Bắc Giang xuất khẩu sang Trung Quốc - thị trường xuất khẩu chính của quả vải, tỉnh này cho hay, hiện được Lạng Sơn, Lào Cai và cơ quan hải quan, quản lý thị trường... tạo điều kiện thuận lợi, lưu thông luồng xanh nên việc thông quan hàng hoá nhanh chóng. Sáng 30/5, 15 xe vải Bắc Giang xuất khẩu qua cửa khẩu Tân Thanh (Lạng Sơn) được đi đường ưu tiên.', 'Sáng nay, 2,5 tấn vải của Bắc Giang đã được quản lý thị trường tỉnh Hoà Bình phối hợp với doanh nghiệp bán hết trong vòng vài giờ.', '2021-06-20 22:21:41', '2021-06-21 10:21:52', 3, NULL);
COMMIT;

-- ----------------------------
-- Table structure for Readers
-- ----------------------------
DROP TABLE IF EXISTS `Readers`;
CREATE TABLE `Readers` (
  `ID` char(5) NOT NULL,
  `Name` varchar(50) NOT NULL,
  `UserName` varchar(255) NOT NULL,
  `Password` varchar(255) NOT NULL,
  `Address` varchar(255) DEFAULT NULL,
  `BirthDay` date DEFAULT NULL,
  `Email` varchar(255) NOT NULL,
  `ExpTime` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of Readers
-- ----------------------------
BEGIN;
INSERT INTO `Readers` VALUES ('1', 'Minh Vuong', 'rd1', '$2a$10$PVQowrDoFnb61ixyiNRVl.Ntlu4l9aeqbFCRjTjzi353/Fy83fN7S', '10 Truong Chinh', NULL, 'hieuflong@gmail.com', NULL);
INSERT INTO `Readers` VALUES ('2', 'Trinh', 'rd2', '$2a$10$PVQowrDoFnb61ixyiNRVl.Ntlu4l9aeqbFCRjTjzi353/Fy83fN7S', '10 Truong Chinh', NULL, 'hieuflong@gmail.com', '2021-06-21 00:00:00');
COMMIT;

-- ----------------------------
-- Table structure for Tags
-- ----------------------------
DROP TABLE IF EXISTS `Tags`;
CREATE TABLE `Tags` (
  `ID` char(5) NOT NULL,
  `Name` varchar(50) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of Tags
-- ----------------------------
BEGIN;
INSERT INTO `Tags` VALUES ('tagHS', 'haisan');
INSERT INTO `Tags` VALUES ('tagNS', 'nongsan');
COMMIT;

-- ----------------------------
-- Table structure for Writers
-- ----------------------------
DROP TABLE IF EXISTS `Writers`;
CREATE TABLE `Writers` (
  `ID` char(5) NOT NULL,
  `Name` varchar(50) NOT NULL,
  `NickName` varchar(50) DEFAULT NULL,
  `UserName` varchar(50) NOT NULL,
  `Password` varchar(255) NOT NULL,
  `Address` varchar(255) DEFAULT NULL,
  `BirthDay` date DEFAULT NULL,
  `Email` varchar(255) NOT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of Writers
-- ----------------------------
BEGIN;
INSERT INTO `Writers` VALUES ('1', 'Writer 1', 'Huan Hoa Hong', 'wrt1', '$2a$10$PVQowrDoFnb61ixyiNRVl.Ntlu4l9aeqbFCRjTjzi353/Fy83fN7S', '10 Truong Chinh', NULL, 'hieuflong@gmail.com');
INSERT INTO `Writers` VALUES ('2', 'Writer 2', 'Cuc Bach Mai', 'wrt2', '$2a$10$VmT9wfxpoOAvz9e/kVJCkOvkON1CvhJULiDy5gTfkixFczsHe9xke', '20 An Duong Vuong', NULL, 'wrt@gmail.com');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
