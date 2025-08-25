<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 중복 체크</title>
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
<style type="text/css">
.test {
	color: aqua;
}
</style>
</head>
<body>

	<div class="card border-primary mt-1  d-flex justify-content-center">
		<div class="card-title text-center bg-primary text-white">
			<h3>
				<c:choose>
					<c:when test="${isIdExist}">
					${id} 아이디가 중복입니다.
				</c:when>
					<c:when test="${!isIdExist}">
					${id} 아이디가 중복이 아닙니다.
				</c:when>
				</c:choose>
			</h3>
		</div>
		<div class="card-body text-center">
			<c:choose>
				<c:when test="${isIdExist}">
					<div>다른 아이디를 입력해주세요.</div>
					<button id="okBtn" type="button" class="btn btn-primary mt-3 ">닫기</button>
					<script>
					
						
						$('#okBtn').click(function(){
							opener.document.getElementById("inputId").value = "";
							window.close();
						});	
					
					</script>
				</c:when>
				<c:when test="${!isIdExist}">
					<div>[ ${id } ] 이 아이디를 사용하겠습니까?</div>
					<div class="m-auto d-flex justify-content-center mt-3">
						<button id="okBtn" type="button" class="btn btn-primary usableBtn">사용</button>
						<button id="cancleBtn" type="button"
							class="btn btn-primary usableBtn">취소</button>
					</div>
					<script>
					
						
						$('#okBtn').click(function(){
							opener.setDuplicateCheckTrue();
							window.close();
						});	
						$('#cancleBtn').click(function(){
							opener.document.getElementById("inputId").value = "";
							window.close();
						});	
					
					</script>
				</c:when>
			</c:choose>
		</div>
	</div>



</body>
</html>