package my;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");

        // Database connection parameters
        String jdbcURL = "jdbc:mysql://localhost:3306/gayuu";
        String jdbcUsername = "root";
        String jdbcPassword = "Gayatri@28";

        // Retrieve form data
        String fullName = request.getParameter("fullName");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String email = request.getParameter("email");

        try (PrintWriter out = response.getWriter()) {
            // Check if password and confirm password match
            if (!password.equals(confirmPassword)) {
                out.println("<font color=red size=18>Passwords do not match!<br>");
                out.println("<a href=registration.jsp>Try Again!</a>");
                return;
            }

            // Establish database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection con = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword)) {
                // Insert user data into database
                String sql = "INSERT INTO users (full_name, username, password, email) VALUES (?, ?, ?, ?)";
                try (PreparedStatement ps = con.prepareStatement(sql)) {
                    ps.setString(1, fullName);
                    ps.setString(2, username);
                    ps.setString(3, password); // In production, use a secure hash instead of plain text
                    ps.setString(4, email);

                    int result = ps.executeUpdate();
                    if (result > 0) {
                        out.println("<font color=green size=18>Registration successful!<br>");
                        out.println("<a href=login.jsp>Login Here</a>");
                    } else {
                        out.println("<font color=red size=18>Registration failed! Please try again.<br>");
                        out.println("<a href=registration.jsp>Try Again!</a>");
                    }
                }
            }
        } catch (ClassNotFoundException e) {
            throw new ServletException("JDBC Driver not found!", e);
        } catch (SQLException e) {
            throw new ServletException("Database error!", e);
        }
    }
}
