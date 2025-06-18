<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="KNNRecommend.KNNRecommend" %>
<%@ page import="java.sql.*, java.util.*" %>
<%@ include file="../connection.jsp" %>
<!-- db연동을 위한 import -->
<%@ page import="java.sql.*" %>

<%
    // 세션 검사
    String userCodeStr = (String) session.getAttribute("userCode");
    if (userCodeStr == null) {
        response.sendRedirect("../Login/login.jsp");
        return;
    }

    int userCode = Integer.parseInt(userCodeStr);

    int foodCode = -1;
    String foodName = "";
    int spicy = 0, sweet = 0, salty = 0, savory = 0, umami = 0;

    if ("POST".equals(request.getMethod())) {
        try {
            KNNRecommend recommender = new KNNRecommend();
            foodCode = recommender.recommendFoodByUser(String.valueOf(userCode));

            String sql = "SELECT * FROM FoodList WHERE FoodCode = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, foodCode);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                foodName = rs.getString("FoodName");
                spicy = rs.getInt("Spicy");
                sweet = rs.getInt("Sweet");
                salty = rs.getInt("Salty");
                savory = rs.getInt("Savory");
                umami = rs.getInt("Umami");
            }

            rs.close();
            pstmt.close();
        } catch (Exception e) {
            out.println("<div class='alert alert-danger mt-3'>추천 오류: " + e.getMessage() + "</div>");
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>음식 추천</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="container mt-5">
    <jsp:include page="/layout/header.jsp" />

    <h2 class="mb-4">내 취향으로 음식 추천</h2>

    <!-- 추천 버튼 -->
    <form method="post">
        <button type="submit" class="btn btn-primary">추천받기</button>
    </form>
    <!-- 취향 변경 버튼 -->
    <a href="../recommend/UpdateUserTaste.jsp" class="btn btn-warning mt-4">내 음식 취향 변경하기</a>
    

    <!-- 추천 결과 -->
    <% if (foodCode != -1) { %>
        <div class="card mt-4 p-4">
            <h4><%= foodName %> (FoodCode: <%= foodCode %>)</h4>
            <ul class="list-group list-group-flush">
                <li class="list-group-item">매운맛: <%= spicy %></li>
                <li class="list-group-item">단맛: <%= sweet %></li>
                <li class="list-group-item">짠맛: <%= salty %></li>
                <li class="list-group-item">고소함: <%= savory %></li>
                <li class="list-group-item">감칠맛: <%= umami %></li>
            </ul>
            <a href= "../article.jsp?id=<%=foodCode%>" type="button" class="btn btn-sm btn-outline-secondary">View</a>
        </div>
    <% } %>

<br><br>
    <a href="../main.jsp" class="btn btn-secondary mt-4">메인으로</a>

    <jsp:include page="/layout/footer.jsp" />
</body>
</html>