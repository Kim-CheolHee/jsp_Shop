
function logincheck() {
	var id = document.getElementById("id").value;
	var pass = document.getElementById("pass").value;
	var name = document.getElementById("name").value;
	
	
	
	var regId = /^[a-zA-Z0-9]*$/;     // 영어와 숫자만 입력되게 유효성 검사 설정
	var regPass = /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[~?!@#$%^&*_-]).{8,}$/;
	// 비밀번호는 영어(대소문자) + 숫자 + 특수문자 포함되어야 하고 8글자 이상
	var regName = /^[가-힣]*$/; // 이름은 한글만 입력 가능하게 유효성 검사 설정
	
	if(id.length<7) {
		alert("아이디는 7글자 이상입니다.");
		return false;
	} else if(!regId.test(id)) {
		alert("아이디는 영어와 숫자만 사용할 수 있습니다.");
		return false;
	}
	
	if(!regPass.test(pass)) {
		alert("비밀번호는 영어,숫자,특수문자 포함 8글자 이상입니다.");
		return false;
	}
	
	if(!regName.test(name)) {
		alert("이름은 한글만 입력 가능합니다.");
		return false;
	}
	
}