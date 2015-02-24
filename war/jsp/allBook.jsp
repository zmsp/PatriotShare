<%@ page import="com.google.appengine.api.datastore.*"%>
<%@ page import="java.util.List"%>

<!DOCTYPE html>
<html lang="en">

<!-- Import library and scripts are from this file -->
<jsp:include page="/fragments/staticFiles.jsp" />

<body>
	<jsp:include page="/fragments/bodyHeader.jsp" />
	<div class="container">


		<h3>Book List:</h3>

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
					<th>Price</th>
					<th>Add</th>
				</tr>
				</thead>
				<tbody>
				<%
					for (Entity Book : Books) {
									out.print("<tr>");
									
									out.print("<td>" + Book.getProperty("title") + "</td>");
									out.print("<td>" + Book.getProperty("isbn") + "</td>");
									out.print("<td>" + Book.getProperty("price") + "</td>");
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
