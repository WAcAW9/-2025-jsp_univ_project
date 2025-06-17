<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.*, dto.PointProduct" %>
<%@ include file="../connection.jsp" %>
<%
    Object userCodeObj = session.getAttribute("userCode");
    int userCode = (userCodeObj != null) ? Integer.parseInt(userCodeObj.toString()) : -1;
    if (userCode == -1) {
        response.sendRedirect("../Login/login.jsp");
        return;
    }

    List<PointProduct> cart = (List<PointProduct>) session.getAttribute("cart");
    if (cart == null) cart = new ArrayList<>();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>장바구니</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f8f9fa; }
        .cart-container { margin-top: 50px; }
    </style>
</head>
<body>
<div class="container cart-container">
    <h2 class="mb-4">🛒 나의 장바구니</h2>
    <ul class="list-group mb-3">
        <% for (PointProduct p : cart) { %>
            <li class="list-group-item d-flex justify-content-between align-items-center">
                <div>
                    <strong><%= p.getProductName() %></strong><br>
                </div>
                <span><%= p.getProductPrice() %> 포인트</span>
            </li>
        <% } %>
        <% if (cart.isEmpty()) { %>
            <li class="list-group-item">장바구니가 비어 있습니다.</li>
        <% } %>
    </ul>

    <form action="../pointCart/shippingInfo.jsp" method="post">
        <button type="submit" class="btn btn-success">주문하기</button>
    </form>
    <a href="../pointList/pointList.jsp" class="btn btn-secondary mt-3">상품 목록으로 돌아가기</a>
</div>
</body>
</html>