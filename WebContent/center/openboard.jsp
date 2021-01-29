<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.exam.vo.OpenboardVo"%>
<%@page import="java.util.List"%>
<%@page import="com.exam.dao.OpenboardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>  
<%
// pageNum 파라미터값 가져오기
String strPageNum = request.getParameter("pageNum");

// strPageNum 값이 null이면 "1"로 수정하기 (디폴트값을 "1"로 설정)
strPageNum = (strPageNum==null) ? "1" : strPageNum ;
// 문자열 페이지번호를 정수형으로 변환하기
int pageNum = Integer.parseInt(strPageNum);

// DAO 객체 준비
OpenboardDao dao = new OpenboardDao();

int totalCount = dao.countAll(); // 전체 글갯수

int pageSize = 15;
// 시작행 인덱스번호 구하기 수식
int startRow = (pageNum-1) * pageSize; //오라클은 인덱스시작 1부터 (pageNum-1)*pageSize +1

// 글목록 가져오기
List<OpenboardVo> list = dao.getOpenboards(startRow,pageSize);

%>    
<!DOCTYPE html>
<html>
<head>
<%-- head 컨텐트 영역 --%>
<jsp:include page="/include/headContent.jsp"/>
<link href="/css/subpage.css" rel="stylesheet" type="text/css"  media="all">
<style>
span.level {
	display: inline-block; /* 크기지정이 가능하면서 인라인배치 */
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
		
	<h1>공개 게시판 [총 글갯수: <%=totalCount %>]</h1>
		
	<table id="notice">
		<tr>
			<th scope="col" class="tno">글번호</th>
			<th scope="col" class="ttitle">제목</th>
			<th scope="col" class="twrite">작성자</th>
			<th scope="col" class="tdate">작성일</th>
			<th scope="col" class="tread">조회</th>
		</tr>
		<%
		if (totalCount > 0){
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
			
			for (OpenboardVo vo : list) {
				%>
			<tr>
			<td><%=vo.getNum() %></td>
			<td class="left">
				<%
				if (vo.getReLev() > 0) {
					%>
					<span class="level" style="width: <%=vo.getReLev()*10 %>px"></span>
					<img src="/images/center/re.gif">
					<%
				}
				%>
				<a href="content.jsp?num=<%=vo.getNum() %>&pageNum=<%=pageNum %>">
				<%=vo.getSubject() %></a>
			</td>
			<td><%=vo.getName() %></td>
			<td><%=sdf.format(vo.getRegDate()) %></td>
			<td><%=vo.getReadcount() %></td>
			</tr>
				<%
			}// for
			
				
		} else { // totalCount == 0
			%>
			<tr>
				<td colspan="5">게시판 글이 없습니다.</td>
			</tr>			
			<%			
		}
		%>
		                
	</table>

	<div id="table_search">
		<input name="" type="text" class="input_box"> 
		<input type="button" value="Search" class="btn">
		<input type="button" value="글쓰기" class="btn" onclick="location.href = 'writeForm.jsp'">		
	</div>
	
	<div class="clear"></div>
	<div id="page_control">
		<%
		if (totalCount > 0) {
			// 총 페이지 갯수 구하기
			// 글50개. 한페이지에 보여줄 글갯수 10개. 50/10 -> 5 페이지
			// 글55개. 한페이지에 보여줄 글갯수 10개. 55/10 -> 5 + 1(나머지 있으면) -> 6페이지
			// int pageCount = (totalCount / pageSize) + ( totalCount % pageSize == 0 ? 0 : 1 );
			int pageCount = (int) Math.ceil((double) totalCount / pageSize); //올림
			
			// 화면에 보여줄 페이지번호 갯수 설정
			int pageBlock = 10;
			
			// 페이지블록의 시작페이지 번호 구하기
			// 1~10  11~20  21~30
			
			//         시작페이지번호
			// 1~10  -> 1
			// 11~20 -> 11
			// 21~30 -> 21
			
			// 페이지블록의 시작페이지번호 구하기 수식
			int startPage = ((pageNum / pageBlock) -(pageNum % pageBlock == 0 ? 1 : 0)) * pageBlock + 1;
			// 페이지블록의 끝페이지번호 구하기
			int endPage = startPage + pageBlock -1;
			if (endPage > pageCount) {
				endPage = pageCount;
			}
			
			// [이전]
			if (startPage > pageBlock) {
				%>
				<a href="openboard.jsp?pageNum=<%=startPage - pageBlock %>">[이전]</a>
				<%
			}
			
			// 페이지블록의 시작페이지부터 끝페이지까지 페이지번호 출력하기
			for (int i=startPage; i<=endPage; i++) {
				%>
				<a href="openboard.jsp?pageNum=<%=i%>">
				<%
				if (i == pageNum) {
					%>
					<span style="font-weight: bold; color: red;"><%=i %></span>
					<%
				} else {
					%>
					<%=i %><%
				}
				%>
				</a>
				<%
			}
			
			// [다음]
			if (endPage < pageCount) {
				%>
				<a href="openboard.jsp?pageNum=<%=startPage + pageBlock %>">[다음]</a>
				<%
			}						
		}		
		%>
		
	</div>
		
	</article>
    
	<div class="clear"></div>
	<%-- footer 영역 --%>
	<jsp:include page = '/include/bottomFooter.jsp' />
</div>

</body>
</html>   

