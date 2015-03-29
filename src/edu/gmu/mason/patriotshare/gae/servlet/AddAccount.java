package edu.gmu.mason.patriotshare.gae.servlet;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;








import org.apache.geronimo.mail.util.Hex;

import edu.gmu.mason.patriotshare.gae.db.Book;
import edu.gmu.mason.patriotshare.gae.db.User;
import edu.gmu.mason.patriotshare.gae.db.UserProfile;

/**
 * Servlet implementation class AddBook
 */
@SuppressWarnings("serial")
public class AddAccount extends HttpServlet {

       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddAccount() {
        super();
        // TODO Auto-generated constructor stub
    }
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.sendRedirect("/jsp/signup.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String firstName = request.getParameter("firstName");
		String lastName = request.getParameter("lastName");
		String pw = request.getParameter("pass_confirmation");
		String email = request.getParameter("email");
		String password = "";
		String terms = "";
		String notification = "";
		String[] n= request.getParameterValues("notification");
		String[] t= request.getParameterValues("terms");
		
		//Goes through check list
		for (String s:t){
			terms=s;
			
		}
		for (String s:n){
			notification=s;
			
		}
		
		request.setAttribute("name",firstName+" "+lastName);
		request.setAttribute("email",email);
		request.setAttribute("notification",notification);
		request.setAttribute("terms",terms);
		 if (firstName==null ||firstName.isEmpty()) {
			 throw new IOException("Add account error, empty name");
			}
		 if (lastName==null ||lastName.isEmpty()) {
			 throw new IOException("Add account error, empty name");
			}
		 
		 if (pw==null ||pw.isEmpty()) {
			 throw new IOException("Empty Password");
			}else{
				
				
				try {
					byte[] bytesOfMessage;
					bytesOfMessage = pw.getBytes("UTF-8");
					MessageDigest md = MessageDigest.getInstance("MD5");
					byte[] thedigest = md.digest(bytesOfMessage);
					password = new String(Hex.encode(thedigest));
					request.setAttribute("md5",password);
					UserProfile.createProfile(firstName, lastName, email, password, terms, notification);					
					
				} catch (UnsupportedEncodingException | NoSuchAlgorithmException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
					throw new IOException("Account cant be created");
				}
				
			}

		 
		 request.getRequestDispatcher("/jsp/accountCreated.jsp").forward(request, response); 
		 
	}

}
