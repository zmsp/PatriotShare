<!DOCTYPE html>
<html lang="en">

<!-- Import CSS -->
<jsp:include page="/fragments/staticFiles.jsp" />

<body>
	<jsp:include page="/fragments/bodyHeader.jsp" />
	<div class="container">
		<div class='row'>
			<div class='col-sm-12 well'>
				<h2>Welcome to PatriotShare!</h2>
				<h4>
					Our mission at PatriotShare&copy is to empower and enable GMU
					students to make smart decisions when it comes to their textbooks.
					<br />
					<br />
					Get started today and see how much you can save!
				</h4>
				<br >
				<a class="btn btn-primary" href="/addbook" role="button">Sell A Book</a> 
				<a class="btn btn-primary" href="/allbook" role="button">Buy A Book</a>
			</div>

		</div>

	</div>
	<jsp:include page="/fragments/footer.jsp" />
	
	
</body>

</html>
