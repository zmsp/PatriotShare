/**
 * 
 */
package edu.gmu.mason.patriotshare.gae.servlet;

import java.io.IOException;
import java.net.URL;
import java.util.Scanner;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.labs.repackaged.org.json.JSONObject;

import edu.gmu.mason.patriotshare.gae.db.Book;

/**
 * Servlet implementation class AddBook
 */
@SuppressWarnings("serial")
public class GetBookServlet extends HttpServlet {

       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetBookServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String isbn = request.getParameter("isbn"); 
		Entity e= Book.getBookWithISBN(isbn);
		request.setAttribute("price",e.getProperty("price").toString());
		request.setAttribute("isbn",isbn);
		
		
		
		
		
		
		//GET JSON DATA
		String urlString = "https://www.googleapis.com/books/v1/volumes?q=isbn:"+isbn+"&key=AIzaSyB2BmUKAIUC4oxQtpsogJhQK2L2Otnv4y4&country=US";
	    //https://www.googleapis.com/books/v1/volumes?q=isbn:9781118087886&key=AIzaSyB2BmUKAIUC4oxQtpsogJhQK2L2Otnv4y4&country=US
	    URL url = new URL(urlString);
	 
	    // read from the URL
	    Scanner scan = new Scanner(url.openStream());
	    String str = new String();
	    while (scan.hasNext())
	        str += scan.nextLine();
	    scan.close();
	    
	    request.setAttribute("data", str);
	    
	 
	    // build a JSON object
	    JSONObject obj;
		try {
			obj = new JSONObject(str);
		

	    // get the first result
	    
	    JSONObject res = obj.getJSONArray("items").getJSONObject(0);
	    
	    if (obj.getInt("totalItems")==0){
	    	 throw new IOException("ISBN not found on Google Book");
	    }else{
	    	
	    
	    String description =
	        res.getJSONObject("volumeInfo").getString("description");
	    String title =
		        res.getJSONObject("volumeInfo").getString("title");
	    String authors =
		        res.getJSONObject("volumeInfo").getJSONArray("authors").toString();
	    String publisher =
		        res.getJSONObject("volumeInfo").getString("publisher");
	    String publishedDate =
		        res.getJSONObject("volumeInfo").getString("publishedDate");
	    String thumbnail=  res.getJSONObject("volumeInfo").getJSONObject("imageLinks").getString("thumbnail");
	   
	    request.setAttribute("description",description);
	    request.setAttribute("title",title);
	    request.setAttribute("authors",authors);
	    request.setAttribute("publisher",publisher);
	    request.setAttribute("publishedDate",publishedDate);
	    request.setAttribute("thumbnail",thumbnail);
	    
	    request.setAttribute("isbn10","TODO");

	    request.setAttribute("isbn13","TODO");

	    request.setAttribute("pageCount","TODO");

	    request.setAttribute("language","TODO");
	    
	    request.setAttribute("url",urlString);

	    
	    
	    }
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			
			throw new IOException(e1.toString());
		}
		request.getRequestDispatcher("/jsp/get.jsp").forward(request, response); 
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		 response.sendRedirect("/jsp/allBook.jsp");
		 
	}

}
