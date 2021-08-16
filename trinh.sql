-- editor
INSERT INTO `Editors` VALUES (9, 'Editor 9', 'edt9', '$2a$10$PVQowrDoFnb61ixyiNRVl.Ntlu4l9aeqbFCRjTjzi353/Fy83fN7S', '10 Truong Chinh', NULL, 'hieuflong9@gmail.com', 14);
INSERT INTO `Editors` VALUES (10, 'Editor 10', 'edt10', '$2a$10$PVQowrDoFnb61ixyiNRVl.Ntlu4l9aeqbFCRjTjzi353/Fy83fN7S', '10 Truong Chinh', NULL, 'hieuflong10@gmail.com', 15);
INSERT INTO `Editors` VALUES (11, 'Editor 11', 'edt11', '$2a$10$PVQowrDoFnb61ixyiNRVl.Ntlu4l9aeqbFCRjTjzi353/Fy83fN7S', '10 Truong Chinh', NULL, 'hieuflong11@gmail.com', 17);
INSERT INTO `Editors` VALUES (12, 'Editor 12', 'edt12', '$2a$10$PVQowrDoFnb61ixyiNRVl.Ntlu4l9aeqbFCRjTjzi353/Fy83fN7S', '10 Truong Chinh', NULL, 'hieuflong12@gmail.com', 18);

-- writer
INSERT INTO `Writers` VALUES (5, 'Nguyễn Ngọc An', 'Ngọc An', 'wrt5', '$2a$10$VmT9wfxpoOAvz9e/kVJCkOvkON1CvhJULiDy5gTfkixFczsHe9xke', '20 An Duong Vuong', NULL, 'wrt5@gmail.com', 1);
INSERT INTO `Writers` VALUES (6, 'Trần Bích Mai', 'Bích Mai', 'wrt6', '$2a$10$VmT9wfxpoOAvz9e/kVJCkOvkON1CvhJULiDy5gTfkixFczsHe9xke', '20 An Duong Vuong', NULL, 'wrt6@gmail.com', 1);

--draft
INSERT INTO `Drafts` VALUES (5, 45, 9, 'Tiêu đề chưa đủ', DATE_SUB(NOW(), INTERVAL 2 DAY));
INSERT INTO `Drafts` VALUES (6, 49, 10, 'Chưa có ảnh hợp lý', DATE_SUB(NOW(), INTERVAL 1 DAY));

--Tags
INSERT INTO `Tags` VALUES (21, 'amthuc');
INSERT INTO `Tags` VALUES (22, 'boiduong');
INSERT INTO `Tags` VALUES (23, 'covid19');
INSERT INTO `Tags` VALUES (24, 'songxanh');
INSERT INTO `Tags` VALUES (25, 'ungthu');
INSERT INTO `Tags` VALUES (26, 'bacsi');
INSERT INTO `Tags` VALUES (27, 'thidau');
INSERT INTO `Tags` VALUES (28, 'bongdanuocngoai');
INSERT INTO `Tags` VALUES (29, 'covua');
INSERT INTO `Tags` VALUES (30, 'vleague');
INSERT INTO `Tags` VALUES (31, 'bongdavietnam');

--PostTags
INSERT INTO `PostTag` VALUES (41, 25);
INSERT INTO `PostTag` VALUES (42, 24);
INSERT INTO `PostTag` VALUES (43, 24);
INSERT INTO `PostTag` VALUES (44, 26);
INSERT INTO `PostTag` VALUES (45, 26);
INSERT INTO `PostTag` VALUES (46, 21);
INSERT INTO `PostTag` VALUES (46, 22);
INSERT INTO `PostTag` VALUES (47, 21);
INSERT INTO `PostTag` VALUES (48, 22);
INSERT INTO `PostTag` VALUES (49, 21);
INSERT INTO `PostTag` VALUES (49, 22);
INSERT INTO `PostTag` VALUES (50, 22);
INSERT INTO `PostTag` VALUES (50, 23);
INSERT INTO `PostTag` VALUES (51, 27);
INSERT INTO `PostTag` VALUES (51, 28);
INSERT INTO `PostTag` VALUES (52, 28);
INSERT INTO `PostTag` VALUES (53, 30);
INSERT INTO `PostTag` VALUES (53, 31);
INSERT INTO `PostTag` VALUES (54, 30);
INSERT INTO `PostTag` VALUES (54, 31);
INSERT INTO `PostTag` VALUES (55, 30);
INSERT INTO `PostTag` VALUES (55, 31);
INSERT INTO `PostTag` VALUES (56, 27);
INSERT INTO `PostTag` VALUES (56, 29);
INSERT INTO `PostTag` VALUES (57, 27);
INSERT INTO `PostTag` VALUES (57, 29);
INSERT INTO `PostTag` VALUES (58, 27);
INSERT INTO `PostTag` VALUES (59, 27);
INSERT INTO `PostTag` VALUES (60, 27);

-- tin tuc suc khoe
INSERT INTO `Posts` VALUES(
  41,
  'Ung thư là thông điệp thử thách thái độ sống của tôi',
  5, 
  null, 
  15, 
  0, 
  '<article><p> Lúc nhận được kết quả trong tay, tôi không dám tin đó là sự thật. Tôi chỉ biết ôm mẹ mà khóc trong bất hạnh: "Con chỉ mới đậu Đại học mà mẹ". Kể từ đó, tôi luôn ở trong tình trạng mệt mỏi, thân thể hao mòn theo chiều dài bệnh tật và đôi chân tong teo không thể đi lại được.</p><p> Tôi cũng đã trải qua tất cả các liệu pháp truyền thống nhằm chữa căn bệnh nan y này. 24 lần hóa trị, 35 tia xạ trị và ba lần đục xương. Bạn sẽ không thể hiểu được cảm giác được chết sung sướng với tôi biết nhường nào.</p><p> Tôi quá chán ghét cuộc sống mỗi ngày đều phải "dùi đục, thuốc giật, phóng xạ bắn". Nhưng qua mỗi ngày trị bệnh, tôi như trưởng thành hơn và đã phát hiện được một bí mật. Nhờ bí mật này, cơ thể tôi dần khôi phục như lúc ban đầu. Vì vậy nếu bạn đang phải chịu thử thách từ căn bệnh ung thư này, tôi muốn viết đôi dòng chia sẻ.</p><p> Bí mật đó chính là: Căn bệnh ung thư bước vào đời tôi như một thông điệp thử thách thái độ sống của tôi trước nghịch cảnh. Và nếu bạn không xem bạn là nạn nhân của căn bệnh ung thư thì sự thật là nghịch cảnh chẳng xảy ra với bạn. Khi gặp một người mắc bệnh ung thư, tôi sẽ không nói gì cả. Vì tôi đã trải qua hai năm với căn bệnh này nên tôi rất hiểu cảm xúc của bệnh nhân. Tôi muốn tạo ra một quả cầu năng lượng tích cực và an toàn để bệnh nhân cảm thấy tin tưởng rằng "ung thư không phải là bản án tử".</p><p> Tôi về nhà, cho đi mọi thứ mình có và sẵn sàng ra đi khi bác sĩ thông báo bệnh tình tôi chuyển biến xấu, đã vô phương cứu chữa. Nhưng lạ thay, tôi cảm thấy một sự bình yên vì không phải lo lắng về bệnh tật nữa, tôi học cách yêu bản thân mình và chấp nhận căn bệnh ung thư. Tôi đã tập thiền định và làm những gì khiến tôi cảm thấy vui vẻ.</p><p> Mỗi buổi sáng sớm, tôi đều đi ra ngoài và dang tay ra đón chào ngày mới. Tôi tự cười với bản thân mỗi ngày như một người điên. Tôi bắt đầu tập trung vào những cái cây, đung đưa trong gió và có cảm giác như tôi đang đung đưa theo chúng. Tôi cảm thấy rất nhiều tình yêu tràn ngập cơ thể tôi. Tôi đang ở trong một trạng thái hạnh phúc hơn bất cứ điều gì tôi từng cảm thấy trước đây.</p><p> Tôi vô cùng biết ơn vì tất cả những lời chúc phúc mà tôi đã được ban tặng và rất biết ơn khi có thể chia sẻ với mọi người. Dần dần, tôi bắt đầu nhận thấy mình có thể đi lại bình thường. Khi tôi trả lời thành thật với bác sĩ rằng hạnh phúc đã giúp tôi. Câu trả lời duy nhất của họ là ung thư sẽ quay trở lại. Đã hai năm, tôi vẫn tràn đầy tình yêu và chấp nhận cuộc sống như nó đang diễn ra.</p><p> Tôi khỏe mạnh, luôn biết ơn và tha thứ cho bản thân vì những sai sót nhỏ. Tôi nhận thấy khi bạn đang nói về bệnh ung thư, bạn gọi nó là "bbệnh ung thư của tôi". Bạn có thể ngừng làm điều đó vì bằng cách nào đó nó bám vào tâm trí bạn và làm gián đoạn mọi quá trình chữa bệnh. Người ta bảo rằng: "Cứ mỗi hai giây thì trên thế giới có một người chết. Nếu như sáng nay, bạn thức dậy khỏe mạnh thì bạn đã hạnh phúc hơn năm trăm triệu người trên thế giới vì họ sẽ không thể sống sót qua tuần sau. Và nếu như bạn không có trải qua nỗi đau khổ của chiến tranh, của tù đày hay vì đói khát thì bạn đã hạnh phúc hơn một tỷ người trên thế giới này". Vậy nên hãy trân trọng mỗi khoảnh khắc được sống, bạn nhé!</p> </article>',
  'Vào một ngày bão giông của tháng tám cách đây hai năm, tôi được chẩn đoán có một khối bướu ác mô bào sợi Sarcoma xương.',
  DATE_SUB(NOW(), INTERVAL 3 DAY),
  null,
  0,
  0);

