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

import edu.gmu.mason.patriotshare.gae.db.Book;

/**
 * Servlet implementation class AddBook
 */
@SuppressWarnings("serial")
public class TradeBookServlet extends HttpServlet {

       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TradeBookServlet() {
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
		request.getRequestDispatcher("/jsp/trade.jsp").forward(request, response); 
		//response.sendRedirect("/jsp/allBook.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		 response.sendRedirect("/jsp/allBook.jsp");
		 
	}

}
