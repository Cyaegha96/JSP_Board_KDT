<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


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
<style>
.table-body {
	min-height: 500px;
}

.table_header {
	background: #020024;
	background: linear-gradient(164deg, rgba(2, 0, 36, 1) 0%,
		rgba(9, 9, 121, 1) 30%, rgba(0, 212, 255, 1) 100%);
}
</style>

<title>자유게시판</title>
</head>
<body>
	<c:choose>
		<c:when test="${loginId==null}">
			<h2>로그인 하지 않은 사용자는 게시판을 이용할 수 없습니다.</h2>
			<a href="/">뒤로가기</a>
		</c:when>
		<c:otherwise>
			<table
				class="table table-bordered table-group-divider m-auto text-center">

				<thead>
					<tr>
						<th class="table_header text-white" colspan="5"
							style="text-align: center">자유게시판</th>
					</tr>

					<tr>
						<td width="5%"></td>
						<td width="45%" style="text-align: center">제목</td>
						<td width="15%">작성자</td>
						<td width="15%">날짜</td>
						<td width="10%">조회</td>
					</tr>
				</thead>
				<tbody class="table-body">

					<c:choose>
						<c:when test="${empty list}">
							<tr>
								<td class="align-middle" colspan="5">표시할 내용이 없습니다.</td>
							</tr>
						</c:when>
						<c:otherwise>

							<c:forEach var="item" items="${list}">
								<tr>
									<td width="5%">${item.seq }</td>
									<td width="45%" style="text-align: center"><a
										href="/detail.board?seqnum=${item.seq}"
										class="text-decoration-none"> ${item.title }</a></td>
									<td width="15%">${item.writer }</td>
									<td width="15%">${item.write_date }</td>
									<td width="10%">${item.view_count }</td>
								</tr>
							</c:forEach>
							<c:if test="${ emptySize != null}">
								<td class="align-middle" colspan="5"
									style="height: ${50*emptySize}px;">빈 행입니다.</td>

							</c:if>

						</c:otherwise>
					</c:choose>

				</tbody>
				<tr>
					<td colspan="5">
						<nav aria-label='Page navigation'>
							<ul class="pagination justify-content-center">
							</ul>
						</nav>
					</td>
				</tr>
				<tr>
					<td colspan="5" class="text-end"><a href="/"><button
								type="button" class="btn btn-outline-primary">뒤로가기</button></a> <a
						href="/write.board"><button type="button"
								class="btn btn-outline-primary">글 작성하기</button></a></td>
				</tr>
			</table>
		</c:otherwise>
	</c:choose>

	<script type="text/javascript">
		let recordTotalCount = ${recordTotalCount};
		let recordCountPerPage = ${recordCountPerPage};
		let naviCountPerPage = ${naviCountPerPage};
		let currentPage = ${currentPage};
		
		$(window).on("load", function(){
			
			if(recordTotalCount%recordCountPerPage > 0) {
				pageTotalCount  = recordTotalCount/recordCountPerPage + 1;
			}else {
				pageTotalCount  = recordTotalCount/recordCountPerPage;
			}
			
			if(currentPage <1){
				currentPage = 1;
			}else if(currentPage > pageTotalCount){
				currentPage = pageTotalCount;
			}
			
			let startNavi =  Math.floor((currentPage-1) / naviCountPerPage) * naviCountPerPage +1;
			let endNavi = startNavi + naviCountPerPage -1;
			console.log("startNavi: "+startNavi);
			console.log("endNavi: "+endNavi);
			
			if(endNavi > pageTotalCount ){
				endNavi = pageTotalCount;
			}
			
			let needPrev = true;
			let needNext = true;
			
			if(startNavi ==1){
				 needPrev = false;
			}
			
			if(endNavi == pageTotalCount){
				needNext=false;
			}

			if(needPrev){
				
				$(".pagination")
				.append($("<li>")
						.addClass("page-item")
						.append($("<a>")
								.addClass("page-link")
								.text("previous")
								.attr("href","/list.board?cpage="+(startNavi - 1))));
			}
			
			for(let i = startNavi; i<=endNavi; i++){
				
				if(i == currentPage){
					$(".pagination")
					.append($("<li>")
							.addClass("page-item")
							.append($("<a>")
									.addClass("page-link active")
									.text(i)
									.attr("href","/list.board?cpage="+i)));
				}else{
					$(".pagination")
					.append($("<li>")
							.addClass("page-item")
							.append($("<a>")
									.addClass("page-link")
									.text(i)
									.attr("href","/list.board?cpage="+i)));
				}
				
			
			}
			
			if(needNext){
	
				$(".pagination")
				.append($("<li>")
						.addClass("page-item")
						.append($("<a>")
								.addClass("page-link")
								.text("Next")
								.attr("href","/list.board?cpage="+(endNavi + 1))));
			}
			
			
		});
		
		
	</script>
</body>
</html>