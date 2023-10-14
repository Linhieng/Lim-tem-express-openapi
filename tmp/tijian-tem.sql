/*
MySQL Data Transfer
Source Host: localhost
Source Database: tijian
Target Host: localhost
Target Database: tijian
Date: 2022/3/14 11:55:09
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for checkitem
-- ----------------------------
DROP TABLE IF EXISTS `checkitem`;
CREATE TABLE `checkitem` (
  `ciId` int(11) NOT NULL AUTO_INCREMENT COMMENT '检查项编号',
  `ciName` varchar(30) NOT NULL COMMENT '检查项名称',
  `ciContent` varchar(200) NOT NULL COMMENT '检查项内容',
  `meaning` varchar(200) DEFAULT NULL COMMENT '检查项意义',
  `remarks` varchar(50) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`ciId`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for checkitemdetailed
-- ----------------------------
DROP TABLE IF EXISTS `checkitemdetailed`;
CREATE TABLE `checkitemdetailed` (
  `cdId` int(11) NOT NULL AUTO_INCREMENT COMMENT '检查项明细编号',
  `name` varchar(40) NOT NULL COMMENT '检查项细明名称',
  `unit` varchar(20) DEFAULT NULL COMMENT '检查项明细单位',
  `minrange` double DEFAULT NULL COMMENT '检查项细明正常值范围中的最小值',
  `maxrange` double DEFAULT NULL COMMENT '检查项细明正常值范围中的最大值',
  `normalValue` varchar(20) DEFAULT NULL COMMENT '检查项细明正常值（非数字型）',
  `normalValueString` varchar(20) DEFAULT NULL COMMENT '检查项验证范围说明文字',
  `type` int(11) NOT NULL DEFAULT '1' COMMENT '检查项明细类型（1：数值围范验证型；2：数值相等验证型；3：无需验证型；4：描述型；5：其它）',
  `ciId` int(11) NOT NULL COMMENT '所属检查项编号',
  `remarks` varchar(100) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`cdId`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for cidetailedreport
-- ----------------------------
DROP TABLE IF EXISTS `cidetailedreport`;
CREATE TABLE `cidetailedreport` (
  `cidrId` int(11) NOT NULL AUTO_INCREMENT COMMENT '检查项明细报告主键',
  `name` varchar(40) NOT NULL COMMENT '检查项明细名称',
  `unit` varchar(20) DEFAULT NULL COMMENT '检查项明细单位',
  `minrange` double DEFAULT NULL COMMENT '检查项细明正常值范围中的最小值',
  `maxrange` double DEFAULT NULL COMMENT '检查项细明正常值范围中的最大值',
  `normalValue` varchar(20) DEFAULT NULL COMMENT '检查项细明正常值（非数字型）',
  `normalValueString` varchar(20) DEFAULT NULL COMMENT '检查项验证范围说明文字',
  `type` int(11) NOT NULL DEFAULT '1' COMMENT '检查项明细类型（1：数值范围验证型；2：数值相等验证型；3：无需验证型；4：描述型；5：其它）',
  `value` varchar(100) DEFAULT NULL COMMENT '检查项目明细值',
  `isError` int(11) NOT NULL DEFAULT '0' COMMENT '此项是否异常（0：无异常；1：异常）',
  `ciId` int(11) NOT NULL COMMENT '所属检查项报告编号',
  `orderId` int(11) NOT NULL COMMENT '所属预约编号',
  PRIMARY KEY (`cidrId`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for cireport
-- ----------------------------
DROP TABLE IF EXISTS `cireport`;
CREATE TABLE `cireport` (
  `cirId` int(11) NOT NULL AUTO_INCREMENT COMMENT '检查项报告主键',
  `ciId` int(11) NOT NULL COMMENT '检查项编号',
  `ciName` varchar(30) NOT NULL COMMENT '检查项名称',
  `orderId` int(11) NOT NULL COMMENT '所属预约编号',
  PRIMARY KEY (`cirId`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for doctor
-- ----------------------------
DROP TABLE IF EXISTS `doctor`;
CREATE TABLE `doctor` (
  `docId` int(11) NOT NULL AUTO_INCREMENT COMMENT '医生编号',
  `docCode` varchar(20) NOT NULL COMMENT '医生编码',
  `realName` varchar(20) NOT NULL COMMENT '真实姓名',
  `password` varchar(20) NOT NULL COMMENT '密码',
  `sex` int(11) NOT NULL COMMENT '性别',
  `deptno` int(11) NOT NULL COMMENT '所属科室（1：检验科；2：内科；3：外科）',
  PRIMARY KEY (`docId`),
  UNIQUE KEY `docCode` (`docCode`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for hospital
-- ----------------------------
DROP TABLE IF EXISTS `hospital`;
CREATE TABLE `hospital` (
  `hpId` int(11) NOT NULL AUTO_INCREMENT COMMENT '医院编号',
  `name` varchar(30) NOT NULL COMMENT '医院名称',
  `picture` mediumtext NOT NULL COMMENT '医院图片',
  `telephone` varchar(20) NOT NULL COMMENT '医院电话',
  `address` varchar(100) NOT NULL COMMENT '医院地址',
  `businessHours` varchar(100) NOT NULL COMMENT '营业时间',
  `deadline` varchar(30) NOT NULL COMMENT '采血截止时间',
  `rule` varchar(30) NOT NULL COMMENT '预约人数规则',
  `state` int(11) NOT NULL COMMENT '医院状态（1：正常；2：其他）',
  PRIMARY KEY (`hpId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `orderId` int(11) NOT NULL AUTO_INCREMENT COMMENT '订单编号',
  `orderDate` date NOT NULL COMMENT '预约日期',
  `userId` varchar(11) NOT NULL COMMENT '客户编号',
  `hpId` int(11) NOT NULL COMMENT '所属医院编号',
  `smId` int(11) NOT NULL COMMENT '所属套餐编号',
  `state` int(11) NOT NULL DEFAULT '1' COMMENT '订单状态（1：未归档；2：已归档）',
  PRIMARY KEY (`orderId`)
) ENGINE=InnoDB AUTO_INCREMENT=100569837 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for overallresult
-- ----------------------------
DROP TABLE IF EXISTS `overallresult`;
CREATE TABLE `overallresult` (
  `orId` int(11) NOT NULL AUTO_INCREMENT COMMENT '总检结论项编号',
  `title` varchar(40) NOT NULL COMMENT '总检结论项标题',
  `content` varchar(400) DEFAULT NULL COMMENT '总检结论项内容',
  `orderId` int(11) NOT NULL COMMENT '所属预约编号',
  PRIMARY KEY (`orId`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for setmeal
-- ----------------------------
DROP TABLE IF EXISTS `setmeal`;
CREATE TABLE `setmeal` (
  `smId` int(11) NOT NULL AUTO_INCREMENT COMMENT '套餐编号',
  `name` varchar(255) NOT NULL COMMENT '套餐名称',
  `type` int(11) NOT NULL COMMENT '套餐类型（1：男士餐套；0：女士套餐）',
  `price` int(11) NOT NULL COMMENT '套餐价格',
  PRIMARY KEY (`smId`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for setmealdetailed
-- ----------------------------
DROP TABLE IF EXISTS `setmealdetailed`;
CREATE TABLE `setmealdetailed` (
  `sdId` int(11) NOT NULL AUTO_INCREMENT COMMENT '套餐明细编号（无意义主键）',
  `smId` int(11) NOT NULL COMMENT '套餐编号',
  `ciId` int(11) NOT NULL COMMENT '检查项编号',
  PRIMARY KEY (`sdId`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `userId` varchar(11) NOT NULL COMMENT '用户编号（手机号码）',
  `password` varchar(20) NOT NULL COMMENT '密码',
  `realName` varchar(20) NOT NULL COMMENT '真实姓名',
  `sex` int(11) NOT NULL COMMENT '用户性别（1：男；0女）',
  `identityCard` varchar(18) NOT NULL COMMENT '身份证号',
  `birthday` date NOT NULL COMMENT '出生日期',
  `userType` int(11) NOT NULL COMMENT '用户类型（1：普通用户；2：其他）',
  PRIMARY KEY (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records
-- ----------------------------
INSERT INTO `checkitem` VALUES ('1', '一般检查', '血压、身高、体重、腰围、臀围。', '通过仪器测定人体基本健康指标。', null);
INSERT INTO `checkitem` VALUES ('2', '血常规', '血常规24项:\r\n                中性粒细胞计数绝对值、红细胞压值、血小板比容、单核细胞计数百分比、平均血小板体积、\r\n                大血小板比例、嗜碱性粒细胞计数百分比、平均血红蛋白含量等。', '临床三大常规检测之一，是最基本的血液检验。通过观察血细胞的数量变化及形态分布，从而判断血液状况及相关疾病。', null);
INSERT INTO `checkitem` VALUES ('3', '尿常规', '尿维生素C测定、尿比重测定、尿液酮体测定、尿胆红素测定、尿亚硝酸盐测定、尿液颜色、尿白细胞计数、尿蛋白定性、\r\n                尿液镜检、尿葡萄糖测定、尿液隐血、尿液酸碱度、尿液清晰度、尿胆原。', '临床三大常规检测之一，可反映机体的代谢状况，是很多疾病诊断的重要指标。', null);
INSERT INTO `checkitem` VALUES ('4', '肾功能', '肾功能（renal function）是指肾脏排泄体内代谢废物，维持机体钠、钾、钙等电解质的稳定及酸碱平衡的功能，肾功能检查包括血肌酐、血尿素氮、血及尿β2—微球蛋白、尿白蛋白、尿免疫球蛋白G、尿分泌型免疫球蛋白A等。', '肾功能检查的临床意义用于急慢性肾炎、肾病、尿毒症、肾衰竭等疾病的检查。', null);
INSERT INTO `checkitem` VALUES ('5', '肝功能', '丙氨酸氨基转移酶（又称谷丙转氨酶，ALT）、门冬氨酸氨基转移酶（又称谷草转氨酶，AST）、碱性磷酸酶（ALP）、γ－谷氨酰转肽酶（γ－GT或GGT）。', '肝功能检查的目的在于探测肝脏有无疾病、肝脏损害程度以及查明肝病原因、判断预后和鉴别发生黄疸的病因等。', null);
INSERT INTO `checkitem` VALUES ('6', '妇科检查', '全身检查、腹部检查和盆腔检查。检查外阴、阴道、子宫颈和子宫、输卵管、卵巢及宫旁组织和骨盆腔内壁。', '主要作用是对一些妇科疾病作出早期诊断、预防以及早期治疗。', null);
INSERT INTO `checkitemdetailed` VALUES ('1', '收缩压', null, '0', '140', null, '<140', '1', '1', null);
INSERT INTO `checkitemdetailed` VALUES ('2', '舒张压', null, '0', '90', null, '<90', '1', '1', null);
INSERT INTO `checkitemdetailed` VALUES ('3', '身高', 'cm', null, null, null, null, '3', '1', null);
INSERT INTO `checkitemdetailed` VALUES ('4', '体重', 'kg', null, null, null, null, '3', '1', null);
INSERT INTO `checkitemdetailed` VALUES ('5', '腰围', 'cm', null, null, null, null, '3', '1', null);
INSERT INTO `checkitemdetailed` VALUES ('6', '臀围', 'cm', null, null, null, null, '3', '1', null);
INSERT INTO `checkitemdetailed` VALUES ('7', '白细胞计数', '10^9/L', '4', '10', null, '4-10', '1', '2', null);
INSERT INTO `checkitemdetailed` VALUES ('8', '红细胞压值', '%', '36', '50', null, '36-50', '1', '2', null);
INSERT INTO `checkitemdetailed` VALUES ('9', '淋巴细胞计数百分比', '%', '18.3', '47.9', null, '18.3-47.9', '1', '2', null);
INSERT INTO `checkitemdetailed` VALUES ('10', '单核细胞计数百分比', '%', '4.2', '15.2', null, '4.2-15.2', '1', '2', null);
INSERT INTO `checkitemdetailed` VALUES ('11', '嗜酸性粒细胞计数百分比', '%', '0.2', '7.6', null, '0.2-7.6', '1', '2', null);
INSERT INTO `checkitemdetailed` VALUES ('12', '中性粒细胞计数绝对值', '10^9/L', '1.8', '8.89', null, '1.8-8.89', '1', '2', null);
INSERT INTO `checkitemdetailed` VALUES ('13', '血小板计数', '10^9/L', '100', '300', null, '100-300', '1', '2', null);
INSERT INTO `checkitemdetailed` VALUES ('14', '血红细胞计数', '10^12/L', '3.5', '5.5', null, '3.5-5.5', '1', '2', null);
INSERT INTO `checkitemdetailed` VALUES ('15', '尿白细胞', '/ul', null, null, '-', '-', '2', '3', null);
INSERT INTO `checkitemdetailed` VALUES ('16', '尿亚硝酸盐', null, null, null, '-', '-（阴性）', '2', '3', null);
INSERT INTO `checkitemdetailed` VALUES ('17', '尿液酸碱度', null, '5.5', '6.5', null, '5.5-6.5', '1', '3', null);
INSERT INTO `checkitemdetailed` VALUES ('18', '尿蛋白定性', 'g/L', null, null, '-', '-', '2', '3', null);
INSERT INTO `checkitemdetailed` VALUES ('19', '尿比重', null, '1.015', '1.025', null, '1.015-1.025', '1', '3', null);
INSERT INTO `checkitemdetailed` VALUES ('20', '尿维生素', 'mmol/L', null, null, '0', '0', '2', '3', null);
INSERT INTO `checkitemdetailed` VALUES ('21', '血清肌酐', 'umol/L', '41', '111', null, '41-111', '1', '4', null);
INSERT INTO `checkitemdetailed` VALUES ('22', '血尿素氮', 'mmol/L', '2.85', '7.14', null, '2.85-7.14', '1', '4', null);
INSERT INTO `checkitemdetailed` VALUES ('23', '血尿酸', 'umol/L', '208', '428', null, '208-428', '1', '4', null);
INSERT INTO `checkitemdetailed` VALUES ('24', '白蛋白', 'g/L', '35', '55', null, '35-55', '1', '5', null);
INSERT INTO `checkitemdetailed` VALUES ('25', '血清谷草转氨酶', 'U/L', '15', '40', null, '15-40', '1', '5', null);
INSERT INTO `checkitemdetailed` VALUES ('26', '血清谷丙转氨酶', 'U/L', '9', '50', null, '9-50', '1', '5', null);
INSERT INTO `checkitemdetailed` VALUES ('27', '血清总胆红素', 'umol/L', '0', '20', null, '0-20', '1', '5', null);
INSERT INTO `checkitemdetailed` VALUES ('28', '血清总蛋白', 'g/L', '60', '87', null, '60-87', '1', '5', null);
INSERT INTO `checkitemdetailed` VALUES ('29', '盆腔检查', null, null, null, null, null, '4', '6', null);
INSERT INTO `checkitemdetailed` VALUES ('30', '乳腺检查', null, null, null, null, null, '4', '6', null);
INSERT INTO `checkitemdetailed` VALUES ('31', '子宫检查', null, null, null, null, null, '4', '6', null);
INSERT INTO `doctor` VALUES ('1', 'zzj', '张仲景', '123', '1', '1');
INSERT INTO `doctor` VALUES ('2', 'ssm', '孙思邈', '123', '1', '1');
INSERT INTO `hospital` VALUES ('1', '沈阳熙康云医院-和平院区', 'imgData', '4006297568', '文体路7号世贸商都（五里河茶城）四楼西区', '周一至周五 7:30-15:30 （周六截止12:00）', '采血截止时间 10:30', '0,200,200,200,200,200,100', '1')
INSERT INTO `hospital` VALUES ('2', '沈阳熙康云医院-浑南院区', 'imgData', '4006297568', '创新路175号（与智慧大厦交汇处）', '周一至周六 7:30-11:30', '采血截止时间 10:30', '0,200,200,200,200,200,200', '1')
INSERT INTO `orders` VALUES ('100569001', '2022-12-31', '12345671111', '1', '4', '1');
INSERT INTO `orders` VALUES ('100569823', '2022-01-11', '12345672222', '2', '1', '1');
INSERT INTO `orders` VALUES ('100569824', '2022-01-12', '12345673333', '1', '2', '1');
INSERT INTO `orders` VALUES ('100569825', '2022-01-13', '12345674444', '2', '3', '1');
INSERT INTO `orders` VALUES ('100569826', '2022-01-14', '12345675555', '1', '1', '1');
INSERT INTO `orders` VALUES ('100569827', '2022-01-17', '12345676666', '2', '2', '1');
INSERT INTO `orders` VALUES ('100569828', '2022-01-17', '12345677777', '1', '5', '1');
INSERT INTO `orders` VALUES ('100569829', '2022-01-17', '12345678888', '2', '3', '1');
INSERT INTO `orders` VALUES ('100569830', '2022-01-17', '12345679999', '1', '6', '1');
INSERT INTO `orders` VALUES ('100569831', '2022-01-18', '12345678111', '2', '3', '1');
INSERT INTO `orders` VALUES ('100569832', '2022-01-18', '12345678222', '2', '5', '1');
INSERT INTO `orders` VALUES ('100569833', '2022-01-19', '12345671111', '1', '5', '1');
INSERT INTO `orders` VALUES ('100569836', '2022-03-30', '12345672222', '2', '3', '1');
INSERT INTO `setmeal` VALUES ('1', '男士-基础套餐', '1', '350');
INSERT INTO `setmeal` VALUES ('2', '男士-肾病检查', '1', '600');
INSERT INTO `setmeal` VALUES ('3', '男士-肝病检查', '1', '600');
INSERT INTO `setmeal` VALUES ('4', '女士-基础套餐', '0', '400');
INSERT INTO `setmeal` VALUES ('5', '女士-肾病检查', '0', '650');
INSERT INTO `setmeal` VALUES ('6', '女士-肝病检查', '0', '650');
INSERT INTO `setmealdetailed` VALUES ('1', '1', '1');
INSERT INTO `setmealdetailed` VALUES ('2', '1', '2');
INSERT INTO `setmealdetailed` VALUES ('3', '1', '3');
INSERT INTO `setmealdetailed` VALUES ('4', '2', '1');
INSERT INTO `setmealdetailed` VALUES ('5', '2', '2');
INSERT INTO `setmealdetailed` VALUES ('6', '2', '3');
INSERT INTO `setmealdetailed` VALUES ('7', '2', '4');
INSERT INTO `setmealdetailed` VALUES ('8', '3', '1');
INSERT INTO `setmealdetailed` VALUES ('9', '3', '2');
INSERT INTO `setmealdetailed` VALUES ('10', '3', '3');
INSERT INTO `setmealdetailed` VALUES ('11', '3', '5');
INSERT INTO `setmealdetailed` VALUES ('12', '4', '1');
INSERT INTO `setmealdetailed` VALUES ('13', '4', '2');
INSERT INTO `setmealdetailed` VALUES ('14', '4', '3');
INSERT INTO `setmealdetailed` VALUES ('15', '4', '6');
INSERT INTO `setmealdetailed` VALUES ('16', '5', '1');
INSERT INTO `setmealdetailed` VALUES ('17', '5', '2');
INSERT INTO `setmealdetailed` VALUES ('18', '5', '3');
INSERT INTO `setmealdetailed` VALUES ('19', '5', '4');
INSERT INTO `setmealdetailed` VALUES ('20', '5', '6');
INSERT INTO `setmealdetailed` VALUES ('21', '6', '1');
INSERT INTO `setmealdetailed` VALUES ('22', '6', '2');
INSERT INTO `setmealdetailed` VALUES ('23', '6', '3');
INSERT INTO `setmealdetailed` VALUES ('24', '6', '5');
INSERT INTO `setmealdetailed` VALUES ('25', '6', '6');
INSERT INTO `users` VALUES ('12345671111', '123', '叶文洁', '0', '254852364142366454', '1990-06-22', '1');
INSERT INTO `users` VALUES ('12345672222', '123', '汪淼', '1', '534866512578524774', '1990-06-22', '2');
INSERT INTO `users` VALUES ('12345673333', '123', '史强', '1', '452124537854757864', '1990-06-22', '1');
INSERT INTO `users` VALUES ('12345674444', '123', '罗辑', '1', '447563476378994358', '1990-06-22', '1');
INSERT INTO `users` VALUES ('12345675555', '123', '章北海', '1', '578724345764525473', '1990-06-22', '1');
INSERT INTO `users` VALUES ('12345676666', '123', '云天海', '1', '378542689424345645', '1990-06-22', '1');
INSERT INTO `users` VALUES ('12345677777', '123', '程心', '0', '456424537575852435', '1990-06-22', '1');
INSERT INTO `users` VALUES ('12345678111', '123', '托马斯•维德', '1', '743785434523423453', '1990-06-22', '1');
INSERT INTO `users` VALUES ('12345678222', '123', '东方延绪', '0', '786784524345345254', '1990-06-22', '1');
INSERT INTO `users` VALUES ('12345678888', '123', '丁仪', '1', '453754543645678364', '1990-06-22', '1');
INSERT INTO `users` VALUES ('12345679999', '123', '杨冬', '0', '786785465854645458', '1990-06-22', '1');
