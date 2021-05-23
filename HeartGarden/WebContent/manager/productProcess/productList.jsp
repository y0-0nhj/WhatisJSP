<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.master.*" %>
<%@ page import="java.util.*, java.text.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 목록 확인</title>
<link href="etc/productList.css" rel="stylesheet" type="text/css">
<script src="etc/productList.js"></script>
</head>
<body>
<div id="container">
<%
	////////// paging 
	int pageSize = 5; // 페이지 사이즈, 한 페이지에서 보여줄 글수
	String pageNum = request.getParameter("pageNum"); // 페이지 번호
	if(pageNum == null) pageNum = "1";
	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage - 1) * pageSize + 1; // 페이지의 첫번째 글
	int endRow = currentPage * pageSize;			 // 페이지의 마지막 글
	//////////
	
	String managerId = (String)session.getAttribute("managerId");
	
	//세션이 없을 때(관리자 로그인을 하지 않았을 때)
	if(managerId == null || managerId.equals("")) { 
		response.sendRedirect("../logon/managerLoginForm.jsp");
	} 

	// 세션이 있을 때(관리자 로그인을 했을 때)
	String product_kind = request.getParameter("product_kind");
	DecimalFormat df = new DecimalFormat("#,###,###.####");
	int number = 0;
	int count = 0;
	
	ProductDBBean dbPro = ProductDBBean.getInstance();
	List<ProductDataBean> productList = null;
	
	// 페이징
	count = dbPro.getProductCount(product_kind); // 전체 상품수 또는 분류별 상품수
	if(count > 0) { // 등록된 상품이 있다면
		productList = dbPro.getProducts(product_kind, startRow, pageSize);
		// 전체 글수 역순 번호 - 현재 페이지마다 달라서 매번 계산
		number = count - (currentPage - 1) * pageSize;
	}
	// 전체 페이지 수
	int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
		
	// 분류번호(코드)를 텍스트로 출력하기 위함. 
	String product_kindName = "";
	if(product_kind.equals("100")) product_kindName = "꽃";
	else if(product_kind.equals("200")) product_kindName = "묘목";
	else if(product_kind.equals("300")) product_kindName = "원예";
	else if(product_kind.equals("400")) product_kindName = "소품";

%>

	<h2>상품 목록</h2>
	<table class="top_table">
		<tr>
			<th width="20%"><%=product_kindName%> 분류의 목록: <%=count%>개</th>
			<th width="33%"></th>
			<th width="12%"><a href='productList.jsp?product_kind=all'>전체 상품 보기</a></th>
			<th width="12%">
			<select id="kind" onchange="selectProduct_kind()">
				<option>상품 분류</option>
				<option value="100" <%if(product_kind.equals("100")) {%> selected <%}%>>꽃</option>
				<option value="200" <%if(product_kind.equals("200")) {%> selected <%}%>>묘목</option>
				<option value="300" <%if(product_kind.equals("300")) {%> selected <%}%>>원예</option>
				<option value="400" <%if(product_kind.equals("400")) {%> selected <%}%>>소품</option>
			</select>
			</th>
			<th width="13%"><a href="../managerMain.jsp">관리자 페이지 이동</a></th>
			<th width="10%" align="right"><button onclick="location='productRegisterForm.jsp'">상품 등록</button></th>
		</tr>
	</table>
	
	<table class="content_table">
		<tr class="title_row">
			<th width="5%">번호</th>
			<th width="5%">상품종류</th>
			<th width="20%">이름</th>
			<th width="10%">상품이미지</th>
			<th width="8%">가격</th>
			<th width="5%">수량</th>
			<th width="12%">색상</th>
			<th width="12%">원산지</th>
			<th width="5%">할인율</th>
			<th width="5%">수정</th>
			<th width="5%">삭제</th>
		</tr>
	<%
	if(count == 0) { 
		out.print("<tr><td colspan='12' align='center' style='color:red;font-size:1.5em;'>등록된 분류의 상품이 없습니다.</td></tr>");
	} else {
		for(int i=0; i<productList.size(); i++) {
			ProductDataBean product = productList.get(i);
			String file = "/image_products/" + product.getProduct_image1();
			//System.out.println("파일 경로: " + file);
			
			int p_id = product.getProduct_id();
			String p_kind = product.getProduct_kind();
			
			String row_color = "";
			if(number%2 == 1) row_color = "gray";
			else row_color = "white";
		%>
		<tr class="<%=row_color%>">
			<td class="center"><%=number-- %></td>
			<td class="center"><%=product.getProduct_kind() %></td>
			<td class="left"><%=product.getProduct_name() %></td>
			<td class="center"><img src="<%=file%>" height="60"></td>
			<td class="right"><%=df.format(product.getProduct_price()) %>원</td>
			<td class="right"><%=product.getProduct_count() %>개</td>
			<td class="center"><%=product.getProduct_color() %></td>
			<td class="center"><%=product.getProduct_origin() %></td>
			<td class="right"><%=product.getDiscount_rate() %>%</td>
			<td class="center">
			<a href="productUpdateForm.jsp?product_id=<%=p_id%>&product_kind=<%=p_kind%>">수정</a>
			</td>
			<td class="center">
			<a href="productDeleteForm.jsp?product_id=<%=p_id%>&product_kind=<%=p_kind%>">삭제</a>
			</td>
		</tr>	
		<%}%>
	</table>		
	<%}%>
	
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
			out.print("<a href='productList.jsp?product_kind=" + product_kind + "&pageNum=" + (startPage-10) 
					+ "'><div id='pbox' class='pagebox3'>&lt</div></a>");
		}
		for(int i=startPage; i<=endPage; i++) {
			if (i == currentPage) { // 해당 페이지 선택 상태
				out.print("<div id='pbox' class='pagebox1'>" + i + "</div>");
			} else { // 선택되지 않은 상태
				out.print("<a href='productList.jsp?product_kind=" + product_kind + "&pageNum=" + i 
				+ "'><div id='pbox' class='pagebox2'>" + i + "</div></a>");
			}
		}
		if(endPage < pageCount) {
			out.print("<a href='productList.jsp?product_kind=" + product_kind + "&pageNum=" + (startPage+10) 
					+ "'><div id='pbox' class='pagebox3'>&gt</div></a>");
		}
	}%>
	</div>
</div>
</body>
</html>