<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.oreilly.servlet.*" %>
<%@ page import="com.oreilly.servlet.multipart.*" %>
<%@ include file="connection.jsp" %>
<!-- db연동을 위한 import -->
<%@ page import="java.sql.*" %>

<%
request.setCharacterEncoding("UTF-8");

String filename = "";
String realFolder = request.getServletContext().getRealPath("/resources/images");
int maxSize = 5 * 1024 * 1024;
String encType = "utf-8";

// 이미지 파일 업로드 처리
MultipartRequest multi = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());

String title = multi.getParameter("title");
String description = multi.getParameter("description");
String recipe = multi.getParameter("recipe");
int spicy = Integer.parseInt(multi.getParameter("spicy"));
int sweet = Integer.parseInt(multi.getParameter("sweet"));
int salty = Integer.parseInt(multi.getParameter("salty"));
int savory = Integer.parseInt(multi.getParameter("savory"));
int umami = Integer.parseInt(multi.getParameter("umami"));
String author = (String) session.getAttribute("userName");

Enumeration files = multi.getFileNames();
String fname = (String) files.nextElement();
String fileName = multi.getFilesystemName(fname);

// DB 저장 처리
PreparedStatement pstmt = null;
try {
    String sql = "INSERT INTO FoodList (FoodName, FoodImg, FoodInfo, FoodDescription, Spicy, Sweet, Salty, Savory, Umami, Author) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    pstmt = conn.prepareStatement(sql);

    pstmt.setString(1, title);
    pstmt.setString(2, fileName);
    pstmt.setString(3, description);
    pstmt.setString(4, recipe);
    pstmt.setInt(5, spicy);
    pstmt.setInt(6, sweet);
    pstmt.setInt(7, salty);
    pstmt.setInt(8, savory);
    pstmt.setInt(9, umami);
    pstmt.setString(10, author);

    pstmt.executeUpdate(); // 실제 실행

} catch(Exception e) {
    e.printStackTrace(); // 오류 확인용
} finally {
    if (pstmt != null) pstmt.close();
    if (conn != null) conn.close();
}

// 리다이렉션
response.sendRedirect("articles.jsp");
%>