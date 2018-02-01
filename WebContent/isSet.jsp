<%@ page contentType="text/html; charset=utf-8"%>
<%@ page language="java"%>
<%
Cookie[] cookie1 = request.getCookies();
if(cookie1 != null){
	for (Cookie cook1 : cookie1) {
		if("isSet".equals(cook1.getName())){
			Cookie c = new Cookie("isTrue","true");
			c.setMaxAge(2);
			response.addCookie(c);
			response.sendRedirect("viewer.html?file=showpdf.jsp?"+cook1.getValue());
		}else{
			//response.sendRedirect("firstpage.jsp");
			response.setHeader("Refresh", "0;url=firstpage.jsp");
		}
	}
}else{
	response.sendRedirect("firstpage.jsp");
}
%>