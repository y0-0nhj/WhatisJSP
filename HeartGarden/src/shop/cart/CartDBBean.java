package shop.cart;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class CartDBBean {
	// singleton 패턴
	private CartDBBean() {}
	
	private static CartDBBean instance = new CartDBBean();
	
	public static CartDBBean getInstance() {
		return instance;
	}
	
	// Connection Pool 사용
	private Connection getConnection() throws Exception {
		Context initCtx = new InitialContext();
		Context envCtx = (Context)initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource) envCtx.lookup("jdbc/heartgarden");
		return ds.getConnection();
	}
	
	// Connection, PreparedStatement, ResultSet 객체 해제
	private void close(Connection conn, PreparedStatement pstmt, ResultSet rs) {
		if(rs != null) try { rs.close();} catch(Exception e) { e.printStackTrace(); }
		if(pstmt != null) try { pstmt.close();} catch(Exception e) { e.printStackTrace(); }
		if(conn != null) try { conn.close();} catch(Exception e) { e.printStackTrace(); }
	}
	
	// Connection, PreparedStatement 객체 해제
	private void close(Connection conn, PreparedStatement pstmt) {
	if(pstmt != null) try { pstmt.close();} catch(Exception e) { e.printStackTrace();}
	if(conn != null) try { conn.close();} catch(Exception e) { e.printStackTrace();}
	}
	
	// 장바구니 추가
		public int insertCart(CartDataBean cart) {
			System.out.println("===> insertCart() 기능 처리");
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = "";
			int count = 0;
			boolean check = false; // 장바구니에 같은 상품이 있는지를 검사
			int b_count = 0;
			
			try {
				conn = getConnection();
				
				sql = "select * from cart where buyer=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, cart.getBuyer());
				rs = pstmt.executeQuery();
				
				// 중복 상품 체크
				while(rs.next()) {
					if(rs.getInt("product_id") == cart.getProduct_id()) {
						check = true;
						b_count = rs.getInt("buy_count");
					}
				}
				
				// 장바구니의 product_id가 같으면 수량만 추가, product_id가 다르면 상품을 장바구니 추가
				if(check == true) { // 장바구니에 중복 상품이 있다면
					sql = "update cart set buy_count=? where product_id=? and buyer=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, b_count + cart.getBuy_count());
					pstmt.setInt(2, cart.getProduct_id());
					pstmt.setString(3, cart.getBuyer());
					count = pstmt.executeUpdate();	
					
				} else {
				sql = "insert into cart(buyer, product_id, product_name, product_image, buy_price, buy_count) values(?,?,?,?,?,?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, cart.getBuyer());
				pstmt.setInt(2, cart.getProduct_id());
				pstmt.setString(3, cart.getProduct_name());
				pstmt.setString(4, cart.getProduct_image());
				pstmt.setInt(5, cart.getBuy_price());
				pstmt.setInt(6, cart.getBuy_count());
				// 성공하면 1, 실패하면 0을 리턴
				count = pstmt.executeUpdate();
				}
			} catch(Exception e) {
				System.out.println("### insertCart() 에러");
				e.printStackTrace();
			} finally {
				close(conn, pstmt);
			}
			return count;
		}
		
		// 장바구니 수정 - 카드 아이디에 대한 장바구니 수량 수정
		public void updateCart(int cart_id, int buy_count) {
			System.out.println("===> updateCart() 기능 처리");
			Connection conn = null;
			PreparedStatement pstmt = null;
			String sql = "";
			
			System.out.println("cart_id: " + cart_id);
			System.out.println("buy_count: " + buy_count);
			
			try {
				conn = getConnection();
				sql = "update cart set buy_count=? where cart_id=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, buy_count);
				pstmt.setInt(2, cart_id);
				pstmt.executeUpdate();
			} catch(Exception e) {
				System.out.println("### updateCart() 에러");
				e.printStackTrace();
			} finally {
				close(conn, pstmt);
			}
		}
		
		// 장바구니 개별 삭제(1개)
		public void deleteCart(int cart_id) {
			System.out.println("===> deleteCart() 1개 삭제 기능 처리");
			Connection conn = null;
			PreparedStatement pstmt = null;
			String sql = "";
			
			try {
				conn = getConnection();
				sql = "delete from cart where cart_id=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, cart_id);
				pstmt.executeUpdate();			
			} catch(Exception e) {
				System.out.println("### deleteCart() 1개 삭제 에러");
				e.printStackTrace();
			} finally {
				close(conn, pstmt);
			}
		}
		
		// 장바구니 전체 삭제(전체 비우기)
		public void deleteCart(String buyer) {
			System.out.println("===> deleteCart() 전체 삭제 기능 처리");
			Connection conn = null;
			PreparedStatement pstmt = null;
			String sql = "";
			
			try {
				conn = getConnection();
				sql = "delete from cart where buyer=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, buyer);
				pstmt.executeUpdate();			
			} catch(Exception e) {
				System.out.println("### deleteCart() 전체 삭제 에러");
				e.printStackTrace();
			} finally {
				close(conn, pstmt);
			}
		}
		
		
		// 장바구니 목록 보기 (1개 또는 전체)
		public List<CartDataBean> getCartList(String buyer, int cart_id) {
			System.out.println("===> getCartList() 기능 처리");
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = "";
			List<CartDataBean> cartList = new ArrayList<CartDataBean>();
			CartDataBean cart = null;
			
			try {
				conn = getConnection();
				
				if(cart_id == -1) { // 전체 장바구니 목록
					sql = "select * from cart where buyer=? order by cart_id desc";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, buyer);
				} else {			// 장바구니 1개
					sql = "select * from cart where cart_id=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, cart_id);
				}
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					cart = new CartDataBean();
					cart.setCart_id(rs.getInt("cart_id"));
					cart.setBuyer(rs.getString("buyer"));
					cart.setProduct_id(rs.getInt("product_id"));
					cart.setProduct_name(rs.getString("product_name"));
					cart.setProduct_image(rs.getString("product_image"));
					cart.setBuy_price(rs.getInt("buy_price"));
					cart.setBuy_count(rs.getInt("buy_count"));
					cartList.add(cart);
				}
			} catch(Exception e) {
				System.out.println("### getCartList() 에러");
				e.printStackTrace();
			} finally {
				close(conn, pstmt, rs);
			}
			return cartList;
		}
		
		
		// 장바구니에 담기 상품 가지 수 
		public int getCartListCout(String buyer) { 
			System.out.println("===> getCartListCount() 기능 처리");
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = "";
			int count = 0;
			
			try {
				conn = getConnection();
				sql = "select count(*) from cart where buyer=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, buyer);
				rs = pstmt.executeQuery();
				
				if(rs.next()) count = rs.getInt(1);
				
			} catch(Exception e) {
				System.out.println("### getCartListCount() 에러");
				e.printStackTrace();
			} finally {
				close(conn, pstmt, rs);
			}
			return count;
		}
	
	
	
}
	
	