INSERT INTO `Posts` VALUES (
    42, 
    'Thay đổi lối sống, đẩy lùi bệnh tật.', 
    5, 
    9, 
    15, 
    1, 
    '<p> Bác sĩ Hoàng Thị Bạch Dương nói trong hội thảo ngăn ngừa, kiểm soát và đảo ngược bệnh mạn tính ngày 20/12, đa số bệnh tật đều xuất phát từ thói quen sống, chế độ dinh dưỡng hàng ngày chưa khoa học...</p><p> Bệnh mạn tính đang là nguyên nhân hàng đầu gây tử vong trên thế giới. Ước tính của Tổ chức Y tế thế giới (WHO), tại Việt Nam, năm 2017, cả nước có trên 541.000 trường hợp tử vong do tất cả các nguyên nhân, trong đó tử vong do các bệnh mạn tính chiếm tới 76% (411.600 ca). Ngoài ra, cứ 10 trường hợp tử vong thì có 7 trường hợp tử vong do các bệnh không lây nhiễm, trong đó đứng đầu là các bệnh tim mạch, tiểu đường, ung thư, bệnh phổi tắc nghẽn mạn tính (COPD), theo số liệu công bố tại Hội nghị Khoa học Y tế lần thứ 8 tại Việt Nam, ngày 25/10.</p><p> Nguyên nhân do người Việt có thói quen ăn thức ăn nhanh, nhiều chất béo, ăn mặn, rượu bia, lười vận động nên bệnh tật ngày càng nhiều, tạo gánh nặng cho xã hội. Bên cạnh đó, những căng thẳng trong cuộc sống, bức xúc trong công việc, gia đình cũng ảnh hưởng. Do đó, việc ngăn ngừa, kiểm soát bệnh mạn tính nhờ xây dựng lối sống khoa học là vô cùng quan trọng.</p><p> Nhà khoa học Charles Sine, Tổng Giám đốc của Anti-Fragility Health Clinic cho biết, thách thức nhất hiện nay là không có các phương pháp điều trị cho các bệnh mạn tính trừ khi thay đổi lối sống. "Các loại thuốc truyền thống không có tác dụng đối với các bệnh mạn tính. Bản thân cơ thể chúng ta có khả năng tự chữa lành khi được cung cấp đủ các dinh dưỡng mà cơ thể cần nhờ ngăn ngừa, quản lý và đẩy lùi các mối đe dọa từ bệnh mạn tính", ông nói.</p><p> Để phòng bệnh, nên duy trì đời sống lành mạnh, uống đủ từ 1,5-2 lít nước mỗi ngày để cơ thể luôn khỏe khoắn. Tập thói quen hít thở sâu, cung cấp oxy cho não giúp cơ thể luôn tỉnh táo và thư giãn.</p><p> Nói không với đồ ăn nhanh, thực phẩm chế biến sẵn chứa nhiều dầu mỡ, lượng đường và muối cao, các chất phụ gia không đảm bảo an toàn, chế biến không đảm bảo vệ sinh,.. có nhiều nguy cơ dẫn tới các bệnh về chuyển hóa như xơ vữa động mạch, tiểu đường, gan nhiễm mỡ. Bỏ hút thuốc lá, lạm dụng rượu hoặc chất cấm.</p><p> Duy trì tập luyện thể thao ít nhất 30 phút mỗi ngày như chạy bộ, đi bộ, đạp xe, yoga...</p>',
    'Việt Nam đang đối mặt với gánh nặng bệnh tật không lây nhiễm như tim mạch, tiểu đường..., trong đó lối sống ảnh hưởng 80%.', 
    DATE_SUB(NOW(), INTERVAL 2 DAY), 
    NOW(), 
    5, 
    0);

INSERT INTO `Posts` VALUES (
    43, 
    'Cơ thể đầy bệnh tật và ốm yếu - tại sao là tôi?', 
    5, 
    9, 
    15, 
    1, 
    '<p> "Tại sao là tôi?" Đó cũng là câu hỏi mà không ít lần vang lên trong đầu tôi. Tuy tôi không bị ung thư, nhưng từ khi mới sinh ra tôi đã quằn quại trong đủ loại bệnh và thể chất ốm yếu.</p><p> Tuổi thiến niên của tôi cứ mỗi năm lại phải trải qua vài lần ốm nặng, mấy lần suýt thì không qua khỏi. Đến lúc học cấp 3 tôi khỏe hơn và ít ốm đau hơn. Nhưng khi đi học đại học thì tự nhiên lại giáng xuống tôi căn bệnh đau đầu. Tôi đi khám nhiều nơi nhưng không phát hiện ra bệnh gì.</p><p> Có điều cứ một khoảng thời gian tôi lại bị đau đầu một cách khủng khiếp, có lúc một tuần đến 5 ngày đau đầu. Về sau các cơn đau đầu giãn hơn, có lúc hơn 1 tháng mới bị đau nặng một trận. Nhưng có năm lại có tần suất đau đầu dày đặc. Kèm theo những cơn đau đầu là những trận nôn thốc nôn tháo, tôi không thể làm được việc và bắt buộc phải tìm đến thuốc giảm đau. Cứ mỗi trận đau tôi lại hỏi, tại sao là tôi? Tại sao khi sinh ra cơ thể đã ốm yếu, tại sao tôi đã cố gắng tập luyện thể thao, không rượu bia thuốc là mà bệnh tật vẫn kéo tới?</p><p> Và đến giờ, do dùng thuốc giảm đau quá nhiều, tôi lại bị bệnh lý về dạ dày. Ngay lúc viết những dòng này đây, tôi đang phải chịu cơn đau dạ dày suốt một đêm cho tới sáng. Bị hành hạ với những căn bệnh thường xuyên làm cuộc sống thật sự rất mệt mỏi.</p>',
    'Tuổi thiếu niên tôi vài lần ốm nặng suýt không qua khỏi, trưởng thành bị đau đầu không rõ nguyên nhân.', 
    DATE_SUB(NOW(), INTERVAL 1 DAY ),  
    DATE_SUB(NOW(), INTERVAL 5 HOUR), 
    40, 
    0);

INSERT INTO `Posts` VALUES (
    44, 
    'Bác sĩ Singapore hầu tòa vì gian dối tình trạng sức khỏe', 
    5, 
    9, 
    15, 
    1, 
    '<p> Ngày 17/4, bác sĩ Joel Sursas, 28 tuổi, thừa nhận tội danh <em>Giả mạo giấy tờ </em>trước tòa án cấp cơ sở Singapore.</p><p> Theo hồ sơ vụ việc, trong thời gian công tác tại phòng chẩn đoán X-quang thuộc bệnh viện đa khoa Changi, Joel Sursas đã 47 lần làm "chui" cho một phòng khám tư với mức thu nhập 95 SGD/giờ, tổng thu nhập nhận được là 13.000 SGD. Bốn lần trong đó, bị cáo báo ốm với cơ quan và làm giả giấy khám sức khỏe để hợp thức hóa đơn xin nghỉ.</p><p> Khi tự viết giấy khám sức khỏe, ở phần ký tên Joel Sursas chỉ viết "bác sĩ thay thế" mà không nói rõ họ tên của mình, nhằm cố tình tạo lầm tưởng rằng một bác sĩ thay thế khác của phòng khám tự ký giấy.</p><p> Công tố viên cho biết thủ đoạn của Joel Sursas rất khó bị phát hiện và chỉ bị phanh phui khi bệnh viện đa khoa Changi liên hệ với phòng khám tư. Hành vi của bị cáo vi phạm đạo đức nghề nghiệp của bác sĩ.</p><p> Về lý do thực hiện hành vi, Joel Sursas nói muốn kiếm thêm thu nhập để bay tới Canada gặp bạn gái cũ.</p><p> Trước đó, tháng 10/2018, bác sĩ đã bị Hội đồng Y tế Singapore kỷ luật, tước giấy phép hành nghề trong ba năm, bị phạt tiền 15.000 SGD kèm theo trả chi phí tổ chức hội đồng kỷ luật.</p><p> Hiện, mức tiền bảo lãnh của Joel Sursas là 5.000 SGD. Bị cáo sẽ bị tuyên án vào ngày 7/5. Nếu bị kết tội, Joel Sursas có thể bị phạt tiền và chịu án bốn năm tù.</p>',
    'Vị bác sĩ nhiều lần báo ốm ở bệnh viện công để đi làm chui cho phòng khám tư.', 
    DATE_SUB(NOW(), INTERVAL 2 DAY), 
    NOW(), 
    7, 
    0);

INSERT INTO `Posts` VALUES (
    45, 
    'Môi trường làm việc y tế Việt Nam nhiều nguy hiểm', 
    6, 
    9, 
    15, 
    -1, 
    '<p> Tại Việt Nam, bạo hành trong ngành y tế có tỷ lệ cao, chiếm 25% tổng số bạo hành tại nơi làm việc, ông Nguyễn Trọng Khoa, Phó Cục trưởng Cục Quản lý Khám, chữa bệnh, Bộ Y tế, cho biết tại hội thảo Bảo vệ Blouse trắng, ngày 29/10.</p><p> Số vụ bạo hành nhân viên y tế có chiều hướng gia tăng. Từ đầu năm 2019 đến nay, có khoảng 20 vụ bạo hành bệnh viện, tập trung chủ yếu tại các bệnh viện đa khoa tuyến tỉnh, trong đó có bốn bác sĩ, 15 điều đưỡng và một bảo vệ bị hành hung. Trước đó, từ năm 2010 đến 2017, có 26 vụ việc điển hình về mất an ninh, trật tự bệnh viện trong đó năm 2014 có tới 7 vụ điển hình.</p><p> Đã có hai trường hợp đoàn viên ngành y tế tử vong do bạo hành của người nhà bệnh nhân là bác sĩ Trần Văn Giàu, Bệnh viện đa khoa Vũ Thư - Thái Bình năm 2012, mới đây nhất là một đoàn viên là nhân viên bảo vệ tại Trung tâm Y tế Quế Sơn - Quảng Nam do ngăn cản vụ cãi nhau giữa người bệnh và người nhà.</p><p> Bạo hành chủ yếu ở bệnh viện tuyến tỉnh (60%), 20% ở tuyến trung ương. 70% nạn nhân là bác sĩ, 15% là điều dưỡng. Tới 90% vụ bạo hành xảy ra khi bác sĩ đang cấp cứu, chăm sóc cho bệnh nhân, 60% xảy ra khi thầy thuốc đang giải thích cho bệnh nhân, người nhà.</p><p> Theo ông Khoa, hiện nay, pháp luật Việt Nam cũng chưa mang tính răn đe cao. Nhiều nước chỉ cần có lời nói mang tính gây hấn với nhân viên y tế có thể sẽ bị giam giữ. Trong khi Việt Nam chưa có những quy định chặt chẽ, chưa có chế tài xử phạt nặng nên tình trạng bạo hành như xúc phạm danh dự, bạo hành tinh thần rất phổ biến trong môi trường bệnh viện.</p><p> Tiến sĩ Phạm Thanh Bình, Chủ tịch Công đoàn Y tế Việt Nam cũng cho biết, <strong> môi trường làm việc của cán bộ y tế ở nước ta cũng thuộc diện áp lực nhất vì quá tải, thiếu thốn về cơ sở vật chất và trang thiết bị </strong> ... Họ còn đối mặt với nhiều rủi ro của những tác hại lây nhiễm và không lây nhiễm.</p><p> "Hóa chất, nóng, tiếng ồn, bức xạ ion hóa, sóng siêu âm, các tác động đến da, căng thẳng về tâm lý stress, nguy cơ bị bạo hành cao. Lo ngại hơn, các bức xạ ion hóa gây biến đổi gen, nhiễm sắc thể, can thiệp vào quá trình chuyển hóa, chậm phân chia tế bào, nguyên nhân của các loại ung thư máu, da, xương và tuyến giáp", bà Bình nói.</p><p> Công đoàn Y tế Việt Nam thống kê sơ bộ ở một số tỉnh và đơn vị trực thuộc bộ đã có gần 2.000 cán bộ y tế bị ung thư, mắc bệnh hiểm nghèo.</p><p> Ông Doãn Ngọc Hải, Viện trưởng Viện Sức khỏe nghề nghiệp và môi trường cho biết, cán bộ y tế đối diện với nhiều yếu tố nguy cơ chứa mầm bệnh, stress nghề nghiệp, làm ca, trực đêm, gặp nhiều nguy cơ bị bạo hành khi tiếp xúc với người nhà bệnh nhân và bệnh nhân...</p><p> "Nhóm bệnh nghề nghiệp do yếu tố vi sinh vật dễ mắc bệnh lao nghề nghiệp, viêm gan B, C, nhiễm HIV, bệnh leptospira. Nhóm bệnh nghề nghiệp do yếu tố vật lý dễ mắc phóng xạ, điếc do tiếng ồn và đục thủy tinh thể. Nhóm bệnh liên quan do cả yếu tố hóa học, bụi dễ mắc bệnh viêm phế quản mạn tính, hen nghề nghiệp...", ông Hải cho hay.</p><p> Một nghiên cứu được khảo sát trên diện rộng cho thấy, có tới 27% nhân viên y tế thuộc hệ điều trị và 26% hệ dự phòng mắc bệnh mạn tính; 17% thuộc hệ điều trị dự phòng mắc các bệnh lây nhiễm trong thời gian làm việc; 57% nhân viên y tế thuộc hệ điều trị và hệ dự phòng bị tổn thương do bệnh xâm nhập khi tiêm và có nhiều bệnh lý nghiêm trọng, các bệnh chuyển hóa khác.</p><p> Tại Bệnh viện Hữu nghị Việt Đức, kết quả khám sức khỏe định kỳ tại bệnh viện năm 2018 cho thấy, có 0,15% nhân viên có sức khỏe loại 4 và 2,88% nhân viên sức khỏe loại 3; 41% nhân viên đạt sức khỏe loại 2 trong đó các bệnh thường gặp là nhân xơ tuyến giáp và nang keo tuyến giáp.</p><p> "Nếu có máy đo đếm về tâm lý môi trường của con người thì có lẽ môi trường tâm lý ở bệnh viện là đặc biệt nhất. Tâm trạng, nhịp tim đập mạnh nhất có lẽ ở bệnh viện", Ông Ngọ Duy Hiểu, Phó Chủ tịch Tổng liên đoàn lao động Việt Nam nói.</p><p> Phó giáo sư Phạm Thanh Bình cho biết về chế độ đối với bệnh nghề nghiệp, hiện nay danh mục nghề nặng nhọc, độc hại, nguy hiểm và đặc biệt nặng nhọc, độc hại, nguy hiểm trong lĩnh vực y tế vẫn chưa được sửa đổi, bổ sung sau 23 năm ban hành nên nhiều cán bộ y tế chưa được hưởng chế độ bồi dưỡng từ các danh mục này. Vì vậy, nhiều chuyên gia đã đề xuất chính sách đảm bảo có môi trường lao động an toàn hơn cho cán bộ y tế.</p>',
    'Môi trường làm việc nhân viên y tế áp lực nhất vì quá tải, thiếu cơ sở vật chất, nhiều rủi ro do bệnh tật và nạn bạo hành.', 
    DATE_SUB(NOW(), INTERVAL 3 DAY),
    NULL, 
    0, 
    0);

