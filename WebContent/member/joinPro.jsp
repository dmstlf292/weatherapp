<%@page import="com.exam.dao.AddressDAO"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="com.exam.vo.AddressVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- post 전송 파라미터값 한글 처리 --%>
<%
	request.setCharacterEncoding("utf-8");
%>

<%-- VO 객체 준비 --%>
<%
	AddressVO memberVo = new AddressVO();
%>

<%-- VO 객체에 파라미터값을 찾아서 저장 --%>
<%
	memberVo.setId(request.getParameter("id"));
memberVo.setPasswd(request.getParameter("passwd"));
memberVo.setName(request.getParameter("name"));
memberVo.setEmail(request.getParameter("email"));
memberVo.setAddress(request.getParameter("address"));
memberVo.setTel(request.getParameter("tel"));
memberVo.setGender(request.getParameter("gender"));
memberVo.setAge(Integer.parseInt(request.getParameter("age"))); // "33" -> 33
%>

<%-- 현재 날짜시간 정보 Timestamp 설정 --%>
<%
	memberVo.setRegDate(new Timestamp(System.currentTimeMillis()));
%>

<%-- DAO 객체 준비 --%>
<%
	AddressDAO memberDao = new AddressDAO();
%>

<%-- 회원가입 메서드 호출 --%>
<% memberDao.addMember(memberVo); %>

<%-- 로그인 페이지를 요청하게하는 응답을 줌 --%>
<% //response.sendRedirect("login.jsp"); %>

<script>
	alert('회원가입 성공!');
	location.href = 'login.jsp';
</script>

