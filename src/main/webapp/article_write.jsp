<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.Date , java.text.SimpleDateFormat" %>
<!-- db연동을 위한 import -->
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en" data-bs-theme="auto">
<head>

	<title>article_write</title>
<%
    String id = (String) session.getAttribute("userName");
    String level = (String) session.getAttribute("level");

    if (!("admin".equals(level) || "mid".equals(level))) {
%>
    <script type="text/javascript">
        alert("게시글 작성 권한이 없습니다.");
        location.href = "main.jsp";
    </script>
<%
        return; // 더 이상 페이지 처리하지 않도록 중단
    }
%>
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

	<jsp:include page="/layout/header2.jsp" />

	<div class="container">
		<main>			
			<div class="row g-5 py-5">			
				<div class="py-5">
				<!-- 게시글 작성 h -->
					<h4 class="mb-3"><fmt:message key="article_write"/></h4>
					<div class="text-end">
						<a href="?language=ko">Korean</a> | <a href="?language=en">English</a> 
					</div>

					<!-- 게시글 작성 form -->
					<form name="newArticle" action="./processAddArticle.jsp" method="post" enctype="multipart/form-data">
						<div class="row g-3">
							
							<!-- 제목 -->
							<div class="col-12">
								<label for="title" class="form-label"><fmt:message key="article_title"/></label> 
								<!-- 유효성 검사를 위한 id= -->
								<!-- 다국어 처리를 위한 value= -->
								<input
									type="text" id="title"  name="title" class="form-control">
							</div>
						</div>
						<hr class="my-4">
						
						
						<!-- 음식에 대한 한줄평 -->
						<div class="col-12">
								<label for="description" class="form-label"><fmt:message key="article_description"/></label> 
								<input
									type="text" id="description" name="description" class="form-control">
							</div>
						
						
						<!-- 이미지 -->
						<div class="col-12">
								<label for="description" class="form-label"><fmt:message key="article_image"/></label> 
								<input
									type="file" id="ArticleImage" value="<fmt:message key="article_image"/>" name="ArticleImage" class="form-control">
							</div>
						
						<!-- 본문 레시피 -->
						<div class="col-12">
								<label for="description" class="form-label"><fmt:message key="article_recipe"/></label> 
								
									<textarea  id="recipe" name="recipe" class="form-control" rows="6" style="resize: vertical;" placeholder="레시피 내용을 입력하세요..."></textarea>
							</div>
							
							<hr>
							
							<!-- 맛분류 -->
							<h5><fmt:message key="article_classification"/></h5>
							<!-- 매운맛 -->
							<label for="spicy" class="form-label"><fmt:message key="article_spicy"/></label>
							<input type="range" name="spicy" class="form-range" min="0" max="5" id="spicy">
							<!-- 단맛 -->
							<label for="sweet" class="form-label"><fmt:message key="article_sweet"/></label>
							<input type="range" name="sweet" class="form-range" min="0" max="5" id="sweet">
							<!-- 짠맛 -->
							<label for="salty" class="form-label"><fmt:message key="article_salty"/></label>
							<input type="range" name="salty" class="form-range" min="0" max="5" id="salty">
							<!-- 고소한맛 -->
							<label for="savory" class="form-label"><fmt:message key="article_savory"/></label>
							<input type="range" name="savory" class="form-range" min="0" max="5" id="savory">
							<!-- 감칠맛 -->
							<label for="umami" class="form-label"><fmt:message key="article_umami"/></label>
							<input type="range" name="umami" class="form-range" min="0" max="5" id="umami">
							
						<hr class="my-4">
						<!-- 업로드 버튼 -->
						<!-- 유효성검사 onclick -->
						<input class="w-100 btn btn-primary btn-lg" type="button" value="<fmt:message key="article_upload"/>" onclick="CheckAddArticle()">
						
					</form>
				</div>
			</div>
		</main>
		
	</div>
	</fmt:bundle>
	
	
	<jsp:include page="/layout/footer.jsp" />
</body>
</html>