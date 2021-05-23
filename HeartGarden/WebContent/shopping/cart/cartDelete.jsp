<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.cart.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니 삭제 처리</title>
</head>
<body>
<%
// cart_id가 1이면 전체 장바구니 삭제, cart_id가 양수값이라면 해당 장바귄 한개 삭제
int cart_id = Integer.parseInt(request.getParameter("cart_id"));
String product_kind = request.getParameter("product_kind");
String buyer = (String)session.getAttribute("id");

CartDBBean cartPro = CartDBBean.getInstance();

if(cart_id == -1) cartPro.deleteCart(buyer);
else cartPro.deleteCart(cart_id);

response.sendRedirect("cartList.jsp?product_kind=" + product_kind);



%>
</body>
</html>