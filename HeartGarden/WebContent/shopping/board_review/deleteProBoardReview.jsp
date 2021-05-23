<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.board_review.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글삭제 처리</title>
</head>
<body>
<%
int num = Integer.parseInt(request.getParameter("num"));
String pageNum = request.getParameter("pageNum");
String passwd = request.getParameter("passwd");

// p_id 세션 받음
String p_id = (String)session.getAttribute("p_id");

BoardReviewDBBean dbPro = BoardReviewDBBean.getInstance();
int check = dbPro.deleteArticle(num, passwd);

if(check == 1) { // 비밀번호가 일치할 때
	response.sendRedirect("../shop/shopContent.jsp?pageNum=" + pageNum 
	+ "&product_id=" + p_id + "&product_kind=null");
} else { // 비밀번호가 일치하지 않을 때, -1, 0
	out.print("<script>alert('비밀번호가 일치하지 않습니다.'); history.go(-1);</script>");
}
%>
</body>
</html>