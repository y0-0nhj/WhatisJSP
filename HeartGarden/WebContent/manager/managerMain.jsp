<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 메인</title>
<link href="etc/managerMain.css" rel="stylesheet" type="text/css">
</head>
<body>
<div id="container">
	<%
	String managerId= (String)session.getAttribute("managerId");
	
	//세션이 없을 때
	if(managerId == null || managerId.equals("")) { 
		response.sendRedirect("logon/managerLoginForm.jsp");
	} else {
	
	// managerId의 세션이 있을 때 
	%>
	<p><span><%=managerId%></span>님이 상품관리 중입니다.</p>
	<p><button onclick="location='logon/managerLogout.jsp'">로그아웃</button></p>
	
	<table>
		<tr class="tr_title"><th>상품 관리</th></tr>
		<tr><td><a href="productProcess/productRegisterForm.jsp">상품 등록</a></td></tr>
		<tr><td><a href="productProcess/productList.jsp?product_kind=all">상품 전체 보기(수정/삭제)</a></td></tr>
		<tr></tr>
		<tr class="tr_title"><th>구매 상품 관리</th></tr>
		<tr><td><a href="orderedProduct/orderedList.jsp">전체 구매목록 확인</a></td></tr>
		<tr></tr>
		<tr class="tr_title"><th>회원 관리</th></tr>
		<tr><td><a href="registedMember/memberList.jsp">전체 회원목록 확인</a></td></tr>
	</table>
	<%} %>
</div>
</body>
</html>