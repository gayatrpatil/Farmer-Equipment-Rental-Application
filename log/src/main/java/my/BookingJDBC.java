package my;

import java.sql.*;

public class BookingJDBC {

    public static void main(String[] args) {
        try {
            // Load the MySQL JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Database connection details
            String url = "jdbc:mysql://localhost:3306/gayuu";
            String username = "root";
            String password = "Gayatri@28";

            // Establishing the connection
            Connection con = DriverManager.getConnection(url, username, password);

            // SQL query to create a table in a single line
            String q = "CREATE TABLE Bookings (\r\n"
            		+ "    id INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for each booking\r\n"
            		+ "    username VARCHAR(50),             -- Username of the user making the booking\r\n"
            		+ "    name VARCHAR(100),                -- Full name of the user\r\n"
            		+ "    email VARCHAR(100),               -- Email address of the user\r\n"
            		+ "    vehicle VARCHAR(50),              -- Type of vehicle booked\r\n"
            		+ "    pickup_date DATE,                 -- Date when the vehicle is picked up\r\n"
            		+ "    return_date DATE                  -- Date when the vehicle is returned\r\n"
            		+ ");\r\n"
            		+ "";

            // Creating a Statement object to execute the query
            Statement st = con.createStatement();

            // Executing the SQL query
            st.executeUpdate(q);
            System.out.println("Table created");

            // Closing the connection
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}