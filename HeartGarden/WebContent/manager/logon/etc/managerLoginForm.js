
/* managerLoginForm.js */

function formCheck() {
	var loginForm = document.managerLoginForm;
	
	if(!loginForm.id.value) {
		alert('아이디를 입력해 주세요!');
		loginForm.id.focus();
		return false;
	}
	
	if(!loginForm.passwd.value) {
		alert('비밀번호를 입력해 주세요!');
		loginForm.passwd.focus();
		return false;
	}
}