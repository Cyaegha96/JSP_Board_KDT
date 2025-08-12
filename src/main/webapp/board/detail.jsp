<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
  <script type="text/javascript" src="//code.jquery.com/jquery-3.6.0.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js" integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q" crossorigin="anonymous"></script>

    <!-- include summernote css/js-->
    <link href="https://cdn.jsdelivr.net/npm/summernote@0.9.0/dist/summernote-bs5.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.9.0/dist/summernote-bs5.min.js"></script>
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
		<textarea name="content" id="hiddenContent" style="display:none;"></textarea>
			<input type="hidden"  name="seq" value="${board.seq}" />
			<input id="hiddenTitle" type="hidden" name="title" value="${board.title}">
			</form>
				<div class="card-header">
				<h4 id="boardTitle">
					${board.title}
					
				</h4>
				
				 <h6 class="card-subtitle mb-2 text-body-secondary">
				 아이디: ${board.writer} | 작성일: ${board.write_date } | 조회수: ${board.view_count }</h6>
				</div>
				<div class="card-body" id="boardContent">
					<c:out value="${board.contents}" escapeXml="false" />
				</div>
				
				<div class="d-flex justify-content-end p-4">
			
				<c:if test="${loginId == board.writer}">
					<button id="cancleBtn"  type="button" class="btn btn-outline-secondary d-none">취소</button>
					<button id="updateBtn" type="button" class="btn btn-outline-secondary">수정하기</button>

					<button id="deleteBtn"  type="button" class="btn btn-outline-danger">삭제하기</button>
					
				</c:if>
					<a href="/list.board?cpage=1" id ="toBoardBtn"><button type="button" class="btn btn-outline-primary">목록으로</button></a>
				</div>
				
			</div>
	
			<div class="container-fluid">
			<form action="/comment.board" method="post">
			    <div class="row g-2" style="height: 100px;">
			
			      <div class="col-10 d-grid">
			        <div class="form-control h-100 align-middle" contenteditable="true" 
			              
			             id="commentBox" data-placeholder="댓글을 입력하세요..."></div>
			      </div>
			
		
			      <div class="col-2 d-grid">
			        <input type="hidden" name="comment" id="hiddenComment">
			        <button type="submit" class="btn btn-primary h-100">등록</button>
			      </div>
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
			$("#boardContent").addClass("summernote")
			
			$('.summernote').summernote({
				  height: 300, // set editor height
				  minHeight: null, // set minimum height of editor
				  maxHeight: null, // set maximum height of editor
				  focus: true // set focus to editable area after initializing summernote
				});
		}else{
			//수정중일 경우
			updateBoard = false;
			
			$("#hiddenTitle").val($("#boardTitle").text())
			$('#hiddenContent').val($('.summernote').summernote('code'));
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