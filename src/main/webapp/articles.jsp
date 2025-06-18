<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- ch4 게시글 목록 출력을 위한 -->
<%@ page import="java.util.ArrayList"%>
<%@ page import="dto.Article" %>
<%@ page import="dao.ArticleRepository" %>
<jsp:useBean id="articleDAO" class="dao.ArticleRepository" scope="session"/>
<!-- db연동을 위한 import -->
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="en" data-bs-theme="auto">
<head>

<title>articles</title>
<!-- css파일 -->
<link rel="stylesheet" type="text/css" href="./resources/css/article.css">
<!-- Like 버틍 누를 시 -->
<script type="text/javascript">
	function addToLike(){
		if(confirm("게시글을 좋아요 목록에 추가하시겠습니까?")){
			document.addForm.submit();
		}else{
			document.addForm.reset();
		}
	}
</script>

</head>
<body>
	
	<jsp:include page="/layout/header2.jsp" />
	
	<main>
		<%@ include file="connection.jsp" %>
		
		<!-- 게시글 모음집 -->
		<%
			// 새로쓴 게시글도 가져오기
			//ArticleRepository dao=ArticleRepository.getInstance();
			//ArrayList<Article> listOfArticles=dao.getAllArticles();
		%>
		
		
		<div class="album py-5 bg-body-tertiary">
			<div class="container">
				<div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
					<%
						PreparedStatement pstmt=null;
						ResultSet rs=null;
						String sql="SELECT * FROM FoodList";
						pstmt=conn.prepareStatement(sql);
						rs=pstmt.executeQuery();
						while(rs.next()){
					%>
					<!-- 게시글 하나씩 출력 -->
					<div class="col">
						<div class="card shadow-sm">
								<img src="./resources/images/<%=rs.getString("FoodImg")%>" style="width:100%; height:100%"/>
							<div class="card-body">
								<p class="card-text"><h5><b><%=rs.getString("FoodName") %></b></h5>
								<p class="card-text"><%=rs.getString("FoodInfo")%></p>
								<div class="d-flex justify-content-between align-items-center">
									<div class="btn-group">
									<!-- button에서 a로 바꿈 -->
										<a href= "./article.jsp?id=<%=rs.getString("FoodCode")%>" type="button" class="btn btn-sm btn-outline-secondary">View</a>
										
									</div>
									
									<a href="addLike.jsp?id=<%=rs.getString("FoodCode")%>" class="btn btn-sm btn-outline-secondary" onclick="return confirm('게시글을 좋아요 목록에 추가하시겠습니까?');">LIKE</a>

									
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