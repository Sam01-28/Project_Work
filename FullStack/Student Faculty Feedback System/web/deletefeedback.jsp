<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
// Database connection parameters
String url = "jdbc:mysql://localhost:3306/gehu";
String username = "root";
String password = "Qwerty@12345";

// Get feedback ID from request parameter
int feedbackId = Integer.parseInt(request.getParameter("id"));

Connection conn = null;
PreparedStatement pstmt = null;
try {
    // Load the MySQL JDBC driver
    Class.forName("com.mysql.jdbc.Driver");

    // Establish a connection to the database
    conn = DriverManager.getConnection(url, username, password);

    // SQL query to delete feedback entry
    String sql = "DELETE FROM teacherevaluation WHERE id = ?";
    
    // Create a PreparedStatement object to execute the SQL query
    pstmt = conn.prepareStatement(sql);
    
    // Set the parameter for the PreparedStatement
    pstmt.setInt(1, feedbackId);
    
    // Execute the query
    int rowsDeleted = pstmt.executeUpdate();
    
    // Redirect to feedback dashboard
    response.sendRedirect("feedbackdashboard.jsp");
} catch (ClassNotFoundException | SQLException e) {
    // Handle exception
    e.printStackTrace();
} finally {
    // Close the PreparedStatement and Connection objects in a finally block
    try {
        if (pstmt != null) {
            pstmt.close();
        }
        if (conn != null) {
            conn.close();
        }
    } catch (SQLException e) {
        // Handle SQLException in closing resources
        e.printStackTrace();
    }
}
%>
