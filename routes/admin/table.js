const express=require('express');
const pool=require('../../pool');
var router=express.Router();
module.exports=router;

/**
* GET  /admin/table
* 获取所有的桌台信息
* 返回值形如
* {tid:1,tname:'福满堂',type:'4人桌',status:1}
*/
router.get('/',(req,res)=>{
  pool.query('SELECT * FROM klyd_table ORDER BY tid',(err,result)=>{
    if(err) throw err;
    res.send(result);
  })
})

/**
* GET  /admin/table/reservation/:tid
* 获取预约状态桌台的详情
* 返回值形如
* {code:200,msg:'require revervation succ'}
* {code:400,mag:'revervation not exits'}
*/

/**
* GET  /admin/table/inuse/:tid
* 获取占用状态桌台的详情
* 返回值形如
* {code:200,msg:'require inuse succ'}
* {code:400,msg:'inuse not exits'}
*/

/**
 * PATCH   /admin/table
 * 修改桌台的状态
 * 返回值形如
 * {code:200,msg:'update table succ'}
 * {code:400,msg:'table not exits'}
 */

/**
 * POST    /admin/table
 * 添加桌台
 * 返回值形如
 * {code:200,msg:'add table succ'}
 * {code:400,msg:'table not exits'}
 */

/**
 * DELETE   /admin/table/:tid
 * 删除桌台
 * 返回值形如
 * {code:200,msg:'delete table succ'}
 * {code:400,msg:'table not exits'}
 */