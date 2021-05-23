/* productRegisterForm.js */

function productRegisterCheck() {
	var form = document.productRegisterForm;
	
	if(!form.product_name.value) {
		alert('상품 이름을 입력해 주세요!');
		form.product_name.focus();
		return false;
	}
	if(!form.product_price.value) {
		alert('가격을 입력해 주세요!');
		form.product_price.focus();
		return false;
	}
	if(!form.product_count.value) {
		alert('수량을 입력해 주세요!');
		form.product_count.focus();
		return false;
	}
	if(!form.product_origin.value) {
		alert('원산지를 입력해 주세요!');
		form.product_origin.focus();
		return false;
	}

	if(!form.product_content.value) {
		alert('내용을 입력해 주세요!');
		form.product_content.focus();
		return false;
	}
	if(!form.discount_rate.value) {
		alert('할인율을 입력해 주세요!');
		form.discount_rate.focus();
		return false;
	}
}