#设置客户端连接时使用的编码
SET NAMES UTF8;
#丢弃数据库klyd 如果存在
DROP DATABASE IF EXISTS klyd;
#创建数据库存储的编码
CREATE DATABASE klyd CHARSET=UTF8;
#进入数据库
USE klyd;
#创建数据库表
#管理员信息表
CREATE TABLE klyd_admin(
  aid INT PRIMARY KEY AUTO_INCREMENT COMMENT "管理员编号",
  aname   VARCHAR(32) UNIQUE COMMENT "管理员用户名",
  apwd   VARCHAR(64) COMMENT "管理员密码"
);
INSERT INTO klyd_admin VALUES
(NULL,'admin',PASSWORD('123456')),
(NULL,'boss',PASSWORD('999999'));

#项目全局设置
CREATE TABLE klyd_settings(
  sid   INT PRIMARY KEY AUTO_INCREMENT,
  appName   VARCHAR(32) COMMENT "应用/店家名称",
  apiUrl   VARCHAR(64) COMMENT "数据api子系统地址",
  adminUrl  VARCHAR(64) COMMENT "管理后台子系统地址",
  appUrl    VARCHAR(64) COMMENT "顾客api子系统地址",
  icp   VARCHAR(64) COMMENT "系统备案号",
  copyright   VARCHAR(128) COMMENT "系统版权声明"
);
INSERT INTO klyd_settings VALUES
(NULL,'快乐一点','http://127.0.0.1:8090','http://127.0.0.1:8091','http://127.0.0.1:8092','京ICP备 18016421号-1','Copyright © 北京大内');

#桌台信息表
CREATE TABLE klyd_table(
  tid   INT PRIMARY KEY AUTO_INCREMENT COMMENT "桌台编号",
  tname   VARCHAR(64) COMMENT "桌台昵称",
  type   VARCHAR(16) COMMENT "桌台类型 如3-4人桌",
  status   INT COMMENT "当前状态"
);
INSERT INTO klyd_table VALUES
(1,'福满堂','6-8人桌',1),
(2,'金镶玉','4人桌',2),
(3,'寿启天','10人桌',3),
(4,'全家福','2人桌',0);

#桌台的预定表
CREATE TABLE klyd_reservation(
  rid   INT PRIMARY KEY AUTO_INCREMENT COMMENT "信息编号",
  contactName     VARCHAR(64) COMMENT "联系人姓名",
  phone    VARCHAR(16) COMMENT "联系电话",
  contactTime   BIGINT COMMENT "联系时间",
  dinnerTime    BIGINT COMMENT "预约的用餐时间",
  tableId   INT,
  FOREIGN KEY(tableId) REFERENCES klyd_table(tid)
);
INSERT INTO klyd_reservation VALUES
(NULL,'dingding','12345678965',1548404830420,1548410400000,1),
(NULL,'dangdang','12345854261',1548404830420,1548410400000,2),
(NULL,'doudou','52461235894',1548404830420,1548410400000,3),
(NULL,'dudu','12358945624',1548404830420,1548410400000,4);

#菜品分类表
CREATE TABLE klyd_category(
  cid    INT PRIMARY KEY AUTO_INCREMENT COMMENT "类别编号",
  cname     VARCHAR(32) COMMENT "类别名称"
);
INSERT INTO klyd_category VALUES
(NULL,'肉类'),
(NULL,'丸滑类'),
(NULL,'菌菇类'), 
(NULL,'海鲜河鲜'),
(NULL,'蔬菜豆制品类'),
(NULL,'捞派特色菜类');

#菜品信息表
CREATE TABLE klyd_dish(
  did   INT PRIMARY KEY AUTO_INCREMENT COMMENT "菜品编号其实质为100000",
  title  VARCHAR(32) COMMENT "菜品名称/标题",
  imgUrl   VARCHAR(128) COMMENT "图片地址",
  price DECIMAL(6,2) COMMENT "价格",
  detail  VARCHAR(128) COMMENT "详细描述信息",
  categoryId   INT  COMMENT "所属类别编号",
  FOREIGN KEY(categoryId) REFERENCES klyd_category(cid)
);
INSERT INTO klyd_dish VALUES
(100000,'草鱼片','CE7I9470.jpg',35,'选鲜活草鱼，切出鱼片冷鲜保存。锅开后再煮1分钟左右即可食用',1),
(100001,'脆皮肠','CE7I9017.jpg',36,'锅开后再煮3分钟左右即可食用',1),
(100002,'酥肉','HGS_4760.jpg',22,'选用冷鲜五花肉，加上鸡蛋，淀粉等原料炸制，色泽黄亮，酥软醇香，肥而不腻。锅开后再煮3分钟左右即可食用',1),
(100003,'现炸酥肉(非清真)','HGS_4761.jpg',28,'选用冷鲜五花肉，加上鸡蛋，淀粉等原料炸制，色泽黄亮，酥软醇香，肥而不腻。锅开后再煮1分钟左右即可食用，也可直接食用',1),
(100004,'牛百叶','CE7I9302.jpg',35,'毛肚切丝后，配以调味料腌制而成。锅开后再煮2分钟左右即可食用',1),
(100005,'腰花','CE7I9287.jpg',35,'选用大型厂家冷鲜腰花，经过解冻、清洗、切片而成。锅开后涮30秒左右即可食用',1),
(100006,'新西兰羊肉卷','CE7I8804.jpg',23,'选用新西兰羔羊肉的前胸和肩胛为原料，在国内经过分割、压制成型，肥瘦均匀。锅开后涮30秒左右即可食用',1),
(100007,'捞派黄喉','EU0A0112.jpg',35,'羊后腿肉肉质紧实，肥肉少，以瘦肉为主；肉中夹筋，筋肉相连。肉质相比前腿肉更为细嫩，用途广，一般用于烧烤、酱制等用途。海底捞只选用生长周期达到6—8个月的草原羔羊，肉嫩筋少而膻味少。精选羔羊后腿肉，肉质紧实，瘦而不柴，再用红油腌制入味，肉香与油香充分融合，一口咬下去鲜嫩多汁、肉味十足',1);

#订单表
CREATE TABLE klyd_order(
  oid   INT PRIMARY KEY AUTO_INCREMENT COMMENT "订单编号",
  startTime  BIGINT COMMENT "开始用餐时间",
  endTime    BIGINT COMMENT "结束用餐时间",
  customerCount  INT COMMENT "用餐人数",
  tableId   INT   COMMENT "桌台编号",
  FOREIGN KEY(tableId) REFERENCES klyd_table(tid)
);
INSERT INTO klyd_order VALUES
(1,4564541312312,7898979798797,3,1);

#订单表
CREATE TABLE klyd_order_detail(
  did   INT PRIMARY KEY AUTO_INCREMENT COMMENT "订单编号",
  dishId    INT COMMENT "菜单编号,外键参考菜品did",
  dishCount  INT COMMENT "菜品数量",
  customerName  VARCHAR(64) COMMENT "点餐用户的称呼",
  orderId   INT COMMENT "订单编号，指明所属订单,外键参考订单oid",
  FOREIGN KEY(dishId) REFERENCES klyd_dish(did),
  FOREIGN KEY(orderId) REFERENCES klyd_order(oid)
);
INSERT INTO klyd_order_detail VALUES
(NULL,100000,2,'dingding',1);