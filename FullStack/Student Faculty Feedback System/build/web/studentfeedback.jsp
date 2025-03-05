<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>



<%
// Get form data from request
String name = request.getParameter("name");
String rollNo = request.getParameter("roll-no");
String branch = request.getParameter("branch");
String semester = request.getParameter("semester");
String teacher = request.getParameter("teacher");

// Get rating question responses
String[] ratingQuestions = {"q1", "q2", "q3", "q4", "q5", "q6", "q7", "q8"};
int[] ratings = new int[ratingQuestions.length];
for (int i = 0; i < ratingQuestions.length; i++) {
    String ratingParam = request.getParameter(ratingQuestions[i]);
    if (ratingParam != null && !ratingParam.isEmpty()) {
        try {
            ratings[i] = Integer.parseInt(ratingParam);
        } catch (NumberFormatException e) {
            // Handle invalid rating input
            out.println("Invalid rating input for question " + ratingQuestions[i]);
            return;
        }
    } else {
        // Handle missing rating
        out.println("Please answer all rating questions.");
        return;
    }
}

// Database connection parameters
String url = "jdbc:mysql://localhost:3306/gehu";
String username = "root";
String password = "Qwerty@12345";

// SQL query to insert form data into database
String sql = "INSERT INTO teacherevaluation (student_name, roll_no, branch, semester, teacher, q1, q2, q3, q4, q5, q6, q7, q8) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
             
Connection conn = null;
PreparedStatement pstmt = null;
try {
    // Load the MySQL JDBC driver
    Class.forName("com.mysql.jdbc.Driver");

    // Establish a connection to the database
    conn = DriverManager.getConnection(url, username, password);

    // Create a PreparedStatement object to execute the SQL query
    pstmt = conn.prepareStatement(sql);

    // Set parameters for the PreparedStatement
    pstmt.setString(1, name);
    pstmt.setString(2, rollNo);
    pstmt.setString(3, branch);
    pstmt.setString(4, semester);
    pstmt.setString(5, teacher);

    for (int i = 0; i < ratingQuestions.length; i++) {
        pstmt.setInt(6 + i, ratings[i]);
    }

    // Execute the query
    int rowsInserted = pstmt.executeUpdate();

    // Check if the data was inserted successfully
    if (rowsInserted > 0) {
        response.sendRedirect("feedbacksuccess.html");
    } else {
        response.sendRedirect("studentfeedback.html");
    }
} catch (ClassNotFoundException e) {
    // Handle ClassNotFoundException
    out.println("Database driver not found.");
    e.printStackTrace();
} catch (SQLException e) {
    // Handle SQLException
    out.println("SQL exception: " + e.getMessage());
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
        out.println("Error closing database resources: " + e.getMessage());
        e.printStackTrace();
    }
}
%>