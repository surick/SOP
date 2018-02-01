<%@ page contentType="text/html; charset=utf-8"%>
<%@ page language="java" import="java.sql.Statement" import="java.sql.*" %>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="com.sop.web.dao.DBDao" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%
	Cookie[] cookie1 = request.getCookies();
	for (Cookie cook1 : cookie1) {
		if("isTrue".equals(cook1.getName())){
			//String file_id = cook1.getValue() != null ? cook1.getValue() : request.getQueryString();  
			String file_id = request.getQueryString();
			String ip = request.getRemoteAddr();
			Connection con =null;
			ResultSet rs =null;
			con = DBDao.getConnection();
			Statement stmt = con.createStatement();
			String sql1 = "insert into log(COMPUTER_IP,FILE_ID) values ('" + ip + "','"+file_id+"')"; 
			stmt.executeUpdate(sql1);
			String sql ="select FILE_URL,FILE_VER,FILE_ID from file where FILE_ID="+file_id+"";
			rs = stmt.executeQuery(sql);
			rs.next();
			byte[] bs = rs.getBytes("FILE_URL");
			request.getSession().setAttribute("ver", rs.getString("FILE_VER"));
			request.getSession().setAttribute("id", rs.getString("FILE_ID"));
	
			// 改成PDF类型 application/pdf;charset=UTF-8
			response.setContentType("application/pdf;charset=UTF-8");
			response.setHeader( "Pragma", "no-cache" );   
			response.setDateHeader("Expires", 0);   
			response.addHeader( "Cache-Control", "no-cache" ); // 浏览器和缓存服务器都不应该缓存页面信息
	
			response.getOutputStream().write(bs);  
			DBDao.close(rs, stmt, con);
		}
	}
%>