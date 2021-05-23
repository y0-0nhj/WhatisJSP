<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.buy.*, java.util.*, java.text.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>구매번호에 따른 구매목록</title>
<style>
<link href="https://fonts.googleapis.com/css2?family=Noto+Serif+KR&display=swap" rel="stylesheet">
<style type="text/css">
#container { width: 1850px; margin: 0 auto;}
h2 { text-align: center; font-family: 'Noto Serif KR';}
table { width: 1000px; margin: 0 auto; border: 1px solid lightgray; border-collapse: collapse;  font-size: 0.9em; }
th { border: 1px solid lightgray; background: #F6F6F6; color: #ED9595; }
tr, td { border: 1px solid lightgray; }
.title { padding-left: 10px;}
.price { padding-right: 10px;}
</style>
</head>
<body>
<%@ include file="../common/shopTop.jsp" %>
<%
// 아이디 세션이 없을 때 (로그인 하지 않았을 때)
if(id == null || id.equals("")) {
	out.print("<script>alert('로그인을 해주세요.'); location='../member/memberLoginForm.jsp'</script>");
}

// 아이디 세션이 있을 때 (로그인을 했을 때)
String buy_id = request.getParameter("buy_id");

// Buy DB 연동
BuyDBBean buyPro = BuyDBBean.getInstance();
List<BuyDataBean> buyList = buyPro.getBuyListId(buy_id);
int count = 0;
DecimalFormat df = new DecimalFormat("#,###");
%>
<div id="container">
<br><br><br><br><br><br><br><br><br><br><br><br>
<h2>구매 상세 내역</h2>
<br><p>
<table>
	<tr>
		<th>번호</th>
		<th>상품사진</th>
		<th>상품명</th>
		<th>구매금액</th>
		<th>구매수량</th>
		<th>준비상태</th>
	</tr>
	<%for(BuyDataBean b : buyList) { 
		String path = "/image_products/" + b.getProduct_image();
	%>
	<tr>
		<td align="center"><%=++count %></td>
		<td align="center"><img src="<%=path %>" height="50"></td>
		<td class="title"><%=b.getProduct_name() %></td>
		<td class="price" align="right"><%=df.format(b.getBuy_price()) %></td>
		<td align="center"><%=b.getBuy_count() %></td>
		<td align="center"><%=b.getDelivery_state() %></td>
	</tr>
	<%} %>
</table>
<br><p>
</div>
<%@ include file="../common/shopBottom.jsp" %>
</body>
</html>