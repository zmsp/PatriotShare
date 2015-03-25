<%@page import="javax.json.stream.JsonParser.Event"%>
<%@page import="edu.gmu.mason.patriotshare.gae.db.BookInfo"%>
<%@ page import="com.google.appengine.api.datastore.*"%>
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
<title>Profile"</title>
<jsp:include page="/fragments/staticFiles.jsp" />
</head>
<body>
<jsp:include page="/fragments/bodyHeader.jsp" />

<div class="container-fluid"> 
<div class="col-sm-8">
		<div class="row">
		<h2>Matched Books</h2>
			<%
				DatastoreService datastore = DatastoreServiceFactory
							.getDatastoreService();
					Query query = new Query("Book");
					List<Entity> Books = datastore.prepare(query).asList(
							FetchOptions.Builder.withLimit(100));

					if (Books.isEmpty()) {
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
					<th>Asking Price</th>
					<th>Trade</th>
					<th>Get</th>
				</tr>
				</thead>
				<tbody>
				<%
				
					for (Entity Book : Books) {
									out.print("<tr>");
									String s= Book.getProperty("price").toString();
							
									out.print("<td>" + Book.getProperty("title") + "</td>");
									out.print("<td>" + Book.getProperty("isbn") + "</td>");
									DecimalFormat df = new DecimalFormat("0.00");
									out.print("<td> $" + df.format(Book.getProperty("price")) + "</td>");
									out.print("<td><a href=\"/trade/?isbn=" + Book.getProperty("isbn") + "\"class=\"btn btn-info\">Trade</a></td>");
									out.print("<td><a href=\"/get/?isbn=" + Book.getProperty("isbn") + "\"class=\"btn btn-info\">Get</a></td>");
									out.print("</tr>");

								}
							}
				%>
				</tbody>
			</table>

		</div>
				<div class="row">
		<h2>Books I own</h2>
			<%
					Query myQuery = new Query("Book");
					List<Entity> myBook = datastore.prepare(myQuery).asList(
							FetchOptions.Builder.withLimit(100));

					if (myBook.isEmpty()) {
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
									out.print("</tr>");

								}
							}
				%>
				</tbody>
			</table>

		</div>
</div>

		<div class="col-sm-4">
			<div class="panel panel-success">
				<div class="panel-heading">
					<h3 class="panel-title">My Profile</h3>
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
					<li class="list-group-item text-right"><span class="pull-left"><strong
							class="">Joined</strong></span> 2.13.2014</li>
					<li class="list-group-item text-right"><span class="pull-left"><strong
							class="">Last seen</strong></span> Yesterday</li>
					<li class="list-group-item text-right"><span class="pull-left"><strong
							class="">Name</strong></span>John Doe</li>

				</ul>

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