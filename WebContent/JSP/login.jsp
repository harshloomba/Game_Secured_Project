<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
    </head>
    <body>
        
    </body>
    <%@ page import="javax.crypto.SecretKeyFactory"%>
    <%@ page import="javax.crypto.spec.PBEKeySpec"%>
    <%@ page import ="java.sql.*" %>
    <%@ page import="java.math.BigInteger"%>
    
    <%
    
    PreparedStatement  st =null;
    ResultSet rs =null;
    Connection con=null;
    
    try
    {
  
    	  Class.forName("com.mysql.jdbc.Driver");
    	  con = DriverManager.getConnection("jdbc:mysql://localhost:3306/isa681",
    	    		"ISA681", "World@123");
    	  
    	st = con.prepareStatement("SELECT Id, paswd, salted_paswd, Log_In FROM usersrecord where email_ID = ? ");
    st.setString(1, request.getParameter("emailid"));	
    rs = st.executeQuery();
    
   if (rs.next())
  {
        
    if(rs.getInt(1)>0)
    {
    	final int ITERATIONS = 1000;
        final int KEY_LENGTH = 192; 
          
        char[] passwordChars = request.getParameter("pwd").toCharArray();
        byte[] saltBytes = rs.getString(3).getBytes();
        
        PBEKeySpec spec = new PBEKeySpec(
        	       passwordChars,
        	       saltBytes,
        	       ITERATIONS,
        	       KEY_LENGTH
        	   );
        	   SecretKeyFactory key;
        	   
  key = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA1");
  byte[] hashedPassword = key.generateSecret(spec).getEncoded();
  String password = String.format("%x", new BigInteger(hashedPassword));
  
  
  
  if(password.equals(rs.getString(2)))
		  {
	  if(rs.getBoolean(4)==false)
	  {
		st = con.prepareStatement("UPDATE usersrecord SET Log_In = true where email_ID = ?");
        st.setString(1, request.getParameter("emailid"));
        st.executeUpdate();
	    session.setAttribute("userid", rs.getInt(1));
	    
	    st = con.prepareStatement("select * from userpoints where User_Id = ?");
	   
	    st.setInt(1, Integer.parseInt(""+rs.getInt(1)));
	   
	    rs = st.executeQuery();
	    if(rs.next()&& rs.getString(3).equals("I"))
	    {
	    	st = con.prepareStatement("select * from userinfo where (FirstPlayer_Id = ? or SecondPlayer_Id = ?) and (Status = 'Ready')");
              st.setInt(1, Integer.parseInt(""+session.getAttribute("userid")));
              st.setInt(2, Integer.parseInt(""+session.getAttribute("userid")));
       	      rs=st.executeQuery();
       	      if(rs.next())
       	      {
       	       session.setAttribute("gameid", rs.getInt(1));
       	       response.sendRedirect("Secured_Code/lastgame.jsp");
       	      }
	    }
       	      else
       	      {
       	      st=con.prepareStatement("delete from userpoints where User_Id = ? ");
      		  st.setInt(1, Integer.parseInt(""+session.getAttribute("userid")));
         	  st.executeUpdate();
      		  response.sendRedirect("Secured_Code/initiategame.jsp");
       	      }
              
	  }
	  else
		  response.sendRedirect("../HTML/login.html");
	  
	  }
  else
  response.sendRedirect("../HTML/login.html");

		  }
    else
 	  response.sendRedirect("../HTML/login.html");
   
  }
   else
	  response.sendRedirect("../HTML/login.html");

    }
 //Security Measure
    finally
    { 
        try
        { 
            if (con != null) 
                con.close (); 
            if (rs != null) 
                rs.close (); 
       
        } 
        catch (SQLException se) 
        { 
            out.println(se.getMessage()); 
        } 
        catch (Exception e)
        {
        	System.out.println(e.getStackTrace());
        }
    }

   
   %> 
</html>
