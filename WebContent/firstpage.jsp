<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
 <%@ page contentType="text/html; charset=utf-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="com.sop.web.dao.DBDao" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
	//response.getWriter().print(request.getRemoteAddr());
	String ip = request.getRemoteAddr().toString();
	String[] realip =  ip.split("\\.");
	String matchip = realip[0]+"."+realip[1]+"."+realip[2];
	String queryString = request.getQueryString();  
	ResultSet rs = null;
	Connection con =null;
	con = DBDao.getConnection();
	String sql = "select * from ip where IP='"+matchip+"'";
	Statement stmt = con.createStatement();
	rs = stmt.executeQuery(sql);
	boolean count = rs.first();
	if(!count){
		response.sendRedirect("errorip.html");
	}   
	DBDao.close(rs, stmt, con); 
%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>部门</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
  	<link href="admin/css/display.css" type="text/css" rel="stylesheet"/>
  	<link href="admin/css/bootstrap.min.css" type="text/css" rel="stylesheet"/>
  	<link href="http://csdnimg.cn/www/images/favicon.ico" rel="SHORTCUT ICON">
	<style>
		body{text-align:center;margin:15 auto;font-family:Microsoft YaHei,Verdana,Arial,SimSun;color:#666;font-size:14px;background:#f6f6f6; overflow:hidden;}
		.block, #block{display:block;}
	</style>
	<script type="text/javascript">  
        var Sys = {};  
        var ua = navigator.userAgent.toLowerCase();  
        var s;  
        (s = ua.match(/msie ([\d.]+)/)) ? Sys.ie = s[1] :  
        (s = ua.match(/firefox\/([\d.]+)/)) ? Sys.firefox = s[1] :  
        (s = ua.match(/chrome\/([\d.]+)/)) ? Sys.chrome = s[1] :  
        (s = ua.match(/opera.([\d.]+)/)) ? Sys.opera = s[1] :  
        (s = ua.match(/version\/([\d.]+).*safari/)) ? Sys.safari = s[1] : 0;   
        if (Sys.firefox){
        	/* alert('欢迎使用Firefox访问 '); */
        }else{
        	/* alert('禁止访问 '); */
        	window.location.href="error.html"
        }
	</script>
  </head>
  <body>
  	<div class="top"></div>
	<div id="header">SOP文件系统</div>
	<div id="content">
    	<form action="showtable.jsp" name="form" method="get">
  			<!-- 	<h4>SOP文件系统</h4> -->
  			<br>
    		<select name="group_id" id="group_id">
    		<!-- <option value=0>请选择您的 部门</option>	 -->
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
 			<br>
    		<input type="submit" value="提交" class="btn">
    	</form>
   </div>
   <div class="bottom"></div>
   <div id="footer"><p>Copyright©江扬科技（无锡）有限公司  &nbsp;Version:1.1.7&nbsp; <a href="mailto:Jinguo.Li@mtigroup.com?subject=SOP系统%20问题" style="color:#32323a;" target="_blank">联系管理</a></p></div>
 </body>
</html>