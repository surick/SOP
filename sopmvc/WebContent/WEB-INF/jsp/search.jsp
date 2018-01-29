<%@ page contentType="text/html; charset=utf-8"%>
<%@ page language="java" pageEncoding="UTF-8" import="java.sql.Statement" import="java.sql.*" %>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>
<%
Connection con =null;
ResultSet rs = null;
String driver ="com.mysql.jdbc.Driver";
String url ="jdbc:mysql://192.168.126.242:3306/proc_sop";
String user ="iot";
String password ="Iot85228800#1";
Class.forName(driver);
con = DriverManager.getConnection(url, user, password);
String sql = "SELECT MODEL_NAME,FILE_ID,FILE_NUM,FILE_NAME,FILE_VER,FILE_TIME,USER_ID from file a,model b where a.MODEL_ID=b.MODEL_ID";
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
stmt.close();
con.close();
request.setAttribute("file",list);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link href="css/bootstrap.min.css" type="text/css" rel="stylesheet"/>
<link href="css/screen.css" type="text/css" rel="stylesheet"/>
<link href="css/alternative.css" type="text/css" rel="stylesheet"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>LOG</title>
</head>
<body>
<div style="margin-top:10px; margin-bottom:6px">
<a href="upload.jsp" class="btn btn-info">发布文件</a><!-- &nbsp;<a href="update_file.jsp" class="btn btn-info">更新文件</a> -->
</div>
<display:table name="file" id="fi" pagesize="13" export="true" sort="list" class="table table-hover">      
        <display:column property="FILE_NUM" title="NUM" />  
        <display:column property="MODEL_NAME" sortable="true" title="MODEL名称" />            
		<display:column property="FILE_NAME" sortable="true" title="文件名"  />  
		<display:column property="FILE_VER" title="文件版本" />
		<display:column property="USER_ID" title="上传人" />     
		<display:column property="FILE_TIME" sortable="true" title="更新时间" />
		<display:column title="操作" media="html">
		<a class="btn btn-info" href="update.jsp?fileid=${fi.FILE_ID}">更新</a>  
   		<a class="btn btn-danger" href="deleteFile.jsp?fileid=${fi.FILE_ID}" onClick="return confirm('确定删除?');" >删除</a>
		</display:column>
        <display:setProperty name="export.csv" value="false" /> 
        <display:setProperty name="export.xml" value="false" />    
</display:table>  
</body>
</html>