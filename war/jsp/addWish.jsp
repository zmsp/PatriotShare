<!DOCTYPE html>
<html lang="en">
<%@ page import="com.google.appengine.api.datastore.*"%>


<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

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
		<form action="/addWish" method="post">
			<div class="form-group">
				<label for="bookTitle">Book Title</label> <input required="required" type="text"
					class="form-control" id="bookTitle" placeholder="Enter book title"
					name="title">
			</div>

			<div class="form-group">
				<label for="bookISBN">Book ISBN (10 or 13 digit)</label> <input required="required" name="ISBN"
					type="text" class="form-control" id="bookISBN"
					placeholder="Book ISBN goes here" pattern="\d{10}|\d{13}">
			</div>
			
			<div>
				<input type="hidden" name="email" value= "<%  out.print(user.getProperty("loginID")); %>"> 
			</div>

			<button type="submit" class="btn btn-primary">
				<i class="icon-user icon-white"></i> Add 
			</button>
		</form>

	</div>


	<jsp:include page="/fragments/footer.jsp" />


</body>

</html>
