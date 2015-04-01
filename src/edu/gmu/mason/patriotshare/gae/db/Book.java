package edu.gmu.mason.patriotshare.gae.db;

/**
 * Copyright 2015 -
 * Licensed under the Academic Free License version 3.0
 * http://opensource.org/licenses/AFL-3.0
 * 
 * Authors: Zobair Shahadat, Mihai Boicu
 */

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

/**
 * GAE ENTITY UTIL CLASS: "Book" <br>
 * PARENT: NONE <br>
 * KEY: A book long Id generated by GAE <br>
 * FEATURES: <br>
 * 
 * 
 * 
 * - "ISBN" a {@link String} with 10 or 13 digits<br>
 * - "title" a {@link String} with the title of the book <br>
 * - "the price is associated with an offer for selling or buying the book and
 * not with the book itself (you will need a different entity)<br>
 */
public final class Book {
	private static final String ISBN_PROPERTY = "isbn";
	private static final String TITLE_PROPERTY = "title";
	private static final String PRICE_PROPERTY = "price";

	/**
	 * The name of the Book ENTITY KIND used in GAE.
	 */
	private static final String ENTITY_KIND = "Book";
	private static final Pattern ISBN_PATTERN = Pattern
			.compile("\\A[0-9]{10,13}\\Z");
	private static final Pattern TITLE_PATTERN = Pattern
			.compile("\\A[ \\w-'',]{3,100}\\Z");

	//
	// SECURITY
	//

	/**
	 * Private constructor to avoid instantiation.
	 */
	private Book() {
	}

	//
	// KEY
	//

	/**
	 * Return the Key for a given book id given as String.
	 * 
	 * @param bookID
	 *            A string with the book ID (a long).
	 * @return the Key for this bookID.
	 */
	public static Key getKey(String bookID) {
		long id = Long.parseLong(bookID);
		Key bookKey = KeyFactory.createKey(ENTITY_KIND, id);
		return bookKey;
	}

	/**
	 * Return the string ID corresponding to the key for the book.
	 * 
	 * @param book
	 *            The GAE Entity storing the book.
	 * @return A string with the book ID (a long).
	 */
	public static String getStringID(Entity book) {
		return Long.toString(book.getKey().getId());
	}

	//
	// ISBN
	//

	/**
	 * The property name for the <b>ISBN</b> of the book.
	 */

	/**
	 * Return the ISBN of the book.
	 * 
	 * @param book
	 *            The GAE Entity storing the book.
	 * @return the ISBN of the book as a String.
	 */
	public static String getISBN(Entity book) {
		return (String) book.getProperty(ISBN_PROPERTY);
	}

	/**
	 * The regular expression pattern for the ISBN of the book.
	 */

	/**
	 * Check if the ISBN is correct for a book.
	 * 
	 * @param isbn
	 *            The checked string.
	 * @return true is the ISBN is correct.
	 */
	public static boolean checkIsbn(String isbn) {
		Matcher matcher = ISBN_PATTERN.matcher(isbn);
		return (isbn.length() == 10 || isbn.length() == 13) && matcher.find();
	}

	//

	// TITLE
	//

	/**
	 * The property name for the <b>title</b> of the book.
	 */

	/**
	 * Return the title of the book.
	 * 
	 * @param book
	 *            The GAE Entity storing the title.
	 * @return the title of the book.
	 */
	public static String getTitle(Entity book) {
		return (String) book.getProperty(TITLE_PROPERTY);
	}

	/**
	 * The regular expression pattern for the title of the book.
	 */

	/**
	 * Check if the title is correct for a book.
	 * 
	 * @param title
	 *            The checked string.
	 * @return true is the title is correct.
	 */
	public static boolean checkTitle(String title) {
		Matcher matcher = TITLE_PATTERN.matcher(title);
		return matcher.find();
	}

	//
	// CREATE BOOK
	//

	/**
	 * Create a new book if the title and ISBN is correct and none exists with
	 * this ISBN.
	 * 
	 * 
	 * @param isbn
	 *            The ISBN for the book.
	 * @param title
	 *            The title for the book.
	 * @return the Entity created with this ISBN and title or null if error
	 */
	public static Entity createBook(String isbn, String title, Double price) {
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
			book.setProperty(PRICE_PROPERTY, price);
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

	/**
	 * Get a book based on a string containing its long ID.
	 * 
	 * 
	 * @param id
	 *            A {@link String} containing the ID key (a <code>long</code>
	 *            number)
	 * @return A GAE {@link Entity} for the Book or <code>null</code> if none or
	 *         error.
	 */
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

	/**
	 * Get a book based on a string containing its ISBN.
	 * 
	 * 
	 * @param isbn
	 *            The ISBN of the book as a String.
	 * @return A GAE {@link Entity} for the Book or <code>null</code> if none or
	 *         error.
	 */
	public static Entity getBookWithISBN(String isbn) {
		DatastoreService datastore = DatastoreServiceFactory
				.getDatastoreService();
		return getBookWithISBN(datastore, isbn);
	}

	/**
	 * Get a book based on a string containing its ISBN.
	 * 
	 * 
	 * @param datastore
	 *            The current datastore instance.
	 * @param isbn
	 *            The ISBN of the book as a String.
	 * @return A GAE {@link Entity} for the Book or <code>null</code> if none or
	 *         error.
	 */
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

	/**
	 * Delete the book if not linked to anything else.
	 * 
	 * @param bookID
	 *            A string with the book ID (a long).
	 * @return True if succeed, false otherwise.
	 */
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

	/**
	 * 
	 * 
	 * 
	 * 
	 * Return the requested number of books (e.g. 100).
	 * 
	 * @param limit
	 *            The number of books to be returned.
	 * @return A list of GAE {@link Entity entities}.
	 */

	public static List<Entity> getFirstBooks(int limit) {
		DatastoreService datastore = DatastoreServiceFactory
				.getDatastoreService();

		Query query = new Query(ENTITY_KIND);
		List<Entity> result = datastore.prepare(query).asList(
				FetchOptions.Builder.withLimit(limit));
		return result;
	}

}
