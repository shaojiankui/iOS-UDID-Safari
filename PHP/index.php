<?php
$UDID =  $_GET['UDID'] ? $_GET['UDID'] : $_POST['UDID'];
?>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
 <meta content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0,user-scalable=no" name="viewport" id="viewport" />
<title>获取您的UDID</title>
<style type="text/css">
body {
	margin: 0;
    padding: 0;
    color: #333;
    font-family: "Helvetica Neue",Helvetica,Arial,sans-serif;
    font-size: 14px;
    line-height: 1.42857;
}
#content {
	width:100%;
    padding: 0px 0;
	
}

#header{
	background-color: #1aa79a;
    height: 150px;
	margin: 0;
    padding: 0;
}
#footer{
	border-top: 1px solid #979797;
    font-family: "Roboto Slab","Helvetica Neue",Helvetica,"Hiragino Sans GB",Arial,sans-serif;
    margin-top: 50px;
    padding-bottom: 70px;
    padding-top: 30px;
    text-align: center;
}
.buttons{
	background: #1AA79A none repeat scroll 0 0;
    border: 1px solid #777;
    border-radius: 8px;
    box-shadow: 0 -1px 3px rgba(255, 255, 255, 0.5) inset, 0 2px 2px rgba(0, 0, 0, 0.2);
    color: #fff;
    cursor: pointer;
    font-family: "Microsoft Yahei",Arial,Tahoma,sans-serif;
    font-size: 14px;
    font-style: normal;
    font-weight: bold;
    padding: 8px 12px;
    text-decoration: none;
    text-shadow: -1px -1px rgba(0, 0, 0, 0.1), 0 0 15px rgba(255, 255, 255, 0.75);
    text-transform: none;
    white-space: nowrap;

}
</style>

<body>
<div id="header">
	 UDID
</div>
<div id="content">
<br><br><br>

UDID:<input style="width:300px;" name="" value="<?php echo $UDID;?>" /> 

<br><br><br>

<a class="buttons" href="udid.mobileconfig" target="_blank">1.点击获取您的UDID</a>

<br><br><br>

<!-- <a class="buttons" href="xxxapp://?function=valid&uuid=<?php echo $UDID;?>&secret=dhasdjh5521673hghdsah">2.验证ipa</a> -->

<br><br><br>

<img src="qr.png" width ="200">
	
</div>
<div id="footer">
@UDID
</div>
</body>
</html>