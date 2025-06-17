<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../connection.jsp" %>
<!-- db연동을 위한 import -->
<%@ page import="java.sql.*" %>
<%
    request.setCharacterEncoding("UTF-8");

    String userCode = request.getParameter("userCode");   
    String newLevel = request.getParameter("level");    

    PreparedStatement pstmt = null;

    try {
        String sql = "UPDATE UserInfo SET level = ? WHERE UserCode = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, newLevel);
        pstmt.setInt(2, Integer.parseInt(userCode));

        int result = pstmt.executeUpdate();

        if (result > 0) {
%>
            <script>
                alert('회원 권한이 변경되었습니다.');
                location.href = 'UpdateUserLevel.jsp';
            </script>
<%
        } else {
%>
            <script>
                alert('변경 실패: 해당 회원이 존재하지 않습니다.');
                history.back();
            </script>
<%
        }
    } catch (Exception e) {
%>
        <script>
            alert('오류 발생: <%= e.getMessage() %>');
            history.back();
        </script>
<%
    } finally {
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>