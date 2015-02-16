<!DOCTYPE html>
<html lang="en">

<!-- Import library and scripts are from this file -->
<jsp:include page="/fragments/staticFiles.jsp" />
<body>
	<div class="container">
		<jsp:include page="/fragments/bodyHeader.jsp" />
		<div>
		<a class="btn btn-primary" href="/addbook" role="button">Add Book</a>
		<a class="btn btn-primary" href="/allbook" role="button">View Book</a>
		</div>


		<div style="margin:5% 0 0 0 ">
			<jsp:include page="/fragments/footer.jsp" />
		</div>
	</div>
</body>

</html>
