<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.master.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 수정 폼</title>
<link href="etc/productUpdateForm.css" rel="stylesheet" type="text/css">
<script src="etc/productUpdateForm.js"></script>
</head>
<body>
<div id="container">
	<%
	String managerId = (String)session.getAttribute("managerId");
	
	// 세션이 없을 때(관리자 로그인을 하지 않았을 때)
	if(managerId == null || managerId.equals("")) { 
		response.sendRedirect("../logon/managerLoginForm.jsp");
	} 
	
	// 세션이 있을 때(관리자 로그인을 했을 때)
	int product_id = Integer.parseInt(request.getParameter("product_id"));
	String product_kind = request.getParameter("product_kind");
		
	ProductDBBean dbPro = ProductDBBean.getInstance();
	ProductDataBean product = dbPro.getProduct(product_id);
	%>
	<h2>상품 수정</h2>
	<form action="productUpdatePro.jsp" method="post" enctype="multipart/form-data"
		name="productUpdateForm" onsubmit="return productUpdateCheck();">
	<input type="hidden" name="product_id" value="<%=product_id %>">
	<table>
		<tr class="tr_first">
			<th colspan="2">
				<a href="../managerMain.jsp">관리자 페이지 이동</a>
				<a href="productList.jsp?product_kind=<%=product_kind%>">상품목록 페이지 이동</a>
			</th>
		</tr>
		<tr>
			<th width="20%">분류선택</th>
			<td width="80%">
				<select name="product_kind">
					<option value="100" <%if(product_kind.equals("100")) {%> selected <%} %>>꽃</option>
					<option value="200" <%if(product_kind.equals("200")) {%> selected <%} %>>묘목</option>
					<option value="300" <%if(product_kind.equals("300")) {%> selected <%} %>>원예</option>
					<option value="400" <%if(product_kind.equals("400")) {%> selected <%} %>>소품</option>
				</select>
			</td>
		</tr>
		<tr>
			<th>이름</th>
			<td><input type="text" size="55" maxlength="55" name="product_name" value="<%=product.getProduct_name() %>"></td></tr>
		<tr>
			<th>가격</th>
			<td><input type="text" size="10" maxlength="9" name="product_price" value="<%=product.getProduct_price() %>"><span class="small_text"> 원</span></td></tr>
		<tr>
			<th>수량</th>
			<td><input type="text" size="10" maxlength="5" name="product_count" value="<%=product.getProduct_count() %>"><span class="small_text"> 권</span></td></tr>
		<tr>
			<th>색상</th>
			<td><input type="text" size="20" maxlength="30" name="product_color" value="<%=product.getProduct_color() %>"></td></tr>
		<tr>
			<th>원산지</th>
			<td><input type="text" size="30" maxlength="30" name="product_origin" value="<%=product.getProduct_origin() %>"></td></tr>
		<tr>
			<th>이미지1(메인)</th>
			<td><input type="file" name="product_image1"><%=product.getProduct_image1() %></td></tr>
		<tr>
			<th>이미지2(보조)</th>
			<td><input type="file" name="product_image2"><%=product.getProduct_image2() %></td></tr>
		<tr>
			<th>이미지3(보조)</th>
			<td><input type="file" name="product_image3"><%=product.getProduct_image3() %></td></tr>
		<tr>
			<th>이미지4(보조)</th>
			<td><input type="file" name="product_image4"><%=product.getProduct_image4() %></td></tr>
		<tr>
			<th>내용</th>
			<td><textarea rows="10" cols="52" name="product_content"><%=product.getProduct_content() %></textarea></td></tr>
		<tr>
			<th>할인율</th>
			<td><input type="text" size="5" maxlength="2" name="discount_rate" value="<%=product.getDiscount_rate() %>"><span class="small_text"> %</span></td></tr>
		<tr class="tr_end">
			<th colspan="2">
				<input type="submit" value="상품 수정">
				<input type="reset" value="다시 작성">
			</th></tr>
	</table>
	</form>
</div>
</body>
</html>