<%@page import="java.sql.Timestamp"%>
<%@page import="com.exam.vo.OpenboardVo"%>
<%@page import="com.exam.dao.OpenboardDao"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// 파일 업로드 라이브러리로 cos 라이브러리 사용함
// cos 라이브러리는 업로드부터 수행하도록 사용방식이 제약되어있음.

// MultipartRequest 생성자 호출만으로 파일 업로드가 수행 완료됨.

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

//DAO 객체 준비
OpenboardDao dao = new OpenboardDao();

// DB 테이블에 insert할 글정보를 VO객체로 준비
OpenboardVo vo = new OpenboardVo();

// 주글정보를 VO에 설정
int num = dao.getNextNum();
vo.setNum(num);
vo.setName(multi.getParameter("name"));
vo.setPasswd(multi.getParameter("passwd"));
vo.setSubject(multi.getParameter("subject"));
vo.setContent(multi.getParameter("content"));
vo.setReadcount(0); // 조회수 0
vo.setRegDate(new Timestamp(System.currentTimeMillis()));
vo.setIp(request.getRemoteAddr()); //작성자 ip주소 문자열
vo.setReRef(num); // 주글은 글그룹 번호와 글번호가 동일함
vo.setReLev(0); // 주글은 들여쓰기 레벨이 0 (들여쓰기 안함)
vo.setReSeq(0); // 주글은 같은 글그룹 내에서 첫번째 순서

// 원본 파일명
String originalFilename = multi.getOriginalFileName("filename");
System.out.println("원본 파일명 = " + originalFilename);
// 업로드한 실제 파일명
String realFilename = multi.getFilesystemName("filename");
System.out.println("실제 파일명 = " + realFilename);
vo.setFilename(realFilename);

// 글 insert 하기
dao.add(vo);

// 글목록 openboard.jsp로 이동
response.sendRedirect("openboard.jsp");

%>