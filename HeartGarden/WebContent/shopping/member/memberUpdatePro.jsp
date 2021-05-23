<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.member.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보 수정 처리</title>
<script>


</script>
</head>
<body>
<%
request.setCharacterEncoding("utf-8");

// 1. 사용자 정보 추출
String id = request.getParameter("id");
String passwd = request.getParameter("passwd");
String name = request.getParameter("name");
String address = request.getParameter("address");
String tel = request.getParameter("tel");

// 2. DB 연동 처리
MemberDataBean member = new MemberDataBean();
member.setId(id);
member.setPasswd(passwd);
member.setName(name);
member.setAddress(address);
member.setTel(tel);

MemberDBBean memberPro = MemberDBBean.getInstance();
memberPro.updateMember(member);

// 3. 화면 이동
response.sendRedirect("myPage.jsp");
%>
</body>
</html>