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

    int userCode = Integer.parseInt(request.getParameter("UserCode"));
    int change = Integer.parseInt(request.getParameter("change"));

    int current = 0;
    PreparedStatement checkStmt = conn.prepareStatement("SELECT Point FROM UserPointCount WHERE UserCode = ?");
    checkStmt.setInt(1, userCode);
    ResultSet rs = checkStmt.executeQuery();

    if (rs.next()) {
        current = rs.getInt("Point");
    }
    rs.close();
    checkStmt.close();

    int updated = current + change;
    if (updated < 0) updated = 0; // 포인트는 음수가 되지 않도록 제한

    PreparedStatement upStmt = conn.prepareStatement(
        "REPLACE INTO UserPointCount (UserCode, Point) VALUES (?, ?)"
    );
    upStmt.setInt(1, userCode);
    upStmt.setInt(2, updated);
    upStmt.executeUpdate();
    upStmt.close();

    conn.close();
    response.sendRedirect("AdminPointList.jsp");
%>