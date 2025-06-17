<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="dto.PointProduct" %>
<%@ page import="java.util.*" %>

<%
    String code = request.getParameter("ProductCode");
    String name = request.getParameter("ProductName");
    String priceStr = request.getParameter("ProductPrice");
    int price = Integer.parseInt(priceStr);

    PointProduct product = new PointProduct();
    product.setProductCode(code);
    product.setProductName(name);
    product.setProductPrice(price);

    List<PointProduct> cart = (List<PointProduct>) session.getAttribute("cart");
    if (cart == null) {
        cart = new ArrayList<>();
        session.setAttribute("cart", cart);
    }

    cart.add(product);

    response.sendRedirect("cart.jsp");
%>