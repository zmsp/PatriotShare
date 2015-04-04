<!DOCTYPE html>
<html lang="en">

<%@ page import="com.google.appengine.api.datastore.*"%>
<%@ page import="java.util.List"%>
<%@ page import="javax.servlet.http.*" %>

	<%
	//allow access only if session exists
	Entity user = null;
	
	if(session.getAttribute("user") == null){
		response.sendRedirect("jsp/login.jsp"); 
		return; 
	}else user = (Entity) session.getAttribute("user");

	String sessionID = session.getId();

	%>

<!-- Import CSS -->
<jsp:include page="/fragments/staticFiles.jsp" />

<body>

		<jsp:include page="/fragments/bodyHeader.jsp" />

	

	<div class="container">
		<div class='row'>
			<div class='col-sm-12 well'>

				<h2>Welcome <%  out.print(user.getProperty("firstName")); %> to PatriotShare!</h2>
				<h4>
					Our mission at PatriotShare&copy is to empower and enable GMU
					students to make smart decisions when it comes to their textbooks.
					<br />
					<br />
					Get started today and see how much you can save!
				</h4>
				<br >
				<form action="/getBookInfo" method="post">
					<div class="form-group">
					<table border="0"; style="border-spacing:10px;">
						<tr>
							<td>
								<span class="glyphicon glyphicon-search"></span>&nbsp;&nbsp;
							</td>
							<td width="480px">
								<input required="required" name="isbn" type="text" class="form-control" id="isbn" placeholder="Enter the 10 or 13 digit ISBN number" pattern="\d{10}|\d{13}">
							</td>	
							<td>	
								&nbsp;&nbsp;<button type="Search" class="btn btn-primary"><i class="icon-user icon-white"></i>Find A Book</button>
							</td>
						</tr>
						<tr>
							<td> &nbsp; </td>
						</tr>
						<tr>
							<td>&nbsp;</td><td><a class="btn btn-primary" href="/jsp/allBook.jsp" role="button">My Books</a>
												<a class="btn btn-primary" href="/addbook" role="button">Sell A Book</a> </td>
						</tr>
					</table>	
			    	</div>
			    </form>	
				<br >
				
				
			</div>

		</div>

	</div>
	<jsp:include page="/fragments/footer.jsp" />
	
	
</body>

</html>


				
			