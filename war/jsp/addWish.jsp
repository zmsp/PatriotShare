<!DOCTYPE html>
<html lang="en">

<!-- Import library and scripts are from this file -->
<jsp:include page="/fragments/staticFiles.jsp" />
<body>
	<jsp:include page="/fragments/bodyHeader.jsp" />
	<div class="container">
		<form action="/addwish" method="post">
			<div class="form-group">
				<label for="bookTitle">Book Title</label> <input required="required" type="text"
					class="form-control" id="bookTitle" placeholder="Enter book title"
					name="title">
			</div>

			<div class="form-group">
				<label for="bookISBN">Book ISBN (10 or 13 digit)</label> <input required="required" name="ISBN"
					type="text" class="form-control" id="bookISBN"
					placeholder="Book ISBN goes here" pattern="\d{10}|\d{13}">
			</div>
			
			<div>
				<input type="hidden" name="email" value="john88@gmail.com"> 
			</div>

			<button type="submit" class="btn btn-primary">
				<i class="icon-user icon-white"></i> Add 
			</button>
		</form>

	</div>


	<jsp:include page="/fragments/footer.jsp" />


</body>

</html>
