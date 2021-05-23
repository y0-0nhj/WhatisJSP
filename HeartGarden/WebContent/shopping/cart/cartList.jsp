<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.cart.*, java.util.*, java.text.*, shop.master.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니 리스트</title>
<link href="https://fonts.googleapis.com/css2?family=Noto+Serif+KR&display=swap" rel="stylesheet">
<style>
#container { width: 1850px; margin: 0 auto;}
h2 { text-align: center; font-family: 'Noto Serif KR';}
table { width:1000px; border-collapse: collapse; margin: 0 auto;}
th, td { border-bottom: 1px solid lightgray; font-weight: normal; color: gray; font-size: 0.8em; text-align: center; padding:10px;}
tr { height: 30px;}
th { background: white; color: black;}
a { text-decoration: none; color: black;}
.product_name { padding-left: 10px;}
.buy_price, .buy_sum { padding-right: 10px;}
input[type="submit"], input[type="button"] { border: 1px solid lightgray; width: 120px; height: 40px;
background: white; color: #ED9595; cursor: pointer; outline:none;}
.results{ width: 1400px; margin: 0 auto; height: 60px; line-height: 60px; text-align: right; font-family: 'Noto Serif KR'; margin-right:500px; }
.r_count, .r_amount { float: left; display: inline-block; width: 48%; padding-right:2%;  }
.r_amount {font-size: 1.2em; font-weight: bold; color: #A54D4D;}
#buy { background: #ED9595; color: white; border:0;}
#title_row { background: #F7E4DF; }
#cart_image { margin-left:-20px; }

.product_name { text-align: left; }
input[type="text"] { width: 30px; text-align:center; }
.acc input[type="button"], .acc input[type="submit"] { cursor: pointer; border: 1px solid lightgray;  width: 40px; height: 20px;}
.acc .btn_update { width: 10px; height: 5px; margin:5px; }
.acc .btn_order { background: #ED9595; color: white; margin-bottom: 5px; }
.acc .btn_order:hover { background: lightgray; color: #DB8383; margin-bottom: 5px; }
.acc .btn_delete { width: 10px; height: 5px; }

/* check박스 설정 */
#check_all {  }
#check_one {}

.btns { text-align: center; margin: 10px 0; }
</style>

<script src="https://code.jquery.com/jquery-3.4.1.js">
</script>
</head>

<body>
<%@ include file="../common/shopTop.jsp" %>

<%
// 아이디 세션이 없을 때 (로그인 하지 않았을 때)
if(id == null || id.equals("")) {
	out.print("<script>alert('로그인을 해주세요.'); location='../member/memberLoginForm.jsp'</script>");
}

// 아이디 세션이 있을 때 (로그인을 했을 때)
String product_kind = request.getParameter("product_kind");
CartDBBean cartPro = CartDBBean.getInstance();
int count = cartPro.getCartListCout(id); // 장바구니 목록 갯수
List<CartDataBean> cartList = cartPro.getCartList(id, -1); // 장바구니 목록
DecimalFormat df = new DecimalFormat("#,###");
int n1 = 0, n2 = 0, tot_price = 0; // n1: 카트 갯수, n2: 전체 상품수, tot_price: 전체 상품금액
%>
<div id="container">
<br><br><br><br><br><br><br><br><br><br><br><br>
<h2>장바구니 목록</h2>
<table>
	<tr id="title_row">
		<th id="title_row" width="3%"><input type="checkbox" name="check_all" id="check_all"></th>
		<th id="title_row" width="5%">번호</th>
		<th id="title_row" width="54%" colspan="2">상품명</th>
		<th id="title_row" width="10%">판매금액</th>
		<th id="title_row" width="8%">수량</th>
		<th id="title_row" width="10%">총액 </th>
		<th id="title_row" width="10%">삭제</th>
	</tr>
	<%if(count == 0) {%>
	<tr><th colspan="8">장바구니에 담기 상품이 없습니다.</th></tr>
	<%} else {
		for(CartDataBean cart : cartList) {
			int cart_id = cart.getCart_id();
			int product_id = cart.getProduct_id();
			String product_image = "/image_products/" + cart.getProduct_image();
			String product_name = cart.getProduct_name();
			int buy_price = cart.getBuy_price();
			int buy_count = cart.getBuy_count();
			int buy_sum = buy_price * buy_count;
			++n1; n2 += buy_count; tot_price += buy_sum;
			
		%>
	
				
 		<script>
			$("#check_all").click(function() {
				if($(this).prop("checked")) {
					$("input:checkbox[id='check_one']").prop("checked", true);
				} else {
					$("input:checkbox[id='check_one']").prop("checked", false);
				}
			});
		</script> 
		
		<form action="cartUpdate.jsp" method="post" name="cartListForm">		
			<tr>
				<input type="hidden" name="cart_id" id="cart_id" value="<%=cart_id%>">
				<input type="hidden" name="product_kind" id="product_kind" value="<%=product_kind%>">
				
				<td><input type="checkbox" id="check_one" name="check_one" value="<%=cart_id %>"></td>
				<td align="center"><%=count-- %></td>
				<td align="center"><a href="../shop/shopContent.jsp?product_id=<%=product_id %>&product_kind=<%=product_kind%>"><img id="cart_image" src="<%=product_image %>" height="80"></a></td>
				<td class="product_name"><a href="../shop/shopContent.jsp?product_id=<%=product_id %>&product_kind=<%=product_kind%>"><%=product_name %></a></td>
				<td align="right" class="buy_price"><%=df.format(buy_price) %>원</td>
				<td align="center">
					<div class="acc"><input type="text" name="buy_count" value="<%=buy_count %>"></div>
					<div class="acc"><input type="submit" value="변경" class="btn_update"></div>
				</td>
				<td align="right" class="buy_sum"><%=df.format(buy_sum) %>원</td>
				<td align="center">
					<div class="acc"><input type="button" class="btn_order" onclick="location='../buy/buyForm.jsp?cart_id=<%=cart_id %>&product_kind=<%=product_kind %>'" value="주문"></div>
					<div class="acc"><input type="button" class="btn_delete" onclick="location='cartDelete.jsp?cart_id=<%=cart_id %>&product_kind=<%=product_kind %>'" value="삭제"></div>
				</td>
			</tr>
			</form>
	<%}}%>
	</table>

		<div class="results">
		<div class="r_count">총 상품 수량: <%=n1 %>종(<%=n2 %>)개 </div>
		<div class="r_amount">총 상품 금액: <%=df.format(tot_price) %>원</div>
		</div>


	<div class="btns">
		<input id="buy" type="button" value="주문하기" onclick="location='../buy/buyForm.jsp?cart_id=-1&product_kind=<%=product_kind %>'">
		<input type="button" value="장바구니 비우기" onclick="location='cartDelete.jsp?cart_id=-1&product_kind=<%=product_kind %>'">
		<input type="button" value="쇼핑 계속하기" onclick="location='../shop/shopMain.jsp'">
		<input type="button" value="체크된 객체 value 가져오기" onclick="value_check()" >
	</div>

</div>
<%@ include file="../common/shopBottom.jsp" %>
</body>
</html>