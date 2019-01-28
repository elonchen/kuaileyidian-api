/**
 * 
 */
// 创建路由器
const express=require('express');
const pool=require('../../pool');
var router=express.Router();
module.exports=router;

/**
 * API: get/admin/category
 * 含义：客户端获取所有的菜品类别，按编号的升序排列
 * 返回值形如
 * [{cid:1,cname:'...'},{...}]
 */
router.get('/',(req,res)=>{
  pool.query('SELECT * FROM klyd_category ORDER BY cid',(err,result)=>{
    if(err) throw err;
    res.send(result);
  })
})

 /**
 * API: DELETE /admin/category/:cid
 * 含义：根据便是菜品编号的路由参数，删除该菜品
 * 返回值形如
 * {code:200,msg:'1 category deleted'}
 * {code:400,msg:'0 category deleted'}
 */
router.delete('/:cid',(req,res)=>{
  // 注意删除菜品类别前需要先把属于该类别的菜品的类别编号设置为null
  pool.query('UPDATE klyd_dish SET categoryId=NULL WHERE categoryId=?',req.params.cid,(err,result)=>{
    if(err) throw err;
    // 至此指定类别的菜品已经修改完毕
    pool.query('DELETE FROM klyd_category WHERE cid=?',req.params.cid,(err,result)=>{
      if(err) throw err;
      // 获取DELETE语句在数据库中影响的行数
      if(result.affectedRows>0){
        res.send({code:200,msg:'1 category deleted'});
      }else{
        res.send({code:400,msg:'0 category deleted'});
      }
    })
  })
})

 /**
 * API: POST/admin/category   非幂等
 * 请求参数：{cname:'xxx'}
 * 含义：添加新的菜品类别
 * 返回值形如
 * {code:200,msg:'1 category added',cid:x}
 */
router.post('/',(req,res)=>{
  console.log('获取到请求数据：');
  var data=req.body;     //形如{cname:'xxx'}
  pool.query('INSERT INTO klyd_category SET ?',data,(err,result)=>{
    if(err) throw err;
    if(result.affectedRows>0){
      res.send({code:200,msg:'1 category added'});
    }else{
      res.send({code:400,msg:'0 category added'});
    }
  })
})
  
 /**
 * API: PUT/admin/category
 * 请求参数：{cid:xx,cname:'xxx'}
 * 含义：根据菜品类别编号修改该类别
 * 返回值形如
 * {code:200,msg:'1 category modified'}
 * {code:400,msg:'0 category modified, not exists'}
 * {code:401,msg:'0 category modified, no modification'}
 */
router.put('/',(req,res)=>{
  var data=req.body;//请求数据{cid:xx,cname:'xx'}
  //todo:此处可以对数据进行验证
  pool.query('UPDATE klyd_category SET ? WHERE cid=?',[data,data.cid],(err,result)=>{  
    //console.log(result.data);
    if(err) throw err;
    if(result.changedRows>0){  //实际更改了一行,  改变
      res.send({code:200,msg:'1 category modified'});
    }else if(result.affectedRows==0){
      res.send({code:400,msg:'category not exits'});
    }else if(result.affectedRows==1&&result.changedRows==0){  //影响到一行，更改了0行  改变changedRows 更改的行数
      res.send({code:401,msg:'no category modified'});
    }
  })
})