<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dto.Article" %>
<%@ page import="dao.ArticleRepository" %>
<%@ page import="java.sql.*" %>

<%@ include file="connection.jsp" %>
<%
	//클라이언트로부터 전달된 파라미터 'id'를 가져온다
	String articleID = request.getParameter("id");
	String userID = (String) session.getAttribute("userName");
	
    if (articleID == null || userID == null) {
        response.sendRedirect("login.jsp");
        return;
    }
	
    PreparedStatement pstmt = null;
    
    try {
        String sql = "INSERT INTO LikeArticle (UserName, foodCode) VALUES (?, ?)";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, userID);
        pstmt.setString(2, articleID);
        pstmt.executeUpdate();

        response.sendRedirect("userPage.jsp"); // 좋아요 완료 후 마이페이지로 이동
    } catch (SQLException e) {
        // 이미 좋아요한 경우 등 예외 처리
        out.println("오류: " + e.getMessage());
    } finally {
        if (pstmt != null) pstmt.close();
    }
%>