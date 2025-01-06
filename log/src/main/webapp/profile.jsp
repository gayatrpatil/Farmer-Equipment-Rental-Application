<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException" %>
<%@ page import="my.DBConnection" %>  <!-- Adjust to your actual package for DBConnection -->

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Profile</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .profile-container {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
            max-width: 800px;
            width: 100%;
        }

        h2 {
            text-align: center;
            color: #333;
        }

        .profile-details, .booking-history {
            margin-top: 20px;
            padding: 20px;
            background-color: #f9f9f9;
            border-radius: 4px;
        }

        .booking-history table {
            width: 100%;
            border-collapse: collapse;
        }

        .booking-history th, .booking-history td {
            padding: 8px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        .back-link {
            text-align: center;
            margin-top: 20px;
        }

        .back-link a {
            color: #007bff;
            text-decoration: none;
        }

        .back-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="profile-container">
        <h2>User Profile</h2>

        <%
            // Get the username from the session
            String username = (String) session.getAttribute("username");

            // If username is null, it means the user is not logged in
            if (username == null) {
        %>
            <p>You are not logged in. Please <a href="login.jsp">login</a> first.</p>
        <%
            } else {
                // Fetch booking details from the database
                try (Connection connection = DBConnection.getConnection()) {
                    String query = "SELECT * FROM Bookings WHERE username = ?";
                    try (PreparedStatement stmt = connection.prepareStatement(query)) {
                        stmt.setString(1, username);
                        ResultSet rs = stmt.executeQuery();

                        // Check if the user has any bookings
                        if (rs.next()) {
                            %>
                            <div class="profile-details">
                                <h3>Profile Information</h3>
                                <p><strong>USERNAME:</strong> <%= username %></p>
                            </div>

                            <div class="booking-history">
                                <h3>Booking History</h3>
                                <table>
                                    <thead>
                                        <tr>
                                            <th>Vehicle</th>
                                            <th>Pickup Date</th>
                                            <th>Return Date</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            do {
                                        %>
                                        <tr>
                                            <td><%= rs.getString("vehicle") %></td>
                                            <td><%= rs.getDate("pickup_date") %></td>
                                            <td><%= rs.getDate("return_date") %></td>
                                        </tr>
                                        <%
                                            } while (rs.next());
                                        %>
                                    </tbody>
                                </table>
                            </div>
                            <%
                        } else {
                            %>
                            <p>No bookings found.</p>
                            <%
                        }
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                    out.println("<p>Error fetching booking details: " + e.getMessage() + "</p>");
                }
            }
        %>

        <div class="back-link">
            <p><a href="index.jsp">Go Back to Homepage</a></p>
        </div>
    </div>
</body>
</html>
