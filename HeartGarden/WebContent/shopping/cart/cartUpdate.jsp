<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.cart.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니 수량 변경 처리</title>
</head>
<body>
<%
// 파라미터값 추출
int cart_id = Integer.parseInt(request.getParameter("cart_id"));
int buy_count = Integer.parseInt(request.getParameter("buy_count"));
String product_kind = request.getParameter("product_kind");

// DB 연동 처리
CartDBBean cartPro = CartDBBean.getInstance();
cartPro.updateCart(cart_id, buy_count);

response.sendRedirect("cartList.jsp?product_kind=" + product_kind);

%>
</body>
</html>