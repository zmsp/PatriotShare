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
				<label for="bookISBN">Book ISBN</label> <input name="ISBN"
					type="text" class="form-control" id="bookISBN"
					placeholder="Book ISBN goes here">
			</div>
			<div class="form-group">
				<label for="bookPrice">Price</label>
				<div class="input-group">
					<div class="input-group-addon">$</div>
					<input name="price" type="text" class="form-control" id="bookPrice"
						placeholder="Amount">
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
