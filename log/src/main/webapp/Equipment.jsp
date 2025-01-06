<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="jakarta.servlet.http.HttpSession"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Rental Application</title>
    <%@include file="Compo/css.jsp"%>
    <style type="text/css">
        /* Add your custom styles if needed */
        .card img {
            width: 100%; /* Full width of the card */
            height: 250px; /* Adjust the height as needed */
            object-fit: cover; /* Make sure the image covers the space without distortion */
        }
    </style>
</head>
<body style="background-color: #f7f7f7;">
    <%@include file="Compo/nav.jsp"%>

    <div class="container-fluid back-img">
    </div>
    
    <div class="container text-center">
        <h3>Booking Equipments</h3>
        <div class="row">
            <%
                // Initialize session and cart
                HttpSession mySession = request.getSession();
                ArrayList<String> cart = (ArrayList<String>) mySession.getAttribute("cart");

                // If the cart is null, initialize it
                if (cart == null) {
                    cart = new ArrayList<>();
                    mySession.setAttribute("cart", cart);
                }

                // List of equipment
                String[][] equipmentList = {
                    {"img/cultivater.jpg", "Cultivater", "1000/hr"},
                    {"img/harvester.jpg", "Harvester", "1500/hr"},
                    {"img/JCB.jpg", "JCB", "1000/hr"},
                    {"img/plough.jpg", "Plough", "1000/hr"},
                    {"img/rotavator.jpg", "Rotavator", "1500/hr"},
                    {"img/spreyyr.jpg", "Spreyer", "500/hr"},
                    {"img/Tractor.jpg", "Tractor", "5000/hr"},
                    {"img/traler.jpg", "Traler", "2000/hr"}
                };

                // Loop through equipment list and display each item
                for (String[] item : equipmentList) {
            %>
            <div class="col-md-3">
                <div class="card crd-ho">
                    <div class="card-body text-center">
                        <!-- Display the full image -->
                        <img alt="<%= item[1] %>" src="<%= item[0] %>" class="img-thumbnail">

                        <p><strong><%= item[1] %></strong></p>
                        <p>HP</p>
                        <div class="row text-center">
                            <a href="cart.jsp?name=<%= item[1] %>" class="btn btn-danger btn-sm">Add Cart</a>
                            <a href="booking.jsp" class="btn btn-success btn-sm ml-1">Book</a>
                            <a href="#" class="btn btn-danger btn-sm ml-1 disabled"><%= item[2] %></a>
                        </div>
                    </div>
                </div>
            </div>
            <%
                }
            %>
        </div>
    </div>

    <%@include file="Compo/footer.jsp" %>
</body>
</html>
