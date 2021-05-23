<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.board_review.*, java.util.*, java.text.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 목록</title>
<style>
/* list.jsp css 설정 */
#container2 { width: 1000px; margin: 0 auto; font-size: 0.8em;}
#container2 h2 { text-align: center; font-family: 'Noto Serif KR'; color: lightblack; font-size: 2em;}
#container2 button { width: 70px; height:25px; background-color: #FF9999; color: white;
font-weight: bold; opacity: 0.7; padding: 2px; cursor: pointer;}
#container2 button:hover { background-color: #fbe8e8; color: #f9a9a9; font-weight: bold;}
#container2 table { width: 100%; border: 1px solid lightgray; border-collapse: collapse;
border-top: 2px solid #f9a9a9; border-bottom: 2px solid #f9a9a9; border-left: hidden; border-right: hidden;}
#container2 th, .review td { border: 1px solid lightgray;}
#container2 tr { height: 30px;}
#container2 th { font-weight: normal;}
#container2 .td_subject { padding-left: 10px;}
#container2 .tr_first { border-bottom: 2px solid #f9a9a9; background-color:  #FF9999;}
#container2 .tr_content1 { background-color: #fff2f2;}
#container2 .tr_content2 { background-color: white;}

/* a태그 설정 */
#container2 a { text-decoration: none; color: black;}
#container2 a:hover { color: pink;}

/* 첫번째 테이블 테두리 삭제 */
#container2 .table1 { border: none; margin-bottom: 10px;}
#container2 .table1 td { border: none;}

/* paging */
#container2 #paging { margin-top: 10px; text-align: center;}
#container2 #pbox { display: inline-block; width: 25px; height: 25px; border-radius: 12.5px; 
margin-left: 2px; margin-right: 2px; font-size: 0.8em; text-align: center; line-height: 25px;}
#container2 .pagebox1 { border: 1px solid #f9a9a9; background-color: pink; color: white; font-weight: bold; opacity: 0.7;}
#container2 .pagebox2 { border: 1px solid lightgray; color: gray; }
</style>
<!-- <link href="css/list.css" rel="stylesheet" type="text/css"> -->
</head>
<body>
<div id="container2">
<br><br><br><br><br><br><br><br><br><br><br><br>
	<%
	int pageSize = 10; // 페이지 사이즈, 한 페이지에서 보여줄 글수
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	String pageNum = request.getParameter("pageNum"); // 페이지 번호
	
	if(pageNum == null) pageNum = "1";
	
	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage - 1) * pageSize + 1; // 페이지의 첫번째 글
	int endRow = currentPage * pageSize;			 // 페이지의 마지막 글
	int count = 0; // 전체 글수
	int number = 0; // 전체 글수 역순 번호
	
	// product_id 세션 받음
	String p_id = (String)session.getAttribute("p_id");
	
	List<BoardReviewDataBean> articleList = null;
	BoardReviewDBBean dbPro = BoardReviewDBBean.getInstance();
	count = dbPro.getArticleCount(p_id); // 전체 글수 (product_id 별로)
	
	if(count > 0) articleList = dbPro.getArticles(startRow, pageSize, p_id);
	// 전체 글수 역순 번호 - 현재 페이지마다 달라서 매번 계산
	number = count - (currentPage - 1) * pageSize;
	// 전체 페이지 수
	int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
	%>
	<h2>상품 후기</h2>
	<table class="table1">
		<tr>
			<td><%=currentPage%>/<%=pageCount%>페이지 (글수: <%=count%>건)</td>
			<td align="right">
			<button onclick="location='../board_review/writeFormBoardReview.jsp'">글쓰기</button>
			</td>
		</tr>
	</table>
	
	<%
		if(count == 0) {
		%> <%-- 글이 없을 때 --%>
		<table><tr><td align="center">게시판에 저장된 글이 없습니다.</td></tr></table>
	<%
		} else {
	%> <%-- 글이 있을 때 --%>
		<table>
			<tr class="tr_first">
				<th width="8%">번호</th>
				<th width="50%">제목</th>
				<th width="14%">작성자</th>
				<th width="20%">작성일</th>
				<th width="8%">조회수</th>
			</tr>
			<%
				for(int i=0; i<articleList.size(); i++) {
					BoardReviewDataBean article = articleList.get(i);
					String color= "";
					if(i%2 != 0) color = "tr_content1";
					else color = "tr_content2";
			%>
			<tr class="<%=color%>">
				<td align="center"><%=number-- %></td>
				<td class="td_subject">
				<%
				int level = article.getRe_level();
				if(level > 0) { // 댓글일 때 단계별로 왼쪽 마진 적용
					out.print("<span style='margin-left: " + (level*15) + "px;'></span>");		
				
					// 댓글일 때 단계별로 댓글이미지 적용
					if(level%3 == 1) out.print("<img src='images/re01.png'>");
					else if(level%3 == 2) out.print("<img src='images/re02.png'>");
					else if(level%3 == 0) out.print("<img src='images/re03.png'>");
				}
				%>			
				<a href="../board_review/contentBoardReview.jsp?num=<%=article.getNum()%>&pageNum=<%=currentPage%>">
				<%=article.getSubject() %></a>
				<% if(article.getReadcount() >= 20) {%>
					<img src="images/icon01.gif" height="12">
				<%}%>
				</td>
				<td align="center"><%=article.getWriter() %></td>
				<td align="center"><%=sdf.format(article.getReg_date()) %></td>
				<td align="center"><%=article.getReadcount() %></td>
			</tr>
			<%}%>
		</table>
	<%} %>
	
	<%--
	pageCount : 전체 페이지수
	currentPage : 현재 페이지
	startPage : 현재 페이지 아래쪽에 페이징되는 첫번째 글
	endPage : 현재 페이지 아래쪽에 페이징되는 마지막 글
	pageBlock : 페이징 처리에서 보여지는 페이지 블럭의 수
	 --%>
	
	<div id="paging">
	<%
	// 페이징 처리(paging)
	if(count > 0) {
		int startPage = 1;
		
		if(currentPage%10 != 0) startPage = (int)(currentPage/10)*10 + 1;
		else startPage = ((int)(currentPage/10)-1)*10 + 1;
		
		int pageBlock = 10; // 페이징처리에서 보여질 페이지 블럭의 수
		int endPage = startPage + pageBlock - 1;
		
		if(endPage > pageCount) endPage = pageCount;
		
		if(startPage > 10) {
			out.print("<a href='listBoardReview.jsp?pageNum=" + (startPage-10) 
					+ "'><div id='pbox' class='pagebox2'>&lt</div></a>");
		}
		for(int i=startPage; i<=endPage; i++) {
			if (i == currentPage) { // 해당 페이지 선택 상태
				out.print("<div id='pbox' class='pagebox1'>" + i + "</div>");
			} else { // 선택되지 않은 상태
				out.print("<a href='listBoardReview.jsp?pageNum=" + i 
				+ "'><div id='pbox' class='pagebox2'>" + i + "</div></a>");
			}
		}
		if(endPage < pageCount) {
			out.print("<a href='listBoardReview.jsp?pageNum=" + (startPage+10) 
					+ "'><div id='pbox' class='pagebox2'>&gt</div></a>");
		}
	}%>
	</div>
</div>
</body>
</html>