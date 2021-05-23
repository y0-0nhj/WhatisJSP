<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>헤더 페이지</title>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Noto+Serif+KR&display=swap" rel="stylesheet">
</head>
<style>
/* 상단 타이틀 메뉴 */
#container { width: 100%; margin: 0 auto; color: lightblack; }
a { text-decoration: none; color: gray; }
header { width: 100%; margin: 0 auto;}
#fixed { margin-top: -10px; position: fixed; width: 100%; background: white;  z-index: 3; }
header ul { list-style: none; color: gray; }
.top_menu ul li { padding-left: 5px; padding-right: 5px; border-left: 1px solid lightgray; border-right: 1px solid lightgray; display: inline-block; float:right; font-family: 'Noto Serif KR';}
#search { width: 150px; height: 20px; background: lightgray; border-style: none; border-radius: 5px; }
.member_id { color: #ED9595; border-left: 1px solid white; border-collapse: collapse; }

/* 메인메뉴 */
.logo { width: 20%; margin: 0 auto; padding-right: 200px; padding-top: 30px; }
.menu li { float: center; position: relative; float: left; width: 16%;  display: inline-block; border: none; z-index:2; text-align:}
.menu ul { float: center; width: 60%; margin: 0 auto; height: 40px; text-align: center; line-height: 40px; z-index:2; text-align:}
.menu { float: center; text-align: center; padding: 15px 55px 15px 55px; text-align: center; font-family: 'Noto Serif KR'; color: gray; z-index:2;}
.menu a:hover {color: pink;}
#menu_title { font-size: 1.3em;  border-left: 1px solid lightgray;}

/* 서브 메뉴 */
.child { position: absolute;}
#sub_menu { position: relative; display: none; z-index: 5;}
li:hover #sub_menu {display: block; }

/* 메인 이미지 */
#main_image{ width: 100%; clear:both; padding-bottom: 0px; z-index:5; }

</style>

<div id="container">

<header id="fixed">
<% String id = (String)session.getAttribute("id");%>
	<div class="top_menu">
		<ul>
			<li><input type="text" value="상품 검색" id="search"><a href="">검색 </a></li>
			<li><a href="../board_qna/listBoardQna.jsp">Q&A</a></li>
			<li><a href="../cart/cartList.jsp">장바구니</a></li>
			<%if(id == null) { %> <%-- 로그인이 되지 않은 상태 --%>
			<li><a href="../member/memberJoinForm.jsp">회원가입</a></li>
			<li><a href="../member/memberLoginForm.jsp">로그인</a></li>
			<%} else {%> <%-- 로그인이 된 상태 --%>
			<li><a href="../member/myPage.jsp">마이페이지</a></li>
			<li><a href="../member/memberLogout.jsp">로그아웃</a></li>
			<li class="member_id"><%=id %>님</li>
			<%} %>
		</ul>
	</div>

	<div class="logo"> <a href="../shop/shopMain.jsp">
		<img id="logo_img" src="../../image/main/logo_image001.png">
		</a>
	</div>

	<div class="menu">
		<ul>
			<li><a href="">About</a>
			</li>
			<li><div id="menu_title"><a href="../shop/shopAll.jsp?product_kind=100">꽃</a></div>
<!-- 				<div class="child">
					<div id="sub_menu"><a href="../shop/shopAll.jsp?product_kind2=110">씨앗</a></div>
					<div id="sub_menu"><a href="../shop/shopAll.jsp?product_kind2=120">구근</a></div>
				</div> -->
			</li>
			<li><div id="menu_title"><a href="../shop/shopAll.jsp?product_kind=200">묘목</a></div>
<!-- 				<div class="child">
					<div id="sub_menu"><a href="../shop/shopAll.jsp?product_kind2=210">상록수</a></div>
					<div id="sub_menu"><a href="../shop/shopAll.jsp?product_kind2=220">활엽수</a></div>
					<div id="sub_menu"><a href="../shop/shopAll.jsp?product_kind2=230">유실수(과수)</a></div>
				</div> -->
			</li>
			<li><div id="menu_title"><a href="../shop/shopAll.jsp?product_kind=300">원예</a></div>
<!-- 				<div class="child">
					<div id="sub_menu"><a href="../shop/shopAll.jsp?product_kind2=310">퇴비/영양</a></div>
					<div id="sub_menu"><a href="../shop/shopAll.jsp?product_kind2=320">원예도구</a></div>
				</div> -->
			</li>
			<li><div id="menu_title"><a href="../shop/shopAll.jsp?product_kind=400">소품</a></div>
<!-- 				<div class="child">
					<div id="sub_menu"><a href="../shop/shopAll.jsp?product_kind2=410">화분</a></div>
					<div id="sub_menu"><a href="../shop/shopAll.jsp?product_kind2=420">조명</a></div>
				</div> -->
			</li>
			<li><div id="menu_title"><a href="">My Page</a></div>
				<div class="child">
					<div id="sub_menu"><a href="../buy/buyList.jsp">배송조회</a></div>
					<div id="sub_menu"><a href="../cart/cartList.jsp">장바구니</a></div>
<!-- 					<div id="sub_menu"><a href="">적립금</a></div>
					<div id="sub_menu"><a href="">쿠폰관리</a></div>
					<div id="sub_menu"><a href="">찜/관심상품</a></div> -->
					<div id="sub_menu"><a href="../board_qna/listBoardQna.jsp">문의내역</a></div>
				</div>
			</li>
		</ul>
	<div id="main_image">
	<img src="../../image/main/white.jpg">
	</div>
	</div>
	
</header>
</div>
</body>
</html>