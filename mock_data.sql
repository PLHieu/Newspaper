-- ----------------------------
-- Records of Admins
-- ----------------------------
BEGIN;
INSERT INTO `Admins` VALUES (1, 'Admin 1', 'adm1', '$2a$10$n1IhX5nX.9XzEao.cb9LUOIBGtV.RE0bwSciiqohxTfdzjKkWPv0G', '10 Truong Chinh', NULL, 'hieuflong@gmail.com');
INSERT INTO `Admins` VALUES (2, 'Admin 2', 'admin', '$2a$10$9VYfnavcm1XMvikacJA5GOGvFz5bOY6mPBorehYZuAFNh.x7w590.', NULL, NULL, 'admin@gmail.com');
COMMIT;

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
-- Records of Writers
-- ----------------------------
BEGIN;
INSERT INTO `Writers` VALUES (1, 'Writer 1', 'Huan Hoa Hong', 'wrt1', '$2a$10$PVQowrDoFnb61ixyiNRVl.Ntlu4l9aeqbFCRjTjzi353/Fy83fN7S', '10 Truong Chinh', NULL, 'hieuflong@gmail.com', 1);
INSERT INTO `Writers` VALUES (2, 'Writer 2', 'Cuc Bach Mai', 'wrt2', '$2a$10$VmT9wfxpoOAvz9e/kVJCkOvkON1CvhJULiDy5gTfkixFczsHe9xke', '20 An Duong Vuong', NULL, 'wrt@gmail.com', 1);
COMMIT;

-- ----------------------------
-- Records of Editors
-- ----------------------------
BEGIN;
INSERT INTO `Editors` VALUES (1, 'Editor 1', 'edt1', '$2a$10$PVQowrDoFnb61ixyiNRVl.Ntlu4l9aeqbFCRjTjzi353/Fy83fN7S', '10 Truong Chinh', NULL, 'hieuflong@gmail.com', 1);
INSERT INTO `Editors` VALUES (2, 'Editor 2', 'edt2', '$2a$10$rSqL5/s/ns5TsczY59CZZOglkbRR1FRo9Qp0ogImNgqjKbbbr1ns2', '10 Pham Ngu Lao', NULL, 'editor@gmail.com', 4);
COMMIT;

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
-- Records of Drafts
-- ----------------------------
BEGIN;
INSERT INTO `Drafts` VALUES (1, 4, 1, 'Không đúng tiêu đề', '2021-07-06 01:18:12');
INSERT INTO `Drafts` VALUES (2, 18, 2, 'Tóm tắt cần ngắn gọn', '2021-07-15 05:04:30');
INSERT INTO `Drafts` VALUES (3, 20, 1, 'Thông tin quá ngắn', '2021-07-18 05:04:55');
INSERT INTO `Drafts` VALUES (4, 24, 2, 'Chưa có ảnh hợp lý', '2021-07-19 05:05:16');
COMMIT;

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





