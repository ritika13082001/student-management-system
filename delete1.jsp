<%@ page import ="java.sql.*" %>
<html>
<head>
<title> student management system </title>
<link rel="stylesheet" href="mystyle.css"/>
<style>
input[type="text"], textarea {
    width: 450px; /* Decreased the width of text fields */
    height: 50px;
    padding: 2px;
    border-radius: 10px; /* Added round border */
}

button {
        width: 300px;
	border-radius: 10px;
	font-size: 40px;
    }
</style>
<script>
function goBack() {
    window.location.href = "home1.jsp";
}

function showCustomValidity(element, message) {
    element.setCustomValidity(message);
    element.reportValidity();
}

function clearCustomValidity(element) {
    element.setCustomValidity('');
}

function confirmDelete() {
    var rnoField = document.getElementById('rno');
    var rno = rnoField.value;

    if (rno !== '' && confirm("Are you sure you want to delete the record for Roll No: " + rno + "?")) {
        return true; // Proceed with form submission
    }

    return false; // Cancel form submission
}
</script>
</head>
<center>

<h1> Delete Record</h1>
<form method="post" onsubmit="return confirmDelete()">
    <label for="rno">Enter Roll No:</label>
    <input type="text" id="rno" name="rno" placeholder="Enter Roll number" required pattern="\d+"
           oninvalid="this.value === '' ? showCustomValidity(this, 'Roll No cannot be empty.') : showCustomValidity(this, 'Only numbers allowed.')"
           oninput="clearCustomValidity(this)"><br><br>
  <button type="submit" name = "btn">Delete</button>
<br><br>
    <button type="button" onclick="goBack()">Back</button>
</form>

<%
if (request.getParameter("btn") != null) {
    int rno = Integer.parseInt(request.getParameter("rno"));

    try {
        DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
        String url = "jdbc:mysql://localhost:3306/au_23june";
        Connection con = DriverManager.getConnection(url, "root", "abc456");
        String sql = "delete from feedback1 where rno = ?";
        PreparedStatement pst = con.prepareStatement(sql);
        pst.setInt(1, rno);
        long r = pst.executeUpdate();
        out.println("Record deleted");
        con.close();
    } catch (SQLException e) {
        out.println("Issue is" + e);
    }
}
%>

</center>
</html>
