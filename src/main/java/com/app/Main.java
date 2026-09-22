package com.app;

import com.app.dao.UserDAO;
import com.app.model.User;

import java.util.List;

public class Main {

    public static void main(String[] args) {



        UserDAO userDAO = new UserDAO();

        List<User> users = userDAO.findAll();

        for (User user : users) {
            System.out.println(
                    user.getId() + " | " +
                            user.getUsername() + " | " +
                            user.getEmail()
            );
        }
    }
}
