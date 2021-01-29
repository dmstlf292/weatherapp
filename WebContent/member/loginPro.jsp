<%@page import="com.exam.vo.AddressVO"%>
<%@page import="com.exam.dao.AddressDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// post 전송 파라미터값 한글처리
request.setCharacterEncoding("utf-8");

// id passwd keepLogin 파라미터값 가져오기
String id = request.getParameter("id");
String passwd = request.getParameter("passwd");
String strKeepLogin = request.getParameter("keepLogin");

// 체크박스는 체크 안하면 null을 리턴함
boolean keepLogin = false;
if (strKeepLogin != null) {
	keepLogin = Boolean.parseBoolean(strKeepLogin); // "true" -> true
}

// DAO 객체 준비
AddressDAO memberDao = new AddressDAO();

// id에 해당하는 VO객체 리턴
AddressVO memberVo = memberDao.getMemberById(id);

if (memberVo != null){ // 아이디 일치
	if (passwd.equals(memberVo.getPasswd())) { // 패스워드 일치
		// 세션은 사용자 한명당 유지되는 일종의 자료구조 맵 객체
		// 로그인 처리. 세션에 로그인 확인용 데이터 저장
		session.setAttribute("id", id);
		
		// 로그인 상태유지 원하면 쿠키 생성 후 응답주기
		if (keepLogin){ // keepLogin == true
	Cookie cookie = new Cookie("id",id);
	cookie.setMaxAge(60*10); // 쿠키 유효기간. 초단위 설정.  10분
	cookie.setPath("/"); // 쿠키 생성경로 설정
	response.addCookie(cookie); 
		}
	
		// index.jsp를 요청하게 하기
		response.sendRedirect("/index.jsp");
	} else {
%>
		<script>
			alert('패스워드가 일치하지 않습니다.');
			history.back(); // 뒤로가기
		</script>	
		<%
	}
} else { // memberVo == null
		%>
	<script>
	alert('없는 아이디 입니다.');
	history.back();
	</script>
	<%
}
%>