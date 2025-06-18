<!-- https://getbootstrap.kr/docs/5.3/examples/blog/# -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
    String userCode_check = (String) session.getAttribute("userCode");
    String userName_check = (String) session.getAttribute("userName");
    String level_check = (String) session.getAttribute("level");
    boolean isLogIn = userCode_check != null && userName_check != null && level_check != null;
%>
<!DOCTYPE html>
<html lang="en" data-bs-theme="auto">
<head>
<title>main</title>
<!-- css파일 -->
<link rel="stylesheet" type="text/css" href="./resources/css/article.css">

</head>

<body>
	<jsp:include page="/layout/header2.jsp" />
	
	<main class="container">
		<div
			class="p-4 p-md-5 mb-4 rounded text-body-emphasis bg-body-secondary">
			<div class="col-lg-6 px-0">
				<h4 class="display-11 fst-italic">오늘 뭐 먹을지 고민된다면?
				</h4>
				<h1 class="display-4 fst-italic"><b>
				"오늘의 레시피"</b></h1>
				<p class="lead my-3">오늘의 레시피는 사용자 맞춤 추천 레시피 웹사이트입니다. 
				당신에게 딱 맞춘 나만의 레시피를 지금 찾아보세요!</p>
				<p class="">
				
									<% if (!isLogIn) { %>
    <a href="Login/register.jsp" class="text-body-emphasis fw-bold">회원가입 >></a>
<% } else { %>
    <a href="recommend/recommend.jsp" class="btn btn-outline-primary fw-bold">음식 추천 받으러 가기</a>
<% } %>

				</p>
			</div>
		</div>
		<div class="row mb-2">
		<div class="col-md-6">
				
				<!-- 여기에 본문 영역 -->
				<%
    String id = (String) session.getAttribute("userName");
    String level = (String) session.getAttribute("level");
%>
<%
	String Level = null;
switch(level){
case "nomal":
	Level = "일반 회원";
	break;
case "admin":
	Level = "관리자";
	break;
case "mid":
	Level = "중간 관리자";
	break;
default:
	break;
}  
%>
<% if (isLogIn) { %>
	<h2>환영합니다 <%= userName_check %>님</h2>
	<p>등급: <%= Level %></p>
<% }else { %>
    continue;
<% } %>
					<% if (isLogIn) { %>
    <a class="btn btn-sm btn-outline-danger" href="Login/logout.jsp">Sign out</a>
<% } else { %>
    <a class="btn btn-sm btn-outline-secondary" href="Login/login.jsp">Sign up</a>
<% } %>
				
			</div>
		</div>
		
	</main>
	<% if (isLogIn) { %>
    <jsp:include page="/layout/footer.jsp" />
<% } else { %>
    <jsp:include page="/layout/footer.jsp" />
<% } %>
	

</body>
</html>