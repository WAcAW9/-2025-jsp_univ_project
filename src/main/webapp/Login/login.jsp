<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<!-- db연동을 위한 import -->
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>로그인</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="container mt-5">
<%@ include file="../connection.jsp" %>
	<jsp:include page="/layout/header.jsp" />
<h2>로그인</h2>
<form method="post">
    <input type="text" name="userid" placeholder="아이디" class="form-control mb-2" required>
    <input type="password" name="userpw" placeholder="비밀번호" class="form-control mb-2" required>
    <button type="submit" class="btn btn-success">로그인</button>
</form>

<%
    if(request.getMethod().equals("POST")) {
        String id = request.getParameter("userid");
        String pw = request.getParameter("userpw");

        try {

            String sql = "SELECT User.UserCode, User.UserName, UserInfo.level " +
                    "FROM User JOIN UserInfo ON User.UserCode = UserInfo.UserCode " +
                    "WHERE User.UserID = ? AND User.UserPW = ?";

            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, id);
            pstmt.setString(2, pw);
            ResultSet rs = pstmt.executeQuery();

            if(rs.next()) {
            	session.setAttribute("userCode", String.valueOf(rs.getInt("UserCode")));
                session.setAttribute("userName", rs.getString("UserName"));
                session.setAttribute("level", rs.getString("level"));  
                response.sendRedirect("../main.jsp");
                //response.sendRedirect("../Test.jsp");
            } else {
                out.println("<div class='alert alert-danger mt-3'>아이디 또는 비밀번호 오류</div>");
            }

            rs.close(); pstmt.close(); conn.close();
        } catch(Exception e) {
            out.println("<div class='alert alert-danger mt-3'>오류: " + e.getMessage() + "</div>");
        }
    }
%>
	<jsp:include page="/layout/footer.jsp" />
</body>
</html>