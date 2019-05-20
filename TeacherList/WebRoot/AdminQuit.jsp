<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head>
    <title>注销成功页面</title>  
  </head>
  <body> 
   <center>
   <%
		session = request.getSession();
		session.invalidate();
	%>
     <h3>注销成功！</h3>
     <a href="index.jsp">返回</a>  
   </center>  
  </body>
</html>