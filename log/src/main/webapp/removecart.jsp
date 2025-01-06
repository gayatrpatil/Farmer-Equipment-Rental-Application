<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Your Cart</title>
    <%@include file="Compo/css.jsp"%>
    <style>
        body {
            background-color: #f7f7f7;
            font-family: Arial, sans-serif;
        }
        .container {
            width: 80%;
            margin: auto;
            background-color: white;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h3 {
            text-align: center;
            margin-bottom: 20px;
        }
        .item {
            border-bottom: 1px solid #ddd;
            padding: 10px 0;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        .item img {
            width: 100px;
            height: 100px;
            object-fit: cover;
            margin-right: 20px;
        }
        .btn {
            padding: 5px 10px;
            margin-top: 5px;
            color: white;
            border: none;
            cursor: pointer;
        }
        .btn-danger {
            background-color: red;
        }
        .btn-success {
            background-color: green;
        }
        .price {
            font-weight: bold;
        }
    </style>
</head>
<body>
    <%@include file="Compo/nav.jsp"%>

    <div class="container">
        <h3>Your Cart</h3>
        <%
            // Retrieve the cart from session
            ArrayList<String[]> cart = (ArrayList<String[]>) session.getAttribute("cart");

            if (cart == null) {
                cart = new ArrayList<>();
            }

            // Handle item removal
            String itemIndexParam = request.getParameter("removeItemIndex");
            if (itemIndexParam != null) {
                try {
                    int itemIndex = Integer.parseInt(itemIndexParam);
                    if (itemIndex >= 0 && itemIndex < cart.size()) {
                        cart.remove(itemIndex); // Remove the item from the cart
                    }
                } catch (NumberFormatException e) {
                    // Handle invalid item index
                }
                session.setAttribute("cart", cart); // Update the cart in session after removal
            }

            // Handle item addition
            String itemName = request.getParameter("itemName");
            String itemPrice = request.getParameter("itemPrice");
            String itemImage = request.getParameter("itemImage");

            if (itemName != null && itemPrice != null) {
                cart.add(new String[] {itemName, itemPrice, itemImage != null ? itemImage : ""});
                session.setAttribute("cart", cart); // Update session with new cart item
            }

            // Display the cart items or a message if it's empty
            if (cart.isEmpty()) {
        %>
            <p>Your cart is empty.</p>
        <%
            } else {
                for (int i = 0; i < cart.size(); i++) {
                    String[] item = cart.get(i);
        %>
            <div class="item">
                <%
                    if (item.length == 3 && item[2] != null && !item[2].isEmpty()) {
                %>
                    <img src="<%= item[2] %>" alt="<%= item[0] %>">
                <%
                    }
                %>
                <div>
                    <p>Item: <%= item[0] %></p>
                    <p class="price">Price: <%= item[1] %></p>
                </div>
                <!-- Remove button -->
                <form action="" method="post"> <!-- Submit to the same page -->
                    <input type="hidden" name="removeItemIndex" value="<%= i %>"> <!-- Pass item index -->
                    <button type="submit" class="btn btn-danger">Remove</button>
                </form>
            </div>
        <%
                }
            }
        %>
        <div class="text-center">
            <a href="booking.jsp" class="btn btn-success">Proceed to Booking</a>
        </div>
    </div>
    
    <%@include file="Compo/footer.jsp" %>
</body>
</html>
