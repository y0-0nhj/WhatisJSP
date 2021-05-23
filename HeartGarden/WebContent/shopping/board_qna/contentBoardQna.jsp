<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.board_qna.*, java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글상세 보기</title>
<link href="css/content.css" rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css2?family=Noto+Serif+KR&display=swap" rel="stylesheet">
</head>
<body>
<%@ include file="../common/shopTop.jsp" %>
<div id="container">
<br><br><br><br><br><br><br><br><br><br><br><br>
<%
int num = Integer.parseInt(request.getParameter("num"));
String pageNum = request.getParameter("pageNum");
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");

BoardQnaDBBean dbPro = BoardQnaDBBean.getInstance();
BoardQnaDataBean article = dbPro.getArticle(num);

int ref = article.getRef();
int re_step = article.getRe_step();
int re_level = article.getRe_level();
%>
<h3>글내용 보기</h3>
<table>
	 <tr>
	 	<th width="16%">글번호</th>
	 	<td width="30%"><%=article.getNum() %></td>
	 	<th width="16%">조회수</th>
	 	<td width="38%"><%=article.getReadcount() %></td>
	 </tr>
	 <tr>
	 	<th>작성자</th><td><%=article.getWriter() %></td>
	 	<th>작성일</th><td><%=sdf.format(article.getReg_date()) %></td>
	 </tr>
	 <tr>
	 	<th>글제목</th><td colspan="3"><%=article.getSubject() %></td>
	 </tr>
	 <tr>
	 	<th>글내용</th><td colspan="3"><br><%=article.getContent() %><br><br><br></td>
	 </tr>
	 <tr class="tr_btn">
	 	<td colspan="4">
	 	<input type="button" value="글수정" 
	 	onclick="location='updateFormBoardQna.jsp?num=<%=num%>&pageNum=<%=pageNum%>'">
	 	<input type="button" value="글삭제" 
	 	onclick="location='deleteFormBoardQna.jsp?num=<%=num%>&pageNum=<%=pageNum%>'">
	 	<input type="button" value="댓글쓰기" 
	 	onclick="location='writeFormBoardQna.jsp?num=<%=num%>&ref=<%=ref%>&re_step=<%=re_step%>&re_level=<%=re_level%>'">
	 	<input type="button" value="글목록"  onclick="location='listBoardQna.jsp?pageNum=<%=pageNum%>'">
	 	</td>
	 </tr>
</table>
<br><br>
</div>
<%@ include file="../common/shopBottom.jsp" %>
</body>
</html>