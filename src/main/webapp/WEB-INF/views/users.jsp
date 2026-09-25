<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Users</title>

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
            max-width: 820px;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        h1 {
            color: #1e293b;
            margin: 0;
            font-size: 22px;
            font-weight: 700;
        }

        .add-button {
            display: inline-flex;
            align-items: center;
            background: #10b981;
            color: #ffffff;
            padding: 9px 16px;
            border-radius: 6px;
            text-decoration: none;
            font-size: 14px;
            font-weight: 600;
            transition: background-color 0.2s;
        }

        .add-button:hover {
            background: #059669;
        }

        /* Search Bar */
        .search-bar {
            display: flex;
            gap: 10px;
            margin-bottom: 22px;
        }

        .search-bar input[type="text"] {
            flex: 1;
            padding: 10px 14px;
            border: 1px solid #cbd5e1;
            border-radius: 6px;
            font-size: 14px;
            color: #334155;
            outline: none;
            transition: border-color 0.2s, box-shadow 0.2s;
        }

        .search-bar input[type="text"]:focus {
            border-color: #3b82f6;
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.15);
        }

        .search-button {
            padding: 10px 18px;
            background-color: #3b82f6;
            color: #ffffff;
            border: none;
            border-radius: 6px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.2s;
        }

        .search-button:hover {
            background-color: #2563eb;
        }

        .clear-link {
            display: flex;
            align-items: center;
            padding: 0 12px;
            color: #64748b;
            text-decoration: none;
            font-size: 13px;
            border: 1px solid #cbd5e1;
            border-radius: 6px;
            background-color: #f8fafc;
        }

        .clear-link:hover {
            background-color: #e2e8f0;
            color: #1e293b;
        }

        /* Table */
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

        /* Action Buttons */
        .actions {
            display: flex;
            align-items: center;
            justify-content: flex-end;
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
            padding: 5px 12px;
            border-radius: 5px;
            font-size: 13px;
            font-weight: 600;
            transition: all 0.2s;
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
            padding: 5px 12px;
            border-radius: 5px;
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
            padding: 35px 16px;
            font-size: 14px;
        }

        /* Pagination */
        .pagination-container {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 6px;
            margin-top: 24px;
            padding-top: 16px;
            border-top: 1px solid #e2e8f0;
        }

        .page-link {
            display: inline-flex;
            justify-content: center;
            align-items: center;
            min-width: 36px;
            height: 36px;
            padding: 0 12px;
            border-radius: 6px;
            border: 1px solid #cbd5e1;
            background-color: #ffffff;
            color: #334155;
            text-decoration: none;
            font-size: 14px;
            font-weight: 600;
            transition: all 0.2s;
        }

        .page-link:hover {
            background-color: #f1f5f9;
            border-color: #94a3b8;
        }

        .page-link.active {
            background-color: #3b82f6;
            border-color: #3b82f6;
            color: #ffffff;
            pointer-events: none;
        }
    </style>
</head>
<body>

<div class="container">

    <!-- Header Section -->
    <div class="header">
        <h1>Users</h1>
        <a href="${pageContext.request.contextPath}/logout" class="add-button">+ Add User</a>
    </div>

    <!-- Search Section -->
    <form class="search-bar" method="get" action="${pageContext.request.contextPath}/users">
        <input type="text" name="keyword" value="${param.keyword}" placeholder="Search by keyword...">
        <button type="submit" class="search-button">Search</button>

        <c:if test="${not empty param.keyword}">
            <a href="${pageContext.request.contextPath}/users" class="clear-link">Clear</a>
        </c:if>
    </form>

    <!-- Table Section -->
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
                                    <div class="actions">
                                        <a class="edit-button" href="${pageContext.request.contextPath}/users?action=edit&id=${user.id}">Edit</a>

                                        <form method="post" action="${pageContext.request.contextPath}/users" onsubmit="return confirm('Are you sure you want to delete ${user.username}?');">
                                            <input type="hidden" name="action" value="delete">
                                            <input type="hidden" name="id" value="${user.id}">
                                            <button type="submit" class="delete-button">Delete</button>
                                        </form>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="4" class="empty-state">No users found.</td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>

    <!-- Pagination Section -->
    <c:if test="${totalPages > 1}">
        <div class="pagination-container">

            <c:if test="${currentPage > 1}">
                <a class="page-link"
                   href="${pageContext.request.contextPath}/users?page=${currentPage - 1}&keyword=${param.keyword}">
                    Previous
                </a>
            </c:if>

            <c:forEach begin="1" end="${totalPages}" var="page">
                <a class="page-link ${currentPage == page ? 'active' : ''}"
                   href="${pageContext.request.contextPath}/users?page=${page}&keyword=${param.keyword}">
                    ${page}
                </a>
            </c:forEach>

            <c:if test="${currentPage < totalPages}">
                <a class="page-link"
                   href="${pageContext.request.contextPath}/users?page=${currentPage + 1}&keyword=${param.keyword}">
                    Next
                </a>
            </c:if>

        </div>
    </c:if>

</div>

</body>
</html>