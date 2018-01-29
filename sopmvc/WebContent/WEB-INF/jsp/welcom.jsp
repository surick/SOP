<%@ page contentType="text/html; charset=utf-8" language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>SOP系统管理</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="${basePath}/css/bootstrap.min.css" type="text/css" rel="stylesheet"/>
    <link href="${basePath}/css/style.css" type="text/css" rel="stylesheet"/>
    <script type="text/javascript" src="${basePath}/js/jquery-1.8.3.min.js"></script>
    <script type="text/javascript" src="${basePath}/js/menu.js"></script> 
  </head>
  
 <body>
<div class="top"></div>
<div id="header">
	<div class="logo">SOP后台管理</div>
	<div class="navigation">
		
	</div>
</div>
<div id="content">
	<div class="left_menu" >
				<ul id="nav_dot">
      <li>
          <h4 class="M1"><span></span>	MODEL管理</h4>
          <div class="list-item none">
            <a href='welcom/mod_search' target="Container">MODEL管理</a>
          </div>
        </li>
        <li>
          <h4 class="M2"><span></span>文件管理</h4>
          <div class="list-item none">
            <a href='welcom/search' target="Container">文件管理</a>
             
           </div>
        </li>
        <li>
          <h4 class="M3"><span></span>日志管理</h4>
          <div class="list-item none">
            <a href='welcom/log_search' target="Container">用户访问记录</a>
            <a href='welcom/log_find' target="Container">条件查询</a>
          </div>
        </li>
						
  </ul>
		</div>
		<div class="m-right">
			<div class="main">
				<iframe src=""  style="width:100%;height:100%" frameborder="0" id="Container" name="Container"></iframe>
			</div>
		</div>
</div>
<div class="bottom"></div>
<div id="footer"><p>Copyright©江扬科技（无锡）有限公司  version:1.0  <a href="mailto:Jinguo.Li@mtigroup.com?subject=SOP系统%20问题" style="color:#32323a;" target="_blank">联系管理</a></p></div>
<script>navList(12);</script>
</body>
</html>