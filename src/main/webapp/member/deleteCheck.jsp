<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 탈퇴 확인</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"
	integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
	crossorigin="anonymous"></script>
</head>
<body>
<div class="card border-primary mt-1  d-flex justify-content-center">
<div class="card-title">

	<h5>정말로 회원 탈퇴 하시겠습니까?</h5>
</div>
<div class="card-body">
<div>
<p>지금까지 열심히 만들었던 계정, 당신의 개인정보 전부다 저희가 홀랑먹고 당신의 접근권한만 사라질수도 있습니다. 그래도 괜찮겠습니까?</p></div>
<div class="m-auto d-flex justify-content-center mt-3">

						<button id="okBtn" type="button" class="btn btn-primary usableBtn">네</button>
						<button id="cancleBtn" type="button" class="btn btn-primary usableBtn">아니요</button>
					</div>
					<script >
					
						
						$('#okBtn').click(function(){
							//opener.setDuplicateCheckTrue();
							
							opener.sendDeleteOk();
							window.close();
						});	
						$('#cancleBtn').click(function(){
							
							window.close();
						});	
					
					</script>

</div>
</div>
</body>
</html>