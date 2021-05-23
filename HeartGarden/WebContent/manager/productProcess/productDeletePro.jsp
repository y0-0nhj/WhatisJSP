<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.master.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 삭제 처리</title>
</head>
<body>
<%
	int product_id = Integer.parseInt(request.getParameter("product_id"));
	String product_kind = request.getParameter("product_kind");
	
	ProductDBBean dbPro = ProductDBBean.getInstance();
	dbPro.deleteProduct(product_id);
	
	response.sendRedirect("productList.jsp?product_kind=" + product_kind);
%>
</body>
</html>