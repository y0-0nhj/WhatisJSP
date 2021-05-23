<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글등록 폼</title>
<link href="css/writeForm.css" rel="stylesheet" type="text/css">
<script src="js/write.js"></script>
</head>
<body>
<%@ include file="../common/shopTop.jsp" %>
<div id="container">
<br><br><br><br><br><br><br><br><br><br><br><br>
<%
// 아이디 세션이 없을 때 (로그인 하지 않았을 때)
if(id == null || id.equals("")) {
	out.print("<script>alert('로그인을 해주세요.'); location='../member/memberLoginForm.jsp'</script>");
}

// 아이디 세션이 있을 때 (로그인을 했을 때)
String buy_id = request.getParameter("buy_id");
// product_id 세션값 받음
String p_id = (String)session.getAttribute("p_id");
// product_title 세션값 받음
String p_name = (String)session.getAttribute("p_name");

int num = 0, ref = 1, re_step = 0, re_level = 0;
String strV = "";

if(request.getParameter("num") != null) {
	num = Integer.parseInt(request.getParameter("num"));
	ref = Integer.parseInt(request.getParameter("ref"));
	re_step = Integer.parseInt(request.getParameter("re_step"));
	re_level = Integer.parseInt(request.getParameter("re_level"));
}
%>
<h3>상품 후기 작성</h3>
<form action="writeProBoardReview.jsp" method="post" name="writeForm" onsubmit="return writeSave()">
<input type="hidden" name="num" value=<%=num %>>
<input type="hidden" name="ref" value=<%=ref %>>
<input type="hidden" name="re_step" value=<%=re_step %>>
<input type="hidden" name="re_level" value=<%=re_level %>>
<input type="hidden" name="product_id" value="<%=p_id %>">
<table>
	<tr>
		<th width="20%" align="center">작성자</th>
		<td width="80%">
		<input type="text" size="10" maxlength="10" name="writer" id="writer" value="<%=id %>" readonly>
		</td>
	</tr>
	<tr>
		<th align="center">상품 이름</th>
		<td>&nbsp;<%=p_name %></td>
	</tr>
	<tr>
		<th align="center">글제목</th>
		<td>
		<%
		if(request.getParameter("num") == null) strV = "";
		else strV="[답변] ";
		%>
		<input type="text" size="40" maxlength="50" name="subject" value="<%=strV %>">
		</td>
	</tr>
	<tr>
		<th align="center">내용</th>
		<td><textarea name="content" rows="13" cols="40"></textarea></td>
	</tr>
	<tr>
		<th align="center">비밀번호</th>
		<td>
			<input type="password" size="8" maxlength="12" name="passwd">
		</td>
	</tr>
	<tr>
		<td colspan="2" align="center">
			<input type="submit" value="후기작성" id="btn">
			<input type="reset" value="다시작성" id="btn">
			<input type="button" value="돌아가기" id="btn" 
			onclick="location='../shop/shopContent.jsp?product_id=<%=p_id%>&product_kind=null'">
		</td>
	</tr>
</table>
</form>
</div>
<%@ include file="../common/shopBottom.jsp" %>
</body>
</html>