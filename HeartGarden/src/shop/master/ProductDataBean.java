package shop.master;

import java.sql.Timestamp;

public class ProductDataBean {
	private int product_id;
	private String product_kind;
	private String product_image1;
	private String product_image2;
	private String product_image3;
	private String product_image4;
	private String product_name;
	private String product_color;
	private String product_content;
	private String product_origin;
	private int product_price;
	private int product_count;
	private int discount_rate;
	private Timestamp reg_date;

	public int getProduct_id() {
		return product_id;
	}

	public String getProduct_kind() {
		return product_kind;
	}

	public String getProduct_image1() {
		return product_image1;
	}

	public String getProduct_image2() {
		return product_image2;
	}

	public String getProduct_image3() {
		return product_image3;
	}

	public String getProduct_image4() {
		return product_image4;
	}

	public String getProduct_name() {
		return product_name;
	}

	public String getProduct_color() {
		return product_color;
	}

	public String getProduct_content() {
		return product_content;
	}

	public String getProduct_origin() {
		return product_origin;
	}

	public int getProduct_price() {
		return product_price;
	}

	public int getProduct_count() {
		return product_count;
	}

	public int getDiscount_rate() {
		return discount_rate;
	}

	public Timestamp getReg_date() {
		return reg_date;
	}

	public void setProduct_id(int product_id) {
		this.product_id = product_id;
	}

	public void setProduct_kind(String product_kind) {
		this.product_kind = product_kind;
	}

	public void setProduct_image1(String product_image1) {
		this.product_image1 = product_image1;
	}

	public void setProduct_image2(String product_image2) {
		this.product_image2 = product_image2;
	}

	public void setProduct_image3(String product_image3) {
		this.product_image3 = product_image3;
	}

	public void setProduct_image4(String product_image4) {
		this.product_image4 = product_image4;
	}

	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}

	public void setProduct_color(String product_color) {
		this.product_color = product_color;
	}

	public void setProduct_content(String product_content) {
		this.product_content = product_content;
	}

	public void setProduct_origin(String product_origin) {
		this.product_origin = product_origin;
	}

	public void setProduct_price(int product_price) {
		this.product_price = product_price;
	}

	public void setProduct_count(int product_count) {
		this.product_count = product_count;
	}

	public void setDiscount_rate(int discount_rate) {
		this.discount_rate = discount_rate;
	}

	public void setReg_date(Timestamp reg_date) {
		this.reg_date = reg_date;
	}

}
