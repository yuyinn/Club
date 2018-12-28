package com.post_info.model;

import java.sql.Timestamp;

public class Post_infoVO implements java.io.Serializable{
	private String post_no;
	private String club_no;
	private String mem_no;
	private String post_topic;
	private String post_content;
	private Timestamp post_date;
	
	
	public String getPost_no() {
		return post_no;
	}
	public void setPost_no(String post_no) {
		this.post_no = post_no;
	}
	public String getClub_no() {
		return club_no;
	}
	public void setClub_no(String club_no) {
		this.club_no = club_no;
	}
	public String getMem_no() {
		return mem_no;
	}
	public void setMem_no(String mem_no) {
		this.mem_no = mem_no;
	}
	public String getPost_topic() {
		return post_topic;
	}
	public void setPost_topic(String post_topic) {
		this.post_topic = post_topic;
	}
	public String getPost_content() {
		return post_content;
	}
	public void setPost_content(String post_content) {
		this.post_content = post_content;
	}
	public Timestamp getPost_date() {
		return post_date;
	}
	public void setPost_date(Timestamp post_date) {
		this.post_date = post_date;
	}
	
	
}
