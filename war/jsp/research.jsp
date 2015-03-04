<%@ page import="com.google.appengine.api.datastore.*"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="javax.json.*"%>
<%@ page import="java.net.*"%>
<%@ page import="java.io.InputStream"%>
<%@ page import="edu.gmu.mason.patriotshare.gae.db.BookPrices"%>



<!DOCTYPE html>
<html lang="en">

<!-- Import CSS -->
<jsp:include page="/fragments/staticFiles.jsp" />

<body>
	<jsp:include page="/fragments/bodyHeader.jsp" />
	<div class="container">



		<h2>Look at how much you could save if you trade with this user!</h2>




		<%
			InputStream is = null; 
			JsonArray results = null; 
			try
			{
				URL url = new URL("http://isbndb.com/api/v2/json/0ee0g43m/prices/" + request.getAttribute("isbn"));
				URLConnection urlConn = url.openConnection(); 
				urlConn.setConnectTimeout(30000); 
				urlConn.setReadTimeout(30000); 
				is = urlConn.getInputStream(); 
				JsonReader rdr = Json.createReader(is); 
				JsonObject obj = rdr.readObject(); 
				results = obj.getJsonArray("data"); 		
			}catch(SocketTimeoutException e)
			{
				e.printStackTrace(); 
				
			}finally
			{
				is.close(); 	
			}

			ArrayList<BookPrices> books = new ArrayList<BookPrices>();

			// adds all the values returned from the url to an ArrayList
			for (JsonObject result : results.getValuesAs(JsonObject.class)) {
				BookPrices temp = new BookPrices(result.getString("store_id"),
						Double.parseDouble(result.getString("price")));
				books.add(temp);
			}

			//Sorts the list by descending order
			for (int i = 1; i < books.size(); i++) {
				int k = i;

				while (k > 0
						&& books.get(k).getPrice() > books.get(k - 1)
								.getPrice()) {
					BookPrices temp = books.get(k);
					books.set(k, books.get(k - 1));
					books.set(k - 1, temp);
					k--;
				}
			}
		%>

		<div class="well">
			<h3>Lowest Prices found on the Internet</h3>
			<div class="col-sm-3 col-sm-offset-1">
				<div class="panel panel-primary">
					<div class="panel-heading">
						<%
							out.print(books.get(0).getName());
						%>
					</div>
					<div class="panel-body">

						<%
							out.print("$" + books.get(0).getPrice());
						%>

					</div>
				</div>
			</div>

			<div class="col-sm-3  col-sm-offset-1">
				<div class="panel panel-primary">
					<div class="panel-heading">
						<%
							out.print(books.get(1).getName());
						%>
					</div>
					<div class="panel-body">

						<%
							out.print("$" + books.get(1).getPrice());
						%>

					</div>
				</div>
			</div>


			<div class="col-sm-3  col-sm-offset-1">
				<div class="panel panel-primary">
					<div class="panel-heading">
						<%
							out.print(books.get(2).getName());
						%>
					</div>
					<div class="panel-body">

						<%
							out.print("$" + books.get(2).getPrice());
						%>

					</div>
				</div>
			</div>

			<h3>Buy it from students using patriot Share:</h3>
			
			<h1>
				<p class="text-success">$${price}</p>
			</h1>
			<h3>Sell it back using Patriot Share for:</h3>(Estimated 75% of price)
			
			<h1>
				<p class="text-success">$${price*.75}</p>
			</h1>
			<p>______________________________________________</p>
			<h3>Your Cost for using book for the semester:</h3>
			<h1>
				<p class="text-success">$${price*.25}</p>
			</h1>
			
			<p>______________________________________________</p>
			<h3>Total Saving:</h3>Estimated: (150% of the seller price) - (Cost of using a semester^)
			<h1>
				<p class="text-success">$${price*1.25}</p>
			</h1>
			
		</div>




		<div class="alert alert-info" role="alert">
			<img src="/resources/infograph1.png" alt="..."
				class="img-responsive center-block"> <img
				src="/resources/infograph2.png" alt="..."
				class="img-responsive center-block">

		</div>


	</div>
	<jsp:include page="/fragments/footer.jsp" />
</body>

</html>
