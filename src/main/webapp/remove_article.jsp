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
    String id = request.getParameter("id");
    if (id == null || id.trim().equals("")) {
        response.sendRedirect("userPage.jsp");
        return;
    }

    PreparedStatement pstmt = null;
    int result = 0;

    try {
        String sql = "DELETE FROM FoodList WHERE FoodCode = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, id);
        result = pstmt.executeUpdate(); 

        if (result > 0) {
%>
            <script type="text/javascript">
                alert("게시글이 성공적으로 삭제되었습니다.");
                location.href = "userPage.jsp"; 
            </script>
<%
        } else {
%>
            <script type="text/javascript">
                alert("해당 게시글을 삭제할 수 없습니다.");
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