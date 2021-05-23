package shop.cart;

public class CartDataBean {
	private int cart_id;
	private String buyer;
	private int product_id;
	private String product_name;
	private String product_image;
	private int buy_price;
	private int buy_count;
	
	public int getCart_id() {
		return cart_id;
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
	public void setCart_id(int cart_id) {
		this.cart_id = cart_id;
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
	@Override
	public String toString() {
		return "CartDataBean [cart_id=" + cart_id + ", buyer=" + buyer + ", product_id=" + product_id
				+ ", product_name=" + product_name + ", product_image=" + product_image + ", buy_price=" + buy_price
				+ ", buy_count=" + buy_count + "]";
	}
	
	
	
	
	
}
