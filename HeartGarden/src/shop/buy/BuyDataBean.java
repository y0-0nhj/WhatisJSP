package shop.buy;

import java.sql.Timestamp;

public class BuyDataBean {
	private String buy_id;
	private String buyer;
	private int product_id;
	private String product_name;
	private String product_image;
	private int buy_price;
	private int buy_count;
	private Timestamp buy_date;
	private String bank_info;
	private String delivery_name;
	private String delivery_tel;
	private String delivery_address;
	private String delivery_state;
	
	
	public String getBuy_id() {
		return buy_id;
	}
	public String getBuyer() {
		return buyer;
	}
	public int getProduct_id() {
		return product_id;
	}
	public String getProduct_name() {
		return product_name;
	}
	public String getProduct_image() {
		return product_image;
	}
	public int getBuy_price() {
		return buy_price;
	}
	public int getBuy_count() {
		return buy_count;
	}
	public Timestamp getBuy_date() {
		return buy_date;
	}
	public String getBank_info() {
		return bank_info;
	}
	public String getDelivery_name() {
		return delivery_name;
	}
	public String getDelivery_tel() {
		return delivery_tel;
	}
	public String getDelivery_address() {
		return delivery_address;
	}
	public String getDelivery_state() {
		return delivery_state;
	}
	public void setBuy_id(String buy_id) {
		this.buy_id = buy_id;
	}
	public void setBuyer(String buyer) {
		this.buyer = buyer;
	}
	public void setProduct_id(int product_id) {
		this.product_id = product_id;
	}
	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}
	public void setProduct_image(String product_image) {
		this.product_image = product_image;
	}
	public void setBuy_price(int buy_price) {
		this.buy_price = buy_price;
	}
	public void setBuy_count(int buy_count) {
		this.buy_count = buy_count;
	}
	public void setBuy_date(Timestamp buy_date) {
		this.buy_date = buy_date;
	}
	public void setBank_info(String bank_info) {
		this.bank_info = bank_info;
	}
	public void setDelivery_name(String delivery_name) {
		this.delivery_name = delivery_name;
	}
	public void setDelivery_tel(String deleivery_tel) {
		this.delivery_tel = deleivery_tel;
	}
	public void setDelivery_address(String delivery_address) {
		this.delivery_address = delivery_address;
	}
	public void setDelivery_state(String delivery_state) {
		this.delivery_state = delivery_state;
	}
	@Override
	public String toString() {
		return "BuyDataBean [buy_id=" + buy_id + ", buyer=" + buyer + ", product_id=" + product_id + ", product_name="
				+ product_name + ", product_image=" + product_image + ", buy_price=" + buy_price + ", buy_count="
				+ buy_count + ", buy_date=" + buy_date + ", bank_info=" + bank_info + ", delivery_name=" + delivery_name
				+ ", deleivery_tel=" + delivery_tel + ", delivery_address=" + delivery_address + ", delivery_state="
				+ delivery_state + "]";
	}

	
	
	
	
}
