package servlet;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import databasemanage.DatabaseManage;
import java.sql.*;
public class AdminLoginCheck extends HttpServlet {
	public AdminLoginCheck() {
		super();
	}
	public void destroy() {
		super.destroy(); 
	}
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setCharacterEncoding("UTF-8");
		String adminname=request.getParameter("adminname");
		String password=request.getParameter("password");	
		DatabaseManage dm=new DatabaseManage();
		Connection con=null;
		ResultSet rs=null;
		boolean result=false;
		con=dm.getConnection();
		String sql="select * from user where username="+"\""+adminname+"\""+" and password="+"\""+password+"\"";
		if(con!=null){
			rs=dm.executeQuery(sql);
		}
		try{
			if(rs!=null){
				result=rs.next();				
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		if(result){
			HttpSession session = request.getSession();
			session.setAttribute("username", adminname);
			response.sendRedirect("../Teacher.jsp");			
		}
		else{
			response.sendRedirect("../LoginFail.jsp");
		}
		dm.close();
	}	
	public void init() throws ServletException {
		super.init();
	}
}
