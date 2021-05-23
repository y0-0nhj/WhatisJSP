<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.master.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 로그인 처리</title>
</head>
<body>
<%
	String id = request.getParameter("id");
	String passwd = request.getParameter("passwd");
	
	ProductDBBean dbPro = ProductDBBean.getInstance();
	int check = dbPro.managerCheck(id, passwd);
	
	// 아이디 존재, 비밀번호 일치: x=1 --> session 생성
	// 아이디 존재, 비밀번호 불일치 x=0
	// 아이디 존재하지 않음: x=-1
	if(check == 1) {
		session.setAttribute("managerId", id); // session 생성
		response.sendRedirect("../managerMain.jsp");
	} else if(check == 0) {
		out.print("<script>alert('비밀번호가 일치하지 않습니다.'); history.go(-1);</script>");
	} else if(check == -1) {
		out.print("<script>alert('입력하신 아이디는 존재하지 않습니다.'); history.go(-1);</script>");
	}
%>
</body>
</html>