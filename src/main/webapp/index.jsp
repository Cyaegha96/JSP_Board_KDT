<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>로그인</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<style>
* {
	box-sizing: border-box;
}
</style>
</head>
<body>
	<div
		class="Login_conatiner card m-auto p-3 rounded-2 border-primary d-flex justify-content-center "
		style="width: 80%;">

		<form action="/login.member" method="post" class="Login_form needs-validation"
			align="center"  novalidate>
			<div class="header">
				<h3 class="card-title text-primary fw-bold">Login Box</h3>
			</div>
			<div class="card-body">
				<div class="mb-3 row">
					<label for="inputId" class="col-sm-4 col-form-label">아이디</label>
					<div class="col-sm-8">
						<input type="text" class="form-control" id="inputId" name="id"
							placeholder="ID" required title="이 필드는 필수입니다.">
							<div class="valid-feedback">
						      Looks good!
						    </div>
						    <div class="invalid-feedback">
					        Please choose a id.
					      </div>
					</div>
				</div>
				<div class="mb-3 row">
					<label for="inputPassword" class="col-sm-4 col-form-label">비밀번호</label>
					<div class="col-sm-8">
						<input type="password" class="form-control" id="inputPassword"
							name="pw" placeholder="PW" required title="이 필드는 필수입니다.">
							<div class="valid-feedback">
						      Looks good!
						    </div>
						    <div class="invalid-feedback">
					        Please choose a pw.
					      </div>
					</div>
				</div>

				<div>
					<button type="submit" class="btn btn-primary">로그인</button>
					<a href="/join.member"><button type="button"
							class="btn btn-outline-primary">회원가입</button></a>
				</div>

			</div>
		</form>
		<div class="form-check d-flex justify-content-center">
					<input class="form-check-input" type="checkbox" value=""
						id="rememberID"> <label class="form-check-label"
						for="rememberID"> ID 기억하기 </label>
				</div>
	</div>
	<script>
	
	(() => {
		  'use strict'

		  // Fetch all the forms we want to apply custom Bootstrap validation styles to
		  const forms = document.querySelectorAll('.needs-validation')

		  // Loop over them and prevent submission
		  Array.from(forms).forEach(form => {
		    form.addEventListener('submit', event => {
		      if (!form.checkValidity()) {
		        event.preventDefault()
		        event.stopPropagation()
		      }

		      form.classList.add('was-validated')
		    }, false)
		  })
		})()
	</script>
	
</body>
</html>