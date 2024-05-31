<%@ page import ="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Registration Confirmation</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .container {
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            text-align: center;
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
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/tourism", "root", "root");
            PreparedStatement preparedStatement = null;

            String Cus_Name = request.getParameter("name"); 
            String user_name = request.getParameter("username");  
            String user_pass = request.getParameter("userpass");
            String Email = request.getParameter("email");

            String sql = "INSERT INTO usersinfo (Cus_Name, user_name, user_pass, Email) VALUES (?, ?, ?, ?)";
            preparedStatement = con.prepareStatement(sql);
            preparedStatement.setString(1, Cus_Name);
            preparedStatement.setString(2, user_name);
            preparedStatement.setString(3, user_pass);
            preparedStatement.setString(4, Email);

            int rowsAffected = preparedStatement.executeUpdate();

            if (rowsAffected > 0) {
                out.println("<h2>Account Created Successfully!</h2>");
            } else {
                out.println("<h2>Failed to Create Account.</h2>");
            }
        } catch (Exception e) {
            out.println("<h2>Error: " + e.getMessage() + "</h2>");
        }
        %>
        <br>
        <a href="index.jsp" class="button">Go to Login</a>
    </div>
</body>
</html>
