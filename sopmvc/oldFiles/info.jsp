<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../_sessioncheck.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>info</title>
<link href="css/bootstrap.min.css" type="text/css" rel="stylesheet"/>
<style>
body{text-align:center;margin:0 auto;font-family:Microsoft YaHei,Verdana,Arial,SimSun;color:#666;font-size:14px;background:#f6f6f6; overflow:hidden
    }
</style>
</head>
<body>
<p align="left" style="margin-top:10px;" class="text-info"><strong>欢迎您:</strong><span class="text-error"><em><%= request.getSession().getAttribute("username") %></em></span></p>
<table border="0" width="100%" class="table table-hover">
<tr>
   <th>服务器名</th>
   <th>服务器IP</th>
   <th>服务端口</th>
</tr>
<tr class="success">
   <td align="center"><%=request.getLocalName() %></td>
   <td align="center"><%=request.getLocalAddr() %></td>
   <td align="center"><%=request.getLocalPort() %></td>
</tr>
<tr>
   <th>访问IP</th>
   <th>运行环境</th>
   <th>访问协议</th>
</tr>
<tr class="error">
   <td align="center"><%=request.getRemoteHost() %></td>
   <td align="center">JSP</td>
   <td align="center"><%=request.getProtocol() %></td>
</tr>
</table>  
</body>
</html>