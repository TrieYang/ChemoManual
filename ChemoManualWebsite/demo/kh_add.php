

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
	<head>
		<title>Add post</title>
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
    <FORM action=kh_add.php method=post enctype="multipart/form-data">
<table width="100%" border="1" bgcolor="#FFFFFF" cellpadding="1" cellspacing="0" bordercolordark="#FFFFFF" bordercolorlight="#000000" height="100%">
  <tr> 
    <td colspan="2" bgcolor="#D4D0C8" height="28">&nbsp;</td>
  </tr>
  <tr> 
    <td width="27%" bgcolor="#D4D0C8"> 
      <div align="right">Title</div>
    </td>
    <td width="73%"> 
      <input type="text" name="title" size="30">
    </td>
  </tr>

  <tr> 
    <td width="27%" height="30" bgcolor="#D4D0C8"> 
      <div align="right">Content</div>
    </td>
    <td width="73%" height="30"> 
    <textarea name="content" cols="30" rows="10"></textarea>
    </td>
  </tr>
    
    <tr>
      <td width="27%" height="30" bgcolor="#D4D0C8">
        <div align="right">Image</div>
      </td>
      <td width="73%" height="30">
        <input type="file" name="file" id="file">
      </td>
    </tr>
    
    <tr>
      <td width="27%" height="30" bgcolor="#D4D0C8">
        <div align="right">Type</div>
      </td>
      <td width="73%" height="30">
    <select name="type">
      <option value="exercise">exercise</option>
      <option value="diet">diet</option>
      <option value="sleep">sleep</option>
    <option value="beauty">beauty</option>
    <option value="mental health">mental health</option>
    </select>
      </td>
    </tr>

  
  <tr bgcolor="#D4D0C8"> 
    <td colspan="2"> 
      <div align="center"> 
        <input type="submit" name="Submit" value="Add" >
        <input type="submit" name="Cancel" value="Cancel">
      </div>
    </td>
  </tr>
</table>
    </FORM>
</body>
</HTML>

    <?php
    include "include/mysql.php";



    
    
    if (!isset($_COOKIE["user_id"]) || !isset($_COOKIE["password"])) {
        header("Location: login.php");
        exit;
    } else if ($_COOKIE["password"] != md5($_COOKIE["user_id"]."30dkeuju#$@$.s")) {
        header("Location: login.php");
        exit;
    }
    

    if (isset($_POST['title']) && isset($_POST['content'])) {
        
        $title = check_input_zf($_POST['title']);
        $content = check_input_zf($_POST['content']);
        $type = check_input_zf($_POST['type']);
        echo $type;
        

        if ($_FILES["file"]["name"] == "" ) {
            $sql = "insert into post(title, content, type)values('".$title."','".$content."','".$type."')";
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
                    
                    // 判断当前目录下的 upload 目录是否存在该文件
                    // 如果没有 upload 目录，你需要创建它，upload 目录权限为 777
                    if (file_exists("upload/" . $_FILES["file"]["name"]))
                    {
                        echo $_FILES["file"]["name"] . " 文件已经存在。 ";
                    } else {
                        // 如果 upload 目录不存在该文件则将文件上传到 upload 目录下
                        $fileLocation = "upload/" . $_FILES["file"]["name"];
                        $fileLocation = wjm().$extension;
                        $sql = "insert into post(title, content, image, type)values('".$title."','".$content."','".$fileLocation."','".$type."')";
                        move_uploaded_file($_FILES["file"]["tmp_name"], "upload/" . $fileLocation);

                    }

                }
            }
            else
            {
                echo $_FILES["file"]["type"];
                echo "<script> alert('illegal file format') </script>";
                
            }
            
           
        }
        
        if (isset($sql)) {
            ExecuteNonQuery($sql);
            header("location: kh_list.php");
        }
        
        
    }
    
    ?>
