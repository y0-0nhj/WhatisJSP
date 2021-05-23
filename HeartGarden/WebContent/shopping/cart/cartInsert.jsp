<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.master.*, shop.cart.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니 추가</title>
</head>
<body>
<%
// 아이디 세션 확인 - 아이디 세션이 없다면 로그인 기능부터 실행하도록 설정
String id = (String)session.getAttribute("id");
if(id == null || id.equals("")) { 
	out.print("<script>alert('로그인을 해주세요.'); location='../member/memberLoginForm.jsp'</script>");
}
//상품 정보 추출
int product_id = Integer.parseInt(request.getParameter("product_id"));
int buy_price = Integer.parseInt(request.getParameter("buy_price"));
int buy_count = Integer.parseInt(request.getParameter("buy_count"));

//product DB 연동
ProductDBBean productPro = ProductDBBean.getInstance();
ProductDataBean product = productPro.getProduct(product_id);
String product_name = product.getProduct_name();
String product_image = product.getProduct_image1();
String product_kind = product.getProduct_kind();

//cart 객체 생성
CartDataBean cart = new CartDataBean();
cart.setBuyer(id); // 세션
cart.setProduct_id(product_id);
cart.setProduct_name(product_name);
cart.setProduct_image(product_image);
cart.setBuy_price(buy_price);
cart.setBuy_count(buy_count);

//cart DB 연동
CartDBBean cartPro = CartDBBean.getInstance();
int count = cartPro.insertCart(cart);

//화면 이동
if(count == 1) { // 장바구니 추가 성공
	out.print("<script>alert('장바구니에 추가하였습니다.'); location='cartList.jsp?=product_kind="+ product_kind +"'</script>");
} else if(count == 0) { // 장바구니 추가 실패
	out.print("<script>alert('장바구니 추가에 실패하였습니다.'); history.back();</script>");
}
%>
</body>
</html>