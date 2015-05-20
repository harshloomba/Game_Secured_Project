<!DOCTYPE html>
<html>
    <%
 
       	out.print("<frameset rows='50%, 50%'>");
   
        if(request.getParameter("gameid")!=null)
        out.print("<frame src=rungame.jsp?button="+request.getParameter("button")+"&gameid="+request.getParameter("gameid")+">");
        
        else
        	out.print("<frame src=rungame.jsp?button="+request.getParameter("button")+">");
        
        out.print("<frame src='gameresult.jsp'>");
        out.print("</frameset>");
   %>

</html>
