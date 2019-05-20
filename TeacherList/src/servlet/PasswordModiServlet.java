package servlet;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import databasemanage.DatabaseManage;
import java.sql.*;
public class PasswordModiServlet extends HttpServlet {
	public PasswordModiServlet() {
		super();
	}
	public void destroy() {
		super.destroy(); 
	}
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setCharacterEncoding("UTF-8");
		String username = null;
	  	HttpSession session = request.getSession(false);
		username = (String) session.getAttribute("username");
		String oldpassword=request.getParameter("oldpassword");
		String newpassword=request.getParameter("newpassword");
		//String passwordagain=request.getParameter("passwordagain");
		DatabaseManage dm=new DatabaseManage();
		Connection con=dm.getConnection();
		int num=0;
		try{
			PreparedStatement pstmt=con.prepareStatement("update user set password=? where username=? and password=?");
			pstmt.setString(1, newpassword);
			pstmt.setString(2, username);	
			pstmt.setString(3, oldpassword);	
			num=pstmt.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
		}
		if(num==0){
			response.sendRedirect("../PasswordModiFailer.jsp");
		}
		else{
			response.sendRedirect("../PasswordModiSuccess.jsp");
		}	
		dm.close();				
		
	}	
	public void init() throws ServletException {
		super.init();
	}
}
