<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body>
    <%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>

    
 <%  
 
 Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/isa681",
        		"ISA681", "World@123");
        PreparedStatement  st =null;
        ResultSet rs =null;
        try
        {
            int userIds [] = new int[2];
               	 
        	 st=con.prepareStatement("UPDATE userpoints SET Status = ?  where User_Id = ? ");
             st.setString(1, "I");
             st.setInt(2, Integer.parseInt(""+session.getAttribute("userid")));
             st.executeUpdate();
             response.sendRedirect("initiategame.jsp");
             st = con.prepareStatement("SELECT SecondPlayer_Id FROM userinfo where Status = 'Ready' and FirstPlayer_Id = ?");
             st.setInt(1, Integer.parseInt(""+session.getAttribute("gameid")));
             rs = st.executeQuery();
if(!rs.next())
{
	    st = con.prepareStatement("SELECT SecondPlayer_Id FROM userinfo where Status = 'Paused' and FirstPlayer_ID = ?");
	st.setInt(1, Integer.parseInt(""+session.getAttribute("gameid")));
    rs = st.executeQuery();
	
}
             
             userIds[0] = Integer.parseInt(""+session.getAttribute("gameid"));
             rs.next();
             
                userIds[1] = rs.getInt(1);             	 
                
             int temp=0;
             
             for(int i=0;i<userIds.length;i++)
             {
            	 st=con.prepareStatement("SELECT count(*) from userpoints where User_Id = ? and status = 'I' ");
                 st.setInt(1,userIds[i]);
                 rs = st.executeQuery();
               
                 rs.next();
                
                 if(rs.getInt(1) == 1 )
                	 temp++; 
            	  
             }
             out.println(""+"Value of w : "+temp);
	        
	       	if (temp==2)
             {
            	  st=con.prepareStatement("Select WordList from gamedata where Game_Id =  ?");
                  st.setInt(1, Integer.parseInt(""+session.getAttribute("gameid")));
                  rs = st.executeQuery();
                  rs.next();
                  String wordslist = rs.getString(1);
                  rs.close();
 
                  st=con.prepareStatement("UPDATE userinfo SET Moves = ?, Status = ?  where FirstPlayer_Id = ? and Status ='Paused'");
                  st.setString(1, wordslist);
                  st.setString(2, "Paused");
                  st.setInt(3, Integer.parseInt(""+session.getAttribute("gameid")));
                  st.executeUpdate();
            	 
                  st=con.prepareStatement("delete from userpoints where User_Id = ? or User_Id = ?");
                 st.setInt(1, userIds[0]);
                 st.setInt(2, userIds[1]);
                 st.executeUpdate();
            	 
                 st=con.prepareStatement("delete from gamedata where Game_Id = ?");
                 st.setInt(1, Integer.parseInt(""+session.getAttribute("gameid")));
                 st.executeUpdate();
                 
                        
                 for(int i=0;i<userIds.length;i++)
                {
             	   if(userIds[i]==Integer.parseInt(""+session.getAttribute("userid")))
             	   {
             		   st=con.prepareStatement("UPDATE winstatistics SET Win_score=Win_score+1 where Id = ?");
             		   st.setInt(1, Integer.parseInt(""+session.getAttribute("userid")));
             		   st.executeUpdate();
             	   }
             	   else
             	   {
             		   st=con.prepareStatement("UPDATE winstatistics SET Loss_score=Loss_score+1 where Id = ?");
             		   st.setInt(1, userIds[i]);
             		   st.executeUpdate();
                   }
             	   
                }

                 
             }
             
	       	else if(temp == 1)	 
			{
                                   
                  st=con.prepareStatement("UPDATE userinfo SET  Status = ?  where FirstPlayer_Id = ? and Status ='Ready'");
                  st.setString(1, "Paused");
                  st.setInt(2, Integer.parseInt(""+session.getAttribute("gameid")));
                  st.executeUpdate();
	             
			}
        	 session.removeAttribute("gameid");
	
             
         }
        catch( SQLException e ) 
        { 
            out.println(e.getMessage()); 
        e.printStackTrace();             
        } 
        
       %>
    </body>
</html>
