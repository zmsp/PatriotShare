<%@page import="java.text.DecimalFormat"%>
<%@ page import="com.google.appengine.api.datastore.*"%>
<%@ page import="java.util.List"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">

	<%
	//allow access only if session exists
	Entity user = null;
	//String user = null;
	
	if( (session.getAttribute("username") == null)) {
		//response.sendRedirect("login.jsp");
		
	} else {
		user = (Entity) session.getAttribute("username");
		//String name = (String) user.getProperty("firstName");
		String sessionID = session.getId();
				
	}
	%>

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
					Query queryUserProfile = new Query("UserProfile");
					List<Entity> Books = datastore.prepare(queryBook).asList(FetchOptions.Builder.withLimit(100));
					List<Entity> UserProfiles = datastore.prepare(queryUserProfile).asList(FetchOptions.Builder.withLimit(100));
					if (UserProfiles.isEmpty()) {
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
					
					String [] names = new String[UserProfiles.size()];
					Double [] prices = new Double[Books.size()];
					
					for (int i=0; i <UserProfiles.size(); i++) {
						
						if (UserProfiles.get(i) != null)
							names[i] = (String)UserProfiles.get(i).getProperty("loginID");
								
					}
					
					for (int i=0; i <Books.size(); i++) {
						if (Books.get(i) != null)
							prices[i] = (Double)Books.get(i).getProperty("price");
					}
				
				
					//for (Entity users : UserProfiles) {
					  for (int i=0; i <UserProfiles.size(); i++) {
						//if(request.getParameter("isbn").equals(users.getProperty("isbn"))) {
							
						
							out.print("<tr>");
							out.print("<td>" + names[i] + "</td>");
							out.print("<td> 3.10 </td>");
							//String p = Book.getProperty("price").toString();
							//DecimalFormat df = new DecimalFormat("0.00");
							
							//if (prices[i] != null)
							out.print("<td> $" + prices[i].doubleValue() + "</td>");
							
							out.print("<td><a href=\"/tradeConfirmation/?isbn=" + "" /*Book.getProperty("isbn")*/ + "\"class=\"btn btn-info\">Trade</a></td>");
							out.print("<td><a href=\"#" + "\"class=\"btn btn-info\">Buy</a></td>");
							out.print("</tr>");
						//}	
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
