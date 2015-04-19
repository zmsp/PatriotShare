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
public class ResearchBookServlet extends HttpServlet {

       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ResearchBookServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String keyStr = request.getParameter("key"); 
		Entity e=null;
		try {
			e = Book.getBookWithKey(keyStr);
			request.setAttribute("error","none");
			request.setAttribute("price",e.getProperty("price").toString());
			request.setAttribute("isbn", e.getProperty("isbn").toString());
			request.getRequestDispatcher("/jsp/trade.jsp").forward(request, response); 
			
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			request.setAttribute("error","No Book found with such isbn in ISBNDB.com");
			request.getRequestDispatcher("/jsp/error.jsp").forward(request, response); 
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		 response.sendRedirect("/jsp/allBook.jsp");
		 
	}

}
