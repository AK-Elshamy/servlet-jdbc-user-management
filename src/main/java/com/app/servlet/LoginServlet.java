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
import jakarta.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("/WEB-INF/views/login.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (username == null || username.isBlank()
                || password == null || password.isBlank()) {

            request.setAttribute(
                    "error",
                    "Username and password are required."
            );

            request.getRequestDispatcher("/WEB-INF/views/login.jsp")
                    .forward(request, response);

            return;
        }

        User user
                = userDAO.findByUsername(username);

        if (user == null) {

            request.setAttribute(
                    "error",
                    "Invalid username or password."
            );

            request.getRequestDispatcher("/WEB-INF/views/login.jsp")
                    .forward(request, response);

            return;
        }

        if (!BCrypt.checkpw(password, user.getPassword())) {

            request.setAttribute(
                    "error",
                    "Invalid username or password."
            );

            request.getRequestDispatcher("/WEB-INF/views/login.jsp")
                    .forward(request, response);

            return;
        }

        HttpSession session = request.getSession();

        session.setAttribute("user", user);

        response.sendRedirect(
                request.getContextPath() + "/users"
        );
    }
}
