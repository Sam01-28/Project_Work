<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Feedback</title>
</head>
<body>

<h2>Edit Feedback</h2>

<%
// Database connection parameters
String url = "jdbc:mysql://localhost:3306/gehu";
String username = "root";
String password = "Qwerty@12345";

// Get feedback ID from request parameter
int feedbackId = Integer.parseInt(request.getParameter("id"));

// Variables to store feedback data
String studentName = "";
String rollNo = "";
String branch = "";
String year = "";
String semester = "";
String teacher = "";
String feedbackDate = "";
int[] ratings = new int[8];

Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
try {
    // Load the MySQL JDBC driver
    Class.forName("com.mysql.jdbc.Driver");

    // Establish a connection to the database
    conn = DriverManager.getConnection(url, username, password);

    // SQL query to retrieve feedback data by ID
    String sql = "SELECT * FROM teacherevaluation WHERE id = ?";

    // Create a PreparedStatement object to execute the SQL query
    pstmt = conn.prepareStatement(sql);
    
    // Set the parameter for the PreparedStatement
    pstmt.setInt(1, feedbackId);
    
    // Execute the query
    rs = pstmt.executeQuery();
    
    // Extract feedback data from the result set
    if (rs.next()) {
        studentName = rs.getString("student_name");
        rollNo = rs.getString("roll_no");
        branch = rs.getString("branch");
        year = rs.getString("year");
        semester = rs.getString("semester");
        teacher = rs.getString("teacher");
        feedbackDate = rs.getString("feedback_date");
        for (int i = 0; i < 8; i++) {
            ratings[i] = rs.getInt("q" + (i+1));
        }
    }
} catch (ClassNotFoundException | SQLException e) {
    // Handle exception
    e.printStackTrace();
} finally {
    // Close the ResultSet, PreparedStatement, and Connection objects in a finally block
    try {
        if (rs != null) {
            rs.close();
        }
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

<form action="updatefeedback.jsp" method="post">
    <input type="hidden" name="id" value="<%= feedbackId %>">
    <label for="name">Student Name:</label>
    <input type="text" id="name" name="name" value="<%= studentName %>"><br>
    <label for="roll-no">Roll Number:</label>
    <input type="text" id="roll-no" name="roll-no" value="<%= rollNo %>"><br>
    <!-- Add fields for other feedback data here -->
    <button type="submit">Update Feedback</button>
</form>

</body>
</html>
