<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.PointProductRepository"%>
<%@ page import="dto.PointProduct"%>
<%@ page import="java.util.*"%>

<%
PointProductRepository dao = PointProductRepository.getInstance();
List<PointProduct> pointProducts = dao.getAllProducts();
%>
<%
    String level = (String) session.getAttribute("level");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>포인트 상품 목록</title>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/pointList.css">
<script
	src="<%=request.getContextPath()%>/resources/script/pointListModal.js"></script>

</head>

<body>
	<jsp:include page="../layout/header.jsp" />

	<div class="ListBlock">
	<%
		for (int i = 0; i < pointProducts.size(); i++) {
			PointProduct product = pointProducts.get(i);
	%>
<div class="List">
    <h3><%= product.getProductName() %></h3>
    <p>가격: <%= product.getProductPrice() %>P</p>
    <p>남은 수량: <%= product.getRemainingQuantity() %></p>
    <div class="d-flex flex-column align-items-center">
        <!-- 상세 보기 버튼 -->
        <button class="btn btn-primary mb-2 detailBTN" onclick="openPointModal('<%= product.getProductCode() %>')">상세보기</button>

        <!-- 포인트 교환하기 -->
        <a href="../pointCart/cart.jsp" class="btn btn-success mb-2 purchaseBTN">포인트 교환하기</a>

        <!-- 장바구니 담기 -->
        <form action="../pointCart/addCart.jsp" method="post">
            <input type="hidden" name="ProductCode" value="<%= product.getProductCode() %>">
            <input type="hidden" name="ProductName" value="<%= product.getProductName() %>">
            <input type="hidden" name="ProductPrice" value="<%= product.getProductPrice() %>">
            <button type="submit" class="btn btn-success cartBTN" style="background-color: rgb(102, 51, 153)">장바구니 담기</button>
        </form>
    </div>
</div>
	<%
		}
	%>
</div>
<div class="container mt-4">
    <div class="d-flex justify-content-end flex-wrap gap-2">
        <a href="../adminPoint/MyPoint.jsp" class="btn btn-info">내 포인트 확인하기</a>

        <% if ("admin".equals(level)) { %>
            <a href="../point_write.jsp" class="btn btn-success">포인트 상품 추가하기</a>
            <a href="../adminPoint/AdminPointList.jsp" class="btn btn-dark">유저 포인트 관리</a>
        <% } %>
    </div>
</div>


	<jsp:include page="../pointList/Pointmodal.jsp" />
	<jsp:include page="/layout/footer.jsp" />
</body>
</html>