package my;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    private static final String URL = "jdbc:mysql://localhost:3306/gayuu";
    private static final String USER = "root";
    private static final String PASSWORD = "Gayatri@28";
    
    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");  // Make sure you have MySQL JDBC Driver in your project
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (Exception e) {
            throw new SQLException("Failed to connect to database", e);
        }
    }
}