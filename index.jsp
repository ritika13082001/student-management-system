<%@ page import = "java.sql.*" %>
<html>
<head>
<title>Student Management System</title>
<link rel = "stylesheet" href = "mystyle.css">
<style>
::placeholder {
    font-size: 30px;}

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

#invalidMessage {
            color: red;
            font-size: 40px;
            margin-top: 10px;
        }

input[type="submit"] {
      margin-top: 10px;
	font-size: 30px;
    }
</style>
<script>
function goBack() {
    window.location.href = "signup.jsp";
  }
</script>
</head>
<body>
<center>
<h1> Login </h1>
<form>
<input type = "text" name = "un" placeholder ="Enter username" required>
<br><br>
<input type = "password" name = "pw" placeholder = " Enter password " required>
<br><br>	
<button type="submit" name = "btn">Log in</button><br>
</form>
<button type="button" onclick="goBack()">Sign up</button>
<%
	if (request.getParameter("btn") != null)
	{
		String un = request.getParameter ("un");
		String pw = request.getParameter ("pw"); 
	
	try
	{
		DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());	
		String url = "jdbc:mysql://localhost:3306/au_23june";
		Connection  con = DriverManager.getConnection(url,"root","abc456");
		String sql = "select * from user where un = ? and pw = ?";
		PreparedStatement pst = con.prepareStatement(sql);
		pst.setString (1,un);
		pst.setString(2,pw);
		ResultSet rs = pst.executeQuery();
		if(rs.next())
		{
			session.setAttribute("un",un);
			response.sendRedirect("home.jsp");
		}
		else
		{
		%>
                	<div id="invalidMessage">Invalid login</div>
                <%
		}
			 	
		con.close();
	}catch(SQLException e)
		{
			out.println("issue" + e);
		}
	}
	
%>
</center>
</body>
</html>