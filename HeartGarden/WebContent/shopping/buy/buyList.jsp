<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.buy.*, java.util.*, java.text.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>구매 목록</title>
<link href="https://fonts.googleapis.com/css2?family=Noto+Serif+KR&display=swap" rel="stylesheet">
<style type="text/css">
#container { width: 1850px; margin: 0 auto;}
h2 { text-align: center; font-family: 'Noto Serif KR';}
table { width: 1200px; margin: 0 auto; border: 1px solid lightgray; border-collapse: collapse; }
th { border: 1px solid lightgray; background: #F6F6F6; color: #ED9595; }
tr, td { border: 1px solid lightgray; }
</style>
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
//각 구매에 대한 상품 1건씩을 저장한 리스트
BuyDBBean buyPro = BuyDBBean.getInstance();
List<BuyDataBean> buyList = buyPro.getBuyListOne(id);

SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
DecimalFormat df = new DecimalFormat("#,###");
%>
<div id="container">
<h2>구매 목록</h2>
<br>
<table>
	<tr>
		<th width="12%">구매번호</th>
		<th width="18%">구매일자</th>
		<th width="30%">구매내역</th>
		<th width="10%">구매금액</th>
		<th width="10%">배송상태</th>
		<th width="10%">구매자</th>
		<th width="10%">수령자</th>
	</tr>
	<%for(BuyDataBean b : buyList) { 
		// 각 구매에 대한 상품 건수 파악
		int count = buyPro.getBuyIdCount(b.getBuy_id());%>
	<tr>
		<td align="center"><a href="buyIdList.jsp?buy_id=<%=b.getBuy_id() %>"><%=b.getBuy_id() %></a></td>
		<td align="center"><%=sdf.format(b.getBuy_date()) %></td>
		<td class="title"><a href="buyIdList.jsp?buy_id=<%=b.getBuy_id() %>"><%=b.getProduct_name() %> 외 (<%=count-1 %>)건</a></td>
		<td class="price" align="right"><%=df.format(b.getBuy_price()) %></td>
		<td align="center"><%=b.getDelivery_state() %></td>
		<td align="center"><%=b.getBuyer() %></td>
		<td align="center"><%=b.getDelivery_name() %></td>
	</tr>
	<%} %>
</table>
<br><p>
</div>
<%@ include file="../common/shopBottom.jsp" %>
</body>
</html>