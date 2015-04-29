package edu.gmu.mason.patriotshare.gae.servlet;

import java.io.IOException;
import java.security.MessageDigest;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Cookie;
import javax.servlet.RequestDispatcher;


import org.apache.geronimo.mail.util.Hex;

import edu.gmu.mason.patriotshare.gae.db.UserProfile; 

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
		response.sendRedirect("/jsp/login.jsp");
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
		
		//String wrongPass = "/invalidLogin.jsp?result=wrongPass";
		 
		//Create a datastore instance
		 DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		
		
		 //This code below is to see if the user has created an account before
		 //if not, then create the account.
			try {

				//The "username" is the column we are searching and filtering our results on
				Filter hasUsername = new FilterPredicate("loginID", FilterOperator.EQUAL, username);
				
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
						byte[] bytesOfMessage;
						bytesOfMessage = password.getBytes("UTF-8");
						MessageDigest md = MessageDigest.getInstance("MD5");
						byte[] thedigest = md.digest(bytesOfMessage);
						String hash = new String(Hex.encode(thedigest));
					
						String retrievedPW = (String) result.get(0).getProperty("password");
						
						if (hash.equals(retrievedPW))
						{
							
							HttpSession session = request.getSession();

							session.setAttribute("username", user);
							session.setMaxInactiveInterval(30*60);
							String encodedURL = response.encodeRedirectURL("/jsp/index.jsp");
							response.sendRedirect(encodedURL);
					        
					        try {
				                RequestDispatcher rd = getServletContext().getRequestDispatcher("/jsp/index.jsp");
				                rd.forward(request, response);
				            } catch (Exception e) {
				                e.printStackTrace();
				            }
				            
				           
						}else
						{
							String message = "Incorrect Password, please try again";
							request.setAttribute("message", message);
							request.getRequestDispatcher("/jsp/login.jsp").forward(request, response);
						}
						 
					}//end for
				}//end if
				
				else {
					
					String message = "User not found";
					request.setAttribute("umessage", message);
					request.getRequestDispatcher("/jsp/login.jsp").forward(request, response);
				}
			} catch (Exception e) {
				e.printStackTrace();
				response.sendRedirect("/jsp/login.jsp");	
			}//end try/catch
			
		 
	}//end method

}
