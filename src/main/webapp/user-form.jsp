<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>User Form</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f4f6f8;
            margin: 0;
            padding: 40px;
        }

        .card {
            width: 450px;
            margin: auto;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }

        h1 {
            text-align: center;
            margin-bottom: 25px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
        }

        input {
            width: 100%;
            padding: 10px;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        button {
            width: 100%;
            padding: 12px;
            border: none;
            border-radius: 5px;
            background: #007bff;
            color: white;
            font-size: 16px;
            cursor: pointer;
        }

        button:hover {
            background: #0056b3;
        }
    </style>
</head>

<body>

    <div>
        <c:if test="${not empty error}">
            <p>${error}</p>
        </c:if>
    </div>
<div class="card">

    <!-- Title -->
    <c:choose>

        <c:when test="${not empty user}">
            <h1>Edit User</h1>
        </c:when>

        <c:otherwise>
            <h1>Add User</h1>
        </c:otherwise>

    </c:choose>


    <!-- Form -->
    <form method="post"
          action="${pageContext.request.contextPath}/users">


        <!-- Tell Servlet what operation we want -->
        <c:choose>

            <c:when test="${not empty user}">
                <input type="hidden"
                       name="action"
                       value="edit">
            </c:when>

            <c:otherwise>
                <input type="hidden"
                       name="action"
                       value="create">
            </c:otherwise>

        </c:choose>


        <!-- User ID -->
        <input type="hidden"
               name="id"
               value="${user.id}">


        <!-- Username -->
        <div class="form-group">

            <label for="username">
                Username
            </label>

            <input
                    type="text"
                    id="username"
                    name="username"
                    placeholder="Enter username"
                    value="${user.username}"
                    required>

        </div>


        <!-- Email -->
        <div class="form-group">

            <label for="email">
                Email
            </label>

            <input
                    type="email"
                    id="email"
                    name="email"
                    placeholder="name@example.com"
                    value="${user.email}"
                    required>

        </div>


        <!-- Submit Button -->
        <c:choose>

            <c:when test="${not empty user}">
                <button type="submit">
                    Update User
                </button>
            </c:when>

            <c:otherwise>
                <button type="submit">
                    Add User
                </button>
            </c:otherwise>

        </c:choose>

    </form>


</div>

</body>
</html>