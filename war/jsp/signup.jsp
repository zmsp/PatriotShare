<!DOCTYPE html>
<html lang="en">

<!-- Import CSS -->
<jsp:include page="/fragments/staticFiles.jsp" />


<script src="/javascript/validate-form.js"></script>

<script type="text/javascript">
 $.fn.form.settings.defaults = {
    firstName: {
      identifier  : 'first-name',
      rules: [
        {
          type   : 'empty',
          prompt : 'Please enter your first name'
        }
      ]
    },
    name: {
      identifier  : 'name',
      rules: [
        {
          type   : 'empty',
          prompt : 'Please enter you name'
        }
      ]
    },
    firstName: {
      identifier  : 'first-name',
      rules: [
        {
          type   : 'empty',
          prompt : 'Please enter your first name'
        }
      ]
    },
    lastName: {
      identifier  : 'last-name',
      rules: [
        {
          type   : 'empty',
          prompt : 'Please enter your last name'
        }
      ]
    },
    username: {
      identifier : 'username',
      rules: [
        {
          type   : 'empty',
          prompt : 'Please enter a username'
        }
      ]
    },
    email: {
      identifier : 'email',
      rules: [
        {
          type   : 'empty',
          prompt : 'Please enter your email'
        },
        {
          type   : 'email',
          prompt : 'Please enter a valid email'
        }
      ]
    },
    password: {
      identifier : 'password',
      rules: [
        {
          type   : 'empty',
          prompt : 'Please enter a password'
        },
        {
          type   : 'length[6]',
          prompt : 'Your password must be at least 6 characters'
        }
      ]
    },
    passwordConfirm: {
      identifier : 'password-confirm',
      rules: [
        {
          type   : 'empty',
          prompt : 'Please confirm your password'
        },
        {
          identifier : 'password-confirm',
          type       : 'match[password]',
          prompt     : 'Please verify password matches'
        }
      ]
    },
    terms: {
      identifier : 'terms',
      rules: [
        {
          type   : 'checked',
          prompt : 'You must agree to the terms and conditions'
        }
      ]
    }
  };

</script>

<body>
<jsp:include page="/fragments/bodyHeader.jsp" />
	<div class="container">
<h1>On Your Way to PatriotShare!</h1>
<form class="ui form segment">
    <div class="two fields">
      <div class="field">
        <label>First Name</label>
        <input placeholder="First Name" name="firstName" type="text">
      </div>
      <div class="field">
        <div class="field">
        <label>Last Name</label>
        <input placeholder="Last Name" name="lastName" type="text">
      </div>
      </div>
    </div>
    <div class="field">
      <label>Username</label>
      <input placeholder="Username" name="username" type="text">
    </div>
    <div class="field">
      <label>Password</label>
      <input name="password" type="password">
    </div>
    <div class="field">
      <label>Confirm Password</label>
      <input name="confirmPassword" type="password">
    </div>
    <div class="ten wide field">
        <label>E-mail</label>
        <input type="text" name="email">
    </div>
    <div class="inline field">
      <div class="ui checkbox">
        <input name="terms" type="checkbox">
        <label>I agree to the terms and conditions</label>
      </div>
    </div>
    <div class="ui blue submit button">Submit</div>
    <div class="ui red reset button">Reset</div>
    <div class="ui yellow clear button">Clear</div>
  </form>

	</div>
<jsp:include page="/fragments/footer.jsp" />

</body>
</html>