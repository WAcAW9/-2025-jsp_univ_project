<%@ page contentType="text/html; charset=UTF-8" %>
<%
    Object userCodeObj = session.getAttribute("userCode");
    if (userCodeObj == null) {
        response.sendRedirect("../Login/login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>배송 정보 입력</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5">
    <h2 class="mb-4">배송 정보 입력</h2>
    <form action="processShippingInfo.jsp" method="post">
        <div class="mb-3">
            <label class="form-label">이름</label>
            <input type="text" name="name" class="form-control" required>
        </div>
        <div class="mb-3">
            <label class="form-label">주소</label>
            <input type="text" name="address" class="form-control" required>
        </div>
        <div class="mb-3">
            <label class="form-label">전화번호</label>
            <input type="text" name="phone" class="form-control" required>
        </div>
        <button type="submit" class="btn btn-success">배송 정보 제출</button>
    </form>
</div>
</body>
</html>