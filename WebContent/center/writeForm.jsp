<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
		
	<h1>공개 게시판 글작성</h1>
	
	<form action="writePro.jsp" method="post" enctype="multipart/form-data">		
	<table id="notice">
		<tr>
			<th scope="col" class="tno" width="200">작성자명</th>
			<td class="left" width="500">
				<input type="text" name="name">
			</td>
		</tr>
		<tr>
			<th scope="col">글 패스워드</th>
			<td class="left">
				<input type="password" name="passwd">
			</td>
		</tr>
		<tr>
			<th scope="col">글제목</th>
			<td class="left">
				<input type="text" name="subject">
			</td>			
		</tr>
		<tr>
			<th scope="col">글내용</th>
			<td class="left">
				<textarea rows="13" cols="40" name="content"></textarea>
			</td>
		</tr>
		<tr>
			<th scope="col">파일</th>
			<td class="left">
				<input type="file" name="filename">
			</td>
		</tr>            
	</table>

	<div id="table_search">
		<input type="submit" value="글쓰기" class="btn">
		<input type="reset" value="다시쓰기" class="btn">
		<input type="button" value="목록" class="btn" onclick="location.href = 'openboard.jsp'">
	</div>
	</form>
	
	<div class="clear"></div>
	<div id="page_control"></div>
		
	</article>
    
	<div class="clear"></div>
	<%-- footer 영역 --%>
	<jsp:include page = '/include/bottomFooter.jsp' />
</div>

</body>
</html>   

