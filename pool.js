/**
 * Mysql数据库连接池
 */
const mysql=require('mysql');
var pool=mysql.createPool({
  host:'127.0.0.1',
  port:3306,
  user:'root',
  password:'',
  database:'klyd',
  connectionLimit:10
  // host     : process.env.MYSQL_HOST,
  // port     : process.env.MYSQL_PORT,
  // user     : process.env.ACCESSKEY,
  // password : process.env.SECRETKEY,
  // database : 'app_' + process.env.APPNAME,
  // connectionLimit:3
});
module.exports=pool; 