<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.PointProductRepository"%>
<%@ page import="dto.PointProduct"%>
<!-- 모달창에서 열 파일 -->
<%
String productCode = request.getParameter("ProductCode");
PointProductRepository dao = PointProductRepository.getInstance();
PointProduct product = dao.getPointProductById(productCode);
%>

<%
if (product != null) {
%>
<div class="ProductDetailModalBox">
<!-- 닫기 버튼 -->
			<span class="close-btn" onclick="closePointModal()" >
				<span class="material-icons">undo</span>
			</span>
	<h2><%=product.getProductName()%></h2>
	<p>
		<b>제품 코드:</b>
		<%=product.getProductCode()%></p>
	<p>
		<b>가격:</b>
		<%=product.getProductPrice()%>P
	</p>
	<p>
		<b>남은 수량:</b>
		<%=product.getRemainingQuantity()%></p>
	<p>
				<a href="../pointCart/cart.jsp" class="btn btn-success purchaseBTN">포인트 교환하기</a>
	</p>
</div>
<div class="productDescriptionBox">
	<p>
		<b>설명:</b>
		<%=product.getDescription()%>
	</p>
</div>
<%
} else {
%>
<p style="color: red;">상품 정보를 찾을 수 없습니다.</p>
<%
}
%>