package edu.gmu.mason.patriotshare.gae.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;

/**
 * Servlet implementation class AddBook
 */
@SuppressWarnings("serial")
public class AddBookServlet extends HttpServlet {

       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddBookServlet() {
        super();
        // TODO Auto-generated constructor stub
    }
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.sendRedirect("/jsp/addBook.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String title = request.getParameter("title");
		String ISBN = request.getParameter("ISBN");
		String price = request.getParameter("price");
		
		 if (ISBN==null ||ISBN.isEmpty()) {
			 throw new IOException("Add book error, empty isbn");
			}
		 DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		 Key bookKey = KeyFactory.createKey("Book", ISBN);
		 Entity book = new Entity(bookKey);
		 book.setProperty("title", title);
		 book.setProperty("price", price);
		 datastore.put(book);
		 response.sendRedirect("/jsp/allBook.jsp");
		 
	}

}
