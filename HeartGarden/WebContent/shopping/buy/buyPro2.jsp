<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.cart.*, shop.buy.*, java.util.*, java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>구매 처리</title>
</head>
<body>
<%
request.setCharacterEncoding("utf-8");

String buyer = (String)session.getAttribute("id");
String product_id = request.getParameter("product_id");
String product_name = request.getParameter("product_name");
String product_image = request.getParameter("product_image");
String buy_price = request.getParameter("buy_price");
String buy_count = request.getParameter("buy_count");
String delivery_name = request.getParameter("delivery_name");
String delivery_tel = request.getParameter("delivery_tel");
String delivery_address = request.getParameter("delivery_address");
String bank_info = request.getParameter("bank_info");

// 자바로 중복되지 않는 고유한 키값 생성 -> buy_id(구매번호)로 사용
// buy_id : 날짜8자리 + 고유한 키값 12자리 -> 20자리의 값으로 생성
// uuid를 문자열로 생성(12자리)
UUID uuid = UUID.randomUUID();
String uuid2 = uuid.toString().replace("-", "").substring(0,12);
// 구매날짜를 문자열로 생성(8자리)
Timestamp now = new Timestamp(System.currentTimeMillis());
String year = now.toString().substring(0, 4);
String month = now.toString().substring(5, 7);
String date = now.toString().substring(8, 10);
String now2 = year + month + date;
// 고유한 주문번호 생성
String buy_id = now2 + uuid2;

// CartDataBean 생성
List<CartDataBean> cartList = null;
CartDataBean cart = null;

// BuyDataBean 생성
List<BuyDataBean> buyList = new ArrayList<BuyDataBean>();
BuyDataBean buy = new BuyDataBean();
buy.setBuy_id(buy_id);
buy.setBuyer(buyer);
buy.setProduct_id(Integer.parseInt(product_id));
buy.setProduct_name(product_name);
buy.setProduct_image(product_image);
buy.setBuy_price(Integer.parseInt(buy_price));
buy.setBuy_count(Integer.parseInt(buy_count));
buy.setBuy_date(now);
buy.setBank_info(bank_info);
buy.setDelivery_name(delivery_name);
buy.setDelivery_tel(delivery_tel);
buy.setDelivery_address(delivery_address);
buy.setDelivery_state("상품 준비중");
buyList.add(buy);



// Buy DB 연동
// check: 0이면 구매 실패, 0이 아니면 등록
// 구매 등록이 되면, 장바구니에서는 삭제 -> 트랜잭션 처리가 되도록 함
BuyDBBean buyPro = BuyDBBean.getInstance();
int check =  buyPro.insertBuyList(buyList, null);

// 구매 성공과 실패
if(check != 0) { // 구매 성공
	out.print("<script>alert('구매에 성공하였습니다.\n구매 목록 페이지로 이동합니다.');</script>");
	out.print("<script>location='buyList.jsp';</script>");
} else { // 구매 실패
	out.print("<script>alert('구매에 실패하였습니다.\n이전 페이지로 이동합니다.');</script>");
	out.print("<script>history.back();</script>");
}
%>
</body>
</html>