<%@page import="java.text.DecimalFormat"%>
<%@ page import="com.google.appengine.api.datastore.*"%>
<%@ page import="java.util.List"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">

<!-- Import library and scripts are from this file -->
<jsp:include page="/fragments/staticFiles.jsp" />

<body>
	<jsp:include page="/fragments/bodyHeader.jsp" />
	<div class="container">

		<h3>Matched Results:</h3>
		<div>
			<%
				DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
					Query queryBook = new Query("Book");
					Query queryUser = new Query("User");
					List<Entity> Books = datastore.prepare(queryBook).asList(FetchOptions.Builder.withLimit(100));
					List<Entity> Users = datastore.prepare(queryUser).asList(FetchOptions.Builder.withLimit(100));
					if (Books.isEmpty()) {
			%>
			<p>Sorry, currently there are no matches :-(</p>
			<%
				} else {
			%>
			
			<table id="example" class="display">
				<thead>
				<tr>
					<th>User Name</th>
					<th>Rating</th>
					<th>Price</th>
					<th>Trade</th>
					<th>Buy</th>
				</tr>
				</thead>
				<tbody>
				<%
					for (Entity Book : Books) {
						
						if(request.getParameter("isbn").equals(Book.getProperty("isbn"))) {
							
						
							out.print("<tr>");
							out.print("<td>" + Book.getProperty("userid") + "</td>");
							out.print("<td> 3.10 </td>");
							String p = Book.getProperty("price").toString();
							DecimalFormat df = new DecimalFormat("0.00");
							out.print("<td> $" + df.format(Book.getProperty("price")) + "</td>");
							out.print("<td><a href=\"/tradeConfirmation/?isbn=" + Book.getProperty("isbn") + "\"class=\"btn btn-info\">Trade</a></td>");
							out.print("<td><a href=\"#" + "\"class=\"btn btn-info\">Buy</a></td>");
							out.print("</tr>");
						}	
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
