<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입폼</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"
	type="text/javascript"></script>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"
	type="text/javascript"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"
	integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
	crossorigin="anonymous" type="text/javascript"></script>
<style type="text/css">
* {
	box-sizing: border-box;
}
</style>
</head>
<body>
	<div class="joinform_container card border-primary m-auto"
		style="width: 80%;">
		<div
			class="header card-header bg-primary d-flex justify-content-center text-white">
			<h6>회원가입 정보 입력</h6>
		</div>
		<form id="joinForm" action="/insert.member"
			class="card-body needs-validation" method="post" novalidate>
			<div class="row g-3 m-2">
				<label for="inputId"
					class="col-sm-2 col-form-label text-start text-sm-end">ID</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="inputId" name="id"
						placeholder="아이디를 입력하세요" required title="이 필드는 필수입니다.">
					<div class="invalid-feedback">Please choose a ID.</div>

				</div>
				<div class="col-sm-3">
					<button id="IdDupliCheck" type="button"
						class="btn btn-primary col-form-btn">중복확인</button>
				</div>
			</div>
			<div class="row g-3 m-2">
				<label for="inputPW"
					class="col-sm-2 col-form-label text-start text-sm-end">PW</label>
				<div class="col-sm-6">
					<input type="password" class="form-control" id="inputPW" name="pw"
						placeholder="비밀번호를 입력하세요" required title="이 필드는 필수 입니다.">

				</div>

			</div>
			<div class="row g-3 m-2">
				<label for="inputPWCorrect"
					class="col-sm-2 col-form-label text-start text-sm-end">PW
					확인</label>
				<div class="col-sm-6">
					<input type="password" class="form-control" id="inputPWCorrect"
						placeholder="비밀번호를 다시 입력하세요">

				</div>

			</div>
			<div class="row g-3 m-2">
				<label for="inputName"
					class="col-sm-2 col-form-label text-start text-sm-end">이름</label>
				<div class="col-sm-6">
					<input type="text" class="form-control" id="inputName" name="name"
						placeholder="이름을 입력하세요">

				</div>

			</div>
			<div class="row g-3 m-2">
				<label for="inputPhone"
					class="col-sm-2 col-form-label text-start text-sm-end">전화번호</label>
				<div class="col-sm-6">
					<input type="text" class="form-control" id="inputPhone"
						name="phone" placeholder="전화번호를 입력하세요 예 (010-1234-5678)">

				</div>

			</div>
			<div class="row g-3 m-2">
				<label for="inputEmail"
					class="col-sm-2 col-form-label text-start text-sm-end">이메일</label>
				<div class="col-sm-6">
					<input type="text" class="form-control" id="inputEmail"
						name="email" placeholder="이메일을 입력하세요">

				</div>

			</div>
			<div class="row g-3 m-2">
				<label for="inputZoneCode"
					class="col-sm-2 col-form-label text-start text-sm-end">우편번호</label>
				<div class="col-sm-6">
					<input type="text" class="form-control" id="inputZoneCode"
						name="zoneCode" readonly placeholder="우편번호">

				</div>
				<div class="col-sm-2">
					<button id="zoneCodeAPIBtn" type="button"
						class="btn btn-primary col-form-btn">찾기</button>
				</div>
			</div>
			<div class="row g-3 m-2">
				<label for="inputAddress"
					class="col-sm-2 col-form-label text-start text-sm-end">주소</label>
				<div class="col-sm-8">
					<input type="text" class="form-control" id="inputAddress"
						name="address" readonly placeholder="주소를 입력하세요">

				</div>

			</div>
			<div class="row g-3 m-2">
				<label for="inputAddressDetail"
					class="col-sm-2 col-form-label text-start text-sm-end">상세주소</label>
				<div class="col-sm-8">
					<input type="text" class="form-control" id="inputAddressDetail"
						name="addressDetail" placeholder="상세주소를 입력하세요">

				</div>

			</div>
			<div class="row g-3 m-2 d-flex justify-content-center">

				<div class="col-auto">
					<button id="submitBtn" class="btn btn-primary">회원가입</button>
					<button id="reset" type="button" class="btn btn-primary">다시입력</button>
				</div>

			</div>

		</form>
	</div>

	<script type="text/javascript">
		let isDuplicateChecked = false;

		function setDuplicateCheckTrue() {
			isDuplicateChecked = true;
			$('#inputId').css({
				"border" : "2px solid green"
			})
		}

		$('#inputId').on("keydown", function() {
			isDuplicateChecked = false;
			$('#inputId').css({
				"border" : "2px solid red"
			})

		})

		$("#zoneCodeAPIBtn").on("click", function() {

			new daum.Postcode({
				oncomplete : function(data) {

					$("#inputZoneCode").val(data.zonecode);
					$("#inputAddress").val(data.address);
				}
			}).open();

		});

		$("#reset")
				.click(
						function() {

							$("input").val("");
							$(
									"#inputId, #inputPW, #inputPWCorrect, #inputPhone, #inputName")
									.css({
										"border" : "2px solid red"
									})

						});

		$("#IdDupliCheck").click(
				function() {
					//아이디 체크를 담당하는 팝업창을 띄우기
					//window.open("url값", "", "옵션")
					//넘겨보내는 서블릿 주소에 파라미터로서 id에 값을 넘겨주면 됨.

					window.open("/idcheck.member?id=" + $('#inputId').val(),
							"", "width=350, height=200")
				});

		$("#joinForm").on("submit", function() {

			console.log("전송 버튼 누름")

			//아이디 검사

			if ($('#inputId').val() == "") {
				alert("아이디를 입력해주세요!")
				return false;
			}

			let regex = /^[a-z0-9_]{4,12}$/;
			if (!regex.test($('#inputId').val())) {
				alert("아이디가 적합하지 않습니다!")
				return false;
			}

			if (!isDuplicateChecked) {
				alert("아직 중복 검사를 하지 않았습니다!")
				return false;
			}

			//패스워드 검사

			if ($('#inputPW').val() == "") {
				alert("패스워드를 입력해주세요!")
				return false;
			}

			//영문 숫자, 특수문자
			regex = /^([a-zA-Z0-9]|[^a-zA-Z0-9\s]){8,16}$/
			if (!regex.test($('#inputPW').val())) {
				alert("패스워드가 적합하지 않습니다!")
				return false;
			}
			regex = /[a-zA-Z]+?/
			if (!regex.test($('#inputPW').val())) {
				alert("패스워드에 최소 한번의 영문이 들어가지 않습니다!")
				return false;
			}

			regex = /[0-9]+?/
			if (!regex.test($('#inputPW').val())) {
				alert("패스워드에 최소 한번의 숫자가 들어가지 않습니다!")
				return false;
			}

			regex = /[^a-zA-Z0-9\s]+?/
			if (!regex.test($('#inputPW').val())) {
				alert("패스워드에 최소 한번의 특수기호가 들어가지 않습니다!")
				return false;
			}

			let pwInputCorrect = $('#inputPWCorrect').val();
			//8~16자의 영문, 숫자, 특수문자를 최소한 각각 한글자 이상 포함해야 함
			//if문 여러번 사용 가능

			if (pwInputCorrect == "") {
				alert("패스워드 확인을 입력해주세요!")
				return false;
			}

			if (pwInputCorrect != $('#inputPW').val()) {
				alert("패스워드 확인이 일치하지 않습니다!");
				return false;
			}

			let nameInput = document.getElementById("inputName").value;
			//이름은 2~6글자의 한글로만 구성 가능

			if (nameInput == "") {
				alert("이름이 빈칸이에요");
				return false;
			}

			regex = /^[가-힣]{2,6}$/;
			if (!regex.test(nameInput)) {
				alert("부모님이 주신 이름을 사용하세요");
				return false;
			}

			let phoneInput = $("#inputPhone").val();
			//핸드폰 번호 형식은 010-????-????
			regex = /^01[0-9]-\d{3,4}-\d{4}$/;
			if (!regex.test(phoneInput)) {
				alert("적합하지 않은 핸드폰 번호입니다.");
				return false;
			}

			let emailInput = document.getElementById("inputEmail").value;
			//이메일은 영문 대/소문자 및 숫자만 사용가능
			//@기호가 하나는 포함되어야 하며    
			//.com이나 .co.kr처럼 입력 가능해야 함.
			//즉 이메일 형식에 맞게

			regex = /^[a-z0-9_]{4,12}@[a-zA-Z0-9]+(\.com|\.co\.kr)$/;
			if (!regex.test(emailInput)) {
				alert("적합하지 않은 이메일입니다.");
				return false;
			}

		});
	</script>
</body>
</html>