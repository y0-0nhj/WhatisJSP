package shop.bank;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BankDBBean {
	// singleton 패턴
	private BankDBBean() {}
	
	private static BankDBBean instance = new BankDBBean();
	
	public static BankDBBean getInstance() {
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
	
	// 뱅크 정보 등록
	public void insertBank(BankDataBean bank) {
		System.out.println("===> insertBank() 기능 처리");
		Connection conn = null;
		PreparedStatement pstmt= null;
		String sql="";
		
		try {
			conn = getConnection();
			sql = "insert into bank values(?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, bank.getCard_no());
			pstmt.setString(2, bank.getCard_com());
			pstmt.setString(3, bank.getMember_name());
			pstmt.setString(4, bank.getMember_id());
			pstmt.executeUpdate();
			
		} catch(Exception e) {
			System.out.println("### insertBank 에러");
			e.printStackTrace();
		} finally {
			close(conn, pstmt);
		}
	}
	
	// 뱅크 정보 삭제
	public void deleteBank(String card_no) {
		System.out.println("===> deleteBank() 기능 처리");
		Connection conn = null;
		PreparedStatement pstmt= null;
		String sql="";
		
		try {
			conn = getConnection();
			sql = "delete from bank where card_no=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, card_no);
			pstmt.executeUpdate();
		} catch(Exception e) {
			System.out.println("### deleteBank 에러");
			e.printStackTrace();
		} finally {
			close(conn, pstmt);
		}
	}
	
	// 뱅크 정보 전체 보기
	public List<BankDataBean> getBankList(String member_id) {
		System.out.println("===> getBankList() 기능 처리");
		Connection conn = null;
		PreparedStatement pstmt= null;
		ResultSet rs = null;
		String sql="";
		List<BankDataBean> bankList = new ArrayList<BankDataBean>();
		BankDataBean bank = null;
		
		try {
			conn = getConnection();
			sql = "select * from bank where member_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member_id);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				bank = new BankDataBean();
				bank.setCard_no( rs.getString("card_no"));
				bank.setCard_com( rs.getString("card_com"));
				bank.setMember_name( rs.getString("member_name"));
				bank.setMember_id( rs.getString("member_id"));
				bankList.add(bank);
			}
			
		} catch(Exception e) {
			System.out.println("### getBankList 에러");
			e.printStackTrace();
		} finally {
			close(conn, pstmt);
		}
		return bankList;
	}
}
