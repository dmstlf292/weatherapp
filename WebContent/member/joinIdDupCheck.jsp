<%@page import="com.exam.dao.AddressDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 파라미터값 "id" 가져오기
String id = request.getParameter("id");

// DAO 객체 준비
AddressDAO memberDao = new AddressDAO();
// 아이디 중복인지 확인하기
int count = memberDao.getCountById(id);
// count값이 1이면 아이디중복, 0이면 중복아님
boolean isIdDup = (count == 1) ? true : false;
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>아이디 중복 확인</h2>
	<hr>
	아이디: <%=id %> <br>
	<%
	if(isIdDup){
		%>
		<p>아이디 중복, 이미 사용중인 ID입니다.</p>
		<%
	}else {
		%>
		<p>사용가능한 ID입니다.
		<input type="button" value="ID사용" onclick="result()">
		</p>
		<%
	}	
	%>
	
	<form action="joinIdDupCheck.jsp" method="get" name="cfrm">
		<input type="text" name="id" value="<%=id %>" placeholder="아이디를 입력하세요">
		<input type="submit" value="ID중복확인">
	</form>
	
<script>
	function result(){
		// 현재창(자식창)의 id값을 부모창(join.jsp)의 id입력상자에 넣기
		//window.document.cfrm.id.value
		//window.opener
		opener.document.frm.id.value = cfrm.id.value;
		// 부모창의 id입력상자의 입력값 선택하기
		opener.document.frm.id.select();
		
		// 현재창 닫기
		close(); // window.close();
	}
</script>
	
</body>
</html>