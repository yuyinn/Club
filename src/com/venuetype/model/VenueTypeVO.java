package com.venuetype.model;

public class VenueTypeVO {
	private String vt_no;
	private String vt_name;
	
	public VenueTypeVO() {
		super();
	}
	
	public VenueTypeVO(String vt_name) {
		super();
		this.vt_name = vt_name;
	}
	
	public String getVt_no() {
		return vt_no;
	}
	public void setVt_no(String vt_no) {
		this.vt_no = vt_no;
	}
	public String getVt_name() {
		return vt_name;
	}
	public void setVt_name(String vt_name) {
		this.vt_name = vt_name;
	}	
	
}
