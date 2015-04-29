package edu.gmu.mason.patriotshare.gae.db;

import java.io.IOException;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.FetchOptions;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.api.datastore.Query;
import com.google.appengine.api.datastore.Query.Filter;
import com.google.appengine.api.datastore.Query.FilterOperator;
import com.google.appengine.api.datastore.Query.FilterPredicate;
import com.google.appengine.api.datastore.Transaction;

import edu.gmu.mason.patriotshare.gae.db.UserProfile;

public final class BookWish {

	private static final String ISBN_PROPERTY = "isbn";
	private static final String TITLE_PROPERTY = "title";

	private static final String ENTITY_KIND = "BookWish";
	private static final Pattern ISBN_PATTERN = Pattern
			.compile("\\A[0-9]{10,13}\\Z");
	private static final Pattern TITLE_PATTERN = Pattern
			.compile("\\A[ \\w-'',]{3,100}\\Z");
	private static final Pattern USERID_PATTERN = Pattern
			.compile("^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$"); //userid@domain.tld

	
	private BookWish() {
	}

	
	public static Key getKey(String bookID) {
		long id = Long.parseLong(bookID);
		Key bookKey = KeyFactory.createKey(ENTITY_KIND, id);
		return bookKey;
	}

	public static String getStringID(Entity book) {
		return Long.toString(book.getKey().getId());
	}

	
	public static String getISBN(Entity book) {
		return (String) book.getProperty(ISBN_PROPERTY);
	}
	
	
//	public static String getUserID(Entity book) {
//		return (String) book.getProperty(USERID_PROPERTY);
//	}
	
	
	public static boolean checkIsbn(String isbn) {
		Matcher matcher = ISBN_PATTERN.matcher(isbn);
		return (isbn.length() == 10 || isbn.length() == 13) && matcher.find();
	}

	
	public static String getTitle(Entity book) {
		return (String) book.getProperty(TITLE_PROPERTY);
	}

	
	public static boolean checkTitle(String title) {
		Matcher matcher = TITLE_PATTERN.matcher(title);
		return matcher.find();
	}
	
	
	public static boolean checkUserID(String email) {
		Matcher matcher = USERID_PATTERN.matcher(email);
		return matcher.find();
	}


	public static Entity createBook(String isbn, String title) {
		Entity book = null;
		DatastoreService datastore = DatastoreServiceFactory
				.getDatastoreService();
		Transaction txn = datastore.beginTransaction();
		try {
			//Multiple isbn are allowed
			/*if (!checkIsbn(isbn)) {
				return null;

			}*/
			

			book = getBookWithISBN(isbn);
			if (book != null) {
				return null;

			}

			book = new Entity(ENTITY_KIND);
			book.setProperty(ISBN_PROPERTY, isbn);
			book.setProperty(TITLE_PROPERTY, title);
			//book.setProperty(USERID_PROPERTY, userid);
			datastore.put(book);

			txn.commit();
		} finally {
			if (txn.isActive()) {
				txn.rollback();

			}
		}  
		return book;
	}

	//
	// GET BOOK
	//

	public static Entity getBook(String bookId) {
		Entity book = null;
		try {
			DatastoreService datastore = DatastoreServiceFactory
					.getDatastoreService();
			long id = Long.parseLong(bookId);
			Key bookKey = KeyFactory.createKey(ENTITY_KIND, id);
			book = datastore.get(bookKey);
		} catch (Exception e) {
			e.printStackTrace();

		}
		return book;
	}

	
	public static Entity getBookWithISBN(String isbn) {
		DatastoreService datastore = DatastoreServiceFactory
				.getDatastoreService();
		return getBookWithISBN(datastore, isbn);
	}

	public static Entity getBookWithISBN(DatastoreService datastore, String isbn) {
		Entity book = null;
		try {

			Filter hasISBN = new FilterPredicate(ISBN_PROPERTY,
					FilterOperator.EQUAL, isbn);
			Query query = new Query(ENTITY_KIND);
			query.setFilter(hasISBN);
			List<Entity> result = datastore.prepare(query).asList(
					FetchOptions.Builder.withLimit(10));
			if (result != null && result.size() > 0) {
				book = result.get(0);

			}
		} catch (Exception e) {
			e.printStackTrace();

		}
		return book;
	}

	//
	// DELETE BOOK
	//

	public static boolean deleteBookCommand(String bookID) {
		try {
			DatastoreService datastore = DatastoreServiceFactory
					.getDatastoreService();
			datastore.delete(getKey(bookID));
		} catch (Exception e) {
			return false;
		}
		return true;
	}

	//
	// QUERY BOOKS
	//

	public static List<Entity> getFirstBooks(int limit) {
		DatastoreService datastore = DatastoreServiceFactory
				.getDatastoreService();

		Query query = new Query(ENTITY_KIND);
		List<Entity> result = datastore.prepare(query).asList(
				FetchOptions.Builder.withLimit(limit));
		return result;
	}


	public static void createBookWish(String email, String isbn, String title) {
		Entity book = null;
		DatastoreService datastore = DatastoreServiceFactory
				.getDatastoreService();
		Transaction txn = datastore.beginTransaction();
		try {
			//Multiple isbn are allowed
			/*if (!checkIsbn(isbn)) {
				return null;

			}*/
			

			book = getBookWithISBN(isbn);
			if (book != null) {

			}

			book = new Entity(ENTITY_KIND);
			book.setProperty("email", email);
			book.setProperty(ISBN_PROPERTY, isbn);
			book.setProperty(TITLE_PROPERTY, title);
			datastore.put(book);

			txn.commit();
		} finally {
			if (txn.isActive()) {
				txn.rollback();

			}
		}
		
	}

	
}
