<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.exam.vo.OpenboardVo"%>
<%@page import="java.util.List"%>
<%@page import="com.exam.dao.OpenboardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 
	선언부 영역
	실제 서블릿 클래스로 변환될때
	멤버변수와 메서드 선언으로 변환됨
--%>
<%!
int max = 100; 

Boolean isImage(String filename) {
	boolean isImage = false;
	
	int index = filename.lastIndexOf(".");
	String ext = filename.substring(index + 1); // 확장자 문자열
	
	// 이미지 파일이면(확장자가 jpg, jpeg, gif, png) img태그로 보여주기
	// 이미지 파일이 아니면 다운로드 링크걸기
	if (ext.equalsIgnoreCase("jpg") 
			|| ext.equalsIgnoreCase("jpeg")
			|| ext.equalsIgnoreCase("gif")
			|| ext.equalsIgnoreCase("png")) {
		isImage = true;
	} else {
		isImage = false;
	}
	
	return isImage;
}
%>      
    
<%    
// num 파라미터값 가져오기
int num = Integer.parseInt(request.getParameter("num"));
String pageNum = request.getParameter("pageNum");

// DAO 객체 준비
OpenboardDao dao = new OpenboardDao();

// 글번호 num에 해당하는 글의 조회수를 1 증가시키기
dao.updateReadCountByNum(num);

// 글번호 num에 해당하는 글한개를 VO로 가져오기
OpenboardVo vo = dao.getOpenboardByNum(num);
%>

<!DOCTYPE html>
<html>
<head>
<%-- head 컨텐트 영역 --%>
<jsp:include page="/include/headContent.jsp"/>
<link href="/css/subpage.css" rel="stylesheet" type="text/css"  media="all">
</head>

<body>
<div id="wrap">
	<%-- header 영역 --%>
	<jsp:include page="/include/topHeader.jsp"/>

	<div class="clear"></div>
	<div id="sub_img_center"></div>
	
	<div class="clear"></div>
	<%-- nav 영역 --%>
	<jsp:include page="/include/submenuBoard.jsp"/>
	
	<article>
		
	<h1>공개 게시판 상세보기</h1>
		
	<table id="notice">
		<tr>
			<th scope="col" class="tno" width="200">글번호</th>
			<td class="left" width="500"><%=vo.getNum() %></td>
		</tr>
		<tr>
			<th scope="col">조회수</th>
			<td class="left"><%=vo.getReadcount() %></td>
		</tr>
		<tr>
			<th scope="col">작성자</th>
			<td class="left"><%=vo.getName() %></td>
		</tr>
		<tr>
			<th scope="col">작성일</th>
			<td class="left"><%=vo.getRegDate() %></td>
		</tr>
		<tr>
			<th scope="col">글제목</th>
			<td class="left"><%=vo.getSubject() %></td>
		</tr>
		<tr>
			<th scope="col">글내용</th>
			<td class="left"><pre><%=vo.getContent() %></pre></td>
		</tr>
		<tr>
			<th scope="col">파일</th>
			<td class="left">
				<%
				String filename = vo.getFilename();
				
				if (filename != null) {
					// 이미지 파일이면(확장자가 jpg, jpeg, gif, png) img태그로 보여주기
					// 이미지 파일이 아니면 다운로드 링크걸기
					int index = filename.lastIndexOf(".");
					String ext = filename.substring(index + 1); // 확장자 문자열
					
					if (isImage(filename)){
						%>
						<a href="/upload/<%=vo.getFilename() %>">
							<img src="/upload/<%=vo.getFilename() %>" width="100" height="100">
						</a>
						<%
					} else {
						%>
						<a href="/upload/<%=vo.getFilename() %>">
							<%=vo.getFilename() %>
						</a>
						<%
					}
				}
				%>
			</td>
		</tr>

		                
	</table>

	<div id="table_search">
		<input type="button" value="수정" class="btn" onclick="location.href = 'updateCheckForm.jsp?num=<%=num %>&pageNum=<%=pageNum %>'">
		<input type="button" value="삭제" class="btn" onclick="location.href = 'deleteForm.jsp?num=<%=num %>&pageNum=<%=pageNum %>'">
		<input type="button" value="답글" class="btn" onclick="location.href = 'replyWriteForm.jsp?reRef=<%=vo.getReRef() %>&reLev=<%=vo.getReLev() %>&reSeq=<%=vo.getReSeq() %>&pageNum=<%=pageNum %>'">
		<input type="button" value="목록" class="btn" onclick="location.href = 'openboard.jsp?pageNum=<%=pageNum %>'">
	</div>
	
	<div class="clear"></div>
	<div id="page_control"></div>
		
	</article>
    
	<div class="clear"></div>
	<%-- footer 영역 --%>
	<jsp:include page = '/include/bottomFooter.jsp' />
</div>

</body>
</html>   

