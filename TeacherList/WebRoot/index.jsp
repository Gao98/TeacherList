<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="databasemanage.DatabaseManage" %>
<%@ page import="java.sql.*" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <title>华东师范大学教师名录</title>
        <link href="style2.css" rel="stylesheet" type="text/css">
        <style type="text/css">
            <!--
            .STYLE2 {color: #8d8d8d}
            .btnSearch{width:86px; height:30px;color:#C90000;font-weight:bold;}
            .input_css{width:410px; height:30px; line-height:30px; font-size:14px; color:#959595;border-left:1px solid #D9D9D9;border-right:1px solid #D9D9D9;border-bottom:1px solid #D9D9D9;border-top:1px solid #C0C0C0;}
            .orgTable {height:30px; line-height:30px;margin-left:10px;font-size:14px;}
            -->
        </style>
        <script language="javascript">
            function keywordOnkeyDown(){
                var keyWord=document.getElementById("keyWord").value;
                if(keyWord == "输入教师姓名来查找华东师范大学教师"){
                    document.getElementById("keyWord").value ="";
                }
            }
            function keywordOnkeyUp(){
                var keyWord=document.getElementById("keyWord").value;
                if(keyWord == ""){
                    document.getElementById("keyWord").value ="输入教师姓名来查找华东师范大学教师";
                }
            }
            function openSearch(){
                var keyWord=document.getElementById("keyWord").value;
                if(keyWord == "输入教师姓名来查找华东师范大学教师"){
                    alert("请输入搜索的关键词");
                    document.getElementById("keyWord").value ="";
                    document.getElementById("keyWord").focus();
                    return;
                }
                window.location.href = 'index.jsp?name='+keyWord;
            }
			
        </script>

    </head>
    <body>
        <div id="container_page">
            <div id="head">
                <table width="888" border="0" align="center" cellpadding="0" cellspacing="0">
                    <tr>
                        <td><img src="images/head2.gif" width="315" height="81" border="0"></td>
                        <td align="right"><br>
                        <table border="0" cellpadding="0" cellspacing="0" class="wlink">
                          <tr>
                            <td><a href="AdminLogin.jsp">管理入口</a></td>
                          </tr>
                          </table>
                      </td>
                    </tr>
              </table>
            </div>
            <div id="container_content"><div style="height:9px;"></div>
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td width="56"></td>
                        <td width="888" valign="top">
                            <table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#F0F0F0">
                              <tr>
                                <td bgcolor="#FFFFFF"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                                  <tr>
                                    <td width="888" height="140" class="kuang"><table width="100%" border="0" cellpadding="0" cellspacing="0">
                                        <tr>
                                          <td width="306" align="right"><img src="images/n2.gif" width="235" height="85"></td>
                                          <td><table border="0" align="center" cellpadding="0" cellspacing="0">
                                              <tr>
                                                <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                    <tr>
                                                      <td><input id='keyWord' type='text' name='keyWord' class="input_css" onBlur="keywordOnkeyUp()" onFocus="keywordOnkeyDown()" onKeyUp="keywordOnkeyDown()" value="输入教师姓名来查找华东师范大学教师" style="-webkit-border-radius:5px;-moz-border-radius:5px;-ms-border-radius:5px;-o-border-radius:5px;border-radius:5px;">
                                                        &nbsp;
                                                        <input name="button" type="button" class="btnSearch" onClick="openSearch();" value="搜索" style="-webkit-border-radius:5px;-moz-border-radius:5px;-ms-border-radius:5px;-o-border-radius:5px;border-radius:5px;"/>
                                                      </td>
                                                    </tr>
                                                </table></td>
                                              </tr>
                                          </table></td>
                                        </tr>
                                    </table></td>
                                  </tr>
                                </table></td>
                              </tr>
                              <tr>
                                <td bgcolor="#FFFFFF"><table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
                                  <tr>
                                    <td>
                                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                          <tr>
                                            <td height="23"></td>
                                          </tr>
                                        </table>
                                      <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
                                          <tr>
                                            <td><table cellpadding="0" cellspacing="0" border="0" class="orgTable" id="shownTD" width="100%">

<%
  	    request.setCharacterEncoding("UTF-8");
  		response.setCharacterEncoding("UTF-8");
  		DatabaseManage dm=new DatabaseManage();
		Connection con=null;
		ResultSet rs=null;
		con=dm.getConnection();
		String name=request.getParameter("name");
		String sql;
		if(name==null)
			sql="select T.dept_name,S.dept_name,teacher.teacher_name,teacher.teacher_title,teacher.teacher_tel,teacher.teacher_address,teacher.teacher_email from department as S,department as T,teacher where S.dept_id=teacher_dept_id and T.dept_id=S.father_id";
		else
			sql="select T.dept_name,S.dept_name,teacher.teacher_name,teacher.teacher_title,teacher.teacher_tel,teacher.teacher_address,teacher.teacher_email from department as S,department as T,teacher where S.dept_id=teacher_dept_id and T.dept_id=S.father_id and teacher_name like '%" + name + "%'";				
		if(con!=null){
			rs=dm.executeQuery(sql);
		}
		try{
			if(rs!=null&&rs.next()){
				out.println("<tr align=\"left\">");
				out.println("<th>学院</th>");
				out.println("<th>系</th>");
				out.println("<th>姓名</th>");
				out.println("<th>职称</th>");
				out.println("<th>电话</th>");
				out.println("<th>地址</th>");
				out.println("<th>邮箱</th>");
				out.println("</tr>");
				rs.beforeFirst();
				while(rs.next()){
					out.println("<tr>");
					out.println("<td>"+rs.getString("T.dept_name")+"</td>");
					out.println("<td>"+rs.getString("S.dept_name")+"</td>");
					out.println("<td>"+rs.getString("teacher_name")+"</td>");
					out.println("<td>"+rs.getString("teacher_title")+"</td>");
					out.println("<td>"+rs.getString("teacher_tel")+"</td>");
					out.println("<td>"+rs.getString("teacher_address")+"</td>");
					out.println("<td>"+rs.getString("teacher_email")+"</td>");						
					out.println("</tr>");
				}
			}						
			else out.println("<tr><td align=\"center\"><h2>查无此人!</h2></td></tr>");					
		}
		catch(Exception e){
			e.printStackTrace();
		}		
  	 %>

                                            </table></td>
                                          </tr>
                                      </table></td>
                                  </tr>
                                </table>
                                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                      <td height="20">&nbsp;</td>
                                    </tr>
                                  </table></td>
                              </tr>
                            </table>
                            
                            </td>
                        <td width="56"></td>
                    </tr>
                </table>

            </div>
            <div id="foot"><div style="height:20px;"></div>
                <table width="888" border="0" align="center" cellpadding="0" cellspacing="0">
                    <tr>
                        <td height="60" align="right" valign="top"><span class="STYLE2">版权所有  | 10165102204 高桢</span></td>
                    </tr>
              </table>
            </div>
        </div>
    </body>
</html>

