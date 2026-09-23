<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Form</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f6f9;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .card {
            background: #ffffff;
            padding: 32px;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
            width: 320px;
        }

        h1 {
            margin: 0 0 24px 0;
            color: #2c3e50;
            font-size: 22px;
            text-align: center;
        }

        .form-group {
            margin-bottom: 18px;
        }

        label {
            display: block;
            margin-bottom: 6px;
            color: #334155;
            font-size: 14px;
            font-weight: 600;
        }

        input[type="text"],
        input[type="email"] {
            width: 100%;
            padding: 10px 12px;
            border: 1px solid #cbd5e1;
            border-radius: 6px;
            box-sizing: border-box;
            font-size: 14px;
            color: #1e293b;
            transition: border-color 0.2s, box-shadow 0.2s;
        }

        input:focus {
            outline: none;
            border-color: #3b82f6;
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.15);
        }

        button {
            width: 100%;
            padding: 11px;
            background-color: #3b82f6;
            color: #ffffff;
            border: none;
            border-radius: 6px;
            font-size: 15px;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.2s;
            margin-top: 6px;
        }

        button:hover {
            background-color: #2563eb;
        }
    </style>
</head>

<body>

<div class="card">
    <c:choose>

        <c:when test="${not empty user}">
            <h1>Edit User</h1>
        </c:when>

        <c:otherwise>
            <h1>Add User</h1>
        </c:otherwise>

    </c:choose>

    <form method="post" action="${pageContext.request.contextPath}/users">
        <div class="form-group">
            <label for="username">Username</label>
            <input type="text" id="username"
             name="username" placeholder="Enter username"
             value = "${user.username}"
             required>
        </div>

        <div class="form-group">
            <label for="email">Email</label>
            <input type="email" id="email" name="email"
            placeholder="name@example.com"
            value = "${user.email}"
            required>
        </div>
        <div>
            <input type="hidden" name="id" value="${user.id}">
        </div>


        <button type="submit">Add User</button>
    </form>
</div>

</body>
</html>