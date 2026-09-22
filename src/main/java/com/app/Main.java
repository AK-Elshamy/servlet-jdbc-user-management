package com.app;

import com.app.util.DatabaseConnection;

import java.sql.Connection;

public class Main {
    static void main(String[] args) {
        try (
                Connection connection = DatabaseConnection.getConnection();
                ){
            System.out.println("DataBase Connected");
        } catch (Exception e){
            e.printStackTrace();
        }
    }
}
