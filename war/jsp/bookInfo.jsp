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
	
	if(session.getAttribute("username") == null){
		response.sendRedirect("/jsp/login.jsp"); 
		return; 
	}else user = (Entity) session.getAttribute("username");

	String sessionID = session.getId();

	%>

<body>
	<jsp:include page="/fragments/bodyHeader.jsp" />
	<div class="container">

			<div class="panel panel-success">
				<div class="panel-heading">
					<h3 class="panel-title">Book Information</h3>
				</div>
				<div class="bookInfo">
					<img src="${thumbnail}" alt="..." class="img-thumbnail center-block">
				</div>
				<ul class="list-group">
				    <li class="list-group-item text-right"><span class="pull-left"><strong
							class="">Title</strong></span> ${title}</li>
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
					<li class="list-group-item text-center"><span class="pull-left"><strong
							class=""></strong></span> <a href="/research/?isbn=${isbn}" class="btn btn-success ">Compare Prices</a>
							&nbsp;<strong class=""> </strong></span> <a href="/jsp/result.jsp?isbn=${isbn}" class="btn btn-success">Find Match</a></li>
				</ul>
			</div>
	</div>

		<jsp:include page="/fragments/footer.jsp" />
		
</body>

</html>
