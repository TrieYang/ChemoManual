

<?php
date_default_timezone_set('Asia/Shanghai');

?>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
	<head>
		<title>Update Post</title>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
	</head>
	<style type="text/css">
		<!--
td {  font-size: 9pt}
.dx { border-left-width: 1; border-right-width: 1; border-top-width: 1; border-bottom-style: dotted; border-bottom-width: 1}
a:hover {  font-size: 9pt; color: #000000; text-decoration: none}
a:active {  font-size: 9pt; line-height: normal; color: #000000; text-decoration: none}
a:link {  font-size: 9pt; color: #000000; text-decoration: none}
a:visited {  font-size: 9pt; color: #000000; text-decoration: none}
--></style>
	<script src="buttons_1.js" type="text/javascript"></script>
	<SCRIPT language="javascript">
function url(url){
window.open(url,"","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no,copyhistory=yes,width=600,height=370,left=200,top=10");
}
function url1(url){
window.open(url,"","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,copyhistory=yes,width=680,height=380,left=100,top=10");
}
	</SCRIPT>
	<body bgcolor="#666666" leftmargin="0" topmargin="0">
    <?PHP
    include "include/mysql.php";
    if(isset($_REQUEST['updateId'])){
        $id = $_REQUEST['updateId'];
        echo "<FORM action=kh_update.php?updateId=".$id." method=post enctype='multipart/form-data'>";}
        ?>
    
<table width="100%" border="1" bgcolor="#FFFFFF" cellpadding="1" cellspacing="0" bordercolordark="#FFFFFF" bordercolorlight="#000000" height="100%">
  <tr> 
    <td colspan="2" bgcolor="#D4D0C8" height="28">&nbsp;</td>
  </tr>
    
    <?PHP
    
    if(isset($_REQUEST['updateId'])){
        $id = $_REQUEST['updateId'];

        if($id != ""){
            $sql="select * from post where id=" . $id;
            $data = Reader_one($sql);
            if ($data) {
                if (!is_null($data["image"])) {
                $originalFile = $data["image"];
                    }
                echo "<tr>
      <td width='17%' bgcolor='#D4D0C8'>
      <div align='right'>Title</div>
      </td>
      <td width='83%'>
      <input type='text' name='title' size='30' value='".$data['title']."' >
    </td>
    </tr>
    
    <tr>
    <td width='27%' height='30' bgcolor='#D4D0C8'>
      <div align='right'>Content</div>
    </td>
    <td width='73%' height='30'>
    <textarea name='content' cols='30' rows='10'>".$data['content']."</textarea>
    </td>
  </tr>

      <tr>
        <td width='27%' height='30' bgcolor='#D4D0C8'>
          <div align='right'>Type</div>
        </td>
        <td width='73%' height='30'>
      <select name='type'>
        <option value='exercise'";
                
                if ($data['type'] == 'exercise') {
                    echo "selected";
                }
                
                echo ">exercise</option>
        <option value='diet' ";
                
                if ($data['type'] == 'diet') {
                    echo "selected";
                }
                
                echo ">diet</option>
        <option value='sleep'";
                
                if ($data['type'] == 'sleep') {
                    echo "selected";
                }
                echo ">sleep</option>
      <option value='beauty'";
                if ($data['type'] == 'beauty') {
                    echo "selected";
                }
                echo ">beauty</option>
      <option value='mental health'";
                if ($data['type'] == 'mental health') {
                    echo "selected";
                }
                echo ">mental health</option>
      </select>
        </td>
      </tr>
";
                }
            
            
        }
    }
    ?>
    

    <tr>
      <td width="27%" height="30" bgcolor="#D4D0C8">
        <div align="right">Image</div>
      </td>
      <td width="73%" height="30">
        <input type="file" name="file" id="file">
    
    <div align="left">Delete your image
    <input type="checkbox" name="delete" id = "delete" value = "1">
    </div>
   
    </tr>

  
  <tr bgcolor="#D4D0C8"> 
    <td colspan="2"> 
      <div align="center"> 
        <input type="submit" name="Submit" value="update" >
        <input type="submit" name="Cancel" value="cancel">
      </div>
    </td>
  </tr>
</table>
    </FORM>
</body>
</HTML>

    <?php

    if (!isset($_COOKIE["user_id"]) || !isset($_COOKIE["password"])) {
        header("Location: login.php");
        exit;
    } else if ($_COOKIE["password"] != md5($_COOKIE["user_id"]."30dkeuju#$@$.s")) {
        header("Location: login.php");
        exit;
    }
    
    
    $date = new DateTime();

    if (isset($_POST['title']) && isset($_POST['content'])) {
        
        $title = check_input_zf($_POST['title']);
        $content = check_input_zf($_POST['content']);
        $type = check_input_zf($_POST['type']);
        
        
            # no pic is uploaded
        if ($_FILES["file"]["name"] == "") {
            
            if (!isset($_POST['delete'])) {
                #original picture exists, stays unmodified
                $sql = "update post set title = '".$title."',Content = '".$content."', time = '".$date->format('Y-m-d H:i:s')."', type = '".$type."' WHERE id = ".$id;
            } else {
                #original picture exists, deletes it
                $sql = "update post set title = '".$title."',Content = '".$content."', image = Null, time = '".$date->format('Y-m-d H:i:s')."', type = '".$type."' where id = ".$id;
            }
            
           
            # new pic uploaded
        } else {
            // 允许上传的图片后缀
            $allowedExts = array("gif", "jpeg", "jpg", "png");
            $temp = explode(".", $_FILES["file"]["name"]);
            echo $_FILES["file"]["size"];
            echo $_FILES["file"]["type"];
            $extension = strtolower(end($temp));     // 获取文件后缀名
            if ((($_FILES["file"]["type"] == "image/gif")
            || ($_FILES["file"]["type"] == "image/jpeg")
            || ($_FILES["file"]["type"] == "image/jpg")
            || ($_FILES["file"]["type"] == "image/pjpeg")
            || ($_FILES["file"]["type"] == "image/x-png")
            || ($_FILES["file"]["type"] == "image/png"))
            && ($_FILES["file"]["size"] < 8048000)   // 小于 200 kb
            && in_array($extension, $allowedExts))
            {
                if ($_FILES["file"]["error"] > 0)
                {
                    echo "错误：: " . $_FILES["file"]["error"] . "<br>";
                }
                else
                {
                    echo "上传文件名: " . $_FILES["file"]["name"] . "<br>";
                    echo "文件类型: " . $_FILES["file"]["type"] . "<br>";
                    echo "文件大小: " . ($_FILES["file"]["size"] / 1024) . " kB<br>";
                    echo "文件临时存储的位置: " . $_FILES["file"]["tmp_name"] . "<br>";
                    
               
                        // upload file if file doesn't already exists
                        // delete the original file in the folder if it exists
                        if (isset($originalFile)) {
                            unlink("upload/".$originalFile);
                        }
                        
                    
                    
                    $fileLocation = "upload/" . $_FILES["file"]["name"];
                    $fileLocation = wjm().$extension;
                    echo $fileLocation;
                    $sql = "update post set title = '".$title."', content = '".$content."', image = '".$fileLocation."', time = '".$date->format('Y-m-d H:i:s')."', type = '".$type."' where id = ".$id;
                    echo $sql;
                    move_uploaded_file($_FILES["file"]["tmp_name"], "upload/" . $fileLocation);
                    
    

                }
            }
            else
            {
                echo $_FILES["file"]["type"];
                echo "<script> alert('非法的文件格式') </script>";
            }
            
           
        }
        
        
        
        if (isset($sql)) {
            ExecuteNonQuery($sql);
            header("location: kh_list.php");
        }
        
        
    }
    
    ?>
