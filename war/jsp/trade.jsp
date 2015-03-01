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
	
	

	
	


		


		<%
		URL url = new URL("http://isbndb.com/api/v2/json/0ee0g43m/prices/" + request.getAttribute("isbn"));
		URLConnection urlConn = url.openConnection(); 
		urlConn.setConnectTimeout(15000); 
		InputStream is = url.openStream();
		JsonReader rdr = Json.createReader(is); 
		
		JsonObject obj = rdr.readObject(); 
		JsonArray results = obj.getJsonArray("data"); 
		
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
	<div class="row">
		<h2>Trade one of your books for theirs. It's as simple as that.</h2> 
	</div>
	
	<div class=" row col-sm-12 well">
	<p>Compared to the competitors, you could potentially save <b><span class="text-success">$<%out.print(books.get(0).getPrice()); %> </span></b>by trading!</p>
	<button type="trade" class="btn btn-primary" disabled="disabled">
				<i class="icon-user icon-white"></i> Trade Now!
	</button>
	</div>
	
	<div class="row"> 
		<div class="col-sm-3 well"> 
			<p class="lead"><b><%out.print(books.get(0).getName()); %>.com</b><br/>
			<%out.print("$" + books.get(0).getPrice());  %>
			</p>
		</div>
		<div class="col-sm-3 well col-sm-offset-1"> 
			<p class="lead"><b><%out.print(books.get(1).getName()); %>.com</b><br/>
			<%out.print("$" + books.get(1).getPrice());  %>
			</p>
		</div>
		<div class="col-sm-3 well col-sm-offset-1"> 
			<p class="lead"><b><%out.print(books.get(2).getName()); %>.com</b><br/>
			<%out.print("$" + books.get(2).getPrice());  %>
			</p>
		</div>
	</div>

	
	

	
	
	
	
	
	</div>
	<jsp:include page="/fragments/footer.jsp" />


</body>
