package shop.board_review;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

// BoardDAO
public class BoardReviewDBBean {
	// singleton 패턴
	private static BoardReviewDBBean instance = new BoardReviewDBBean();
	public static BoardReviewDBBean getInstance() {
		return instance;
	}
	private BoardReviewDBBean() {}
	
	// 커넥션풀 연결
	private Connection getConnection() throws Exception {
		Context initCtx = new InitialContext();
		Context envCtx = (Context)initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource) envCtx.lookup("jdbc/heartgarden");
		return ds.getConnection();
	}
		
	// Connection, PreparedStatement, ResultSet 객체 닫기
	private void close(Connection conn, PreparedStatement pstmt, ResultSet rs) {
		if(rs != null) try { rs.close();} catch(Exception e) { e.printStackTrace();}
		if(pstmt != null) try { pstmt.close();} catch(Exception e) { e.printStackTrace();}
		if(conn != null) try { conn.close();} catch(Exception e) { e.printStackTrace();}
	}
	
	// 글 추가 -> writePro.jsp 에서 사용
	
	public void insertArticle(BoardReviewDataBean article) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int num = article.getNum();
		int ref = article.getRef();
		int re_step = article.getRe_step();
		int re_level = article.getRe_level();
		int number = 0;
		String sql = "";
		
		try {
			conn = getConnection();
			
			sql = "select max(num) from board_review";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) number = rs.getInt(1) + 1; // 글이 있을 때, 글번호 최댓값에 1을 더해서 구함.
			else number = 1; // 아무 글이 없고, 처음으로 글을 추가할 때
			
			// 댓글 처리에 관련된 부분 - 중요하고, 어려운 부분
			if(num != 0) { // num이  0이 아닐 때, 댓글일 때
				sql = "update board_review set re_step=re_step+1 where ref=? and re_step>?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, ref);
				pstmt.setInt(2, re_step);
				pstmt.executeUpdate();
				
				re_step = re_step+1;
				re_level = re_level+1;
			} else { // num이 0일 때, 댓글이 아닐때(원글일 ㄸ)
				ref = number;
				re_step = 0;
				re_level = 0;
			}
			
			// 데이터 추가
			sql = "insert into board_review(writer, passwd, product_id, subject, content, reg_date, ref, re_step, re_level) "
					+ "values(?,?,?,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, article.getWriter());
			pstmt.setString(2, article.getPasswd());
			pstmt.setString(3, article.getProduct_id());
			pstmt.setString(4, article.getSubject());
			pstmt.setString(5, article.getContent());
			pstmt.setTimestamp(6, article.getReg_date());
			pstmt.setInt(7, ref);
			pstmt.setInt(8, re_step);
			pstmt.setInt(9, re_level);
			pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("### insertArticle() 에러 ###");
		} finally {
			close(conn, pstmt, rs);
		}
	}
	
	// 전체 글수 -> list.jsp 에서 사용
	public int getArticleCount(String product_id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int x = 0; // 전체 글수
		String sql = "";
		
		try {
			conn = getConnection();
			
			sql = "select count(*) from board_review where product_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, product_id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) x = rs.getInt(1);	
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("### getArticleCount() 에러 ###");
		} finally {
			close(conn, pstmt, rs);
		}
		return x;
	}
	
	// 페이징(paging) 처리 - 페이지를 나누는 일.
	// 글의 목록(10개) 보기 -> list.jsp 에서 사용
	// 상품 아이디별(product_id)로 목록을 구함
	public List<BoardReviewDataBean> getArticles(int start, int end, String product_id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		List<BoardReviewDataBean> articleList = new ArrayList<BoardReviewDataBean>();
		BoardReviewDataBean article = null;
		String sql = "";
		
		try {
			conn = getConnection();
			
			sql = "select * from board_review where product_id=? order by ref desc, re_step asc limit ?, ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, product_id);
			pstmt.setInt(2, start-1); // limit는 0번부터 시작
			pstmt.setInt(3, end);     // 가져올 로우수 
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				article = new BoardReviewDataBean();
				article.setNum(rs.getInt("num"));
				article.setWriter(rs.getString("writer"));
				article.setPasswd(rs.getString("passwd"));
				article.setProduct_id(rs.getString("product_id"));
				article.setSubject(rs.getString("subject"));
				article.setContent(rs.getString("content"));
				article.setReg_date(rs.getTimestamp("reg_date"));
				article.setReadcount(rs.getInt("readcount"));
				article.setRef(rs.getInt("ref"));
				article.setRe_step(rs.getInt("re_step"));
				article.setRe_level(rs.getInt("re_level"));
				articleList.add(article);
			}
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("### getArticles() 에러 ###");
		} finally { 
			close(conn, pstmt, rs);
		}
		return articleList;
	}
	
	// 글 내용(1건) 보기 -> content.jsp 에서 사용
	public BoardReviewDataBean getArticle(int num) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		BoardReviewDataBean article = null;
		String sql = "";
		
		try {
			conn = getConnection();
			
			sql = "update board_review set readcount=readcount+1 where num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeLargeUpdate();
			
			sql = "select * from board_review where num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				article = new BoardReviewDataBean();
				article.setNum(rs.getInt("num"));
				article.setWriter(rs.getString("writer"));
				article.setPasswd(rs.getString("passwd"));
				article.setProduct_id(rs.getString("product_id"));
				article.setSubject(rs.getString("subject"));
				article.setContent(rs.getString("content"));
				article.setReg_date(rs.getTimestamp("reg_date"));
				article.setReadcount(rs.getInt("readcount"));
				article.setRef(rs.getInt("ref"));
				article.setRe_step(rs.getInt("re_step"));
				article.setRe_level(rs.getInt("re_level"));
			}
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("### getArticle() 에러 ###");
		} finally {
			close(conn, pstmt, rs);
		}
		return article;
	}
	
	// 글 수정폼 보기 -> updateForm.jsp
	public BoardReviewDataBean updateGetArticle(int num) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		BoardReviewDataBean article = null;
		String sql = "";
		
		try {
			conn = getConnection();
			
			sql = "select * from board_review where num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				article = new BoardReviewDataBean();
				article.setNum(rs.getInt("num"));
				article.setWriter(rs.getString("writer"));
				article.setPasswd(rs.getString("passwd"));
				article.setProduct_id(rs.getString("product_id"));
				article.setSubject(rs.getString("subject"));
				article.setContent(rs.getString("content"));
				article.setReg_date(rs.getTimestamp("reg_date"));
				article.setReadcount(rs.getInt("readcount"));
				article.setRef(rs.getInt("ref"));
				article.setRe_step(rs.getInt("re_step"));
				article.setRe_level(rs.getInt("re_level"));
			}
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("### updateGetArticle() 에러 ###");
		} finally {
			close(conn, pstmt, rs);
		}
		return article;
	}
	
	// 글 수정 처리 -> updatePro.jsp
	public int updateArticle(BoardReviewDataBean article) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String dbPasswd = "";
		int x = -1;
		String sql = "";
		
		try {
			conn = getConnection();
			
			sql = "select passwd from board_review where num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, article.getNum());
			rs = pstmt.executeQuery();
			
			// x=-1(아이디가 없음), x=1(아이디와 비밀번호가 모두 일치), x=0(아이디는 있으나 비밀번호가 다를 때)
			if(rs.next()) { // 아이디가 있을 때
				dbPasswd = rs.getString("passwd");
				if(dbPasswd.equals(article.getPasswd())) { // 비밀번호가 같을 때
					sql = "update board_review set product_id=?, subject=?, content=? where num=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, article.getProduct_id());
					pstmt.setString(2, article.getSubject());
					pstmt.setString(3, article.getContent());
					pstmt.setInt(4, article.getNum());
					pstmt.executeUpdate();
					x = 1;
				} else x = 0;  // 비밀번호가 다를 때
			} 
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("### updateArticle() 에러 ###");
		} finally {
			close(conn, pstmt, rs);
		}
		return x;	
	}
	
	// 글 삭제 처리 -> deletePro.jsp
	public int deleteArticle(int num, String passwd) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String dbPasswd = "";
		int x = -1;
		String sql = "";
		
		try {
			conn = getConnection();
			
			sql = "select passwd from board_review where num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			// x=-1(아이디가 없음), x=1(아이디와 비밀번호가 모두 일치), x=0(아이디는 있으나 비밀번호가 다를 때)
			if(rs.next()) { // 아이디가 있을 때
				dbPasswd = rs.getString("passwd");
				if(dbPasswd.equals(passwd)) { // 비밀번호가 같을 때
					sql = "delete from board_review where num=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, num);
					pstmt.executeUpdate();
					x = 1;
				} else x = 0;  // 비밀번호가 다를 때
			} 
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("### deleteArticle() 에러 ###");
		} finally {
			close(conn, pstmt, rs);
		}
		return x;
	}
	
}
