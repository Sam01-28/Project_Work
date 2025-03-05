<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*, java.util.*"%>
<%
String email = request.getParameter("email");
String password = request.getParameter("password");

try {
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost/gehu", "root", "Qwerty@12345");

    // Using prepared statement to prevent SQL injection
    String query = "SELECT * FROM admin WHERE email=? AND password=?";
    PreparedStatement pstmt = con.prepareStatement(query);
    pstmt.setString(1, email);
    pstmt.setString(2, password);
    
    ResultSet rs = pstmt.executeQuery();

    if (rs.next()) {
        // If login successful, store email in session
        session.setAttribute("email", email);
        // Set session expiration time to 30 minutes
        session.setMaxInactiveInterval(30 * 60);
        response.sendRedirect("feedbackdashboard.jsp");
    } else {
        // If login fails, set error message and redirect to login page
        session.setAttribute("error", "Invalid email or password.");
        // Redirect using PRG pattern to prevent form resubmission
        response.sendRedirect("adminlogin.html");
    }

    // Close resources
    rs.close();
    pstmt.close();
    con.close();
} catch (Exception e) {
    e.printStackTrace();
    // Redirect to error page or handle error appropriately
    session.setAttribute("error", "An error occurred while processing your request.");
    // Redirect using PRG pattern to prevent form resubmission
    response.sendRedirect("error.html");
}
%>
