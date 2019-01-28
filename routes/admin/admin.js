const express=require('express');
const pool=require('../../pool');
var router=express.Router();
module.exports=router;

/**
 * API   GET/admin/login
 * 请求数据：{aname:'xxx',apwd:'xxx'}
 *完成用户登录验证(提示：有的项目洗出香泽Post)
 *返回数据：
 *{code:200,msg:'login succ'}
 *{code:400,msg:'aname or apwd err'}
 */
router.get('/login/:aname/:apwd',(req,res)=>{
  //console.log(req.body);
  var aname=req.params.aname;
  var apwd=req.params.apwd;
  // 需要对用户输入的密码执行加密函数
  pool.query('SELECT aid FROM klyd_admin WHERE aname=? AND apwd=PASSWORD(?)',[aname,apwd],(err,result)=>{
    if(err) throw err;
    if(result.length>0){//查询到一行数据，登录成功
      res.send({code:200,msg:'login succ'});
    }else{//没有查询到数据
      res.send({code:400,msg:'aname or apwd err'});
    }
  })
})


 /**
 * API   PATCH/admin/login
 * 请求数据：{aname:'xxx',oldPwd:'xxx',newPwd:'xxx'}
 *根据管理员名和密码修改管理员密码
 *返回数据：
 *{code:200,msg:'modified succ'}
 *{code:400,msg:'aname or apwd err'}
 *{code:401,msg:'apwd not modified'} 
 */
router.patch('/',(req,res)=>{
  var data=req.body;  //{aname:'',oldPwd:'',newPwd:''}
  //console.log(data);
  // 首先根据aname/oldPwd查询该用户是否存在
  //如果查询到了用户，再修改其密码
  pool.query('SELECT aid FROM klyd_admin WHERE aname=? AND apwd=PASSWORD(?)',[data.aname,data.oldPwd],(err,result)=>{
    if(err) throw err;
    if(result.length==0){
      res.send({code:400,msg:'password err'});
      return;
    }
    // 如果查新到了用户，再修改其密码
    pool.query('UPDATE klyd_admin SET apwd=PASSWORD(?) WHERE aname=?',[data.newPwd,data.aname],(err,result)=>{
      if(err) throw err;
      if(result.changedRows>0){//密码修改完成
        res.send({code:200,msg:'modify succ'});
      }else{//新旧密码一样， 未做修改
        res.send({code:401,msg:'pwd not modified'});
      }
    })
  })
})
