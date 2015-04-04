<!DOCTYPE html>
<html lang="en">

<!-- Import CSS -->
<jsp:include page="/fragments/staticFiles.jsp" />


<body>
	<jsp:include page="/fragments/bodyHeader.jsp" />

	<div class="container">

		<div class="well panel-body col-md-6 col-sm-12">
			<form action="/addAccount" method="post">
				<h3 class="dark-grey">Registration</h3>

				<div class="form-group col-lg-6">
					<label>First name</label> <input type="" name="firstName" class="form-control"
						placeholder="Enter your last" data-validation="required">
				</div>
				<div class="form-group col-lg-6">
					<label>Last name</label> <input type="" name="lastName" class="form-control"
						placeholder="Enter your last" data-validation="required">
				</div>

				<div class="form-group col-lg-6">
					<label>Password</label> <input class="form-control"
						name="pass_confirmation" type="password"
						data-validation="strength" data-validation-strength="1">

				</div>

				<div class="form-group col-lg-6">
					<label>Repeat Password</label> <input class="form-control"
						type="password" name="pass" data-validation="confirmation">
				</div>

				<div class="form-group col-lg-12">
					<label>Email Address</label> <input class="form-control"
						name="email" data-validation="email" placeholder="Enter your email address"> (This is your user
					ID)
				</div>

				<div class="form-group col-lg-12">
					<label> <input type="checkbox" class="checkbox"
						name="terms" value="agreed terms" data-validation="required" /> Agree
						with terms and condition
					</label>
				</div>

				<div class="form-group col-lg-12">
					<label> <input type="checkbox" class="checkbox"
						name="notification" value="want notification" data-validation="required" /> Send
						notifications to this email (Required! At the moment we do not
						have site notification implemented)
					</label>
				</div>

				<div class="col-sm-12 col-md-12">
					<button type="submit" class="btn btn-primary">Register</button>
				</div>
			</form>
		</div>


		<div class="well panel-body col-md-5 col-sm-12 col-md-offset-1">
			<h3 class="dark-grey">Terms and Conditions</h3>
			<p>By clicking on "Register" you agree to be bound by the terms and conditions</p>
			<jsp:include page="/fragments/terms.jsp" />
		</div>


	</div>

	<jsp:include page="/fragments/footer.jsp" />
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery-form-validator/2.1.47/jquery.form-validator.min.js"></script>
	
	<script>
		$.validate({
			modules : 'security',
			onModulesLoaded : function() {
				$('input[name="pass_confirmation"]').displayPasswordStrength();
			}
		});
	</script>

</body>
</html>