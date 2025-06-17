<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.Date , java.text.SimpleDateFormat" %>
<!-- db연동을 위한 import -->
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en" data-bs-theme="auto">
<head>

	<title>point_write</title>

	<!-- CSs파일 -->
	<link rel="stylesheet" type="text/css" href="./resources/css/article.css">
	<!-- 유효성 검사를 위한 script -->
	<script type="text/javascript" src="./resources/script/validation.js"></script>
	<!-- 다국어 처리를 위한 import -->
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

</head>

<fmt:setLocale value='<%=request.getParameter("language") %>' />
<fmt:bundle basename="bundle.message">


<body class="bg-body-tertiary">

	<jsp:include page="/layout/header.jsp" />

	<div class="container">
		<main>			
			<div class="row g-5 py-5">			
				<div class="py-5">
				<!-- 게시글 작성 h -->
					<h4 class="mb-3"><fmt:message key="point_write"/></h4>
					<div class="text-end">
						<a href="?language=ko">Korean</a> | <a href="?language=en">English</a> 
					</div>

					<!-- 게시글 작성 form -->
					<form name="newPoint" action="./processAddPoint.jsp" method="post" enctype="multipart/form-data">
						<div class="row g-3">
							
							<!-- 제목 -->
							<div class="col-12">
								<label for="title" class="form-label"><fmt:message key="point_title"/></label> 
								<!-- 유효성 검사를 위한 id= -->
								<!-- 다국어 처리를 위한 value= -->
								<input
									type="text" id="title"  name="title" class="form-control">
							</div>
						</div>
						<hr class="my-4">
						
						<!-- product code -->
							<div class="col-12">
								<label for="code" class="form-label"><fmt:message key="point_code"/></label> 
								<!-- 유효성 검사를 위한 id= -->
								<!-- 다국어 처리를 위한 value= -->
								<input
									type="text" id="code"  name="code" class="form-control">
							</div>
						
						<!-- 가격 -->
						<div class="col-12">
								<label for="price" class="form-label"><fmt:message key="point_price"/></label> 
								<input
									type="number" id="price" name="price" class="form-control">
							</div>
							
						<!-- 수량 -->
						<div class="col-12">
								<label for="quantity" class="form-label"><fmt:message key="point_count"/></label> 
								<input
									type="number" id="quantity" name="quantity" class="form-control">
							</div>							
					
						<hr>
						
						<!-- 이미지 -->
						<div class="col-12">
								<label for="PointImage" class="form-label"><fmt:message key="article_image"/></label> 
								<input
									type="file" id="PointImage" value="<fmt:message key="article_image"/>" name="ArticleImage" class="form-control">
							</div>
						
						<!-- 본문 레시피 -->
						<div class="col-12">
								<label for="description" class="form-label"><fmt:message key="point_description"/></label> 
								
									<textarea  id="description" name="description" class="form-control" rows="6" style="resize: vertical;" placeholder="내용을 입력하세요..."></textarea>
							</div>
							

						<hr class="my-4">
						<!-- 업로드 버튼 -->
						<!-- 유효성검사 onclick -->
						<input class="w-100 btn btn-primary btn-lg" type="button" value="<fmt:message key="article_upload"/>" onclick="CheckAddPoint()">
						
					</form>
				</div>
			</div>
		</main>
		
	</div>
	</fmt:bundle>
	
	
	<jsp:include page="/layout/footer.jsp" />
</body>
</html>

<script type="text/javascript">
function CheckAddPoint() {
    var title = document.getElementById("title");
    var description = document.getElementById("description");
    var price = document.getElementById("price");
    var quantity = document.getElementById("quantity");

    if (title.value.length < 1 || title.value.length > 20) {
        alert("[제목]\n최소 1자에서 20자까지 입력하세요");
        title.focus();
        return false;
    }

    if (description.value.length < 1) {
        alert("[본문]\n본문 내용을 입력해주세요");
        description.focus();
        return false;
    }

    if (price.value === "" || parseInt(price.value) < 1) {
        alert("[가격]\n가격을 지정해주세요");
        price.focus();
        return false;
    }

    if (quantity.value === "" || parseInt(quantity.value) < 1) {
        alert("[수량]\n수량을 지정해주세요");
        quantity.focus();
        return false;
    }

    document.newPoint.submit();
}
</script>