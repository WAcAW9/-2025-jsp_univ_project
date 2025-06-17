<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="../connection.jsp" %>
<!-- db연동을 위한 import -->
<%@ page import="java.sql.*" %>

<%
    String userCode = request.getParameter("userCode");
    String userLevel = request.getParameter("userLevel");
    String reason = request.getParameter("reason");

    PreparedStatement pstmt = null;

    try {
        String sql = "INSERT INTO LevelRequest (userCode, userLevel, reason) VALUES (?, ?, ?)";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, userCode);
        pstmt.setString(2, userLevel);
        pstmt.setString(3, reason);

        int result = pstmt.executeUpdate();
        if (result > 0) {
            //out.println("<script>alert('신청이 완료되었습니다.'); location.href='main.jsp';</script>");
            out.println("<script>alert('신청이 완료되었습니다.'); location.href='../Test.jsp';</script>");
        } else {
            out.println("<script>alert('신청 실패.'); history.back();</script>");
        }
    } catch (Exception e) {
        out.println("오류: " + e.getMessage());
    } finally {
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>