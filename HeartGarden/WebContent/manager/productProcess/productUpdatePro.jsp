<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.util.Enumeration, java.sql.Timestamp" %>
<%@ page import="shop.master.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 수정 처리</title>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");
			
	MultipartRequest imageUp = null;
	String realFolder = ""; // 실제 경로
	String fileName = "";   // 파일 이름
	
	//String saveFolder = "/imageFile"; // 파일이 저장되는(업로드되는) 폴더
	String encType = "utf-8";
	int maxSize = 1024 * 1024 * 2; // 업로드 파일의 크기 제한, 2MB
	
	realFolder = "d:/image_products/";
	
	try {
		// 데이터 전달 객체(파일 정보를 포함)
		imageUp = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());
		
		Enumeration<?> files = imageUp.getFileNames();
		while(files.hasMoreElements()) {
			String name = (String)files.nextElement();
			fileName =  imageUp.getFilesystemName(name);
		}

	} catch(Exception e) {
		e.printStackTrace();
	}
		
	int product_id = Integer.parseInt(imageUp.getParameter("product_id"));
	String product_kind = imageUp.getParameter("product_kind");
	String product_name = imageUp.getParameter("product_name");
	String product_color = imageUp.getParameter("product_color");
	String product_content = imageUp.getParameter("product_content");
	String product_origin = imageUp.getParameter("product_origin");
	String product_price = imageUp.getParameter("product_price");
	String product_count = imageUp.getParameter("product_count");
	String discount_rate = imageUp.getParameter("discount_rate");
	String fileName1 = imageUp.getParameter("product_image1");
	String fileName2 = imageUp.getParameter("product_image2");
	String fileName3 = imageUp.getParameter("product_image3");
	String fileName4 = imageUp.getParameter("product_image4");
	
	//객체 생성
	ProductDataBean product = new ProductDataBean();
	product.setProduct_kind(product_kind);
	product.setProduct_name(product_name);
	product.setProduct_color(product_color);
	product.setProduct_content(product_content);
	product.setProduct_origin(product_origin);
	product.setProduct_price(Integer.parseInt(product_price));
	product.setProduct_count(Integer.parseInt(product_count));
	product.setProduct_image1(fileName1);
	product.setProduct_image2(fileName2);
	product.setProduct_image3(fileName3);
	product.setProduct_image4(fileName4);
	product.setProduct_content(product_content);
	product.setDiscount_rate(Integer.parseInt(discount_rate));
	product.setReg_date(new Timestamp(System.currentTimeMillis()));
	
	ProductDBBean dbPro = ProductDBBean.getInstance();
	dbPro.updateProduct(product);
	
	response.sendRedirect("productList.jsp?product_kind=" + product_kind);
%>
</body>
</html>