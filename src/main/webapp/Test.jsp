<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
    out.println("userCode = " + session.getAttribute("userCode"));
    out.println("level = " + session.getAttribute("level"));
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>테스트 페이지00</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <style>
        body {
            background-color: #f1f3f5;
        }
        .card {
            border-radius: 12px;
            box-shadow: 0 0 12px rgba(0,0,0,0.08);
        }
    </style>
</head>
<body>

<div class="container d-flex justify-content-center align-items-center" style="min-height: 100vh;">
    <div class="card p-5" style="width: 100%; max-width: 500px;">
        <h3 class="text-center text-primary mb-4">테스트 메뉴</h3>

        <div class="d-grid gap-3">
            <a href="Login/UpdateUserLevel.jsp" class="btn btn-dark">🔧 관리자 - 회원 등급 변경</a>
            <a href="recommend/recommend.jsp" class="btn btn-success">🍽 음식 추천 받기</a>
            <a href="Login/RequestLevelChange.jsp" class="btn btn-warning">📤 회원 등급 업그레이드 신청</a>
            <a href="recommend/UpdateUserTaste.jsp" class="btn btn-info">🎯 내 맛 선호도 수정</a>
            <a href="pointList/pointList.jsp" class="btn btn-info">🎯 포인트 리스트</a>
        </div>
    </div>
</div>

</body>
</html>
	