<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.util.Random"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.concurrent.Executors"%>
<%@page import="javax.xml.ws.spi.http.HttpExchange"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <script type="text/JavaScript">
<!--
function timedRefresh(timeoutPeriod) {
   
	setTimeout("location.reload(true);",timeoutPeriod);
}

//   -->
</script>
    </head>
    <body onload="JavaScript:timedRefresh(2900);">
    <%@ page import="java.io.*, java.net.*, java.sql.Timestamp" %>
     <%
     
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/isa681","ISA681", "World@123");
    PreparedStatement st ;
    ResultSet rs = null;
    
 if((request.getParameter("button").equals("NEW"))&& (session.getAttribute("reloadcount")==null))
{
	st = con.prepareStatement("insert into userinfo (FirstPlayer_Id, SecondPlayer_Id, Status, Moves) values (? ,0,'Waiting','' )");
    st.setInt(1, Integer.parseInt(""+session.getAttribute("userid")));
	int i = st.executeUpdate();

	session.setAttribute("gameid", session.getAttribute("userid"));
    session.setAttribute("reloadcount", 1);
   
    con.close();
}
 

 else if(request.getParameter("button").equals("JOIN") && (session.getAttribute("reload")==null))
 {
     session.setAttribute("gameid", Integer.parseInt(request.getParameter("gameid")));
      st = con.prepareStatement("SELECT SecondPlayer_Id FROM userinfo where Status = 'Waiting' and FirstPlayer_Id = ?");
     st.setInt(1, Integer.parseInt(""+session.getAttribute("gameid")));
     rs = st.executeQuery();
	
     rs.next();
          
     if(rs.getInt(1)==0)
     {
    	st = con.prepareStatement("UPDATE userinfo SET SecondPlayer_Id = ? , Status = 'Ready' where  Status = 'Waiting' and FirstPlayer_Id = ? ");
        st.setInt(1, Integer.parseInt(""+session.getAttribute("userid")));
        st.setInt(2, Integer.parseInt(""+session.getAttribute("gameid")));
        st.executeUpdate();
     }
       session.setAttribute("reload", 1);
 }
 
    else 
 {
    
 st = con.prepareStatement("SELECT count(*) FROM userinfo where FirstPlayer_Id = ? and Status = 'Waiting' ");
 st.setInt(1, Integer.parseInt(""+session.getAttribute("gameid")));
 rs = st.executeQuery();
 
 rs.next();
   if(rs.getInt(1)==1)
   {
   out.println("<center>");
   out.println("<h1> Another Player is Joining!!</h1>");
   out.println("</center>");
   }

   st = con.prepareStatement("SELECT count(*) FROM userinfo where FirstPlayer_Id = ? and Status = 'Ready' ");
   st.setInt(1, Integer.parseInt(""+session.getAttribute("gameid")));
   rs = st.executeQuery();
   
   rs.next();
   
   if(rs.getInt(1)==1)
   {
   rs.close();
   out.println("<center>");
   out.println("<h1> Start Game </h1>"); %>
 <form  action="updategameresult_db.jsp" target="_top" > 
     <input name =button type=submit value="ExitGame"  > 
 </form>
       <%
   if(session.getAttribute("intial")==null)
   {
	   st = con.prepareStatement("SELECT count(*) FROM gamedata where Game_Id = ? ");
	   st.setInt(1, Integer.parseInt(""+session.getAttribute("gameid")));
	   rs=st.executeQuery();
   
	   rs.next();
   
	   if(rs.getInt(1)==0)
   {
   String CHARS = "ABCDEFGHIabfOPQRSTUVWXYZ";
   Random rnd = new Random();
   int index = (int) (rnd.nextFloat() * CHARS.length());
	
   st = con.prepareStatement("insert into gamedata values (?, ?, 0)");
   st.setInt(1, Integer.parseInt(""+session.getAttribute("gameid")));
   st.setString(2, "Letter : "+CHARS.charAt(index));		   
   st.executeUpdate();
   
   }
	   
	   st = con.prepareStatement("insert into userpoints values (? , 0, 'A')");
	   st.setInt(1, Integer.parseInt(""+session.getAttribute("userid")));
	   
      int updt= st.executeUpdate();
  	   session.setAttribute("intial", "no");
   
   }
 out.print("<textarea readonly rows=50 cols=50>");
 st = con.prepareStatement("SELECT WordList FROM gamedata where Game_Id = ?");
 st.setInt(1, Integer.parseInt(""+session.getAttribute("gameid")));
 rs = st.executeQuery();
  
 rs.next();
 String words [] = rs.getString(1).split("&");
   for(int len =0; len<words.length;len++)
   {
   out.print(""+words[len]);
   out.print("\n");
   }
   out.print("</textarea>"); 
   String temp [] = words[words.length-1].split(":");
   String tempWord = temp[0]+":"+temp[1];
   out.print("<label>Latest word: </label> <input type=text value="+  temp[1]+" readonly>");
   
   st = con.prepareStatement("select score from userpoints where User_Id = ?");
   st.setInt(1, Integer.parseInt(""+session.getAttribute("userid")));
   rs = st.executeQuery();
   
   rs.next();
   out.print(""+"User Points : "+rs.getInt(1));
   out.println("</center>");
   }
   
   else 
   {
	   st = con.prepareStatement("select Max(Id) from userinfo where FirstPlayer_Id = ?");   
	   st.setInt(1, Integer.parseInt(""+session.getAttribute("gameid")));
       rs=st.executeQuery();
   
    rs.next();
    
    st = con.prepareStatement("select Status from userinfo where Id = ? ");
    st.setInt(1, rs.getInt(1));
    rs=st.executeQuery();
    
    if(rs.next())
    {
    
    if(rs.getString(1).equals("Paused"))
    {
    	if(session.getAttribute("intialcheck")==null)
    	{
    		st = con.prepareStatement("insert into stopgame values (? , Now())");
    		st.setInt(1, Integer.parseInt(""+session.getAttribute("gameid")));
    		st.executeUpdate();
    	    session.setAttribute("intialcheck", "no");
    	}
    	
    	else
    	{
    		st = con.prepareStatement("SELECT TIMESTAMPDIFF(MINUTE, S_Time, NOW()) as timediff FROM stopgame");
    		rs = st.executeQuery();
    		rs.next();
    		if(Integer.parseInt(rs.getString(1))>=5)
    		{
    		      st=con.prepareStatement("delete from pausedgame where GameId = ? ");
    		      st.setInt(1, Integer.parseInt(""+session.getAttribute("gameid")));
    		      st.executeUpdate();
    		      
    			  out.print(""+ "Game has been completed and you won. Wanna Play more then go to other server");
    		      out.println("<form  action='updategameresult_db.jsp' target='_top' >");
    		      out.println("<input name =button type=submit value='ExitGame'>"); 
    		      out.println("</form>");
    		
    		}
    		else
    		{
    			out.println(""+"Every others have left the game so you will be winner in next 5 min on condtion if no one joins. Present time completed is : "+rs.getString(1));	
    	    			
    		}
    	}
    
    }
    
    if(rs.getString(1).split("&")[0].equals("Compeleted"))
   {
    
       st = con.prepareStatement("Select user_name from usersrecord where Id = ?");
       st.setInt(1, Integer.parseInt(rs.getString(1).split("&")[1]));
       rs=st.executeQuery();
    
       rs.next();
       out.print(""+ "Game has been completed and the winner is "+rs.getString(1));
      out.println("<form  action='updategameresult_db.jsp' target='_top' >");
      out.println("<input name =button type=submit value='ExitGame'>"); 
      out.println("</form>");
      
  
   }
   }    
      
   }
   rs.close();
   con.close();
 
   }
 
 %>
    
    </body>
</html>
