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
    <title>文件上传</title>
    <link href="css/bootstrap.min.css" type="text/css" rel="stylesheet"/>
    <style type="text/css">
    	body{font-family: Verdana, Geneva, Arial, Helvetica, sans-serif;
			font-size: 11px;color:#666;background:#f6f6f6; overflow:hidden;
    	}
    </style>
  </head>

<body>
<form action="${pageContext.request.contextPath}/UpdateServlet" enctype="multipart/form-data" method="post">
        <table align="left" width="450" style="margin-top:-20px;">
            <tr>
                <td align="left" colspan="2" style="margin-top:5px;">
                    <h5>文件管理-更新文件</h5>
                </td>
            </tr>
    				<sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
     					url="jdbc:mysql://192.168.126.242:3306/proc_sop?useUnicode=true&characterEncoding=utf-8"
     					user="iot"  password="Iot85228800#1"/>
     				<sql:query dataSource="${snapshot}" var="result">
	 					SELECT FILE_ID,FILE_NUM,FILE_NAME,FILE_VER,MODEL_NAME from model a,file b where a.MODEL_ID=b.MODEL_ID AND b.FILE_ID=<%=request.getParameter("fileid")%>;
	 				</sql:query>
	 				<c:forEach var="row" items="${result.rows}">
             <tr>
                <td align="right">ID：</td>
                <td><input type="text" name="FILE_ID" value="${row.FILE_ID}" readonly="readonly"/></td>
            </tr> 
            <tr>
                <td align="right">MODEL名称：</td>
                <td><select name="MODEL_ID" id="MODEL_ID" disabled>	
	 				<option value="${row.MODEL_ID}">${row.MODEL_NAME}</option>
	 				<%-- <option value="${row.MODEL_ID}">${row.MODEL_ID},${row.MODEL_NAME}</option> --%>
	 				</select>
	 			</td>
            </tr>
            <tr>
                <td align="right">NUM：</td>
                <td><input type="text" name="FILE_NUM" value="${row.FILE_NUM}"/></td>
            </tr> 
         	<tr>
                <td align="right">文件名称：</td>
                <td><input type="text" name="FILE_NAME" value="${row.FILE_NAME}"/></td>
            </tr>
            <tr>
                <td align="right">版本：</td>
                <td><input type="text" name="FILE_VER" value="${row.FILE_VER}"/></td>
            </tr>
	 				</c:forEach>
            <tr style="display:none">
                <td align="right">更新用户：</td>
                <td><input type="text" name="USER_ID" value="<%=request.getSession().getAttribute("username")%>"/></td>
            </tr> 
            <tr>
                <td align="right">更新文件：</td>
                <td><input type="file" name="file1"/></td>
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



