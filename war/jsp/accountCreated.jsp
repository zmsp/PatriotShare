<%@page import="java.text.DecimalFormat"%>
<%@ page import="com.google.appengine.api.datastore.*"%>
<%@ page import="java.util.List"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">

<!-- Import CSS -->
<jsp:include page="/fragments/staticFiles.jsp" />

<body>
	<jsp:include page="/fragments/bodyHeader.jsp" />
	<div class="container">

	<h1>Your account was created with following information</h1>
	<h3>Name: ${name}</h3>
	<h3>Email: ${email}</h3>
	<h3>Terms: ${terms}</h3>
	<h3>Email Notification: ${notification}</h3>
	<h3>Password Md5: ${md5}</h3>
	
	We are still implementing email verifications 
	
	Data Store:
	<div>
			<%
				DatastoreService datastore = DatastoreServiceFactory
							.getDatastoreService();
					Query query = new Query("UserProfile");
					List<Entity> Users = datastore.prepare(query).asList(
							FetchOptions.Builder.withLimit(100));

					if (Users.isEmpty()) {
			%>
			<p>There are no books listed.</p>
			<%
				} else {
			%>








			<h1>Following Table is from our datastore</h1>
			<table id="example" class="display">
				<thead>
				<tr>
					<th>First</th>
					<th>Last</th>
					<th>Login ID</th>
					<th>Hash Password</th>
					<th>terms</th>
					<th>notification</th>
				</tr>
				</thead>
				<tbody>
				<%
				
					for (Entity User : Users) {
									out.print("<tr>");
									
									out.print("<td>" + User.getProperty("firstName") + "</td>");
									out.print("<td>" + User.getProperty("lastName") + "</td>");
									out.print("<td>" + User.getProperty("loginID") + "</td>");
									
									out.print("<td> " + User.getProperty("password") + "</td>");
									out.print("<td> " + User.getProperty("terms") + "</td>");
									out.print("<td> " + User.getProperty("notification") + "</td>");
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
