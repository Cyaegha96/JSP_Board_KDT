<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
	
<!doctype html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
  <script
      src="https://code.jquery.com/jquery-3.7.1.min.js"
      integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
      crossorigin="anonymous"
    ></script>
<title>로그인</title>


<style>
* {
	box-sizing: border-box;
	
}

.transparent-table{
	background-color: transparent !important;
    color: white !important;

}

.transparent-table th,
.transparent-table td {
  border-color: rgba(255, 255, 255, 0.3);
}


	spline-viewer {
      position: fixed;
      top: 0;
      left: 0;
      width: 100vw;
      height: 100vh;
      z-index: -1; /* 배경으로 보내기 */
    }

</style>
</head>
<body>
 <div>
 
 </div>
	<c:choose>
		<c:when test="${loginId==null}">
			<div
		class="Login_conatiner card m-auto p-3 rounded-2 border-primary d-flex justify-content-center align-items-center"
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
		
		</c:when>
		<c:otherwise>
		<div class="container d-flex justify-content-center align-items-center vh-100">
		<table border="1" class="table text-center p-5 bg-light border rounded transparent-table">
			<tr>
				<th colspan="4">${loginId} 님 안녕하세요.</th>
			</tr>
			<tr>
				
				<td><a href="/list.board?cpage=1" class="text-decoration-none text-black fw-bold">회원게시판</a></td>
				<td>
					<a href="/mypage.member" class="text-decoration-none text-black fw-bold">마이페이지</a>
				
				</td>
				
				<td>
					<a href="/logout.member" class="text-decoration-none text-black fw-bold">로그아웃</a>
				</td>
				<td><button type="button" id="deleteCheck" class="bg-transparent border-0 p-0 text-decoration-none text-black fw-bold" >회원 탈퇴</button></td>
			</tr>
		</table>	
		<form id="withdrawForm" action="/delete.member" method="post">
		  <input type="hidden" name="userId" value="${loginId}"> <!-- 필요 시 사용자 정보 -->
		</form>
		</div>
		
		</c:otherwise>	
	</c:choose>
<script type="module" src="https://unpkg.com/@splinetool/viewer@1.10.45/build/spline-viewer.js"></script>
<spline-viewer url="https://prod.spline.design/BURdK6cjbJicYHgy/scene.splinecode"></spline-viewer>
	
	<script>
	
	function sendDeleteOk(){
	
			$("#withdrawForm").submit();
		
	}
	
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
		
		$("#deleteCheck").click(function(){

			console.log("회원탈퇴 버튼 클릭");
			
		
		
    			window.open("/deleteCheck.member", "", "width=350, height=200");
   		 });
		
	</script>
	
</body>
</html>