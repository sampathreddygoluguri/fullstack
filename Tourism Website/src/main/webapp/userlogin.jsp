<%@ page import ="java.sql.*" %>
<%@ page import ="javax.naming.InitialContext" %>
<%@ page import ="javax.sql.DataSource" %>
<%
String username = request.getParameter("user_name");    
String userpass = request.getParameter("user_pass");

if (username == null || userpass == null || username.isEmpty() || userpass.isEmpty()) {
    out.println("Invalid input. <a href='index.jsp'>Try again</a>");
    return;
}

Connection con = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/tourism", "root", "root");
    
    String query = "SELECT * FROM usersinfo WHERE user_name = ? AND user_pass = ?";
    pstmt = con.prepareStatement(query);
    pstmt.setString(1, username);
    pstmt.setString(2, userpass);
    rs = pstmt.executeQuery();

    if (rs.next()) {
        session.setAttribute("username", username);
        response.sendRedirect("tour.jsp");
    } else {
        out.println("Invalid password / username <a href='index.jsp'>try again</a>");
    }
} catch (Exception e) {
    e.printStackTrace();
    out.println("Error occurred: " + e.getMessage());
} finally {
    if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
    if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
    if (con != null) try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
}
%>
