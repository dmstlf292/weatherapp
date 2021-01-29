<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%-- head 컨텐트 영역 --%>
<jsp:include page="/include/headContent.jsp" />
<link href="/css/subpage.css" rel="stylesheet" type="text/css"
	media="all">
</head>

<body>
	<div id="wrap">
		<%-- header 영역 --%>
		<jsp:include page="/include/topHeader.jsp" />

		<div class="clear"></div>
		<div id="sub_img_member"></div>

		<div class="clear"></div>
		<nav id="sub_menu">
			<ul>
				<li><a href="#">Join us</a></li>
				<li><a href="#">Privacy policy</a></li>
			</ul>
		</nav>

		<article>

			<h1>회원 가입</h1>
			<form id="join" action="joinPro.jsp" method="post" name="frm" onsubmit="return checkId()">
				<fieldset>
					<legend>기본 정보</legend>
					
					<label>사용자 ID</label> 
					<input type="text" class="id" name="id" required> 
					<input type="button" value="ID중복확인" class="dup" onclick="winopen()"><br>
					
					<label>패스워드 입력</label> 
					<input type="password" class="pass" name="passwd" id="pass1" required><br>
					<label>패스워드 재입력</label> 
					<input type="password" class="pass" id="pass2" onkeyup="checkPasswd()" required>
					<span id="messagePasswd"></span>
					<br> 
					
					<label>이름</label> 
					<input type="text" class="nick" name="name" required><br> 
					
					<label>이메일</label> 
					<input type="email" class="email" name="email" required><br> 
					<label>이메일 주소 재입력</label> 
					<input type="email" class="email" required><br>
				</fieldset>

				<fieldset>
					<legend>옵션 정보</legend>
					
					<label>주소</label> 
					<input type="text" class="address" name="address" required><br>
					
					<label>폰번호</label> 
					<input type="tel" class="phone" name="tel" required><br>
					
					<label>성별</label> 
					<input type="radio" class="mobile" name="gender" value="남" required>남성
					<input type="radio" class="mobile" name="gender" value="여" required>여성	<br>
					
					<label>나이</label> 
					<input type="number" class="mobile" name="age" min="0" max="150" required><br>
				</fieldset>

				<div class="clear"></div>
				<div id="buttons">
					<input type="submit" value="회원가입" class="submit">
					<input type="reset" value="새로작성" class="cancel">
				</div>
			</form>

		</article>

		<div class="clear"></div>
		<%-- footer 영역 --%>
		<jsp:include page='/include/bottomFooter.jsp' />
	</div>

<script>
	function winopen(){
		let id = document.frm.id.value;
		
		if (id ==''){
			alert('아이디를 입력 후 중복확인을 해주세요');
			document.frm.id.focus();
			return;
		}
		
	// 새 창 열어서 아이디중복확인 jsp요청  window.open()
	open('joinIdDupCheck.jsp?id=' + id,'dupCheck','width=500,height=400'); // 두번째 이름넣는부분이 ''이면 새창이 계속 뜸
	}// winopen
	
	
	// 패스워드 입력상자 pass1, pass2 문서객체 참조하기
	let pass1 = document.getElementById('pass1');
	let pass2 = document.getElementById('pass2');
	let spanPasswd = document.getElementById('messagePasswd');
	
	function checkPasswd(){
		if (pass1.value == pass2.value){
			spanPasswd.innerHTML = '패스워드가 일치합니다.';
			spanPasswd.style.color = 'green'; 
		}else {
			spanPasswd.innerHTML = '패스워드가 불일치!';
			spanPasswd.style.color = 'red';
		}
		
	}// checkPasswd
	
	
	function checkId() {
		let id = frm.id.value.trim();
		//아이디 글자수가 3개이상 12개 이하가 아니면 submit 허용안함
		if (!(id.length >= 3 && id.length <= 12)){
			alert('아이디 글자수는 3개 이상 12개 이하만 가능합니다.');
			frm.id.select();
			return false;
		}
	}// checkId
	
	
</script>

</body>
</html>
