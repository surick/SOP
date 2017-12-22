<%@ page contentType="text/html; charset=utf-8"%>
<%@ page language="java" pageEncoding="UTF-8" import="java.sql.Statement" import="java.sql.*" %>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="com.sop.web.dao.DBDao" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<style>
*{
	font-size:14px;
}
a:link{
	color:red;
	text-decoration:none;
}
</style>
<%	
	Cookie c0 = new Cookie("isTrue","true");
	c0.setMaxAge(50);
	response.addCookie(c0);
	Cookie c1 = new Cookie("livetime","alive");
	c1.setMaxAge(50);
	response.addCookie(c1);
	Connection con =null;
	ResultSet rs =null;
	con = DBDao.getConnection();
	Statement stmt = con.createStatement();
	String id = (String)session.getAttribute("id");
	String ver = (String)session.getAttribute("ver");
	String sql = "select FILE_VER from file where FILE_ID="+id+"";
	rs = stmt.executeQuery(sql);
	rs.next();
	String new_ver = rs.getString("FILE_VER");
	
	//response.getWriter().print("当前页面版本"+ver);
	//response.getWriter().print("当前页面版本"+new_ver);
	if(!ver.equals(new_ver)){
		response.getWriter().println("数据库已更新版本:"+new_ver+"!");
		response.getWriter().write("<br><a href='javascript:void(0)' onclick='javascript:history.go(0)'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;请重新获取</a>");
		
	} 
	
	DBDao.close(rs, stmt, con);
	
%>