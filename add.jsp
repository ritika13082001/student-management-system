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
	button {
        width: 300px;
	border-radius: 10px;
	font-size: 40px;
    }

  form input[type="text"],
    form textarea {
      width: 450px;
      height: 50px;
      padding: 2px;
      border-radius: 10px;
      /* ... Other existing styles ... */
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
  <h1> Add Student </h1>
  <form>
    <label for="rno">Enter Roll No:</label>
    <input type="text" id="rno" name="rno" placeholder="Enter Roll number" required pattern="\d+" 
           oninvalid="this.value === '' ? showCustomValidity(this, 'Roll No cannot be empty.') : showCustomValidity(this, 'Only numbers allowed.')"
           oninput="clearCustomValidity(this)">

    <label for="name">Enter Name:</label>
    <input type="text" id="name" name="name" placeholder = "Enter Name" required pattern="[A-Za-z\s]+" 
	 oninvalid="showCustomValidity(this, 'Only alphabets allowed.')"
           oninput="clearCustomValidity(this)">

    <label for="marks">Enter Marks:</label>
    <input type="text" id="marks" name="marks" placeholder="Enter Marks" required pattern="\d+" 
           oninvalid="this.value === '' ? showCustomValidity(this) : showCustomValidity(this, 'Only numbers allowed.')"
           oninput="clearCustomValidity(this)">
	
   
<br><br>
<button type="submit" name = "btn">Add</button>
<button type="button" onclick="goBack()">Back</button>
</form>

<%
if (request.getParameter("btn") != null)
	{

	try
	{
		int rno = Integer.parseInt(request.getParameter("rno"));
		String name = request.getParameter("name");
		String marks = request.getParameter("marks");
		
		
		DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());	
		String url = "jdbc:mysql://localhost:3306/au_23june";
		Connection  con = DriverManager.getConnection(url,"root","abc456");
		String checkSql = "SELECT * FROM student WHERE rno=?";
    	PreparedStatement checkPst = con.prepareStatement(checkSql);
    	checkPst.setInt(1, rno);
    	ResultSet checkResult = checkPst.executeQuery();
    
    	if (checkResult.next()) {
     	 // Feedback already exists for the given roll number
      	out.println("Record already submitted for Roll No: " + rno);
    	} 	else {
    
    		String sql = "insert into student values (?,?,?)";
		PreparedStatement pst = con.prepareStatement(sql);
		pst.setInt(1,rno);
		pst.setString (2,name);
		pst.setString(3,marks);
		
		pst.executeUpdate(); 	
		con.close();
		out.println("Add Student Record Successfully!");
		
		}
	}catch(SQLException e)
		{
			out.println("issue" + e);
		}
	}

%>
</center>
</body>
</html>
