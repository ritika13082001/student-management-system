<%@ page import = "java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
  <title>Add Student</title>
  <link rel="stylesheet" href="mystyle.css">
  <style>
    label {
      display: block;
      margin-top: 5px;
    }
    input[type="text"]
    input[type="email"], textarea {
      width: 200px;
	}
	
     input[type="radio"] {
    width: 30px;
    height: 30px;
  }
button {
        width: 300px;
	border-radius: 10px;
	font-size: 40px;
    }

	input[type="text"], input[type="email"], textarea {
    width: 450px; /* Decreased the width of text fields */
    height: 40px;
    padding: 2px;
    border-radius: 10px; /* Added round border */
  }
    
    input[type="submit"] {
      margin-top: 10px;
	font-size: 30px;
    }
	::placeholder {
    font-size: 30px;
  }
  </style>
<script>
function goBack() {
      window.location.href = "home.jsp";
    }

 function showCustomValidity(element, message) {
      element.setCustomValidity(message);
      element.reportValidity();
    }

    function clearCustomValidity(element) {
      element.setCustomValidity('');
    }
</script>


</head>
<body>
<center>
  <h1>Update Student Record </h1>
  <form>
    <label for="rno">Enter Roll No:</label>
    <input type="text" id="rno" name="rno" placeholder="Enter Roll number" required pattern="\d+" 
           oninvalid="this.value === '' ? showCustomValidity(this, 'Roll No cannot be empty.') : showCustomValidity(this, 'Only numbers allowed.')"
           oninput="clearCustomValidity(this)">

    <label for="name">Enter Name:</label>
    <input type="text" id="name" name="name" placeholder = "Enter Name" required pattern="[A-Za-z\s]+" 
	 oninvalid="showCustomValidity(this, 'Only alphabets allowed.')"
           oninput="clearCustomValidity(this)">

    <label for="mark">Enter Marks:</label>
    <input type="text" id="marks" name="marks" placeholder="Enter Marks" required pattern="\d+" 
           oninvalid="this.value === '' ? showCustomValidity(this) : showCustomValidity(this, 'Only numbers allowed.')"
           oninput="clearCustomValidity(this)">
	
   
<br><br>
<button type="submit" name = "btn">Update</button>

<button type="button" onclick="goBack()">Back</button>
</form>

<%
if (request.getParameter("btn") != null) {
  try {
    int rno = Integer.parseInt(request.getParameter("rno"));
    String name = request.getParameter("name");
    int marks = Integer.parseInt(request.getParameter("marks"));

    DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
    String url = "jdbc:mysql://localhost:3306/au_23june";
    String un = "root";
    String pw= "abc456";
    Connection con = DriverManager.getConnection(url, un, pw);

    // Correct the SQL update statement
    String sql = "update student set name=?, marks=? where rno=?";
    PreparedStatement pst = con.prepareStatement(sql);
    pst.setString(1, name);
    pst.setInt(2, marks);
    pst.setInt(3, rno);

    int rc = pst.executeUpdate();
    out.println(rc + " Record updated");

    con.close();

  } catch (SQLException e) {
    out.println("Issue: " + e);
  }
}
%>
</center>
</body>
</html>
