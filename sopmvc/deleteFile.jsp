<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement" %>
<%@page import="com.sop.web.dao.DBDao" %>
<%@ include file="../_sessioncheck.jsp" %> 
<!-- 解决中文乱码的问题 -->
<%request.setCharacterEncoding("UTF-8"); %>

	 <%
	/*  response.getWriter().print(request.getParameter("fileid")); */
    try{
        
        Connection conn=DBDao.getConnection();
        String sql="delete from file where FILE_ID = ?";
        PreparedStatement ps=conn.prepareStatement(sql);
        ps.setString(1,request.getParameter("fileid"));
        int count=ps.executeUpdate();
        if(count>=1){
        		
        		response.sendRedirect("search.jsp");
        }
       	DBDao.close(null, ps, conn);
        }catch(Exception e ){
        	out.println("删除失败");
        }
	 	
      
	%> 