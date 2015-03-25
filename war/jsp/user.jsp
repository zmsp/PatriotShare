<!DOCTYPE html>
<html lang="en">

<!-- Import CSS -->
<jsp:include page="/fragments/staticFiles.jsp" />

<body>
<jsp:include page="/fragments/bodyHeader.jsp" />
	<div class="container">
<h1>On Your Way to PatriotShare!</h1>

	<form class="ui form">
  <h4 class="ui dividing header">Personal Information</h4>
  <div class="two fields">
    <div class="field">
      <label>Name</label>
      <div class="two fields">
        <div class="field">
          <input type="text" name="first-name" placeholder="First Name">
        </div>
        <div class="field">
          <input type="text" name="last-name" placeholder="Last Name">
        </div>
      </div>
    </div>
    <div class="field">
      <label>Gender</label>
      <div class="ui selection dropdown">
        <input type="hidden" name="gender">
        <div class="default text">Gender</div>
        <i class="dropdown icon"></i>
        <div class="menu">
          <div class="item" data-value="male">Male</div>
          <div class="item" data-value="female">Female</div>
        </div>
      </div>
    </div>
  </div>
  <div class="two fields">
    <div class="field">
      <label>School</label>
      <select class="ui search dropdown">
        <option value="">School</option>
        <option value="GMU">George Mason University</option>
      </select>
    </div>
    <div class="field">
    <label>School Email</label>
          <input type="text" name="scname" placeholder="To Verify you go to this school">
    </div>
  </div>
  <div class="field">
    <label>Biography</label>
    <textarea></textarea>
  </div>
  <h4 class="ui dividing header">Account Info</h4>
  <div class="two fields">
    <div class="required field">
      <label>Username</label>
      <div class="ui icon input">
        <input type="text" placeholder="Username">
        <i class="user icon"></i>
      </div>
    </div>
    <div class="required field">
      <label>Password</label>
      <div class="ui icon input">
        <input type="password">
        <i class="lock icon"></i>
      </div>
    </div>
  </div>
   <h4 class="ui dividing header">Settings</h4>
  <h5 class="ui header">Privacy</h5>
  <div class="field">
    <div class="ui toggle checkbox">
      <input type="radio" name="privacy">
      <label>Allow <b>anyone</b> to see my account</label>
    </div>
  </div>
  <div class="field">
    <div class="ui toggle checkbox">
      <input type="radio" name="privacy">
      <label>Allow <b>only friends</b> to see my account</label>
    </div>
  </div>
  <h5 class="ui header">Newsletter Subscriptions</h5>
  <div class="field">
    <div class="ui slider checkbox">
      <input type="checkbox" name="top-posts">
      <label>Email when someone posts the books I want</label>
    </div>
  </div>
  <div class="field">
    <div class="ui slider checkbox">
      <input type="checkbox" name="hot-deals">
      <label>Email when someone sends a trade request</label>
    </div>
  </div>
  <div class="ui hidden divider"></div>
  <div class="field">
    <div class="ui checkbox">
      <input type="checkbox" name="hot-deals">
      <label>I agree to the <a href="#">Terms of Service</a>.</label>
    </div>
  </div>
  <div class="ui error message">
    <div class="header">We noticed some issues</div>
  </div>
  <div class="ui submit button">Register</div>
</form>
	</div>
<jsp:include page="/fragments/footer.jsp" />
</body>
</html>