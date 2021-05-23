<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.board_review.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글수정 폼</title>
<link href="css/updateForm.css" rel="stylesheet" type="text/css">
<script src="js/update.js"></script>
</head>
<body>
<%@ include file="../common/shopTop.jsp" %>
<div id="container">
<br><br><br><br><br><br><br><br><br><br><br><br>
<%
int num = Integer.parseInt(request.getParameter("num"));
String pageNum = request.getParameter("pageNum");

// p_id 세션 받음
String p_id = (String)session.getAttribute("p_id");
// p_title 세션 받음
String p_name = (String)session.getAttribute("p_name");

BoardReviewDBBean dbPro = BoardReviewDBBean.getInstance();
BoardReviewDataBean article = dbPro.getArticle(num);
%>
<h3>상품후기 수정</h3>
<form action="updateProBoardReview.jsp" method="post" name="updateForm" onsubmit="return updateSave()">
<input type="hidden" name="num" value="<%=num%>">
<input type="hidden" name="pageNum" value="<%=pageNum%>">
<input type="hidden" name="product_id" value="<%=p_id%>">
<table>
	<tr>
		<th>상품명</th>
		<td>&nbsp;<%=p_name%></td>
	</tr>
	<tr>
		<th>글제목</th>
		<td><input type="text" name="subject" size="43" value="<%=article.getSubject()%>"></td>
	</tr>
	<tr>
		<th>글내용</th>
		<td><textarea rows="13" cols="42" name="content"><%=article.getContent() %></textarea></td>
	</tr>
	<tr>
		<th align="center">비밀번호</th>
		<td>
			<input type="password" size="8" maxlength="12" name="passwd">
		</td>
	</tr>
	<tr>
		<th colspan="2">
			<input type="submit" id="btn" value="리뷰 수정">
			<input type="button" id="btn" value="리뷰 목록" 
			onclick="location='../shop/shopContent.jsp?pageNum=<%=pageNum%>&product_id=<%=p_id%>&product_kind=null'">
		</th>
	</tr>
</table>
</form>
</div>
<%@ include file="../common/shopBottom.jsp" %>
</body>
</html>