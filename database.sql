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

 Date: 08/07/2021 09:56:35
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
INSERT INTO `Categories` VALUES (19, 'Giáo dục', NULL);
INSERT INTO `Categories` VALUES (20, 'Tuyển sinh', 19);
INSERT INTO `Categories` VALUES (21, 'Giáo dục 4.0', 19);
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
  CONSTRAINT `CommentPost` FOREIGN KEY (`PostID`) REFERENCES `Posts` (`ID`),
  CONSTRAINT `CommentReader` FOREIGN KEY (`ReaderID`) REFERENCES `Readers` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of Comments
-- ----------------------------
BEGIN;
INSERT INTO `Comments` VALUES (1, 1, 4, '2021-06-24 21:50:36', 'Bài viết hay', 'reader');
INSERT INTO `Comments` VALUES (2, 2, 7, '2021-06-24 21:51:27', 'Thật sự đỉnh, không thể tin được luôn.', 'reader');
INSERT INTO `Comments` VALUES (3, NULL, 7, '2021-07-02 00:00:00', 'alo', NULL);
INSERT INTO `Comments` VALUES (9, 1, 24, '2021-07-08 00:00:00', 'reader1', 'writer');
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
  CONSTRAINT `DraftEditor` FOREIGN KEY (`EditorID`) REFERENCES `Editors` (`ID`),
  CONSTRAINT `DraftPost` FOREIGN KEY (`PostID`) REFERENCES `Posts` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of Drafts
-- ----------------------------
BEGIN;
INSERT INTO `Drafts` VALUES (1, 4, 1, 'Không đúng tiêu đề', '2021-07-06 01:18:12');
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
INSERT INTO `PostTag` VALUES (5, 10);
INSERT INTO `PostTag` VALUES (11, 12);
INSERT INTO `PostTag` VALUES (11, 13);
INSERT INTO `PostTag` VALUES (11, 14);
INSERT INTO `PostTag` VALUES (14, 15);
INSERT INTO `PostTag` VALUES (14, 16);
INSERT INTO `PostTag` VALUES (14, 17);
INSERT INTO `PostTag` VALUES (22, 18);
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
  CONSTRAINT `PostCat` FOREIGN KEY (`CatID`) REFERENCES `Categories` (`ID`),
  CONSTRAINT `PostWriter` FOREIGN KEY (`WriterID`) REFERENCES `Writers` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of Posts
