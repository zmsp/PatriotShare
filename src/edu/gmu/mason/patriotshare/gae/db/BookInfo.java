package edu.gmu.mason.patriotshare.gae.db;

//class used to store prices

public class BookInfo {

	private String title; 
	private String descirption; 
	private String publishedDate; 
	private double price;
	
	public BookInfo()
	{
		this("","",""); 
	}
	public BookInfo(String title, String description, String publishedDate )
	{
		this.title=title;
		this.descirption= description;
		this.publishedDate= publishedDate;
		
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getDescirption() {
		return descirption;
	}
	public void setDescirption(String descirption) {
		this.descirption = descirption;
	}
	public String getPublishedDate() {
		return publishedDate;
	}
	public void setPublishedDate(String publishedDate) {
		this.publishedDate = publishedDate;
	}
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}
 
	
	

}