INSERT INTO `Posts` VALUES (
    46, 
    'Thực phẩm màu đỏ - cam tác dụng bổ phổi', 
    6, 
    10, 
    14, 
    1, 
    '<p> Phổi là một bộ phận quan trọng trong cơ thể giữ vai trò trao đổi khí, giúp cơ thể hấp thụ khí oxy và loại bỏ khí carbonic. Tiến sĩ, bác sĩ Nguyễn Trọng Hưng, Trưởng khoa Khám Tư vấn Dinh dưỡng người lớn, Viện Dinh dưỡng Quốc gia, cho biết phổi là cơ quan rất quan trọng đối với cơ thể con người, chịu trách nhiệm về hô hấp và giúp các tế bào duy trì hoạt động sống, song tiếp xúc trực tiếp với các tác nhân từ môi trường bên ngoài nên thường rất dễ bị nhiễm vi khuẩn, virus... Khi phổi có vấn đề, các triệu chứng ở người bệnh sẽ xuất hiện tùy thuộc vào mức độ như ho khan, ho có đờm, tức ngực, khó thở...</p><p> <strong>Carotene</strong></p><p> Trong dinh dưỡng, nhóm thực phẩm giàu carotene được đánh giá rất tốt cho phổi. Carotene được xác định là chất có khả năng chống lại oxy hóa, giúp ngăn ngừa những nguy cơ gây ung thư phổi. Carotene có trong các loại rau quả có màu cam hoặc đỏ, bao gồm: cà rốt, bí đỏ, gấc, đu đủ, berries (các loại quả họ dâu).</p><p> Cà rốt nhiều beta carotene là chất tiền vitamin A, cùng với đó là vitamin C và các chất chống oxy hóa như lycopene, tác dụng cải thiện sức khỏe phổi và làm giảm nguy cơ mắc bệnh phổi. Cà rốt cũng nhiều vitamin B6 và amino acid methionine, những hợp chất được chứng minh có khả năng phòng chống và làm giảm nguy cơ mắc bệnh ung thư phổi.</p><p> Nước ép từ cà rốt giúp bồi bổ sức khỏe và nâng cao sức đề kháng cho người bệnh ung thư phổi, bổ phổi.</p><p> Bí đỏ hay bí ngô, không chỉ là món ăn dân dã và bổ dưỡng mà còn là vị thuốc phòng trị bệnh. Chứa nhiều vitamin và khoáng chất, bí đỏ cũng giàu beta-caroten, một loại carotenoid mà cơ thể tổng hợp thành vitamin A, cùng các chất dinh dưỡng khác.</p><p> Thành phần trong bí đỏ còn có chất chống oxy hóa như alpha-carotene, beta-carotene và beta- cryptoxanthin, có thể vô hiệu hóa các gốc tự do, ngăn chặn chúng làm hỏng các tế bào. Các nghiên cứu chỉ ra các chất chống oxy hóa bảo vệ da chống lại tác hại của ánh nắng mặt trời, bệnh về mắt, giảm nguy cơ ung thư, trong đó có ung thư phổi.</p><p> Các loại quả họ dâu, berries gồm cà chua, dâu tây, nam việt quất, phúc bồn tử, nho đỏ, lê đỏ... có chỉ số ORAC (khả năng chống oxy hóa) cao, vị ngọt tự nhiên, ít đường và đủ chất dinh dưỡng. Màu sắc sống động của những loại quả này có nghĩa nó chứa đầy đủ chất chống oxy hóa - điển hình là proanthocyanidin có khả năng bảo vệ cơ thể khỏi sự tấn công của các gốc tự do, bổ phổi.</p><p> Củ cải đỏ giàu hàm lượng chất chống oxy hóa, cung cấp kali, chất xơ, folate, vitamin C và nitrat. Chất betanin mang lại màu sắc sặc sỡ cho củ cải, có lợi cho sức khỏe, giúp tăng khả năng miễn dịch nói chung và tốt cho phổi nói riêng.</p><p> Củ cải đỏ chế biến nhanh chóng và dễ dàng như: phơi khô, ngâm củ cải trong nước muối, kết hợp với cam quýt cùng xà lách tươi để làm món salad, hay làm nước ép...</p><p> Đu đủ là trái cây quen thuộc vùng nhiệt đới, giá trị dinh dưỡng cao. Trong đu đủ chứa các vitamin và khoáng chất như: vitamin A, C, B1, B2, magie, canxi, sắt, kẽm... Đặc biệt, nó giàu enzyme tự do, trong đó papain là loại enzyme có vai trò quan trọng trong điều trị nhiễm khuẩn. Papain là một chất chống viêm tự nhiên, ngăn cản sự tiến triển của quá trình nhiễm trùng tại phổi, hỗ trợ giảm nhẹ các triệu chứng như ho có đờm, sốt, đau tức ngực, khó thở do viêm phổi gây ra.</p><p> Ngoài ra, đu đủ xanh còn chứa một lượng chất xơ tương đối lớn, hỗ trợ chức năng tiêu hóa, cải thiện đường ruột người bệnh.</p><p> <strong>Omega-3</strong></p><p> Bên cạnh trái cây màu đỏ - cam, thực phẩm chứa axit béo Omega-3 tác dụng hiệu quả trong bổ phổi, làm giảm các triệu chứng bệnh hen như khó thở, thở khò khè. Thực phẩm giàu axit béo omega-3 là các loại cá biển cá hồi, cá thu, cá ngừ...</p><p> Ngoài ra, có thể ăn các loại dầu thực vật như dầu đậu tương, dầu oliu, hướng dương... Chọn các loại hạt vào thực đơn như lạc, đậu, đỗ, vừng và ăn các loại hạt như hạt dẻ, óc chó.</p><p> <strong>Dưỡng chất khác</strong></p><p> Nhóm các loại gia vị như tỏi, nghệ, gừng tốt cho phổi. Tỏi chứa một chất hoạt tính được gọi là allicin. Chất này chống lại nhiễm khuẩn và giảm viêm cho phổi. Tỏi cũng có thuộc tính chống oxy hóa và giúp loại bỏ các gốc tự do ra khỏi toàn bộ cơ thể vì nhiều selen, dự phòng ung thư phổi. Tỏi cũng tốt cho người bệnh hen và người bị bất cứ bệnh nhiễm trùng phổi nào.</p><p> Gừng là loại gia vị rất dễ kết hợp vào bữa ăn của bạn để thêm hương vị và tăng cường sức khỏe. Chức năng kháng viêm sẽ làm sạch những chất ô nhiễm còn sót lại trong phổi - nguyên nhân dẫn tới các vấn đề sức khỏe.</p><p> Nghệ giúp giảm viêm phổi vì có đặc tính kháng viêm. Nghệ chứa một chất gọi là curcumin giúp loại bỏ những chất sinh ung thư.</p>',
    'Nhóm thực phẩm giàu carotene trong các loại rau quả màu cam - đỏ như cà rồi, bí đỏ, đu đủ, loại quả họ dâu... tốt cho phổi.', 
    DATE_SUB(NOW(), INTERVAL 2 DAY), 
    DATE_SUB(NOW(), INTERVAL 4 HOUR), 
    60, 
    0);

