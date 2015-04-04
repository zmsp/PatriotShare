package edu.gmu.mason.patriotshare.gae.db;

import com.google.appengine.api.datastore.Key;

import javax.jdo.annotations.IdGeneratorStrategy;
import javax.jdo.annotations.PersistenceCapable;
import javax.jdo.annotations.Persistent;
import javax.jdo.annotations.PrimaryKey;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.api.datastore.Transaction;

@PersistenceCapable
public class User extends HttpServlet {
	@PrimaryKey
	@Persistent(valueStrategy = IdGeneratorStrategy.IDENTITY)
	private Key key;

	@Persistent
	private String firstName;

	@Persistent
	private String lastName;

	@Persistent
	private String email;

	@Persistent
	private String password;
	
	@Persistent
	private String terms;
	
	@Persistent
	private double rating;
	
	@Persistent
	private String notification;
	

	public User(String firstName, String lastName, String email, String password, double rating) {
		this.firstName = firstName;
		this.lastName = lastName;
		this.email = email;
		this.password = password;
		this.rating = rating;
	}

	// Accessors for the fields. JDO doesn't use these, but your application
	// does.

	public Key getKey() {
		return key;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	/*
	 * Retrieving user input data from .jsp page (Yet to be created) public void
	 * doPost(HttpServletRequest request, HttpServletResponse response) throws
	 * IOException { String userName = request.getParameter("Username"); if
	 * (userName==null||userName.isEmpty()){ throw new
	 * IOException("Username field is empty"); }
	 */
	public static Key getKey(String userID) {
		long id = Long.parseLong(userID);
		Key userKey = KeyFactory.createKey("USERID", id);
		return userKey;
	}

	/*
	 * Creating Data store entity for user Still need to add input validation
	 */
	public static Entity createUser(String firstName, String lastName, String email, String password, double rating) {
		Entity user = null;
		DatastoreService datastore = DatastoreServiceFactory
				.getDatastoreService();

		Transaction txn = datastore.beginTransaction();
		try {

			user = new Entity(email);
			user.setProperty("firstName", firstName);
			user.setProperty("lastName", lastName);
			user.setProperty("email", email);
			user.setProperty("password", password);
			//user.setProperty("terms", terms);
			//user.setProperty("notification", notification);
			user.setProperty("rating", rating);
			datastore.put(user);
			txn.commit();
		} finally {
			if (txn.isActive()) {
				txn.rollback();

			}
		}
		return user;

	}

}
