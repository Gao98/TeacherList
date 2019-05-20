package servlet;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import databasemanage.DatabaseManage;
import java.sql.*;
public class TeacherAddServlet extends HttpServlet {
	public TeacherAddServlet() {
		super();
	}
	public void destroy() {
		super.destroy(); 
	}
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		String name=request.getParameter("name");
		int dept_id = Integer.parseInt(request.getParameter("dept_id"));
		String title=request.getParameter("title");
		String tel=request.getParameter("tel");
		String address=request.getParameter("address");
		String email=request.getParameter("email");
		DatabaseManage dm=new DatabaseManage();
		Connection con=dm.getConnection();
		int num=0;
		try{
			PreparedStatement pstmt=con.prepareStatement("insert into teacher values (null,?,?,?,?,?,?)");
			pstmt.setString(1, name);
			pstmt.setInt(2, dept_id);
			pstmt.setString(3, title);
			pstmt.setString(4, tel);
			pstmt.setString(5, address);
			pstmt.setString(6, email);
			num=pstmt.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
		}
		if(num==0){
			response.sendRedirect("../TeacherAddFailer.jsp");
		}
		else{
			response.sendRedirect("../TeacherAddSuccess.jsp");
		}	
		dm.close();		
	}	
	public void init() throws ServletException {
		super.init();
	}
}
