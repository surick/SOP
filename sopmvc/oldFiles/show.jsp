<%@ page contentType="text/html; charset=gb2312"%>
<%@ page language="java" import="java.sql.Statement" import="java.sql.*" %>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="com.sop.web.dao.DBDao" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ include file="../_sessioncheck.jsp" %>
<%
String file_id = request.getParameter("fileid");
Connection con =null;
ResultSet rs =null;
con = DBDao.getConnection();
Statement stmt = con.createStatement();
String sql ="select FILE_URL from file where FILE_ID="+file_id+"";
rs = stmt.executeQuery(sql);
rs.next();
byte[] bs = rs.getBytes("FILE_URL");
//�ĳ�PDF���� application/pdf;charset=UTF-8
response.setContentType("application/pdf;charset=UTF-8");
response.setHeader( "Pragma", "no-cache" );   
response.setDateHeader("Expires", 0);   
response.addHeader( "Cache-Control", "no-cache" );//������ͻ������������Ӧ�û���ҳ����Ϣ
response.addHeader( "Cache-Control", "no-store" );//�������Ӧ����Ϣ����Ӧ�ñ��洢�ڶԷ��Ĵ���ϵͳ�У�    
response.addHeader( "Cache-Control", "must-revalidate" );
Cookie c = new Cookie("livetime","alive");
c.setMaxAge(500);
response.addCookie(c);
response.getOutputStream().write(bs);  
DBDao.close(rs, stmt, con);
%>