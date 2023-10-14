/*
mysql 版本：8.0.34
建表规范：
    - 字段统一小写
    - INT 不需要最大显示宽度
    - 使用自增数字有序 UUID 做主键
        如果 INNODB 表没有显式定义主键，则可能会选择唯一索引做为主键，但是唯一索引很可能不是递增的，写入数据时，很可能会导致数据页频繁分裂，从而导致写入效率低和页空间浪费。这也是选择自增 INT 类型或者有序 UUID 做为主键的原因。
    - 使用 COMMENT 添加注释
    - 每张表都添加 create_time 和 update_time
    - 使用 status 来标识是否有效。删除时置为 0
    - 具有唯一性的字段，应该添加成唯一索引
    - 字符集使用 utf8mb4
    - 存储引擎使用 INNODB
    - 单表字段数目小于 30
    - 存储精确浮点数必须使用 DECIMAL 替代 FLOAT 和 DOUBLE。
    - 为经常作为条件、排序、关联的字段增加索引，比如下面的 update_time
    - 用尽量少的存储空间来存储一个字段的数据
        能用 INT 的就不用 CHAR 或者 VARCHAR；
        能用 TINYINT 的就不用 INT；
        使用 UNSIGNED 存储非负数值；
        只存储年使用 YEAR 类型；
        只存储日期使用 DATE 类型。
        尽可能不使用 TEXT、BLOB 类型。
 */

CREATE DATABASE physical
    DEFAULT CHARACTER SET utf8mb4
    DEFAULT COLLATE utf8mb4_general_ci;

USE physical;

DROP TABLE IF EXISTS `doctor_info`;
CREATE TABLE doctor_info (
    `id`                  INT NOT NULL AUTO_INCREMENT                                        COMMENT '主键',
    `real_name`   VARCHAR(10) NOT NULL                                                       COMMENT '姓名',
    `password`    VARCHAR(16) NOT NULL                                                       COMMENT '密码',
    `doctor_code` VARCHAR(10) NOT NULL                                                       COMMENT '医生编码（用于登录）',
    `gender`          TINYINT NOT NULL DEFAULT '2'                                           COMMENT '0女；1男；2保密',
    `create_time`    DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP                             COMMENT '记录创建时间',
    `update_time`    DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '记录更新时间',
    `status`          TINYINT NOT NULL DEFAULT '1'                                           COMMENT '1代表记录有效；0代表记录无效（相当于删除）',
    PRIMARY KEY (`id`),
    UNIQUE  KEY uni_doc_code (`doctor_code`),
            KEY idx_update_time (`update_time`)
) ENGINE  = INNODB
  CHARSET = utf8mb4
  COMMENT '医生信息表';

INSERT INTO doctor_info (real_name, password, doctor_code, gender)
    VALUES ('张仲景', '123', '123', 1);
