<!DOCTYPE html>
<html lang="en">

<!-- Import library and scripts are from this file -->
<jsp:include page="/fragments/staticFiles.jsp" />
<body>
	<jsp:include page="/fragments/bodyHeader.jsp" />
	<div class="container">
		<form action="/addbook" method="post">
			<div class="form-group">
				<label for="bookTitle">Book Title</label> <input type="text"
					class="form-control" id="bookTitle" placeholder="Enter book title"
					name="title">
			</div>

			<div class="form-group">
				<label for="bookISBN">Book ISBN (10 or 13 digit)</label> <input name="ISBN"
					type="text" class="form-control" id="bookISBN"
					placeholder="Book ISBN goes here" pattern="\d{10}|\d{13}">
			</div>
			<div class="form-group">
				<label for="bookPrice">Price (0.00-999)</label>
				<div class="input-group">
					<div class="input-group-addon">$</div>
					<input name="price" type="number" class="form-control" id="bookPrice"
						placeholder="Amount" min="0" max="500" >
					<div class="input-group-addon">.00</div>
				</div>
			</div>



			<button type="submit" class="btn btn-primary">
				<i class="icon-user icon-white"></i> Submit
			</button>
		</form>

	</div>


	<jsp:include page="/fragments/footer.jsp" />


</body>

</html>
