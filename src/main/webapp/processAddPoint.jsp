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
String realFolder = "C:\\Users\\awon0\\Desktop\\sec_project\\sec_project\\JSP_UNIV_Project\\SchoolProject_KTK_CAW\\src\\main\\webapp\\resources\\images";
int maxSize = 5 * 1024 * 1024;
String encType = "utf-8";

// 이미지 파일 업로드 처리
MultipartRequest multi = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());

String title = multi.getParameter("title");
int price = Integer.parseInt(multi.getParameter("price"));
int quantity = Integer.parseInt(multi.getParameter("quantity"));
String description = multi.getParameter("description");
String code = multi.getParameter("code");

Enumeration files = multi.getFileNames();
String fname = (String) files.nextElement();
String fileName = multi.getFilesystemName(fname);

// DB 저장 처리
PreparedStatement pstmt = null;
try {
    String sql = "INSERT INTO PointProduct VALUES (?, ?, ?, ?, ?,?)";
    pstmt = conn.prepareStatement(sql);

    pstmt.setString(1, code);
    pstmt.setString(2, title);
    pstmt.setInt(3, price);
    pstmt.setString(4, fileName);
    pstmt.setInt(5, quantity);
    pstmt.setString(6, description);

    pstmt.executeUpdate(); // 실제 실행

} catch(Exception e) {
    e.printStackTrace(); // 오류 확인용
} finally {
    if (pstmt != null) pstmt.close();
    if (conn != null) conn.close();
}

// 리다이렉션 -> 경로 바꾸기
response.sendRedirect("articles.jsp");
%>