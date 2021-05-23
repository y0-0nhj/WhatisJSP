<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 가입 페이지</title>
<link href="https://fonts.googleapis.com/css2?family=Noto+Serif+KR&display=swap" rel="stylesheet">
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script> 
</head>
<style>
#container { width: 1850px; margin: 0 auto;  font-family: 'Noto Serif KR';}
h2 { text-align: center; color: dark; font-size:1.5em;  font-family: 'Noto Serif KR';}
table { width: 1000px; margin: 0 auto;  border-collapse: collapse; }
th { background: #F6F6F6; font-weight: 400;}
td { background: white;}
th, td { border-top: 1px solid lightgray; border-bottom: 1px solid lightgray; }
tr { height: 50px;}
.btnCheck, .btnAddress { border: 0; background: #FFEAEA; color: #ED9595; width: 120px; height: 30px; cursor: pointer;
border-radius: 5px; }
span { color: gray; font-size:0.8em; }
#star { color: blue; }
input { margin-left: 10px; }
p { text-align: center;}
p input { border: 0; background: #FFEAEA; color: #ED9595; width: 120px; height: 40px; cursor: pointer; }
p input:hover { background: #F6F6F6; color: pink; font-weight: bold;}
</style>
<body>
<%  %>
<script>
// 각 input 필드에 대한 유효성 검사
function memberJoinCheck() {
	var form = document.memberJoinForm;
	
	if(form.id.value.length == 0) {
		alert('아이디를 입력해 주세요.');
		form.id.focus();
		return false;
	}
	
	if(form.passwd.value.length == 0) {
		alert('비밀번호를 입력해 주세요.');
		form.passwd.focus();
		return false;
	}
	
	if(form.passwd2.value.length == 0) {
		alert('비밀번호 확인을 입력해 주세요.');
		form.passwd2.focus();
		return false;
	}
	
	if(form.passwd.value != form.passwd2.value) {
		alert('비밀번호가 일치하지 않습니다.\n비밀번호를 다시 입력해 주세요.');
		form.passwd.focus();
		return false;
	}
	
	if(form.name.value.length == 0) {
		alert('이름을 입력해 주세요.');
		form.name.focus();
		return false;
	}
	
	if(form.address.value.length == 0) {
		alert('주소를 입력해 주세요.');
		form.address.focus();
		return false;
	}
	
	if(form.tel.value.length == 0) {
		alert('전화번호를 입력해 주세요.');
		form.tel.focus();
		return false;
	}
	
	return true;
}

// 주소 찾기 기능 - 다음 라이브러리 활용
function searchAddress() {
	var form = document.memberJoinForm;
	
	new daum.Postcode({
		oncomplete:function(data) {
			form.address.value = data.address;
		}
	}).open();
}

// 중복 아이디 체크
function checkId() {
	var id = document.querySelecter("#id").value;
}
</script>
</head>
<body>
<%@ include file="../common/shopTop.jsp" %>
<div id="container">
<br><br><br><br><br><br><br><br><br><br><br><br>
<h2>회원 가입</h2>
<br>
<form action="memberJoinPro.jsp" method="post" name="memberJoinForm" 
onsubmit="return memberJoinCheck()">
<table>
	<tr>
		<th width="25%">아이디<span id="star">*</span></th>
		<td width="75%">
		<input type="text" name="id" id="id" maxlength="20" size="20">  <span>(영문소문자/숫자, 4~16자)</span>
		<input type="button" value="중복 아이디 체크" class="btnCheck" onclick="checkId();" >
		</td>
	</tr>
	<tr>
		<th>비밀번호<span id="star">*</span></th>
		<td><input type="password" name="passwd" maxlength="16" size="20">  <span>(영문대소문자/숫자, 4~16자)</span></td>
	</tr>
	<tr>
		<th>비밀번호 확인<span id="star">*</span></th>
		<td><input type="password" name="passwd2" maxlength="16" size="20"></td>
	</tr>
	<tr>
		<th>이름<span id="star">*</span></th>
		<td><input type="text" name="name" maxlength="20" size="10"></td>
	</tr>
	<tr>
		<th>주소<span id="star">*</span></th>
		<td>
		<input type="text" name="address" maxlength="100" size="50"><input type="button" value="주소찾기" class="btnAddress" onclick="searchAddress()">
		</td>
	</tr>
	<tr>
		<th>전화번호<span id="star">*</span></th>
		<td><input type="text" name="tel" maxlength="20" size="30"></td>
	</tr>
</table>
<br>
<p>
	<input type="submit" value="회원가입">
	<input type="reset" value="다시쓰기">
</p>
</form>
</div>
<%@ include file="../common/shopBottom.jsp" %>
</body>
</html>