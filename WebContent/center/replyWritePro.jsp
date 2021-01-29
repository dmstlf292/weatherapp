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


// 답글을 다는 대상글의 re로 시작하는 파라미터값 가져오기
int reRef = Integer.parseInt(multi.getParameter("reRef"));
int reLev = Integer.parseInt(multi.getParameter("reLev"));
int reSeq = Integer.parseInt(multi.getParameter("reSeq"));
// pageNum 파라미터값 가져오기
String pageNum = multi.getParameter("pageNum");

//DAO 객체 준비
OpenboardDao dao = new OpenboardDao();

//답글 다는 대상글의 같은 글그룹 내에서 대상글의 순번보다 큰 글들의 순번 1 증가시키기
dao.updateReSeqInReRef(reRef, reSeq);

//DB 테이블에 insert할 글정보를 VO객체로 준비
OpenboardVo vo = new OpenboardVo();

// 답글정보를 VO에 설정
int num = dao.getNextNum();
vo.setNum(num);
vo.setName(multi.getParameter("name"));
vo.setPasswd(multi.getParameter("passwd"));
vo.setSubject(multi.getParameter("subject"));
vo.setContent(multi.getParameter("content"));
vo.setReadcount(0); // 조회수 0
vo.setRegDate(new Timestamp(System.currentTimeMillis()));
vo.setIp(request.getRemoteAddr()); //작성자 ip주소 문자열
vo.setReRef(reRef); // 답글의 글그룹 번호는 답글을 다는 대상글의 글그룹번호와 동일함
vo.setReLev(reLev + 1); // 답글의 들여쓰기 레벨은 답글을 다는 대상글의 들여쓰기레벨 +1
vo.setReSeq(reSeq + 1); // 답글의 순번은 답글을 다는 대상글의 순번+1


// 원본 파일명
String originalFilename = multi.getOriginalFileName("filename");
System.out.println("원본 파일명 = " + originalFilename);
// 업로드한 실제 파일명
String realFilename = multi.getFilesystemName("filename");
System.out.println("실제 파일명 = " + realFilename);
vo.setFilename(realFilename);

// 글 insert 하기
dao.add(vo);

// 상세보기 content.jsp 로 이동
response.sendRedirect("content.jsp?num=" + num + "&pageNum=" + pageNum);
%>
