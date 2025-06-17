<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>remove_article</title>
</head>
<body>
<%@ include file="connection.jsp" %>

<%
	request.setCharacterEncoding("UTF-8");
	String foodCode = request.getParameter("foodCode");
	String userName = request.getParameter("userName");
	
	if (foodCode == null || userName == null) {
	    response.sendRedirect("userPage.jsp");
	    return;
	}

    PreparedStatement pstmt = null;
    int result = 0;

    try {
        String sql = "DELETE FROM LikeArticle WHERE UserName = ? AND foodCode = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, userName);
        pstmt.setString(2, foodCode);
        result = pstmt.executeUpdate(); 

        if (result > 0) {
%>
            <script type="text/javascript">
                alert("좋아요 게시글이 성공적으로 삭제되었습니다.");
                location.href = "userPage.jsp"; 
            </script>
<%
        } else {
%>
            <script type="text/javascript">
                alert("해당 좋아요 게시글을 삭제할 수 없습니다.");
                location.href = "userPage.jsp";
            </script>
<%
        }
    } catch (Exception e) {
        out.println("에러 발생: " + e.getMessage());
    } finally {
        if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
    }
%>


</body>
</html>