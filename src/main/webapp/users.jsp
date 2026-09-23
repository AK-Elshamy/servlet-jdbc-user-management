<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Users Management</title>

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f6f9;
            margin: 0;
            padding: 40px 20px;
            display: flex;
            justify-content: center;
        }

        .container {
            background: #ffffff;
            padding: 28px 32px;
            border-radius: 12px;
            box-shadow: 0 4px 16px rgba(0, 0, 0, 0.06);
            width: 100%;
            max-width: 800px;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 24px;
            padding-bottom: 16px;
            border-bottom: 1px solid #e2e8f0;
        }

        .header-title-group {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        h1 {
            color: #1e293b;
            margin: 0;
            font-size: 22px;
            font-weight: 700;
        }

        .user-count {
            background-color: #eff6ff;
            color: #2563eb;
            padding: 3px 10px;
            border-radius: 9999px;
            font-size: 12px;
            font-weight: 600;
        }

        .add-button {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            background: #10b981;
            color: #ffffff;
            padding: 9px 16px;
            border-radius: 6px;
            text-decoration: none;
            font-size: 14px;
            font-weight: 600;
            transition: background-color 0.2s, transform 0.1s;
        }

        .add-button:hover {
            background: #059669;
        }

        .add-button:active {
            transform: scale(0.98);
        }

        .table-responsive {
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            text-align: left;
        }

        th {
            background-color: #f8fafc;
            color: #64748b;
            padding: 12px 16px;
            font-size: 12px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            font-weight: 600;
            border-bottom: 1px solid #e2e8f0;
        }

        td {
            padding: 14px 16px;
            border-bottom: 1px solid #f1f5f9;
            color: #334155;
            font-size: 14px;
            vertical-align: middle;
        }

        tr:last-child td {
            border-bottom: none;
        }

        tbody tr:hover {
            background-color: #f8fafc;
        }

        .badge-id {
            color: #94a3b8;
            font-family: monospace;
            font-weight: bold;
        }

        .username {
            font-weight: 600;
            color: #0f172a;
        }

        .email {
            color: #64748b;
        }

        .actions {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .actions form {
            margin: 0;
            display: inline;
        }

        .edit-button {
            text-decoration: none;
            background-color: #eff6ff;
            color: #2563eb;
            border: 1px solid #bfdbfe;
            padding: 6px 12px;
            border-radius: 6px;
            font-size: 13px;
            font-weight: 600;
            transition: all 0.2s;
            display: inline-block;
        }

        .edit-button:hover {
            background-color: #2563eb;
            color: #ffffff;
            border-color: #2563eb;
        }

        .delete-button {
            background-color: #fef2f2;
            color: #dc2626;
            border: 1px solid #fecaca;
            padding: 6px 12px;
            border-radius: 6px;
            font-size: 13px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s;
        }

        .delete-button:hover {
            background-color: #dc2626;
            color: #ffffff;
            border-color: #dc2626;
        }

        .empty-state {
            text-align: center;
            color: #94a3b8;
            padding: 40px 16px;
            font-size: 14px;
        }
    </style>
</head>

<body>

<div class="container">

    <!-- Consolidated Single Header -->
    <div class="header">
        <div class="header-title-group">
            <h1>Users</h1>
            <span class="user-count">${not empty users ? users.size() : 0} Total</span>
        </div>

        <a href="${pageContext.request.contextPath}/users?action=new" class="add-button">
            + Add User
        </a>
    </div>

    <!-- Table -->
    <div class="table-responsive">
        <table>
            <thead>
                <tr>
                    <th style="width: 70px;">ID</th>
                    <th>Username</th>
                    <th>Email</th>
                    <th style="width: 140px; text-align: right;">Actions</th>
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
                                <td>
                                    <div class="actions" style="justify-content: flex-end;">
                                        <!-- Edit -->
                                        <a class="edit-button"
                                           href="${pageContext.request.contextPath}/users?action=edit&id=${user.id}">
                                            Edit
                                        </a>

                                        <!-- Delete -->
                                        <form method="post"
                                              action="${pageContext.request.contextPath}/users"
                                              onsubmit="return confirm('Are you sure you want to delete user: ${user.username}?');">
                                            <input type="hidden" name="action" value="delete">
                                            <input type="hidden" name="id" value="${user.id}">
                                            <button type="submit" class="delete-button">
                                                Delete
                                            </button>
                                        </form>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>

                    <c:otherwise>
                        <tr>
                            <td colspan="4" class="empty-state">
                                No users found in database.
                            </td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>

</div>

</body>
</html>