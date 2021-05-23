<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.master.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쇼핑몰 메인컨텐츠</title>
<link href="https://fonts.googleapis.com/css2?family=Berkshire+Swash&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>
<style type="text/css">
#container {width: 1100px; margin: 0 auto; }

/* 본문 */
section article {
	text-align: center; border: none;
	display: inline-block; width: 300px; height: 300px; margin: 10px -200px 10px 190px; padding-top:12px; border-radius: 5px;
}
section article img { width: 250px; height: 250px; border: none; border-radius: 20px; margin: 0 auto;}

section #top_gallery { text-align: center;}
.kind { width: 1100px; margin-left: 220px; }
.kind b { font-family: 'Berkshire Swash'; font-size: 1.5em; color: #FAE0D4;}
.kind a { margin-left: 10px; padding: 5px; text-decoration: none; color: black; background: #FFF2E6; color: #DB8383; border-radius: 5px;}
.name { font-size: 0.8em; font-weight: 700;}
.discount_price { font-size: 0.7em; color: gray;}
.bx-wrapper, .bxslider, img { border: none; margin: 0 auto; }
</style>
</head>

<body>
<%@ include file="../common/shopTop.jsp" %>
<br><br><br><br><br><br><br><br><br><br><br><br>
<div id="container">
<section>
<% ProductDBBean productPro = ProductDBBean.getInstance();
//bxSilider 배치 : 본문 상단에 상품 종류별 최신 상품 3개씩 총 15개
%>
<ul class="bxslider">
	<li><img width="100%" src="../../image/main/mainintroduce001.png"/></li>
	<li><img width="100%" src="../../image/main/mainintroduce002.png"/></li>
	<li><img width="100%" src="../../image/main/mainintroduce003.png"/></li>
	<li><img width="100%" src="../../image/main/mainintroduce004.png"/></li>
	<li><img width="100%" src="../../image/main/mainintroduce005.png"/></li>
</ul>
<br><br><br>
<script>
$(document).ready(function(){
	$('.bxslider').bxSlider({
		auto: true,			// 자동 슬라이드 여부
		speed: 2000,		// 전환 속도
		pause: 4500, 		// 전화 사이의 시간(이미지의 노출시간)
		wrapperClass: 'bx-wrapper'
/* 		mode: "horizontal",	// 슬라이드 이동 방향, horizontal, vertical, fade, 기본값: horizontal
		auto: true,			// 자동 슬라이드 여부
		autoControls: true,	// 재생/정지 버튼 (오른쪽 하단) 노출 여부, 기본값: false
		controls: true,		// 이전/다음 슬라이드 버튼의 노출 여부, 기본값: true
		pager: true,		// 페이지 블릿의 노출 여부, 기본값: true
		autoHover: true,    // 이미지에 마우스를 올렸을 때 멈춤 여부, 기본값: false
		speed: 2000,		// 전환 속도
		pause: 4500, 		// 전화 사이의 시간(이미지의 노출시간)
		slideWidth: 1850,  	// 슬라이드 너비
		slideMargin: 10,	// 슬라이드 사이의 여백
		maxSlides: 1, 		// 슬라이드 최대 노출 개수
		minSlides: 1, 		// 슬라이드 최소 노출 개수
		moveSlide: 1, 		// 슬라이드 이동 개수
		touchEnabled: false, // 웹화면에서 touch 이벤트 제거, 클릭했을때 해당 페이지로 이동하기 위해서
		wrapperClass: 'bx-wrapper' */
	});
}); 
</script>

<script>
	function clickProduct(pCategory, pId) {
		location = "productContent.jsp?product_kind=" + pKind + "&product_id=" + pId;
	}
</script>
<div id="top_gallery">
	<ul class="slider">
	<%
	List<ProductDataBean> newProducts = new ArrayList<ProductDataBean>();
	for(ProductDataBean product : newProducts) {
		String pKind = product.getProduct_kind();
		int pId = product.getProduct_id();
		out.print("<li>");
		out.print("<img onclick='clickProduct(" + pKind + "," + pId + ");'");
		out.print("src='" + "/image_products/" + product.getProduct_image1()  + "'></li>");
	}%>
	</ul>
</div>
<%  List<ProductDataBean> productList = new ArrayList<ProductDataBean>();
String product_kindName = "";
String[] pNames = {"꽃", "묘목", "원예", "소품"};
int n = 0;

// 본문 - 상품종류별 신상품 5개씩 저장
for(int i=1; i<=4; i++) {
	productList.addAll(productPro.getProducts(i+"00", 5)); }
	
for(int i=0; i<productList.size(); i++) {
	int product_id = productList.get(i).getProduct_id();
	String product_image = "/image_products/" +  productList.get(i).getProduct_image1();
	String product_name = productList.get(i).getProduct_name();
	String product_content = productList.get(i).getProduct_content();
	String product_kind = productList.get(i).getProduct_kind();
	String product_origin = productList.get(i).getProduct_origin();
	int product_price = productList.get(i).getProduct_price();
	int discount_rate = productList.get(i).getDiscount_rate();
	int discount_price = product_price - (product_price*discount_rate/100);
	
	if(i%5 == 0) {
		product_kindName = pNames[n++];
		out.print("<p class='kind'><b>" + product_kindName + "</b> 최신 분류");
		out.print("<a href='shopAll.jsp?product_kind=" + product_kind + "'>전체보기</a></p>"); }%>
	<a href="shopContent.jsp?product_kind=<%=product_kind%>&product_id=<%=product_id%>">
	<article>
		<p><img src=<%=product_image %> height="230" width="260"></p>
		<p>
		<span class="name"><%=product_name %></span><br>
		<span class="discount_price"><%=discount_price %>원</span><br>
		</p>
	</article>
	</a>
<!-- 	<div class="cover">
		<div class="detail"><a href="">상세보기</a></div>
	</div> -->
<%}%>
</section>
<%@ include file="../common/shopBottom.jsp" %>
</div>
</body>
</html>