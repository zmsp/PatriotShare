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

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Profile</title>
<jsp:include page="/fragments/staticFiles.jsp" />
</head>
<body>

	<%
		//allow access only if session exists
		Entity user = null;
		
		if(session.getAttribute("username") == null){
			response.sendRedirect("/jsp/login.jsp"); 
			return; 
		}else user = (Entity) session.getAttribute("username");

		String sessionID = session.getId();
	%>
	<jsp:include page="/fragments/bodyHeader.jsp" />

	<div class="container-fluid">
		<div class="col-sm-12">

			<div class="col-xs-12 col-sm-4">
				<div class="panel panel-success">
					<div class="panel-heading">
						<h3 class="panel-title">
							<%
								out.print(user.getProperty("firstName"));
							%>'s Profile
						</h3>
					</div>
					<img src="/resources/profile.jpg" alt="..."
						class="img-circle center-block">
					<div class="ratings">
						<p class="pull-right">3 reviews</p>
						<p>
							<span class="glyphicon glyphicon-star"></span> <span
								class="glyphicon glyphicon-star"></span> <span
								class="glyphicon glyphicon-star"></span> <span
								class="glyphicon glyphicon-star"></span> <span
								class="glyphicon glyphicon-star-empty"></span> 4.0 stars
						</p>
					</div>
					<ul class="list-group">
						<li class="list-group-item text-muted" contenteditable="false">Profile</li>
						<li class="list-group-item text-right"><span
							class="pull-left"><strong class="">Joined</strong></span>
							2.13.2014</li>
						<li class="list-group-item text-right"><span
							class="pull-left"><strong class="">Last seen</strong></span>
							Yesterday</li>
						<li class="list-group-item text-right"><span
							class="pull-left"><strong class="">Name</strong></span>
							<%
								out.print(user.getProperty("firstName") + " " + user.getProperty("lastName"));
							%></li>
						<li class="list-group-item text-right"><span
							class="pull-left"><strong class="">Email</strong></span>
							<%
								out.print(user.getProperty("loginID"));
							%></li>
					</ul>

				</div>

			</div>

				<%
					DatastoreService datastore = null; 
					Query query = null;
					List<Entity> matched = null;
					String myEmail = (String)user.getProperty("loginID");
						
					 datastore = DatastoreServiceFactory.getDatastoreService();
				%>



				<div class="col-xs-12 col-sm-8">
					<h2>Books I have for sale <a class="btn btn-success" href="/addbook" role="button"><span class="glyphicon glyphicon-plus-sign"></span></a></h2>
					
					<%
						Filter userBooks = new FilterPredicate("email", FilterOperator.EQUAL, myEmail);
						
							//"User" is the entity to search
							Query mybookquery = new Query("Book");

							//Links the entity to the search filter
							mybookquery.setFilter(userBooks);
							
							//Creates the list that has the search results based on the filter applied
							//The limit should not have to be increased since we are expecting either 1 or 0 results
							List<Entity> myBook = datastore.prepare(mybookquery).asList(FetchOptions.Builder.withLimit(100));
							if(myBook.isEmpty()){
					%>
					<p>There are no books listed.</p>
					<%
						} else {
					%>


					<table id="example2" class="display">
						<thead>
							<tr>
								<th>Book Title</th>
								<th>ISBN</th>
								<th>Asking Price</th>
								<th>Remove</th>
							</tr>
						</thead>
						<tbody>
							<%
								for (Entity Book : myBook) {
														out.print("<tr>");
														String s= Book.getProperty("price").toString();
												
														out.print("<td>" + Book.getProperty("title") + "</td>");
														out.print("<td>" + Book.getProperty("isbn") + "</td>");
														DecimalFormat df = new DecimalFormat("0.00");
														out.print("<td> $" + df.format(Book.getProperty("price")) + "</td>");
														out.print("<td><a href=\"/profile/?isbn=" + Book.getProperty("isbn") + "&email=" + Book.getProperty("email") + "\"class=\"btn btn-danger\">Sold</a></td>");
														out.print("</tr>");

													}
												}
							%>
						</tbody>
					</table>

				</div>
				
				<div class="col-xs-12 col-sm-8">
					<h2>My Wish List
					<a class="btn btn-success" href="/addWish" role="button"><span class="glyphicon glyphicon-plus-sign"></span></a>
					
					
					</h2>
					<%
					Filter userWish = new FilterPredicate("email", FilterOperator.EQUAL, myEmail);
					
					//"User" is the entity to search
					Query mywishquery = new Query("BookWish");

					//Links the entity to the search filter
					mywishquery.setFilter(userWish);
					
					//Creates the list that has the search results based on the filter applied
					//The limit should not have to be increased since we are expecting either 1 or 0 results
					List<Entity> myWish = datastore.prepare(mywishquery).asList(FetchOptions.Builder.withLimit(100));
					if(myWish.isEmpty()){
					
					
					%>
					<p>There are no books listed.</p>
					<%
						} else {
					%>


					<table id="example" class="display">
						<thead>
							<tr>
								<th>Book Title</th>
								<th>ISBN</th>
								</tr>
						</thead>
						<tbody>
							<%
								for (Entity Book : myWish) {
														out.print("<tr>");
												
														out.print("<td>" + Book.getProperty("title") + "</td>");
														out.print("<td>" + Book.getProperty("isbn") + "</td>");
														out.print("</tr>");

													}
												}
							%>
						</tbody>
					</table>

				</div>
			</div>


		</div>
		<jsp:include page="/fragments/footer.jsp" />
</body>

<script type="text/javascript">
	// For demo to fit into DataTables site builder...
	$('#example').removeClass('display').addClass(
			'table table-striped table-bordered');
	$('#example2').removeClass('display').addClass(
			'table table-striped table-bordered');
</script>
<script type="text/javascript" language="javascript"
	src="//code.jquery.com/jquery-1.10.2.min.js"></script>
<script type="text/javascript" language="javascript"
	src="//cdn.datatables.net/1.10.5/js/jquery.dataTables.min.js"></script>
<script type="text/javascript" language="javascript"
	src="//cdn.datatables.net/plug-ins/f2c75b7247b/integration/bootstrap/3/dataTables.bootstrap.js"></script>
<script type="text/javascript" charset="utf-8">
	$(document).ready(function() {
		$('#example').dataTable();
		$('#example2').dataTable();
	});
</script>

</html>