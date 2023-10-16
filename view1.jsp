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
body {
  background-image: url("download.jpg");
  height: 500px; /* You must set a specified height */
  background-position: center; /* Center the image */
  background-repeat: no-repeat; /* Do not repeat the image */
  background-size: cover; /* Resize the background image to cover the entire container */

}
</style>
</head>
<center>
	
<h1> Feedback </h1>
<table border = "5" style="width:70%";font-size: 50px;">
	<tr>
	<th> Roll no </th>
	<th> Name </th>
	<th> Email </th>
	<th> Feedback </th>
	
	</tr>
	<%
	try
	{
		DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
		String url = "jdbc:mysql://localhost:3306/au_23june";
		Connection con=DriverManager.getConnection(url ,"root","abc456");
		String sql = "select * from feedback1";
		PreparedStatement pst = con.prepareStatement(sql);
		ResultSet rs =pst.executeQuery();
		
		while(rs.next())
		{
	%>		
			<tr style="text-align:center;">
			<td> <%= rs.getInt(1) %> </td>
			<td> <%= rs.getString(2) %> </td>	
			<td> <%= rs.getString(3) %> </td>
			<td> <%= rs.getInt(4) %> </td>
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

</center>
</html>