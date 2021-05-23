<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.board_qna.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글수정 폼</title>
<link href="https://fonts.googleapis.com/css2?family=Noto+Serif+KR&display=swap" rel="stylesheet">
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

BoardQnaDBBean dbPro = BoardQnaDBBean.getInstance();
BoardQnaDataBean article = dbPro.getArticle(num);
%>
<h3>글수정</h3>
<form action="updateProBoardQna.jsp" method="post" name="updateForm" onsubmit="return updateSave()">
<input type="hidden" name="num" value="<%=num%>">
<input type="hidden" name="pageNum" value="<%=pageNum%>">
<table>
	<tr>
		<th width="70">QnA 분류</th>
		<td width="330">
		<select name="q_kind">
			<option value="상품">상품</option>
			<option value="배송">배송</option>
			<option value="결제">결제</option>
			<option value="반송">반송</option>
			<option value="서비스">서비스</option>
			<option value="기타">기타</option>
		</select>
		</td>
	</tr>
	<tr>
		<th>제목</th>
		<td><input type="text" name="subject" size="43" value="<%=article.getSubject()%>"></td>
	</tr>
	<tr>
		<th>내용</th>
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
			<input type="submit" id="btn" value="글수정">
			<input type="button" id="btn" value="목록보기" onclick="location='listBoardQna.jsp?pageNum=<%=pageNum%>'">
		</th>
	</tr>
</table>
</form>
</div>
<%@ include file="../common/shopBottom.jsp" %>
</body>
</html>