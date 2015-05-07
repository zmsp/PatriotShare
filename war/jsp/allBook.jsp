<%@page import="java.text.DecimalFormat"%>
<%@ page import= "com.google.appengine.api.datastore.DatastoreService" %>
<%@ page import= "com.google.appengine.api.datastore.DatastoreServiceFactory"%>
<%@ page import= "com.google.appengine.api.datastore.Entity" %>
<%@ page import= "com.google.appengine.api.datastore.FetchOptions"%>
<%@ page import= "com.google.appengine.api.datastore.Key"%>
<%@ page import= "com.google.appengine.api.datastore.KeyFactory"%>
<%@ page import= "com.google.appengine.api.datastore.Query"%>
<%@ page import= "com.google.appengine.api.datastore.Transaction"%>
<%@ page import= "com.google.appengine.api.datastore.Query.Filter"%>
<%@ page import= "com.google.appengine.api.datastore.Query.FilterOperator"%>
<%@ page import= "com.google.appengine.api.datastore.Query.FilterPredicate"%>
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


		<h3>Books for sale by other users:</h3>

<%
if (request.getAttribute("error")!=null)
{%>
<p><span style="color: red">${error}</span></p>
<%} %>

		<div>
			<%
				DatastoreService datastore = DatastoreServiceFactory
								.getDatastoreService();
						String userID = (String)user.getProperty("loginID"); 
						Filter removeMyself = new FilterPredicate("email", FilterOperator.NOT_EQUAL, userID); 
						Query query = new Query("Book");
						query.setFilter(removeMyself); 
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
						<th>Owner</th>
						<th>Buy</th>
						<th>Info</th>
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
												out.print("<td>" + Book.getProperty("email") + "</td>");
												out.print("<td><a href=\"/orderReview/?key=" + KeyFactory.keyToString(Book.getKey()) + "\"class=\"btn btn-success\">Buy</a></td>");
												out.print("<td><a href=\"/get/?key=" + KeyFactory.keyToString(Book.getKey()) + "\"class=\"btn btn-info\">Book Info</a></td>");
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
