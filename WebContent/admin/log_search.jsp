<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@page import="com.sop.web.dao.DBDao" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>
<%@ include file="../_sessioncheck.jsp" %>
<%
Connection con =null;
ResultSet rs = null;
con = DBDao.getConnection();
String sql = "SELECT LOG_ID,COMPUTER_IP,FILE_NAME,LOG_TIME from log a,file b where a.file_id=b.file_id ORDER BY LOG_TIME DESC";
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
request.setAttribute("log",list);
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
<form class="form-search" action="log_find.jsp">
  <div class="input-append" style="margin-top:15px;margin-left:5px;">
    <input type="text" class="span2 search-query" placeholder="请输入文件名" name="filename">
    <button type="submit" class="btn">Search</button>
  </div>
</form>
<display:table name="log" pagesize="16" export="true" sort="list" class="table table-hover">      
        <display:column property="LOG_ID" title="日志ID" />      
        <display:column property="COMPUTER_IP" sortable="true" title="访问者IP" />       
        <display:column property="FILE_NAME" title="访问文件" />  
		<display:column property="LOG_TIME" sortable="true" title="访问日期"  />  
        <display:setProperty name="export.csv" value="false" /> 
        <display:setProperty name="export.xml" value="false" />    
</display:table>  
</body>
</html>