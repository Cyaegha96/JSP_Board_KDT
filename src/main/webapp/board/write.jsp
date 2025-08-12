<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!doctype html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"
	integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
	crossorigin="anonymous"></script>
<title>글 작성 페이지</title>
</head>
<body>
	<c:choose>
		<c:when test="${loginId==null}">
			<h2>로그인 하지 않은 사용자는 게시판을 이용할 수 없습니다.</h2>
			<a href="/">뒤로가기</a>
		</c:when>
		<c:otherwise>
		<form id="writeBoardFrm" action="/insert.board" method="post" >
			<table class="table table-bordered table-group-divider m-auto text-center">
				
			<thead>
			<tr>
					<th colspan="5" >자유게시판 글 작성하기</th>
				</tr>
			
				
				</thead>
				
				<tbody>
				
				<tr>
					<td class="text-start" width="80%">
					<input name="title" type="text" placeholder="글 제목을 입력하세요" class="w-100">
					</td>
				</tr>
					<tr > 
				
				<td colspan="5" height= "500px"> 
				
				
				<div id="editor"
		           class="h-100 w-100 border p-2 text-start"
		           contenteditable="true"
		           style="overflow-y: auto;">
		        글 내용을 입력하세요
						
				
				</div>
				    <input type="hidden" name="content" id="hiddenContent">
				
				</td></tr>
				
				<tr>
					<td colspan="5" class="text-end"> 
							<a href="/list.board?cpage=1"><button type="button">목록으로</button></a>
							<a ><button type="submit" id="submitbtn">작성완료</button></a>
					</td>
				</tr>
				
				
				</tbody>
				
			</table>
			</form>
		</c:otherwise>
	</c:choose>
	<script type="text/javascript">
	
	const editableDiv = document.querySelector('[contenteditable]');
	editableDiv.addEventListener('focus', function() {
	  if (this.innerText === '글 내용을 입력하세요') {
	    this.innerText = '';
	  }
	});
	editableDiv.addEventListener('blur', function() {
	  if (this.innerText.trim() === '') {
	    this.innerText = '글 내용을 입력하세요';
	  }
	});

	
	 $("#writeBoardFrm").on("submit", function() {
		    const editor = document.getElementById('editor');
		    const hiddenInput = document.getElementById('hiddenContent');
		    hiddenInput.value = editor.innerHTML; // 또는 innerText
		  })

	</script>
</body>
</html>