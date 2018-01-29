<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement" %>
<%@page import="com.sop.web.dao.DBDao" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ include file="../_sessioncheck.jsp" %>
<!-- 解决中文乱码的问题 -->
<%request.setCharacterEncoding("UTF-8"); %>
<%
    try{
        Connection conn=DBDao.getConnection();
        String sql="delete from model where MODEL_NAME = ?";
        PreparedStatement ps=conn.prepareStatement(sql);
        ps.setString(1,request.getParameter("model_name"));
        int count=ps.executeUpdate();
        if(count>=1){
        	response.sendRedirect("mod_search.jsp");
        }
        DBDao.close(null, ps, conn);
        }catch(Exception e ){
        	out.println("删除失败");
        }
	 	
      
%>   