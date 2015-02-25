<%@ page isErrorPage="true" import="java.io.*"%>

<!DOCTYPE html>
<html lang="en">

<!-- Import CSS -->
<jsp:include page="/fragments/staticFiles.jsp" />

<body>
	<jsp:include page="/fragments/bodyHeader.jsp" />
	<div class="container">
		
			<div class='row text-center bg-danger'>
				<img src="/resources/error.png" alt="Error banner" class="img-rounded">
				<h4>You got error because:</h4>
				<h5">
					<%=exception.getMessage()%>
				</h5>
				
				


			</div>
	</div>
	<jsp:include page="/fragments/footer.jsp" />


</body>

</html>
