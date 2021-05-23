package shop.buy;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import shop.cart.CartDataBean;

public class BuyDBBean {
	// singleton 패턴
	private BuyDBBean() {}
	
	private static BuyDBBean instance = new BuyDBBean();
	
	public static BuyDBBean getInstance() {
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
		if(rs != null) try { rs.close();} catch(Exception e) { e.printStackTrace();}
		if(pstmt != null) try { pstmt.close();} catch(Exception e) { e.printStackTrace();}
		if(conn != null) try { conn.close();} catch(Exception e) { e.printStackTrace();}
	}
	
	// Connection, PreparedStatement 객체 해제
	private void close(Connection conn, PreparedStatement pstmt) {
		if(pstmt != null) try { pstmt.close();} catch(Exception e) { e.printStackTrace();}
		if(conn != null) try { conn.close();} catch(Exception e) { e.printStackTrace();}
	}
	
	
	// 구매 목록 추가하고, 장바구니 목록에서는 삭제 ---> 트랜잭션 처리
	public int insertBuyList(List<BuyDataBean> buyList, List<CartDataBean> cartList) {
		System.out.println("===> insertBuyList() 기능 처리");
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql="";
		int check=0;
		int product_count = 0;
		
		try {
			conn = getConnection();
			
			// 하나의 트랜잭션으로 처리 - 시작
			conn.setAutoCommit(false);
			
			// 구매 목록에 추가
			sql = "insert into buy values(?,?,?,?,?,?,?,?,?,?,?,?,?)";
			for(BuyDataBean buy : buyList) {
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, buy.getBuy_id());
				pstmt.setString(2, buy.getBuyer());
				pstmt.setInt(3, buy.getProduct_id());
				pstmt.setString(4, buy.getProduct_name());
				pstmt.setString(5, buy.getProduct_image());
				pstmt.setInt(6, buy.getBuy_price());
				pstmt.setInt(7, buy.getBuy_count());
				pstmt.setTimestamp(8, buy.getBuy_date());
				pstmt.setString(9, buy.getBank_info());
				pstmt.setString(10, buy.getDelivery_name());
				pstmt.setString(11, buy.getDelivery_tel());
				pstmt.setString(12, buy.getDelivery_address());
				pstmt.setString(13,buy.getDelivery_state());
				pstmt.executeUpdate();
				++check;
			}
			
			// 장바구니담기를 통해 구매를 했을 때, 상품보기에서 바로구매를 했을 때 들어가지 않음.
			if(cartList != null) {
				// 장바구니에서 삭제
				sql = "delete from cart where cart_id=?";
				for(CartDataBean cart : cartList) {
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, cart.getCart_id());
					pstmt.executeUpdate();
				}
			}
			
			// 상품 테이블에 상품수량(재고량)에서 주문수량만큼 빼도록 업데이트
			for(BuyDataBean buy : buyList) {
				// 재고 수량 업데이트
				sql = "update product set product_count=product_count-? where product_id=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, buy.getBuy_count());
				pstmt.setInt(2, buy.getProduct_id());
				pstmt.executeUpdate();
			}
			
			// 하나의 트랜잭션으로 처리 - 끝
			conn.commit();
			conn.setAutoCommit(true);
			
		} catch(Exception e) {
			System.out.println("### insertBuyList()에러");
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return check;
	}
	
	// 구매 상품 목록 중 1개씩 저장한 리스트 생성
	public List<BuyDataBean> getBuyListOne(String buyer) {
		System.out.println("===> getBuyListOne() 기능 처리");
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql="";
		List<BuyDataBean> buyList = new ArrayList<BuyDataBean>();
		BuyDataBean buy = null;
		List<String> buyIdList = new ArrayList<String>();
		
		try {
			conn = getConnection();
			
			// 구매 목록 중복없이 불러오기
			sql = "select distinct(buy_id) from buy where buyer=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, buyer);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				buyIdList.add(rs.getString("buy_id"));
			}
			
			// buy_id에 해당하는 구매 목록 불러오기 
			sql = "select * from buy where buy_id=? limit 1";
			for(int i=0; i<buyIdList.size(); i++) {
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, buyIdList.get(i));
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					buy = new BuyDataBean();
					buy.setBuy_id(rs.getString("buy_id"));
					buy.setBuyer(rs.getString("buyer"));
					buy.setProduct_id(rs.getInt("product_id"));
					buy.setProduct_name(rs.getString("product_name"));
					buy.setProduct_image(rs.getString("product_image"));
					buy.setBuy_price(rs.getInt("buy_price"));
					buy.setBuy_count(rs.getInt("buy_count"));
					buy.setBuy_date(rs.getTimestamp("buy_date"));
					buy.setBank_info(rs.getString("bank_info"));
					buy.setDelivery_name(rs.getString("delivery_name"));
					buy.setDelivery_tel(rs.getString("delivery_tel"));
					buy.setDelivery_address(rs.getString("delivery_address"));
					buy.setDelivery_state(rs.getString("delivery_state"));
					buyList.add(buy);
				}
			}
			
		} catch (Exception e){
			System.out.println("### getBuyListOne() 에러");
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return buyList;
	}
	
	// 구매 번호에 따른 전체 구매 목록 확인
	public List<BuyDataBean> getBuyListId(String buy_id) {
		System.out.println("===> getBuyListId() 기능 처리");
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql="";
		List<BuyDataBean> buyList = new ArrayList<BuyDataBean>();
		BuyDataBean buy = null;
		
		try {
			
			conn = getConnection();
			sql = "select * from buy where buy_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, buy_id);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				buy = new BuyDataBean();
				buy.setBuy_id(rs.getString("buy_id"));
				buy.setBuyer(rs.getString("buyer"));
				buy.setProduct_id(rs.getInt("product_id"));
				buy.setProduct_name(rs.getString("product_name"));
				buy.setProduct_image(rs.getString("product_image"));
				buy.setBuy_price(rs.getInt("buy_price"));
				buy.setBuy_count(rs.getInt("buy_count"));
				buy.setBuy_date(rs.getTimestamp("buy_date"));
				buy.setBank_info(rs.getString("bank_info"));
				buy.setDelivery_name(rs.getString("delivery_name"));
				buy.setDelivery_tel(rs.getString("delivery_tel"));
				buy.setDelivery_address(rs.getString("delivery_address"));
				buy.setDelivery_state(rs.getString("delivery_state"));
				buyList.add(buy);
			}
			
		} catch(Exception e) {
			System.out.println("### getBuyListId() 에러");
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return buyList;
	}
	
	// 구매 1건에 대한 구매 갯수 리턴하는 함수
	public int getBuyIdCount(String buy_id) {
		System.out.println("===> getBuyIdCount() 기능 처리");
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		int count = 0;
		
		try {
			conn = getConnection();
			sql = "select count(*) from buy where buy_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, buy_id);
			rs = pstmt.executeQuery();
			
			rs.next();
			count = rs.getInt(1);
			
		} catch(Exception e) {
			System.out.println("### getBuyIdCount() 에러");
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return count;
	}
	

	
}
