<html>
	<head>
		<title>Untitled Document</title>
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
window.open(url,"","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,copyhistory=yes,width=580,height=580,left=100,top=10");
}
	</SCRIPT>
	<body bgcolor="#666666" leftmargin="0" topmargin="0">
<table width="100%" border="1" bgcolor="#FFFFFF" cellspacing="0" cellpadding="5" bordercolordark="#FFFFFF" bordercolorlight="#000000">
  <tr> 
    <td colspan="6" bgcolor="#D4D0C8"> 
      <input type="text" name="textfield">
      <input type="submit" name="Submit" value="Search">
    <a href='kh_add.php'>
      <input type="submit" name="Submit2" value="Add post" >
    </a>
      
      <br>
    </td>
  </tr>

  <tr bgcolor="#D4D0C8"> 
    <td width="13%">
      <div align="center">Title</div>
    </td>
    <td width="33%">
      <div align="center">Content</div>
    </td>
    <td width="16%">
      <div align="center">Image</div>
    </td>
    <td width="16%">
      <div align="center">Type</div>
    </td>

    <td width="15%">
      <div align="center">Operation</div>
    </td>
  </tr>

    
    <?php
    include "include/mysql.php";
    
    if (!isset($_COOKIE["user_id"]) || !isset($_COOKIE["password"])) {
        header("Location: login.php");
        exit;
    } else if ($_COOKIE["password"] != md5($_COOKIE["user_id"]."30dkeuju#$@$.s")) {
        header("Location: login.php");
        exit;
    }
    
    if(isset($_REQUEST['scid'])){
        $scid = check_input_zs($_REQUEST['scid']);

        if($scid != ""){
            $result = Reader_one("select * from post where id=".$scid );
            if ($result) {
                if (!is_null($result["image"])) {
                $originalFile = $result["image"];
                unlink("upload/".$originalFile);
            }
            $sql="delete from post where id=" . $scid;
            ExecuteNonQuery($sql);
            
        }
    }
        }
    
    $sql = "select * from post order by id desc";
    $result = Reader($sql);
    
    if ($result && mysqli_num_rows($result)) {
            
            while ($row = mysqli_fetch_assoc($result)) {//这个循环可以把查到的记录全部输出来
                
                echo "<td width='13%'><a href='javascript:url1('kh_xx.htm')' target='_blank'>".$row['title']."</a></td>";
                echo "<td width='23%'>
                    <div align='left'><a href='javascript:url1('kh_xx.htm')'>".nl2br($row['content'])."</a></div>
                  </td>";
                if (isset($row['image'])) {
                    echo "<td width='33%'>
                    <div align='center'></div>
                  <img src=upload/".$row['image']." style = 'max-width: 80px'/>
                                      </div>
                  </td>";
                } else {
                                            echo "<td width='33%'>
                                            <div align='center'><a href='javascript:url1('kh_xx.htm')'> no image </a></div>
                                          </td>";
                }
                echo "<td width='10%'>
                    <div align='left'><a href='javascript:url1('kh_xx.htm')'>".nl2br($row['type'])."</a></div>
                  </td>";
                echo "<td width='15%'>
                    <div align='center'>
<a href='kh_update.php?updateId=".$row['id']."'>update</a>
<a href='kh_list.php?scid=".$row['id']."'>delete</a>
                </div>
                  </td>
                </tr>";
            }
    
            } else {
            echo '没有查询到任何数据';
    }
    ?>

  <tr bgcolor="#D4D0C8"> 
    <td colspan="6">&nbsp;</td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
			<tr>
				
    <td width="86%" valign="top"> 
      <div align="center"></div>
    </td>
			</tr>
		</table>
	</body>
</html>
