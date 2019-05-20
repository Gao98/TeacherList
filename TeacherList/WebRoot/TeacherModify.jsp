<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="databasemanage.DatabaseManage" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList"%>
<html>
  <head>
    <title>教师信息修改</title>  
  </head>
  <body>
  <%
  	String username = null;
  	session = request.getSession(false);
	if (session != null)
		username = (String) session.getAttribute("username");
	if (username != null) {
   %>
  <h1 align="center">教师信息修改</h1>
  	<%
  		request.setCharacterEncoding("UTF-8");
  		response.setCharacterEncoding("UTF-8");
  		String teacher_id=request.getParameter("teacher_id");	
  		DatabaseManage dm=new DatabaseManage();
		Connection con=null;
		ResultSet rs=null;
		ResultSet rs2=null;
		con=dm.getConnection();
		String sql="select S.dept_id,S.father_id,T.dept_name,S.dept_name,teacher.teacher_id,teacher.teacher_name,teacher.teacher_title,teacher.teacher_tel,teacher.teacher_address,teacher.teacher_email from department as S,department as T,teacher where S.dept_id=teacher_dept_id and T.dept_id=S.father_id and teacher_id='"+teacher_id+"'";
		String sql2="select * from department";
		if(con!=null){
			rs=dm.executeQuery(sql);
			rs.absolute(1);
			rs2=dm.executeQuery(sql2);
		}
	%>
	<center>
		<form id="teachermodify" name="teachermodify" method="post" action="servlet/TeacherModiServlet">
		<table>
		<tr>
			<td align=right>编号：</td>
			<td>
				<input name="id"  type="text" style= “background-color:transparent;border:0;” value=<%=rs.getString("teacher_id") %> readonly="readonly"/>
			</td>
		</tr>
		<tr>
			<td align=right>学院：</td>
			<td><select id="school" onchange="change()">
				<% 
					ArrayList dept_list = new ArrayList();
					rs2.beforeFirst();
					while(rs2.next()){
						ArrayList list = new ArrayList();
						list.add(rs2.getString("dept_id"));
						list.add(rs2.getString("dept_name"));
						list.add(rs2.getString("father_id"));
						dept_list.add(list);
						if (rs2.getInt("father_id") == 0) {
							out.println("<option value = \"" + rs2.getInt("dept_id") + "\"");
							if (rs2.getInt("dept_id") == rs.getInt("S.father_id")) {
								out.println(" selected ");
							}
							out.println(">" + rs2.getString("dept_name") + "</option>");
						}
					}
				%></select>
			</td>
		</tr> 
		<td align=right>系：</td>
			<td><select id="department" name="dept_id">
				<% 
					rs2.beforeFirst();
					while(rs2.next()){
						if (rs2.getInt("father_id") == rs.getInt("S.father_id")) {
							out.println("<option value = \"" + rs2.getInt("dept_id") + "\"");
							if (rs2.getInt("dept_id") == rs.getInt("S.dept_id")) {
								out.println(" selected ");
							}
							out.println(">" + rs2.getString("dept_name") + "</option>");
						}
					}
				%></select>
			</td>
		</tr>
		<tr>
			<td align=right>姓名：</td>
			<td>
				<input name="name"  type="text" value=<%=rs.getString("teacher_name") %> >
			</td>
		</tr>
		<tr>
			<td align=right>职称：</td>
			<td>
				<input name="title"  type="text" value=<%=rs.getString("teacher_title") %> >
			</td>
		</tr>
		<tr>
			<td align=right>电话：</td>
			<td>
				<input name="tel"  type="text" value=<%=rs.getString("teacher_tel") %> >
			</td>
		</tr>
		<tr>
			<td align=right>地址：</td>
			<td>
				<input name="address"  type="text" value=<%=rs.getString("teacher_address") %> >
			</td>
		</tr>
		<tr>
			<td align=right>邮箱：</td>
			<td>
				<input name="email"  type="text" value=<%=rs.getString("teacher_email") %> >
			</td>
		</tr>
		<tr>
			<td></td>
  	        <td align="center">
               <input type="submit"  value="修改"/ >
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
