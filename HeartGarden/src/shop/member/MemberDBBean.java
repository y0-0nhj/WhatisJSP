package shop.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

// MemberDAO
public class MemberDBBean {
	// Singleton 패턴
	private MemberDBBean() { }
	
	private static MemberDBBean instance = new MemberDBBean();
	
	public static MemberDBBean getInstance() {
		return instance;
	}
	
	// Apache Commons Connection Pool 사용
	private Connection getConnection() throws Exception {
		Context initCtx = new InitialContext();
		Context envCtx = (Context)initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource)envCtx.lookup("jdbc/heartgarden");
		return ds.getConnection();
	}
	
	// Connection, PreparedStatement, ResultSet 객체 닫기
	private void close(Connection conn, PreparedStatement pstmt, ResultSet rs) {
		if(rs != null) try { rs.close();} catch(Exception e) { e.printStackTrace();}
		if(pstmt != null) try { pstmt.close();} catch(Exception e) { e.printStackTrace();}
		if(conn != null) try { conn.close();} catch(Exception e) { e.printStackTrace();}
	}
	
	// Connection, PreparedStatement 객체 닫기
	private void close(Connection conn, PreparedStatement pstmt) {
		if(pstmt != null) try { pstmt.close();} catch(Exception e) { e.printStackTrace();}
		if(conn != null) try { conn.close();} catch(Exception e) { e.printStackTrace();}
	}
	
	// 회원가입
	public int insertMember(MemberDataBean member) {
		System.out.println("===> insertMember() 메소드 처리");
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql ="";
		int check = 0;
		
		try {
			conn = getConnection();
			
			// 중복 아이디 체크 - confirmId() 메소드 호출
			// check가 1이면 중복 아이디, check가 -1이면 새로운 아이디
			check = confirmId(member.getId());
			
			if(check == -1) { // 아이디가 없을 때(아이디가 중복되지 않을 때)
				sql = "insert into member values(?,?,?,?,?,?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, member.getId());
				pstmt.setString(2, member.getPasswd());
				pstmt.setString(3, member.getName());
				pstmt.setTimestamp(4, member.getReg_date());
				pstmt.setString(5, member.getAddress());
				pstmt.setString(6, member.getTel());
				pstmt.executeUpdate();
			}	
		} catch(Exception e) {
			System.out.println("### insertMember() 에러");
			e.printStackTrace();
		} finally {
			close(conn, pstmt);
		}
		return check;
	}
	
	// 사용자 인증 처리 (아이디와 비밀번호 확인)
	public int userCheck(String id, String passwd) {
		System.out.println("===> userCheck() 메소드 처리");
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		String dbPasswd = "";
		int x = -1;
		
		try {
			conn = getConnection();
			
			sql = "select passwd from member where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			// 아이디가 있고, 비밀번호 일치하면, x=1
			// 아이디가 있고, 비밀번호 일치하지 않으면, x=0
			// 아이디가 없다면, x=-1
			if(rs.next()) {
				dbPasswd = rs.getString("passwd");
				
				if(dbPasswd.equals(passwd)) x = 1;
				else x = 0;
			}
			System.out.println("x = " + x);
		} catch(Exception e) {
			System.out.println("### userCheck() 에러");
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return x;
	}
	
	// 회원가입시에 중복아이디를 체크
	public int confirmId(String id) {
		System.out.println("===> confirmId() 메소드 처리");
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		int x = -1;
		
		try {
			conn = getConnection();
			
			sql = "select id from member where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			// 아이디가 이미 존재하면 1, 아이디가 존재하지 않으면 -1
			if(rs.next()) x = 1;	
		} catch(Exception e) {
			System.out.println("### confirmId() 에러");
			e.printStackTrace();
		} finally { 
			close(conn, pstmt, rs);
		}	
		return x;
	}
	
	// 회원정보 확인 - 회원 자신의 정보 확인 (1명) - 사용자	
	public MemberDataBean getMember(String id) {
		System.out.println("===> getMember() 메소드 처리");
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		MemberDataBean member = null;
		
		try {
			conn = getConnection();
			
			sql = "select * from member where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				member = new MemberDataBean();
				member.setId(rs.getString("id"));
				member.setPasswd(rs.getString("passwd"));
				member.setName(rs.getString("name"));
				member.setReg_date(rs.getTimestamp("reg_date"));
				member.setAddress(rs.getString("address"));
				member.setTel(rs.getString("tel"));	
			}
		} catch(Exception e) {
			System.out.println("### getMember() 에러");
			e.printStackTrace();
		} finally { 
			close(conn, pstmt, rs);
		}
		return member;
	}
	
	// 회원정보 전체 확인 - 관리자
	public List<MemberDataBean> getMembers() {
		System.out.println("===> getMembers() 메소드 처리");
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<MemberDataBean> memberList = new ArrayList<MemberDataBean>();
		MemberDataBean member = null;
		String sql = "";
		
		try {
			conn = getConnection();
			
			sql = "select * from board order by reg_date desc";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				member = new MemberDataBean();
				member.setId(rs.getString("id"));
				member.setPasswd(rs.getString("passwd"));
				member.setName(rs.getString("name"));
				member.setReg_date(rs.getTimestamp("reg_date"));
				member.setAddress(rs.getString("address"));
				member.setTel(rs.getString("tel"));
				memberList.add(member);
			}
		} catch(Exception e) {
			System.out.println("### getMembers() 에러");
			e.printStackTrace();
		} finally { 
			close(conn, pstmt, rs);
		}
		return memberList;
	}
	
	// 회원정보 수정
	public void updateMember(MemberDataBean member) {
		System.out.println("===> updateMember() 메소드 처리");
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "";
		
		try {
			conn = getConnection();
			
			sql = "update member set passwd=?, name=?, address=?, tel=? where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getPasswd());
			pstmt.setString(2, member.getName());
			pstmt.setString(3, member.getAddress());
			pstmt.setString(4, member.getTel());
			pstmt.setString(5, member.getId());
			pstmt.executeUpdate();
		} catch(Exception e) {
			System.out.println("### updateMember() 에러");
			e.printStackTrace();
		} finally {
			close(conn, pstmt);
		} 
	}
	
	// 회원정보(회원탈퇴)
	public void deleteMember(String id, String passwd) {
		System.out.println("===> deleteMember() 메소드 처리");
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql= "";
		
		try {
			conn = getConnection();
			
			sql = "delete from member where id=? and passwd=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, passwd);
			pstmt.executeUpdate();   
		} catch(Exception e) {
			System.out.println("### deleteMember() 에러");
			e.printStackTrace();
		} finally { 
			close(conn, pstmt, rs);
		}
	}
}
