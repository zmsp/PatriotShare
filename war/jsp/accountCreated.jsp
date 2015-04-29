<%@ page import="java.util.List"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">

<!-- Import CSS -->
<jsp:include page="/fragments/staticFiles.jsp" />

<body>
	<jsp:include page="/fragments/bodyHeader.jsp" />
	<div class="container">

	<h1>Welcome to PatriotShare ${name}. Your account was created.</h1>

	<a href="/login" class="btn btn-info" role="button">Login</a>
	
	</div>
	<jsp:include page="/fragments/footer.jsp" />

</body>

</html>
