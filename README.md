# Servlet JDBC User Management

A simple User Management web application built with Java Servlets, JSP, JDBC, and MySQL.

## Features

- User Registration
- User Login / Logout
- BCrypt Password Hashing
- Authentication Filter
- User CRUD
- Search Users
- Pagination
- Form Validation
- MVC Architecture
- DAO Pattern
- MySQL Database

## Technologies

- Java 25
- Jakarta Servlet 6
- JSP
- JSTL
- JDBC
- MySQL
- Maven
- Tomcat 10.1
- BCrypt

## Project Structure

```text
src/main/java/com/app/
├── dao/
├── filter/
├── model/
├── servlet/
└── util/

src/main/webapp/
└── WEB-INF/
    └── views/
````

## Database

Database:

```text
servlet_jdbc_app
```

Table:

```text
users
```

The `users` table contains:

* `id`
* `username`
* `email`
* `password`

Passwords are stored using BCrypt hashing.

## Main Endpoints

| Method | Endpoint    | Description       |
| ------ | ----------- | ----------------- |
| GET    | `/register` | Registration page |
| POST   | `/register` | Create account    |
| GET    | `/login`    | Login page        |
| POST   | `/login`    | Authenticate user |
| GET    | `/logout`   | Logout            |
| GET    | `/users`    | View users        |
| POST   | `/users`    | Edit/Delete users |

## How to Run

1. Create the MySQL database and `users` table.
2. Configure the database connection in `DatabaseConnection.java`.
3. Build the project:

```bash
mvn clean package
```

4. Deploy the generated WAR file to Tomcat.
5. Open:

```text
http://localhost:8080/jdbc-servlet-app
```

## Architecture

```text
Browser
   ↓
Servlet
   ↓
DAO
   ↓
JDBC
   ↓
MySQL
```

For authentication:

```text
Login
   ↓
UserDAO
   ↓
BCrypt verification
   ↓
HttpSession
   ↓
AuthenticationFilter
   ↓
Protected Resources
```

## Purpose

This project was built to practice Java Servlets and JDBC before moving to Spring Boot.

---