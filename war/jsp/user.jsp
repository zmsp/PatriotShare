<!DOCTYPE html>
<html lang="en">

<!-- Import CSS -->
<jsp:include page="/fragments/staticFiles.jsp" />

<body>
<jsp:include page="/fragments/bodyHeader.jsp" />
	<div class="container">
<h1>On Your Way to PatriotShare!</h1>

	<form action="/UserSignUp" method="post">
			<div class="form-group">
				<label for="fn">First Name:</label> 
				<input type="text" class="form-control"  col-md-8 id="firstname" placeholder="First Name" name="firstname">
			</div>
			
			<div class="form-group">
				<label for="ln">Last Name</label> 
				<input name="lastname" type="text" class="form-control" id="lastname" placeholder="Last Name">
			</div>
			<div class="form-group">
				<label for="email">GMU email:</label> 
				<input type="text" class="form-control"  id="email" placeholder="GMU email" name="email" required>
			</div>
			<button type="submit" class="btn btn-success">
				<i class="icon-user icon-white"></i> Add
			</button>
			<button type=button class="btn btn-warning">
				<i class="icon-user icon-white"></i> Clear
			</button>
	</form>
	</div>
<jsp:include page="/fragments/footer.jsp" />
</body>
</html>