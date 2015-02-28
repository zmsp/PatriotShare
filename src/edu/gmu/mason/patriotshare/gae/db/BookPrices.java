package edu.gmu.mason.patriotshare.gae.db;

//class used to store prices

public class BookPrices {
	private String storeName; 
	private double price; 
	
	public BookPrices()
	{
		this("", 0.0); 
	}
	public BookPrices(String storeName, double price)
	{
		this.storeName = storeName; 
		this.price = price; 
	}
	
	
	
	public String getName(){return this.storeName;}
	public double getPrice(){return this.price;}
	

}
