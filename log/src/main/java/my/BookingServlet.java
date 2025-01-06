package my;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/Booking")
public class BookingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Validate session
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Retrieve session and form data
        String username = (String) session.getAttribute("username");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String vehicle = request.getParameter("vehicle");
        String pickupDate = request.getParameter("pickupDate");
        String returnDate = request.getParameter("returnDate");

        // Save booking details to the database
        try (Connection connection = DBConnection.getConnection()) {
            String query = "INSERT INTO Bookings (username, name, email, vehicle, pickup_date, return_date) VALUES (?, ?, ?, ?, ?, ?)";
            try (PreparedStatement stmt = connection.prepareStatement(query)) {
                stmt.setString(1, username);
                stmt.setString(2, name);
                stmt.setString(3, email);
                stmt.setString(4, vehicle);
                stmt.setString(5, pickupDate);
                stmt.setString(6, returnDate);
                stmt.executeUpdate();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("<p>Error saving booking details to the database.</p>");
            return;
        }

        // Display booking confirmation
        response.setContentType("text/html");
        response.getWriter().println("<!DOCTYPE html>");
        response.getWriter().println("<html>");
        response.getWriter().println("<head><title>Booking Confirmation</title></head>");
        response.getWriter().println("<body>");
        response.getWriter().println("<h2>Booking Confirmed!</h2>");
        response.getWriter().println("<p>Thank you, <strong>" + name + "</strong>!</p>");
        response.getWriter().println("<p>Your booking for a <strong>" + vehicle + "</strong> has been confirmed.</p>");
        response.getWriter().println("<p>Pickup Date: " + pickupDate + "</p>");
        response.getWriter().println("<p>Return Date: " + returnDate + "</p>");
        response.getWriter().println("<p>A confirmation email has been sent to: <strong>" + email + "</strong>.</p>");
        response.getWriter().println("<a href='index.jsp'>Go back to homepage</a>");
        response.getWriter().println("</body>");
        response.getWriter().println("</html>");
    }
}
