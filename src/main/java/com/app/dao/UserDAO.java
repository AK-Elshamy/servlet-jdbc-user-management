package com.app.dao;

import com.app.model.User;
import com.app.util.DatabaseConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {


    public boolean create(User user) {

        String sql = """
                INSERT INTO users (username, email)
                VALUES (?, ?)
                """;

        try (
                Connection connection =
                        DatabaseConnection.getConnection();

                PreparedStatement statement =
                        connection.prepareStatement(sql)
        ) {

            statement.setString(1, user.getUsername());
            statement.setString(2, user.getEmail());

            return statement.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }





    }


    public List<User> findAll() {

        String sql = """
        SELECT * FROM users
        """;

        List<User> users = new ArrayList<>();

        try (
                Connection connection = DatabaseConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql);
                ResultSet resultSet = statement.executeQuery()
        ) {

            System.out.println("Database: " + connection.getCatalog());
            System.out.println("URL: " + connection.getMetaData().getURL());

            while (resultSet.next()) {

                User user = new User(
                        resultSet.getInt("id"),
                        resultSet.getString("username"),
                        resultSet.getString("email")
                );

                users.add(user);
            }

            System.out.println("Users from DB: " + users.size());

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return users;
    }

    public User findById(int id) {

        String sql = """
            SELECT * FROM users
            WHERE id = ?
            """;

        try (
                Connection connection =
                        DatabaseConnection.getConnection();

                PreparedStatement statement =
                        connection.prepareStatement(sql);


        ) {

            statement.setInt(1, id);
            ResultSet resultSet =
                    statement.executeQuery();
            if (resultSet.next()) {

                return new User(
                        resultSet.getInt("id"),
                        resultSet.getString("username"),
                        resultSet.getString("email")
                );
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    public boolean update(User user) {

        String sql = """
            UPDATE users
            SET username = ?, email = ?
            WHERE id = ?
            """;

        try (
                Connection connection =
                        DatabaseConnection.getConnection();

                PreparedStatement statement =
                        connection.prepareStatement(sql)
        ) {

            statement.setString(1, user.getUsername());
            statement.setString(2, user.getEmail());
            statement.setInt(3, user.getId());

            return statement.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    public boolean delete(int id) {

        String sql = """
            DELETE FROM users
            WHERE id = ?
            """;

        try (
                Connection connection =
                        DatabaseConnection.getConnection();

                PreparedStatement statement =
                        connection.prepareStatement(sql)
        ) {

            statement.setInt(1, id);

            return statement.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }


}