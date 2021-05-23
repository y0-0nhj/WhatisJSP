package shop.board_qna;

import java.sql.Timestamp;

// QnA 게시판으로 사용  - q_kind 필드로 구분함.
public class BoardQnaDataBean {
	private int num;
	private String writer;
	private String passwd;
	private String q_kind; // QnA의 종류, 상품, 배송, 결제, 반납, 서비스, 기타...
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

	public String getQ_kind() {
		return q_kind;
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

	public void setQ_kind(String q_kind) {
		this.q_kind = q_kind;
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
