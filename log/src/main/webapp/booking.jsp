<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    if (session == null || session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Vehicle Booking</title>
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

        .booking-container {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
            max-width: 500px;
            width: 100%;
        }

        h2 {
            text-align: center;
            color: #333;
        }

        form {
            display: flex;
            flex-direction: column;
        }

        label {
            margin-bottom: 8px;
            font-weight: bold;
        }

        input, select {
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        input[type="submit"] {
            background-color: #28a745;
            color: #fff;
            border: none;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #218838;
        }

        .register-link {
            text-align: center;
            margin-top: 20px;
        }

        .register-link a {
            color: #007bff;
            text-decoration: none;
        }

        .register-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="booking-container">
        <h2>Book a Vehicle</h2>
        <form action="BookingServlet" method="post">
            <label for="name">Name:</label>
            <input type="text" id="name" name="name" required>
            
            <label for="email">Email Address:</label>
            <input type="email" id="email" name="email" required>
            
            <label for="vehicle">Vehicle Type:</label>
            <select id="vehicle" name="vehicle" required>
                <option value="Cultivater">Cultivater</option>
                <option value="Harvester">Harvester</option>
                <option value="Plough">Plough</option>
                <option value="Rotavator">Rotavator</option>
                <option value="Spreyyr">Spreyyr</option>
                <option value="Tractor">Tractor</option>
                <option value="Traler">Traler</option>
            </select>
            
            <label for="pickupDate">Pickup Date:</label>
            <input type="date" id="pickupDate" name="pickupDate" required>
            
            <label for="returnDate">Return Date:</label>
            <input type="date" id="returnDate" name="returnDate" required>

            <label for="within50km">Booking within 50km:</label>
            <select id="within50km" name="within50km" required>
                <option value="yes">Yes</option>
                <option value="no">No</option>
            </select>
            
            <input type="submit" value="Book Now">
        </form>
        <div class="register-link">
            <p>Don't have an account? <a href="Register.jsp">Register here</a></p>
        </div>
    </div>
</body>
</html>
