<!DOCTYPE html>
<html lang="en">

<!-- Import CSS -->
<jsp:include page="/fragments/staticFiles.jsp" />

<body>
	<jsp:include page="/fragments/bodyHeader.jsp" />
	<div class="container">
		<div class='row'>
			<div class='col-sm-6 well '>
<h1 class="text-success">PatriotShare | Login</h1>
<h4>Login with user <em>Username</em> & <em>Password</em> and your ready to go!</h4>


<form action="/addbook" method="post">
			<div class="form-group">
				<label for="username">Username:</label> <input type="text"
					class="form-control" id="username" placeholder="jone doe"
					name="username">
			</div>

			<div class="form-group">
				<label for="password">Password:</label> <input name="password"
					type="password" class="form-control" id="password"
					placeholder="******">
			</div>

			<button type="submit" class="btn btn-success">
				<i class="icon-user icon-white"></i>Enter
			</button>
		</form>

	</div>
<img src="/resources/signup.jpg" alt="..."
				class="img-responsive center-block">
</div>
</div>
	<jsp:include page="/fragments/footer.jsp" />


</body>

</html>
