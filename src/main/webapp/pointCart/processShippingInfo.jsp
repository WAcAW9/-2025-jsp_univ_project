<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.net.URLEncoder" %>


<%
    String name = request.getParameter("name");
    String address = request.getParameter("address");
    String phone = request.getParameter("phone");

    Cookie c1 = new Cookie("name", URLEncoder.encode(name, "UTF-8"));
    Cookie c2 = new Cookie("address", URLEncoder.encode(address, "UTF-8"));
    Cookie c3 = new Cookie("phone", URLEncoder.encode(phone, "UTF-8"));

    c1.setMaxAge(60 * 60 * 24);
    c2.setMaxAge(60 * 60 * 24);
    c3.setMaxAge(60 * 60 * 24);

    response.addCookie(c1);
    response.addCookie(c2);
    response.addCookie(c3);

    response.sendRedirect("orderConfirmation.jsp");
%>