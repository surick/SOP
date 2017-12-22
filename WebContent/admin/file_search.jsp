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
String sql = "SELECT FILE_PATH,MODEL_NAME,FILE_ID,FILE_NUM,FILE_NAME,FILE_VER,FILE_TIME,USER_ID from file a,model b where a.MODEL_ID=b.MODEL_ID ORDER BY FILE_TIME DESC";
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
request.setAttribute("file",list);
%>
<!DOCTYPE html>
<html>
<head>
<link href="css/bootstrap.min.css" type="text/css" rel="stylesheet"/>
<link href="css/screen.css" type="text/css" rel="stylesheet"/>
<link href="css/alternative.css" type="text/css" rel="stylesheet"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>LOG</title>
</head>
<body>
<div style="margin-top:10px; margin-bottom:6px;margin-left:5px;">
<a href="file_upload.jsp" class="btn btn-info">发布文件</a> 
<form class="form-search" action="file_find.jsp">
  <div class="input-append" style="float: right;margin-top:-30px;margin-right:5px;">
    <input type="text" class="span2 search-query" placeholder="请输入文件名" name="filename">
    <button type="submit" class="btn">Search</button>
  </div>
</form>
</div>
<display:table name="file" id="fi" pagesize="7" export="true" sort="list" class="table table-hover">      
        <display:column property="FILE_NUM" title="NUM" />  
        <display:column property="MODEL_NAME" sortable="true" title="MODEL名称" />            
		<display:column property="FILE_NAME" sortable="true" title="文件名"/> 
		<display:column property="FILE_PATH" title="档案名" />
		<display:column property="FILE_VER" title="文件版本" />
		<display:column property="USER_ID" title="上传人" />     
		<display:column property="FILE_TIME" sortable="true" title="更新时间" />
		<display:column title="操作" media="html">
		<a class="btn btn-info" href="file_show.jsp?fileid=${fi.FILE_ID}">查看</a>  
		<a class="btn btn-info" href="file_update.jsp?fileid=${fi.FILE_ID}">更新</a>  <%-- ${pageContext.request.contextPath} --%>
   		<a class="btn btn-danger" href="${pageContext.request.contextPath}/DeleteFileServlet?fileid=${fi.FILE_ID}" onClick="return confirm('确定删除?');" >删除</a>
		</display:column>
        <display:setProperty name="export.csv" value="false" /> 
        <display:setProperty name="export.xml" value="false" />    
</display:table>  
</body>
</html>