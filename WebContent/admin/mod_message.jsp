<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../_sessioncheck.jsp" %>
<!DOCTYPE HTML>
<html>
  <head>
    <title>消息提示</title>
  </head>
  
  <body>
        ${message}
        
    	<%response.setHeader("Refresh","2;url=admin/mod_search.jsp"); %> 
     <%--    <%response.sendRedirect("admin/search.jsp"); %>  --%>
  </body>
</html>