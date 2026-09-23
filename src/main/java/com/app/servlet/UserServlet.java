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

        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String id = request.getParameter("id");
        User user = new User(username, email);
        if(id == null) {
            boolean created = userDAO.create(user);

            if (created) {
                response.sendRedirect(
                        request.getContextPath() + "/users"
                );
            }
        }else{
            user.setId(Integer.parseInt(id));
            boolean updated = userDAO.update(user);

            if (updated) {
                response.sendRedirect(
                        request.getContextPath() + "/users"
                );
            }
        }
    }
}
