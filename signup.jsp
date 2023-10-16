<%@ page import = "java.sql.*" %>
<html>
<head>
<title>Student Management System</title>
<link rel = "stylesheet" href = "mystyle.css">
<style>

	input[type="text"], input[type="password"], textarea {
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
    window.location.href = "index.jsp";
  }
</script>
</head>
<body>
<center>
<h1> Signup </h1>
<form>
<input type = "text" name = "un" placeholder ="Enter username" required>
<br><br>
<input type = "password" name = "pw1" placeholder = " Enter password " pattern="^(?=.*[a-zA-Z0-9])(?=.*[!@#$%^&*]).{8,}$" title="Password must contain at least 8 characters and include at least one special character" required>
<br><br>	
<input type = "password" name = "pw2" placeholder = " confirm password " required>
<br><br>
<button type="submit" name = "btn">Register</button><br><br>
<button type="button" onclick="goBack()">Log in</button>
</form>
<%
	if (request.getParameter("btn") != null)
	{
		String un = request.getParameter ("un");
		String pw1 = request.getParameter ("pw1"); 
		String pw2 = request.getParameter ("pw2"); 
		
		if(! pw1.equals(pw2))
		{
			out.println("password did not match");
			return;
		}

	try
	{
		DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());	
		String url = "jdbc:mysql://localhost:3306/au_23june";
		Connection  con = DriverManager.getConnection(url,"root","abc456");
 		String checkSql = "SELECT * FROM user WHERE un=?";
    		PreparedStatement checkPst = con.prepareStatement(checkSql);
    		checkPst.setString(1, un);
    		ResultSet checkResult = checkPst.executeQuery();
	
    		if (checkResult.next()) {
      		out.println("Username already exists");
    		} else {
		String sql = "insert into user values (?,?)";
		PreparedStatement pst = con.prepareStatement(sql);
		pst.setString (1,un);
		pst.setString(2,pw1);
		pst.executeUpdate(); 	
		con.close();
		out.println("Admin created successfully");
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