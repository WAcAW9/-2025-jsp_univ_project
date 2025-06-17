<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*, java.util.*" %>
<%@ include file="../connection.jsp" %>
<!-- db연동을 위한 import -->
<%@ page import="java.sql.*" %>
<%
    Object userCodeObj = session.getAttribute("userCode");
    int userCode = (userCodeObj != null) ? Integer.parseInt(userCodeObj.toString()) : -1;
    String level = (String) session.getAttribute("level");
    if (userCode == -1 || level == null || !level.equals("admin")) {
        response.sendRedirect("../Login/login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>관리자 - 사용자 포인트 목록</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5">
    <h2 class="mb-4">관리자 페이지 - 포인트 관리</h2>
    <table class="table table-bordered table-hover">
        <thead class="table-dark">
            <tr>
                <th>UserCode</th>
                <th>UserName</th>
                <th>레벨</th>
                <th>포인트</th>
                <th>수정</th>
            </tr>
        </thead>
        <tbody>
            <%
                String sql = "SELECT u.UserCode, u.UserName, ui.level, IFNULL(up.Point, 0) AS Point " +
                             "FROM User u JOIN UserInfo ui ON u.UserCode = ui.UserCode " +
                             "LEFT JOIN UserPointCount up ON u.UserCode = up.UserCode " +
                             "WHERE ui.level IN ('min', 'admin')";
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
            %>
            <tr>
                <td><%= rs.getInt("UserCode") %></td>
                <td><%= rs.getString("UserName") %></td>
                <td><%= rs.getString("level") %></td>
                <td><%= rs.getInt("Point") %></td>
                <td>
                    <form action="UpdatePoint.jsp" method="post">
                        <input type="hidden" name="UserCode" value="<%= rs.getInt("UserCode") %>">
                        <button type="submit" class="btn btn-warning btn-sm">수정</button>
                    </form>
                </td>
            </tr>
            <% } rs.close(); ps.close(); %>
        </tbody>
    </table>
<div class="d-flex justify-content-end gap-2 mb-3">
    <a href="../pointList/pointList.jsp" class="btn btn-secondary">포인트 페이지로 이동</a>
    <a href="../main.jsp" class="btn btn-dark">메인페이지 이동</a>
</div>
</div>
</body>
</html>