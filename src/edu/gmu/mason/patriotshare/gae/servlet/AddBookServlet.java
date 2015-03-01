package edu.gmu.mason.patriotshare.gae.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import edu.gmu.mason.patriotshare.gae.db.Book;

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
		String isbn = request.getParameter("ISBN");
		double price = Double.parseDouble(request.getParameter("price"));
		
		 if (isbn==null ||isbn.isEmpty()) {
			 throw new IOException("Add book error, empty isbn");
			}
		 
		 if (title==null ||title.isEmpty()) {
			 throw new IOException("Add book error, empty title");
			}
		 if (price<=0) {
			 throw new IOException("Not a valid price");
			}
		 
			 Book.createBook(isbn, title, price);
		 
		 response.sendRedirect("/jsp/allBook.jsp");
		 
	}

}
