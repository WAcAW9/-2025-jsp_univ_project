<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ include file="../connection.jsp" %>
<!-- db연동을 위한 import -->
<%@ page import="java.sql.*" %>
<%
    String sessionLevel = (String) session.getAttribute("level");
    if (sessionLevel == null || !sessionLevel.equals("admin")) {
        response.sendRedirect("../Login/login.jsp");
        return;
    }

    String userCodeStr = request.getParameter("UserCode");
    int userCode = (userCodeStr != null) ? Integer.parseInt(userCodeStr) : -1;
    if (userCode == -1) {
        out.println("잘못된 접근입니다.");
        return;
    }

    String userName = "";
    int currentPoint = 0;
    PreparedStatement ps = conn.prepareStatement(
        "SELECT u.UserName, IFNULL(up.Point, 0) AS Point FROM User u " +
        "LEFT JOIN UserPointCount up ON u.UserCode = up.UserCode WHERE u.UserCode = ?"
    );
    ps.setInt(1, userCode);
    ResultSet rs = ps.executeQuery();
    if (rs.next()) {
        userName = rs.getString("UserName");
        currentPoint = rs.getInt("Point");
    }
    rs.close();
    ps.close();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>포인트 수정</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5">
    <h2>포인트 수정 - <%= userName %> (UserCode: <%= userCode %>)</h2>
    <form action="UpdatePointProcess.jsp" method="post">
        <input type="hidden" name="UserCode" value="<%= userCode %>">
        <div class="mb-3">
            <label class="form-label">현재 포인트</label>
            <input type="text" class="form-control" value="<%= currentPoint %>" readonly>
        </div>
        <div class="mb-3">
            <label class="form-label">추가할 포인트 <br>(양수 -> 추가, 음수 -> 차감)</label>
            <input type="number" name="change" class="form-control" required>
        </div>
        <button type="submit" class="btn btn-primary">포인트 수정</button>
        <a href="AdminPointList.jsp" class="btn btn-secondary">취소</a>
    </form>
</div>
</body>
</html>