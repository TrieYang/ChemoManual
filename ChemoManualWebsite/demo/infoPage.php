<?php
//先在include里打开config.php 设置自己的数据库名称，密码等设置好。
//使用方法说明，把mysql.php 包含进来，这样这里就可以使用mysql.php里面写好的所有函数了
include "include/mysql.php";
if (isset($_REQUEST['lastId'])) {
$lastId = $_REQUEST['lastId'];
    

//if(isset($_REQUEST['scid'])){
//    $scid = check_input_zs($_REQUEST['scid']);
//
//    if($scid != ""){
//        $sql="delete from post where id=" . $scid;
//        ExecuteNonQuery($sql);
//    }
//}
//这几句演示读出一条数据

$timeQuery = "select * from post where id = ".$lastId;  //这是一条查询语句
$data = Reader_one($timeQuery);//通过Reader_one查询到结果返回到变量数组$data
$time = $data['time'];
    



$sql = "select * from post WHERE time > '".$time."'";  //这是一条查询语句
    } else {
        $sql = "select * from post";
    }
$data = Reader($sql);//通过Reader_one查询到结果返回到变量数组$data
$items = array();
if($data) {//这里判断$data不是为空的话，就说明查到数据了
    //echo  "title=" . $data['title'] . $data['content']."<br>";//把查到的数据字段内容显示出来，
    while ($row = mysqli_fetch_assoc($data)) {//这个循环可以把查到的记录全部输出来
          array_push($items, $row);
    }
} else {
    echo "nothing was returned";
}

$json=json_encode($items);
echo $json;
?>
