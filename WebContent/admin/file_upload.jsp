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
    <script type="text/javascript" src="js/jquery-1.8.3.min.js"></script>
    <style type="text/css">
    	body{font-family: Verdana, Geneva, Arial, Helvetica, sans-serif;
			font-size: 11px;color:#666;background:#f6f6f6; overflow:hidden;
    	}
    	.int{ height: 30px; text-align: left; width: 600px; }
     	label{ width: 200px; margin-left: 20px; }
     	.high{ color: red; }
     	.msg{ font-size: 13px; }
     	.onError{ color: red; }
     	.onSuccess{ color: green; }
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
                <td><select name="MODEL_ID" id="MODEL_ID" class="required">
    				<!-- <option value=0>请选择 MODEL</option>	 -->
    				<sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
     					url="jdbc:mysql://192.168.126.242:3306/proc_sop?useUnicode=true&characterEncoding=utf-8"
     					user="iot"  password="Iot85228800#1"/>
     				<sql:query dataSource="${snapshot}" var="result">
	 					SELECT * from model a,proc_sop.group b where a.GROUP_ID=b.GROUP_ID;
	 				</sql:query>
	 				<c:forEach var="row" items="${result.rows}">
	 				<option value="${row.MODEL_ID}">${row.GROUP_NAME}&nbsp;&nbsp;&nbsp;${row.MODEL_NAME}</option>
	 				</c:forEach>
	 				</select>
	 			</td>
            </tr>
           <tr>
                <td align="right">NUM：</td>
                <td><input type="text" id="FILE_NUM" name="FILE_NUM" class="required"/></td>
            </tr> 
            <tr>
                <td align="right">文件名称：</td>
                <td><input type="text" id="FILE_NAME" name="FILE_NAME" class="required"/></td>
            </tr>
            <tr>
                <td align="right">版本：</td>
                <td><input type="text" id="FILE_VER" name="FILE_VER" class="required"/></td>
            </tr>
            <tr style="display:none">
                <td align="right">上传用户：</td>
                <td><input type="text" name="USER_ID" value="<%=request.getSession().getAttribute("username")%>"/></td>
            </tr> 
            <tr>
                <td align="right">上传文件：</td>
                <td><input type="file" id="file" name="file1" class="required"/></td>
            </tr> 
            <tr>
                <td align="center" colspan="2">
                    <input type="submit" value="发布" class="btn btn-info">
                </td>
            </tr>
        </table>
    </form>
    <script type="text/javascript">
    	$(document).ready(function(){
        //为表单的必填文本框添加提示信息（选择form中的所有后代input元素）
        $("form :input.required").each(function(){ 
            //创建元素
            var $required = $("<strong class='high'>*</strong>");
            //将它追加到文档中
            $(this).parent().append($required);
        });
        
        //为表单的必填文本框添加相关事件（blur、focus、keyup）
        $("form :input").blur(function(){
            //注意：这里的this是DOM对象，$(this)才是jQuery对象
            var $parent = $(this).parent();
            //删除之前的错误提醒信息
            $parent.find(".msg").remove();
            if($(this).is("#FILE_NUM")){
                //运用jQuery中的$.trim()方法，去掉首位空格
                if($.trim(this.value) == "" || $.trim(this.value).length > 10){
                    var errorMsg = "请检查NUM格式！";
                    //class='msg onError' 中间的空格是层叠样式的格式
                    $parent.append("<span class='msg onError'>" + errorMsg + "</span>"); 
                }
                else{
                    var okMsg=" 输入正确";
                    $parent.find(".high").remove();
                    $parent.append("<span class='msg onSuccess'>" + okMsg + "</span>");
                }                
            }
            if($(this).is("#FILE_NAME")){
                if($.trim(this.value) == "" || $.trim(this.value).length > 25){
                    var errorMsg = "请检查文件名！";
                    $parent.append("<span class='msg onError'>" + errorMsg + "</span>");
                }
                else{
                    var okMsg=" 输入正确";
                    $parent.find(".high").remove();
                    $parent.append("<span class='msg onSuccess'>" + okMsg + "</span>");
                }
            }
            if($(this).is("#FILE_VER")){
                if($.trim(this.value) == "" || $.trim(this.value).length > 2){
                    var errorMsg = "请检查版本号！";
                    $parent.append("<span class='msg onError'>" + errorMsg + "</span>");
                }
                else{
                    var okMsg=" 输入正确";
                    $parent.find(".high").remove();
                    $parent.append("<span class='msg onSuccess'>" + okMsg + "</span>");
                }
            }
        }).keyup(function(){
            //triggerHandler 防止事件执行完后，浏览器自动为标签获得焦点
            $(this).triggerHandler("blur");
        }).focus(function(){
            $(this).triggerHandler("blur");
        });
    });
    </script>
  </body>
</html>