<%@ page import="java.sql.*" %>
<%
    Connection conn = null;

    String url = "jdbc:mysql://localhost:3306/SchoolProjectJSP";
    String user = "root";
    String password = "7482";

    Class.forName("com.mysql.cj.jdbc.Driver");
    conn = DriverManager.getConnection(url, user, password);
%>