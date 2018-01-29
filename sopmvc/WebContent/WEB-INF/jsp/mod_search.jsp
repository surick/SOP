<%@ page contentType="text/html; charset=utf-8"%>
<%@ page language="java" pageEncoding="UTF-8" import="java.sql.Statement" import="java.sql.*" %>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link href="css/bootstrap.min.css" type="text/css" rel="stylesheet"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
body{
	font-family: Verdana, Geneva, Arial, Helvetica, sans-serif;
	font-size: 11px;color:#666;background:#f6f6f6; overflow:hidden;
}
</style>
<title>查询信息</title>
</head>
<body>
<sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
     					url="jdbc:mysql://192.168.126.242:3306/proc_sop?useUnicode=true&characterEncoding=utf-8"
     					user="iot"  password="Iot85228800#1"/>
  
<sql:query dataSource="${snapshot}" var="result">
SELECT * from model a,proc_sop.group b where a.GROUP_ID=b.GROUP_ID;
</sql:query>
<div style="margin-top:10px; margin-bottom:6px">
<a href="addModel.jsp" class="btn btn-info">添加MODEL</a>
</div>
<table border="0" width="100%" class="table table-hover">
<tr>
   <th>MODEL_ID</th>
   <th>MODEL名称</th>
   <th>部门</th>
   <th>操作</th>
</tr>
<c:forEach var="row" items="${result.rows}">
<tr>
   <td align="center"><c:out value="${row.MODEL_ID}"/></td>
   <td align="center"><c:out value="${row.MODEL_NAME}"/></td>
   <td align="center"><c:out value="${row.GROUP_NAME}"/></td>
   <td align="center"><a class="btn btn-danger" href="deleteModel.jsp?model_name=${row.MODEL_NAME}" onClick="return confirm('确定删除?');">删除</a> </td>
</tr>
</c:forEach>
</table>  
</body>
</html>