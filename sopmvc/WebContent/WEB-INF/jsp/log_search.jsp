<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
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
String sql = "SELECT LOG_ID,COMPUTER_IP,FILE_NAME,LOG_TIME from log a,file b where a.file_id=b.file_id";
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
request.setAttribute("log",list);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link href="css/bootstrap.min.css" type="text/css" rel="stylesheet"/>
<link href="css/alternative.css" type="text/css" rel="stylesheet"/>
<link href="css/screen.css" type="text/css" rel="stylesheet"/>
<link href="css/displaytag.css" type="text/css" rel="stylesheet"/>	
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>LOG</title>
</head>
<body>
<display:table name="log" pagesize="23" export="true" sort="list" class="table table-hover">      
        <display:column property="LOG_ID" title="日志ID" />      
        <display:column property="COMPUTER_IP" sortable="true" title="访问者IP" />       
        <display:column property="FILE_NAME" title="访问文件" />  
		<display:column property="LOG_TIME" sortable="true" title="访问日期"  />  
        <display:setProperty name="export.csv" value="false" /> 
        <display:setProperty name="export.xml" value="false" />    
</display:table>  
</body>
</html>