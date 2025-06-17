<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.net.URLDecoder, java.sql.*, java.util.*, dto.PointProduct" %>
<%@ include file="../connection.jsp" %>
<!-- db연동을 위한 import -->
<%@ page import="java.sql.*" %>
<%
    String name = "", address = "", phone = "";
    Cookie[] cookies = request.getCookies();
    for (Cookie c : cookies) {
        switch (c.getName()) {
            case "name": name = URLDecoder.decode(c.getValue(), "UTF-8"); break;
            case "address": address = URLDecoder.decode(c.getValue(), "UTF-8"); break;
            case "phone": phone = URLDecoder.decode(c.getValue(), "UTF-8"); break;
        }
    }

    String userCodeStr = (String) session.getAttribute("userCode");
    String userName = (String) session.getAttribute("userName");
    if (userCodeStr == null || userName == null) {
        response.sendRedirect("../Login/login.jsp");
        return;
    }

    int userCode = Integer.parseInt(userCodeStr);
    int currentPoint = 0;
    PreparedStatement checkStmt = conn.prepareStatement("SELECT Point FROM UserPointCount WHERE UserCode = ?");
    checkStmt.setInt(1, userCode);
    ResultSet rs = checkStmt.executeQuery();
    if (rs.next()) {
        currentPoint = rs.getInt("Point");
    }
    rs.close();
    checkStmt.close();

    List<PointProduct> cart = (List<PointProduct>) session.getAttribute("cart");
    int totalCost = 0;
    if (userCode != -1 && cart != null && !cart.isEmpty()) {
        for (PointProduct p : cart) {
            totalCost += p.getProductPrice();
        }
        if (currentPoint >= totalCost) {
            for (PointProduct p : cart) {
                PreparedStatement ps = conn.prepareStatement(
                    "INSERT INTO Orders (UserCode, ProductCode, Quantity, CustomerInfo) VALUES (?, ?, ?, ?)"
                );
                ps.setInt(1, userCode);
                ps.setString(2, p.getProductCode());
                ps.setInt(3, 1);
                ps.setString(4, name + ", " + address + ", " + phone);
                ps.executeUpdate();
                ps.close();
            }
            PreparedStatement updatePoint = conn.prepareStatement("UPDATE UserPointCount SET Point = ? WHERE UserCode = ?");
            updatePoint.setInt(1, currentPoint - totalCost);
            updatePoint.setInt(2, userCode);
            updatePoint.executeUpdate();
            updatePoint.close();
            session.removeAttribute("cart");
        } else {
            out.println("<script>alert('포인트가 부족합니다.'); history.back();</script>");
            return;
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>주문 완료</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5">
    <h2 class="text-success">주문이 완료되었습니다!</h2>
    <p>감사합니다. <strong><%= name %></strong> 고객님<br>
    배송지: <%= address %><br>
    연락처: <%= phone %><br>
    사용한 포인트: <strong><%= totalCost %></strong> P<br>
    남은 포인트: <strong><%= currentPoint - totalCost %></strong> P</p>
    <a href="../pointList/pointList.jsp" class="btn btn-primary">상품 목록으로 이동</a>
</div>
</body>
</html>