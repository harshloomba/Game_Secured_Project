<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Registration Page</title>
    </head>
    <body>
       
    </body>
    <%@ page import="java.security.SecureRandom"%>
    <%@ page import="javax.crypto.SecretKeyFactory"%>
    <%@ page import="javax.crypto.spec.PBEKeySpec"%>

    <%@ page import="java.util.Random"%>
    <%@ page import ="java.sql.*" %>
    <%@ page import="java.math.BigInteger"%>
    
<%
String pwd = request.getParameter("pwd");
  
    String saltedpwd="";
   
    final int ITERATIONS = 1000;
    final int KEY_LENGTH = 192; 
    
    final Random rand = new SecureRandom();
	 
    byte[] salt = new byte[32];
	
    rand.nextBytes(salt);
    
    saltedpwd = String.format("%x", new BigInteger(salt));
    
    
    char[] passwordChars = pwd.toCharArray();

    PBEKeySpec spec = new PBEKeySpec(
    	       passwordChars,
    	       saltedpwd.getBytes(),
    	       ITERATIONS,
    	       KEY_LENGTH
    	   );
    SecretKeyFactory key;
    
    key = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA1");
    byte[] hashedPassword = key.generateSecret(spec).getEncoded();
    
    pwd =  String.format("%x", new BigInteger(hashedPassword));
    
    PreparedStatement  st =null;
    ResultSet rs =null;
    Connection con=null;
    try
    {
    	  Class.forName("com.mysql.jdbc.Driver");
    	  con = DriverManager.getConnection("jdbc:mysql://localhost:3306/isa681",
    	            "ISA681", "World@123");
    	    
    if(request.getParameter("emailid")!=null)
    {
    st =  con.prepareStatement("SELECT COUNT(*) FROM usersrecord where email_ID = ? ");
    st.setString(1, request.getParameter("emailid"));
    rs = st.executeQuery();
    }
    rs.next();
    int rowCount = rs.getInt(1);
    
    if(rowCount==0)
    {
    	  st =  con.prepareStatement("insert into usersrecord(user_name, email_ID, contact_no, paswd, salted_paswd, Log_In) values (? ,? ,? ,? ,? ,?)");
    	  	st.setString(1, request.getParameter("name"));
    	  	st.setString(2, request.getParameter("emailid"));
    	  	st.setString(3, request.getParameter("phonenumber"));
    		st.setString(4, pwd);
    		st.setString(5, saltedpwd);
    		st.setBoolean(6, false);
      	  	
         int ou = st.executeUpdate();
    rs = st.executeQuery("Select max(Id) from usersrecord");
    rs.next();
    int temp= st.executeUpdate("insert into winstatistics values ("+ rs.getInt(1)+", 0 , 0)");
    if (ou>0 && temp > 0) 
        out.print("Registration Ssccessfull!"+"<a href='../HTML/login.html'>Go to Login</a>");  

    else
        out.print("Registration UnSuccessfull!"+"<a href='../HTML/register.html'>Go to Registration</a>");    
          
    }
    
    else
        out.print("Registration UnSuccessfull..!! Mailid already exists. "+"<a href='../HTML/register.html'>Go to Registration</a>");  
    
    }
    catch( Exception e ) 
    { 
        out.println(e.getMessage()); 
    } 
   
%>
    
</html>
