<%@ page import ="java.sql.*" %>
<%

try {
Class.forName("com.mysql.cj.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/tourism", "root", "root");
PreparedStatement preparedStatement = null;

String Cus_Name = request.getParameter("name"); 
String user_name = request.getParameter("username");  
String user_pass = request.getParameter("userpass");
String Email = request.getParameter("email");

String sql = "insert into usersinfo (Cus_Name, user_name, user_pass, Email) values (?,?,?,?)";
preparedStatement = con.prepareStatement(sql);
preparedStatement.setString(1, Cus_Name);
preparedStatement.setString(2, user_name);
preparedStatement.setString(3, user_pass);
preparedStatement.setString(4, Email);

int rowsAffected = preparedStatement.executeUpdate();

if (rowsAffected > 0) {
    out.println("Data inserted successfully!!!");
} else {
    out.println("Failed to insert data.");
}
} catch (Exception e) {
	out.println(e);
}

%>
<br><a href='index.jsp'>Go to Login</a>