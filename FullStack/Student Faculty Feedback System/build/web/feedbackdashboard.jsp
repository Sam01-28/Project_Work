<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>



<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Feedback Dashboard</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
    <style>
        /* CSS for table styling */
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #4CAF50;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        tr:hover {
            background-color: #ddd;
        }
        .edit-link, .delete-link {
            text-decoration: none;
            padding: 4px;
            border-radius: 50%;
            color: #333;
            margin-right: 5px;
            transition: background-color 0.3s;
        }
        .edit-link:hover, .delete-link:hover {
            background-color: #f0f0f0;
        }
        .material-icons {
            vertical-align: middle;
        }
    </style>
    <script type="text/javascript">
        function disableBack() {
            window.history.forward();
        }

        window.onload = disableBack;
        window.onpageshow = function(evt) {
            if (evt.persisted) disableBack();
        }
        window.onunload = function() {
            void (0);
        }
    </script>
</head>
<body>

<h2 style="color: #4CAF50;">Feedback Dashboard</h2>

<table class="striped">
    <!-- Table content goes here -->
</table>

<table class="striped">
    <thead>
        <tr>
            <th>Student Name</th>
            <th>Roll Number</th>
            <th>Branch</th>
            <th>Semester</th>
            <th>Teacher</th>
            <th>Feedback Date</th>
            <th>Q1</th>
            <th>Q2</th>
            <th>Q3</th>
            <th>Q4</th>
            <th>Q5</th>
            <th>Q6</th>
            <th>Q7</th>
            <th>Q8</th>
            <th>Actions</th>
        </tr>
    </thead>
    <tbody>
        <% 
            // Database connection parameters
            String url = "jdbc:mysql://localhost:3306/gehu";
            String username = "root";
            String password = "Qwerty@12345";
            
            // SQL query to retrieve feedback data
            String sql = "SELECT * FROM teacherevaluation";
            
            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;
            try {
                // Load the MySQL JDBC driver
                Class.forName("com.mysql.jdbc.Driver");

                // Establish a connection to the database
                conn = DriverManager.getConnection(url, username, password);

                // Create a Statement object to execute the SQL query
                stmt = conn.createStatement();

                // Execute the query
                rs = stmt.executeQuery(sql);

                // Iterate through the result set and display data in the table
                while (rs.next()) {
                    String studentName = rs.getString("student_name");
                    String rollNo = rs.getString("roll_no");
                    String branch = rs.getString("branch");
                    String semester = rs.getString("semester");
                    String teacher = rs.getString("teacher");
                    Timestamp feedbackDate = rs.getTimestamp("feedback_date");
                    int[] ratings = new int[8];
                    for (int i = 0; i < 8; i++) {
                        ratings[i] = rs.getInt("q" + (i+1));
                    }
                    
                    // Output table row with data
                    out.println("<tr>");
                    out.println("<td>" + studentName + "</td>");
                    out.println("<td>" + rollNo + "</td>");
                    out.println("<td>" + branch + "</td>");
                    out.println("<td>" + semester + "</td>");
                    out.println("<td>" + teacher + "</td>");
                    out.println("<td>" + feedbackDate + "</td>");
                    for (int i = 0; i < 8; i++) {
                        out.println("<td>" + ratings[i] + "</td>");
                    }
                    out.println("<td>");
                    out.println("<a href=\"editfeedback.jsp?id=" + rs.getInt("id") + "\" class=\"edit-link\"><i class=\"material-icons\">edit</i></a>");
                    out.println("<a href=\"deletefeedback.jsp?id=" + rs.getInt("id") + "\" class=\"delete-link\"><i class=\"material-icons\">delete</i></a>");
                    out.println("</td>");
                    out.println("</tr>");
                }
            } catch (ClassNotFoundException | SQLException e) {
                out.println("Error: " + e.getMessage());
            } finally {
                // Close the Statement, ResultSet, and Connection objects in a finally block
                try {
                    if (rs != null) {
                        rs.close();
                    }
                    if (stmt != null) {
                        stmt.close();
                    }
                    if (conn != null) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    out.println("Error closing database resources: " + e.getMessage());
                }
            }
        %>
    </tbody>
</table>

<form method="post" action="index.html">
    <input type="hidden" name="action" value="logout">
    <button type="submit" class="btn btn-primary w-100">Logout</button>
</form>

<script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
</body>
</html>
