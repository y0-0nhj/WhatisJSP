<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.member.*, shop.master.*, shop.bank.*" %>
<%@ page import="java.util.*, java.text.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>구매 폼</title>
<link href="https://fonts.googleapis.com/css2?family=Noto+Serif+KR&display=swap" rel="stylesheet">
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script> 
<style>
#container { width: 1850px; margin: 0 auto;}
h2 { text-align: center; font-family: 'Noto Serif KR';}
h3 { margin-left: 450px; font-family: 'Noto Serif KR'; }
table { width:1000px; border-collapse: collapse; margin: 0 auto;}
th, td { border-bottom: 1px solid lightgray; font-weight: normal; color: gray; font-size: 0.8em; text-align: center; padding:10px;}
tr { height: 30px;}
th { background: white; color: black;}
a { text-decoration: none; color: black;}
.product_title { padding-left: 10px;}
.buy_price, .buy_sum { padding-right: 10px;}
input[type="submit"], #reset { border: 1px solid lightgray; width: 120px; height: 40px;
background: white; color: #ED9595; cursor: pointer; outline:none;}
input[type="button"] { border: 1px solid lightgray; width: 120px; height: 30px;
background: white; color: #ED9595; cursor: pointer; outline:none; border-radius:1px;}
.results{ width: 1400px; height: 60px; line-height: 60px; text-align: right; font-family: 'Noto Serif KR'; margin-right:500px; }
.r_count, .r_amount { float: left; display: inline-block; width: 48%; padding-right:2%;  }
.r_amount {font-size: 1.2em; font-weight: bold; color: #A54D4D;}
#buy { background: #ED9595; color: white; border:0;}
#title_row { background: #F7E4DF; }

.order_info table { border: 1px solid lightgray; }
.order_info th { width: 30%; border: 1px solid lightgray; background: #F6F6F6; color: #ED9595; }
.order_info tr, .order_info td { width: 70%; border: 1px solid lightgray; }
.delivery_info table { border: 1px solid lightgray; }
.delivery_info th { width: 30%; border: 1px solid lightgray; background: #F6F6F6; color: #ED9595; }
.delivery-info tr, .delivery_info td { width: 70%; border: 1px solid lightgray; }

.btns { text-align: center; margin: 30px auto; }
.btns input[type="submit"] { background: #FFA7A7; color: white; }
.btns input[type="submit"]:hover {background: #FFD8D8; color: #ED9595;}


#name, #tel, #address, #btn_bank { margin-right: 500px;}
#name, #tel, #address {  border: none;  outline:none; }
#delivery_name, #delivery_tel { margin-right: 500px; }
.btnAddress { margin-right: 375px; width:10px; height: 10px; }

</style>

<script>
// 주문자 정보 복사
var btnCopy = document.querySelector(".btn_copy");
btnCopy.addEventListener("click", copyInfo);
function copyInfo() {
	document.querySelector("#delivery_name").value = document.querySelector("#name").value;
	document.querySelector("#delivery_tel").value = document.querySelector("#tel").value;
	document.querySelector("#delivery_address").value = document.querySelector("#address").value;
}

//주문수량과 재고량을 파악하여 구매 여부를 결정
function buyFormCheck() {
	var order = document.getElementById("order");
	
	if(order.innerHTML == '주문 가능') {
		return true;
	} else {
		alert('재고 부족 상품이 있습니다.\n확인하고 다시 주문해 주세요.');
		return false;
	}
}

//주소 찾기 기능 - 다음 라이브러리 활용
function searchAddress() {
	var form = document.buyForm;
	
	new daum.Postcode({
		oncomplete:function(data) {
			form.delivery_address.value = data.address;
		}
	}).open();
}
</script>
</head>
<body>
<%@ include file="../common/shopTop.jsp" %>
<br><br><br><br><br><br><br><br><br><br><br><br>
<%
//아이디 세션이 없을 때 (로그인 하지 않았을 때)
if(id == null || id.equals("")) {
	out.print("<script>alert('로그인을 해주세요.'); location='../member/memberLoginForm.jsp'</script>");
}

//아이디 세션이 있을 때 (로그인을 했을 때)
// 상세보기에서 바로 구매 버튼을 클릭했을 때 
// (shopContent.jsp -> buyForm.jsp)

//int cart_id = Integer.parseInt(request.getParameter("cart_id"));
//String product_kind = request.getParameter("product_kind");

int product_id = Integer.parseInt(request.getParameter("product_id"));
int buy_price = Integer.parseInt(request.getParameter("buy_price"));
int buy_count = Integer.parseInt(request.getParameter("buy_count"));
int buy_sum = buy_price * buy_count;

String p_id = (String)session.getAttribute("p_id");

DecimalFormat df = new DecimalFormat("#,###");

// 회원 DB 처리
MemberDBBean memberPro = MemberDBBean.getInstance();
MemberDataBean member = memberPro.getMember(id);

// 은행 DB 처리
BankDBBean bankPro = BankDBBean.getInstance();
List<BankDataBean> bankList = bankPro.getBankList(id);

// 상품 DB 처리
ProductDBBean productPro = ProductDBBean.getInstance();
ProductDataBean product = productPro.getProduct(product_id);
int product_count = product.getProduct_count();

// 장바구니 DB 처리
//CartDBBean cartPro = CartDBBean.getInstance();
//List<CartDataBean> cartList = null;
//CartDataBean cart = null;

// cart_id가 -1이면 전체 장바구니 보기, cart_id가 양수라면 해당 장바구니 보기
//cartList = cartPro.getCartList(id, cart_id);

/*
// cart_id가 -1이면 전체 장바구니 보기, cart_id가 양수라면 해당 장바구니 보기
if(cart_id == -1) cartList = cartPro.getCartList(id);
else cart = cartPro.getCart(cart_id);
*/
%>
<div id="container">
<h2>주문 내역 확인</h2>
<h3>주문 내역</h3>
<table>
	<tr>
		<th id="title_row">번호</th>
		<th id="title_row" colspan="2">상품명</th>
		<th id="title_row">판매가</th>
		<th id="title_row">수량</th>
		<th id="title_row">금액</th>
		<th id="title_row">주문 상태</th>
	</tr>
	<tr>
		<td class="center">1</td>
		<td class="center"><img src=<%="/image_products/" + product.getProduct_image1() %> height="50"></td>
		<td class="left"><%=product.getProduct_name() %></td>
		<td class="right"><%=df.format(buy_price) %></td>
		<td class="center"><%=buy_count %></td>
		<td class="right"><%=df.format(buy_sum) %></td>
		<td class="center">
		<%if(product_count >= buy_count){ %>
		<span class="order1" id="order">주문 가능</span>
				<%} else {%>
		<span class="order2" id="order">재고 부족</span>
		<%} %>
		</td>
	</tr>
</table>
<div class="results">
	<div class="r_count">총 상품 수량: 1종 (<%=buy_count %>개)</div>
	<div class="r_amount">총 상품 금액: <%=df.format(buy_sum) %></div>
</div>
<br>

<form action="buyPro2.jsp" method="post" name="buyForm" onsubmit="return buyFormCheck();">
<input type="hidden" name="product_id" value="<%=product_id %>">
<input type="hidden" name="product_name" value="<%=product.getProduct_name() %>">
<input type="hidden" name="product_image" value="<%=product.getProduct_image1() %>">
<input type="hidden" name="buy_price" value="<%=buy_sum %>">
<input type="hidden" name="buy_count" value="<%=buy_count %>">
<h3>주문자 정보</h3>
<table class="order_info">
	<tr>
		<th width="30%">이름</th>
		<td width="70%" class="left"><input type="text" id="name" value="<%=member.getName() %>" readonly></td>
	</tr>
	<tr>
		<th>전화번호</th>
		<td class="left"><input type="text" id="tel" value="<%=member.getTel() %>" readonly></td>
	</tr>
	<tr>
		<th>주소</th>
		<td class="left"><input type="text" id="address" value="<%=member.getAddress() %>" readonly></td>
	</tr>
	<tr>
		<th>결제 계좌</th>
		<td>
		<select name="bank_info" class="bank_info">
		<%for(BankDataBean bank : bankList){
		String bankInfo = bank.getCard_no() + " " + bank.getCard_com();%>
		<option value="<%=bankInfo %>"><%=bankInfo %></option>
		<%}%>
		</select>
		<input type="button" class="btn_bank" value="은행 정보 확인" onclick="">
		</td>
	</tr>
</table>
<br>
<h3>배송지 정보 <input type="button" onclick="copyInfo()" class="btn_copy" value="주문자 정보 복사"></h3>
<input type="hidden" name="buyer" value="<%=id %>">
<table class="delivery_info">
	<tr>
		<th width="30%">이름</th>
		<td width="70%" class="left"><input type="text" name="delivery_name" id="delivery_name"></td>
	</tr>
	<tr>
		<th>전화번호</th>
		<td class="left"><input type="text" name="delivery_tel" id="delivery_tel"></td>
	</tr>
	<tr>
		<th>주소</th>
		<td class="left">
		<input type="button" value="주소 찾기" class="btnAddress" onclick="searchAddress()"><br>
		<input type="text" name="delivery_address" id="delivery_address" size="78">
		</td>
	</tr>
</table>
<br>
<div class="btns">
	<input type="submit" value="구매">
	<input type="button" value="취소" onclick="location='../shop/shopContent.jsp?product_id=<%=product_id%>&product_kind=null'">
</div>
</form>
</div>
<%@ include file="../common/shopBottom.jsp" %>
</body>
</html>