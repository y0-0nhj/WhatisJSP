package shop.master;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

//DB와 연결하여 상품등록, 상품조회, 상품수정, 상품삭제를 하는 클래스
//DB 처리를 하는 클래스
public class ProductDBBean {
	// singleton pattern(싱글톤 패턴) 적용
	private ProductDBBean() {}
	
	private static ProductDBBean instance = new ProductDBBean();
	
	public static ProductDBBean getInstance() {
		return instance;
	}
	
	// 커넥션풀을 통해 커넥션을 획득하는 메소드
	private Connection getConnection() throws Exception {
		Context initCtx = new InitialContext();
		Context envCtx = (Context)initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource)envCtx.lookup("jdbc/heartgarden");
		return ds.getConnection();
	}
	
	// Connection, PreparedStatement, ResultSet 객체를 닫는 메소드
	private void close(Connection conn, PreparedStatement pstmt, ResultSet rs) {
		if(rs != null) try { rs.close(); } catch(Exception e) { e.printStackTrace();}
		if(pstmt != null) try { pstmt.close(); } catch(Exception e) { e.printStackTrace();}
		if(conn != null) try { conn.close(); } catch(Exception e) { e.printStackTrace();}
	}
	
	// Connection, PreparedStatement 객체를 닫는 메소드
	private void close(Connection conn, PreparedStatement pstmt) {
		if(pstmt != null) try { pstmt.close(); } catch(Exception e) { e.printStackTrace();}
		if(conn != null) try { conn.close(); } catch(Exception e) { e.printStackTrace();}
	}
	
	// 관리자 인증 메소드
	public int managerCheck(String id, String passwd) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String dbPasswd = "";
		String sql="";
		int x = -1; // 1, 0, -1 : 아이디 존재와 패스워드 일치 여부 판단
		
		try {
			conn = getConnection();
			sql = "select managerPasswd from manager where managerId = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			// 아이디 존재, 비밀번호 일치 : x = 1, 아아디 존재, 비밀번호 불일치  x=0
			// 아이디 존재하지 않음: x=-1
			if(rs.next()) {
				dbPasswd = rs.getString("managerPasswd");
				if(dbPasswd.equals(passwd)) x = 1;
				else x = 0;
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return x;
		
	}
	
	// 상품 등록 메소드
	public void insertProduct(ProductDataBean product) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "";
		
		try {
			conn = getConnection();
			sql = "insert into product values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, product.getProduct_id());
			pstmt.setString(2, product.getProduct_kind());
			pstmt.setString(3, product.getProduct_image1());
			pstmt.setString(4, product.getProduct_image2());
			pstmt.setString(5, product.getProduct_image3());
			pstmt.setString(6, product.getProduct_image4());
			pstmt.setString(7, product.getProduct_name());
			pstmt.setString(8, product.getProduct_content());
			pstmt.setString(9, product.getProduct_origin());
			pstmt.setInt(10, product.getProduct_price());
			pstmt.setInt(11, product.getProduct_count());
			pstmt.setString(12, product.getProduct_color());
			pstmt.setInt(13, product.getDiscount_rate());
			pstmt.setTimestamp(14, product.getReg_date());
			pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally { 
			close(conn, pstmt);
		}
	}
	
	// 전체 상품수 또는 분류별 상품수를 알아내는 메소드
	public int getProductCount(String product_kind) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql1 = "";
		String sql2 = "";
		int count = 0; // 상품수
		
		try {
			conn = getConnection();
			sql1 = "select count(*) from product"; // 전체 상품수
			sql2 = "select count(*) from product where product_kind=?"; // 분류별 상품수
			
			if(product_kind.equals("all")) {
				pstmt = conn.prepareStatement(sql1);
			} else {
				pstmt = conn.prepareStatement(sql2);
				pstmt.setString(1, product_kind);
			}
			rs = pstmt.executeQuery();
			
			if(rs.next()) count = rs.getInt(1);
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return count;
	}
	
	/*
	// <<  대중소분류에 따른 product_kind별 상품수 알아내는 메소드  >>
	// kind1별 상품수 알아내는 메소드
	public int getProductKindCount1(String product_kind) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql1 = "", sql2 = "", sql3 = "" ,sql4 = "", sql5 = "";
		int count = 0; // 상품수
		
		String first_kind = product_kind.substring(0,1); // 1000, 1
		
		try {
			conn = getConnection();
			sql1 = "select count(*) from product"; // 전체 상품수
			sql2 = "select count(*) from product where product_kind like '1%'" ; // 꽃
			sql3 = "select count(*) from product where product_kind like '2%'" ; // 묘목
			sql4 = "select count(*) from product where product_kind like '3%'" ; // 원예
			sql5 = "select count(*) from product where product_kind like '4%'" ; // 소품
			sql = "select from product where product_kind like ?;
			pstmt.setString(1, product_kind + "%");
			
			if(product_kind.equals("all")) {
				pstmt = conn.prepareStatement(sql1);
			} else if(first_kind.equals("1")) {
				pstmt = conn.prepareStatement(sql2);
				pstmt.setString(1, product_kind);
			} else if(first_kind.equals("2")) {
				pstmt = conn.prepareStatement(sql3);
				pstmt.setString(1, product_kind);
			} else if(first_kind.equals("3")) {
				pstmt = conn.prepareStatement(sql4);
				pstmt.setString(1, product_kind);
			} else if(first_kind.equals("4")) {
				pstmt = conn.prepareStatement(sql5);
				pstmt.setString(1, product_kind);
			}
			rs = pstmt.executeQuery();
			
			if(rs.next()) count = rs.getInt(1);
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return count;
	}
	
	// kind2별 상품수 알아내는 메소드
	public int getProductKindCount2(String product_kind) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql1 = "", sql2 = "", sql3 = "" ,sql4 = "", sql5 = "";
		String sql6 = "", sql7 = "", sql8 = "", sql9 = "";
		int count = 0; // 상품수
		
		String second_kind = product_kind.substring(0,2); // 1100, 11
		
		try {
			conn = getConnection();
			sql1 = "select count(*) from product where product_kind like '11%'" ; // 꽃>씨앗
			sql2 = "select count(*) from product where product_kind like '12%'" ; // 꽃>구근
			sql3 = "select count(*) from product where product_kind like '21%'" ; // 묘목>상록수
			sql4 = "select count(*) from product where product_kind like '22%'" ; // 묘목>활엽수
			sql5 = "select count(*) from product where product_kind like '23%'" ; // 묘목>유실수(과실수)
			sql6 = "select count(*) from product where product_kind like '31%'" ; // 원예>퇴비 및 영양
			sql7 = "select count(*) from product where product_kind like '32%'" ; // 원예>원예도구
			sql8 = "select count(*) from product where product_kind like '41%'" ; // 소품>화분
			sql9 = "select count(*) from product where product_kind like '42%'" ; // 소품>조명
			
			if(second_kind.equals("11")) {
				pstmt = conn.prepareStatement(sql1);
			} else if(second_kind.equals("12")) {
				pstmt = conn.prepareStatement(sql2);
				pstmt.setString(1, product_kind);
			} else if(second_kind.equals("21")) {
				pstmt = conn.prepareStatement(sql3);
				pstmt.setString(1, product_kind);
			} else if(second_kind.equals("22")) {
				pstmt = conn.prepareStatement(sql4);
				pstmt.setString(1, product_kind);
			} else if(second_kind.equals("23")) {
				pstmt = conn.prepareStatement(sql5);
				pstmt.setString(1, product_kind);
			} else if(second_kind.equals("31")) {
				pstmt = conn.prepareStatement(sql6);
				pstmt.setString(1, product_kind);
			}  else if(second_kind.equals("32")) {
				pstmt = conn.prepareStatement(sql7);
				pstmt.setString(1, product_kind);
			}  else if(second_kind.equals("41")) {
				pstmt = conn.prepareStatement(sql8);
				pstmt.setString(1, product_kind);
			}  else if(second_kind.equals("42")) {
				pstmt = conn.prepareStatement(sql9);
				pstmt.setString(1, product_kind);
			} 
			rs = pstmt.executeQuery();
			
			if(rs.next()) count = rs.getInt(1);
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return count;
	}
	
	
	// 꽃> kind3별 상품수 알아내는 메소드
	public int getProductKindCount3(String product_kind) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql1 = "", sql2 = "";
		int count = 0; // 상품수
		
		try {
			conn = getConnection();
			sql1 = "select count(*) from product where product_kind like '110%'" ; // 씨앗
			sql2 = "select count(*) from product where product_kind like '120%'" ; // 구근
			
			
			for(int i=2; i<=5; i++) {
				if(product_kind.equals("1101")) {
					pstmt = conn.prepareStatement(sql1);
				} else if(product_kind.equals("110"+i)) {
					pstmt = conn.prepareStatement("sql"+i);
					pstmt.setString(1, product_kind);
				}
			}
			rs = pstmt.executeQuery();
			
			if(rs.next()) count = rs.getInt(1);
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return count;
		
		
		
		public List<ProductDataBean> getProducts(String product_kind, int start, int end) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		List<ProductDataBean> productList = null;
		ProductDataBean product = null;
		
		try {
		conn = getConnection();
		sql = "select * from product where product_kind like '?%' order by reg_date desc";
		
		if(product_kind.equals("")) {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start-1);
			pstmt.setInt(2, end);
		} else if(product_kind.equals("1")) {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start-1);
			pstmt.setInt(2, end);
		}
	}
	*/
	
	// 전체 또는 상품종류별 상품정보를 알아내는 메소드
	public List<ProductDataBean> getProducts(String product_kind, int start, int end) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql1 = "";
		String sql2 = "";
		List<ProductDataBean> productList = null;
		ProductDataBean product = null;
		
		try {
			conn = getConnection();
			sql1 = "select * from product order by reg_date desc limit ?, ?"; // 전체 상품
			sql2 = "select * from product where product_kind=? order by reg_date desc limit ?, ?"; // 상품종류에 따른 상품

			if(product_kind.equals("all")) {
				pstmt = conn.prepareStatement(sql1);
				pstmt.setInt(1, start-1); // limit는 0번부터 시작
				pstmt.setInt(2, end);     // 가져올 로우수 
			} else {
				pstmt = conn.prepareStatement(sql2);
				pstmt.setString(1, product_kind);
				pstmt.setInt(2, start-1); // limit는 0번부터 시작
				pstmt.setInt(3, end);     // 가져올 로우수 
			}
			rs = pstmt.executeQuery();
			
			productList = new ArrayList<ProductDataBean>();
			while(rs.next()) {
				product = new ProductDataBean();
				product.setProduct_id(rs.getInt("product_id"));
				product.setProduct_kind(rs.getString("product_kind"));
				product.setProduct_image1(rs.getString("product_image1"));
				product.setProduct_image2(rs.getString("product_image2"));
				product.setProduct_image3(rs.getString("product_image3"));
				product.setProduct_image4(rs.getString("product_image4"));
				product.setProduct_name(rs.getString("product_name"));
				product.setProduct_content(rs.getString("product_content"));
				product.setProduct_origin(rs.getString("product_origin"));
				product.setProduct_price(rs.getInt("product_price"));
				product.setProduct_count(rs.getInt("product_count"));
				product.setProduct_color(rs.getString("product_color"));
				product.setDiscount_rate(rs.getInt("discount_rate"));
				product.setReg_date(rs.getTimestamp("reg_date"));
				productList.add(product);
			}	
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return productList;
	}
	
	// 상품종류별 신간목록을 알아내는 메소드
	public List<ProductDataBean> getProducts(String product_kind, int count) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		List<ProductDataBean> productList = null;
		ProductDataBean product = null;
		
		try {
			conn = getConnection();
			// 상품종류에 따라 등록일을 내림차수하여 count 갯수만큼만 조회
			sql = "select * from product where product_kind=? order by reg_date desc limit ?"; 
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, product_kind);
			pstmt.setInt(2, count);
			rs = pstmt.executeQuery();
			
			productList = new ArrayList<ProductDataBean>();
			while(rs.next()) {
				product = new ProductDataBean();
				product.setProduct_id(rs.getInt("product_id"));
				product.setProduct_kind(rs.getString("product_kind"));
				product.setProduct_image1(rs.getString("product_image1"));
				product.setProduct_image2(rs.getString("product_image2"));
				product.setProduct_image3(rs.getString("product_image3"));
				product.setProduct_image4(rs.getString("product_image4"));
				product.setProduct_name(rs.getString("product_name"));
				product.setProduct_content(rs.getString("product_content"));
				product.setProduct_origin(rs.getString("product_origin"));
				product.setProduct_price(rs.getInt("product_price"));
				product.setProduct_count(rs.getInt("product_count"));
				product.setProduct_color(rs.getString("product_color"));
				product.setDiscount_rate(rs.getInt("discount_rate"));
				product.setReg_date(rs.getTimestamp("reg_date"));
				productList.add(product);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return productList;
	}
	
	// 상품정보 1개를 알아내는 메소드 - 상품 내용보기(상세보기)
	public ProductDataBean getProduct(int product_id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		ProductDataBean product = null;
		
		try {
			conn = getConnection();
			// 상품번호를 통해 product 테이블에서 데이터 1건을 가져옴
			sql = "select * from product where product_id=?"; 
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, product_id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				product = new ProductDataBean();
				product.setProduct_id(rs.getInt("product_id"));
				product.setProduct_kind(rs.getString("product_kind"));
				product.setProduct_image1(rs.getString("product_image1"));
				product.setProduct_image2(rs.getString("product_image2"));
				product.setProduct_image3(rs.getString("product_image3"));
				product.setProduct_image4(rs.getString("product_image4"));
				product.setProduct_name(rs.getString("product_name"));
				product.setProduct_content(rs.getString("product_content"));
				product.setProduct_origin(rs.getString("product_origin"));
				product.setProduct_price(rs.getInt("product_price"));
				product.setProduct_count(rs.getInt("product_count"));
				product.setProduct_color(rs.getString("product_color"));
				product.setDiscount_rate(rs.getInt("discount_rate"));
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return product;
	}
	
	
	// 상품정보를 수정하는 메소드
	public void updateProduct(ProductDataBean product) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "";
		
		try {
			conn = getConnection();
			sql = "update product set product_kind=?, product_image1=?, product_image2=?, product_image3=?, product_image4=?, "
				+ "product_name=?, product_content=?, product_origin=?, product_price=?, product_count=?, product_color=? "
				+ "discount_rate=? where product_id=?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, product.getProduct_kind());
			pstmt.setString(2, product.getProduct_image1());
			pstmt.setString(3, product.getProduct_image2());
			pstmt.setString(4, product.getProduct_image3());
			pstmt.setString(5, product.getProduct_image4());
			pstmt.setString(6, product.getProduct_name());
			pstmt.setString(7, product.getProduct_content());
			pstmt.setString(8, product.getProduct_origin());
			pstmt.setInt(9, product.getProduct_price());
			pstmt.setInt(10, product.getProduct_count());
			pstmt.setString(11, product.getProduct_color());
			pstmt.setInt(12, product.getDiscount_rate());
			pstmt.setInt(13, product.getProduct_id());
			pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt);
		}
	}
	
	// 상품정보를 삭제하는 메소드
	public void deleteProduct(int product_id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "";
		
		try {
			conn = getConnection();
			sql = "delete from product where product_id=?";
			pstmt = conn.prepareCall(sql);
			pstmt.setInt(1, product_id);
			pstmt.executeUpdate();
		} catch(Exception e) {
			 e.printStackTrace();
		} finally {
			close(conn, pstmt);
		}
	}

}
