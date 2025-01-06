package my;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class LoginServlet extends HttpServlet {
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
        String username = request.getParameter("txtName");
        String password = request.getParameter("txtPwd");

        try (PrintWriter out = response.getWriter()) {
            // Validate input
            if (username == null || username.isEmpty() || password == null || password.isEmpty()) {
                out.println("<font color=red size=18>Invalid username or password!<br>");
                out.println("<a href=login.jsp>Try Again!</a>");
                return;
            }

            // Establish database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection con = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword)) {
                // Query the database for the user
                String sql = "SELECT username FROM users WHERE username = ? AND password = ?";
                try (PreparedStatement ps = con.prepareStatement(sql)) {
                    ps.setString(1, username);
                    ps.setString(2, password); // In production, compare hashed passwords

                    try (ResultSet rs = ps.executeQuery()) {
                        if (rs.next()) {
                            // Successful login
                            // Store the username in the session
                            HttpSession session = request.getSession();
                            session.setAttribute("username", username);

                            // Redirect to profile page
                            response.sendRedirect("index.jsp");
                        } else {
                            // Failed login
                            out.println("<font color=red size=18>Login Failed! Invalid credentials.<br>");
                            out.println("<a href=login.jsp>Try Again!</a>");
                        }
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
