<%@ page import="com.google.appengine.api.datastore.*"%>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html lang="en">

<!-- Import library and scripts are from this file -->
<jsp:include page="/fragments/staticFiles.jsp" />

<body>
	<jsp:include page="/fragments/bodyHeader.jsp" />
	<div class="container">
	
		
		Booklist
		
		<div>
			<%
				// LIST ALL DEFINED TOPICS

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





				<h3>Book List:</h3>
				
				
<div class="input-group"> <span class="input-group-addon">Filter</span>

    <input id="filter" type="text" class="form-control" placeholder="Search Now">
</div>
				<table class="table table-hover">
				<tr>
					<th>ISBN</th>
					<th>Title</th>
					<th>Price</th>
				</tr>
				<%
				for (Entity Book : Books) {
					out.print("<tr>");
						out.print("<td>"+Book.getKey().getName()+"</td>");
						out.print("<td>"+Book.getProperty("title")+"</td>");
						out.print("<td>"+Book.getProperty("price")+"</td>");
						out.print("</tr>");
						
					}
				}
				
			%>
			</table>
			
		</div>

<<<<<<< Updated upstream
		<div style="margin:5% 0 0 0 ">
			<jsp:include page="/fragments/footer.jsp" />
		</div>
=======
>>>>>>> Stashed changes

	</div>
	<jsp:include page="/fragments/footer.jsp" />
</body>

</html>
