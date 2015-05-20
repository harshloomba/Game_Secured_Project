<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body>
        
    <%@ page import="javax.crypto.spec.PBEKeySpec"%>
    <%@ page import="java.math.BigInteger"%>
    <%@ page import ="java.sql.*" %>
    <%@ page import="javax.crypto.SecretKeyFactory"%>
    
    
    <h4>Previous Game is still pending, Would you like to continue!!</h4>
    <table>
    <tr>
    <td>
  <form  action='lastgame.jsp' target='_top' >
  <input name =button type=submit value='No'> 
  </form>
    </td>
    <td>
     <form  action='lastgame.jsp' target='_top'  >
  <input name =button_c type=submit value='Yes'> 
  </form>
     
    </td>
    </tr>
    </table>
    
    <%
    
    PreparedStatement  st =null;
    ResultSet rs =null;
    Connection con=null;
    try
    {
    	  Class.forName("com.mysql.jdbc.Driver");
    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/isa681",
    	    		"ISA681", null);

    if(request.getParameter("button")!=null)
    {
    	
    	session.setAttribute("gameid", null);
       response.sendRedirect("initiategame.jsp");

    }
    
    if(request.getParameter("button_c")!=null)
    {
    	 st = con.prepareStatement("UPDATE userpoints SET Status = ? where User_Id = ? ");
         st.setString(1, "A");
         st.setInt(2, Integer.parseInt(""+session.getAttribute("userid")));
         st.executeUpdate();
         session.setAttribute("intial", "no");
     	 response.sendRedirect("playgame.jsp?button=join&gameid="+session.getAttribute("gameid"));
     }
    
    }
   catch(Exception e)
    
    {
	  out.println(e.getMessage());
    }
    
   
   %> 
   
      </body>
 
</html>
