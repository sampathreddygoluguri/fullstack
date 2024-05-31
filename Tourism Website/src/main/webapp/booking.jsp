<%@ page import ="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Booking Confirmation</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        .container {
            max-width: 600px;
            margin: 50px auto;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h2 {
            color: #4CAF50;
        }
        p {
            font-size: 18px;
        }
        .button {
            display: inline-block;
            padding: 10px 20px;
            margin-top: 20px;
            font-size: 16px;
            color: #fff;
            background-color: #4CAF50;
            border: none;
            border-radius: 5px;
            text-decoration: none;
            cursor: pointer;
        }
        .button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <div class="container">
        <%
            // Retrieve form data
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String guestsStr = request.getParameter("Guests");
            String departureDate = request.getParameter("departure-date");
            String returnDate = request.getParameter("return-date");

            // Validate input
            if (name == null || email == null || guestsStr == null || departureDate == null || returnDate == null ||
                name.isEmpty() || email.isEmpty() || guestsStr.isEmpty() || departureDate.isEmpty() || returnDate.isEmpty()) {
                out.println("All fields are required. <a href='tour.jsp'>Try again</a>");
                return;
            }

            int guests;
            try {
                guests = Integer.parseInt(guestsStr);
            } catch (NumberFormatException e) {
                out.println("Invalid number of guests. <a href='tour.jsp'>Try again</a>");
                return;
            }

            Connection con = null;
            PreparedStatement pstmt = null;

            try {
                // Load the MySQL JDBC driver
                Class.forName("com.mysql.cj.jdbc.Driver");

                // Establish a connection to the database
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/tourism", "root", "root");

                // Insert booking data into the database
                String query = "INSERT INTO bookings (name, email, guests, departure_date, return_date) VALUES (?, ?, ?, ?, ?)";
                pstmt = con.prepareStatement(query);
                pstmt.setString(1, name);
                pstmt.setString(2, email);
                pstmt.setInt(3, guests);
                pstmt.setDate(4, Date.valueOf(departureDate));
                pstmt.setDate(5, Date.valueOf(returnDate));

                int rows = pstmt.executeUpdate();
                if (rows > 0) {
                    out.println("<h2>Booking Confirmed</h2>");
                    out.println("<p>Name: " + name + "</p>");
                    out.println("<p>Departure Date: " + departureDate + "</p>");
                    out.println("<a href='tour.jsp' class='button'>Book Another Room</a>");
                } else {
                    out.println("Failed to book. <a href='tour.jsp'>Try again</a>");
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.println("Error occurred: " + e.getMessage());
            } finally {
                if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (con != null) try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        %>
    </div>
</body>
</html>
