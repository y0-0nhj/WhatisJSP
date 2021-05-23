<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.board_qna.*" %>
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

BoardQnaDBBean dbPro = BoardQnaDBBean.getInstance();
int check = dbPro.deleteArticle(num, passwd);

if(check == 1) { // 비밀번호가 일치할 때
	response.sendRedirect("listBoardQna.jsp?pageNum=" + pageNum);
} else { // 비밀번호가 일치하지 않을 때, -1, 0
	out.print("<script>alert('비밀번호가 일치하지 않습니다.'); history.go(-1);</script>");
}
%>
</body>
</html>