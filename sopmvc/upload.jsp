<%@ page contentType="text/html; charset=utf-8"%>
<%@ page language="java" pageEncoding="UTF-8" import="java.sql.Statement" import="java.sql.*" %>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ include file="../_sessioncheck.jsp" %>

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
    <form action="${pageContext.request.contextPath}/UploadHandleServlet" enctype="multipart/form-data" method="post">
        <table align="left" width="450" style="margin-top:-20px;">
            <tr>
                <td align="left" colspan="2">
                    <h5>文件管理-发布文件</h5>
                </td>
            </tr>
            <tr>
                <td align="right">MODEL名称：</td>
                <td><select name="MODEL_ID" id="MODEL_ID">
    				<option value=0>请选择 MODEL</option>	
    				<sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
     					url="jdbc:mysql://192.168.126.242:3306/proc_sop?useUnicode=true&characterEncoding=utf-8"
     					user="iot"  password="Iot85228800#1"/>
     				<sql:query dataSource="${snapshot}" var="result">
	 					SELECT * from model;
	 				</sql:query>
	 				<c:forEach var="row" items="${result.rows}">
	 				<option value="${row.MODEL_ID}">${row.MODEL_ID},${row.MODEL_NAME}</option>
	 				</c:forEach>
	 				</select>
	 			</td>
            </tr>
           <tr>
                <td align="right">NUM：</td>
                <td><input type="text" name="FILE_NUM"/></td>
            </tr> 
            <tr>
                <td align="right">文件名称：</td>
                <td><input type="text" name="FILE_NAME"/></td>
            </tr>
            <tr>
                <td align="right">版本：</td>
                <td><input type="text" name="FILE_VER"/></td>
            </tr>
            <tr style="display:none">
                <td align="right">上传用户：</td>
                <td><input type="text" name="USER_ID" value="<%=request.getSession().getAttribute("username")%>"/></td>
            </tr> 
            <tr>
                <td align="right">上传文件：</td>
                <td><input type="file" name="file1"/></td>
            </tr> 
            <tr>
                <td align="center" colspan="2">
                    <input type="submit" value="发布" class="btn btn-info">
                </td>
            </tr>
        </table>
    </form>
  </body>
</html>