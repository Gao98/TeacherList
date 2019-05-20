<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="databasemanage.DatabaseManage" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList"%>
<html>
  <head>
    <title>添加教师信息</title>  
  </head>
  <body>
  <%
  	String username = null;
  	session = request.getSession(false);
	if (session != null)
		username = (String) session.getAttribute("username");
	if (username != null) {
   %>
  <h1 align="center">添加教师信息</h1>
  	<%
  		request.setCharacterEncoding("UTF-8");
  		response.setCharacterEncoding("UTF-8");
  		DatabaseManage dm=new DatabaseManage();
		Connection con=null;
		ResultSet rs=null;
		con=dm.getConnection();
		String sql="select * from department";
		if(con!=null){
			rs=dm.executeQuery(sql);
		}
	%>
	<center>
		<form id="teacheradd" name="teacheradd" method="post" action="servlet/TeacherAddServlet">
		<table>
		<tr>
			<td align=right>学院：</td>
			<td><select id="school" onchange="change()">
				<% 
					ArrayList dept_list = new ArrayList();
					out.println("<option value = \"-1\"/>");
					rs.beforeFirst();
					while(rs.next()){
						ArrayList list = new ArrayList();
						list.add(rs.getString("dept_id"));
						list.add(rs.getString("dept_name"));
						list.add(rs.getString("father_id"));
						dept_list.add(list);
						if (rs.getInt("father_id") == 0) {
							out.println("<option value = \"" + rs.getInt("dept_id") + "\">" + rs.getString("dept_name") + "</option>");
						}
					}
				%></select>
			</td>
		</tr> 
		<td align=right>系：</td>
			<td><select id="department" name="dept_id" />
			</td>
		</tr>
		<tr>
			<td align=right>姓名：</td>
			<td>
				<input name="name"  type="text">
			</td>
		</tr>
		<tr>
			<td align=right>职称：</td>
			<td>
				<input name="title"  type="text">
			</td>
		</tr>
		<tr>
			<td align=right>电话：</td>
			<td>
				<input name="tel"  type="text">
			</td>
		</tr>
		<tr>
			<td align=right>地址：</td>
			<td>
				<input name="address"  type="text">
			</td>
		</tr>
		<tr>
			<td align=right>邮箱：</td>
			<td>
				<input name="email"  type="text">
			</td>
		</tr>
		<tr>
			<td></td>
  	        <td align="center">
               <input type="submit"  value="确认添加"/ >
           </td>
        </tr>
     </table>
  	</form>
  	</center>
  	<script language="javascript">
  	function change() {
  		var school = document.getElementById("school").value;
  		var dept = document.getElementById("department");
		dept.options.length=0;
		<%for (int i = 0; i < dept_list.size(); i++) {
				ArrayList list = (ArrayList) dept_list.get(i);
				String dept_id = (String) list.get(0);
				String dept_name = (String) list.get(1);
				String father_id = (String) list.get(2);%>
			if(school==<%=father_id%>){
				dept.options.add(new Option("<%=dept_name%>","<%=dept_id%>"));
			}
		<%}%>
  	}
  </script>
  	<%
		dm.close();	
    } else 
 	{
 		out.println("<center><h3>需要管理员权限，请先登录！</h3>");
 		out.println("<a href=\"AdminLogin.jsp\">登录</a></center>");
 	}
     %>
  </body>
</html>
