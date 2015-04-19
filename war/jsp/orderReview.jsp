<%@page import="javax.json.stream.JsonParser.Event"%>
<%@page import="edu.gmu.mason.patriotshare.gae.db.BookInfo"%>
<%@ page import="com.google.appengine.api.datastore.*"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="javax.json.*"%>

<%@ page import="java.io.InputStream"%>
<%@ page import="edu.gmu.mason.patriotshare.gae.db.BookPrices"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<!DOCTYPE html>
<html lang="en">

<!-- Import CSS -->
<jsp:include page="/fragments/staticFiles.jsp" />
<%
	//allow access only if session exists
	Entity user = null;

	if (session.getAttribute("username") == null) {
		response.sendRedirect("/jsp/login.jsp");
		return;
	} else
		user = (Entity) session.getAttribute("username");

	String sessionID = session.getId();
%>

<body>
	<jsp:include page="/fragments/bodyHeader.jsp" />
	<div class="container">
		<div class="col-md-8">

			<div class="panel panel-info">
				<div class="panel-heading">
					<h3 class="panel-title">Book Information</h3>
				</div>
				<div class="bookInfo">
				
					<div class="caption-full">
						<h4 class="pull-right">
							Asking Price:
							<fmt:formatNumber type="currency" value="${price}" />
						</h4>

						<h4>
							<a href="${url}">${title}</a>
						</h4>
						<p>Click on the book name to get more information about this book</p>
					</div>
					

				</div>
				<ul class="list-group">
					<li class="list-group-item text-right"><span class="pull-left"><strong
							class="">Title</strong></span> ${title}</li>
					<li class="list-group-item text-right"><span class="pull-left"><strong
							class="">Price</strong></span> ${price}</li>
					<li class="list-group-item text-right"><span class="pull-left"><strong
							class="">ISBN</strong></span> ${isbn}</li>
					<li class="list-group-item text-right"><span class="pull-left"><strong
							class="">Confirm buying this book for <fmt:formatNumber type="currency" value="${price}" />?</strong></span> <a href="/tradeConfirmation/?key=${key}"
						class="btn btn-success">Buy</a></li>


				</ul>

			</div>

		</div>
		<div class="col-md-4">
			<div class="panel panel-success">
				<div class="panel-heading">
					<h3 class="panel-title">Trader Information</h3>
				</div>
				<img src="/resources/profile.jpg" alt="..."
					class="img-circle center-block">
				<div class="ratings">
					<p class="pull-right">3 reviews</p>
					<p>
						<span class="glyphicon glyphicon-star"></span> <span
							class="glyphicon glyphicon-star"></span> <span
							class="glyphicon glyphicon-star"></span> <span
							class="glyphicon glyphicon-star"></span> <span
							class="glyphicon glyphicon-star-empty"></span> 4.0 stars
					</p>
				</div>
				<ul class="list-group">
					<li class="list-group-item text-muted" contenteditable="false">Profile</li>
					<li class="list-group-item text-right"><span class="pull-left"><strong
							class="">Joined</strong></span> 2.13.2014</li>
					<li class="list-group-item text-right"><span class="pull-left"><strong
							class="">Last seen</strong></span> Yesterday</li>
					<li class="list-group-item text-right"><span class="pull-left"><strong
							class="">Name</strong></span>${name}</li>

				</ul>

			</div>
			<a href="mailto:${email}" class="btn btn-info glyphicon glyphicon-envelope" role="button">  Email Me</a>
			
		</div>
</div>










		<jsp:include page="/fragments/footer.jsp" />
</body>

</html>
