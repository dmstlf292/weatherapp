<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// 파라미터값 num pageNum 가져오기
String num = request.getParameter("num");
String pageNum = request.getParameter("pageNum");
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
		
	<h1>공개 게시판 글삭제</h1>
	
	<form action="deletePro.jsp" method="post" onsubmit="return check();">
	<input type="hidden" name="pageNum" value="<%=pageNum %>">
	<input type="hidden" name="num" value="<%=num %>">
			
	<table id="notice">
		<tr>
			<th scope="col">글 패스워드</th>
			<td class="left">
				<input type="password" name="passwd">
			</td>
		</tr>
	</table>

	<div id="table_search">
		<input type="submit" value="글삭제" class="btn">
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

<script>
	function check() {
		let isRemove = confirm('글을 정말 삭제하시겠습니까?');
		if (!isRemove) {
			return false;
		}
	}
</script>

</body>
</html>   

