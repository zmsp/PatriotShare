<!-- You guys dont need to add imports or other html tags -->
<%@page import="javax.json.stream.JsonParser.Event"%>
<%@page import="edu.gmu.mason.patriotshare.gae.db.BookInfo"%>
<%@ page import="com.google.appengine.api.datastore.*"%>
<%@ page import="java.util.List"%>
<%@ page import="javax.json.*"%>
<%@page import="java.text.DecimalFormat"%>
<%@ page import="java.io.InputStream"%>
<%@ page import="edu.gmu.mason.patriotshare.gae.db.BookPrices"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
	<%
	//allow access only if session exists
	Entity user = null;
	
	if(session.getAttribute("username") == null){
	%> 		
<div class="navbar navbar-default navbar-static-top">
	
        <div class="container">
        <a href='/jsp/index.jsp' class='navbar-brand'><i class='glyphicon glyphicon-book'></i> PatriotShare</a>
          <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
              <span class="sr-only">Toggle navigation</span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
            </button>
          </div>
          <div id="navbar" class="navbar-collapse collapse">
            <ul class="nav navbar-nav">


  
            
              
            </ul>
            <ul class="nav navbar-nav navbar-right">
              <!--<li style="background-color:#CCC66C" active><a href="./">Sign up <span class="sr-only">(current)</span></a></li>-->
              <li style="background-color:#CCC66C; font-size: 8pt" active><a href="/jsp/signup.jsp">Sign Up<span class="sr-only">(current)</span></a></li>
              <li style="background-color:#CCC66C; font-size: 8pt" active><a href="/login">Login<span class="sr-only">(current)</span></a></li>
            </ul>
          </div><!--/.nav-collapse -->
        </div><!--/.container-fluid -->
      </div>
      
      <%}else 
    	{user = (Entity) session.getAttribute("username");

		String sessionID = session.getId(); %>
	
	
	<div class="navbar navbar-default navbar-static-top">
	
        <div class="container">
        <a href='/jsp/index.jsp' class='navbar-brand'><i class='glyphicon glyphicon-book'></i> PatriotShare</a>
          <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
              <span class="sr-only">Toggle navigation</span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
            </button>
          </div>
          <div id="navbar" class="navbar-collapse collapse">
            <ul class="nav navbar-nav">
            <!--<li class="dropdown"> -->
                <!--  <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Start Here <span class="caret"></span></a>-->
                <!-- <ul class="dropdown-menu" role="menu"> -->
                  <li style="font-size: 8pt"><a href="/addbook">Sell A Book</a></li>
                  <li style="font-size: 8pt"><a href="/allbook">Buy A Book</a></li>
                  <!-- <li class="disabled"><a href='#'>Find A Match</a></li> -->
                  <!-- <li class="disabled"><a href='#'>My Profile</a></li> -->

                </ul>
              </li>
            
              
            </ul>
            <ul class="nav navbar-nav navbar-right">
               <li style="font-size: 8pt"><a href="/jsp/userProfile.jsp"><i class='glyphicon glyphicon-user'></i><%out.print(user.getProperty("firstName") + " " + user.getProperty("lastName"));%></a></li>
              <li style="background-color:#CCC66C; font-size:8pt" active><a href="<%=request.getContextPath()%>/logout">Log out<span class="sr-only">(current)</span></a></li>
            </ul>
          </div><!--/.nav-collapse -->
        </div><!--/.container-fluid -->
      </div>
      
      <%} %>
