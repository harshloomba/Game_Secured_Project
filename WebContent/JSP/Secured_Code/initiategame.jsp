<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.SQLException"%>
<%@page import="javax.xml.crypto.Data"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link href="../../HTML/style.css" rel="stylesheet" type="text/css" />
  
</head>
<body onload="JavaScript:timedRefresh(6300);">
  <div id="header"> <a href="#"><img src="../../HTML/images/games_logo_big.jpg" /></a>
  </div>
<div id="bodyfooterPan">
   
  <%
  
  Connection con=null;

  PreparedStatement  st =null;
  ResultSet result =null;
  
  try
  {
	  Class.forName("com.mysql.jdbc.Driver");
	  con = DriverManager.getConnection("jdbc:mysql://localhost:3306/isa681",
			  "ISA681", "World@123");
   st=con.prepareStatement("SELECT * from winstatistics where Id= ?");
   st.setInt(1, Integer.parseInt(""+session.getAttribute("userid")));
   result = st.executeQuery();
   result.next();
  out.println("<h2>Win/Loss Statistics</h2>");
  out.println("<br></br>");
  out.print("<table border=3>");
  out.print("<tr>");
  out.print("<th>Wins</th>");
  out.print("<th>Loses</th>");
  out.print("</tr>");
  out.print("<tr>");
  out.print("<td>");
  out.println(""+result.getInt(2));
  out.print("</td>");
  out.print("<td>");

  out.println(""+result.getInt(3));
  out.print("</td>");

  out.print("</tr>");
  out.print("</table>"); 

  out.println("<br></br>");
  
  out.println("<h1> Previous Game Moves</h1>");
  out.println("<br></br>");
  out.print("<table border=1>");
  out.print("<tr>");
  out.print("<th>Previous Games</th>");
  out.print("<th>Moves Of Selected Game</th>");
  out.print("</tr>");
  out.print("<tr>");
  out.print("<td>");
  st=con.prepareStatement("select Id from userinfo where (FirstPlayer_Id=? or SecondPlayer_Id =? )and (Status!='Waiting' or Status!='Ready')");
  st.setInt(1, Integer.parseInt(""+session.getAttribute("userid")));
  st.setInt(2, Integer.parseInt(""+session.getAttribute("userid")));
  result=st.executeQuery();
  out.println("<form action=initiategame.jsp>");
  out.print("<select name=gameno size=1>");
 int m=1;
  while(result.next())
  {
	  out.print("<option value="+result.getInt(1)+">Game: "+ m+"</option>");
	  m++;
  }
  out.print("</select>");
  out.print("<input name =button type=submit value=RETRIVE>");
  out.print("</form>");
  out.print("</td>");
  out.print("<td>");
 
  if(request.getParameter("gameno") != null)
  {
	 out.print("<textarea readonly rows=20 cols=20>");
	 st=con.prepareStatement("SELECT Moves FROM userinfo where Id = ?");
	 st.setInt(1, Integer.parseInt(""+request.getParameter("gameno")));
	 result = st.executeQuery();
	 result.next();
	 String words [] = result.getString(1).split("&");
	   for(int len =0; len<words.length;len++)
	   {
	   
	   out.print(""+words[len]);
	   out.print("\n");
	   }
	   out.print("</textarea>");
  }
  else
	  out.print(""+"Select Game of which moves need to be displayed");
	  
  out.print("</td>");
  
  out.print("</table>");
  out.println("<br></br>");
  
  out.print("<table border=3>");
  out.print("<tr>");
  
  out.print("<th>Existing Game Info</th>");
  out.print("<th>Click to join the gamezone</th>");
  out.print("</tr>");
  
  while(result.next())
 {
	 out.println(""+result.getString(1));
 }
 
  
  out.println("<h1> Join the existing game</h1>");
  out.println("<br></br>");

  
  ResultSet rs1;
 
  result = st.executeQuery("SELECT FirstPlayer_Id, SecondPlayer_Id FROM userinfo where Status='Waiting'");
  result.last();
  int f = result.getRow();
  int games[][] = new int [f][2];
  result.first();
    int n=0;
  while (n<f)
   {
       games[n][0]=result.getInt(1);
       games[n][1]=result.getInt(2);
       n++;
       result.next();
   }
    result.close();
int temp=0;

    while(temp<n)
    {
       int l=0;
        out.println("<tr>");
        out.println("<td>");
        st=con.prepareStatement("select user_name from usersrecord where Id=?");
        st.setInt(1, games[temp][0]);
        rs1= st.executeQuery();
        rs1.next();
        out.println("Game hosted by : "+rs1.getString(1));
        l++;
        out.println("<br></br>");
        rs1.close();
        if(games[temp][1]!=0)
        {
        st=con.prepareStatement("select user_name from usersrecord where Id=?");
        st.setInt(1, games[temp][1]);
        rs1= st.executeQuery();
        rs1.next();
        out.println("Game member:"+rs1.getString(1));
        out.println("<br></br>");
        l++;
        rs1.close();
        }    
        
      out.println("Current players: "+l);
    
       out.println("</td>");
       out.println("<td>");
    if(l<2)	   
    out.println("<form action=playgame.jsp method=post> <input type=hidden name=gameid value="+games[temp][0]+">  <input name =button type=submit value=JOIN> </input></form>");
       out.println("</td>");
     out.println("</tr>");
     temp++;
    }
  }
  catch( SQLException e ) 
  { 
      out.println(e.getMessage()); 
  } 
  %>
    <form action="playgame.jsp" method="post"> <input name ="button" type="submit" value="NEW GAME..!!"> </input></form>
<br />
    
</div>
<br></br>
<br></br>
<div>
  <form  action="endgame.jsp" target="_top" > 
	     <input name ="button" type="submit" value="LOgOut" /> 
	 </form>
    </div>
</body>
</html>