INSERT INTO `Posts` VALUES (
    47, 
    'Từ nông trại sạch đến thực phẩm dinh dưỡng Gerber cho trẻ', 
    6, 
    10, 
    14, 
    1, 
    '<p> Giai đoạn trẻ bắt đầu ăn dặm rất quan trọng bởi ngoài sữa mẹ, con cần hấp thụ thêm chất dinh dưỡng từ các nguồn thực phẩm khác. Hệ tiêu hóa của bé vẫn còn non nớt nên nhiều mẹ cẩn trọng trong khâu lựa chọn, chế biến thực phẩm sao cho ngon, lành. Thấu hiểu tâm tư của mẹ như người bạn đồng hành cùng nuôi dưỡng con khôn lớn, Gerber chú trọng mỗi công đoạn trồng trọt, sản xuất để mang đến bánh ăn dặm Gerber Puffs nhiều dinh dưỡng cho trẻ trong những năm tháng đầu đời.</p><p> Gần một thế kỷ qua, sản phẩm Gerber được hàng triệu bà mẹ trên thế giới lựa chọn nhờ thương hiệu không ngừng theo đuổi chất lượng. Bánh Gerber Puffs mới bổ sung nhiều vi lượng quan trọng như kẽm, vitamin B1... giúp bé ăn ngon hơn, góp phần tăng đề kháng và hỗ trợ sự phát triển của trẻ. Kẽm kích thích vị giác của bé, tạo cảm giác ngon miệng; trong khi vitamin B1 hỗ trợ tăng cường chuyển hóa năng lượng. Sản phẩm không bổ sung đường, hương liệu, phẩm màu và chất bảo quản, phù hợp với trẻ nhỏ.</p><p> Không ít bà mẹ nuôi con theo tiêu chí "ngon, bổ, khỏe" đã chọn bánh ăn dặm Gerber Puffs để làm bữa phụ cho con khi tìm hiểu mô hình nông trại sạch của hãng. Quy trình sản xuất tuân thủ các tiêu chuẩn về chất lượng, sản phẩm trải qua nhiều khâu kiểm định trước khi lên kệ, bao gồm 5 bước quan trọng:</p><p> <em><strong>Lựa chọn hạt giống:</strong> </em> Từng hạt giống được lựa chọn kỹ lưỡng sao cho chắc, mẩy; loại bỏ những hạt lép, sâu bệnh... Điều này nhằm đảm bảo sau những ngày được chăm bón, chúng nảy mầm thành cây non khỏe mạnh, góp phần đảm bảo năng suất gieo trồng từ ban đầu.</p><p> <em><strong>Nguồn đất trồng sạch:</strong> </em> Đất sạch phải là đất không tồn dư chất độc hại theo nhiều phân tích đánh giá, đảm bảo những tiêu chuẩn nghiêm ngặt. Trong quá trình luân canh, người nông dân còn chú ý phục hồi các dinh dưỡng trong đất, giúp đất tơi xốp, giữ và thoát nước tốt... Cây được trồng trên nguồn đất sạch, hút chất dinh dưỡng cần thiết nên có thể xanh tốt và lớn nhanh hơn.</p><p> <em> <strong> Thu hoạch nguyên liệu tinh chọn và đúng thời gian, vụ mùa: </strong> </em> Sau thời gian canh tác, người nông dân lựa chọn thời điểm thu hoạch cho phù hợp để đảm bảo nguồn nguyên liệu tươi ngon. Sản phẩm sử dụng nguyên liệu tự nhiên được lựa chọn kỹ càng; không thêm màu nhân tạo, hương liệu, chất bảo quản vào sản phẩm.</p><p> <em><strong>Giữ trọn dinh dưỡng:</strong> </em> Sau khi thu hoạch từ nông trại, nguyên liệu được bảo quản kỹ lưỡng để giữ độ tươi ngon và đầy đủ dưỡng chất trước khi đưa vào sản xuất. Bởi thế mà sản phẩm khi đến tay người tiêu dùng vẫn có được hương vị tự nhiên với chất lượng đồng đều, nhất quán.</p><p> <em><strong>Không ngừng theo đuổi chất lượng: </strong></em> Với<strong> </strong>mong muốn mang đến những gì tốt nhất cho trẻ trong những năm tháng đầu đời quan trọng, các chuyên gia nông nghiệp của Gerber không ngừng nỗ lực nâng cao chất lượng sản phẩm tốt hơn mỗi ngày. Mỗi một cải tiến mới về sản phẩm đều là kết quả của quá trình nghiên cứu, tìm tòi và kiên định theo đuổi những tiêu chuẩn khắt khe về chất lượng. <br/></p><p> Kể từ khi ra mắt người tiêu dùng Việt Nam vào cuối năm 2018, Gerber được nhiều mẹ Việt đang nuôi con nhỏ lựa chọn nhờ chuỗi các sản phẩm dinh dưỡng chất lượng, phù hợp với từng thời kỳ ăn dặm của bé.</p><p> Đại diện Gerber cho biết, thương hiệu chú trọng sử dụng tối đa nguyên liệu tự nhiên. Tất cả sản phẩm Gerber đều áp dụng các bước kiểm định nghiêm ngặt của Nestlé Thụy Sĩ và quản lý chất lượng tại khu vực lưu hành sản phẩm nên mẹ có thể yên tâm cho trẻ sử dụng.</p><p> Bên cạnh tìm hiểu quá trình sản xuất, để mua bánh ăn dặm chất lượng cho con, phụ huynh nên lưu ý nhà sản xuất, nhà cung cấp có nguồn gốc rõ ràng, uy tín; đạt các kiểm định chất lượng. Nguyên liệu cũng phải tự nhiên, bao bì đóng gói cẩn thận, ghi rõ thành phần dinh dưỡng, hạn sử dụng. Sản phẩm nên dễ tan, dễ cầm nắm giúp bé thoải thưởng thức và mẹ không lo con bị hóc. <br/></p>',
    'Hạt giống chắc, khỏe nảy mầm trên nông trại với nguồn đất trồng sạch, nguyên liệu thu hoạch lúc tươi ngon, giúp bánh ăn dặm Gerber Puffs đảm bảo dinh dưỡng.', 
    DATE_SUB(NOW(), INTERVAL 5 DAY), 
    DATE_SUB(NOW(), INTERVAL 4 DAY), 
    105, 
    0);

INSERT INTO `Posts` VALUES (
    48, 
    'Bổ sung vitamin C thế nào để tăng đề kháng?', 
    6, 
    10, 
    14, 
    1, 
    '<p> Nên bổ sung vitamin C trong những thực phẩm nào và thời điểm nào trong ngày thì tốt?</p><p> <strong>Trả lời:</strong></p><p> Vitamin C còn được gọi là acid ascorbic - một vi chất dinh dưỡng tăng cường miễn dịch tốt nhất và cũng tham gia nhiều chức năng bình thường của cơ thể. Vitamin C hỗ trợ đề kháng, chống nhiễm trùng như cảm cúm, mau lành vết thương. Nó cần thiết cho việc tạo ra collagen, một loại protein kết nối và hỗ trợ cho các mô cơ thể như da, xương, gân, cơ và sụn, tăng cường hấp thu chất sắt, chống bệnh đục thủy tinh thể. Vitamin C cũng được biết là một chất chống oxy hóa, giúp bảo vệ tế bào khỏi tổn thương từ gốc tự do. Tổn thương tế bào của gốc tự do gây ra các bệnh tim mạch, ung thư và bệnh mạn tính khác.</p><p> Thực phẩm giàu vitamin C giúp tăng sức đề kháng, thích hợp sử dụng trong dịch Covid-19 để nâng cao sức khỏe. Khuyến nghị về nhu cầu vitamin C theo ngày như sau:</p><p> Trẻ 6-11 tháng cần 25-30 mg;</p><p> Trẻ 1-6 tuổi 30 mg, trẻ 7-9 tuổi 35 mg;</p><p> Tuổi vị thành niên 10-18 là 65 mg;</p><p> Người trưởng thành 70 mg;</p><p> Phụ nữ có thai là 80 mg;</p><p> Bà mẹ cho con bú là 95 mg.</p><p> Thời điểm tốt nhất để uống vitamin C trong ngày là buổi sáng hoặc buổi trưa, sau khi ăn no. Vì nếu sử dụng vào lúc đói, bạn dễ gặp phải tình trạng cồn ruột, xót dạ dày. Bên cạnh đó, bạn cũng không nên dùng vitamin C vào buổi tối trước khi đi ngủ vì sẽ khó vào giấc.</p><p> Các thực phẩm rau quả chứ nhiều vitamin C như bông cải xanh, trái kiwi, cam, quýt, chanh, ổi, dâu tây và cà chua. Đặc biệt, trái cây họ cam quýt, là nguồn cung cấp vitamin C dồi dào. Chỉ cần ăn đủ hàm lượng 400 g rau xanh và trái cây chín một ngày là đủ lượng vitamin cần thiết.</p><p> Trường hợp nếu cơ thể tiêu hóa và hấp thu kém thì có thể bổ sung thực phẩm chứa vitamin C, các dạng như viên nén uống, viên nén nhai, thuốc dạng lỏng, dạng thuốc tiêm... Tuy nhiên, bổ sung như thế nào, hàm lượng bao nhiêu cần theo chỉ định của bác sĩ.</p><p> Bổ sung vitamin C quá nhiều có thể gây ra hiện tượng ức chế ngược nếu ngừng đột ngột. Một số trường hợp có thể gặp các tác dụng không mong muốn như rối loạn tiêu hóa, loét dạ dày, tá tràng, viêm bàng quang, tiêu chảy, cản trở hấp thụ vitamin A, B12. Đặc biệt, vitamin C thường có đặc tính làm tăng bài tiết axit uric và oxalat, từ đó làm tăng nguy cơ hình thành bệnh sỏi thận. Ở phụ nữ mang thai, dùng vitamin C liều cao trong thời gian dài có thể gây ra những nhu cầu bất thường ở thai nhi, từ đó dẫn đến bệnh scorbut sớm ở trẻ. Dùng đường tiêm với liều cao có thể gây tan máu, đặc biệt ở những người thiếu men G6PD.</p><p> Vitamin C tốt nhưng không nên lạm dụng, đặc biệt trong dịch Covid-19. Nếu bạn chỉ bổ sung vitamin C mà quên bổ sung các chất dinh dưỡng khác, không tập luyện nâng cao sức khỏe, không thực hiện 5K, thì rất nguy hiểm.</p>',
    'Vitamin C tăng sức đề kháng, vậy khuyến nghị về sử dụng vitamin C thế nào thì hợp lý, có phải dùng càng nhiều càng tốt, thưa bác sĩ? (Thùy Linh).', 
    DATE_SUB(NOW(), INTERVAL 2 DAY), 
    DATE_SUB(NOW(), INTERVAL 1 DAY), 
    46, 
    0);

INSERT INTO `Posts` VALUES (
    49, 
    'Người cao tuổi ăn gì để khỏe mạnh trong đại dịch?', 
    5, 
    10, 
    14, 
    -1, 
    '<p> Nhờ bác sĩ tư vấn cho tôi chế độ dinh dưỡng và cần lưu ý gì thêm để đảm bảo sức khỏe cho bố trong đại dịch này. (Nguyễn Minh Quân, 30 tuổi, Tây Hồ, Hà Nội).</p><p> <strong>Trả lời:</strong></p><p> Người cao tuổi là đối tượng nguy cơ cao mắc Covid-19, đặc biệt là người có bệnh lý nền. Để chung sống an toàn với Covid-19, người cao tuổi ngoài việc tuân thủ theo hướng dẫn của Bộ Y tế (thông điệp 5K và tiêm phòng), cần kiểm soát tốt bệnh lý nền, có chế độ dinh dưỡng hợp lý, duy trì tập luyện, giữ tinh thần luôn vui vẻ, lạc quan. Cụ thể:</p><p> Gia đình cần thiết lập một chế độ dinh dưỡng đa dạng thực phẩm trong các bữa ăn hàng ngày bao gồm nhóm ngũ cốc (250- 300 g), nhóm chất đạm (thịt, cá, tôm, đậu, đỗ, lạc... 150-200 g, cân đối đạm động vật và thực vật), nhóm chất béo (nên sử dụng dầu thực vật, các loại hạt nhiều dầu, mỡ cá: 20-25 g), nhóm rau xanh: 200-300 g, quả chín: 200-300 g.</p><p> Không nên ăn nhiều đường, nhiều muối, mỗi ngày chỉ nên ăn dưới 20 g đường, lượng muối dưới 6g/ngày (tương đương dưới 8 g bột canh, 30 ml nước mắm). Ăn các thực phẩm nhiều vitamin nhóm A, C, E giúp tăng cường miễn dịch, có nhiều trong các loại hoa quả và rau xanh (cam, quýt, bưởi, ổi, đu đủ, cà rốt, rau ngót, ớt chuông, rau chân vịt...).</p><p> Tổ chức bữa ăn vui vẻ trong gia đình để cải thiện không khí. Người cao tuổi nên ăn từ từ, chậm rãi giúp tăng cảm giác ngon miệng, đạt nhu cầu dinh dưỡng và dễ tiêu hóa thức ăn.</p><p> Uống đủ nước, nhu cầu 30-35 ml/kg, bao gồm nước lọc, sữa, nước canh... Uống nước sạch, ấm, uống từng ngụm nhỏ và chia đều trong ngày để giữ ẩm cổ họng, không uống nước nhiều trước khi đi ngủ.</p><p> Hạn chế các món ăn chứa đường hấp thu nhanh như nước ngọt, nước có ga, bánh kẹo ngọt và các món ăn chứa nhiều muối như dưa muối, cà muối, mỳ tôm, các món kho mặn, nước dùng bún phở... để phòng ngừa các bệnh không lây nhiễm như đái tháo đường, tăng huyết áp.</p><p> Trường hợp đã mắc các bệnh lý đái tháo đường, tăng huyết áp, suy thận... như bố của bạn, cần liên hệ với chuyên khoa dinh dưỡng để có chế độ dinh dưỡng chi tiết hơn.</p><p> Ngoài ra, người cao tuổi cần duy trì tập luyện hàng ngày. Ưu tiên các hoạt động tiếp xúc ánh nắng mặt trời, tối thiểu 30 phút mỗi ngày giúp tổng hợp vitamin D, tăng sức đề kháng, giảm nguy cơ loãng xương, nguy cơ ngã ở người cao tuổi. Nếu trong giai đoạn dịch hạn chế ra ngoài nên tập các bài tập tại nhà như yoga, dưỡng sinh, thái cực quyền, đứng lên ngồi xuống, tập các bài tập thăng bằng.</p><p> Duy trì tinh thần vui vẻ, lạc quan, tránh stress giúp tăng cường miễn dịch, đảm bảo khỏe mạnh về cả thể chất lẫn tinh thần giúp phòng chống dịch bệnh.</p>',
    'Bố tôi năm nay 65 tuổi, mắc tăng huyết áp, gần đây hay chán ăn, mệt mỏi. Tôi nên bổ sung và chế biến thực phẩm thế nào để giúp bố tăng đề kháng?', 
    DATE_SUB(NOW(), INTERVAL 2 DAY), 
    NULL, 
    0, 
    0);

