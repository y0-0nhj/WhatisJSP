<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 등록 폼</title>
<link href="etc/productRegisterForm.css" rel="stylesheet" type="text/css">
<script src="etc/productRegisterForm.js">
// 대분류 선택시
/* window.onload = function() {
	var v_selectLarge = document.getElementById("selectLarge"); // 대분류 태그
	var v_selectMiddle = document.getElementById("tr_middle"); // 중분류 태그
	
	v_selectMiddle.style.display="none";
} */

</script>
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
	
	%>
	<h2>상품 등록</h2>
	<form action="productRegisterPro.jsp" method="post" enctype="multipart/form-data"
		name="productRegisterForm" onsubmit="return productRegisterCheck();">
	<table>
		<tr class="tr_first"><th colspan="2"><a href="../managerMain.jsp">관리자 페이지 이동</a></th></tr>
		<tr>
			<th width="20%">대분류선택</th>
			<td width="80%">
				<select name="product_kind">
					<option value="100">꽃</option>
					<option value="200">묘목</option>
					<option value="300">원예</option>
					<option value="400">소품</option>
				</select>
			</td>
		</tr>
<!-- 		<tr id="tr_middle">
			<th width="20%">중분류선택</th>
			<td width="20%">
				<select name="product_kind" id="selectFlw">
					<option value="1100">씨앗</option>
					<option value="1200">구근</option>
				</select>
				<select name="product_kind" id="selectWood">
					<option value="2100">상록수</option>
					<option value="2200">활엽수</option>
					<option value="2300">유실수(과실수)</option>
				</select>
				<select name="product_kind" id="selectGarden">
					<option value="3100">퇴비&영양</option>
					<option value="3200">원예도구</option>
				</select>
				<select name="product_kind" id="selectAcc">
					<option value="4100">화분</option>
					<option value="4200">조명</option>
				</select>
			</td>
		</tr> -->
		<tr>
			<th>이름</th>
			<td><input type="text" size="55" maxlength="55" name="product_name"></td>
		</tr>
		<tr>
			<th>가격</th>
			<td><input type="text" size="10" maxlength="9" name="product_price"><span class="small_text"> 원</span></td>
		</tr>
		<tr>
			<th>수량</th>
			<td><input type="text" size="10" maxlength="5" name="product_count"><span class="small_text"> 개</span></td>
		</tr>
		<tr>
			<th>색상</th>
			<td><input type="text" size="20" maxlength="30" name="product_color"></td>
		</tr>
		<tr>
			<th>원산지</th>
			<td><input type="text" size="30" maxlength="30" name="product_origin"></td>
		</tr>
		<tr>
			<th>이미지1(메인)</th>
			<td><input type="file" name="product_image1"></td>
		</tr>
		<tr>
			<th>이미지2(보조)</th>
			<td><input type="file" name="product_image2"></td>
		</tr>
		<tr>
			<th>이미지3(보조)</th>
			<td><input type="file" name="product_image3"></td>
		</tr>
		<tr>
			<th>이미지4(상세)</th>
			<td><input type="file" name="product_image4"></td>
		</tr>
		<tr>
			<th>내용</th>
			<td><textarea rows="10" cols="52" name="product_content"></textarea></td>
		</tr>
		<tr>
			<th>할인율</th>
			<td><input type="text" size="5" maxlength="2" name="discount_rate"><span class="small_text"> %</span></td>
		</tr>
		<tr class="tr_end">
			<th colspan="2">
				<input type="submit" value="상품 등록">
				<input type="reset" value="다시 작성">
			</th>
		</tr>
	</table>
	</form>
</div>
</body>
</html>