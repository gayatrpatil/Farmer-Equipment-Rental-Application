package my;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

@WebServlet("/rental")
public class AddJva extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        // Initialize session and cart
        HttpSession mySession = request.getSession();
        ArrayList<String> cart = (ArrayList<String>) mySession.getAttribute("cart");

        // If the cart is null, initialize it
        if (cart == null) {
            cart = new ArrayList<>();
            mySession.setAttribute("cart", cart);
        }

        // Add the equipment to the cart if the request contains a "name" parameter
        String equipment = request.getParameter("name");
        if (equipment != null && !equipment.isEmpty()) {
            cart.add(equipment);
        }

        // Check if the request is to remove an item
        String action = request.getParameter("action");
        if ("remove".equals(action) && equipment != null) {
            cart.remove(equipment);
        }

        // HTML structure starts here
        out.println("<!DOCTYPE html>");
        out.println("<html lang='en'>");
        out.println("<head>");
        out.println("    <meta charset='UTF-8'>");
        out.println("    <title>Rental Application</title>");
        out.println("    <style>");
        out.println("        body { font-family: Arial, sans-serif; background-color: #f7f7f7; margin: 0; padding: 0; }");
        out.println("        .container { width: 80%; margin: 20px auto; background-color: white; padding: 20px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); }");
        out.println("        h3 { text-align: center; margin-bottom: 20px; }");
        out.println("        .row { display: flex; justify-content: space-around; flex-wrap: wrap; }");
        out.println("        .card { border: 1px solid #ddd; border-radius: 5px; padding: 10px; margin: 10px; text-align: center; width: 150px; }");
        out.println("        .card img { width: 100%; height: 200px; border-radius: 5px; }");
        out.println("        .btn { padding: 5px 10px; margin-top: 5px; color: white; border: none; cursor: pointer; }");
        out.println("        .btn-danger { background-color: red; }");
        out.println("        .btn-success { background-color: green; }");
        out.println("        .cart-item { display: flex; justify-content: space-between; margin-bottom: 10px; padding: 10px; background-color: #f9f9f9; border: 1px solid #ddd; }");
        out.println("        .checkout-btn { display: block; width: 100%; padding: 10px; background-color: blue; color: white; border: none; cursor: pointer; text-align: center; margin-top: 20px; }");
        out.println("    </style>");
        out.println("</head>");
        out.println("<body>");
        out.println("    <div class='container'>");
        out.println("        <h3>Booking Equipments</h3>");
        out.println("        <div class='row'>");

        // List of equipment (You can replace this with dynamic data from a database)
        String[][] equipmentList = {
            {"Tractor 1", "img/eq6.jpg", "10000"},
            {"Tractor 2", "img/eq1.jpg", "10000"},
            {"Tractor 3", "img/eq8.jpg", "10000"},
            {"Tractor 4", "img/eq9.jpg", "10000"},
            {"Tractor 5", "img/eq3.jpg", "10000"},
            {"Tractor 6", "img/Eq2.jpg", "10000"},
            {"Tractor 7", "img/gh8.jpg", "10000"},
            {"Tractor 8", "img/gh1.jpg", "10000"}
        };

        // Display equipment cards
        for (String[] item : equipmentList) {
            out.println("            <div class='card'>");
            out.println("                <img src='" + item[1] + "' alt='" + item[0] + "'>");
            out.println("                <p>" + item[0] + "</p>");
            out.println("                <p>Price: " + item[2] + "</p>");
            out.println("                <a href='?name=" + item[0] + "' class='btn btn-danger'>Add to Cart</a>");
            out.println("                <a href='booking.jsp' class='btn btn-success'>Book</a>");
            out.println("            </div>");
        }

        out.println("        </div>");

        out.println("        <h3>Your Cart</h3>");
        // Display the cart items
        if (cart.size() > 0) {
            for (String item : cart) {
                out.println("            <div class='cart-item'>");
                out.println("                <p>" + item + "</p>");
                out.println("                <a href='?action=remove&name=" + item + "' class='btn btn-danger'>Remove</a>");
                out.println("            </div>");
            }
        } else {
            out.println("            <p>Your cart is empty!</p>");
        }

        out.println("        <button class='checkout-btn'>Proceed to Checkout</button>");
        out.println("    </div>");
        out.println("</body>");
        out.println("</html>");
    }
}
