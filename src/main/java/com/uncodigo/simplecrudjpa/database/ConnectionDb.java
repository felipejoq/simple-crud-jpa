package com.uncodigo.simplecrudjpa.database;

import com.uncodigo.simplecrudjpa.database.providers.IEnvsProvider;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectionDb implements IEnvsProvider {

    // Connection to database implement singleton
    private static Connection connection;

    private ConnectionDb() {
    }

    public static Connection getConnection() {
        if (connection == null) {
            try {
                System.out.println("Connecting to database...");
                connection = DriverManager.getConnection(url, user, password);
            } catch (SQLException e) {
                System.out.println("Error: " + e.getMessage());
            }
        }
        return connection;
    }
}
