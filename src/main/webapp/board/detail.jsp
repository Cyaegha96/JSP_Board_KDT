<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript"
	src="//code.jquery.com/jquery-3.6.0.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q"
	crossorigin="anonymous"></script>

<!-- include summernote css/js-->
<link
	href="https://cdn.jsdelivr.net/npm/summernote@0.9.0/dist/summernote-bs5.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/summernote@0.9.0/dist/summernote-bs5.min.js"></script>
<title>${board.title}</title>
<style type="text/css">
.reply {
	/* height: 300px; */ /* 이 줄은 삭제하거나 주석 처리 */
	min-height: 50px; /* 필요하다면 최소 높이만 설정 */
}

.boardContent {
	/* height: 300px; */ /* 이 줄은 삭제하거나 주석 처리 */
	min-height: 200px; /* 필요하다면 최소 높이만 설정 */
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
					<textarea name="content" id="hiddenContent" style="display: none;"></textarea>
					<input type="hidden" name="seq" value="${board.seq}" /> <input
						id="hiddenTitle" type="hidden" name="title" value="${board.title}">
				</form>
				<div class="card-header">
					<h4 id="boardTitle">${board.title}</h4>

					<h6 class="card-subtitle mb-2 text-body-secondary">아이디:
						${board.writer} | 작성일: ${board.write_date} | 조회수:
						${board.view_count }</h6>
				</div>
				<div class="card-body boardContent" id="boardContent">
					<c:out value="${board.contents}" escapeXml="false" />
				</div>

				<div class="d-flex justify-content-end p-4">

					<c:if test="${loginId == board.writer}">
						<button id="cancleBtn" type="button"
							class="btn btn-outline-secondary d-none">취소</button>
						<button id="updateBtn" type="button"
							class="btn btn-outline-secondary">수정하기</button>

						<button id="deleteBoardBtn" type="button"
							class="btn btn-outline-danger">삭제하기</button>

					</c:if>
					<a href="/list.board?cpage=1" id="toBoardBtn"><button
							type="button" class="btn btn-outline-primary">목록으로</button></a>
				</div>

			</div>

			<div class="container my-4">

				<!-- 댓글 입력 폼 -->
				<form id="replyForm" action="/insert.reply" method="post">
					<div class="row g-3 align-items-center " style="height: 100px;">

						<!-- 댓글 입력 영역 -->
						<div class="col-md-10">
							<div class="form-floating">
								<div class="form-control" contenteditable="true" id="commentBox"
									style="height: 100px; overflow-y: auto;"
									data-placeholder="댓글을 입력하세요..."></div>
								<label for="commentBox" class="text-muted">댓글을 입력하세요...</label>
							</div>
						</div>

						<!-- 등록 버튼 -->
						<div class="col-md-2 d-grid h-100">
							<input type="hidden" name="parent_seq" id="hiddentparent_seq"
								value="${param.seqnum}"> <input type="hidden"
								name="writer" id="hiddenWriter" value="${loginId}"> <input
								type="hidden" name="comment" id="hiddenComment">
							<button type="button" class="btn btn-outline-primary"
								id="insertReplyBtn">등록</button>
						</div>

					</div>
				</form>
			</div>
			<!-- 달린 댓글 확인 창-->
			<div class="container my-4">

				<c:forEach var="reply" items="${replyList}">
					<form data-seq="${reply.seq}" class="replyForm"
						action="/handleComment" method="post">
						<input type="hidden" name="seq" value="${reply.seq}"> <input
							type="hidden" name="parent_seq" value="${param.seqnum}">
						<div class="card">
							<div class="card-header">
								<h5 class="card-title">${reply.writer}</h5>
								${reply.write_date }
							</div>
							<div class="card-body reply">

								<div class="reply-contents">${reply.contents}</div>
								<div class="d-flex justify-content-end">
									<input type="hidden" name="comment"
										class="hiddenUpdatedComment">
									<c:if test="${loginId == reply.writer}">
										<button type="button"
											class="btn btn-outline-secondary d-none cancleReplyBtn">취소</button>
										<button type="button"
											class="btn btn-outline-secondary updateReplyBtn">수정하기</button>

										<button type="button"
											class="btn btn-outline-danger deleteReplyBtn">삭제하기</button>

									</c:if>
								</div>
							</div>
						</div>
					</form>
				</c:forEach>
			</div>

		</c:otherwise>
	</c:choose>
	<script>
	let updateBoard = false;
	

	//게시글 삭제 버튼
	$("#deleteBoardBtn").on("click", function(){
		if (confirm("정말 이 게시글을 삭제하시겠습니까?")) {
		$("#boardDetailForm").attr("action","/delete.board");
		 $("#boardDetailForm").submit();
		}
	}
	);
	
	//댓글 삭제 버튼
	$(".deleteReplyBtn").on("click", function(){
		if (confirm("정말 이 댓글을 삭제하시겠습니까?")) {
			
			 const form = $(this).closest("form");
			 let seq = form.attr("data-seq");
			 form.attr("action","/delete.reply");
			 form.submit();
		  }
	})
	
	//댓글 수정 버튼
	
	$(".updateReplyBtn").on("click", function () {
		  const $form = $(this).closest("form");
		  const $contents = $form.find(".reply-contents");
		
		  if (!$form.hasClass("editing")) {
		    // 수정 시작
		    $form.addClass("editing"); //폼에 editing 클래스 추가
		    $(this).text("수정 완료");
		    $form.find(".cancleReplyBtn").removeClass("d-none");
		    $form.find(".deleteReplyBtn").addClass("d-none");
		    $contents.attr("contenteditable", "true").css("overflow-y", "auto");
		    
		    // 다른 댓글의 수정 버튼 비활성화
		    $(".updateReplyBtn").not(this).prop("disabled", true);

		  } else {
		    // 수정 완료
		    $form.removeClass("editing");
		    const updated = $contents.html();
		    $form.find(".hiddenUpdatedComment").val(updated);
		    $form.attr("action", "/update.reply").submit();
		  }
});
	
	$("#updateBtn").on("click", function(){
		
		if(!updateBoard){
			//만약 수정중이 아닐경우
			
			updateBoard = true;
			$("#updateBtn").text("수정 완료");
			$("#boardTitle").addClass("border");

			$("#deleteBoardBtn").addClass("d-none");
			$("#deleteBoardBtn").addClass("d-none");
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
			
			if ($("#hiddenTitle").val() === "") {
			    alert("제목을 입력해주세요.");
			    return;
			  }
			if ($('#hiddenContent').val() === "") {
			    alert("글내용을 입력해주세요.");
			    return;
			  }
			
			$("#boardDetailForm").attr("action","/update.board");
			 $("#boardDetailForm").submit();
			 
		}

		
	 });
	$(".cancleReplyBtn").click(()=>{
		location.reload();
	})
	
	$("#cancleBtn").click(()=>{
		location.reload();
	})
	
	$("#insertReplyBtn").click(function() {
	  const comment = $("#commentBox").html();
	  if (comment === "") {
	    alert("댓글을 입력해주세요.");
	    return;
	  }
	  $("#hiddenComment").val(comment);
	  $("#replyForm").submit();
	});


</script>

</body>
</html>