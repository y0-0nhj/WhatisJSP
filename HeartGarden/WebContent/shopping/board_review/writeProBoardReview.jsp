<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.board_review.*, java.sql.Timestamp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글등록 처리</title>
</head>
<body>
<% request.setCharacterEncoding("utf-8");%>

<jsp:useBean id="article" class="shop.board_review.BoardReviewDataBean">
	<jsp:setProperty name="article" property="*"/>
</jsp:useBean>

<%
// product_id 세션 받음
String p_id = (String)session.getAttribute("p_id");

article.setReg_date(new Timestamp(System.currentTimeMillis()));
BoardReviewDBBean dbPro = BoardReviewDBBean.getInstance();
dbPro.insertArticle(article);
response.sendRedirect("../shop/shopContent.jsp?product_id=" + p_id + "&product_kind=null");
%>
</body>
</html>