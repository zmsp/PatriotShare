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


		<h3>My Book List:</h3>

		<div>
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
					<!--<th>Trade</th> -->
					<!--<th>Get</th>  -->
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
									//out.print("<td><a href=\"/trade/?isbn=" + Book.getProperty("isbn") + "\"class=\"btn btn-info\">Trade</a></td>");
									//out.print("<td><a href=\"/get/?isbn=" + Book.getProperty("isbn") + "\"class=\"btn btn-info\">Get</a></td>");
									out.print("</tr>");

								}
							}
				%>
				</tbody>
			</table>

		</div>
		
			<h3>My Wish List:</h3>
			<div>
			<%
			
			DatastoreService datastor = DatastoreServiceFactory
							.getDatastoreService();
					Query q = new Query("BookWish");
					List<Entity> WishBooks = datastor.prepare(q).asList(
							FetchOptions.Builder.withLimit(100));

					if (WishBooks.isEmpty()) {
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
					<!--<th>Asking Price</th>-->
					<!--<th>Trade</th> -->
					<!--<th>Get</th>  -->
				</tr>
				</thead>
				<tbody>
		    <%
				
					for (Entity BookWish : WishBooks) {
									out.print("<tr>");
									out.print("<td>" + BookWish.getProperty("title") + "</td>");
									out.print("<td>" + BookWish.getProperty("isbn") + "</td>");
									//out.print("<td><a href=\"/trade/?isbn=" + Book.getProperty("isbn") + "\"class=\"btn btn-info\">Trade</a></td>");
									//out.print("<td><a href=\"/get/?isbn=" + Book.getProperty("isbn") + "\"class=\"btn btn-info\">Get</a></td>");
									out.print("</tr>");

								}
							}
				%>
				</tbody>
			</table>

		</div>

	</div>
	<jsp:include page="/fragments/footer.jsp" />

	<script type="text/javascript">
		// For demo to fit into DataTables site builder...
		$('#example').removeClass('display').addClass(
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
		});
	</script>
</body>

</html>
