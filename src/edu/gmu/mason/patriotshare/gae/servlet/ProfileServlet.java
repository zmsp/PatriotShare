package edu.gmu.mason.patriotshare.gae.servlet;

import java.io.IOException;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;










import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.FetchOptions;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.api.datastore.Query;
import com.google.appengine.api.datastore.Query.CompositeFilterOperator;
import com.google.appengine.api.datastore.Query.Filter;
import com.google.appengine.api.datastore.Query.FilterOperator;
import com.google.appengine.api.datastore.Query.FilterPredicate;
import com.google.appengine.labs.repackaged.org.json.JSONArray;
import com.google.appengine.labs.repackaged.org.json.JSONObject;

import edu.gmu.mason.patriotshare.gae.db.Book;

public class ProfileServlet extends HttpServlet {

    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProfileServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		
		String isbn = request.getParameter("isbn"); 
		String user = request.getParameter("email"); 
		Filter userName = new FilterPredicate("email", FilterOperator.EQUAL, user);
		Filter bookIsbn = new FilterPredicate("isbn", FilterOperator.EQUAL, isbn); 
		Filter removeBook = CompositeFilterOperator.and(userName, bookIsbn); 
		
		Query myquery = new Query("Book"); 
		myquery.setFilter(removeBook); 
		
		List<Entity> myBook = datastore.prepare(myquery).asList(FetchOptions.Builder.withLimit(1));
		if(myBook.isEmpty() || myBook == null){
			response.sendRedirect("/jsp/userProfile.jsp");
		}
		
		try
		{
		Entity remove = myBook.get(0); 
		datastore.delete(remove.getKey());
		}catch(IndexOutOfBoundsException e)
		{
			response.sendRedirect("/jsp/userProfile.jsp");
		}

		response.sendRedirect("/jsp/userProfile.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		 response.sendRedirect("/jsp/userProfile.jsp");
		 
	}
}
