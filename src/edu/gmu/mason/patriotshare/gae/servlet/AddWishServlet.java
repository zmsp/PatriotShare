package edu.gmu.mason.patriotshare.gae.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import edu.gmu.mason.patriotshare.gae.db.BookWish;
//import edu.gmu.mason.patriotshare.gae.db.UserProfile;


@SuppressWarnings("serial")
public class AddWishServlet extends HttpServlet {

	 public AddWishServlet() {
	        super();
	       
	    }
		
		protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			response.sendRedirect("/jsp/addWish.jsp");
		}

		
		protected void doPost(HttpServletRequest request,
				HttpServletResponse response) throws ServletException, IOException {
			String title = request.getParameter("title");
			String isbn = request.getParameter("ISBN");
			String email = request.getParameter("email");

			if (isbn == null || isbn.isEmpty()) {
				throw new IOException("Add book error, empty isbn");
			}

			if (title == null || title.isEmpty()) {
				throw new IOException("Add book error, empty title");
			}
			
			//Book.createBook(isbn, title, price);
			//response.sendRedirect("/jsp/allBook.jsp");
	
			if (isbn == null || isbn.isEmpty()) {
				throw new IOException("Add book error, empty isbn");
			}

			if (title == null || title.isEmpty()) {
				throw new IOException("Add book error, empty title");
			}

			BookWish.createBookWish(email, isbn, title);

			//UserProfile.addtobooklist(isbn, title);
			//UserProfile.Testbooklist();
			response.sendRedirect("/jsp/userProfile.jsp");
			 
		}

	
}
