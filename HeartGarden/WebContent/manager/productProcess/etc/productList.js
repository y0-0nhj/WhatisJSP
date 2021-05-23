// productList.js 

function selectProduct_kind() {
	var kind = document.getElementById("kind");
	
	var product_kind = kind.options[kind.selectedIndex].value;
	
	location = "productList.jsp?product_kind=" + product_kind;
}
