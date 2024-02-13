<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
<HTML xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE>ChemoManual App Manager</TITLE>
<META http-equiv=Content-Type content="text/html; charset=UTF-8">
<STYLE type=text/css>BODY {
	MARGIN: 0px
}
td {  font-size: 9pt}
a:active {  font-size: 9pt; color: #000000; text-decoration: none}
a:hover {  font-size: 9pt; color: #000000; text-decoration: none}
a:link {  font-size: 9pt; color: #000000; text-decoration: none}
a:visited {  color: #000000; text-decoration: none}
</STYLE>
<LINK href="images/css11.css" type=text/css rel=stylesheet>
<META content="MSHTML 6.00.3790.1830" name=GENERATOR>
</HEAD>
<BODY>
<TABLE style="MARGIN-TOP: 70px" height=128 cellSpacing=0 cellPadding=0 
width="100%" background=images/021_04.jpg border=0>
  <TBODY>
  <TR>
    <TD>
      <TABLE style="MARGIN-LEFT: 230px" cellSpacing=0 cellPadding=0 width="48%" 
      border=0>
        <TBODY>
        <TR>
          <TD width="33%"><IMG height=128 src="images/01_03.jpg" 
          width=171></TD>
          <TD width="5%">&nbsp;</TD>
          <TD width="62%"><IMG height=128 alt="" src="images/01_05.jpg" 
            width=291></TD></TR></TBODY></TABLE></TD></TR></TBODY></TABLE>
<FORM action=login.php method=post>
  <TABLE height=128 cellSpacing=0 cellPadding=0 width="100%" border=0>
  <TBODY>
  <TR>
    <TD vAlign=top>
      <TABLE cellSpacing=3 cellPadding=0 width="48%" align=center border=0>
        <TBODY>
        <TR>
          <TD width="39%">&nbsp;</TD>
          <TD width="61%" height=30><IMG alt="" 
        src="images/01_09.jpg"></TD></TR>
        <TR>
          <TD class=td01 align=right>username：</TD>
          <TD height=30><INPUT class=ii name=username style="WIDTH: 127px"></TD></TR>
        <TR>
          <TD align=right>
            <P class=td01>password：</P></TD>
          <TD height=30><INPUT class=ii type=password name=password style="WIDTH: 127px">
            </TD>
          </TR>
        <TR>
          <TD align=right>&nbsp;</TD><!--<td height="30"><a href="#"><img src="images/01_13.jpg" alt="" width="67" height="20" border="0" /></a> <a href="#"><img src="images/01_15.jpg" alt="" width="67" height="20" border="0" /></a></td>-->
            <TD> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
              <input type="image" border="0" name="imageField" src="images/01_13.jpg" width="67" height="20" align="middle">
              &nbsp;&nbsp;&nbsp; </TD>
          </TR></TBODY></TABLE></TD></TR></TBODY></TABLE></FORM>
<TABLE style="MARGIN-TOP: 30px" height=58 cellSpacing=0 cellPadding=0 
width="100%" border=0 ?>
  <TBODY>
  <TR>
    <TD class=td02 vAlign=bottom align=middle background=images/botten.jpg 
    bgColor=#f8fcff>
      <TABLE cellSpacing=0 cellPadding=0 width="35%" border=0 align="center">
        <TBODY> 
        <TR>
          <TD width="93%">
            <div align="center"><a href="http://www.q88.net">Created and designed by Trie Yang</a></div>
          </TD>
        </TR></TBODY></TABLE></TD></TR></TBODY></TABLE></BODY></HTML>


<?php
include "include/mysql.php";


if (isset($_POST['username']) && isset($_POST['password'])) {

$username = check_input_zf($_POST['username']);
$password = check_input_zf($_POST['password']);
$sql = "select * from user where  username = '" . $username . "'";  //这是一条查询语句
$data = Reader_one($sql);//通过Reader_one查询到结果返回到变量数组$data
if($data) {//这里判断$data不是为空的话，就说明查到数据了
    if ($data["password"] == $password) {
        $user_id = $data["id"];
        $password = md5($data["id"]."30dkeuju#$@$.s");
        setcookie("user_id", $user_id, time()+3600, '/');
        setcookie("password", $password, time()+3600, '/');
        header("location: kh_list.php");
    } else {
        echo "<script> alert('密码无效') </script>";
    }
} else {
    echo "<script> alert('此用户名未注册') </script>";

    }
    }


?>
