package shop.board_review;

import java.sql.Timestamp;

// 상품 리뷰 게시판으로 사용  - product_id 필드로 구분함.
public class BoardReviewDataBean {
	private int num;
	private String writer;
	private String passwd;
	private String product_id; // 상품 아이디별로 게시판이 나타나게 됨.
	private String subject;
	private String content;
	private Timestamp reg_date;
	private int readcount;
	private int ref;
	private int re_step;
	private int re_level;

	public int getNum() {
		return num;
	}

	public String getWriter() {
		return writer;
	}

	public String getPasswd() {
		return passwd;
	}

	public String getProduct_id() {
		return product_id;
	}

	public String getSubject() {
		return subject;
	}

	public String getContent() {
		return content;
	}

	public Timestamp getReg_date() {
		return reg_date;
	}

	public int getReadcount() {
		return readcount;
	}

	public int getRef() {
		return ref;
	}

	public int getRe_step() {
		return re_step;
	}

	public int getRe_level() {
		return re_level;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}

	public void setProduct_id(String product_id) {
		this.product_id = product_id;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public void setReg_date(Timestamp reg_date) {
		this.reg_date = reg_date;
	}

	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}

	public void setRef(int ref) {
		this.ref = ref;
	}

	public void setRe_step(int re_step) {
		this.re_step = re_step;
	}

	public void setRe_level(int re_level) {
		this.re_level = re_level;
	}

}
