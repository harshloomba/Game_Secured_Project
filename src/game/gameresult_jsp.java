/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/8.0.21
 * Generated at: 2015-05-01 22:11:49 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package game;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.DriverManager;
import java.sql.Connection;

public final class gameresult_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent,
                 org.apache.jasper.runtime.JspSourceImports {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  private static final java.util.Set<java.lang.String> _jspx_imports_packages;

  private static final java.util.Set<java.lang.String> _jspx_imports_classes;

  static {
    _jspx_imports_packages = new java.util.HashSet<>();
    _jspx_imports_packages.add("javax.servlet");
    _jspx_imports_packages.add("javax.servlet.jsp");
    _jspx_imports_packages.add("javax.servlet.http");
    _jspx_imports_classes = new java.util.HashSet<>();
    _jspx_imports_classes.add("java.sql.Connection");
    _jspx_imports_classes.add("java.sql.ResultSet");
    _jspx_imports_classes.add("java.sql.SQLException");
    _jspx_imports_classes.add("java.sql.DriverManager");
    _jspx_imports_classes.add("java.sql.PreparedStatement");
    _jspx_imports_classes.add("java.sql.Statement");
  }

  private javax.el.ExpressionFactory _el_expressionfactory;
  private org.apache.tomcat.InstanceManager _jsp_instancemanager;

  public java.util.Map<java.lang.String,java.lang.Long> getDependants() {
    return _jspx_dependants;
  }

  public java.util.Set<java.lang.String> getPackageImports() {
    return _jspx_imports_packages;
  }

  public java.util.Set<java.lang.String> getClassImports() {
    return _jspx_imports_classes;
  }

  public void _jspInit() {
    _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
    _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(getServletConfig());
  }

  public void _jspDestroy() {
  }

  public void _jspService(final javax.servlet.http.HttpServletRequest request, final javax.servlet.http.HttpServletResponse response)
        throws java.io.IOException, javax.servlet.ServletException {

final java.lang.String _jspx_method = request.getMethod();
if (!"GET".equals(_jspx_method) && !"POST".equals(_jspx_method) && !"HEAD".equals(_jspx_method) && !javax.servlet.DispatcherType.ERROR.equals(request.getDispatcherType())) {
response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "JSPs only permit GET POST or HEAD");
return;
}

    final javax.servlet.jsp.PageContext pageContext;
    javax.servlet.http.HttpSession session = null;
    final javax.servlet.ServletContext application;
    final javax.servlet.ServletConfig config;
    javax.servlet.jsp.JspWriter out = null;
    final java.lang.Object page = this;
    javax.servlet.jsp.JspWriter _jspx_out = null;
    javax.servlet.jsp.PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html;charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<!DOCTYPE html>\r\n");
      out.write("<html>\r\n");
      out.write("    <head>\r\n");
      out.write("        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\r\n");
      out.write("        <title>JSP Page</title>\r\n");
      out.write("        <script>\r\n");
      out.write("function validateForm() {\r\n");
      out.write("\t\r\n");
      out.write("\t   var response = document.forms[\"gameresponse\"][\"response\"].value;\r\n");
      out.write("\t\t   \r\n");
      out.write("\t   var responsepattern =/^[A-z]+$/;\r\n");
      out.write("\t   \r\n");
      out.write("\t   if (response==null || response==\"\") {\r\n");
      out.write("\t        alert(\"OOPS!!, Response is empty. Please type in\");\r\n");
      out.write("\t        return false;\r\n");
      out.write("\t    }\r\n");
      out.write("\t    else\r\n");
      out.write("\t    {\r\n");
      out.write("\t    result = response.match(responsepattern); \r\n");
      out.write("\t     if (result==null || result==\"\") {\r\n");
      out.write("\t        alert(\"Response should have only charcters Please retype\");\r\n");
      out.write("\t        return false;\r\n");
      out.write("\t    }\r\n");
      out.write("\t\r\n");
      out.write("}\r\n");
      out.write("}\r\n");
      out.write("</script>\r\n");
      out.write("    </head>\r\n");
      out.write("    <body>\r\n");
      out.write("        ");
 
        
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
        if(rs.getInt(1)==50)
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
        st=con.prepareStatement("delete from gamedata where currentID = ?");
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
        out.print("OOPS!! your word must continue with the end character of previous word");
        }
        
        }
        }
       if(session.getAttribute("gameid")!=null)
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
        {
        response.addHeader("Refresh","1;https://localhost:8443/SWE681_Project_Secured/JSP/Secured_Code/gameresult.jsp");
        }

}
else
{
        out.print("<center><form name = 'gameresponse' action=gameresult.jsp onsubmit='return validateForm()'> <input type=hidden name=userid value="+session.getAttribute("userid")+"> <label> Response : </label> <input type=text name=response id =response> <input name =button type=submit value= SUBMIT> </form></center>");
    
}
       }
       else
       {
    	     out.print("<center><form name = 'gameresponse' action=gameresult.jsp onsubmit='return validateForm()'> <input type=hidden name=userid value="+session.getAttribute("userid")+"> <label> Response : </label> <input type=text name=response id =response> <input name =button type=submit value= SUBMIT> </form></center>");
    	      	   
       }

        }
        catch( SQLException e ) 
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
        }  
        
      out.write("    \r\n");
      out.write("    </body>\r\n");
      out.write("</html>\r\n");
    } catch (java.lang.Throwable t) {
      if (!(t instanceof javax.servlet.jsp.SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try {
            if (response.isCommitted()) {
              out.flush();
            } else {
              out.clearBuffer();
            }
          } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
