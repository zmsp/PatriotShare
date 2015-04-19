<%@ page import="com.google.appengine.api.datastore.*"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="javax.json.*"  %>
<%@ page import="java.net.*" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="edu.gmu.mason.patriotshare.gae.db.BookPrices" %>


<!DOCTYPE html>
<html lang="en">

<!-- Import CSS -->
<jsp:include page="/fragments/staticFiles.jsp" />

<body>
	<jsp:include page="/fragments/bodyHeader.jsp" />
	<div class="container">
		<div class='row'>
			<div class='col-sm-12 well'>
			
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
		for(JsonObject result : results.getValuesAs(JsonObject.class))
		{
			BookPrices temp = new BookPrices(result.getString("store_id"), Double.parseDouble(result.getString("price"))); 
			books.add(temp); 
		}
		
		//Sorts the list by descending order
		for(int i = 1; i < books.size(); i++)
		{
			int k = i; 
			
			while(k > 0 && books.get(k).getPrice() > books.get(k-1).getPrice() )
			{
				BookPrices temp = books.get(k); 
				books.set(k, books.get(k-1)); 
				books.set(k-1, temp); 
				k--; 
			}
		}
	
	%>
		
				<h2>Congratulations!</h2>
				<h3>
					Your trade request has been submitted successfully.
					<br >
					<br >
					You have saved $<%out.print(books.get(0).getPrice()); %> by trading with PatriotShare.
				</h3>
				<br >
					<a class="btn btn-primary" href="/jsp/index.jsp" role="button">Find Another Book</a>
			</div>
		</div>
	</div>
	<jsp:include page="/fragments/footer.jsp" />
	
	
</body>

</html>


				
			