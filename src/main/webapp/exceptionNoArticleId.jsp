<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 아이디 오류</title>
</head>
<body>
	<jsp:include page="/layout/header.jsp" />
	
	<div class="container py-4">
		<div class="p-5 mb-4 bg-body-tertiary">
			<h1>해당 게시글이 존재하지 않습니다.</h1>
		</div>
		<p> <%=request.getRequestURL()%>?<%=request.getQueryString() %>
		<p> <a href="articles.jsp">게시글 목록으로 돌아가기 &raquo;</a>
	</div>
	
	<jsp:include page="/layout/footer.jsp" />
</body>
</html>