INSERT INTO `Posts` VALUES (
    50, 
    'Bí kíp giúp F1, F0 cách ly tại nhà ăn ngon miệng', 
    5, 
    10, 
    14, 
    1, 
    '<p> Hướng dẫn của các chuyên gia ở Đại học Y dược TP HCM trong "Sổ tay Sức khỏe Covid-19", người bệnh cần giữ tinh thần thoải mái thưởng thức bữa ăn, không nên quá lo lắng về bệnh, dằn vặt hay trách người đã lây bệnh cho mình, có thể cùng ăn từ xa với người thân qua các ứng dụng Zalo, Facetime.</p><p> Theo đó, nên áp dụng 6 bước trong công thức "Thiền ăn": Đầu tiên, nhìn đĩa thức ăn và cảm nhận hình dạng nó trông giống hình ảnh vui nhộn nào đó. Sau đó nhắm mắt lại và tưởng tượng món ăn trong đầu, nghĩ đến người làm ra món ăn, quy trình chế biến món ăn. Tiếp theo ngửi hương thơm tỏa ra và cảm nhận.</p><p> Bước thứ 4 đưa thức ăn chạm môi, sau đó đưa vào lưỡi và cảm giác vị trí thức ăn chạm vào. Sau đó, bằng ý thức, hãy cắn và cảm nhận vị ngon của thức ăn. Cuối cùng nhai và đếm nhẩm số lần trước khi nuốt. Nuốt từ từ cảm nhận thức ăn đang di chuyển xuống dạ dày và cảm ơn người đã tạo ra món ăn cho bạn.</p><p> Đối với người thay đổi vị giác, khởi đầu từ ăn nhạt rồi tăng dần vị. Dùng thức ăn khi còn ấm vì thức ăn nóng có vị đậm đà hơn. Dùng kẹo chua, kẹo bạc hà hoặc kẹo cao su trước và sau bữa ăn nếu bị khô miệng. Vệ sinh răng miệng sạch sẽ để tạo cảm giác ngon miệng hơn.</p><p> Với người chán ăn, cần chia nhỏ bữa ăn 4-6 lần/ngày, không bỏ bữa. Nếu không ăn cơm được thì thay thế bằng các thực phẩm giàu dinh dưỡng như cháo thịt, sữa giàu năng lượng, ngũ cốc... Người chăm sóc cần khuyến khích, động viên, tạo động lực sống để người bệnh vui vẻ, lạc quan.</p><p> Về chế độ dinh dưỡng, cần ăn uống đa dạng đủ chất. Cung cấp đầy đủ năng lượng, bổ sung đủ 4 nhóm chất, ăn ba bữa chính và ăn thêm các bữa phụ, đa dạng các loại thực phẩm mỗi ngày.</p><p> Uống nhiều nước, có thể bổ sung nước trái cây như cam, chanh, nước ép rau củ quả hoặc sinh tố. Đối với trẻ em và người cao tuổi cần bổ sung nước thường xuyên chứ không đợi cảm giác khát. Ăn các loại trái cây, rau, các loại đậu như đậu lăng, đậu xanh..., các loại hạt và ngũ cốc nguyên hạt.</p><p> Người cao tuổi, trẻ nhỏ, người mắc các bệnh mạn tính, người thiếu cân có thể bổ sung thêm các chế phẩm dinh dưỡng giàu năng lượng và đạm như ngũ cốc, sữa và sản phẩm từ sữa như phô mai, sữa chua,..</p><p> Ngoài ra, cần hạn chế đường, bánh ngọt, nước ngọt, rượu bia, đồ ăn dầu mỡ, chiên xào. Giảm ăn mặn, mỗi ngày dùng ít hơn 5 g muối tương đương khoảng một thìa cà phê. Luôn ăn chín uống sôi để tránh các bệnh gây ra do thực phẩm.</p>',
    'Giữ tâm lý thoải mái khi ăn, kết hợp các giác quan nhìn, ngửi, nếm... giúp cảm nhận hương vị món ăn, nếu chán ăn cần chia nhỏ các bữa.', 
    DATE_SUB(NOW(), INTERVAL 3 DAY), 
    DATE_SUB(NOW(), INTERVAL 3 HOUR), 
    26, 
    0);

--Tin tuc the thao
INSERT INTO `Posts` VALUES (
    51, 
    'Koeman: "Barca đã có một trận tuyệt vời về mọi mặt" ', 
    6, 
    11, 
    17, 
    1, 
    '<p> "Thật tuyệt khi CĐV trở lại sân. Họ cổ vũ chúng tôi ngay từ đầu. Có CĐV, chúng tôi như bước sang một thế giới khác. Có vẻ đã có hơn 20.000 người trên các khán đài. Họ hỗ trợ khi chúng tôi cần sự mạnh mẽ trên sân nhà. Đây là một trận đấu tuyệt vời về mọi mặt, như CĐV, lối chơi rồi chiến thắng",</p> <p> Koeman nói sau trận đấu ở Cmap Nou.</p><div><p> Trong trận chính thức đầu tiên sau khi Messi ra đi, Barca mở tỷ số từ phút 19 nhờ cú đánh đầu của trung vệ Gerard Pique. Ở phút bù giờ hiệp một và phút 59, tiền đạo Martin Braithwaite hoàn tất cú đúp để nâng cách biệt lên 3-0.</p><p> Sociedad gỡ hai bàn nhờ cú sút chéo góc của Julen Lobete phút 82 và cú sút phạt trực tiếp của Mikel Oyarzabal phút 85, nhưng không thể ngăn Barca ghi thêm bàn. Ở phút bù giờ thứ nhất của hiệp hai, Braithwaite căng ngang cho Sergi Roberto đệm bóng ấn định chiến thắng 4-2. Koeman dành lời khen cho tiền đạo người Đan Mạch: "Tôi nghĩ Braithwaite là một tấm gương về sự chuyên nghiệp. Cậu ấy đã cải thiện lối chơi của bản thân, và luôn nỗ lực vì đội bóng. Braithwaite nhanh nhẹn và khó bị ngăn cản. Tôi rất vui khi có những cầu thủ như thế".</p><p> Trận này HLV Koeman bố trí hai tân binh Memphis Depay và Eric Garcia chơi ngay từ đầu. Họ đã đáp lại sự tin tưởng. Memphis trực tiếp kiến tạo bàn đầu và phát động tấn công dẫn đến bàn thứ hai. Garcia thì đảm bảo sự an toàn cho hàng thủ, cho đến khi Sociedad bất ngờ vùng lên khoảng 10 phút cuối. Trung vệ đá cặp với Garcia, Pique cũng có một trận đấu nổi bật. Sau khi chấp nhận giảm lương đến mức "gần như miễn phí" cho đội bóng, lão tướng người Tây Ban Nha giúp Barca khởi đầu mùa giải suôn sẻ bằng cú đánh đầu mở tỷ số. "Mùa trước, Pique cũng là một thủ lĩnh của Barca. Mùa này, cậu ấy có thể lực tốt hơn. Thái độ của cậu ấy rất mẫu mực giống như những cầu thủ thi đấu lâu năm khác", Koeman nói.</p></div>',
    'HLV Ronald Koeman hài lòng với cách Barca khởi đầu kỷ nguyên hậu Lionel Messi bằng trận thắng Sociedad 4-2 ở trận ra quân La Liga.', 
    DATE_SUB(NOW(), INTERVAL 2 DAY), 
    DATE_SUB(NOW(), INTERVAL 10 HOUR), 
    74, 
    0);

INSERT INTO `Posts` VALUES (
    52, 
    'Man City dùng đội hình xuất phát đắt giá nhất lịch sử', 
    6, 
    11, 
    17, 
    1, 
    '<p>HLV Pep Guardiola dùng thủ môn Ederson, hậu vệ Joao Cancelo, Ruben Dias, Nathan Ake, Benjamin Mendy, tiền vệ Fernandinho, Ilkay Gundogan, Jack Grealish, tiền đạo Riyad Mahrez, Ferran Torres và Raheem Sterling đá chính. Phí chuyển nhượng của 11 cầu thủ này sang Man City lên tới 550 triệu bảng (khoảng 760 triệu USD). Trung bình, mỗi cầu thủ có giá 50 triệu bảng.</p><div><p> Hai cầu thủ rẻ nhất đội hình này là Gundogan và Torres, cùng với giá 20 triệu bảng. Ederson và Fernandinho được mua về từ Benfica và Shakhtar Donetsk với giá 36 triệu bảng. Bộ tứ vệ của Man City đáng giá hơn 210 triệu bảng, nhưng vẫn không ngăn được pha độc diễn ghi bàn thắng 1-0 của Son Heung-min ở phút 55. Tiền đạo Hàn Quốc từ Bayer Leverkusen sang Tottenham hè 2015 với phí chuyển nhượng 22 triệu bảng.</p><p> Tân binh Grealish đá chính cho Man City, trong hàng tiền vệ ba người có giá 156 triệu bảng. Còn bộ ba tấn công của Man City cũng đáng giá 139 triệu bảng.</p><p> Ba cầu thủ dự bị vào sân gồm Kevin de Bruyne, Gabriel Jesus và Oleksandr Zinchenko có giá 97 triệu bảng. Man City vẫn còn những cầu thủ đắt giá như John Stones, Kyle Walker, Aymeric Laporte, Rodri hay Bernardo Silva. Họ ngồi dự bị nhưng không có cơ hội vào sân.</p><p> 18 cầu thủ Man City đăng ký chơi trận ra quân Ngoại hạng Anh có giá tổng cộng gần 900 triệu bảng (khoảng 1,25 tỷ USD). Đội khách dứt điểm 18 lần, nhưng không ghi bàn nào và trắng tay rời sân Tottenham Hotspur.</p><p> Trước trận, Guardiola cũng cho rằng các thương vụ chuyển nhượng đình đám không làm Man City vi phạm luật Công bằng Tài chính. Ông nói: "Có những ông chủ muốn kiếm lời, còn có những ông chủ không muốn kiếm lời. Vì thế họ không muốn đầu tư, còn ông chủ của chúng tôi muốn đầu tư. Nhưng, chúng tôi vẫn nằm trong giới hạn của luật Công bằng Tài chính. Nếu chúng tôi sai, chứng minh đi".</p></div>',
    '11 cầu thủ đá chính cho Man City ở trận thua Tottenham hôm 15/8 có giá 550 triệu bảng, kỷ lục của Ngoại hạng Anh.', 
    DATE_SUB(NOW(), INTERVAL 4 DAY), 
    DATE_SUB(NOW(), INTERVAL 3 DAY), 
    50, 
    0);

