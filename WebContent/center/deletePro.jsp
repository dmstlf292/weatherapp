<%@page import="java.io.File"%>
<%@page import="com.exam.vo.OpenboardVo"%>
<%@page import="com.exam.dao.OpenboardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
// post 전송 파라미터값 한글처리
request.setCharacterEncoding("utf-8");

// 파라미터값 pageNum  num  passwd 가져오기
String pageNum = request.getParameter("pageNum");
int num = Integer.parseInt(request.getParameter("num"));
String passwd = request.getParameter("passwd");

// DAO 객체 준비
OpenboardDao dao = new OpenboardDao();

// 본인글 확인용 패스워드 비교하기
boolean isCorrect = dao.isPasswdCorrect(num, passwd);

// 글 패스워드 일치하지 않을때
if (!isCorrect) { // isCorrect = false  
	%>
	<script>
		alert('글 패스워드 틀림. 다시 입력하세요.');
		history.back(); // 뒤로가기. 앞으로가기는 forward()
	</script>
	<%
 return;
}

// 글 패스워드 일치할 때
// 글번호에 해당하는 글내용 가져오기(첨부파일 정보 확인을 위해서)
OpenboardVo vo = dao.getOpenboardByNum(num);
// 첨부파일 존재여부 확인해서 있으면 삭제하기
String filename = vo.getFilename();
if (filename != null) {// 첨부파일이 있으면
	// 실제 업로드 되어있는 경로 구하기
	String realPath = application.getRealPath("/upload"); // 업로드 경로	
	// File 객체 준비
	File file =new File(realPath, filename);
	if (file.exists()) { // 해당 경로에 파일이 존재하는지 확인
		file.delete(); // 파일 삭제하기
	}
}
// 테이블 글내용 삭제하기
dao.deleteByNum(num);

// 글목록 페이지로 리다이렉트 시키기
response.sendRedirect("openboard.jsp?pageNum=" + pageNum);
%>