<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

</head>
<body>

<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>

<%

response.sendRedirect("../../HTML/index.html");

Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/isa681",
		"ISA681", "World@123");

try
{
PreparedStatement  st =null;
ResultSet rs =null;

st = con.prepareStatement("UPDATE usersrecord SET Log_In = false where Id = ?");
st.setInt(1, Integer.parseInt(""+session.getAttribute("userid")));
st.executeUpdate();
session.removeAttribute("userid");
session.removeAttribute("gameid");

}
catch( SQLException e ) 
{ 
    out.println(e.getMessage()); 
e.printStackTrace();             
} 
catch (Exception se) 
{ 
    out.println(se.getMessage()); 
}

%>
</body>
</html>