package com.app.servlet;

import java.io.IOException;

import org.mindrot.jbcrypt.BCrypt;

import com.app.dao.UserDAO;
import com.app.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Username validation
        if (username == null || username.trim().length() < 4) {
            request.setAttribute(
                    "error",
                    "Username must be at least 4 characters long."
            );

            request.getRequestDispatcher("/WEB-INF/views/register.jsp")
                    .forward(request, response);

            return;
        }

        // Email validation
        String emailRegex
                = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$";

        if (email == null || !email.trim().matches(emailRegex)) {
            request.setAttribute(
                    "error",
                    "Please enter a valid email address."
            );

            request.getRequestDispatcher("/WEB-INF/views/register.jsp")
                    .forward(request, response);

            return;
        }

        // Password validation
        String passwordRegex
                = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[@$!%*#?&])"
                + "[A-Za-z\\d@$!%*#?&]{8,}$";

        if (password == null || !password.matches(passwordRegex)) {
            request.setAttribute(
                    "error",
                    "Password must be at least 8 characters "
                    + "and include a number and special character."
            );

            request.getRequestDispatcher("/WEB-INF/views/register.jsp")
                    .forward(request, response);

            return;
        }

        User foundUser = userDAO.findByUsername(username);
        if (foundUser != null) {
            request.setAttribute(
                    "error",
                    "Username already exists. Please choose another."
            );

            request.getRequestDispatcher("/WEB-INF/views/register.jsp")
                    .forward(request, response);

            return;
        }
        foundUser = userDAO.findByEmail(email);
        if (foundUser != null) {
            request.setAttribute(
                    "error",
                    "Email already registered. Please use another."
            );

            request.getRequestDispatcher("/WEB-INF/views/register.jsp")
                    .forward(request, response);

            return;
        }

        password = BCrypt.hashpw(password, BCrypt.gensalt());

        User user = new User(username, email, password);

        boolean created = userDAO.create(user);

        if (!created) {
            request.setAttribute(
                    "error",
                    "Registration failed."
            );

            request.getRequestDispatcher("/WEB-INF/views/register.jsp")
                    .forward(request, response);

            return;
        }

        response.sendRedirect(
                request.getContextPath() + "/login"
        );
    }
}
