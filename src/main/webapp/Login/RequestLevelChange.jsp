<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="../connection.jsp" %>
<%
    String userCode = (String) session.getAttribute("userCode");
    String userLevel = (String) session.getAttribute("level");

    if (userCode == null || userLevel == null) {
%>
    <script>
        alert('로그인이 필요합니다.');
        location.href = '../Login/login.jsp';
    </script>
<%
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>등급 변경 신청</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <style>
        body {
            background-color: #e9ecef;
        }
        .card {
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
        }
    </style>
</head>
<body>

<div class="container d-flex justify-content-center align-items-center" style="min-height: 100vh;">
    <div class="card p-4" style="width: 100%; max-width: 600px;">
        <h3 class="mb-4 text-center text-primary">회원 등급 변경 신청</h3>
        <form method="post" action="SubmitLevelRequest.jsp">
            <input type="hidden" name="userCode" value="<%= userCode %>">
            <input type="hidden" name="userLevel" value="<%= userLevel %>">

            <div class="mb-3">
                <label for="reason" class="form-label fw-semibold">신청 사유</label>
                <textarea name="reason" id="reason" class="form-control" rows="5" placeholder="변경을 원하는 이유를 적어주세요." required></textarea>
            </div>

            <div class="d-grid">
                <button type="submit" class="btn btn-primary">신청하기</button>
            </div>
        </form>
    </div>
</div>

</body>
</html>