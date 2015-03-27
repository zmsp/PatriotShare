package edu.gmu.mason.patriotshare.gae.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.FetchOptions;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.api.datastore.Query;
import com.google.appengine.api.datastore.Transaction;
import com.google.appengine.api.datastore.Query.Filter;
import com.google.appengine.api.datastore.Query.FilterOperator;
import com.google.appengine.api.datastore.Query.FilterPredicate;


/**
 * Sebastian velasquez
 */
@SuppressWarnings("serial")
public class loginServletBridge extends HttpServlet {

       
    /*
     * @see HttpServlet#HttpServlet()
     */
    public loginServletBridge() {
        super();
        // TODO Auto-generated constructor stub
    }
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.sendRedirect("/jsp/user.jsp");
		//Not used since sent via POST
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//Get the information that was posted on the server
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		
		 //create the strings to be sent through the browser on redirect
		
		String wrongPass = "/invalidLogin.jsp?result=wrongPass";
		 
		//Create a datastore instance
		 DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		
		
		 //This code below is to see if the user has created an account before
		 //if not, then create the account.
			try {

				//The "username" is the column we are searching and filtering our results on
				Filter hasUsername = new FilterPredicate("username", FilterOperator.EQUAL, username);
				
				//"User" is the entity to search
				Query query = new Query("User");
				
				//Links the entity to the search filter
				query.setFilter(hasUsername);
				
				//Creates the list that has the search results based on the filter applied
				//The limit should not have to be increased since we are expecting either 1 or 0 results
				List<Entity> result = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(1));
				
				//"If" there are an results in the list
				if (result != null && result.size() > 0) {
					for (Entity user: result)
					{						
					
						String tempPassword = (String) user.getProperty("password");
						if (password.equals(tempPassword))
						{
							
							
							
							HttpSession session = request.getSession();
							
							session.setAttribute("username", username);
							//session.setAttribute("age", age);
							//Will need to change below when login-success.jsp page is ready	
							response.sendRedirect("login-success.jsp");
						}else
						{
							response.sendRedirect(wrongPass);
						}
					
					}//end for
				}//end if
				else {
					
					response.sendRedirect("invalidLogin.jsp");	
				}
					
			} catch (Exception e) {
				// TODO log the error
			}//end try/catch
			
		 
	}//end method

}
