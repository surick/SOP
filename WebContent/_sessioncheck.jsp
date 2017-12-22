
<% 
String user1 = (String)session.getAttribute("username");

if( user1==null ){
	/* System.out.println(username); */
	response.sendRedirect("../login.jsp");
}
%>