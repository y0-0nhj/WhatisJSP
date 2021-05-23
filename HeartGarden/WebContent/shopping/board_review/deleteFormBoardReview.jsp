<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글삭제 폼</title>
<link href="css/deleteForm.css" rel="stylesheet" type="text/css">
<script src="js/delete.js"></script>
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
%>
<h3>글삭제</h3>
<br>
<form action="deleteProBoardReview.jsp" method="post" name="delForm" onsubmit="return deleteSave()">
<input type="hidden" name="num" value="<%=num %>">
<input type="hidden" name="pageNum" value="<%=pageNum %>">
<table>
	<tr>
		<th>비밀번호 확인</th>
	</tr>
	<tr>
		<td>비밀번호 : <input type="password" name="passwd" size="8" maxlength="12"></td>
	</tr>
	<tr>
		<th>
		<input type="submit" id="btn" value="글삭제">
		<input type="button" id="btn" value="글목록" 
		onclick="location='../shop/shopContent.jsp?pageNum=<%=pageNum%>&product_id=<%=p_id%>&product_kind=null'">
		</th>
	</tr>
</table>
</form>
</div>
<%@ include file="../common/shopBottom.jsp" %>
</body>
</html>