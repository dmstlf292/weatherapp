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
	<div id="sub_img_member"></div>
	
	<div class="clear"></div>
	<nav id="sub_menu">  
        <ul>
            <li> <a href="#">Join us</a></li>
            <li> <a href="#">Privacy policy</a></li>
    	</ul>
	</nav>
	
	<article>
		<h1>로그인</h1>
		<form action="loginPro.jsp" method="post" id="join">
			<fieldset>
				<legend>로그인 정보</legend>
				
				<label>사용자 ID</label>
				<input type="text" name="id"><br>
				
				<label>패스워드</label>
				<input type="password" name="passwd"><br>
				
				<label>로그인 상태 유지</label>
				<input type="checkbox" name="keepLogin" value="true">
				체크하면 10분동안 로그인이 유지됩니다.
				<br>
			</fieldset>
			
			<div class="clear"></div>
			<div id="buttons">
				<input type="submit" value="로그인" class="submit">
				<input type="reset" value="초기화" class="cancel">
			</div>
		</form>
	</article>
	
	<div class="clear"></div>
	<%-- footer 영역 --%>
	<jsp:include page = '/include/bottomFooter.jsp' />
</div>

</body>
</html>   
