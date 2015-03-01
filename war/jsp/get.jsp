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

<body>
	<jsp:include page="/fragments/bodyHeader.jsp" />
	<div class="container">

		<div class="col-md-8">

			<div class="panel panel-info">
				<div class="panel-heading">
					<h3 class="panel-title">Book Information</h3>
				</div>
				<div class="bookInfo">
					<img src="${thumbnail}" alt="..." class="img-thumbnail center-block">
					<div class="caption-full">
						<h4 class="pull-right">
							Asking Price:
							<fmt:formatNumber type="currency" value="${price}" />
						</h4>

						<h4>
							<a href="${url}">${title}</a>
						</h4>
						<p>${description}</p>
					</div>
					NOTE: Books meta data are from google books API. Contact seller to
					make sure.

				</div>
				<ul class="list-group">
					<li class="list-group-item text-right"><span class="pull-left"><strong
							class="">Authors</strong></span> ${authors}</li>
					<li class="list-group-item text-right"><span class="pull-left"><strong
							class="">publisher</strong></span> ${publisher}</li>
					<li class="list-group-item text-right"><span class="pull-left"><strong
							class="">publishedDate</strong></span> ${publishedDate}</li>
					<li class="list-group-item text-right"><span class="pull-left"><strong
							class="">ISBN 10</strong></span> ${isbn10}</li>
					<li class="list-group-item text-right"><span class="pull-left"><strong
							class="">ISBN 13</strong></span> ${isbn13}</li>
					<li class="list-group-item text-right"><span class="pull-left"><strong
							class="">Page Count</strong></span> ${pageCount}</li>
					<li class="list-group-item text-right"><span class="pull-left"><strong
							class="">Language</strong></span> ${language}</li>
					<li class="list-group-item text-right"><span class="pull-left"><strong
							class="">How much will you save?</strong></span> <a href="/trade/?isbn=${isbn}" class="btn btn-primary ">Research</a></li>
					<li class="list-group-item text-right"><span class="pull-left"><strong
							class="">Buy this book?</strong></span> <a href="/trade/?isbn=${isbn}" class="btn btn-success">Trade</a></li>


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
							class="">Name</strong></span>John Doe</li>

				</ul>

			</div>
			<button type="button" class="btn btn-info">Send me a message</button>
		</div>











		<jsp:include page="/fragments/footer.jsp" />
</body>

</html>
