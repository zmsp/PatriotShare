package edu.gmu.mason.patriotshare.gae.servlet;
import java.io.IOException;
import java.net.URL;
import java.security.MessageDigest;
import java.util.List;
import java.util.Scanner;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.geronimo.mail.util.Hex;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.FetchOptions;
import com.google.appengine.api.datastore.Query;
import com.google.appengine.api.datastore.Query.Filter;
import com.google.appengine.api.datastore.Query.FilterOperator;
import com.google.appengine.api.datastore.Query.FilterPredicate;
import com.google.appengine.labs.repackaged.org.json.JSONArray;
import com.google.appengine.labs.repackaged.org.json.JSONObject;

import edu.gmu.mason.patriotshare.gae.db.Book;


public class OrderReviewServlet extends HttpServlet {

	public OrderReviewServlet() {
        super();  
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String keyStr = request.getParameter("key"); 
		Entity e=null;
		try {
			e = Book.getBookWithKey(keyStr);
			request.setAttribute("error","none");
			request.setAttribute("url","/get/?key=" + keyStr);
			request.setAttribute("price",e.getProperty("price").toString());
			request.setAttribute("title",e.getProperty("title").toString());
			request.setAttribute("isbn", e.getProperty("isbn").toString());
			request.setAttribute("email", e.getProperty("email").toString());
			request.setAttribute("key", keyStr);
			
				//Create a datastore instance
				 DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
				
				
				 //This code below is to see if the user has created an account before
				 //if not, then create the account.
					try {

						//The "username" is the column we are searching and filtering our results on
						Filter hasUsername = new FilterPredicate("loginID", FilterOperator.EQUAL, e.getProperty("email").toString());
						
						//"User" is the entity to search
						Query query = new Query("UserProfile");

						//Links the entity to the search filter
						query.setFilter(hasUsername);
						
						//Creates the list that has the search results based on the filter applied
						//The limit should not have to be increased since we are expecting either 1 or 0 results
						List<Entity> result = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(1));
					
						//"If" there are an results in the list
						if (result != null && result.size() > 0) {
							for (Entity user : result)
							{						
								String name = (String) result.get(0).getProperty("firstName") + " "+  (String) result.get(0).getProperty("lastName") ; 
								request.setAttribute("name",name);
								request.setAttribute("phone","5713344312");
							}//end for
						}//end if
						
						else {
							
							response.sendRedirect("/jsp/addBook.jsp");	
						}
					} catch (Exception e2) {
						e2.printStackTrace();
						response.sendRedirect("/jsp/addBook.jsp");	
					}//end try/catch
					
				 
		

			
			
			
			
			
			
			request.getRequestDispatcher("/jsp/orderReview.jsp").forward(request, response); 
			
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			 e1.printStackTrace();
			request.setAttribute("error","No Book found with such name in ISBNDB");
			request.getRequestDispatcher("/jsp/error.jsp").forward(request, response); 
		}
		//response.sendRedirect("/jsp/allBook.jsp");
	}

	
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setAttribute("error","You can't submit the form");
		request.getRequestDispatcher("/jsp/error.jsp").forward(request, response); 
		 
	}

		
	
	
}
