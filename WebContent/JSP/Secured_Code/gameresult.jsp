<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script>

        function validateForm() {
	
	   var response = document.forms["gameresponse"]["response"].value;
		   
	   var responsepattern =/^[A-z]+$/;
	   
	   if (response==null || response=="") {
	        alert("OOPS!!, Response is empty. Please type in");
	        return false;
	    }
	    else
	    {
	    result = response.match(responsepattern); 
	     if (result==null || result=="") {
	        alert("Response can have characters only!!");
	        return false;
	    }
	
}
}
</script>
    </head>
    <body>
        <% 
        
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/isa681",
        		"ISA681", "World@123");
        PreparedStatement  st =null;
        ResultSet rs =null;
        try
        {
       if(request.getParameter("button")!=null)
        {
           if((request.getParameter("button").equals("SUBMIT")))
        {
            
        String word = request.getParameter("response");
        word = word.trim();
        st = con.prepareStatement("select user_name from usersrecord where Id= ?");
        st.setInt(1, Integer.parseInt(""+session.getAttribute("userid")));
        rs = st.executeQuery();
        rs.next();
        String name= rs.getString(1);
        rs.close();
        
        st = con.prepareStatement("SELECT WordList FROM gamedata WHERE Game_Id= ?");
        st.setInt(1, Integer.parseInt(""+session.getAttribute("gameid")));
        rs = st.executeQuery();
        rs.next();
        
        String temp=rs.getString(1);
        String req=null;
        if(rs.getString(1).indexOf(":")!=-1)
        	req = ""+rs.getString(1).substring(rs.getString(1).lastIndexOf(":")+1, rs.getString(1).length());
        else
        	req = ""+rs.getString(1).charAt(rs.getString(1).length()-1);
        System.out.println("rs.getString(1).indexOf"+rs.getString(1).indexOf(":"));
        System.out.println("last word:"+req.trim());
        String words= rs.getString(1)+"&"+name+" : "+word;
        System.out.println("response word:"+""+word);
        System.out.println("previouslistofwords:"+""+temp);
        System.out.println("!req.trim().equals(word)"+!req.trim().equals(word));
        System.out.println("first characters"+req.trim().charAt(0)+":"+word.charAt(0));
        
        System.out.println("!words.contains(word)"+!temp.contains(word));
        rs.close();
          if(req.trim().length()==1 && req.trim().equalsIgnoreCase(""+word.charAt(0))|| req.trim().charAt(0)==word.charAt(0) && !req.trim().equals(word) && !temp.contains(word))	
        {    
       
        st = con.prepareStatement("Select count(*) from correctwords where correctword= ?");
        st.setString(1, word);
        rs = st.executeQuery();
        rs.next();
       
        if(rs.getInt(1)==1)
        {
        st = con.prepareStatement("UPDATE gamedata SET WordList = ? , currentID = ? where Game_ID = ?");
        st.setString(1, words);
        st.setInt(2, Integer.parseInt(""+session.getAttribute("userid")));
        st.setInt(3, Integer.parseInt(""+session.getAttribute("gameid")));
        int i =st.executeUpdate();
        
        st = con.prepareStatement("UPDATE userpoints SET score=score+10 where User_Id =?");
        st.setInt(1, Integer.parseInt(""+session.getAttribute("userid")));
        i=st.executeUpdate();   
        rs.close();
        
        st=con.prepareStatement("Select score from userpoints where User_Id = ?");
        st.setInt(1, Integer.parseInt(""+session.getAttribute("userid")));
        rs=st.executeQuery();

        rs.next();
        if(rs.getInt(1)==20)
        {
        rs.close();
   
        st=con.prepareStatement("delete from userpoints where User_Id = ?");
        st.setInt(1, Integer.parseInt(""+session.getAttribute("userid")));
        i= st.executeUpdate();
   
        st=con.prepareStatement("Select WordList from gamedata where currentID =  ?");
        st.setInt(1, Integer.parseInt(""+session.getAttribute("gameid")));
        rs = st.executeQuery();
        
        rs.next();
        String wordslist = rs.getString(1);
        rs.close();
    	System.out.println("GameID:"+session.getAttribute("gameid"));
       st=con.prepareStatement("select FirstPlayer_Id, SecondPlayer_Id from userinfo where FirstPlayer_Id =  ? and Status = 'Ready'");
        st.setInt(1, Integer.parseInt(""+session.getAttribute("gameid")));
        rs = st.executeQuery();
        
        st=con.prepareStatement("UPDATE userinfo SET Moves = ?, Status = ?  where FirstPlayer_Id = ? and Status ='Ready'");
        st.setString(1, wordslist);
        st.setString(2, "Compeleted&"+session.getAttribute("userid"));
        st.setInt(3, Integer.parseInt(""+session.getAttribute("gameid")));
        i = st.executeUpdate();
        st=con.prepareStatement("delete from gamedata where game_ID = ?");
        System.out.println("Testing");
        st.setInt(1, Integer.parseInt(""+session.getAttribute("gameid")));
        i= st.executeUpdate();
        System.out.println("Testing"+i);
        System.out.println("useriID:"+session.getAttribute("userid"));
        rs.next(); 
        System.out.println("rs.getInt(e)"+rs.getInt(1));
        System.out.println("rs.getInt(e)"+rs.getInt(2));
             
       for(int j=1; j<=2;j++)
       {
    	   if(rs.getInt(i)==Integer.parseInt((session.getAttribute("userid").toString())))
    	   {
    		   System.out.println("useriID:"+session.getAttribute("userid"));
    		   st=con.prepareStatement("UPDATE winstatistics SET Win_score=Win_score+1 where Id = ?");
    		   st.setInt(1, Integer.parseInt(""+session.getAttribute("userid")));
    		   st.executeUpdate();
    	   }
    	   else
    	   {
    		   st=con.prepareStatement("UPDATE winstatistics SET Loss_score=Loss_score+1 where Id = ?");
    		   st.setInt(1, rs.getInt(j));
    		   st.executeUpdate();
           }
    	   
       }
        
        }
        else
        {
        rs.close();    
        }
        }
        else
        {
        out.print("Alert word is invalid!!");
        }
       
        }
        else
        {
        out.print("OOPS!! your word should start with the letter prompted at the begining of the game!!");
        }
        
        }
        }
      
       //Made changes
       if(session.getAttribute("gameid")==null)
    	     out.print("<center><form name = 'gameresponse' action=gameresult.jsp onsubmit='return validateForm()'> <input type=hidden name=userid value="+session.getAttribute("userid")+"> <label> Response : </label> <input type=text name=response id =response> <input name =button type=submit value= SUBMIT> </form></center>");   
       else
       {
       st = con.prepareStatement("select currentID from gamedata where Game_id = ?");
       st.setInt(1, Integer.parseInt(""+session.getAttribute("gameid")));
       rs = st.executeQuery();
       
if(rs.next())
{
	if(rs.getInt(1)!=Integer.parseInt(""+session.getAttribute("userid")))
        {
        out.print("<center><form name = 'gameresponse' action=gameresult.jsp onsubmit='return validateForm()'> <input type=hidden name=userid value="+session.getAttribute("userid")+"> <label> Response : </label> <input type=text name=response id =response> <input name =button type=submit value= SUBMIT> </form></center>");
    response.addHeader("Refresh","6000;https://localhost:8443/SWE681_Project_Secured/JSP/Secured_Code/gameresult.jsp");
        }
        
        else
        response.addHeader("Refresh","1;https://localhost:8443/SWE681_Project_Secured/JSP/Secured_Code/gameresult.jsp");
      

}
else
        out.print("<center><form name = 'gameresponse' action=gameresult.jsp onsubmit='return validateForm()'> <input type=hidden name=userid value="+session.getAttribute("userid")+"> <label> Response : </label> <input type=text name=response id =response> <input name =button type=submit value= SUBMIT> </form></center>");
    
       }
     
        }
        catch( Exception e ) 
        { 
            out.println(e.getMessage()); 
        } 
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
    </body>
</html>
