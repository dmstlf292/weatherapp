package com.exam.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.exam.dao.OpenboardDao;
import com.exam.vo.OpenboardVo;

// 톰캣이 jsp를 실행하는 과정
// a.jsp 요청받아 실행되면 -> a_jsp.java 서블릿 클래스로 변환 -> 객체생성 후 service() 호출



@WebServlet("/first.jsp")
public class FirstServlet extends HttpServlet { 
	
	int max = 100;
	
	boolean isImage(String filename) {
		boolean isImage = false;
		
		int index = filename.lastIndexOf(".");
		String ext = filename.substring(index + 1); // 확장자 문자열
		
		if (ext.equalsIgnoreCase("jpg") 
				|| ext.equalsIgnoreCase("jpeg")
				|| ext.equalsIgnoreCase("gif")
				|| ext.equalsIgnoreCase("png")) {
			isImage = true;
		} else {
			isImage = false;
		}
		return isImage;
	} // isImage
	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 세션객체 준비
		HttpSession session = request.getSession();
		// 애플리케이션 객체 준비
		ServletContext application = request.getServletContext();
		
		response.setContentType("text/html; charset=UTF-8");

		PrintWriter out = response.getWriter();
		
		// num  pageNum   파라미터값 가져오기
		int num = Integer.parseInt(request.getParameter("num"));
		// DAO 객체 준비
		OpenboardDao dao = new OpenboardDao();
		// 글번호 num에 해당하는 글의 조회수를 1 증가시키기
		dao.updateReadCountByNum(num);
		// 글번호 num에 해당하는 글한개를 VO로 가져오기
		OpenboardVo vo = dao.getOpenboardByNum(num);
		
		
		out.println("<!DOCTYPE html>");
		out.println("<html>");
		
		out.println("<head>");
		out.println("	<meta charset='utf-8'>");
		out.println("	<title>Welcome to Fun Web</title>");
		out.println("</head>");
		
		out.println("<body>");
		out.println("<h1>");
		out.println(vo);
		out.println("</h1>");
		out.println("</body>");
		
		out.println("</html>");		
	}// service

}
