<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dto.Article" %>
<%@ page import="dao.ArticleRepository" %>
<!-- db연동을 위한 import -->
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en" data-bs-theme="auto">
<head>

<title>userPage</title>
<%@ include file="connection.jsp" %>
<%
    String id = (String) session.getAttribute("userName");
	//String userName = (String) session.getAttribute("userName");
    String level = (String) session.getAttribute("level");

    if (id == null) {
%>
    <script type="text/javascript">
        alert("로그인 후 이용 가능한 페이지입니다.");
        location.href = "Login/login.jsp";
    </script>
<%
        return; // 더 이상 페이지 처리하지 않도록 중단
    }
%>
<%
	String LikeCartId=session.getId();
%>
<!-- css파일 -->
<link rel="stylesheet" type="text/css" href="./resources/css/article.css">

</head>
<body>
	<jsp:include page="/layout/header2.jsp" />
	
	<%
		int sum=0;
		ArrayList<Article> likelist=(ArrayList<Article>)session.getAttribute("likelist");
		if (likelist == null) {
		    likelist = new ArrayList<Article>();
		}


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
			Level = "확인되지 않은 level";
			break;
		}  
	%>
	
	<main>
		<section class="py-5 text-center container">
		
				<div class="col-lg-6 col-md-8 mx-auto">
					
					<svg aria-label="Placeholder"
						class="bd-placeholder-img rounded-circle" height="140"
						preserveAspectRatio="xMidYMid slice" role="img" width="140"
						xmlns="http://www.w3.org/2000/svg">
						<title>Placeholder</title><rect width="100%" height="100%"
							fill="var(--bs-secondary-color)"></rect></svg>
							<h2 class="fw-normal"><%=id %></h2>
							<p> 회원 등급 : <%=Level %></p>
<!-- 
						<a class="btn btn-secondary" href="#">좋아요 누른 레시피</a> -->
						<a href="recommend/UpdateUserTaste.jsp" class="btn btn-secondary my-2">내 맛 선호도 수정</a>
						<% if(Level=="일반 회원"){ %>
						<a href="Login/RequestLevelChange.jsp" class="btn btn-primary my-2">회원 등급 업그레이드 신청</a> 
						<%} %>
						<% if(Level == "관리자"){ %>
						<a href="Login/UpdateUserLevel.jsp" class="btn btn-secondary my-2">관리자 페이지</a>
						<%} %>
				</div>
		</section>
		
		<% if(Level=="중간 관리자"||Level == "관리자"){ %>
		<!-- 내가 쓴 게시글 -->
		<div class="album py-5 bg-body-tertiary">

			<div class="container">
			<p class="lead text-center "> 내가 쓴 게시글 :
			<p>
				<div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
					<%
						//for(int i=0;i<likelist.size();i++){
						//	Article article = likelist.get(i);
					%>
					<!-- db로 보기 -->
					<%
								PreparedStatement pstmt=null;
								ResultSet rs=null;
								String sql="SELECT * FROM FoodList WHERE Author=?";
								pstmt=conn.prepareStatement(sql);
								pstmt.setString(1,id);
								rs=pstmt.executeQuery();
								
								while(rs.next()){
								
					%>
					<!-- 게시글 하나씩 출력 -->
					<div class="col">
						<div class="card shadow-sm">
								<img src="./resources/images/<%=rs.getString("FoodImg") %>" style="width:100%; height:100%"/>
							<div class="card-body">
								<p class="card-text"><h5><b><%=rs.getString("FoodName") %></b></h5>
								<p class="card-text"><%=rs.getString("FoodDescription")%></p>
								<div class="d-flex justify-content-between align-items-center">
									<div class="btn-group">
									<!-- button에서 a로 바꿈 -->
										<a href= "./article.jsp?id=<%=rs.getString("FoodCode")%>" type="button" class="btn btn-sm btn-outline-secondary">View</a>
										
									</div>
									<small class="text-body-secondary">
									<!-- 게시글 리스트에서 삭제하기-->
										<a href="./remove_article.jsp?id=<%=rs.getString("FoodCode")%>"class="btn btn-sm btn-outline-secondary">Delete</a>
									</small>
								</div>
							</div>
						</div>
					</div>
				
					<% } %>
					
				</div>
			</div>
		</div>
	<%} %>
	<!-- 좋아요한 게시글 -->
		<div class="album py-5 bg-body-tertiary">

			<div class="container">
			<p class="lead text-center "> 좋아요 한 게시글 :
			<p>
				<div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
					<!-- db로 보기 -->
					<%
				    PreparedStatement pstmt2 = null;
				    ResultSet rs2 = null;
				    String sql2 = "SELECT * FROM FoodList WHERE FoodCode IN (SELECT foodCode FROM LikeArticle WHERE UserName = ?)";
				    pstmt2 = conn.prepareStatement(sql2);
				    pstmt2.setString(1, id); // userName 전달
				    rs2 = pstmt2.executeQuery();
				    while (rs2.next()) {
					%>
					<!-- 게시글 하나씩 출력 -->
					<div class="col">
						<div class="card shadow-sm">
								<img src="./resources/images/<%=rs2.getString("FoodImg") %>" style="width:100%; height:100%"/>
							<div class="card-body">
								<p class="card-text"><h5><b><%=rs2.getString("FoodName") %></b></h5>
								<p class="card-text"><%=rs2.getString("FoodDescription")%></p>
								<div class="d-flex justify-content-between align-items-center">
									<div class="btn-group">
									<!-- button에서 a로 바꿈 -->
										<a href= "./article.jsp?id=<%=rs2.getString("FoodCode")%>" type="button" class="btn btn-sm btn-outline-secondary">View</a>
										
									</div>
									<small class="text-body-secondary">
									<!-- 게시글 리스트에서 삭제하기-->
										<a href="./remove_like.jsp?foodCode=<%=rs2.getString("FoodCode")%>&userName=<%=session.getAttribute("userName")%>" class="btn btn-sm btn-outline-secondary">Delete</a>
									</small>
								</div>
							</div>
						</div>
					</div>
				
					<% } %>
					
				</div>
			</div>
		</div>
	
	
	</main>
	
	
	<jsp:include page="/layout/footer.jsp" />
	
	</body>
</html>