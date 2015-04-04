package edu.gmu.mason.patriotshare.gae.servlet;
import java.io.IOException;

import javax.servlet.http.HttpServlet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;

import edu.gmu.mason.patriotshare.gae.db.Book;

@SuppressWarnings("serial")
public class tradeConfirmationServlet extends HttpServlet {
	
	

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String isbn = request.getParameter("isbn"); 
		Entity entity = Book.getBookWithISBN(isbn);
		request.setAttribute("price",entity.getProperty("price").toString());
		request.setAttribute("isbn", entity.getProperty("isbn").toString());
		request.getRequestDispatcher("/jsp/tradeConfirmation.jsp").forward(request, response); 
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		 
	}

	
	
	
}







 