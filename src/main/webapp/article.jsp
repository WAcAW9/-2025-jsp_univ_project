<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 도서 상세 정보 데이터를 불러오기 위한 -->
<%@ page import="dto.Article" %>
<%@ page import="dao.ArticleRepository" %>
<jsp:useBean id="articleDAO" class="dao.ArticleRepository" scope="session"/>

<!-- 예외처리 -->
<%@ page errorPage="exceptionNoArticleId.jsp" %>
<!-- db연동을 위한 import -->
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="en" data-bs-theme="auto">
<head>
<!-- css파일 -->
<link rel="stylesheet" type="text/css" href="./resources/css/article.css">

</head>
<body>
	
	<jsp:include page="/layout/header.jsp" />
	<%@ include file="connection.jsp" %>
			
	<main class="container">
		<!-- 게시글 상세 보기 데이터 -->
		<% 
			String id = request.getParameter("id");
			//ArticleRepository dao= ArticleRepository.getInstance();//새로 쓴 게시글 가져오기
			//Article article=dao.getArticleById(id); //여기 임시 아이디 고정
			
		%>
		
		<!-- db로 보기 -->
		<%
					PreparedStatement pstmt=null;
					ResultSet rs=null;
					String sql="SELECT * FROM FoodList WHERE FoodCode=?";
					pstmt=conn.prepareStatement(sql);
					pstmt.setString(1,id);
					rs=pstmt.executeQuery();
					
					if(rs.next()){
					
		%>
		<div class="row g-5">
			<div class="col-md-8">
				<!-- 게시글 본문 -->
				<article class="blog-post">
					<img src="./resources/images/<%=rs.getString("FoodImg") %>" style="width:100%; height:100%"/>
					<hr>
					<p><%=rs.getString("FoodInfo") %></p>
					<h2 class="display-5 link-body-emphasis mb-1"><%=rs.getString("FoodName") %></h2>
					<p class="blog-post-meta">
						<%=rs.getDate("UploadDate")  %> | <a href="#"><%=rs.getString("Author")%></a>  <!-- 사용자 링크 -->
					</p>
					<hr>
				
					<table class="table">
						<thead>
						
							<tr>
								<th>분류</th>
								<th>정도</th>
							</tr>
						</thead>
						<tbody>
						<% if(rs.getInt("Spicy")!=0){ %>
							<tr>
								<td>매운맛</td>
								<td><% for(int i=0;i<rs.getInt("Spicy");i++){%>
								🟨
								<%} 
								for(int j=5-rs.getInt("Spicy");j>0;j--){
								%>▫️
								<%} %>	
								</td>
						<%} %>
							</tr>
							
							
							<% if(rs.getInt("Sweet")!=0){ %>
							<tr>
								<td>달콤한맛</td>
								<td><% for(int i=0;i<rs.getInt("Sweet");i++){%>
								🟨
								<%} 
								for(int j=5-rs.getInt("Sweet");j>0;j--){
								%>▫️
								<%} %>	
								</td>
						<%} %>
							</tr>
							
							<% if(rs.getInt("Salty")!=0){ %>
							<tr>
								<td>짠맛</td>
								<td><% for(int i=0;i<rs.getInt("Salty");i++){%>
								🟨
								<%} 
								for(int j=5-rs.getInt("Salty");j>0;j--){
								%>▫️
								<%} %>	
								</td>
						<%} %>
							</tr>
							
							<% if(rs.getInt("Savory")!=0){ %>
							<tr>
								<td>고소한맛</td>
								<td><% for(int i=0;i<rs.getInt("Savory");i++){%>
								🟨
								<%} 
								for(int j=5-rs.getInt("Savory");j>0;j--){
								%>▫️
								<%} %>	
								</td>
						<%} %>
							</tr>
							
							<% if(rs.getInt("Umami")!=0){ %>
							<tr>
								<td>감칠맛</td>
								<td><% for(int i=0;i<rs.getInt("Umami");i++){%>
								🟨
								<%} 
								for(int j=5-rs.getInt("Umami");j>0;j--){
								%>▫️
								<%} %>	
								</td>
						<%} %>
							</tr>
						</tbody>
						
					</table>
					
					<hr>
					
					<p><%=rs.getString("FoodDescription") %></p>
					
					
				</article>
				
				
				<hr>
				<a href="addLike.jsp?id=<%=rs.getString("FoodCode") %>" class="btn btn-sm btn-outline-secondary" onclick="return confirm('게시글을 좋아요 목록에 추가하시겠습니까?');">LIKE</a>
				<hr>
			
			</div>
			
			
			<!-- 옆에 서브 테이블 -->
			<div class="col-md-4">
				<div class="position-sticky" style="top: 2rem;">
				
				<!-- 작성자에 대한 정보 -->
					<div class="p-4 mb-3 bg-body-tertiary rounded">
						<h4 class="fst-italic"><a href="#"><%=rs.getString("Author") %></a></h4>
						<p class="mb-0">Customize this section to tell your visitors a
							little bit about your publication, writers, content, or something
							else entirely. Totally up to you.</p>
					</div>
					<!-- 다른 게시글 -->
					<div>					
					
						<h4 class="fst-italic">다른 게시글</h4>
						<ul class="list-unstyled">
						<%
							PreparedStatement pstmt2=null;
							ResultSet rs2=null;
							String sql2="SELECT * FROM FoodList";
							pstmt2=conn.prepareStatement(sql2);
							rs2=pstmt2.executeQuery();
							int count=0;
							while (rs2.next() && count < 3) {
						%>
							<li><a
								class="d-flex flex-column flex-lg-row gap-3 align-items-start align-items-lg-center py-3 link-body-emphasis text-decoration-none border-top"
								href="#"> <svg aria-hidden="true"
										class="bd-placeholder-img " height="96"
										preserveAspectRatio="xMidYMid slice" width="100%"
										xmlns="http://www.w3.org/2000/svg">
										<rect width="100%" height="100%" fill="#777"></rect></svg>
									<div class="col-lg-8">
										<h6 class="mb-0"><%=rs2.getString("FoodName") %></h6>
										<small class="text-body-secondary"><%=rs2.getString("UploadDate") %></small>
									</div>
							</a></li>
							<%count++;} %>
						</ul>
					</div>

				</div>
			</div>
		</div>
		<% } %>
	</main>
	 
	<jsp:include page="/layout/footer.jsp" />
	
</body>
</html>
</html>