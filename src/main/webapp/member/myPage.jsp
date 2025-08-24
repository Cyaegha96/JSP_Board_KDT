<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
  <script
      src="https://code.jquery.com/jquery-3.7.1.min.js"
      integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
      crossorigin="anonymous"
    ></script>
     <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
     <script src="/js/regex.js"></script>
</head>
<body>
	<div class="card border-primary m-auto" style="width: 80%;">
		<div class="header card-header bg-primary d-flex justify-content-center text-white">
		
			<h2>My Page</h2>
		</div> 
		<form id="form" action="/update.member" method="post" class="card-body">
		<div class="row g-3 m-2">
				<label for="inputId" class="col-sm-2 col-form-label text-start text-sm-end">ID</label>
				<div class="col-sm-4">
					<h2 id = "ajaxInputId">아이디</h2>
				</div>
				
		</div>	
		
		
		<div class="row g-3 m-2">
				<label for="inputName" class="col-sm-2 col-form-label text-start text-sm-end">이름</label>
				<div class="col-sm-6">
					<h2 id="ajaxInputName">이름</h2>

				</div>
				
		</div>	
		<div class="row g-3 m-2">
				<label for="inputPhone" class="col-sm-2 col-form-label text-start text-sm-end">전화번호</label>
				<div class="col-sm-6">
				<h2 class="viewMode" id="ajaxInputPhone" >폰번호</h2>
					<div class="editMode d-none">
					<input type="text" class="form-control" id="inputPhone" name="phone"
						placeholder="전화번호를 입력하세요 예 (010-1234-5678)" >
					
					</div>
				</div>
				
		</div>	
		<div class="row g-3 m-2">
				<label for="inputEmail" class="col-sm-2 col-form-label text-start text-sm-end">이메일</label>
				<div class="col-sm-6">
				<h2 class="viewMode" id="ajaxInputEmail" >이메일</h2>
					<div class="editMode d-none">
					<input type="text" class="form-control" id="inputEmail" name="email"
						placeholder="이메일을 입력하세요" >
					
					</div>

				</div>
				
		</div>	
		<div class="row g-3 m-2">
				<label for="inputZoneCode" class="col-sm-2 col-form-label text-start text-sm-end">우편번호</label>
				<div class="col-sm-6">
				<h2 class="viewMode" id="ajaxInputZonecode" >우편번호</h2>
				<div class="editMode d-none">
					<input type="text" class="form-control" id="inputZoneCode" name="zoneCode" readonly
						placeholder="우편번호" >
				</div>
				</div>
				<div class="editMode d-none col-sm-2">
					<button id="zoneCodeAPIBtn" type="button" class="btn btn-primary col-form-btn">
						찾기</button>
				</div>
		</div>	
		<div class="row g-3 m-2">
				<label for="inputAddress" class="col-sm-2 col-form-label text-start text-sm-end">주소</label>
				<div class="col-sm-8">
				<h2 class="viewMode" id="ajaxInputAddress" >주소</h2>
				<div class="editMode d-none">
					<input type="text" class="form-control" id="inputAddress" name="address" readonly
						placeholder="주소를 입력하세요"  >
				</div>
				</div>
				
		</div>
		<div class="row g-3 m-2">
				<label for="inputAddressDetail" class="col-sm-2 col-form-label text-start text-sm-end">상세주소</label>
				<div class="col-sm-8">
				<h2 class="viewMode" id="ajaxInputAddressDetail" >상세주소</h2>
				<div class="editMode d-none">
					<input type="text" class="form-control" id="inputAddressDetail" name="addressDetail"
						placeholder="상세주소를 입력하세요" >
					</div>
				</div>
				
		</div>
		<div class="row g-3 m-2">
				<label for="inputCreatedTime" class="col-sm-2 col-form-label text-start text-sm-end">가입 날짜</label>
				<div class="col-sm-8">
					<h2 id = "createdAt">생성일</h2>

				</div>
				
		</div>
		
		
		<div class="row g-3 m-2 d-flex justify-content-center">
			
			<div class="col-auto">
			<button type="button" id="updateBtn" class="btn btn-primary">수정하기</button>
			<a href="/"><button id="undo" type="button" class="btn btn-outline-primary">뒤로가기</button></a>
			<button id="cancleBtn" type="button" class="btn btn-outline-primary d-none">취소하기</button>
		</div>
		</div>
		</form>
		
		
	</div>
	
	<script>
	
	

	
		$("#updateBtn").on("click", function(){

			if($("#updateBtn").text() == "수정하기" ){
				$("#updateBtn").text("수정완료");
				$(".viewMode").each(function(){
					$(this).addClass("d-none")
				});
				
				$(".editMode").each(function(){
					$(this).removeClass("d-none");
				});
				$("#undo").addClass("d-none");
				$("#cancleBtn").removeClass("d-none");
				
				
				return false;
				
			}else if($("#updateBtn").text() =="수정완료"){
				
				$("#updateBtn").attr("type", "submit")
				
			}
				
		});
		//취소하기
		$("#cancleBtn").on("click", function(){
			$("#updateBtn").text("수정하기");
			$(".viewMode").each(function(){
				$(this).removeClass("d-none")
			});
			
			$(".editMode").each(function(){
				$(this).addClass("d-none");
			});
			$("#undo").removeClass("d-none");
			$("#cancleBtn").addClass("d-none");
			
		});
		
		$("#zoneCodeAPIBtn").on("click", function(){	

	    	new daum.Postcode({
	            oncomplete: function(data) {
	                
	                $("#inputZoneCode").val(data.zonecode);
	                $("#inputAddress").val(data.address);
	            }
	        }).open();
	    	
		});

		$("#form").on("submit",function(){
			let phoneInput = $("#inputPhone").val();
			//핸드폰 번호 형식은 010-????-????
			regex = /^01[0-9]-\d{3,4}-\d{4}$/;
			if(!regex.test(phoneInput)){
	            alert("적합하지 않은 핸드폰 번호입니다.");
	            return false;
	        }
			
			
			let emailInput = document.getElementById("inputEmail").value;
	        //이메일은 영문 대/소문자 및 숫자만 사용가능
	        //@기호가 하나는 포함되어야 하며    
	        //.com이나 .co.kr처럼 입력 가능해야 함.
	        //즉 이메일 형식에 맞게

	        
	        regex = /^[a-z0-9_]{4,12}@[a-zA-Z0-9]+(\.com|\.co\.kr)$/;
	        if(!regex.test(emailInput)){
	            alert("적합하지 않은 이메일입니다.");
	            return false;
	        }
		
		});
		
		$(function(){ //window.onload~ document.onload 랑 같은거. 즉 화면이 로드되는게 완료되면 바로 실행되는 함수.
				$.ajax({
					url:"/mypageIbuttlineonnfo.member",
					dataType:"json",
					method:"post"
				}).done(function(resq){
					console.log(resq);
					
					$("#ajaxInputId").text(resq.id);
					
					$("#ajaxInputName").text(resq.name);
					
					
					$("#ajaxInputPhone").text(resq.phoneNumber);
					$("#inputPhone").val(resq.phoneNumber);
					
					$("#ajaxInputEmail").text(resq.email);
					$("#inputEmail").val( resq.email);
					
					$("#ajaxInputZonecode").text(resq.zonecode);
					$("#inputZoneCode").val(resq.zonecode);
					
					
					$("#ajaxInputAddress").text(resq.address);
					$("#inputAddress").val(resq.address);
					
					$("#ajaxInputAddressDetail").text(resq.addressDetail);
					$("#inputAddressDetail").val(resq.addressDetail);
				
					$("#createdAt").text(resq.createdAt);
				
				
				})
		})
	
	</script>
	
	
</body>
</html>