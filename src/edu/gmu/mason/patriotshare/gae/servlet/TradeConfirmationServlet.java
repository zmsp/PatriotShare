package edu.gmu.mason.patriotshare.gae.servlet;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.text.DecimalFormat;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.FetchOptions;
import com.google.appengine.api.datastore.Query;
import com.google.appengine.api.datastore.Query.Filter;
import com.google.appengine.api.datastore.Query.FilterOperator;
import com.google.appengine.api.datastore.Query.FilterPredicate;

import edu.gmu.mason.patriotshare.gae.db.Book;

public class TradeConfirmationServlet extends HttpServlet {

	public TradeConfirmationServlet() {
		super();
	}

	/**
	 * @throws UnsupportedEncodingException 
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String keyStr = request.getParameter("key");
		
		Entity e = null;
		String nameTo = "No Name";
		String emailTo = "thunder.z@hotmail.com";
		String phoneTo = "7031234567";
		
		
		//Buyer Info
		HttpSession session = request.getSession();
		
		
		
	
		Entity buyer = null;
		if(session.getAttribute("username") == null){
			response.sendRedirect("/jsp/login.jsp"); 
			return; 
		}else buyer = (Entity) session.getAttribute("username");

		String nameFrom= buyer.getProperty("firstName").toString()+ " "+buyer.getProperty("lastName").toString();
		String emailFrom= buyer.getProperty("loginID").toString();
		
		DecimalFormat df = new DecimalFormat("0.00");
		
/*		if(session.getAttribute("username") == null){
			response.sendRedirect("/jsp/login.jsp"); 
			return; 
		}else user = (Entity) session.getAttribute("username");

		String sessionID = session.getId();
*/		
		try {
			
			//Setting up response
			e = Book.getBookWithKey(keyStr);
			request.setAttribute("error", "none");
			request.setAttribute("url", "/get/?key=" + keyStr);
			request.setAttribute("price", e.getProperty("price").toString());
			request.setAttribute("title", e.getProperty("title").toString());
			request.setAttribute("isbn", e.getProperty("isbn").toString());
			request.setAttribute("email", e.getProperty("email").toString());


			// Getting Seller Info
			
			
			DatastoreService datastore = DatastoreServiceFactory
					.getDatastoreService();

			// This code below is to see if the user has created an account
			// before
			// if not, then create the account.
			try {

				// The "username" is the column we are searching and filtering
				// our results on
				Filter hasUsername = new FilterPredicate("loginID",
						FilterOperator.EQUAL, e.getProperty("email").toString());

				// "User" is the entity to search
				Query query = new Query("UserProfile");

				// Links the entity to the search filter
				query.setFilter(hasUsername);

				// Creates the list that has the search results based on the
				// filter applied
				// The limit should not have to be increased since we are
				// expecting either 1 or 0 results
				List<Entity> result = datastore.prepare(query).asList(
						FetchOptions.Builder.withLimit(1));

				// "If" there are an results in the list
				if (result != null && result.size() > 0) {
					
						 nameTo = (String) result.get(0).getProperty(
								"firstName")
								+ " "
								+ (String) result.get(0)
										.getProperty("lastName");
						request.setAttribute("name", nameTo);
						
						phoneTo="7031234567";
						request.setAttribute("phone", "7031234567");
					
				}// end if

				else {

					response.sendRedirect("/jsp/error.jsp");
					request.setAttribute("error", "Failed to get Seller info");
				}
			} catch (Exception e2) {
				e2.printStackTrace();
				
				response.sendRedirect("/jsp/error.jsp");
				request.setAttribute("error", "Failed to get Seller info");
			}// end try/catch

			

		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
			request.setAttribute("error",
					"Failed to get seller info");
			request.getRequestDispatcher("/jsp/error.jsp").forward(request,
					response);
		}
		
		//Sending seller the email
		
		
		Properties props = new Properties();
        Session sessionMail = Session.getDefaultInstance(props, null);

        
		String msgBody = "You have an offer for your book "+e.getProperty("title").toString()+ " for the price of $"+
        df.format(e.getProperty("price"))+ ". Buyer "+nameFrom+" phone number is "+phoneTo+ " and email "+ emailFrom;

        //Sending the email
        try {
            Message msg = new MimeMessage(sessionMail);
            msg.setFrom(new InternetAddress("ait390s1501MdZobair@gmail.com", "Patriot Share Admin"));
            msg.addRecipient(Message.RecipientType.TO,
                    new InternetAddress(emailTo, nameTo));
            msg.setSubject("You have received an offer for "+e.getProperty("title").toString());
            
            msg.setText(msgBody);
            System.out.println(emailFrom+nameFrom+emailTo+nameTo+msgBody);
            Transport.send(msg);

        } catch (AddressException e5) {
        	e5.printStackTrace();
			request.setAttribute("error",
					"Email wasn't send. Something went wrong with email address");
			request.getRequestDispatcher("/jsp/error.jsp").forward(request,
					response);
        } catch (MessagingException e6) {
        	e6.printStackTrace();
			request.setAttribute("error",
					"Email wasn't send. Something went wrong with email address");
			request.getRequestDispatcher("/jsp/error.jsp").forward(request,
					response);
        }
        
        
        //Sending buyer the email
        try {
            Message msg = new MimeMessage(sessionMail);
            msg.setFrom(new InternetAddress("ait390s1501MdZobair@gmail.com", "Patriot Share Admin"));
            msg.addRecipient(Message.RecipientType.TO,
                    new InternetAddress(emailFrom, nameFrom));
            msg.setSubject("You have sent an offer for "+e.getProperty("title").toString());
            String msgBody2 = "You have an sent an offer for "+e.getProperty("title").toString()+ "for the price of $"+
                    df.format(e.getProperty("price"))+ ". Seller "+nameTo +" phone number is "+phoneTo+ " and email "+ emailTo;

                           
            msg.setText(msgBody2);
            System.out.println(emailFrom+nameFrom+emailTo+nameTo+msgBody);
            Transport.send(msg);

        } catch (AddressException e5) {
        	e5.printStackTrace();
			request.setAttribute("error",
					"Email wasn't send. Something went wrong with email address");
			request.getRequestDispatcher("/jsp/error.jsp").forward(request,
					response);
        } catch (MessagingException e6) {
        	e6.printStackTrace();
			request.setAttribute("error",
					"Email wasn't send. Something went wrong with email address");
			request.getRequestDispatcher("/jsp/error.jsp").forward(request,
					response);
        }
        
        request.getRequestDispatcher("/jsp/tradeConfirmation.jsp").forward(
				request, response);
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		request.setAttribute("error", "You can't submit the form");
		request.getRequestDispatcher("/jsp/error.jsp").forward(request,
				response);

	}

}
