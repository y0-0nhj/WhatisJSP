<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 로그인 폼</title>
<link href="etc/managerLoginForm.css" rel="stylesheet" type="text/css">
<script src="etc/managerLoginForm.js"></script>
</head>
<body>
<div id="container">
	<h2>관리자 로그인</h2>
	<form action="managerLoginPro.jsp" method="post" name="managerLoginForm" onsubmit="return formCheck()" >
		<ul>
			<li>
				<label for="id">아이디</label>
				<input type="text" name="id" id="id" maxlength="50">
			</li>
			<li>
				<label for="passwd">비밀번호</label>
				<input type="password" name="passwd" id="passwd" maxlength="16"><br>
			</li>
			<li>
				<input type="submit" value="로그인">
			</li>
		</ul>
	</form>
</div>
</body>
</html>