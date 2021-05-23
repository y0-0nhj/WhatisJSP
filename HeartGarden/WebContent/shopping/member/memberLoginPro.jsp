<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.member.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 로그인 처리</title>
</head>
<body>
<%
String id = request.getParameter("id");
String passwd = request.getParameter("passwd");

MemberDBBean memberPro = MemberDBBean.getInstance();
int check = memberPro.userCheck(id, passwd);

if(check == 1) { // 아이디와 비밀번호 모두 일치
	session.setAttribute("id", id); // 장바구니, 주문에서 활용
	response.sendRedirect("../shop/shopMain.jsp");
} else if(check == 0) { // 아이디 일치, 비밀번호 불일치
	out.print("<script>alert('비밀번호가 일치하지 않습니다.'); history.back();</script>");
} else if(check == -1) { // 아이디 불일치
	out.print("<script>alert('아이디가 일치하지 않습니다.'); history.back();</script>");
}
%>
</body>
</html>