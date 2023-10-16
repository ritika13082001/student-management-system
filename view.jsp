<%@ page import="java.sql.*" %>
<html>
<head>
    <title>Student Record</title>
    <link rel="stylesheet" href="mystyle.css">
    <style>
        button {
            width: 300px;
            border-radius: 10px;
            font-size: 40px;
        }
        table {
            width: 80%;
            font-size: 50px;
            border-collapse: collapse;
        }
        th, td {
            border: 2px solid black;
            padding: 10px;
            text-align: center;
        }
    </style>
    <script>
        function goBack() {
            window.location.href = "home.jsp";
        }
    </script>
</head>

<center>
<h1>Student Record</h1>
<table>
    <tr>
        <th>Roll No</th>
        <th>Name</th>
        <th>Marks</th>
        <th>Course</th>
        <th>Division</th>
        <th>Achievements</th>
    </tr>
    <%
        try {
            DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
            String url = "jdbc:mysql://localhost:3306/au_23june";
            Connection con = DriverManager.getConnection(url, "root", "abc456");
            String sql = "select * from student";
            PreparedStatement pst = con.prepareStatement(sql);
            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
    %>
                <tr>
                    <td><%= rs.getInt(1) %></td>
                    <td><%= rs.getString(2) %></td>
                    <td><%= rs.getString(3) %></td>
                    <td><%= rs.getString(4) %></td>
                    <td><%= rs.getString(5) %></td>
                    <td><%= rs.getString(6) %></td>
                </tr>
    <%
            }
            con.close();
        } catch (SQLException e) {
            out.println("Issue is " + e);
        }
    %>
</table>
<form>
    <br>
    <button type="button" onclick="goBack()">Back</button>
</form>
</center>
</html>
