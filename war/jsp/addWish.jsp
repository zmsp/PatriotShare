<%@page import="javax.json.stream.JsonParser.Event"%>
<%@page import="edu.gmu.mason.patriotshare.gae.db.BookInfo"%>
<%@ page import="com.google.appengine.api.datastore.DatastoreService"%>
<%@ page
	import="com.google.appengine.api.datastore.DatastoreServiceFactory"%>
<%@ page import="com.google.appengine.api.datastore.Entity"%>
<%@ page import="com.google.appengine.api.datastore.FetchOptions"%>
<%@ page import="com.google.appengine.api.datastore.Key"%>
<%@ page import="com.google.appengine.api.datastore.KeyFactory"%>
<%@ page import="com.google.appengine.api.datastore.Query"%>
<%@ page import="com.google.appengine.api.datastore.Transaction"%>
<%@ page import="com.google.appengine.api.datastore.Query.Filter"%>
<%@ page
	import="com.google.appengine.api.datastore.Query.FilterOperator"%>
<%@ page
	import="com.google.appengine.api.datastore.Query.FilterPredicate"%>
<%@ page import="java.util.List"%>
<%@ page import="javax.json.*"%>
<%@page import="java.text.DecimalFormat"%>
<%@ page import="java.io.InputStream"%>
<%@ page import="edu.gmu.mason.patriotshare.gae.db.BookPrices"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
