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

// 글번호에 해당하는 패스워드 비교하기
boolean isCorrect = dao.isPasswdCorrect(num,passwd);

// 패스워드가 불일치하면 "글 패스워드가 틀림" 뒤로가기
if (!isCorrect) {
	%>
	<script>
		alert('글 패스워드가 틀립니다. 다시 입력하세요.');
		history.back();
	</script>
	<%
	return;
} 

// 글번호에 해당하는 글정보 한개 가져오기
OpenboardVo vo = dao.getOpenboardByNum(num);
    
%>

    
<!DOCTYPE html>
<html>
<head>
<%-- head 컨텐트 영역 --%>
<jsp:include page="/include/headContent.jsp"/>
<link href="/css/subpage.css" rel="stylesheet" type="text/css"  media="all">
<style>
span.btnDelFile {
	color: red;
	background-color: yellow;
	font-weight: bold;
	border: 1px solid black;
	border-radius: 5px;
	padding: 3px;
	cursor: pointer;
}

</style>
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
		
	<h1>공개 게시판 글수정</h1>
	
	<form action="updatePro.jsp" method="post" enctype="multipart/form-data">
	<input type="hidden" name="pageNum" value="<%=pageNum %>">
	<input type="hidden" name="num" value="<%=num %>">		
	<table id="notice">
		<tr>
			<th scope="col" class="tno" width="200">작성자명</th>
			<td class="left" width="500">
				<input type="text" name="name" value="<%=vo.getName() %>">
			</td>
		</tr>
		<tr>
			<th scope="col">글 패스워드</th>
			<td class="left">
				<input type="password" name="passwd" value="<%=vo.getPasswd() %>">
			</td>
		</tr>
		<tr>
			<th scope="col">글제목</th>
			<td class="left">
				<input type="text" name="subject" value="<%=vo.getSubject() %>">
			</td>			
		</tr>
		<tr>
			<th scope="col">글내용</th>
			<td class="left">
				<textarea rows="13" cols="40" name="content"><%=vo.getContent() %></textarea>
			</td>
		</tr>
		<tr>
			<th scope="col">파일</th>
			<td class="left">
				<%
				if(vo.getFilename() == null) {
					%>
					<input type="file" name="filename">
					<%
				} else { // vo.getFilename() != null
					%>
					<div class="oldFileArea">
						<%=vo.getFilename() %>
						<span class="btnDelFile">X</span>
					</div>
					<input type="hidden" name="oldFilename" value="<%=vo.getFilename() %>">
					<%
				}
				%>

			</td>
		</tr>            
	</table>

	<div id="table_search">
		<input type="submit" value="글수정" class="btn">
		<input type="reset" value="다시쓰기" class="btn">
		<input type="button" value="목록" class="btn" onclick="location.href = 'openboard.jsp?pageNum=<%=pageNum %>'">
	</div>
	</form>
	
	<div class="clear"></div>
	<div id="page_control"></div>
		
	</article>
    
	<div class="clear"></div>
	<%-- footer 영역 --%>
	<jsp:include page = '/include/bottomFooter.jsp' />
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
// 제이쿼리는 css 선택자 문법으로 대상을 선택해서 기능을 연결하는 용도 등으로 사용
$('span.btnDelFile').click(function () {
	// 이벤트 소스 : 이벤트가 발생한 대상
	// 제이쿼리에서는 이벤트 핸들러 함수 내부에서 항상 this로 참조됨
	
	// this는 여기서 클릭한 자기자신인 span태그가 됨
	
	//hidden타입 input태그의 name 속성값을 delFilename으로 수정하기
	$(this).closest('div').next().prop('name','delFilename');
	
	// 가장 가까운 상위요소 중에 td요소를 기준으로 가장 앞의 자식요소로 추가하기
	$(this).closest('td').prepend('<input type="file" name="filename">');
	
	// 가장 가까운 div 요소를 삭제하기
	$(this).closest('div').remove();
});



</script>

</body>
</html>   

