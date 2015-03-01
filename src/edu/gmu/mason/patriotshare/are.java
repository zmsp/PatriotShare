package edu.gmu.mason.patriotshare;

import java.net.*;
import java.util.Scanner;
import java.io.*;

import org.json.*;

public class are {

	public static void main(String arg[]) throws JSONException {
		try {
			geocoding("abcd");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		}

	public static void geocoding(String addr) throws Exception
	{
		 // build a URL
	    String s = "https://www.googleapis.com/books/v1/volumes?q=isbn:0596009208";
	    
	    URL url = new URL(s);
	 
	    // read from the URL
	    Scanner scan = new Scanner(url.openStream());
	    String str = new String();
	    while (scan.hasNext())
	        str += scan.nextLine();
	    scan.close();
	 
	    // build a JSON object
	    JSONObject obj;
		try {
			obj = new JSONObject(str);
		

	    // get the first result
	    
	    JSONObject res = obj.getJSONArray("items").getJSONObject(0);
	    
	    if (obj.getInt("totalItems")==0){
	    	 throw new IOException("ISBN not found on Google Book");
	    }else{
	    	
	    
	    String description =
	        res.getJSONObject("volumeInfo").getString("description");
	    String title =
		        res.getJSONObject("volumeInfo").getString("title");
	    String authors =
		        res.getJSONObject("volumeInfo").getJSONArray("authors").toString();
	    String publisher =
		        res.getJSONObject("volumeInfo").getString("publisher");
	    String publishedDate =
		        res.getJSONObject("volumeInfo").getString("publishedDate");
	    String thumbnail=  res.getJSONObject("volumeInfo").getJSONObject("imageLinks").getString("thumbnail");
	   
	    System.out.println(description+title+authors+publisher+publishedDate+thumbnail);
	    
	    }
		} catch (JSONException e1) {
			// TODO Auto-generated catch block
			throw new IOException("Book information not found");
		}
	    
	    
	}
}
