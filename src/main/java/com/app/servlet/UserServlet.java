package com.app.servlet;

import java.io.IOException;
import java.util.List;

import com.app.dao.UserDAO;
import com.app.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/users")
public class UserServlet extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() {
        this.userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String keyword = request.getParameter("keyword");

        if (keyword != null && !keyword.isBlank()) {

            List<User> users = userDAO.searchByUsername(keyword);
            request.setAttribute("users", users);
            request.getRequestDispatcher("/WEB-INF/views/users.jsp").forward(request, response);
            return;
        }

        String action = request.getParameter("action");

        if ("edit".equals(action)) {

            String id = request.getParameter("id");
            int userId = Integer.parseInt(id);
            User user = userDAO.findById(userId);
            request.setAttribute("user", user);
            request.getRequestDispatcher("/WEB-INF/views/user-form.jsp").forward(request, response);
            return;
        }

        String pageParameter = request.getParameter("page");

        int numberOfPage = 1;

        if (pageParameter != null) {
            numberOfPage = Integer.parseInt(pageParameter);
        }

        final int LIMIT = 3;

        int offset = (numberOfPage - 1) * LIMIT;
        int totalUsers = userDAO.countUsers();
        int totalPages = (totalUsers + LIMIT - 1) / LIMIT;
        List<User> users = userDAO.findAll(LIMIT, offset);

        request.setAttribute("users", users);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", numberOfPage);

        request.getRequestDispatcher("/WEB-INF/views/users.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String id = request.getParameter("id");

        // DELETE
        if ("delete".equals(action)) {

            HttpSession session = request.getSession();
            User loggedInUser = (User) session.getAttribute("user");
            User userDelete = userDAO.findById(Integer.parseInt(id));
            boolean deleted
                    = userDAO.delete(Integer.parseInt(id));

            if (deleted) {

                if (loggedInUser != null && loggedInUser.getId() == userDelete.getId()) {
                    response.sendRedirect(
                            request.getContextPath() + "/logout"
                    );
                    return;
                }
                response.sendRedirect(
                        request.getContextPath() + "/users"
                );
            }

            return;
        }

        // Data needed for CREATE / EDIT
        String username = request.getParameter("username");
        String email = request.getParameter("email");

        // Username Validation
        boolean nonValidUsername
                = username == null || username.isBlank();

        if (nonValidUsername) {

            request.setAttribute(
                    "error",
                    "Username is required"
            );

            request.getRequestDispatcher("/WEB-INF/views/user-form.jsp")
                    .forward(request, response);

            return;
        }

        // Email Validation
        String emailRegex
                = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$";

        boolean nonValidEmail
                = email == null
                || email.isBlank()
                || !email.matches(emailRegex);

        if (nonValidEmail) {
            request.setAttribute(
                    "error",
                    "Email is not valid"
            );

            request.getRequestDispatcher("/WEB-INF/views/user-form.jsp")
                    .forward(request, response);

            return;
        }

        // EDIT
        if ("edit".equals(action)) {

            User user = new User(username, email);
            user.setId(Integer.parseInt(id));

            boolean updated = userDAO.update(user);

            if (updated) {
                response.sendRedirect(
                        request.getContextPath() + "/users"
                );
            }

            return;
        }

    }
}