INSERT INTO `Posts` VALUES (
    53, 
    'Bầu Đức bác ý tưởng HAGL tranh vô địch với Viettel', 
    6, 
    11, 
    17, 
    1, 
    '<p> <em> - Công ty Cổ phần Bóng đá chuyên nghiệp Việt Nam VPF dự định lùi V-League sang tháng 2/2002 do ảnh hưởng của Covid-19. Quan điểm của ông về vấn đề này? </em></p><p> - Ban đầu, tôi cũng như lãnh đạo CLB chỉ biết thông tin qua truyền thông, chứ không được tham khảo ý kiến, dù là một trong 14 CLB V-League. Vì vậy, tôi cảm thấy VPF đã thiếu tôn trọng các CLB. Việc nêu đề xuất trong giai đoạn dịch bệnh bùng phát thế này cũng thiếu hợp lý. Vì thế, tôi không bàn đến VPF, kể cả khi họ đã ra thông cáo hôm qua rằng các CLB có quyền nêu ý kiến đến hết ngày 23/7. VPF chỉ là đơn vị thực thi nhiệm vụ tổ chức, chỉ VFF mới có quyền quyết định huỷ hoặc lùi giải đấu.</p><p> Quan điểm của tôi là ủng hộ các quyết định của VFF, nhưng tất nhiên họ phải tính toán cho thấu tình đạt lý. Muốn như thế, VFF phải họp với 14 CLB. Tất cả cùng ngồi lại với nhau, lắng nghe ý kiến của đại diện các CLB rồi tổng hợp để xây dựng phương án khả thi nhất. Cuộc chơi này là của 14 đội bóng chứ đâu phải của riêng ai đâu mà muốn lùi thì lùi, muốn hoãn thì hoãn.</p><p> <em> - Thực tế, bên cạnh đại dịch, VPF còn muốn ưu tiên thời gian cho ĐTQG và đội U23. Ông nghĩa sao về lý do này? </em></p><p> - Cần nhớ rằng, xây dựng ĐTQG là phải dựa trên nền tảng của CLB. Nếu không, lấy đâu ra con người cho đội tuyển. Do đó, chúng ta phải đưa giải pháp thực hiện phù hợp với tình hình thực tiễn, không thể tuỳ tiện mà ảnh hưởng đến cái gốc rễ của nền bóng đá.</p><p> Các CLB trực tiếp bỏ tiền đào tạo, nuôi dưỡng cầu thủ. Lùi giải nửa năm sẽ gây thiệt hại lớn chứ không đùa đâu. Vì không thi đấu thì không có khán giả, không thể bán vé, không kiếm được tài trợ..., trong khi vẫn phải nuôi cầu thủ, trả lương cho nhân viên... Nhiều CLB sẽ chịu không nổi đâu.</p><p> <em> - Chủ tịch CLB Hải Phòng Văn Trần Hoàn đưa giải pháp dừng V-League và tổ chức trận tranh chức vô địch giữa HAGL và Viettel. Ông thấy ý tưởng này thế nào? </em></p><p> - HAGL không quan tâm đến quyền lợi riêng. Câu chuyện mà chúng tôi muốn nói ở đây là lợi ích chung cho cả nền bóng đá. Vì thế, tôi không bàn đến ý tưởng của Chủ tịch Hải Phòng.</p><p> <em>- Nếu V-League lùi sang năm 2022, HAGL sẽ bị ảnh hưởng thế nào?</em></p><p> - Tất nhiên có nhiều ảnh hưởng rồi. Hiện tại, chúng tôi có cả trăm cầu thủ ở các lứa tuổi khác nhau. Nhưng giải diễn ra hay không thì vẫn phải nuôi và trả lương đầy đủ cho họ. Tôi đã đầu tư bóng đá 15 năm nay, chẳng lẽ mấy tháng nghỉ lại không chịu được? HAGL xác định từ đầu rằng cầu thủ như người nhà nên có mệnh hệ gì chúng tôi cũng phải có trách nhiệm với họ.</p>',
    'Ông chủ của HAGL muốn Liên đoàn Bóng đá Việt Nam họp với 14 đội bóng để tìm ra quyết định liên quan đến số phận của V-League mùa này.', 
    DATE_SUB(NOW(), INTERVAL 2 DAY), 
    NOW(), 
    43, 
    0);

INSERT INTO `Posts` VALUES (
    54, 
    'Tạm dừng V-League 2021', 
    5, 
    11, 
    17, 
    1, 
    '<p> Sáng 6/5, một thanh niên ở Vinh đến khai báo y tế là F1, do cùng chuyến bay với một bệnh nhân mắc nCoV từ Đà Nẵng về Vinh. Vì từng tiếp xúc với F1 kể trên, một số cầu thủ SLNA trở thành F2.</p><p> Công ty Cổ phần bóng đá chuyên nghiệp Việt Nam (VPF), vì vậy, phải hoãn trận đấu giữa Hà Nội và SLNA, dự kiến diễn ra lúc 17h ngày 7/5. Trận đấu thuộc vòng 13 - vòng cuối cùng giai đoạn I có ý nghĩa quyết định nhóm đội đua vô địch và nhóm đua trụ hạng. Theo quy định, tất cả các trận đấu đều diễn ra cùng giờ để đảm bảo tính công bằng. Do đó, hoãn trận SLNA - Hà Nội đồng nghĩa với việc tạm dừng sáu trận đấu còn lại.</p><p> Ban tổ chức chưa thể quyết định lịch đá bù, do sắp tới V-League phải nhường chỗ cho đội tuyển quốc gia tập trung, chuẩn bị cho vòng loại World Cup 2022 - khu vực châu Á.</p><p> Sau 12 vòng, HAGL đang đứng đầu với 29 điểm, nhiều nhì bảng Viettel ba điểm. Đây cũng là hai đội chắc suất được đá giai đoạn II đua vô địch. Vị trí từ thứ ba đến thứ sáu chưa ngã ngũ. SLNA đang đứng cuối bảng, với 10 điểm và nguy cơ cao xuống hạng.</p><p> F2 là diện tiếp xúc gần trong vòng hai mét với F1, tính từ ngày đầu tiên F1 tiếp xúc với người nhiễm đến khi F1 cách ly y tế. Theo Trung tâm Kiểm soát Bệnh tật TP HCM, khả năng nhiễm nCoV của F2 phụ thuộc rất lớn vào kết quả xét nghiệm của F1. Nếu F1 âm tính, F2 sẽ được giải tỏa vì thời điểm F2 tiếp xúc gần với F1, F1 không có khả năng lây bệnh. Nếu F1 dương tính, F2 sẽ trở thành F1, khi ấy phải tiến hành các biện pháp phòng bệnh dành cho F1. Trong lúc chờ kết quả xét nghiệm của F1, để hạn chế khả năng lây nhiễm cộng đồng, F2 cần thực hiện đúng quy định cách ly tại nhà.</p>',
    'Tất cả trận đấu vòng 13, dự kiến diễn ra chiều thứ Sáu 7/5, bị hoãn do nhiều cầu thủ SLNA thuộc diện F2 của người nghi nhiễm Covid-19.', 
    DATE_SUB(NOW(), INTERVAL 1 DAY), 
    DATE_SUB(NOW(), INTERVAL 6 HOUR),  
    47, 
    0);

