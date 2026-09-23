package com.app.servlet;

import com.app.dao.UserDAO;
import com.app.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/users")
public class UserServlet extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init(){
        this.userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

       String action = request.getParameter("action");
       if("new".equals(action)){
           request.getRequestDispatcher("/user-form.jsp").forward(request, response);
           return;
       }


        if ("edit".equals(action)) {

            String id = request.getParameter("id");
            int userId = Integer.parseInt(id);
            User user = userDAO.findById(userId);
            request.setAttribute("user", user);
            request.getRequestDispatcher("/user-form.jsp").forward(request, response);
            return;
        }

        List<User> users = userDAO.findAll();
        request.setAttribute("users", users);
        request.getRequestDispatcher("/users.jsp").forward(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String id = request.getParameter("id");


        // DELETE
        if ("delete".equals(action)) {

            boolean deleted =
                    userDAO.delete(Integer.parseInt(id));

            if (deleted) {
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
        boolean nonValidUsername =
                username == null || username.isBlank();

        if (nonValidUsername) {

            request.setAttribute(
                    "error",
                    "Username is required"
            );

            request.getRequestDispatcher("/user-form.jsp")
                    .forward(request, response);

            return;
        }


        // Email Validation
        String emailRegex =
                "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$";

        boolean nonValidEmail =
                email == null
                        || email.isBlank()
                        || !email.matches(emailRegex);

        if (nonValidEmail) {
            request.setAttribute(
                    "error",
                    "Email is not valid"
            );

            request.getRequestDispatcher("/user-form.jsp")
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


        // CREATE
        if ("create".equals(action)) {

            User user = new User(username, email);

            boolean created = userDAO.create(user);

            if (created) {
                response.sendRedirect(
                        request.getContextPath() + "/users"
                );
            }
        }
    }
}