-- ----------------------------
BEGIN;
INSERT INTO `Posts` VALUES (1, 'Đường sắt giảm giá vận chuyển nông sản', 1, 5, 0, 'Tổng công ty Đường sắt Việt Nam (VNR) giảm 50% giá cước toa xe để hỗ trợ nông dân vận chuyển hàng nông sản.\r\nNgày 11/6, lãnh đạo Tổng công ty Đường sắt Việt Nam (VNR) cho hay, đơn vị này sẽ hỗ trợ người dân các tỉnh Bắc Giang, Bắc Ninh, Vĩnh Phúc, Hải Dương, Hưng Yên vận chuyển hàng nông sản đi các tỉnh miền Trung, Nam bằng tàu hỏa. Đây là các vùng dịch mà bà con đang gặp nhiều khó khăn trong việc vận chuyển, lưu thông hàng hóa.\r\nTheo đó, từ 11/6 đến 31/7, VNR giảm giá cước vận chuyển tối đa là 50%, đồng thời sử dụng các toa xe chuyên dụng và container lạnh bảo ôn vận chuyển hàng nông sản để đảm bảo chất lượng.\r\n\"Ngành đường sắt cũng chịu ảnh hưởng nặng bởi dịch Covid-19, song chúng tôi vẫn hướng về bà con vùng dịch bằng nguồn lực hiện có\", lãnh đạo VNR nói.\r\n5 tháng qua, hành khách đi tàu giảm hơn 1,1 triệu lượt, chỉ bằng 64% cùng kỳ năm trước. Doanh thu đạt hơn 400 tỷ đồng, bằng 51%.\r\nTrong tháng 5, ngành đường sắt đã cắt giảm 393 đoàn tàu, trong đó tàu Thống Nhất là 38 đoàn, tàu khách địa phương là 355 đoàn. Đến nay, toàn mạng lưới hiện chỉ chạy một đôi tàu Thống nhất là SE7/8, tàu địa phương không chạy.', 'Tổng công ty Đường sắt Việt Nam (VNR) giảm 50% giá cước toa xe để hỗ trợ nông dân vận chuyển hàng nông sản.', '2021-06-21 22:16:47', NULL, 1, 0);
INSERT INTO `Posts` VALUES (2, '2,5 tấn vải Bắc Giang được Quản lý thị trường bán trong vài giờ', 1, 5, 1, 'Sáng nay, 2,5 tấn vải của Bắc Giang đã được quản lý thị trường tỉnh Hoà Bình phối hợp với doanh nghiệp bán hết trong vòng vài giờ.\r\nĐây là chuyến hàng đầu tiên Đội Quản lý thị trường số 3 (Cục Quản lý thị trường Hoà Bình) triển khai, được vận chuyển từ tâm dịch Bắc Giang trong ngày hôm qua (29/5), để giúp bà con nông dân nơi đây tiêu thụ.\r\n\"Ngoài việc tạo điều kiện thuận lợi lưu thông hàng hóa, quản lý thị trường vào cuộc hỗ trợ tiêu thụ nông sản ùn ứ cho Bắc Giang đã thể hiện trách nhiệm với cộng đồng, góp phần phòng, chống Covid-19\" ông Nguyễn Bá Thức - Cục trưởng Cục Quản lý thị trường Hoà Bình nói.\r\nÔng Nguyễn Mạnh Trường - Đội phó Đội Quản lý thị trường số 3 (Cục Quản lý thị trường Hoà Bình) cho biết, giá vải đơn vị thu mua tại vườn của bà con Bắc Giang là 17.000 đồng một kg và được bán tại điểm hỗ trợ tiêu thụ nông sản Bắc Giang là 20.000 đồng mỗi kg.\r\nÔng Trường cho hay, mỗi kg vải quản lý thị trường vẫn phải bù lỗ, nhưng giúp được bà con nông dân trong lúc này thì đó là việc nên làm. \"Người dân nằm trong vùng dịch đã rất khổ rồi, nếu giá bán thấp quá, họ chẳng còn gì\", ông chia sẻ.\r\nCũng theo Đội phó Quản lý thị trường số 3, hiện vận chuyển, tiêu thụ hàng hoá của Bắc Giang đang gặp nhiều khó khăn, nhất là vận chuyển nông sản từ tỉnh này sang các địa phương khác và ngược lại. Mất 8 tiếng đồng hồ một chuyến xe vải Bắc Giang - Hoà Bình mới có thể quay đầu về vị trí xuất phát do phải tuân thủ các biện pháp khử khuẩn, phòng chống dịch.\r\nMỗi chuyến xe đi vào vùng dịch, lái xe sẽ phải thực hiện đầy đủ các bước khai báo y tế, khử khuẩn phương tiện. Đến Bắc Giang, xe của quản lý thị trường sẽ thực hiện trung chuyển tại Cục Quản lý thị trường tỉnh này. Các khâu thu mua, bốc xếp, khử khuẩn đều được thực hiện nghiêm ngặt. Xe khi về tới Hoà Bình lại được khử khuẩn, khai báo y tế theo quy định phòng dịch\", ông Trường chia sẻ.\r\nDự kiến mỗi tuần sẽ có 2 chuyến hàng với tổng khối lượng khoảng 5 tấn được vận chuyển về tiêu thụ tại điểm bán hàng của Đội Quản lý thị trường số 3.\r\n\"Chúng tôi sẽ thực hiện thí điểm, nếu hiệu quả có thể nhân rộng mô hình này tại một số đội trên địa bàn Hòa Bình\", ông Nguyễn Bá Thức - Cục trưởng Cục Quản lý thị trường Hòa Bình nói thêm.\r\nNgoài vải, quản lý thị trường Hoà Bình cũng giúp bà con Bắc Giang tiêu thụ một số loại nông sản. Theo ông Trường, khoảng 600 kg nông sản rau củ quả đã được đơn vị này hỗ trợ nông dân vùng dịch tiêu thụ trong ngày 29/5.\r\nTheo kế hoạch, mô hình trên sẽ được triển khai và nhân rộng tại nhiều tỉnh thành nhằm hỗ trợ nông dân tại vùng dịch tiêu thụ nông sản đến vụ thu hoạch.\r\nTại Hà Nội, vài ngày nay một số nhóm thiện nguyện cũng giúp bà con Bắc Giang tiêu thụ các mặt hàng nông sản như vải, dưa hấu...đang vào vụ, nhưng diễn biến Covid-19 phức tạp khiến việc mua bán chậm. Mỗi kg vải thiều sớm Bắc Giang được các nhóm thiện nguyện vận chuyển đưa về Hà Nội bán tại một số điểm trong thành phố với giá 20.000 đồng một kg; dưa hấu 6.000-7.000 đồng mỗi kg.\r\nTheo chị Nguyễn Thị Nhung (huyện Tân Yên, Bắc Giang), hiện hợp tác xã của huyện có gần 7.000 tấn vải và đã tiêu thụ được một nửa. Thời tiết nắng nóng, vải bắt đầu vào vụ thu hoạch nên không thể để lâu. Sự chung tay tiêu thụ vải của nhóm thiện nguyện giúp bà con trồng vải vơi phần nào nỗi lo ứ đọng hàng. Các chuyến xe hỗ trợ tiêu thụ vải đều được chính quyền xã hỗ trợ khử khuẩn hàng hoá, xe, lái xe khai báo y tế...\r\nNgoài các nhóm thiện nguyện, một số doanh nghiệp lớn cũng chung tay tiêu thụ vải thiều Bắc Giang. Như Tập đoàn Than, khoáng sản Việt Nam (TKV) mới đây đã có văn bản gửi tỉnh Bắc Giang đề nghị được mua 180 tấn vải thiều, giúp tỉnh này tiêu thụ vải khi mùa thu hoạch chính vụ đang tới.\r\nTheo báo cáo của tỉnh Bắc Giang, đến hết ngày 29/5, tổng sản lượng vải tiêu thụ đạt gần 14.500 tấn, trong đó tiêu thụ trong nước xấp xỉ 10.000 tấn, gần 4.400 tấn xuất khẩu. Giá thu mua bình quân 22.000-32.000 đồng một kg, tuỳ loại. Giá bán vải loại 1 đạt tiêu chuẩn VietGap, GlobalGap 30.000-35.000 đồng một kg.\r\nTuy nhiên, tỉnh Bắc Giang cho biết, việc lưu thông qua các chốt kiểm soát của các tỉnh vẫn khó khăn, container vận chuyển khan hiếm và giá thành vận chuyển cao.\r\nÔng Trần Duy Đông - Vụ trưởng Vụ Thị trường trong nước cho biết, đơn vị này đang phối hợp với tỉnh để gỡ \"ách tắc\" lưu thông hàng nông sản Bắc Giang tại một số địa phương.\r\nRiêng với vải thiều Bắc Giang xuất khẩu sang Trung Quốc - thị trường xuất khẩu chính của quả vải, tỉnh này cho hay, hiện được Lạng Sơn, Lào Cai và cơ quan hải quan, quản lý thị trường... tạo điều kiện thuận lợi, lưu thông luồng xanh nên việc thông quan hàng hoá nhanh chóng. Sáng 30/5, 15 xe vải Bắc Giang xuất khẩu qua cửa khẩu Tân Thanh (Lạng Sơn) được đi đường ưu tiên.', 'Sáng nay, 2,5 tấn vải của Bắc Giang đã được quản lý thị trường tỉnh Hoà Bình phối hợp với doanh nghiệp bán hết trong vòng vài giờ.', '2021-06-20 22:21:41', '2021-06-21 10:21:52', 4, 0);
INSERT INTO `Posts` VALUES (3, 'Ông Nguyễn Thành Phong tái đắc cử Chủ tịch TP HCM', 2, 9, 1, 'Với tỷ lệ tán thành 89,53%, ông Nguyễn Thành Phong tiếp tục làm Chủ tịch UBND TP HCM nhiệm kỳ 2021-2026.\n\nÔng Nguyễn Thành Phong được bầu giữ chức Chủ tịch UBND TP HCM tại kỳ họp thứ nhất HĐND thành phố khoá X sáng 24/6, sau khi được Chủ tịch HĐND thành phố Nguyễn Thị Lệ giới thiệu.\n\nÔng Phong 59 tuổi, quê Bến Tre, tiến sĩ kinh tế; từng đảm nhiệm các chức vụ Chủ tịch Hội sinh viên Việt Nam TP HCM, Bí thư Thành Đoàn TP HCM; Bí thư Trung ương Đoàn. Đầu năm 2007, ông làm Bí thư quận 2 trước khi trở thành Bí thư Tỉnh ủy Bến Tre. Tháng 3/2015, ông được Trung ương điều động trở lại TP HCM giữ cương vị Phó bí thư Thành ủy nhiệm kỳ 2010-2015.Tại Đại hội Đảng bộ TP HCM khóa X, nhiệm kỳ 2015-2020, tổ chức giữa tháng 10/2015, ông Phong tái cử Phó bí thư Thành ủy TP HCM, sau đó được bầu làm Chủ tịch UBND thành phố. Đến tháng 6/2016, kỳ họp thứ nhất HĐND TP HCM khoá X bầu ông giữ chức Chủ tịch UBND thành phố nhiệm kỳ 2016-2021.\n\nTại Đại hội Đảng bộ TP HCM khoá XI, nhiệm kỳ 2020-2025, tổ chức giữa tháng 10 năm ngoái ông Phong tái đắc cử Phó bí thư Thành ủy TP HCM.\n\nChủ tịch UBND thành phố là một trong 94 đại biểu HĐND thành phố khóa X, nhiệm kỳ 2021-2026. Trong chương trình hành động, ông cho biết sẽ tập trung giải quyết những vấn đề lớn của thành phố, gồm: xây dựng hiệu quả nền hành chính; phát triển kinh tế nhanh, bền vững trên ứng dụng khoa học công nghệ; nâng cao chất lượng quy hoạch đô thị; đẩy mạnh phòng chống Covid-19; xử lý tiếng ồn, ùn tắc, ngập nước; giữ vững an ninh chính trị, trật tự an toàn xã hội...\n\nCũng tại kỳ họp, HĐND thành phố khoá X bầu 5 Phó chủ tịch UBND thành phố nhiệm kỳ 2021-2026 theo giới thiệu của Chủ tịch UBND thành phố, gồm các ông, bà: Ngô Minh Châu (57 tuổi), Võ Văn Hoan (56 tuổi), Dương Anh Đức (53 tuổi), Lê Hoà Bình (51 tuổi), Phan Thị Thắng (45 tuổi). Đây cũng là 5 Phó chủ tịch UBND thành phố nhiệm kỳ trước.', 'Với tỷ lệ tán thành 89,53%, ông Nguyễn Thành Phong tiếp tục làm Chủ tịch UBND TP HCM nhiệm kỳ 2021-2026.', '2021-06-02 21:25:34', '2021-06-18 21:25:39', 10, 1);
INSERT INTO `Posts` VALUES (4, '\'Chính sách quốc phòng của Việt Nam mang tính chất hòa bình\'', 2, 9, -1, 'Chiều 23/6, Bộ trưởng Quốc phòng Việt Nam có bài phát biểu tại Phiên toàn thể thứ 2, hội nghị An ninh Quốc tế Moscow lần thứ 9 với chủ đề \"Các quan điểm chiến lược về an ninh khu vực\".\n\nTheo ông, trong bối cảnh tình hình quốc tế và khu vực đang có nhiều diễn biến nhanh chóng, khó lường, việc đề cập đến những quan điểm chiến lược về an ninh khu vực là hết sức thiết thực, thể hiện nhận thức của các bên trước những thách thức to lớn cần phải vượt qua; đồng thời, phản ánh mong muốn duy trì môi trường hòa bình, ổn định, làm tiền đề cho hợp tác và phát triển.\n\nÔng khẳng định Việt Nam tiếp tục thực hiện chính sách quốc phòng mang tính chất hòa bình và tự vệ; kiên quyết, kiên trì đấu tranh giải quyết mọi tranh chấp, bất đồng, trong đó có tranh chấp trên Biển Đông bằng biện pháp hòa bình trên cơ sở luật pháp quốc tếvà các quy định thống nhất trong khu vực; tích cực, chủ động hợp tác với các nước, trong đó có Nga nhằm bảo vệ môi trường hòa bình, ổn định để phát triển đất nước, vì cuộc sống của người dân.\n\n\"Từ những kinh nghiệm xương máu của dân tộc mình, Việt Nam hiểu giá trị của hòa bình, và cũng sẽ làm hết sức mình để đóng góp cho công cuộc bảo vệ hòa bình vì lợi ích không chỉ của chúng tôi màcòn của tất cả các quốc gia khác\", Thượng tướng Phan Văn Giang nói. Bộ trưởng Quốc phòng Việt Nam đánh giá cao, ủng hộ các hoạt động đa phương quốc tế do Bộ Quốc phòng Nga khởi xướng và chủ trì tổ chức, trong đó có Hội thao quân sự quốc tế Army Games.\n\nTheo ông, các hoạt động thực tế đã góp phần củng cố sự hiểu biết và tin cậy lẫn nhau, làm tiền đề cho các hoạt động hợp tác cũng như tăng cường khả năng phối hợp hoạt động chung giữa các lực lượng tham gia. Hội nghị An ninh quốc tế Moscow là sáng kiến của Bộ Quốc phòng Liên bang Nga, được tổ chức lần đầu vào năm 2012. Tại hội nghị lần thứ 9 này, Hội nghị có sự tham dự của hơn 100 nước và tổ chức quốc tế, với hình thức kết hợp trực tiếp và trực tuyến.\n\nHội nghị có 5 phiên toàn thể, Thượng tướng Phan Văn Giang phát biểu tại phiên toàn thể thứ 2 \"Khu vực Châu Á - Thái Bình Dương trong bối cảnh chính trị toàn cầu\".', 'Việt Nam tiếp tục thực hiện chính sách quốc phòng mang tính chất hòa bình và tự vệ, theo Bộ trưởng Quốc phòng, Thượng tướng Phan Văn Giang.', '2021-05-15 21:27:14', NULL, 5, 1);
INSERT INTO `Posts` VALUES (5, 'Kiến nghị giảm 10% giá vé qua trạm BOT xa lộ Hà Nội', 1, 1, 1, 'Nhà đầu ​tư đề xuất giảm 10% giá vé, tăng thời gian sử dụng vé tháng, quý tại trạm BOT xa lộ Hà Nội để hỗ trợ doanh nghiệp trước tác động Covid-19.\n\nKiến nghị vừa được Công ty cổ phần Đầu tư hạ tầng kỹ thuật TP HCM (nhà đầu tư) gửi UBND thành phố để áp dụng từ ngày 1/7 đến 30/9. Sau thời gian này, trạm BOT xa lộ Hà Nội (TP Thủ Đức) trở lại mức phí cũ. Giá vé mới được đề xuất 22.000 đồng với ôtô dưới 12 chỗ, xe tải dưới 2 tấn và xe buýt; vé ôtô 12-30 chỗ, xe tải 2-4 tấn là 35.000 đồng; ôtô từ 31 chỗ trở lên, xe tải 4-10 tấn là 45.000 đồng; xe tải 10-18 tấn, container 20 feet là 90.000 đồng; xe tải trên 18 tấn, container loại 40 feet áp dụng 125.000 đồng.\n\nHiện, khung giá áp dụng lần lượt cho các loại xe nói trên là 25.000 đồng, 38.000 đồng, 50.000 đồng, 100.000 đồng và 140.000 đồng.\n\nXe mua vé tháng và quý sẽ không giảm giá, song được đề xuất tăng 10% thời gian sử dụng trong giai đoạn được giảm giá.\n\nBOT xa lộ Hà Nội bắt đầu thu phí hồi đầu tháng 4, nhằm hoàn vốn cho dự án mở rộng tuyến đường này và đoạn quốc lộ 1 từ ngã ba Trạm 2 cũ đến nút giao Tân Vạn (Bình Dương). Toàn dự án dài 15,7 km, tổng vốn đầu tư hơn 4.900 tỷ đồng.\n\nCovid-19 khiến hoạt động kinh doanh vận tải bị ảnh hưởng nặng nề, đặc biệt là vận tải hành khách. Trong tháng 5, loại hình này ở cả nước chỉ đạt khoảng 288 triệu lượt khách, giảm 14% so với tháng trước.\n\nBộ Tài chính đang dự thảo đề xuất giảm phí bảo trì đường bộ cho các doanh nghiệp vận tải bị ảnh hưởng dịch. Trong đó xe khách, buýt giảm 30%; ôtô tải, xe chuyên dùng, container giảm 10%.', 'Nhà đầu ​tư đề xuất giảm 10% giá vé, tăng thời gian sử dụng vé tháng, quý tại trạm BOT xa lộ Hà Nội để hỗ trợ doanh nghiệp trước tác động Covid-19.', '2021-06-11 21:29:23', '2021-06-17 21:29:28', 8, 0);
INSERT INTO `Posts` VALUES (6, '28 sân bay được quy hoạch đến năm 2030', 2, 1, 0, 'Bộ Giao thông Vận tải đề xuất quy hoạch cả nước có 28 sân bay đến năm 2030 và 29 sân bay đến năm 2050. Ngày 21/6, đại diện Bộ Giao thông Vận tải cho hay cơ quan này đã hoàn thành và trình Chính phủ dự thảo quy hoạch cảng hàng không toàn quốc đến năm 2030, tầm nhìn đến 2050.\n\nTheo đó, đến năm 2030, Bộ Giao thông Vận tải đề xuất 28 sân bay trong quy hoạch, gồm: 14 cảng quốc tế là Nội Bài, Long Thành, Tân Sơn Nhất, Vân Đồn, Cát Bi, Thọ Xuân, Vinh, Phú Bài, Đà Nẵng, Cam Ranh, Chu Lai, Cần Thơ, Phú Quốc và Liên Khương.\n\n14 sân bay quốc nội gồm: Lai Châu, Điện Biên, Sa Pa, Nà Sản, Quảng Trị, Pleiku, Phù Cát, Tuy Hòa, Buôn Ma Thuột, Phan Thiết, Đồng Hới, Rạch Giá, Cà Mau và Côn Đảo.\n\nNgoài ra, Bộ Giao thông Vận tải đang nghiên cứu, khảo sát và báo cáo Thủ tướng quyết định việc bổ sung quy hoạch sân bay tại các đảo Lý Sơn, Phú Quý...\n\nNhư vậy, số lượng 28 sân bay đến năm 2030 giữ nguyên như quy hoạch hiện nay (quy hoạch phát triển giao thông hàng không được Chính phủ phê duyệt năm 2018). Các kiến nghị bổ sung quy hoạch sân bay của 11 địa phương thời gian qua không được chấp thuận (gồm các tỉnh: Bắc Giang, Bắc Kạn, Đăk Nông, Ninh Bình, Hà Giang, Hòa Bình, Bình Phước, Kon Tum, Hà Tĩnh, Trà Vinh và Ninh Thuận). Đến năm 2050, Bộ Giao thông Vận tải đề xuất bổ sung sân bay Cao Bằng phục vụ quốc nội, nâng số cảng nội địa là 15; đồng thời tiếp tục duy trì vị trí quy hoạch sân bay quốc tế Hải Phòng (tại Tiên Lãng) nhằm dự bị cho sân bay Nội Bài và Cát Bi.\n\nVề lý do giữ nguyên quy hoạch 28 sân bay, đại diện Bộ Giao thông Vận tải cho hay một sân bay mới muốn được đưa vào quy hoạch phải dựa trên cơ sở dự báo nhu cầu của 5 loại hình vận tải đường bộ, đường sắt, đường thủy, hàng hải, hàng không và điều kiện tự nhiên, hiệu quả kinh tế, kinh nghiệm quốc tế.\n\nSân bay đó phải phù hợp 6 tiêu chí chính (22 tiêu chí chi tiết) để xem xét tính khả thi, gồm: Nhu cầu sản lượng; tình hình kinh tế xã hội (tăng trưởng GDP, việc làm, thúc đẩy du lịch); an ninh quốc phòng; khẩn nguy cứu trợ; điều kiện tự nhiên (vùng trời, tĩnh không, thời tiết, đất đai); cự ly bố trí (cự ly tới đô thị trung tâm, cự ly tiếp cận các sân bay lân cận).\n\n\"Theo các tiêu chí này, kiến nghị bổ sung quy hoạch sân bay của 11 địa phương thời gian qua đã không được chấp thuận\", đại diện Bộ Giao thông Vận tải nói.\n\nTheo dự thảo quy hoạch mới, các sân bay quốc tế lớn đóng vai trò đầu mối như Long Thành (giai đoạn 1) đạt công suất 25 triệu hành khách mỗi năm; Tân Sơn Nhất sẽ được mở rộng lên 50 triệu khách; Nội Bài đạt công suất 60 triệu khách; sân bay Đà Nẵng 25 triệu khách...\n\nQuy hoạch xác định nhu cầu vốn đầu tư cho các cảng hàng không trên toàn quốc đến năm 2030 khoảng 403.100 tỷ đồng.', 'Bộ Giao thông Vận tải đề xuất quy hoạch cả nước có 28 sân bay đến năm 2030 và 29 sân bay đến năm 2050.', '2021-06-08 21:41:53', NULL, 7, 0);
INSERT INTO `Posts` VALUES (7, '\'Mỹ nhân 4.000 năm có một\' phủ nhận sửa mặt', 2, 7, 1, 'Cúc Tịnh Y - diễn viên được gọi là \"mỹ nhân 4.000 năm có một\" - phủ nhận phẫu thuật thẩm mỹ gương mặt và cầu vai. Các bức ảnh cũ của Tịnh Y lan truyền trên Weibo ngày 22/6, nhiều lần vào top tìm kiếm, bình luận. Một số tài khoản cho rằng ngoài sửa mắt, mũi và cằm, Cúc Tịnh Y còn sửa vai. Hàng nghìn ý kiến nhận xét cô là \"vịt hóa thiên nga\", \"sao nữ đập đi xây lại thành công nhất\", \"sản phẩm dao kéo\"... Các fan của Tịnh Y bảo vệ thần tượng, cho rằng cô kiên trì tập gym để vóc dáng đẹp hơn. Công ty quản lý của Cúc Tịnh Y ra thông cáo cho biết một số người cố tình tung tin thất thiệt để bôi nhọ, làm tổn thương cô. Người đại diện kêu gọi khán giả không chia sẻ bài viết nói Cúc Tịnh Y phẫu thuật thẩm mỹ. Công ty đã thuê luật sư thu thập chứng cứ, kiện người tung tin không đúng về nữ diễn viên.', 'Cúc Tịnh Y - diễn viên được gọi là \"mỹ nhân 4.000 năm có một\" - phủ nhận phẫu thuật thẩm mỹ gương mặt và cầu vai.', '2021-06-09 21:43:53', '2021-06-11 21:44:00', 262, 0);
INSERT INTO `Posts` VALUES (8, 'Top 5 Hoa hậu Việt Nam 2020 tiếp tục thi nhan sắc', 1, 7, 1, 'Huỳnh Nguyễn Mai Phương - Người đẹp Nhân ái, Top 5 Hoa hậu Việt Nam 2020 - muốn đem đến hình ảnh mới mẻ tại Miss World Vietnam 2021. Mai Phương cho biết đã dành nhiều tháng để tìm hiểu về cuộc thi Miss World, từ đó đưa ra định hướng và phát triển các kỹ năng phù hợp trước khi đăng ký. Nếu tại Hoa hậu Việt Nam 2020, cô rụt rè thì ở lần này, cô xây dựng hình ảnh sắc sảo, quyến rũ hơn để thử thách bản thân. Cô đặt mục tiêu tiến sâu trong đêm chung kết. Cô gái sinh năm 1999 đến từ Đồng Nai, cao 1,7 m, số đo ba vòng 77-62-90 cm, từng được xếp vào nhóm thí sinh có gương mặt đẹp ở Hoa hậu Việt Nam 2020. Mai Phương vào Top 5 chung cuộc và giành giải Người đẹp Nhân ái. Trước đó, cô từng đăng quang Hoa Khôi Đại học Đồng Nai, giành giải nhì và giải ba học sinh giỏi tiếng Anh cấp tỉnh năm 2017 và 2018. Cô hiện làm việc trong ngành truyền hình.\n\nMiss World Vietnam 2021 - cuộc thi nhằm tìm kiếm người đẹp đại diện quốc gia thi Miss World - đang ở giai đoạn khởi động. Ban tổ chức năm nay mở cửa cho các thí sinh phẫu thuật thẩm mỹ. Ngoài ra, chiều cao tối thiểu của thí sinh giảm từ 1,65 m còn 1,63 m.\n\nFormat cuộc thi vẫn bám sát quốc tế với các phần thi phụ Người đẹp nhân ái, Người đẹp thời trang, Người đẹp truyền thông... Dàn giám khảo gồm: Hoa hậu Hà Kiều Anh, hoa hậu Lương Thùy Linh, ca sĩ Đàm Vĩnh Hưng, ông Lê Xuân Sơn - Tổng biên tập báo Tiền Phong... Đêm chung kết dự kiến diễn ra vào cuối năm, với các nội dung thi: áo dài, áo tắm, trang phục tự chọn, thuyết trình về quê hương đất nước và ứng xử dành cho Top 5.', 'Huỳnh Nguyễn Mai Phương - Người đẹp Nhân ái, Top 5 Hoa hậu Việt Nam 2020 - muốn đem đến hình ảnh mới mẻ tại Miss World Vietnam 2021.', '2021-05-21 21:45:35', '2021-05-31 21:45:40', 11, 0);
INSERT INTO `Posts` VALUES (9, 'Bom tấn Trung Quốc có kinh phí 200 triệu USD', 1, 6, 0, 'Phim chiến tranh \"Trường Luật Hồ\" do Trần Khải Ca đồng đạo diễn, Ngô Kinh đóng chính được đầu tư hơn 200 triệu USD. Theo Sina, Trường Luật Hồ (The Battle at Lake Changjin) thuộc nhóm phim được đầu tư lớn nhất lịch sử điện ảnh Trung Quốc với êkip hùng hậu gồm ba đạo diễn Trần Khải Ca, Từ Khắc, Lâm Siêu Hiền. Dàn diễn viên tên tuổi tham gia dự án gồm: Ngô Kinh, Dịch Dương Thiên Tỉ, Đoạn Dịch Hoành, Lý Thần, Hồ Quân, Chu Á Văn... Phim lấy bối cảnh Chiến tranh Triều Tiên (1950-1953), Trung Quốc tham chiến chặn quân Mỹ, chi viện Triều Tiên. Trên National Business Daily, Trần Khải Ca cho biết ông phụ trách xây dựng tính cách nhân vật, khắc họa con người thời chiến. Từ Khắc đảm nhiệm các phần cao trào còn Lâm Siêu Hiền chỉ đạo tất cả cảnh hành động. Tác phẩm sẽ tham gia chợ phim Cannes tổ chức trực tuyến vào tháng 7, sau đó phát hành toàn cầu trong năm nay.', 'Phim chiến tranh \"Trường Luật Hồ\" do Trần Khải Ca đồng đạo diễn, Ngô Kinh đóng chính được đầu tư hơn 200 triệu USD.', '2021-06-25 21:46:48', NULL, 0, 0);
INSERT INTO `Posts` VALUES (10, 'Trương Thế Vinh: \'Tôi phải điều chỉnh tâm lý sau vai Ngà\'', 2, 6, 1, 'Trương Thế Vinh nhập tâm diễn nhân vật Ngà lười biếng, ham ăn, mê cờ bạc trong \"Cây táo nở hoa\" đến nỗi mất cân bằng tâm lý. - Trong phim, nhân vật Ngà khiến người xem ức chế, anh nghĩ sao?\n\n- Ngay từ khi đọc kịch bản, tôi đã biết Ngà sẽ mang lại cảm xúc gì cho khán giả. Tôi cũng không thích nhân vật này - một người lười biếng, ham ăn, mê cờ bạc và gây ra không biết bao nhiêu rắc rối cho gia đình. Từ bé, tôi đã rất ghét cờ bạc. Tôi mà biết ai chơi là khuyên họ bỏ ngay.\n\nNgà là người đàn ông bị mắc kẹt ở tuổi thơ, không bao giờ lớn nổi. Anh ta không bị thiểu năng mà là có trí tuệ của một đứa trẻ. Vì vậy, anh có những suy nghĩ, hành xử không đúng lứa tuổi. Phần đầu phim là những tình tiết khắc họa tính cách nhân vật nên người xem sẽ ức chế. Tôi coi phản ứng khán giả như minh chứng mình làm tốt vai diễn. Nửa sau phim, mọi người có thể hiểu được vì sao Ngà lại như vậy. Nhân vật trải qua nhiều biến cố và có những thay đổi trong tính cách.', 'Trương Thế Vinh nhập tâm diễn nhân vật Ngà lười biếng, ham ăn, mê cờ bạc trong \"Cây táo nở hoa\" đến nỗi mất cân bằng tâm lý.', '2021-06-16 21:47:51', '2021-06-16 23:47:56', 0, 0);
INSERT INTO `Posts` VALUES (11, 'Suối tổ ong hơn 100 triệu năm tuổi tại Gia Lai', 1, 11, 0, 'Dòng suối và bãi đá này ở làng Vân, thuộc thị trấn Ialy, huyện Chư Păh, tỉnh Gia Lai. Người Jrai quanh vùng gọi nơi này là Jrai Phă (jrai nghĩa là thác nước, phă là bể). Một số khách đến tham quan còn gọi là suối Đá Đĩa vì nơi này có hình dạng như Ghềnh Đá Đĩa, di tích quốc gia đặc biệt ở huyện Tuy An, tỉnh Phú Yên.\nvượt 100 triệu năm tuổi. \nBiết thông tin tỉnh nhà xuất hiện bãi đá cổ, bà Bích Vân (57 tuổi) chạy xe máy khoảng 140 km từ thị xã An Khê đến huyện Chư Păh để chiêm ngưỡng con suối. \"Tây Nguyên đang bước vào mùa mưa nên nước ở suối có pha đất đỏ trông hơi đục, tuy nhiên vẫn có vẻ đẹp riêng. Tham quan vào mùa này, mọi người nên cẩn thận nước mưa từ thượng nguồn đổ về sẽ làm cho dòng chảy mạnh, cần cẩn thận khi tham quan, cắm trại có trẻ nhỏ ven suối\", bà chia sẻ.', 'Con suối được ví như Ghềnh Đá Đĩa trên cạn khi có nhiều trụ đá hình lục lăng xếp cạnh nhau trông như \"tổ ong\" khổng lồ.', '2021-06-27 13:34:03', NULL, 1, 0);
INSERT INTO `Posts` VALUES (12, 'Quán cà phê rợp cây xanh ở trung tâm Hà Nội', 1, 11, 0, 'Quán The Firefly nằm trên con phố nhỏ Nguyễn Văn Tuyết, gần gò Đống Đa, ngay dưới chân một toà chung cư cao tầng. Quán được thiết kế theo kiểu cà phê sân vườn với nhiều cây xanh và không gian mộc mạc, giản dị. Bước vào quán là có thể thấy cây xanh ở khắp mọi nơi.\nCây được trồng khá tự do và ngẫu hứng, trong đó có những cây từ trước và những cây mới trồng trong bồn, trong chậu hay trực tiếp lên nền đất tạo nên một không gian xanh mát mẻ và gần gũi thiên nhiên.', 'Quán cà phê ở quận Đống Đa có khoảng không gian sân vườn rộng rãi và nhiều cây xanh, đem lại cảm giác thư thái, thoải mái cho khách.', '2021-06-27 13:34:03', NULL, 0, 0);
INSERT INTO `Posts` VALUES (13, 'Travel Pass được áp dụng thế nào cho hành khách?', 1, 12, 0, 'Số lượng các hãng hàng không trên thế giới đang thử nghiệm ứng dụng \"Giấy thông hành đặc biệt\" (Travel Pass) từ Hiệp hội Vận tải Hàng không Quốc tế (IATA) ngày càng tăng. Hiện có khoảng 50 hãng, trong đó có nhiều hãng lớn như Air France, Singapore Airlines, Qatar Airways, All Nippon Airways... đang áp dụng. Vietnam Airlines và Vietjet Air của Việt Nam cũng nằm trong số này.', 'Hành khách có thể kiểm tra các yêu cầu nhập cảnh mới nhất tại điểm đến cũng như kết quả xét nghiệm nCoV...', '2021-06-27 13:34:03', NULL, 1, 0);
INSERT INTO `Posts` VALUES (14, '10 loại sushi phổ biến nhất ở Nhật Bản', 1, 12, 0, 'Nare sushi (hay narezushi) là một kiểu sushi \"cổ đại\" vẫn có bán ở khắp nơi tại Nhật, đặc biệt nhiều nhất ở vùng Shiga. Tại đây thực khách biết tới narezushi với tên gọi phổ biến hơn là funazushi - đặc sản địa phương làm từ cá ướp muối mặn và cơm trong nhiều năm liền. Narezushi là một trong những loại sushi được sáng tạo ra sớm nhất trên thế giới. Từ thế kỷ 10 tại Nhật Bản, loại cá lên men này đã được bảo quản bằng muối và gạo, sau đó mới cải tiến thành nigiri (sushi kiểu cơm nắm và cá thái lát đặt lên trên) mà chúng ta biết ngày nay. Ảnh: CNN', 'Dù chỉ có một cách gọi nhưng sushi ở Nhật có rất nhiều loại từ cơm cuộn rong biển, sushi cuộn tròn, hoặc đơn giản là một tô cơm và cá sống.', '2021-06-27 13:34:03', NULL, 0, 0);
INSERT INTO `Posts` VALUES (15, 'Nguy cơ mắc bệnh gout do uống nhiều trà sữa trân châu', 1, 14, 0, '	Tiến sĩ Victor Seah, bác sĩ phẫu thuật chỉnh hình tại Bệnh viện Parkway East, Singapore, cho biết: \"Tôi thấy trung bình bốn hoặc năm người bị bệnh gout đến khám mỗi tháng\". Những bệnh nhân này đều uống trà sữa trân châu thường xuyên. \nBệnh gout là tình trạng đau đớn dữ dội tại các khớp. Nguyên nhân của bệnh là do nồng độ axit uric trong máu tăng cao.', 'Trà sữa trân châu chứa nhiều đường và calo, do đó, những tín đồ của loại đồ uống này cần đề phòng nguy cơ mắc bệnh gout.', '2021-06-27 13:34:03', NULL, 0, 1);
INSERT INTO `Posts` VALUES (16, 'Kiểm soát cao huyết áp bằng thực phẩm', 1, 14, 0, '	Bác sĩ chuyên khoa 1 Hoàng Văn Đức - Phó trưởng khoa Nội Tim mạch, Bệnh viện 199 (Bộ Công An) cho biết: Một chế độ ăn uống lành mạnh là điều cần thiết để giảm huyết áp và duy trì mức huyết áp ổn định. Các nghiên cứu cho thấy một số loại thực phẩm, đặc biệt những sản phẩm chứa nhiều chất dinh dưỡng như kali và magiê, giúp giảm huyết áp.', 'Cá hồi, bí ngô, cần tây, bông cải xanh, chuối, kiwi, tỏi... là những thực phẩm nên bổ sung trong chế độ ăn hàng ngày với người bệnh cao huyết áp.', '2021-06-27 13:34:03', NULL, 0, 0);
INSERT INTO `Posts` VALUES (17, 'Tránh nguy cơ mắc bệnh mạn tính không lây bằng dự phòng thừa cân', 1, 15, 0, 'Giáo sư, tiến sĩ Nguyễn Gia Khánh, Chủ tịch Hội Nhi khoa Việt Nam cảnh báo, hiện nay nhiều cha mẹ vẫn giữ quan điểm \"con tròn trịa, mập mạp mới tốt, mới dễ thương\" mà không biết đó là dấu hiệu đặc trưng của thừa cân và béo phì - một gánh nặng sức khỏe toàn cầu.', 'Trẻ thừa cân, béo phì có nguy cơ mắc bệnh mãn tính như tim mạch, xương khớp… khi trưởng thành,', '2021-06-27 13:34:03', NULL, 0, 0);
INSERT INTO `Posts` VALUES (18, '3 quan niệm sai lầm của bố mẹ khiến con thừa cân, béo phì', 1, 15, 0, 'Trong 10 năm, tỷ lệ thừa cân, béo phì của trẻ em Việt Nam trong độ tuổi 5 - 19 tăng gấp đôi từ 8,5% (năm 2010) lên 19% (năm 2020), theo kết quả Tổng điều tra Dinh dưỡng toàn quốc năm 2019-2020 của Bộ Y tế. Một báo cáo của Viện Dinh dưỡng quốc gia năm 2019 sau khi khảo sát tại 75 trường học ở 5 tỉnh, thành phố ghi nhận tỷ lệ thừa cân béo phì của học sinh khu vực thành thị là 41,9%. Đây là những con số đáng báo động về tình trạng thừa cân của trẻ em từ lứa tuổi mầm non đến trung học. Mặc dù vậy, trong một khảo sát của Viện Dinh dưỡng tại Hà Nội năm 2019, có đến 53% phụ huynh không biết, thậm chí không chấp nhận rằng con mình thừa cân, béo phì.', 'Béo sẽ khỏe, ít đau ốm hay phát triển nhanh... là những quan niệm chưa đúng của nhiều bố mẹ Việt.', '2021-06-27 13:34:03', NULL, 0, 0);
INSERT INTO `Posts` VALUES (19, 'Lời khuyên về phương pháp giảng dạy trẻ trước khi vào lớp 1', 1, 21, 0, 'Đây là content của bài lời khuyên phương pháp dạy học cho trẻ lớp 1', 'Đây là abstract của phương pháp dạy trẻ lớp 1', '2021-07-06 21:01:47', NULL, 0, 0);
INSERT INTO `Posts` VALUES (20, 'Lộ trình 4 bước học hè trực tuyến cho trẻ tiểu học', 1, 21, 0, 'Đây là content của Lộ trình 4 bước học hè trực tuyến cho trẻ tiểu học', 'Đây là abstract của Lộ trình 4 bước học hè trực tuyến cho trẻ tiểu học', '2021-07-06 21:01:47', NULL, 0, 0);
INSERT INTO `Posts` VALUES (21, 'Điểm tuyển sinh đại học năm 2020 cao bất ngờ', 1, 20, 0, 'Đây là content của bài Điểm tuyển sinh đại học năm 2020 cao bất ngờ', 'Đây là abstract của Điểm tuyển sinh đại học năm 2020 cao bất ngờ', '2021-07-06 21:01:47', NULL, 0, 0);
INSERT INTO `Posts` VALUES (22, 'Đội tuyển bóng đá Việt Nam vào vòng loại 3 khu vực Châu Á', 1, 17, 0, 'Đây là content của bài Đội tuyển bóng đá Việt Nam vào vòng loại 3 khu vực Châu Á', 'Đây là abstract của Đội tuyển bóng đá Việt Nam vào vòng loại 3 khu vực Châu Á', '2021-07-06 21:01:47', NULL, 0, 0);
INSERT INTO `Posts` VALUES (23, 'Cờ vua môn thể thao trí tuệ cần được quan tâm', 1, 18, 0, 'Đây là content của bài Cờ vua môn thể thao trí tuệ cần được quan tâm', 'Đây là abstract của Cờ vua môn thể thao trí tuệ cần được quan tâm', '2021-07-06 21:01:47', NULL, 0, 0);
INSERT INTO `Posts` VALUES (24, 'This a title', 2, 1, 0, '<p>Ahuhu</p>\r\n<p><img title=\"bhorse.jpg\" src=\"data:image/jpeg;base64,/9j/4AAQSkZJRgABAgEASABIAAD/7QYUUGhvdG9zaG9wIDMuMAA4QklNA+0AAAAAABAASAAAAAEAAQBIAAAAAQABOEJJTQQNAAAAAAAEAAAAeDhCSU0D8wAAAAAACAAAAAAAAAAAOEJJTQQKAAAAAAABAAA4QklNJxAAAAAAAAoAAQAAAAAAAAACOEJJTQP1AAAAAABIAC9mZgABAGxmZgAGAAAAAAABAC9mZgABAKGZmgAGAAAAAAABADIAAAABAFoAAAAGAAAAAAABADUAAAABAC0AAAAGAAAAAAABOEJJTQP4AAAAAABwAAD/////////////////////////////A+gAAAAA/////////////////////////////wPoAAAAAP////////////////////////////8D6AAAAAD/////////////////////////////A+gAADhCSU0ECAAAAAAAEAAAAAEAAAJAAAACQAAAAAA4QklNBBQAAAAAAAQAAAADOEJJTQQMAAAAAASDAAAAAQAAACIAAAAgAAAAaAAADQAAAARnABgAAf/Y/+AAEEpGSUYAAQIBAEgASAAA//4AJkZpbGUgd3JpdHRlbiBieSBBZG9iZSBQaG90b3Nob3CoIDUuMv/uAA5BZG9iZQBkgAAAAAH/2wCEAAwICAgJCAwJCQwRCwoLERUPDAwPFRgTExUTExgRDAwMDAwMEQwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwBDQsLDQ4NEA4OEBQODg4UFA4ODg4UEQwMDAwMEREMDAwMDAwRDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDP/AABEIACAAIgMBIgACEQEDEQH/3QAEAAP/xAE/AAABBQEBAQEBAQAAAAAAAAADAAECBAUGBwgJCgsBAAEFAQEBAQEBAAAAAAAAAAEAAgMEBQYHCAkKCxAAAQQBAwIEAgUHBggFAwwzAQACEQMEIRIxBUFRYRMicYEyBhSRobFCIyQVUsFiMzRygtFDByWSU/Dh8WNzNRaisoMmRJNUZEXCo3Q2F9JV4mXys4TD03Xj80YnlKSFtJXE1OT0pbXF1eX1VmZ2hpamtsbW5vY3R1dnd4eXp7fH1+f3EQACAgECBAQDBAUGBwcGBTUBAAIRAyExEgRBUWFxIhMFMoGRFKGxQiPB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\" alt=\"\" width=\"34\" height=\"32\" /></p>\r\n<p>Coi thu duoc khong</p>\r\n<div style=\"left: 0px; width: 100%; height: 0px; position: relative; padding-bottom: 56.25%; max-width: 650px;\" data-ephox-embed-iri=\"https://www.youtube.com/watch?v=MfN0c5poKLU&amp;list=RDMfN0c5poKLU&amp;start_radio=1\"><iframe style=\"top: 0; left: 0; width: 100%; height: 100%; position: absolute; border: 0;\" src=\"https://www.youtube.com/embed/MfN0c5poKLU?rel=0\" scrolling=\"no\" allowfullscreen=\"allowfullscreen\"></iframe></div>\r\n<ul class=\"tox-checklist\">\r\n<li style=\"text-align: center;\">upthem<strong> tam anh </strong>nua</li>\r\n</ul>', 'This a abstract', '2021-07-08 00:36:13', NULL, 50, 0);
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
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ReadersUniqueUsername` (`UserName`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of Readers
-- ----------------------------
BEGIN;
INSERT INTO `Readers` VALUES (1, 'Minh Vuong', 'rd1', '$2a$10$PVQowrDoFnb61ixyiNRVl.Ntlu4l9aeqbFCRjTjzi353/Fy83fN7S', '10 Truong Chinh', NULL, 'hieuflong@gmail.com', NULL);
INSERT INTO `Readers` VALUES (2, 'Trinh', 'rd2', '$2a$10$PVQowrDoFnb61ixyiNRVl.Ntlu4l9aeqbFCRjTjzi353/Fy83fN7S', '10 Truong Chinh', NULL, 'hieuflong@gmail.com', '2021-06-21 00:00:00');
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
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;

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
INSERT INTO `Tags` VALUES (2, 'drama');
INSERT INTO `Tags` VALUES (12, 'dulich');
INSERT INTO `Tags` VALUES (27, 'giaovien');
INSERT INTO `Tags` VALUES (4, 'haisan');
INSERT INTO `Tags` VALUES (3, 'hoinghi');
INSERT INTO `Tags` VALUES (5, 'kinhdi');
INSERT INTO `Tags` VALUES (17, 'monngon');
INSERT INTO `Tags` VALUES (6, 'nongsan');
INSERT INTO `Tags` VALUES (7, 'quocte');
INSERT INTO `Tags` VALUES (9, 'tainan');
INSERT INTO `Tags` VALUES (21, 'thidau');
INSERT INTO `Tags` VALUES (13, 'thiennhien');
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
  PRIMARY KEY (`ID`) USING BTREE,
  UNIQUE KEY `WriterUniqueUsername` (`UserName`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of Writers
-- ----------------------------
BEGIN;
INSERT INTO `Writers` VALUES (1, 'Writer 1', 'Huan Hoa Hong', 'wrt1', '$2a$10$PVQowrDoFnb61ixyiNRVl.Ntlu4l9aeqbFCRjTjzi353/Fy83fN7S', '10 Truong Chinh', NULL, 'hieuflong@gmail.com');
INSERT INTO `Writers` VALUES (2, 'Writer 2', 'Cuc Bach Mai', 'wrt2', '$2a$10$VmT9wfxpoOAvz9e/kVJCkOvkON1CvhJULiDy5gTfkixFczsHe9xke', '20 An Duong Vuong', NULL, 'wrt@gmail.com');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
