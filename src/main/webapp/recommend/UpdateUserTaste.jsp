<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ include file="../connection.jsp" %>
<!-- db연동을 위한 import -->
<%@ page import="java.sql.*" %>
<%
    Object codeObj = session.getAttribute("userCode");
    int userCode = -1;
    try {
        userCode = (codeObj instanceof Integer) ? (Integer) codeObj : Integer.parseInt(codeObj.toString());
    } catch (Exception e) {
        userCode = -1;
    }

    if (userCode == -1) {
        response.sendRedirect("../Login/login.jsp");
        return;
    }

    int spicy = 3, sweet = 3, salty = 3, savory = 3, umami = 3;

    try {
        if ("POST".equals(request.getMethod())) {
            spicy = Integer.parseInt(request.getParameter("spicy"));
            sweet = Integer.parseInt(request.getParameter("sweet"));
            salty = Integer.parseInt(request.getParameter("salty"));
            savory = Integer.parseInt(request.getParameter("savory"));
            umami = Integer.parseInt(request.getParameter("umami"));

            String updateSql = "UPDATE UserTaste SET UserSpicy=?, UserSweet=?, UserSalty=?, UserSavory=?, UserUmami=? WHERE UserCode=?";
            PreparedStatement pstmt = conn.prepareStatement(updateSql);
            pstmt.setInt(1, spicy);
            pstmt.setInt(2, sweet);
            pstmt.setInt(3, salty);
            pstmt.setInt(4, savory);
            pstmt.setInt(5, umami);
            pstmt.setInt(6, userCode);
            pstmt.executeUpdate();
            pstmt.close();

            out.println("<div class='alert alert-success mt-3'>맛 정보가 성공적으로 수정되었습니다.</div>");
        } else {
            String sql = "SELECT * FROM UserTaste WHERE UserCode = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userCode);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                spicy = rs.getInt("UserSpicy");
                sweet = rs.getInt("UserSweet");
                salty = rs.getInt("UserSalty");
                savory = rs.getInt("UserSavory");
                umami = rs.getInt("UserUmami");
            }
            rs.close();
            pstmt.close();
        }
    } catch (Exception e) {
        out.println("<div class='alert alert-danger'>오류: " + e.getMessage() + "</div>");
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>맛 선호도 수정</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .slider-vertical {
            writing-mode: bt-lr;
            -webkit-appearance: slider-vertical;
            width: 8px;
            height: 200px;
        }
        .taste-card {
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 1rem;
            border: 1px solid #ddd;
            border-radius: 10px;
            background-color: #f9f9f9;
        }
        .taste-label {
            font-weight: bold;
            margin-bottom: 0.5rem;
        }
        .slider-value {
            margin-top: 0.5rem;
            font-size: 1.2rem;
            color: #007bff;
        }
    </style>
</head>
<body class="bg-light">
    <div class="container py-5">
        <h2 class="text-center mb-5">맛 선호도 수정</h2>
        <form method="post">
            <div class="row justify-content-center gy-4">
                <div class="col-6 col-md-2 text-center">
                    <div class="taste-card">
                        <div class="taste-label">매운맛</div>
                        <input type="range" class="form-range slider-vertical" name="spicy" min="1" max="5" value="<%= spicy %>" oninput="spicyVal.innerText = this.value">
                        <div id="spicyVal" class="slider-value"><%= spicy %></div>
                    </div>
                </div>
                <div class="col-6 col-md-2 text-center">
                    <div class="taste-card">
                        <div class="taste-label">단맛</div>
                        <input type="range" class="form-range slider-vertical" name="sweet" min="1" max="5" value="<%= sweet %>" oninput="sweetVal.innerText = this.value">
                        <div id="sweetVal" class="slider-value"><%= sweet %></div>
                    </div>
                </div>
                <div class="col-6 col-md-2 text-center">
                    <div class="taste-card">
                        <div class="taste-label">짠맛</div>
                        <input type="range" class="form-range slider-vertical" name="salty" min="1" max="5" value="<%= salty %>" oninput="saltyVal.innerText = this.value">
                        <div id="saltyVal" class="slider-value"><%= salty %></div>
                    </div>
                </div>
                <div class="col-6 col-md-2 text-center">
                    <div class="taste-card">
                        <div class="taste-label">고소함</div>
                        <input type="range" class="form-range slider-vertical" name="savory" min="1" max="5" value="<%= savory %>" oninput="savoryVal.innerText = this.value">
                        <div id="savoryVal" class="slider-value"><%= savory %></div>
                    </div>
                </div>
                <div class="col-6 col-md-2 text-center">
                    <div class="taste-card">
                        <div class="taste-label">감칠맛</div>
                        <input type="range" class="form-range slider-vertical" name="umami" min="1" max="5" value="<%= umami %>" oninput="umamiVal.innerText = this.value">
                        <div id="umamiVal" class="slider-value"><%= umami %></div>
                    </div>
                </div>
            </div>
            <div class="text-center mt-5">
                <button type="submit" class="btn btn-success btn-lg px-5">저장</button>
            </div>
        </form>
    </div>
</body>
</html>