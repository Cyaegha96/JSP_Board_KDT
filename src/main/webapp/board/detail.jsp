<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"
	integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
	crossorigin="anonymous"></script>
<title>Insert title here</title>
<style type="text/css">
	.card-body{
		height:300px;
	}
</style>
</head>
<body>
	<c:choose>
		<c:when test="${loginId==null}">
			<h2>로그인 하지 않은 사용자는 게시판을 이용할 수 없습니다.</h2>
			<a href="/">뒤로가기</a>
		</c:when>
		
		<c:when test="${board==null}">
			<h2>요청하신 게시글이 존재하지 않습니다.</h2>
			<a href="/">뒤로가기</a>
		</c:when>
		<c:otherwise>
			
			<div class="card m-auto">
			<form id="boardDetailForm" action="/handle" method="post">
				<div class="card-header">
				<h4>
					<div id="boardTitle">
					${board.title}
					</div>
				</h4>
				<input id="hiddenTitle" type="hidden" name="title" value="${board.title}">
				 <h6 class="card-subtitle mb-2 text-body-secondary">
				 아이디: ${board.writer} | 작성일: ${board.write_date } | 조회수: ${board.view_count }</h6>
				</div>
				<div class="card-body" id="boardContent">
					${board.contents}
				</div>
				<input id="hiddenContents" type="hidden" name="content" value="${board.contents}">
				<div class="d-flex justify-content-end p-4">
			
				<c:if test="${loginId == board.writer}">
					<button id="cancleBtn"  type="button" class="btn btn-outline-secondary d-none">취소</button>
					<button id="updateBtn" type="button" class="btn btn-outline-secondary">수정하기</button>
					
					
					<input type="hidden"  name="seq" value="${board.seq}" />
					
					<button id="deleteBtn"  type="button" class="btn btn-outline-danger">삭제하기</button>
					
				</c:if>
					<a href="/list.board" id ="toBoardBtn"><button type="button" class="btn btn-outline-primary">목록으로</button></a>
				</div>
				</form>
			</div>
			
		</c:otherwise>
</c:choose>
<script>
	let updateBoard = false;

	$("#deleteBtn").on("click", function(){
		$("#boardDetailForm").attr("action","/delete.board");
		 $("#boardDetailForm").submit();
	
	}
	);
$("#updateBtn").on("click", function(){
	
		if(!updateBoard){
			//만약 수정중이 아닐경우
			
			updateBoard = true;
			$("#updateBtn").text("수정 완료");
			$("#boardTitle").addClass("border");

			$("#deleteBtn").addClass("d-none");
			$("#deleteBtn").addClass("d-none");
			$("#cancleBtn").removeClass("d-none");
			$("#toBoardBtn").addClass("d-none");
			$("#boardTitle").attr("contenteditable","true");
			$("#boardContent").attr("contenteditable","true");
			$("#boardContent").addClass("border")
		}else{
			//수정중일 경우
			updateBoard = false;
			
			$("#hiddenTitle").val($("#boardTitle").text())
			$("#hiddenContents").val($("#boardContent").text())
			$("#boardDetailForm").attr("action","/update.board");
			 $("#boardDetailForm").submit();
			 
		}

		
	 });
$("#cancleBtn").click(()=>{
	location.reload();
})
	
</script>

</body>
</html>