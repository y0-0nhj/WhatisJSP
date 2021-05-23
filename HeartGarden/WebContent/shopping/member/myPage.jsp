<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.member.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script> 
<style>
#container { width: 1850px; margin: 0 auto;  font-family: 'Noto Serif KR';}
h2 { text-align: center; color: dark; font-size:1.5em;  font-family: 'Noto Serif KR';}
table { width: 1000px;  border-collapse: collapse; margin: 0 auto; }
th { background: #F6F6F6; font-weight: 400;}
td { background: white;}
th, td { border-top: 1px solid lightgray; border-bottom: 1px solid lightgray; }
tr { height: 50px;}
.btnCheck, .btnAddress { border: 0; background: #FFEAEA; color: #ED9595; width: 120px; height: 30px; cursor: pointer;
border-radius: 5px; }
span { color: gray; font-size:0.8em; }
#star { color: blue; }
input { margin-left: 10px; }
p { text-align: center;}
p input { border: 0; background: #FFEAEA; color: #ED9595; width: 120px; height: 40px; cursor: pointer; }
p input:hover { background: #F6F6F6; color: pink; font-weight: bold;}
</style>
<script>
//각 input 필드에 대한 유효성 검사
function myPageCheck() {
	var form = document.myPage;
		
	if(form.passwd.value.length == 0) {
		alert('비밀번호를 입력해 주세요.');
		form.passwd.focus();
		return false;
	}
	
	if(form.passwd2.value.length == 0) {
		alert('비밀번호 확인을 입력해 주세요.');
		form.passwd2.focus();
		return false;
	}
	
	if(form.passwd.value != form.passwd2.value) {
		alert('비밀번호가 일치하지 않습니다.\n비밀번호를 다시 입력해 주세요.');
		form.passwd.focus();
		return false;
	}
	
	if(form.name.value.length == 0) {
		alert('이름을 입력해 주세요.');
		form.name.focus();
		return false;
	}
	
	if(form.address.value.length == 0) {
		alert('주소를 입력해 주세요.');
		form.address.focus();
		return false;
	}
	
	if(form.tel.value.length == 0) {
		alert('전화번호를 입력해 주세요.');
		form.tel.focus();
		return false;
	}
	
	return true;
}

// 주소 찾기 기능 - 다음 라이브러리 활용
function searchAddress() {
	var form = document.memberJoinForm;
	
	new daum.Postcode({
		oncomplete:function(data) {
			form.address.value = data.address;
		}
	}).open();
}

// 회원 탈퇴 여부 확인 함수
function deleteMemberCheck() {
	var id = document.getElementById("id").value;
	var passwd = document.getElementById("passwd").value;
	
	var check = confirm("회원을 탈퇴하면 1주일 후에 가입이 가능합니다.\n정말로 회원을 탈퇴하겠습니까?");
	
	if(check == true) { // 예일 때, 회원 탈퇴 처리
		location = "memberDeletePro.jsp?id=" + id + "&passwd=" + passwd;
	} else { // 아니오일 때, 이전 페이지 돌아가기
		location = "myPage.jsp";
	}
}


</script>
</head>
<body>
<%-- 회원 정보, 장바구니 정보, 구매 정보 --%>
<%@ include file="../common/shopTop.jsp" %>

<%
// 아이디 세션이 없을 때
if(id == null || id.equals("")) {
	response.sendRedirect("../shop/shopMain.jsp");
}
// 아이디 세션이 있을 떼
MemberDBBean memberPro = MemberDBBean.getInstance();
MemberDataBean member = memberPro.getMember(id);
%>
<div id="container">
<br><br><br><br><br><br><br><br><br><br><br><br>
<h2>회원 정보 확인</h2>

<form action="memberUpdatePro.jsp" method="post" name="myPage" onsubmit="return myPageCheck()">
<input type="hidden" name="id" id="id" value="<%=member.getId()%>">
<table>
	<tr>
		<th width="25%">아이디</th>
		<td width="75%">&nbsp;&nbsp;<%=member.getId() %></td>
	</tr>
	<tr>
		<th>비밀번호</th>
		<td><input type="password" name="passwd" id="passwd" maxlength="16" size="10" value="<%=member.getPasswd()%>"></td>
	</tr>
	<tr>
		<th>비밀번호 확인</th>
		<td><input type="password" name="passwd2" maxlength="16" size="10" value="<%=member.getPasswd()%>"></td>
	</tr>
	<tr>
		<th>이름</th>
		<td><input type="text" name="name" maxlength="20" size="10" value="<%=member.getName()%>"></td>
	</tr>
	<tr>
		<th>주소</th>
		<td>
		<input type="text" name="address" maxlength="100" size="50" value="<%=member.getAddress()%>">
		<input type="button" value="주소 찾기" class="btnAddress" onclick="searchAddress()">
		</td>
	</tr>
	<tr>
		<th>전화번호</th>
		<td><input type="text" name="tel" maxlength="20" size="10" value="<%=member.getTel()%>"></td>
	</tr>
</table>

<p>
	<input type="submit" value="회원정보 수정">
	<input type="button" value="회원 탈퇴" onclick="deleteMemberCheck()">
</p>
</form>
</div>
<%@ include file="../common/shopBottom.jsp" %>
</body>
</html>