INSERT INTO `Posts` VALUES (
    55, 
    'Chuyện thay tướng chờ đổi vận ở V-League', 
    6, 
    null, 
    17, 
    0, 
    '<p> Sài Gòn là đội đầu tiên thay ngựa giữa dòng tại V-League mùa này. Họ sa thải HLV người Nhật Bản Shimoda Masahiro, đưa HLV phó Phùng Thanh Phương sau vòng 6. Kế đến, Hà Nội đổi ghế HLV những hai lần, khi "công thần" Chu Đình Nghiêm rút lui, để HLV Hoàng Văn Phúc tạm quyền hai trận cho đến khi HLV người Hàn Quốc Park Choong-kyun nhậm chức chính thức.</p><p> Sau vòng 9, lần lượt Bình Dương rồi Hà Tĩnh cũng thay tướng, với việc các HLV Phan Thanh Hùng, Phạm Minh Đức xin nghỉ, nhường chỗ cho các ông Nguyễn Thanh Sơn, Nguyễn Thành Công. Tới hết vòng 11, SLNA chia tay HLV Ngô Quang Trường, đôn HLV phó Nguyễn Huy Hoàng lên. Và Đà Nẵng là đội mới nhất theo xu thế này khi HLV Lê Huỳnh Đức xin nghỉ sau trận thua ngược Viettel 1-2 trên sân nhà Hòa Xuân, và HLV Phan Thanh Hùng được mời về thay thế.</p><p> Với việc được tự do sau khi rời Đà Nẵng, không loại trừ khả năng ông Lê Huỳnh Đức sẽ nhận lời giải cứu một đội bóng khó khăn khác - có thể là CLB TP HCM hoặc Sài Gòn FC. <strong>Cái vòng luẩn quẩn ấy có thể đơn giản chỉ là sự trùng hợp.</strong> Những đội bóng nói trên đều thi đấu sa sút mùa này, và họ buộc phải nghĩ đến chuyện "thay tướng để đổi vận". Sau vòng 12, chưa đội nào chắc suất trong top 6. Thậm chí, nếu ở vòng đấu cuối cùng của giai đoạn I, Quảng Ninh thua HAGL, Đà Nẵng và Hà Nội không thắng Nam Định và SLNA trên sân khách, và cùng lúc Thanh Hóa, Bình Dương rồi Bình Định kiếm trọn ba điểm thì có thể toàn bộ các đội bóng kể trên sẽ phải gia nhập nhóm 8 đội tranh trụ hạng. Trong nhóm này, Sài Gòn, Hà Nội, Hà Tĩnh và Quảng Ninh đều từng bị nghi ngờ là nằm trong liên minh mà bầu Đức cách đây hai mùa đã nhắc đến là "năm ông gầy" (khi đó còn Quảng Nam, nhưng đã xuống hạng Nhất). Xem ra, rrong một mùa giải có thể thức khắc nghiệt như hiện nay, việc tự cứu mình còn khó chứ chưa nói gì đến việc tương trợ lẫn nhau.</p><p> Quảng Ninh đang đứng thứ ba với 19 điểm, nhưng nếu thua đầu bảng HAGL ở vòng 13, có nguy cơ sẽ bị các đội đứng sau qua mặt. Trong khi đó, Đà Nẵng chỉ có 16 điểm nhưng sẽ chơi trận cầu sáu điểm với Nam Định. Nếu thắng tại sân Thiên Trường, họ không những tự điền tên mình vào top 6, mà còn có thể gián tiếp giúp Quảng Ninh hay Hà Nội vượt qua Nam Định - đội đang có 18 điểm.</p><p> Việc thay HLV là hợp lý với Đà Nẵng lúc này. HLV Lê Huỳnh Đức đã liên tục dùng từ "xui xẻo" để nói về thành tích vừa qua của đội nhà. Kể từ sau trận thắng Hà Nội 2-0, Đà Nẵng đá năm trận mà chỉ kiếm được đúng một điểm (hòa Hải Phòng 0-0 trên sân khách) cho dù họ có đến ba trận sân nhà. Nói cách khác, lẽ ra Đà Nẵng đã vào top 6 từ lâu, nhưng đến giờ, họ chỉ còn một con đường duy nhất, đó là phải lấy trọn ba điểm tại Thiên Trường. Thế nên, HLV Lê Huỳnh Đức có vẻ nhẹ nhàng khi nói về cuộc chia tay lần thứ hai với đội bóng sông Hàn. Ông thậm chí nghĩ rằng sự ra đi của bản thân sẽ giúp ích cho đội bóng mà ông đã gắn bó gần 20 năm, kể từ ngày lặng lẽ rời TP HCM ra Đà Nẵng để chơi ít mùa cuối sự nghiệp.</p><p> <strong> Việc ông Đức nhường ghế cho ông Phan Thanh Hùng, một lần nữa nhắc đến tính chu kỳ 10 năm của bóng đá Việt Nam </strong> . Chức vô địch đầu tiên của đội Quảng Nam - Đà Nẵng là năm 1992, chính ông Phan Thanh Hùng là thành viên của thế hệ vàng bóng đá Quảng - Đà ngày đó. Sau khi tách tỉnh, đội Đà Nẵng xuống hạng, đến năm 2002 mới trở lại với V-League. Năm 2012, họ có chức vô địch V-League lần gần nhất, khi đó trong tay HLV Lê Huỳnh Đức có dàn cầu thủ trẻ trung nổi lên từ hai chức vô địch các giải U21 quốc gia các năm 2008, 2009 cho chính HLV Phan Thanh Hùng là người dìu dắt. Ông Hùng ra Bắc từ năm 2010 để xây dựng "đế chế Hà Nội T&amp;T" cho bầu Hiển, để lại một Đà Nẵng dồi dào nguồn lực trẻ cho Lê Huỳnh Đức. Có thể nói, chức vô địch năm 2012 là đỉnh cao của chu kỳ thành công với bóng đá Đà Nẵng.</p><p> Nhưng 10 năm qua, bóng đá trẻ Đà Nẵng không thành công. Ở giải U21 Quốc gia, họ chỉ một lần vào bán kết. Ở giải U19 Quốc gia, họ cũng chỉ một lần vào chung kết năm 2012. Một làng cầu từng có tiếng tăm về đào tạo trẻ, khi không còn giữ được thế mạnh của mình, thì sa sút là dễ hiểu. Nếu muốn tìm lại thời hoàng kim, họ nên bắt đầu ngay từ lúc này, khi đội một vẫn còn thi đấu tại V-League. Kể cả khi HLV Phan Thanh Hùng không thể giúp Đà Nẵng vào top 6, họ vẫn cần một làn gió mới từ băng ghế chỉ đạo để tạo động lực cho cuộc đua trụ hạng tại giai đoạn II vốn rất căng thẳng. Bởi, cần phải nhìn nhận, chất lượng con người và khát vọng thi đấu của đội bóng bên sông Hàn đang ở mức rất thấp. Nếu không tái thiết, xuống hạng là viễn cảnh khó tránh.</p><p> <strong> Chỉ có điều, sau bao nhiêu năm qua, rốt cục, bóng đá Đà Nẵng vẫn phải nhờ đến một người cũ </strong> . Chỉ tính từ đầu năm 2021, ông Phan Thanh Hùng đã làm việc ở ba CLB khác nhau - Quảng Ninh ngay trước thềm V-League, Bình Dương rồi bây giờ là Đà Nẵng, dù đã 60 tuổi. Điều đó cũng cho thấy bóng đá Việt Nam đang thiếu hụt nghiêm trọng các HLV có năng lực xây dựng đội bóng một cách dài hạn. Trước đây, người ta từng thấy một trường hợp gần tương tự, là ông Lê Thụy Hải, người mà cứ đội nào cần danh hiệu trong ngắn hạn thì lại trải thảm đỏ mời về. Nay, đến lượt ông Hùng, người lẽ ra nên được sử dụng ở vai trò Giám đốc Kỹ thuật hơn là vẫn cầm sa bàn chỉ đạo.</p>',
    'Lê Huỳnh Đức là HLV thứ sáu thôi việc ở V-League 2021, và điều trùng hợp là phần lớn thay đổi này đều liên quan đến những đội bóng từng có quan hệ với nhau.', 
    DATE_SUB(NOW(), INTERVAL 2 DAY), 
    NULL, 
    0, 
    0);

INSERT INTO `Posts` VALUES (
    56, 
    'Quang Liêm nước rút thần tốc ở siêu giải St Louis', 
    6, 
    12, 
    18, 
    1, 
    '<p> Quang Liêm thắng Jeffery Xiong, Sam Shankland, Peter Svidler, Richard Rapport, hoà Wesley So, Shakhriyar Mamedyarov, Hikaru Nakamura và thua Leinier Dominguez, Fabiano Caruana ở chín ván cờ chớp cuối, sáng 16/8, giờ Hà Nội.</p><p> Với 5,5 điểm kiếm được trong ngày cuối, Quang Liêm cán đích với 17,5 điểm và đứng thứ năm, sau Nakamura 24 điểm, Caruana 21, Rapport 19,5 và So 18,5. Các vị trí sau thuộc về Mamedyarov, Dominguez 17 điểm, Svidler 16, Xiong 15 và Shankland 14,5.</p><p> Kỳ thủ Việt Nam nhận 12.500 USD tiền thưởng, bằng một nửa của Caruana. Trong tháng 8/2021, tiền thưởng của Quang Liêm tăng lên 27.500 USD, với 15.000 USD trước đó nhận từ vị trí á quân siêu giải online Chessable Masters.</p><p> Nakamura đứng đầu siêu giải St Louis với 37.500 USD tiền thưởng, còn Rapport và So lần lượt nhận 20.000 USD và 15.000 USD. Các vị trí thứ sáu đến cuối nhận từ 9.500 USD đến 6.000 USD.</p><p> Quang Liêm cũng là kỳ thủ chơi tốt thứ hai ở nội dung cờ chớp, diễn ra hai ngày 15/8 và 16/8, với 11,5 trên 18 điểm tối đa. Anh chỉ đứng sau Nakamura - kỳ thủ kiếm 12 điểm.</p><p> Quang Liêm nhận thêm 84 Elo cờ chớp, để đạt 2.774 Elo, đứng thứ 14 thế giới. Nakamura mất 16 Elo, xuống còn 2.884 Elo và rơi xuống vị trí số hai thế giới, để lại vị trí đầu cho Vua cờ Magnus Carlsen. Sau nhiều năm, Carlsen đã lại đứng đầu thế giới ở cả ba nội dung cờ tiêu chuẩn, nhanh và chớp.</p><p> Quang Liêm kết thúc nội dung cờ nhanh với 6 trên 18 điểm tối đa và đứng cuối cùng. Nhưng, cú nước rút thần tốc ở cờ chớp giúp anh vươn lên nửa trên. Nhưng, đây chưa phải thành tích tốt nhất của Quang Liêm ở một giải thuộc hệ thống Grand Chess Tour. Tại siêu giải Superbet 2019 ở Romania, Quang Liêm về thứ tư với 19 điểm.</p><p> St Louis là giải cờ nhanh chớp cuối của Grand Tour 2021. Chặng cuối cùng mang tên Sinquefield Cup đánh cờ tiêu chuẩn cũng ở St Louis, thi đấu từ sáng 18/8, giờ Hà Nội. Cơ hội để Quang Liêm được mời dự Sinquefield Cup còn bỏ ngỏ.</p>',
    'Kỳ thủ số một Việt Nam Lê Quang Liêm kiếm 5,5 điểm trong chín ván cờ chớp cuối, về thứ năm chung cuộc ở siêu giải St Louis.', 
    DATE_SUB(NOW(), INTERVAL 2 DAY), 
    NOW(), 
    8, 
    0);

INSERT INTO `Posts` VALUES (
    57, 
    'Quang Liêm tiết lộ bí quyết chơi cờ chớp', 
    6, 
    12, 
    18, 
    1, 
    '<p> Sau khi kết thúc ngày đầu cờ chớp siêu giải St Louis với thành tích tốt bậc nhất, ngang với Hikaru Nakamura, Quang Liêm được ban tổ chức giữ lại phỏng vấn. Đại kiện tướng Maurice Ashley hỏi: "Đâu là điểm khác biệt giữa cờ nhanh và cờ chớp, khiến anh tạo kết quả khác biệt như vậy?". Quang Liêm trả lời: "Điều cốt yếu ở cờ chớp là chơi thật nhanh và tránh sai lầm nghiêm trọng. Kỳ thủ không cần chơi quá cẩn thận, mà chỉ còn đi những nước ổn, tránh sai sót và cố gắng đi nhanh hơn đối thủ. Để chơi cờ nhanh và cờ tiêu chuẩn giỏi, chúng ta cần luyện tập nhiều hơn hẳn so với cờ chớp. Vì tôi nghĩ chơi cờ chớp cần nhiều năng lực tự nhiên hơn, cứ đi quân và xem chuyện gì xảy ra".</p><div><p> Quang Liêm từng vô địch cờ chớp thế giới năm 2013, trước dàn cao thủ như Alexander Grischuk, Ian Nepomniachtchi hay Shakhriyar Mamedyarov. Trước khi bước vào nội dung cờ chớp ở siêu giải St Louis, thuộc hệ thống Grand Chess Tour, Quang Liêm đứng cuối ở nội dung cờ nhanh. Nhưng, anh thắng năm, hoà hai và thua hai trong chín ván cờ chớp đầu tiên, để leo lên thứ tám. Chỉ có Nakamura đạt sáu điểm như Quang Liêm trong ngày thi sáng 15/8, giờ Hà Nội.</p><p> Ở ván thứ chín, Quang Liêm chiếm ưu thế thắng trước chính Nakamura, nhưng sau đó thua ngược. Sau trận, Quang Liêm nói rằng anh rất tiếc với thất bại này. Còn Nakamura cũng cho rằng anh gặp may. Kỳ thủ Mỹ nói: "Ván đấu gặp Quang Liêm tôi chơi tệ nhất ngày, nhưng tôi gặp chút may mắn. Tôi vẫn có khả năng đi những nước không hoàn toàn là sai lầm nghiêm trọng. Ngay cả khi cờ bị yếu, tôi vẫn cố gắng chiến đấu và gặp may khi Quang Liêm để sót nước".</p><p> Elo cờ chớp tháng 8/2021 của Quang Liêm là 2.690, còn Nakamura đứng đầu thế giới với Elo 2.900. Sau chín ván, Quang Liêm kiếm thêm 47 Elo để vươn lên thứ 29 thế giới ở cờ chớp. Còn Nakamura mất 8 Elo, vẫn đứng số một nhưng ngang với Magnus Carlsen.</p><p> Quang Liêm và Nakamura đều có cơ hội cải thiện thành tích ở chín ván cờ chớp còn lại, diễn ra sáng 16/8, giờ Hà Nội. Đây cũng là ngày thi cuối cùng của giải. Nakamura đang đứng đầu siêu giải St Louis, còn Quang Liêm đứng thứ tám.</p><p> Ở cờ nhanh, mỗi kỳ thủ có 25 phút, thêm 10 giây sau mỗi nước đi. Còn ở cờ chớp, mỗi người chỉ có năm phút, thêm hai giây sau từng nước đi. Hôm 15/8, Quang Liêm thắng hai ván khi đối thủ bị hết thời gian, dù thế cờ khá cân bằng.</p></div>',
    'Kỳ thủ số một Việt Nam Lê Quang Liêm cho rằng để đạt kết quả tốt trong cờ chớp, cần chơi rất nhanh và tránh sai lầm ngớ ngẩn.', 
    DATE_SUB(NOW(), INTERVAL 2 DAY), 
    DATE_SUB(NOW(), INTERVAL 2 HOUR), 
    28, 
    0);

