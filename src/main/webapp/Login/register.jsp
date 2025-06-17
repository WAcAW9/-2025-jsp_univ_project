<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<!-- db연동을 위한 import -->
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>회원가입</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        .slider-label {
            display: flex;
            justify-content: space-between;
        }
        .slider-value {
            font-weight: bold;
            margin-left: 10px;
        }
    </style>
</head>
<body class="container mt-5">
<%@ include file="../connection.jsp" %>
<jsp:include page="/layout/header.jsp" />

<h2>회원가입</h2>
<form method="post">
    <input type="text" name="userid" placeholder="아이디" class="form-control mb-2" required>
    <input type="password" name="userpw" placeholder="비밀번호" class="form-control mb-2" required>
    <input type="text" name="username" placeholder="이름" class="form-control mb-2" required>
    <input type="number" name="age" placeholder="나이" class="form-control mb-2">
    <input type="text" name="address" placeholder="주소" class="form-control mb-2">

    <h5 class="mt-4">맛 선호도 설정 (1~5)</h5>

    <div class="mb-3">
        <label class="form-label">매운맛 (Spicy): <span id="spicyVal" class="slider-value">3</span></label>
        <input type="range" class="form-range" name="spicy" min="1" max="5" value="3" oninput="spicyVal.innerText = this.value">
    </div>
    <div class="mb-3">
        <label class="form-label">단맛 (Sweet): <span id="sweetVal" class="slider-value">3</span></label>
        <input type="range" class="form-range" name="sweet" min="1" max="5" value="3" oninput="sweetVal.innerText = this.value">
    </div>
    <div class="mb-3">
        <label class="form-label">짠맛 (Salty): <span id="saltyVal" class="slider-value">3</span></label>
        <input type="range" class="form-range" name="salty" min="1" max="5" value="3" oninput="saltyVal.innerText = this.value">
    </div>
    <div class="mb-3">
        <label class="form-label">고소함 (Savory): <span id="savoryVal" class="slider-value">3</span></label>
        <input type="range" class="form-range" name="savory" min="1" max="5" value="3" oninput="savoryVal.innerText = this.value">
    </div>
    <div class="mb-3">
        <label class="form-label">감칠맛 (Umami): <span id="umamiVal" class="slider-value">3</span></label>
        <input type="range" class="form-range" name="umami" min="1" max="5" value="3" oninput="umamiVal.innerText = this.value">
    </div>

    <button type="submit" class="btn btn-primary">가입하기</button>
</form>

<%
    if(request.getMethod().equals("POST")) {
        String id = request.getParameter("userid");
        String pw = request.getParameter("userpw");
        String name = request.getParameter("username");
        String age = request.getParameter("age");
        String address = request.getParameter("address");

        // Taste 파라미터
        int spicy = Integer.parseInt(request.getParameter("spicy"));
        int sweet = Integer.parseInt(request.getParameter("sweet"));
        int salty = Integer.parseInt(request.getParameter("salty"));
        int savory = Integer.parseInt(request.getParameter("savory"));
        int umami = Integer.parseInt(request.getParameter("umami"));

        try {
            String sql1 = "INSERT INTO User(UserID, UserPW, UserName, UserAge, UserAddress) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement pstmt1 = conn.prepareStatement(sql1, Statement.RETURN_GENERATED_KEYS);
            pstmt1.setString(1, id);
            pstmt1.setString(2, pw);
            pstmt1.setString(3, name);
            pstmt1.setInt(4, Integer.parseInt(age));
            pstmt1.setString(5, address);
            pstmt1.executeUpdate();

            ResultSet rs = pstmt1.getGeneratedKeys();
            int userCode = -1;
            if(rs.next()) {
                userCode = rs.getInt(1);
            }

            // UserInfo 테이블 입력
            String sql2 = "INSERT INTO UserInfo(UserCode, level) VALUES (?, ?)";
            PreparedStatement pstmt2 = conn.prepareStatement(sql2);
            pstmt2.setInt(1, userCode);
            pstmt2.setString(2, "nomal");
            pstmt2.executeUpdate();

            // UserTaste 테이블 입력
            String sql3 = "INSERT INTO UserTaste(UserCode, UserSpicy, UserSweet, UserSalty, UserSavory, UserUmami) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement pstmt3 = conn.prepareStatement(sql3);
            pstmt3.setInt(1, userCode);
            pstmt3.setInt(2, spicy);
            pstmt3.setInt(3, sweet);
            pstmt3.setInt(4, salty);
            pstmt3.setInt(5, savory);
            pstmt3.setInt(6, umami);
            pstmt3.executeUpdate();

            out.println("<div class='alert alert-success mt-3'>회원가입 성공! 로그인하세요.</div>");
            pstmt1.close(); pstmt2.close(); pstmt3.close(); conn.close();
            response.sendRedirect("main.jsp");
        } catch(Exception e) {
            out.println("<div class='alert alert-danger mt-3'>오류 발생: " + e.getMessage() + "</div>");
        }
    }
%>

<jsp:include page="/layout/footer.jsp" />
</body>
</html>