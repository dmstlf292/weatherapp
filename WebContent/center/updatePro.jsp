<%@page import="com.exam.dao.OpenboardDao"%>
<%@page import="com.exam.vo.OpenboardVo"%>
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// 파일업로드 라이브러리로 cos.jar 를 사용하고 있음
// cos.jar는 업로드부터 수행해야되는 제약사항이 존재함

// MultipartRequest 생성자 인자 5개
// 1 request
// 2 upload 폴더 생성하고 물리적 경로 지정
String realPath = application.getRealPath("/upload");
System.out.println("realPath = " + realPath);
// 3 파일업로드 최대크기 제한 (바이크 단위)
int maxSize = 1024 * 1024 * 50; // 50MB 제한
// 4 한글처리 (utf-8 유니코드 적용)
// 5 파일이름이 중복일경우 -> 파일이름 변경 규칙을 가진 객체
MultipartRequest multi = new MultipartRequest(
		request, realPath, maxSize, "utf-8", new DefaultFileRenamePolicy());

// ====================파일정보는 업로드 수행 완료===========================


// 기존에 첨부된파일 삭제할필요 있으면 삭제하기
String delFilename = multi.getParameter("delFilename");
if (delFilename != null) {
	File file = new File(realPath, delFilename);
	if (file.exists()){
		file.delete();
	}
}

// ===================삭제할 파일 삭제처리 완료됨============================

// pageNum 파라미터값 가져오기
String pageNum = multi.getParameter("pageNum");

// VO 객체 준비
OpenboardVo vo = new OpenboardVo();

// 파라미터값 가져와서 VO에 저장
vo.setNum(Integer.parseInt(multi.getParameter("num")));
vo.setName(multi.getParameter("name"));
vo.setPasswd(multi.getParameter("passwd"));
vo.setSubject(multi.getParameter("subject"));
vo.setContent(multi.getParameter("content"));

//원본 파일명
String originalFilename = multi.getOriginalFileName("filename");
//업로드한 실제 파일명
String realFilename = multi.getFilesystemName("filename");

// 새로 업로드된 파일이 없으면
if (multi.getFilesystemName("filename") != null){
	vo.setFilename(multi.getFilesystemName("filename")); // 새파일명으로 저장
} else { // 새로 업로드된 파일이 없으면
	vo.setFilename(multi.getParameter("oldFilename")); // 기존파일명으로 저장
}

// DAO 객체 준비
OpenboardDao dao = new OpenboardDao();

// DB 테이블 글정보 수정하기
dao.update(vo);

// 수정한 글내용 바로 확인하도록 상세보기 페이지 content.jsp로 이동
//response.sendRedirect("content.jsp?num=" + vo.getNum() + "&pageNum=" + pageNum);

%>
<script>
	alert('글 수정 완료!');
	location.href = 'content.jsp?num=<%=vo.getNum() %>&pageNum=<%=pageNum %>';
</script>


