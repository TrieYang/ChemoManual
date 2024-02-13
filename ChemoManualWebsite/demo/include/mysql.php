<?php
   include 'config.php';
   //这个函数实现插入数据
   function ExecuteNonQuery($sql){

       $conn = mysqli_connect(DB_HOST, DB_USER, DB_PWD, DB_NAME);
       // if connect fail echo error
   	   if (mysqli_connect_errno()) {
   				echo mysqli_connect_error();
					exit;
			 }

       mysqli_set_charset($conn, DB_CHARSET);
       $result = mysqli_query($conn, $sql);
       if ($result) {
   				//echo '成功';
				} else {
   			//echo '失败';
           rz("error $sql" . "\n");
           exit;
			 }
			 //echo '新增加ID' . mysqli_insert_id($conn);
			 $id=mysqli_insert_id($conn);
       mysqli_close($conn);

       //echo "id=".$id;
       //echo "user1=".DB_USER;
       return $id;
   }




  //这个函数实现查询返回一个数据集
   function Reader($sql){
   			$conn = mysqli_connect(DB_HOST, DB_USER, DB_PWD, DB_NAME);
            if (mysqli_connect_errno()) {
                echo mysqli_connect_error();
                exit;
            }

				mysqli_set_charset($conn, DB_CHARSET);
				$result = mysqli_query($conn, $sql);
				if ($result) {
   				//echo '成功';
				} else {
                    rz("error $sql" . "\n");
                    exit;
   			//echo '失败';
			  }
			  mysqli_close($conn);
				return $result;
   }

   //这个查询返回一条数据
    function Reader_one($sql){
        $conn = mysqli_connect(DB_HOST, DB_USER, DB_PWD, DB_NAME);
        if (mysqli_connect_errno()) {
            echo mysqli_connect_error();
            exit;
        }

        mysqli_set_charset($conn, DB_CHARSET);
        $result = mysqli_query($conn, $sql);
        if ($result) {
            //echo '成功';
        } else {
            //echo '失败';

            rz("error Reader_one $sql" . "\n");
            exit;
        }
        mysqli_close($conn);
        $data = mysqli_fetch_assoc($result);
        if($result){
            //echo "释放";
            mysqli_free_result($result);
        }
        return $data;
    }

   

   
    //用来检查输入的数据是不是一个整数字
    function check_input_zs($value){
        if(strlen($value)>0){ //if(!empty($value)){
            $sz = intval($value);
            //echo "\$sz=".$sz."sz=".$value;
            if(strval($sz) == $value){
                return $sz;
            }else{
                exit('err1');
                return "1";
            }
        }else{
            return "";
        }
    }

   
 //用来检查
    function check_input_xs($value){
        if(strlen($value)>0){ //if(!empty($value)){
            $sz = floatval($value);
            //echo "\$sz=".$sz."sz=".$value;
            if(strval($sz) == $value){
                return $sz;
            }else{
                exit('err1');
                return "1";
            }
        }else{
            return "";
        }
    }



    function inject_check($sql_str)
    {
            //return preg_match('/^select|insert|and|or|create|update|delete|alter|count|\'|\/\*|\*|\.\.\/|\.\/|union|into|load_file|outfile/i', $sql_str); // 进行过滤
            return preg_match('/^select|select|insert|and|or|create|update|delete|alter|count|\/\*|\.\.\/|\.\/|union|into|load_file|outfile/i', $sql_str); // 进行过滤
     }

    //对一个字符串进行检查
    function check_input_zf($value){

//       if(inject_check($value)){
//           exit('err3');
//       }

       $zf=str_replace("'","''",$value);
       $zf=str_replace("$","",$zf);
       $zf=str_replace("%","",$zf);
       return $zf;

    }



    function check_input($value)
    {
        // 去除斜杠
        if (get_magic_quotes_gpc())
        {
            $value = stripslashes($value);
        }

        // 如果不是数字则加引号
        if (!is_numeric($value))
        {
            $value = “‘” . mysql_real_escape_string($value) . “‘”;
        }
        return $value;

    }

    function wjm(){
        $hash="CR-";
        //定义一个包含大小写字母数字的字符串
        $chars="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        //把字符串分割成数组
        $newchars=str_split($chars);
        //打乱数组
        shuffle($newchars);
        //从数组中随机取出15个字符
        $chars_key=array_rand($newchars,15);
        $fnstr="";
        //把取出的字符重新组成字符串
        for($i=0;$i<15;$i++){
            $fnstr.=$newchars[$chars_key[$i]];
        }
        //输出文件名并做MD5加密
        //echo $hash.md5($fnstr.time().microtime()*1000000);
        return($hash.md5($fnstr.time().microtime()*1000000).'.');

    }



    function checkTime($data)
    {

        if (empty(strtotime($data))) {

            return false;

        } else {

            return true;

        }
    }

    function rz($nn){

        error_log($nn . PHP_EOL, 3, LOG_PATH);


    }

function encrypt($string,$operation,$key='')
{
    //使用方法
//    $id = 132;
//    $token = encrypt($id, 'E', 'nowamagic');
//    echo '加密:'.encrypt($id, 'E', 'nowamagic');
//    echo '<br />';
//    echo '解密：'.encrypt($token, 'D', 'nowamagic');
//
    $key=md5($key);
    $key_length=strlen($key);
    $string=$operation=='D'?base64_decode($string):substr(md5($string.$key),0,8).$string;
    $string_length=strlen($string);
    $rndkey=$box=array();
    $result='';
    for($i=0;$i<=255;$i++)
    {
        $rndkey[$i]=ord($key[$i%$key_length]);
        $box[$i]=$i;
    }
    for($j=$i=0;$i<256;$i++)
    {
        $j=($j+$box[$i]+$rndkey[$i])%256;
        $tmp=$box[$i];
        $box[$i]=$box[$j];
        $box[$j]=$tmp;
    }
    for($a=$j=$i=0;$i<$string_length;$i++)
    {
        $a=($a+1)%256;
        $j=($j+$box[$a])%256;
        $tmp=$box[$a];
        $box[$a]=$box[$j];
        $box[$j]=$tmp;
        $result.=chr(ord($string[$i])^($box[($box[$a]+$box[$j])%256]));
    }
    if($operation=='D')
    {
        if(substr($result,0,8)==substr(md5(substr($result,8).$key),0,8))
        {
            return substr($result,8);
        }
        else
        {
            return'';
        }
    }
    else
    {
        return str_replace('=','',base64_encode($result));
    }
}












function cookie_clear(){
    foreach ($_COOKIE as $c=>$v) {
        //setcoolie($c,'',-1);
        setcookie ( $c, null, time() - 100 );
    }

}


?>
