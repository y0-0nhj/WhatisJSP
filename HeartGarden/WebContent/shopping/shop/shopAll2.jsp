<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="shop.master.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 종류별 전체보기</title>
<link href="https://fonts.googleapis.com/css2?family=Stylish&display=swap" rel="stylesheet">
<style>
#container { width: 1100px; margin: 0 auto;}

/* 본문 */
section article {
	text-align: center; border: 1px solid lightgray;
	float: left; width: 23%; height: 420px; margin: 10px 10px 30px 10px;}
section article img { }

section #top_gallery { text-align: center;}
.kind { margin-left: 20px; margin-bottom: 0; font-family: 'Stylish', sans-serif; 
font-size: 2em; color: brown; }
.kind b { font-family: 'Nanum Brush Script'; font-size: 1.5em; color: pink;}
.kind a { text-decoration: none; color: black; margin-left: 30px; padding: 5px;
background: rgba(100,100,200,0.2); color: pink; border-radius: 5px;}
.name { font-size: 0.8em; font-weight: 700;}
.discount_price { font-size: 0.7em; color: gray;}

/* .cover { background: black; opacity: 1; margin-left:-19%; opacity: 0.5;}
.detail {}
 */
 
/* paging */
#paging { margin-top: 10px; text-align: center; clear: both;}
#pbox { display: inline-block; width: 25px; height: 25px; border-radius: 12.5px; 
margin-left: 2px; margin-right: 2px; font-size: 0.8em; text-align: center; line-height: 25px;}
.pagebox1 { border: 1px solid pink; background-color: pink; color: white; font-weight: bold; opacity: 0.7;}
.pagebox2 { border: 1px solid gray; color: gray; }
.pagebox3 { border: 1px solid gray; background: rgba(100,100,200,0.2);  }
</style>
</head>
<body>
<div class="container">
<%@ include file="../common/shopTop.jsp" %>

<section>
<%
String product_kind = request.getParameter("product_kind");
ProductDBBean productPro = ProductDBBean.getInstance();
List<ProductDataBean> productList = new ArrayList<ProductDataBean>();
int n = 0;

//String first_kind = product_kind.substring(0,1); // 1000, 1
//String second_kind = product_kind.substring(0,2); // 1100, 11


// 분류번호(숫자)를 텍스트로 출력하기 위함
String product_kindName = "";
if(product_kind.equals("all")) product_kindName = "전체";
else if(product_kind.equals("100")) product_kindName = "꽃";
else if(product_kind.equals("200")) product_kindName = "묘목";
else if(product_kind.equals("300")) product_kindName = "원예";
else if(product_kind.equals("400")) product_kindName = "소품";


// 세부 분류번호를 텍스트로 출력하기 위함
/*
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
else if(second_kind.equals("42")) product_kindName = "조명";
*/

//////////paging 
int pageSize = 8; // 페이지 사이즈, 한 페이지에서 보여줄 글수
String pageNum = request.getParameter("pageNum"); // 페이지 번호
if(pageNum == null) pageNum = "1";
int currentPage = Integer.parseInt(pageNum);
int startRow = (currentPage - 1) * pageSize + 1; // 페이지의 첫번째 글
int endRow = currentPage * pageSize;			 // 페이지의 마지막 글
//////////

//페이징
int count = productPro.getProductCount(product_kind); // 전체 상품수 또는 분류별 상품수
if(count > 0) { // 등록된 상품이 있다면
	productList = productPro.getProducts(product_kind, startRow, pageSize);
}

//전체 페이지 수
int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);

System.out.print("<p><span class='kind'>" + product_kindName + "</span> 전체 보기</p>");
for(int i=0; i<productList.size(); i++) {
	int product_id = productList.get(i).getProduct_id();
	String product_image = "/image_products/" +  productList.get(i).getProduct_image1();
	String product_name = productList.get(i).getProduct_name();
	String product_origin = productList.get(i).getProduct_origin();
	int product_price = productList.get(i).getProduct_price();
	int discount_rate = productList.get(i).getDiscount_rate();
	int discount_price = product_price - (product_price*discount_rate/100);
%>

	<a href="shopContent.jsp?product_kind=<%=product_kind%>&product_id=<%=product_id%>">
	<article>
		<p><img src=<%=product_image %> height="330" width="350" ></p>
		<p>
		<span class="name"><%=product_name %></span><br>
		<span class="discount_price"><%=discount_price %>원</span><br>
		</p>
	</article>
	</a>
<%}%>
</section>

<div id="paging">
	<%
	// 페이징 처리(paging)
	if(count > 0) {
		int startPage = 1;
		
		if(currentPage%10 != 0) startPage = (int)(currentPage/10)*10 + 1;
		else startPage = ((int)(currentPage/10)-1)*10 + 1;
		
		int pageBlock = 10; // 페이징처리에서 보여질 페이지 블럭의 수
		int endPage = startPage + pageBlock - 1;
		
		if(endPage > pageCount) endPage = pageCount;
		
		if(startPage > 10) {
			out.print("<a href='shopAll.jsp?product_kind=" + product_kind + "&pageNum=" + (startPage-10) 
					+ "'><div id='pbox' class='pagebox3'>&lt</div></a>");
		}
		for(int i=startPage; i<=endPage; i++) {
			if (i == currentPage) { // 해당 페이지 선택 상태
				out.print("<div id='pbox' class='pagebox1'>" + i + "</div>");
			} else { // 선택되지 않은 상태
				out.print("<a href='shopAll.jsp?product_kind=" + product_kind + "&pageNum=" + i 
				+ "'><div id='pbox' class='pagebox2'>" + i + "</div></a>");
			}
		}
		if(endPage < pageCount) {
			out.print("<a href='shopAll.jsp?product_kind=" + product_kind + "&pageNum=" + (startPage+10) 
					+ "'><div id='pbox' class='pagebox3'>&gt</div></a>");
		}
}%>
	</div>

<%@ include file="../common/shopBottom.jsp" %>

</div>
</body>
</html>