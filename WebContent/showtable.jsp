<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%
 Cookie c = new Cookie("isTrue","true");
 c.setMaxAge(50);
 response.addCookie(c);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link href="admin/css/bootstrap.min.css" type="text/css" rel="stylesheet"/>
<meta http-equiv="refresh" content="50">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>选择文件</title>
<script type="text/javascript" src="admin/js/jquery-1.8.3.min.js"></script>
<style>
		body{
			text-align:center;
			margin:0 auto;
			font-family:Microsoft YaHei,Verdana,Arial,SimSun;
			color:#666;
			font-size:14px;
			background:#f6f6f6;
			overflow:hidden;
			}
		.block, #block{
			display:block;
			}
</style>
</head>
<body>
	<br>
	<form name="form" >
	<sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
     url="jdbc:mysql://192.168.126.242:3306/proc_sop?useUnicode=true&characterEncoding=utf-8"
     user="iot"  password="Iot85228800#1"/>
    <sql:query dataSource="${snapshot}" var="result">
	SELECT MODEL_NAME,FILE_ID,FILE_NAME,FILE_VER,FILE_TIME from file a,model b where a.model_id=b.model_id and b.GROUP_ID = <%=request.getParameter("group_id")%>;
	</sql:query>
	<table border="0" width="100%"  id="table3" class="table table-striped">
	<tr>
   <th style="display:none">FILE_ID</th>
   <th>MODEL名称</th>
   <th>文件名称</th>
   <th>版本</th>
   <th>更新时间</th>
	</tr>
	<c:forEach var="row" items="${result.rows}">
	<tr onclick="fun(this)" align="right">
   <td  style="display:none"><c:out value="${row.FILE_ID}"/></td> 
   <td><c:out value="${row.MODEL_NAME}"/></td>
   <td><a href="javascript:void(0)"><c:out value="${row.FILE_NAME}"/></a></td>
   <td><c:out value="${row.FILE_VER}"/></td>
   <td><c:out value="${row.FILE_TIME}"/></td>
</tr>
</c:forEach>
</table>
</form>
</body>

 <script>

function fun(a)
{
	var value= $(a).children('td').eq(0).text();
	window.location.href="viewer.html?file=showpdf.jsp?"+value; 
}
</script>

</html>