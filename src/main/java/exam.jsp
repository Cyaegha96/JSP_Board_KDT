<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 일단 호환은 되긴하는데 아래로 바꿔야함--%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

  
  JSP Standard Tag Library -> JSTL <br>
  <c:if test="${number !=null}">
  	number의 값은 ${number} 입니다.
  </c:if>
  <br>
  <c:choose>
  	<c:when test="${arr[0]  == 'Apple'}">
  	배열의 첫번째 요소는 사과입니다.
  	</c:when>
  	<c:when test="${arr[0]  == 'Orange'}">
  	배열의 첫번재 요소는 오렌지입니다.
  	</c:when>
  	<c:otherwise>
  	배열의 첫번째 요소는 과일이 아닙니다.
  	</c:otherwise>
  </c:choose>
 
  <c:forEach var="i" items="${list}"> 
${  i.setID } : ${i.writer} : ${i.messages} <br>
  </c:forEach>
  
  <c:forEach begin="5" end="10" step="1" varStatus="status" var ="i">
   ${status.count}번째 회차:  ${i} var값  : ${"Hello world"} <br>
  </c:forEach>
	
</body>
</html>