<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- 세션에 저장된 특정값 삭제 --%>
<% //session.removeAttribute("id"); %>

<%-- 세션값 초기화(세션에 저장된 모든정보 삭제) --%>
<% session.invalidate(); %>

<%-- 로그인 상대유지용 쿠키가 존재하면 삭제처리 --%>
<% 
Cookie[] cookies = request.getCookies();

if (cookies != null) {
	for(Cookie cookie : cookies) {
		// 쿠키이름이 "id"인 쿠키를 삭제하도록 유효기간을 0으로 설정
		if (cookie.getName().equals("id")) {
			cookie.setMaxAge(0); // 쿠키삭제 의도로 유효기간 0 설정
			cookie.setPath("/"); // 경로설정 유지
			response.addCookie(cookie);
		}
	}// for
}
%>

<%-- "로그아웃됨", index.jsp로 이동 --%>
<script>
	alert('로그아웃됨');
	location.href = '/index.jsp'; // '../index.jsp'
</script>