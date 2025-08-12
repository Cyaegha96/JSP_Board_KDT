<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!doctype html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
     <script type="text/javascript" src="//code.jquery.com/jquery-3.6.0.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js" integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q" crossorigin="anonymous"></script>

    <!-- include summernote css/js-->
    <link href="https://cdn.jsdelivr.net/npm/summernote@0.9.0/dist/summernote-bs5.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.9.0/dist/summernote-bs5.min.js"></script>
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
				
				<td colspan="5"> 
				
				
				<div id="summernote" ></div>
				
				
				</td></tr>
				
				<tr>
					<td colspan="5" class="text-end"> 
					
						 <input type="hidden" name="content" id="hiddenContent">
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
	

	 $("#writeBoardFrm").on("submit", function() {
		  
		    const hiddenInput = document.getElementById('hiddenContent');
		    hiddenInput.value =  $('#summernote').summernote('code');
		  })
		  
	$(document).ready(function() {
	 $('#summernote').summernote({
		 fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New','맑은 고딕','궁서','굴림체','굴림','돋움체','바탕체'],
			fontSizes: ['8','9','10','11','12','14','16','18','20','22','24','28','30','36','50','72'],
			height: 450,
			lang: "ko-KR",
			placeholder : "내용을 작성하세요.",
	        callbacks: {
	            onInit: function() {
	              // 에디터 내부 editable 영역에 스타일 직접 지정
	              $('.note-editable').css('text-align', 'left');
	            }
	        }
	      });
		
});
	 </script>
</body>
</html>