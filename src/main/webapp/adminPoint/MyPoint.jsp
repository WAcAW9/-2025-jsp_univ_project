<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ include file="../connection.jsp" %>
<!-- db연동을 위한 import -->
<%@ page import="java.sql.*" %>
<%
    String userCodeStr = (String) session.getAttribute("userCode");
    String userName = (String) session.getAttribute("userName");
    if (userCodeStr == null || userName == null) {
        response.sendRedirect("../Login/login.jsp");
        return;
    }

    int userCode = Integer.parseInt(userCodeStr);
    int currentPoint = 0;

    PreparedStatement ps = conn.prepareStatement("SELECT Point FROM UserPointCount WHERE UserCode = ?");
    ps.setInt(1, userCode);
    ResultSet rs = ps.executeQuery();
    if (rs.next()) {
        currentPoint = rs.getInt("Point");
    }
    rs.close();
    ps.close();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>내 포인트 조회</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5">
    <h2><%= userName %>님의 포인트</h2>
    <p class="fs-4">현재 포인트: <strong><%= currentPoint %> P</strong></p>
    <a href="../pointList/pointList.jsp" class="btn btn-primary">포인트 구매하러 가기</a>
    <a href="../main.jsp" class="btn btn-primary">메인으로</a>
</div>
</body>
</html>