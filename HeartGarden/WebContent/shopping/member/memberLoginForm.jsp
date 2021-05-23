<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 로그인 폼</title>
<style>
#container { width: 1000px; margin: 0 auto;  font-family: 'Noto Serif KR';}
h2 { text-align: center; margin:0px; padding:0px; }
table { width: 0px; margin: 0 auto; padding:80px 50px 80px 50px; margin-bottom: 100px; border: 1px solid lightgray;}
#textarea { width: 250px; height:25px; border:none; border-bottom: 1px solid lightgray; border-collapse: collpase; outline:none; cursor: text; }
#login { width: 260px; height:30px; background: #FFB9B9; color: white; border:0; border-collapse: collapse; outline:1px; cursor: pointer;  }
#welcome { color: gray; padding:0px; margin-top: 0px; text-align: center;  }
</style>
</head>
<body>
<script>
function memberLoginCheck() {
	var form = document.memberLoginForm;
	
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
	
	return true;
}
</script>
</head>
<body>
<%@ include file="../common/shopTop.jsp" %>

<div id="container">
<br><br><br><br><br><br><br><br><br><br><br><br>
<br><br>
<form action="memberLoginPro.jsp" method="post" name="memberLoginForm" onsubmit="return memberLoginCheck()">
<table>
	<tr><td><h2>LOGIN</h2></td>
	<tr><td><h3 id="welcome">WELCOME BACK</h3></td>
	<tr><td><input id="textarea" type="text" name="id" placeholder="아이디"></td></tr>
	<tr><td><input id="textarea" type="password" name="passwd" placeholder="비밀번호"></td></tr>
	<tr><td><input id="login" type="submit" value="로그인"></td></tr>
</table>
</form>
</div>
<%@ include file="../common/shopBottom.jsp" %>
</body>
</html>