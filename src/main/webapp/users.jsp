<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Users List</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f6f9;
            margin: 0;
            padding: 40px 20px;
            display: flex;
            justify-content: center;
        }

        .container {
            background: #ffffff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
            width: 100%;
            max-width: 700px;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            border-bottom: 2px solid #edf2f7;
            padding-bottom: 12px;
        }

        h1 {
            color: #2c3e50;
            margin: 0;
            font-size: 22px;
        }

        .user-count {
            background-color: #e3f2fd;
            color: #1976d2;
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: bold;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            text-align: left;
        }

        th {
            background-color: #f8fafc;
            color: #475569;
            padding: 12px 14px;
            font-size: 13px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            border-bottom: 1px solid #e2e8f0;
        }

        td {
            padding: 14px;
            border-bottom: 1px solid #f1f5f9;
            color: #334155;
            font-size: 14px;
        }

        tr:hover td {
            background-color: #f8fafc;
        }

        .badge-id {
            color: #64748b;
            font-weight: bold;
        }

        .username {
            font-weight: 600;
            color: #0f172a;
        }

        .email {
            color: #3b82f6;
        }

        .empty-state {
            text-align: center;
            color: #94a3b8;
            padding: 30px 0;
            font-size: 14px;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="header">
        <h1>Users</h1>
        <span class="user-count">${users.size()} Total</span>
    </div>

    <table>
        <thead>
            <tr>
                <th style="width: 80px;">ID</th>
                <th>Username</th>
                <th>Email</th>
            </tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${not empty users}">
                    <c:forEach var="user" items="${users}">
                        <tr>
                            <td class="badge-id">#${user.id}</td>
                            <td class="username">${user.username}</td>
                            <td class="email">${user.email}</td>
                        </tr>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <tr>
                        <td colspan="3" class="empty-state">No users found.</td>
                    </tr>
                </c:otherwise>
            </c:choose>
        </tbody>
    </table>
</div>

</body>
</html>