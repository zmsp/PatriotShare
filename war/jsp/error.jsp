<%@ page isErrorPage="true" import="java.io.*"%>

<!DOCTYPE html>
<html lang="en">

<!-- Import CSS -->
<jsp:include page="/fragments/staticFiles.jsp" />

<body>
	<jsp:include page="/fragments/bodyHeader.jsp" />
	<div class="container">
		
			<div class='row text-center bg-danger'>
				<h4>We have an error. We are working hard to fix the problem. Please contact us for help at patriotshare@gmail.com</h4>
				<h5>
				<%
				if ((request.getAttribute("error")).equals("none")){
					
					out.print ("no error");
				}
				%>
					Cause of error: ${error}
				</h5>
				
				
					<%=exception.getMessage()%>


			</div>
	</div>
	<jsp:include page="/fragments/footer.jsp" />


</body>

</html>
