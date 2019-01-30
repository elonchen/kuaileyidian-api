const express=require('express');
const pool=require('../../pool');
var router=express.Router();
module.exports=router;


/**
 * GET  /admin/settings
 * 获得所有的全局设置信息
 */
router.get('/',(req,res)=>{
  pool.query('SELECT * FROM klyd_settings LIMIT 1',(err,result)=>{
    if(err) throw err;
    res.send(result[0]);
  })
})

/**
 * PUT   /admin/settings
 * 设置所有的全局设置信息
 * 返回的数据
 * {sid:1,appName:'快乐一点',apiUrl:'http://127.0.0.1:8090',adminUrl:'http://127.0.0.1:8091',
 * appUrl:'http://127.0.0.1:8092',icp:'京ICP备 18016421号-1',copyright:'Copyright © 北京大内'}
 */
router.put('/',(req,res)=>{
  pool.query('UPDATE klyd_settings SET ?',req.body,(err,result)=>{
    if(err) throw err;
    res.send({code:200,msg:'settings updated succ'});
  })
})