<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.master.*, java.util.List, java.text.SimpleDateFormat" %>
<%@ page import="java.text.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 상세보기</title>
<link href="https://fonts.googleapis.com/css2?family=Noto+Serif+KR&display=swap" rel="stylesheet">
<style>
#container { width: 1850px; margin: 0 auto;}
#content { width: 75%; margin: 0 auto;}
.images { float: left; margin-left: 300px;}
.desc { float: left; }

.content { clear: both;}
#product_menu { width: 70%; clear:both; margin: 0 auto; }
#menu_button  { width: 320px; height: 50px; line-height: 50px; text-align: center; display: inline-block; }
#menu_button:hover  { width: 320px; display: inline-block; background: lightgray; color: white;}
.images { text-align: center;}
.s-images img { margin: 10px 20px;}
#contentImage1 { width: 60%; margin-left:270px; margin-top: 20px; }
#contentImage { width: 100%; margin-left:10px; }


/* desc */
.desc ul { list-style: none;}
.desc ul li { width: 450px; margin: 10px 15px; font-family: 'Noto Serif KR' }
.desc .title { font-family: 'Noto Serif KR'; font-size: 2.5em; color: black; margin-bottom: 30px;}
.desc .price1 { font-family: 'Noto Serif KR'; text-decoration: line-through;}
.desc .price2 { font-family: 'Noto Serif KR'; font-size: 1.2em; font-weight: 700; color: red;}
.desc .price3 { color: red;}
input[type="number"] { height: 20px; text-align: right;}
input[type="number"]::-webkit-inner-spin-button, 
input[type="number"]::-webkit-outer-spin-button {opacity: 1;}
button {  border: none; width: 160px; height: 45px; 
margin: 10px; background: pink; color: white; cursor: pointer;}
button:hover { background: #FAE0D4; color: #ED9595; font-weight: 700;}
.btns { text-align: center;}
#btn_cart, #btn_buy { width: 200px; height: 50px;}

#topup { position: fixed; margin-left: 1700px; margin-top: 500px; display: none;  cursor: pointer;}
#scrolling-box1 { display: none;  }
#scrolling-box2 { display: none;  }
#scrolling-box3 { display: none; margin-left:-235px;  }



h1 { text-align: center; margin-top: 50px; color: black; font-family: 'Noto Serif KR'; }
</style>
<script>
function cartPro() {
	var product_id = document.querySelector("#product_id").value;
	var buy_price = document.querySelector("#buy_price").value;
	var buy_count = document.querySelector("#buy_count").value;
	location = "../cart/cartInsert.jsp?product_id="+product_id+"&buy_price="+buy_price+"&buy_count="+buy_count; }
function buyPro() {
	var product_id = document.querySelector("#product_id").value;
	var buy_price = document.querySelector("#buy_price").value;
	var buy_count = document.querySelector("#buy_count").value;
	location = "../buy/buyForm2.jsp?product_id="+product_id+"&buy_price="+buy_price+"&buy_count="+buy_count;}
</script>
</head>
<body>
<div id="container">
<%@ include file="../common/shopTop.jsp" %>
<br><br><br><br><br><br><br><br><br><br><br><br>
 <img src="../../imageFile/top.png" id="topup" onclick="location.href='#container'">
<%
String product_kind = request.getParameter("product_kind");
String product_id = request.getParameter("product_id");


ProductDBBean productPro = ProductDBBean.getInstance();
ProductDataBean product = productPro.getProduct(Integer.parseInt(product_id));

// product_id 세션 저장
session.setAttribute("p_id", product_id);

// product_name 세션 저장
session.setAttribute("p_name", product.getProduct_name());

String first_kind = product_kind.substring(0,1); // 1000, 1
String second_kind = product_kind.substring(0,2); // 1100, 11

//분류번호(숫자)를 텍스트로 출력하기 위함
String product_kindName = "";
if (product_kind.equals("all")) product_kindName = "전체";
else if(first_kind.equals("1")) product_kindName = "꽃";
else if(first_kind.equals("2")) product_kindName = "묘목";
else if(first_kind.equals("3")) product_kindName = "원예";
else if(first_kind.equals("4")) product_kindName = "소품";

/* // 세부 분류번호를 텍스트로 출력하기 위함
if(first_kind.equals("1")) product_kindName = "꽃";

else if(second_kind.equals("11")) product_kindName = "씨앗";
else if(product_kind.equals("1101")) product_kindName = "장미";
else if(product_kind.equals("1102")) product_kindName = "국화";
else if(product_kind.equals("1103")) product_kindName = "안개류";
else if(product_kind.equals("1104")) product_kindName = "계절꽃";
else if(product_kind.equals("1105")) product_kindName = "기타";

else if(second_kind.equals("12")) product_kindName = "구근";
else if(product_kind.equals("1201")) product_kindName = "백합";
else if(product_kind.equals("1202")) product_kindName = "수선화";
else if(product_kind.equals("1203")) product_kindName = "튤립";
else if(product_kind.equals("1204")) product_kindName = "히아신스";
else if(product_kind.equals("1205")) product_kindName = "기타";

//

if(first_kind.equals("2")) product_kindName = "묘목";
else if(second_kind.equals("21")) product_kindName = "상록수";
else if(second_kind.equals("22")) product_kindName = "활엽수";
else if(second_kind.equals("23")) product_kindName = "유실수(과실수)";

//

if(first_kind.equals("3")) product_kindName = "원예";
else if(second_kind.equals("31")) product_kindName = "퇴비 및 영양";
else if(second_kind.equals("32")) product_kindName = "원예도구";

//

if(first_kind.equals("4")) product_kindName = "소품";
else if(second_kind.equals("41")) product_kindName = "화분";
else if(second_kind.equals("42")) product_kindName = "조명"; */

String product_image1 = "/image_products/" + product.getProduct_image1();
String product_image2 = "/image_products/" + product.getProduct_image2();
String product_image3 = "/image_products/" + product.getProduct_image3();
String product_image4 = "/image_products/" + product.getProduct_image4();
int product_price = product.getProduct_price();
int discount_rate = product.getDiscount_rate();
int sale_price = product_price - (product_price*discount_rate/100);
DecimalFormat df = new DecimalFormat("#,###,###");
%>
<br><br><br>
<div id="content">
	<div class="images">
		<img src="<%=product_image1 %>" width="400" id="big_img">
		<div id="small_pic">
			<img src="<%=product_image1 %>" class="small_img" width="130">
			<img src="<%=product_image2 %>" class="small_img" width="130">
			<img src="<%=product_image3 %>" class="small_img" width="130">
		</div>
	</div>
	<script>
   // 1. 마우스를 작은 이미지 위에 놓았을 때 큰 이미지가 변경되도록 이벤트 설정
   var big_img = document.querySelector("#big_img"); // 1개
   var small_img = document.querySelectorAll(".small_img"); // 여러개, 배열
   
   // 1-2. 익명 함수 활용 - 여기서만 사용 가능, 내용이 몇줄되지 않을 때
   
   for(var i=0; i<small_img.length; i++) {
       small_img[i].addEventListener("mouseover", function() {
           big_img.src = this.src; // 속성
           
           //big_img.setAttribute("src", this.src); // 메소드
       }); // 작은 이미지를 선택했을 때
   }
</script>
	<div class="desc">
		<input type="hidden" id="product_id" value="<%=product_id %>">
		<input type="hidden" id="buy_price" value="<%=sale_price%>">
		<ul>
			<li class="title"><%=product.getProduct_name() %></li>
			<hr>
			<li>원산지 : <%=product.getProduct_origin() %></li>
			<li>정가 : <span class="price1"><%=df.format(product_price) %></span> 원</li>
			<li>판매가 : <span class="price2"><%=df.format(sale_price) %></span> 원 
				(<span class="price3"><%=discount_rate %>%</span> 할인)</li>
			<li>수량 : <input type="number" id="buy_count" value="1" min="1" max="10"></li>
			<li class="btns">
				<button id="btn_cart" onclick="cartPro();">장바구니 담기</button>
				<button id="btn_buy" onclick="buyPro();">바로 구매</button>
			</li>
		</ul>
	</div>
	<br>
	<div class="content">
	<br><br><br><br><br>
		<hr width="1000">
	<div id="product_menu" width="1000">

		<a href="#product_menu" ><div id="menu_button" onclick="showingBox1()">상품 상세보기</div></a>
		<a href="#scrolling-box2"><div id="menu_button" onclick="showingBox2()">상품 후기</div></a>
		<a href="#scrolling-box3"><div id="menu_button" onclick="showingBox3()">문의 내역</div></a>
	<script> 
		function showingBox1() {
			var x = document.getElementById("scrolling-box1");
			var y = document.getElementById("scrolling-box2");
			var z = document.getElementById("scrolling-box3");
			var top = document.getElementById("topup");

			if (x.style.display === "none") {
			    x.style.display = "block";
			    top.style.display = "block";
			    y.style.display = "none";
			    z.style.display = "none";
			    } else { x.style.display = "none"; }}
		function showingBox2() {
			var x = document.getElementById("scrolling-box1");
			var y = document.getElementById("scrolling-box2");
			var z = document.getElementById("scrolling-box3");
			
			if (y.style.display === "none") {
			    y.style.display = "block";
			    x.style.display = "none";
			    z.style.display = "none";
			  } else {y.style.display = "none"; }}
		function showingBox3() {
			var x = document.getElementById("scrolling-box1");
			var y = document.getElementById("scrolling-box2");
			var z = document.getElementById("scrolling-box3");
			
			if (z.style.display === "none") {
			    z.style.display = "block";
			    x.style.display = "none";
			    y.style.display = "none";
			  } else {z.style.display = "none";}}
	</script>


	</div>
	<div id="scrolling-box1">
	<br><br><br><br><br><br><br><br>
		<h1>상품 상세 설명</h1>
		<br><br>
		<img id="contentImage1" src="<%=product_image1 %>" width="500">
		<img id="contentImage1" src="<%=product_image2 %>" width="500">
		<img id="contentImage1" src="<%=product_image3 %>" width="500">
		<img id="contentImage" src="<%=product_image4 %>" width="950">
	<br><br><br><br><br><br><br><br>
	</div>
	
	<div id="scrolling-box2">
	<br><br><br><br>
		<%@ include file="../board_review/listBoardReview.jsp" %>
	<br><br><br><br><br><br><br><br>
	</div>
	<div id="scrolling-box3">
	
	<% String board_qna = "../board_qna/listBoardQna2.jsp"; 
	%>
		<jsp:include page="<%= board_qna %>" flush="false"/>
	<br><br><br><br>
	</div>
	
	<%@ include file="../common/shopBottom.jsp" %>
</div>
</div>

</body>
</html>