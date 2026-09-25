<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Home</title>
</head>
<body>

    <h1>Welcome to the Application</h1>

    <c:choose>
        <c:when test="${not empty sessionScope.user}">
            <p>Hello, ${sessionScope.user.username}!</p>
            <ul>
                <li><a href="${pageContext.request.contextPath}/users">Manage Users</a></li>
                <li><a href="${pageContext.request.contextPath}/logout">Logout</a></li>
            </ul>
        </c:when>
        <c:otherwise>
            <p>Please log in or create an account:</p>
            <ul>
                <li><a href="${pageContext.request.contextPath}/login">Login</a></li>
                <li><a href="${pageContext.request.contextPath}/register.jsp">Register</a></li>
            </ul>
        </c:otherwise>
    </c:choose>

</body>
</html>