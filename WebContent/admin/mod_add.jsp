<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@page import="com.sop.web.dao.DBDao" %>
<%@ include file="../_sessioncheck.jsp" %>
<%request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>添加MODEL</title>
<link href="css/bootstrap.min.css" type="text/css" rel="stylesheet"/>
<style type="text/css">
body{
	font-family: Verdana, Geneva, Arial, Helvetica, sans-serif;
	font-size: 11px;color:#666;background:#f6f6f6; overflow:hidden
}
</style>
</head>
<body>
<form action="${pageContext.request.contextPath}/AddModelServlet" method="post" class="form-horizontal">
<div style="margin-top:20px;">
<h6>MODEL管理-MODEL添加</h6>
</div>
<div class="control-group" style="margin-top:20px; margin-left:-50px;">
    <label class="control-label" for="inputEmail">Model名称：</label>
    <div class="controls">
      <input type="text" id="inputEmail" placeholder="Model名称" name="model_name">
    </div>
  </div>
  <div class="control-group" style="margin-left:-50px;">
    <label class="control-label" for="inputPassword">部门名称：</label>
    <div class="controls">
      <select name="group_id" id="group_id">
    				<!-- <option value=0>请选择您的 部门</option> -->
    				<sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
     					url="jdbc:mysql://192.168.126.242:3306/proc_sop?useUnicode=true&characterEncoding=utf-8"
     					user="iot"  password="Iot85228800#1"/>
     				<sql:query dataSource="${snapshot}" var="result">
	 					SELECT * FROM `group`;
					</sql:query>
	 				<c:forEach var="row" items="${result.rows}">
	 				<option value="${row.GROUP_ID}">${row.GROUP_NAME}</option>
	 				</c:forEach>
    				</select>
    </div>
  </div>
  <div class="control-group">
    <div class="controls">
      <button type="submit" class="btn btn-info">添加</button>
    </div>
  </div>
</form>
</body>
</html>