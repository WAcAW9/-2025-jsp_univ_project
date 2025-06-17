<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="../connection.jsp" %>
<!-- db연동을 위한 import -->
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>등급 변경 신청 목록</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        body {
            background-color: #f8f9fa;
        }
        .container {
            margin-top: 50px;
        }
        .admin-header {
            background-color: #343a40;
            color: white;
            padding: 15px;
            border-radius: 5px;
        }
        table {
            background-color: white;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="admin-header mb-4">
        <h2>관리자 페이지 - 등급 변경 신청 목록</h2>
    </div>

    <%
        String currentLevel = (String) session.getAttribute("level");

        if (!"admin".equals(currentLevel)) {
            out.println("<div class='alert alert-danger'>접근 권한이 없습니다.</div>");
            return;
        }

        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT * FROM LevelRequest ORDER BY requestDate DESC");
    %>

    <table class="table table-bordered table-hover text-center">
        <thead class="table-dark">
            <tr>
                <th>유저코드</th>
                <th>현재레벨</th>
                <th>신청사유</th>
                <th>신청일시</th>
                <th>조치</th>
            </tr>
        </thead>
        <tbody>
        <%
            while (rs.next()) {
                String userCode = rs.getString("userCode");
                String userLevel = rs.getString("userLevel");
                String reason = rs.getString("reason");
                String requestDate = rs.getString("requestDate");
        %>
            <tr>
                <td><%= userCode %></td>
                <td><%= userLevel %></td>
                <td><%= reason %></td>
                <td><%= requestDate %></td>
                <td>
                    <form method="post" action="changeLevelProcess.jsp" class="d-flex flex-column">
                        <input type="hidden" name="userCode" value="<%= userCode %>">
                        <select name="level" class="form-select mb-1" required>
                            <option value="nomal">일반회원</option>
                            <option value="mid">중간관리자</option>
                            <option value="admin">관리자</option>
                        </select>
                        <button type="submit" class="btn btn-success btn-sm">등급 변경</button>
                    </form>
                </td>
            </tr>
        <%
            }
            rs.close();
            stmt.close();
            conn.close();
        %>
        </tbody>
    </table>
</div>

</body>
</html>