<%--
  Created by IntelliJ IDEA.
  User: jakey
  Date: 15/7/17
  Time: 下午9:23
  To change this template use File | Settings | File Templates.
--%>
<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>--%>
<%@ page import="java.util.*" %>

<%@ page language="java" import="java.util.Map" contentType="text/html; charset=UTF-8"%>

<%
    String UDID=(String)request.getParameter("UDID");

    response.sendRedirect("http://192.168.1.106:8080/udid");

%>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0,user-scalable=no" name="viewport" id="viewport" />
    <title>获取您的UDID</title>


<body>
<div id="header">
    UDID
</div>
<div id="content">
    <br><br><br>

    UUDI:<input style="width:300px;" name="" value="<%=UDID %>"  />

    <br><br><br>

    <a class="buttons" href="udid.mobileconfig" target="_blank">点击获取您的UDID</a>

    <br><br><br>

    <a class="buttons" href="d-cars://?function=valid&uuid=<?php echo $UDID;?>&secret=dhasdjh5521673hghdsah">验证ipa</a>

    <br><br><br>

    <img src="qr.png" width ="200">

</div>
<div id="footer">
    @UDID
</div>
</body>
</html>