<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 삭제 폼</title>
</head>
<body>
<%
	String managerId = (String)session.getAttribute("managerId");
	
	//세션이 없을 때(관리자 로그인을 하지 않았을 때)
	if(managerId == null || managerId.equals("")) { 
		response.sendRedirect("../logon/managerLoginForm.jsp");
	} 
	
	// 세션이 있을 때(관리자 로그인을 했을 때)
	int product_id = Integer.parseInt(request.getParameter("product_id"));
	String product_kind = request.getParameter("product_kind");
%>	
<script>
	var result = confirm("상품을 삭제하시겠습니까?");
	if(result) location="productDeletePro.jsp?product_id=<%=product_id%>&product_kind=<%=product_kind%>"; 
	else history.back();
</script>
</body>
</html>