<%@ page contentType="text/html; charset=utf-8"%>
<%@ page language="java" pageEncoding="UTF-8" import="java.sql.Statement" import="java.sql.*" %>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="com.sop.web.dao.DBDao" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>
<%@ include file="../_sessioncheck.jsp" %>
<%
Connection con =null;
ResultSet rs = null;
con = DBDao.getConnection();
String sql = "SELECT * from model a,proc_sop.group b where a.GROUP_ID=b.GROUP_ID ORDER BY MODEL_ID DESC";
Statement stmt = con.createStatement();
rs = stmt.executeQuery(sql);
ResultSetMetaData md = rs.getMetaData(); //获得结果集结构信息,元数据  
int columnCount = md.getColumnCount();   //获得列数   
List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
while (rs.next()) {  
    Map<String,Object> rowData = new HashMap<String,Object>();  
    for (int i = 1; i <= columnCount; i++) {  
        rowData.put(md.getColumnName(i), rs.getObject(i));  
    }  
    list.add(rowData);  
}
DBDao.close(rs, stmt, con);
request.setAttribute("model",list);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="css/bootstrap.min.css" type="text/css" rel="stylesheet"/>
<link href="css/screen.css" type="text/css" rel="stylesheet"/>
<link href="css/alternative.css" type="text/css" rel="stylesheet"/>
<style type="text/css">
      .header{
           display: none;
       }
</style>
<title>LOG</title>
</head>
<body>
<div style="margin-top:10px; margin-bottom:6px">
<a href="mod_add.jsp" class="btn btn-info">添加MODEL</a><!-- &nbsp;<a href="update_file.jsp" class="btn btn-info">更新文件</a> -->
</div>
<display:table name="model" id="mo" pagesize="13" export="true" sort="list" class="table table-hover">      
        <display:column property="MODEL_ID" headerClass="header" style="display:none" title="ID" />  
        <display:column property="MODEL_NAME" sortable="true" title="MODEL名称" />            
		<display:column property="GROUP_NAME" sortable="true" title="部门"/> 
		<display:column title="操作" media="html"> 
		<a class="btn btn-info" href="mod_update.jsp?mo_id=${mo.MODEL_ID}">更新</a>  
   		<a class="btn btn-danger" href="${pageContext.request.contextPath}/DeleteModelServlet?mo_id=${mo.MODEL_ID}" onClick="return confirm('确定删除?');" >删除</a>
		</display:column>
        <display:setProperty name="export.csv" value="false" /> 
        <display:setProperty name="export.xml" value="false" />    
</display:table>  
</body>
</html>