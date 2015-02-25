package edu.gmu.mason.patriotshare.gae.db;
import com.google.appengine.api.datastore.Key;

import javax.jdo.annotations.IdGeneratorStrategy;
import javax.jdo.annotations.PersistenceCapable;
import javax.jdo.annotations.Persistent;
import javax.jdo.annotations.PrimaryKey;

import java.io.IOException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.api.datastore.Transaction;

public class PSTransaction {
	 @PrimaryKey
	    @Persistent(valueStrategy = IdGeneratorStrategy.IDENTITY)
	    private Key transactionID;

	    @Persistent
	    private String posterFirstName;

	    @Persistent
	    private String posterLastName;
	   
	    @Persistent
		private String email;
	    
	    @Persistent
		private Object book;
	    
	    @Persistent
		private double price;

	    public PSTransaction (String posterFirstName, String posterLastName, String email, Double price) {
	        this.posterFirstName = posterFirstName;
	        this.posterLastName = posterLastName;
	        this.email = email;
	        this.price = price;
	    }

	    // Accessors for the fields. JDO doesn't use these, but your application does.

	    public Key getKey() {
	        return transactionID;
	    }

	    public String getFirstName() {
	        return posterFirstName;
	    }
	    public void setFirstName(String firstName) {
	        this.posterFirstName = firstName;
	    }

	    public String getLastName() {
	        return posterLastName;
	    }

	    public void setLastName(String lastName) {
	        this.posterLastName = lastName;
	    }

	    public String getEmail() {
	        return email;
	    }
	    
	    public void setEmail(String email) {
	        this.email = email;
	    }
	    public Double getPrice() {
	        return price;
	    }
	    
	    public void setPrice(Double price) {
	        this.price = price;
	    }
	    
	    public static Key getKey(String transactionID){
	    	long id = Long.parseLong(transactionID);
	    	Key transKey = KeyFactory.createKey("TRANSACTIONID", id);
	    	return transKey;
	    }
	    public static Entity createPSTransaction(Key key, String firstName, String lastName, String email, double price ) {
	    	Entity psTransaction = null;
	    	DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
	    	
	    	Transaction txn = datastore.beginTransaction();
	    	try {
	    	
	    		psTransaction = new Entity(key);
	    		psTransaction.setProperty("FNAME", firstName);
	    		psTransaction.setProperty("LNAME", lastName);
	    		psTransaction.setProperty("EMAIL", email);
	    		psTransaction.setProperty("PRICE", price);
	    		datastore.put(psTransaction);
	    		txn.commit();
	    	} finally {
	    		if (txn.isActive()) {
	    			txn.rollback();

	    		}
	    	}
	    		return psTransaction;	
	    	
	    	}
}
