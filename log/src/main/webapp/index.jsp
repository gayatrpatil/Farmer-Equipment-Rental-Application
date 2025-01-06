<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Agricart</title>
    <%@include file="Compo/css.jsp" %>
    <style>
        /* Fullscreen animated background */
        .back-img {
            position: relative; /* Ensure content inside can be positioned relative to the container */
            height: 90vh; /* Full viewport height */
            width: 100%; /* Full width */
            background-image: url('img/plough.jpg');
            background-position: center; /* Center the background image */
            background-size: cover; /* Ensure the image covers the container */
            background-repeat: no-repeat; /* Prevent tiling */
            animation: slide 80s infinite; /* Infinite animation */
        }

        /* Add a subtle blur effect to the background */
        .back-img::after {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: inherit; /* Inherit background from parent */
            filter: blur(3px); /* Apply subtle blur effect */
            z-index: 1; /* Make sure background blur is behind content */
        }

        /* Welcome message */
        .welcome-message {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            color: white;
            font-size: 2.5rem;
            font-weight: bold;
            text-shadow: 2px 2px 5px rgba(0, 0, 0, 0.7); /* Add shadow to make text more visible */
            z-index: 2; /* Make sure the message is above the blurred background */
        }

        /* Content Section */
        .content {
            position: relative;
            z-index: 2; /* Ensure content is above the blurred background */
            background-color: rgba(255, 255, 255, 0.7); /* Semi-transparent white background */
            padding: 20px;
            border-radius: 10px;
        }

        /* Hover effect for cards */
        .crd-ho:hover {
            background: #f7f7f7;
        }

        /* Card image styling */
        .card img {
            width: 100%;
            height: 250px;
            object-fit: cover;
            transition: transform 0.3s ease;
        }

        .card:hover img {
            transform: scale(1.1);
        }

        /* Button styling */
        .btn {
            cursor: pointer;
            transition: opacity 0.3s ease;
        }

        .btn-danger {
            background-color: #dc3545;
            border: none;
        }

        .btn-success {
            background-color: #28a745;
            border: none;
        }

        .btn:hover {
            opacity: 0.8;
        }

        .btn-margin {
            margin-left: 5px;
        }

        .card-body p {
            margin: 5px 0;
        }
    </style>
</head>
<body style="background-color: #f7f7f7;">
    <%@include file="Compo/nav.jsp" %>

    <!-- Background image with blur and welcome message -->
    <div class="container-fluid back-img">
        <div class="welcome-message">
            Welcome to Agricart Rental Website
        </div>
    </div>

    <!-- Equipment Booking Section -->
    <div class="container text-center content">
        <h3>Equipment Booking</h3>
        <div class="row">
            <%
                String[][] equipment = {
                    {"img/cultivater.jpg", "Cultivater", "1000/hr"},
                    {"img/harvester.jpg", "Harvester", "1500/hr"},
                    {"img/JCB.jpg", "JCB", "1000/hr"},
                    {"img/plough.jpg", "Plough", "1000/hr"},
                    {"img/rotavator.jpg", "Rotavator", "1500/hr"},
                    {"img/spreyyr.jpg", "Sprayer", "500/hr"},
                    {"img/Tractor.jpg", "Tractor", "5000/hr"},
                    {"img/traler.jpg", "Trailer", "2000/hr"}
                };

                for (int i = 0; i < equipment.length; i++) {
            %>
            <div class="col-md-3">
                <div class="card crd-ho">
                    <div class="card-body">
                        <img alt="<%= equipment[i][1] %>" src="<%= equipment[i][0] %>" class="img-thumbnail">
                        <p><strong><%= equipment[i][1] %></strong></p>
                        
                        <div class="row text-center">
                            <!-- Add to Cart Form -->
                            <form action="cart.jsp" method="post" style="display: inline;">
                                <input type="hidden" name="itemName" value="<%= equipment[i][1] %>">
                                <input type="hidden" name="itemPrice" value="<%= equipment[i][2] %>">
                                <input type="hidden" name="itemImage" value="<%= equipment[i][0] %>">
                                <button type="submit" class="btn btn-danger btn-sm">Add to Cart</button>
                            </form>
                            <!-- Book and Price Buttons -->
                            <a href="booking.jsp" class="btn btn-success btn-sm btn-margin">Book</a>
                            <span class="btn btn-danger btn-sm btn-margin disabled"><%= equipment[i][2] %></span>
                        </div>
                    </div>
                </div>
            </div>
            <% } %>
        </div>
    </div>

    <%@include file="Compo/footer.jsp" %>
</body>
</html>
