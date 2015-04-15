<%@page import="java.text.DecimalFormat"%>
<%@ page import="com.google.appengine.api.datastore.*"%>
<%@ page import="java.util.List"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">

<!-- Import library and scripts are from this file -->
<jsp:include page="/fragments/staticFiles.jsp" />
	<%
	//allow access only if session exists
	Entity user = null;
	
	if(session.getAttribute("username") == null){
		response.sendRedirect("/jsp/login.jsp"); 
		return; 
	}else user = (Entity) session.getAttribute("username");

	String sessionID = session.getId();

	%>
<body>
	<jsp:include page="/fragments/bodyHeader.jsp" />
	<div class="container">
		<div class='row'>
			<div class='col-sm-12 well'>
				<h2>The Book Hub</h2>
				<form action="/getBookInfo" method="post">
					<h4>
						Please enter the 10 or 13 digit ISBN number:
					</h4>
					<br >
					<div class="form-group">
					<table border="0"; style="border-spacing:10px;">
						<tr>
							<td>
								<span class="glyphicon glyphicon-search"></span>&nbsp;&nbsp;
							</td>
							<td width="480px">
								<input name="isbn" type="text" class="form-control" id="isbn" placeholder="Enter ISBN# here" pattern="\d{10}|\d{13}">
							</td>	
							<td>	
								&nbsp;&nbsp;<button type="Search" class="btn btn-primary"><i class="icon-user icon-white"></i>Search</button>
							</td>
						</tr>
					</table>	
			    	</div>
			    </form>	
			</div>
		</div>
	</div>
	<jsp:include page="/fragments/footer.jsp" />


</body>
</html>