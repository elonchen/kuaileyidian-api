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
  aname   VARCHAR(32) COMMENT "管理员用户名",
  apwd   VARCHAR(64) COMMENT "管理员密码",
  role   INT COMMENT "管理员角色"
);
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
#桌台信息表
CREATE TABLE klyd_table(
  tid   INT PRIMARY KEY AUTO_INCREMENT COMMENT "桌台编号",
  tname   VARCHAR(64) COMMENT "桌台昵称",
  type   VARCHAR(16) COMMENT "桌台类型 如3-4人桌",
  status   INT COMMENT "当前状态"
);
#桌台的预定表
CREATE TABLE klyd_reservation(
  rid   INT PRIMARY KEY AUTO_INCREMENT COMMENT "信息编号",
  contactName     VARCHAR(64) COMMENT "联系人姓名",
  phone    VARCHAR(16) COMMENT "联系电话",
  contactTime   BIGINT COMMENT "联系时间",
  dinnerTime    BIGINT COMMENT "预约的用餐时间"
);
#菜品分类表
CREATE TABLE klyd_category(
  cid    INT PRIMARY KEY AUTO_INCREMENT COMMENT "类别编号",
  cname     VARCHAR(32) COMMENT "类别名称"
);
#菜品信息表
CREATE TABLE klyd_dish(
  did   INT PRIMARY KEY AUTO_INCREMENT COMMENT "菜品编号其实质为100000",
  title  VARCHAR(32) COMMENT "菜品名称/标题",
  imgUrl   VARCHAR(128) COMMENT "图片地址",
  price DECIMAL(6,2) COMMENT "价格",
  detail  VARCHAR(128) COMMENT "详细描述信息",
  categoryId   INT  COMMENT "所属类别编号"
);
#订单表
CREATE TABLE klyd_order(
  oid   INT PRIMARY KEY AUTO_INCREMENT COMMENT "订单编号",
  startTime  BIGINT COMMENT "开始用餐时间",
  endTime    BIGINT COMMENT "结束用餐时间",
  customerCount  INT COMMENT "用餐人数",
  TABLEld   INT   COMMENT "桌台编号"
);
#订单表
CREATE TABLE klyd_order_detail(
  did   INT PRIMARY KEY AUTO_INCREMENT COMMENT "订单编号",
  dishld    INT COMMENT "菜单编号,外键参考菜品did",
  dishCount  INT COMMENT "菜品数量",
  customerName  VARCHAR(64) COMMENT "点餐用户的称呼",
  orderld   INT COMMENT "订单编号，指明所属订单,外键参考订单oid"
);