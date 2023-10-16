<%@page import="java.sql.*"%>
<%@page import="javax.mail.*"%>
<%@page import="javax.mail.internet.*"%>
<%@page import="javax.activation.*"%>

<%@page import="java.util.*"%>

<html>
<head>
    <title>Student Registration App</title>
	<link rel="stylesheet" href="mystyle.css">
    <style>
        * {
            font-size: 40px;
        }

        .nav {
            background-color: #5D3FD3;
            padding: 10px;
            font-weight: BOLD;
        }

        .nav1 {
            background-color: #5D3FD3;
            padding: 10px;
            font-weight: BOLD;
            float: left;
        }

        .nav1 a {
            text-decoration: none;
            margin-right: 100px;
            color: white;
        }

        .nav2 {
            background-color: #5D3FD3;
            padding: 10px;
            font-weight: BOLD;
        }

        .nav2 a {
            text-decoration: none;
            margin-right: 100px;
            color: white;
        }
    </style>
</head>
<body>
    <center>
        <h1>Student Registration Form</h1>

        <form method="post">

            <input type="text" name="name" placeholder="Enter Name" />
            <br/><br/>
            <input type="text" name="college" placeholder="Enter College Name" />
            <br/><br/>
            <input type="text" name="address" placeholder="Enter Address" />
            <br/><br/>
            <label for="course">Choose a Course:</label>
            <select name="course" id="course">
                <option value="java">Java</option>
                <option value="python">Python</option>
                <option value="Mysql">Mysql</option>
                <option value="ML">ML</option>
            </select>
            <br/><br/>
            <input type="email" name="email" placeholder="Enter Email" />
            <br/><br/>
            <input type="number" name="phone" placeholder="Enter Phone no" />
            <br/><br/>
            <input type="submit" name="btnSubmit" />
            <input type="Reset" name="btnReset" />

        </form>

        <%
        if (request.getParameter("btnSubmit") != null) {
            String name = request.getParameter("name");
            String college = request.getParameter("college");
            String address = request.getParameter("address");
            String course = request.getParameter("course");
            String phone = request.getParameter("phone");
            String email = request.getParameter("email");

            if (name.trim().length() == 0) {
                out.println("Name is empty!");
            } else if (name.trim().length() == 1) {
                out.println("Name should be a minimum of 2 characters");
            } else if (!name.matches("^[a-zA-Z ]*$")) {
                out.println("Name should start with only letters");
            } else if (college.equals("")) {
                out.println("College name is empty!");
            } else if (college.trim().length() <= 2) {
                out.println("College name should be a minimum of 3 letters");
            } else if (address.equals("")) {
                out.println("Address is empty!");
            } else if (address.trim().length() <= 4) {
                out.println("Address should be a minimum of 5 letters");
            } else if (course.equals("")) {
                out.println("Course should not be empty!");
            } else if (phone.length() != 10) {
                out.println("Phone number should be exactly 10 digits");
            } else if (email.equals("")) {
                out.println("Email should not be empty");
            } else {
                try {
                    DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
                    String url = "jdbc:mysql://localhost:3306/au_23june";
                    Connection con = DriverManager.getConnection(url, "root", "abc456");
                    String sql = "insert into register values(?,?,?,?,?,?)";
                    PreparedStatement pst = con.prepareStatement(sql);
                    pst.setString(1, name);
                    pst.setString(2, college);
                    pst.setString(3, address);
                    pst.setString(4, course);
                    pst.setString(5, phone);
                    pst.setString(6, email);
                    int rowsAffected = pst.executeUpdate();

                    if (rowsAffected > 0) {
                        // Email sending code
                        Properties p = System.getProperties();
                        p.put("mail.smtp.host", "smtp.gmail.com");
                        p.put("mail.smtp.port", "587");
                        p.put("mail.smtp.auth", "true");
                        p.put("mail.smtp.starttls.enable", "true");

                        Session ms = Session.getInstance(p, new Authenticator() {
                            public PasswordAuthentication getPasswordAuthentication() {
                                String un = "pratikmore5702@gmail.com";
                                String pw = "olvy tctp fgkh hwvb";
                                return new PasswordAuthentication(un, pw);
                            }
                        });

                        try {
                            MimeMessage msg = new MimeMessage(ms);
                            String subject = "Thank you for registration!!!";
                            msg.setSubject(subject);
                            String txt = "Name: " + name + "\nCollege: " + college + "\nCourse: " + course + "\nPhone: " + phone;
                            msg.setText(txt);
                            msg.setFrom(new InternetAddress("pratikmore5702@gmail.com"));
                            msg.addRecipient(Message.RecipientType.TO, new InternetAddress(email));
                            Transport.send(msg);
                            out.println("Record saved and email sent.");
                        } catch (Exception er) {
                            out.println("Error sending email: " + er);
                        }
                        con.close();
                    } else {
                        out.println("Error saving the record.");
                    }
                } catch (SQLIntegrityConstraintViolationException e) {
                    out.println("Phone number is already in use.");
                } catch (SQLException e) {
                    out.println("SQL error: " + e.getMessage());
                }
            }
        }
        %>

    </center>
</body>
</html>
