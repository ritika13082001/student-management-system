<html>
<head>
<title>Student Management System</title>
<link rel="stylesheet" href="mystyle.css">
<style>
    h1 {font-size: 50px;}

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
        <h1>Feedback Management System</h1>
        <form action="add.jsp">
            <button type="submit">Add</button>
        </form>
        <form action="update.jsp">
            <button type="submit">Update</button>
        </form>
        <form action="view.jsp">
            <button type="submit">View</button>
        </form>
        <form action="delete.jsp">
            <button type="submit">Delete</button>
        </form>
        <button onclick="goBack()">Back</button>
    </center>
</body>
</html>
