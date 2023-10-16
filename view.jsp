<%@ page import ="java.sql.*" %>
<html>
<head>
<title> Feedback management system </title>
  <link rel="stylesheet" href="mystyle.css">
<style>
button {
        width: 300px;
	border-radius: 10px;
	font-size: 40px;
    }
</style>
<script>
function goBack() {
      window.location.href = "home.jsp";
    }
</script>
</head>
<center>
<h1> Student Record </h1>
<table border = "5" style="width:70%";font-size: 50px;">
	<tr>
	<th> Roll no </th>
	<th> Name </th>
	<th> Marks </th>
	
	
	</tr>
	<%
	try
	{
		DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
		String url = "jdbc:mysql://localhost:3306/au_23june";
		Connection con=DriverManager.getConnection(url ,"root","abc456");
		String sql = "select * from student";
		PreparedStatement pst = con.prepareStatement(sql);
		ResultSet rs =pst.executeQuery();
		
		while(rs.next())
		{
	%>		
			<tr style="text-align:center;">
			<td> <%= rs.getInt(1) %> </td>
			<td> <%= rs.getString(2) %> </td>	
			<td> <%= rs.getString(3) %> </td>
			
			</tr>
	<%
		
		}
		con.close();
	}
	catch(SQLException e)
	{
		out.println("Issue is" + e);
	}
%>
	</table>
<form>
<br>
<button type="button" onclick="goBack()">Back</button>

</form>

</center>
</html>