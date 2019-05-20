<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head>
    <title>管理员密码修改</title>  
  </head>
  <body>
  <%
  	String username = null;
  	session = request.getSession(false);
	if (session != null)
		username = (String) session.getAttribute("username");
	if (username != null) {
   %>
     <h1 align="center">管理员密码修改</h1>
     <center>
  	 <form id="passwordmodify" name="passwordmodify" method="post" action="servlet/PasswordModiServlet">
       <table>
        <tr>
           <td>旧密码：</td>
           <td>
              <input name="oldpassword"  type="password"/>
           </td>
        </tr>
        <tr>
           <td>新密码：</td>
           <td>
              <input name="newpassword"  type="password"/>
           </td>
        </tr>
        <tr>
           <td>确认密码：</td>
           <td>
              <input name="passwordagagin"  type="password"/>
           </td>
        </tr>
        <tr>
           <td> </td>
           <td align="center">
             <input type="submit"  value="修改"/ >
           </td>
        </tr>  
      </table>  
    </form> 
    </center> 
    <%
    } else 
 	{
 		out.println("<center><h3>需要管理员权限，请先登录！</h3>");
 		out.println("<a href=\"AdminLogin.jsp\">登录</a></center>");
 	}
     %>
  </body>
</html>