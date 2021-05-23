<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 로그아웃 처리</title>
</head>
<body>
<%
// 1. 아이디 세션 삭제
session.removeAttribute("id");

// 2. 화면 이동
out.print("<script>alert('로그아웃 되었습니다.'); location='../shop/shopMain.jsp'</script>");
%>
</body>
</html>