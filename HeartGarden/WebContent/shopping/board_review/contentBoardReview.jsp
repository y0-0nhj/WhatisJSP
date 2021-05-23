<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.board_review.*, java.text.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글상세 보기</title>
<link href="css/content.css" rel="stylesheet" type="text/css">
</head>
<body>
<%@ include file="../common/shopTop.jsp" %>

<div id="container">
<br><br><br><br><br><br><br><br><br><br><br><br>
<%
// p_id 세션 받음
String p_id = (String)session.getAttribute("p_id");

int num = Integer.parseInt(request.getParameter("num"));
String pageNum = request.getParameter("pageNum");
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");

BoardReviewDBBean dbPro = BoardReviewDBBean.getInstance();
BoardReviewDataBean article = dbPro.getArticle(num);

int ref = article.getRef();
int re_step = article.getRe_step();
int re_level = article.getRe_level();
%>
<h3>상품후기 상세</h3>
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
	 	<th>상품이름</th><td colspan="3"><%=article.getSubject() %></td>
	 </tr>
	 <tr>
	 	<th>글내용</th><td colspan="3"><%=article.getContent() %></td>
	 </tr>
	 <tr class="tr_btn">
	 	<td colspan="4">
	 	<input type="button" value="리뷰 수정" 
	 	onclick="location='updateFormBoardReview.jsp?num=<%=num%>&pageNum=<%=pageNum%>'">
	 	<input type="button" value="리뷰 삭제" 
	 	onclick="location='deleteFormBoardReview.jsp?num=<%=num%>&pageNum=<%=pageNum%>'">
	 	<input type="button" value="댓글쓰기" 
	 	onclick="location='writeFormBoardReview.jsp?num=<%=num%>&ref=<%=ref%>&re_step=<%=re_step%>&re_level=<%=re_level%>'">
	 	<input type="button" value="리뷰 목록" 
	 	onclick="location='../shop/shopContent.jsp?pageNum=<%=pageNum%>&product_id=<%=p_id%>&product_kind=null'">
	 	</td>
	 </tr>
</table>
</div>
<%@ include file="../common/shopBottom.jsp" %>
</body>
</html>