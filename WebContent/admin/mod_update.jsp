<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ include file="../_sessioncheck.jsp" %> 
<%request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <title>更新MODEL</title>
    <link href="css/bootstrap.min.css" type="text/css" rel="stylesheet"/>
    <style type="text/css">
    	body{font-family: Verdana, Geneva, Arial, Helvetica, sans-serif;
			font-size: 11px;color:#666;background:#f6f6f6; overflow:hidden;
    	}
    </style>
  </head>

<body>
<form action="${pageContext.request.contextPath}/UpmodelServlet" method="post">
        <table align="left" width="450" style="margin-top:-20px;">
            <tr>
                <td align="left" colspan="2" style="margin-top:5px;">
                    <h5>MODEL管理-更新MODEL</h5>
                </td>
            </tr>
    				<sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
     					url="jdbc:mysql://192.168.126.242:3306/proc_sop?useUnicode=true&characterEncoding=utf-8"
     					user="iot"  password="Iot85228800#1"/>
     				<sql:query dataSource="${snapshot}" var="result">
	 					SELECT * from model a,`group` b where a.GROUP_ID=b.GROUP_ID AND a.MODEL_ID=<%=request.getParameter("mo_id")%>;
	 				</sql:query>
	 				<sql:query dataSource="${snapshot}" var="result1">
	 					SELECT * from `group`;
	 				</sql:query>
	 				<c:forEach var="row" items="${result.rows}">
            <tr>
                <td align="right">ID：</td>
                <td><input type="text" name="MODEL_ID" value="${row.MODEL_ID}" readonly="readonly"/></td>
            </tr> 
         	<tr>
                <td align="right">MODEL名称：</td>
                <td><input type="text" name="MODEL_NAME" value="${row.MODEL_NAME}"/></td>
            </tr>
	 				</c:forEach>
            <tr>
               <td align="right">部门名称：</td>
                <td>
                	<select name="GROUP_ID" id="GROUP_ID">	
	 				<c:forEach var="row1" items="${result1.rows}">
	 				<option value="${row1.GROUP_ID}">${row1.GROUP_NAME}</option>
            		</c:forEach>
	 				</select>
	 			</td>
            </tr>
            <tr>
                <td align="center" colspan="2">
                    <input type="submit" value="更新" class="btn btn-info">
                </td>
            </tr>
        </table>
    </form> 

</body>
</html>