INSERT INTO `Posts` VALUES (
    58, 
    'Đấu thủ PGA Tour lĩnh một triệu USD dù bị cắt loại', 
    5, 
    12, 
    18, 
    -2, 
    '<p> Trước giải, Wolff đứng đầu RRC qua 38 vòng với đối thủ lớn nhất là Louis Oosthuizen. Tuy nhiên, golfer Nam Phi bỏ giải vì chấn thương cổ. Hôm 13/8, Wolff đủ điều kiện nhận thưởng vì lần lượt ghi par-birdie hố 15 qua hai ngày. Nhờ vậy, anh về nhất với điểm -1.105 - đánh ít hơn chuẩn (under par) 1,105 gậy.</p><p> RRC là cuộc đua dài cả mùa với một triệu USD cho người thắng với điều kiện dự tối thiểu 40 vòng. Trong đó, Ban tổ chức lấy bình quân hai thành tích tốt nhất tại một hố (par4 hoặc par5) được chỉ định trước tại mỗi giải. Kết quả chung cuộc dựa trên trung bình thành tích hố RRC qua 47 giải.</p><p> Hố RRC ở Wyndham Championship là hố 15 par5, dài 545 yard thuộc Sedgefield Country Club. Nó có bẫy nước kéo từ phía trước sang bên phải green. PGA Tour nói ở "ải" này, 87% golfer dự giải đủ sức lên green trong cú thứ hai.</p><p> "PGA Tour lắm cơ hội kiếm nhiều tiền. Tôi thì vẫn dạng mới ở đấu trường này, nên mọi phần thưởng đều hữu ích. Vài tháng qua tôi biết mình có cơ hội nên khá hồi hộp khi vào hố thi. Nhưng tôi vẫn đánh tốt rồi thắng chung cuộc. Tôi hạnh phúc vì thành tích này", Wolff tươi cười phát biểu trước giới truyền thông khi hết vòng thứ hai Wyndham Championship. Giải cũng kết thúc chương trình thường lệ của PGA Tour 2020-2021, đồng thời tổng kết Risk Reward Challenge (RRC).</p><p> Đầu sự kiện với quỹ thưởng 6,4 triệu USD này, Wolff còn cơ hội tranh khoản thưởng vô địch 1,152 triệu USD. Nhưng sau 36 hố, anh phải rời cuộc chơi do chỉ đạt điểm -1 trên sân par70.</p><p> Đỉnh bảng 54 hố thuộc về Russell Henley ở điểm -15. Henley dẫn suốt từ đầu giải, duy trì vị trí nhờ 69 gậy chặng áp chót. Bám anh là 13 đấu thủ trong tầm năm gậy trong đó Tyler McCumber cách gần nhất với điểm -12.</p><p> Wolff lên PGA Tour từ 2019, đoạt 3M Open cùng năm chào sân. Golfer Mỹ sinh năm 1999 khiến giới chuyên môn ngạc nhiên bằng kiểu vung gậy phi chính thống, nhưng hiệu quả. Anh nhún vài lần khi nạp swing, nhấc gót chân trước, chĩa đầu gậy lên trời sau đó, theo đường móc câu rồi mới vào chuẩn trong nửa sau vòng swing.</p>',
    'Matthew Wolff rời Wyndham Championship sau 36 hố nhưng vẫn lĩnh một triệu USD nhờ thắng Risk Reward Challenge (RRC) thuộc PGA Tour mùa này.', 
    DATE_SUB(NOW(), INTERVAL 2 DAY), 
    NULL, 
    0, 
    0);

INSERT INTO `Posts` VALUES (
    59, 
    'Võ sĩ Indonesia thắng knock-out sau 10 giây', 
    6, 
    null, 
    18, 
    0, 
    '<p> Trận đấu tại Kallang, Singapore kết thúc chóng vánh. Hai võ sĩ không phòng ngự, mà lao vào đôi công ngay khi trận đấu bắt đầu.</p><div><p> Sau hai pha ra đòn trúng mặt đẩy lùi Peng Shuai, Saputra đã áp sát tung cú móc phải nặng khiến đối thủ Trung Quốc ngã ra sàn. Trọng tài lập tức can thiệp, và trận đấu khép lại chỉ sau mười giây của hiệp đầu tiên.</p><p> Hạ đo ván Shuai sau 10 giây, Saputra lập kỷ lục thắng knock-out nhanh nhất trong lịch sử hạng ruồi ONE Championship. Saputra có chiến thắng thứ năm liên tiếp ngay từ hiệp một, qua đó đánh dấu màn trở lại hoàn hảo sau gần một năm không thi đấu.</p><p> Saputra tiếp đà thăng tiến vũ bão tại ONE Championship, và nhắm tới suất tranh đai gặp hai ngôi sao hạng ruồi mà anh từng gọi tên trước đó, là võ sĩ Campuchia Chan Rothana và đối thủ mang hai dòng máu Ấn Độ và Canada Gurdarshan Mangat.</p><p> Cha của Saputra là HLV quyền Anh, vì vậy, anh tập môn thể thao này khi mới năm tuổi. Saputra sau đó chuyển sang đấu vật theo lời khuyên của cha mẹ, và giành nhiều chức vô địch quốc gia. Võ sĩ sinh năm 1991 bất bại trên sàn đấu ở quê nhà Indonesia, và từng đoạt HC bạc và đồng SEA Games môn đấu vật.</p><p> Thành công trong sự nghiệp đấu vật thôi thúc Saputra thử sức với MMA. Cuối năm 2018, võ sĩ Indonesia gia nhập Evolve Fight Team và chuyển đến Singapore để theo đuổi sự nghiệp mới. Tại đây, anh tập luyện với nhiều nhà vô địch thế giới với mục tiêu chinh phục ngôi vô địch ONE Championship.</p></div><div> <br/></div>',
    'Eko Roni Saputra hạ đo ván Liu Peng Shuai bằng cú knock-out nhanh nhất lịch sử hạng ruồi ONE Championship tại sự kiện ONE Battleground 2 tối 13/8.', 
    DATE_SUB(NOW(), INTERVAL 1 DAY), 
    NULL, 
    0, 
    0);

INSERT INTO `Posts` VALUES (
    60, 
    'Quang Liêm khởi sắc ở siêu giải St Louis', 
    6, 
    12, 
    18, 
    1, 
    '<p> Quang Liêm và Hikaru Nakamura chơi ấn tượng nhất trong chín ván cờ chớp đầu tiên, khi đều kiếm được sáu điểm. Kỳ thủ Việt Nam kiếm 4,5 điểm sau năm trận đầu. Ở bốn ván sau, anh hụt hơi một chút khi chỉ kiếm 1,5 điểm. Nhưng, màn trình diễn đó cũng đủ để giúp Quang Liêm thoát khỏi vị trí cuối cùng. Anh chỉ đang kém vị trí thứ năm của Shakhriyar Mamedyarov một điểm.</p><p> Nếu giữ vững phong độ ở ngày thi cờ chớp cuối, Quang Liêm có thể tiến thêm vài bậc để tăng tiền thưởng.</p><p> Ở ván đầu tiên, Quang Liêm cầm quân trắng thắng Jeffery Xiong ở tàn cuộc hai mã và tốt cân bằng. Đến ván thứ hai, anh cầm quân đen nhưng tiếp tục thắng Sam Shankland nhờ đẩy được tốt cột d xuống hàng hai và doạ phong hậu. Ván thứ ba, Quang Liêm cầm quân trắng gặp Wesley So, và tạo ưu thế lớn suốt ván đấu. Nhưng, So tận dụng được cơ hội để chiếu bất biến cầu hoà.</p><p> Quang Liêm tìm lại mạch thắng ở ván thứ tư, khi anh cầm quân đen gặp Peter Svidler. Trong tàn cuộc tưởng như cân bằng, Svidler để hết thời gian và thua. Ván sau đó Quang Liêm cũng thắng khi Leinier Dominguez cạn giờ.</p><p> Sau khi hoà Mamedyarov ở ván sáu, Quang Liêm nhận thất bại đầu tiên trong ngày trước số hai thế giới Fabiano Caruana. Anh thắng Richard Rapport ở ván kế tiếp với tàn cuộc xe và ba tốt đánh xe. Ở ván cuối, kỳ thủ số một Việt Nam lại có cơ hội thắng, nhưng thua ngược Nakamura.</p><p> "Đáng lẽ tôi có thể làm tốt hơn nếu thắng Nakamura ở ván chín", Quang Liêm chia sẻ. "Nhưng tôi vẫn rất hạnh phúc với màn trình diễn hôm nay. Tôi kiếm được sáu điểm, bằng số điểm của ba ngày thi trước gộp lại. Và dù sao mục tiêu của tôi là thoát khỏi vị trí cuối, nên hôm nay tôi đã hoàn thành nhiệm vụ".</p><p> Cũng kiếm được sáu điểm như Quang Liêm, Nakamura giữ vững đỉnh bảng với 18 điểm trước ngày thi cuối. Caruana đứng thứ hai với 15,5 điểm. Rapport và So lần lượt đứng sau với 14,5 và 14 điểm. Quang Liêm đang có 12 điểm, đứng thứ tám. Shankland và Dominguez đứng cuối, với 11,5 điểm. Thứ bậc các kỳ thủ ở nhóm cuối sẽ xáo trộn sau ngày cuối.</p><p> Nếu kết thúc giải ở vị trí thứ tám, Quang Liêm sẽ nhận 8.000 USD. Còn nếu leo lên thứ năm, anh kiếm thêm 4.500 USD. Quỹ thưởng của giải là 150.000 USD, trong đó vị trí đầu nhận 37.500 USD.</p><p> Ngày thi cuối, 10 kỳ thủ đấu thêm chín ván cờ chớp, từ 3h sáng 16/8, giờ Hà Nội.</p>',
    'Kỳ thủ Lê Quang Liêm kiếm sáu trên chín điểm tối đa ở ngày thi cờ chớp sáng 15/8, để vươn lên thứ tám siêu giải St Louis.', 
    DATE_SUB(NOW(), INTERVAL 3 DAY), 
    DATE_SUB(NOW(), INTERVAL 2 DAY), 
    125, 
    1);

--Comment
INSERT INTO `Comments` VALUES (1, 1, 50, DATE_SUB(NOW(), INTERVAL 2 HOUR), 'Bài viết hay và hữu ích cho những ai là F0, F1', 'reader');
INSERT INTO `Comments` VALUES (1, 2, 46, DATE_SUB(NOW(), INTERVAL 2 HOUR), 'Vitamin C rất hữu ích cho sức khoẻ', 'reader');
INSERT INTO `Comments` VALUES (1, 2, 56, DATE_SUB(NOW(), INTERVAL 2 HOUR), 'Mình rất tự hào về Quang Liêm', 'reader');