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
<h4>Login with your <em>Username</em> & <em>Password</em> and you're ready to go!</h4>


<form action="/login" method="post">
			<div class="form-group">
				<label for="username">Username:</label> <input type="text"
					class="form-control" id="username" placeholder="jone doe"
					name="username">
					<%if(request.getAttribute("umessage") != null){%>
					<p><span style="color: red"> ${umessage}</span></p>
					<%} %>
			</div>

			<div class="form-group">
				<label for="password">Password:</label> <input name="password"
					type="password" class="form-control" id="password"
					placeholder="******">
					<%if(request.getAttribute("message") != null){%>
					<p><span style="color: red"> ${message}</span></p>
					<%} %>
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
