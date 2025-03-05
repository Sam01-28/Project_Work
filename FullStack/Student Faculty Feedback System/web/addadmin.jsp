

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>

<script>//Email validation
            const emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,6}$/;
            if (!emailPattern.test(email)) {
                alert("Please enter a valid email address.");
                return false;
            }</script>
<%
String fname = request.getParameter("fname");
String lname = request.getParameter("lname");
String email = request.getParameter("email");
String password = request.getParameter("password");
String phone = request.getParameter("phone");

// Hash the password (replace this with your preferred password hashing method)
String hashedPassword = password;

Connection con = null;
PreparedStatement pstmt = null;

try {
    Class.forName("com.mysql.jdbc.Driver");
    con = DriverManager.getConnection("jdbc:mysql://localhost/gehu", "root", "Qwerty@12345");
    String sql = "INSERT INTO admin (fname, lname, email, password, phone) VALUES (?, ?, ?, ?, ?)";
    pstmt = con.prepareStatement(sql);
    pstmt.setString(1, fname);
    pstmt.setString(2, lname);
    pstmt.setString(3, email);
    pstmt.setString(4, hashedPassword);
    pstmt.setString(5, phone);
    int rowsInserted = pstmt.executeUpdate();
    if (rowsInserted > 0) {
        response.sendRedirect("adminlogin.html");
    } else {
        // Handle insertion failure
        out.println("Failed to insert user.");
    }
} catch (SQLException | ClassNotFoundException e) {
    // Handle database or class loading errors
    out.println("An error occurred: " + e.getMessage());
} finally {
    // Close resources
    try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
    try { if (con != null) con.close(); } catch (Exception e) {}
}
%>
