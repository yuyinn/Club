package com.club.model;

public class ClubVO implements java.io.Serializable{
	private static final long serialVersionUID = 1L;
	
	private String club_no;
	private String sp_no;
	private byte[] photo;
	private String photo_ext; 
	private String club_status;
	private String club_name;
	private String club_intro;
	
	public String getClub_no() {
		return club_no;
	}
	public void setClub_no(String club_no) {
		this.club_no = club_no;
	}
	public String getSp_no() {
		return sp_no;
	}
	public void setSp_no(String sp_no) {
		this.sp_no = sp_no;
	}
	public byte[] getPhoto() {
		return photo;
	}
	public void setPhoto(byte[] photo) {
		this.photo = photo;
	}
	public String getPhoto_ext() {
		return photo_ext;
	}
	public void setPhoto_ext(String photo_ext) {
		this.photo_ext = photo_ext;
	}
	public String getClub_status() {
		return club_status;
	}
	public void setClub_status(String club_status) {
		this.club_status = club_status;
	}
	public String getClub_name() {
		return club_name;
	}
	public void setClub_name(String club_name) {
		this.club_name = club_name;
	}
	public String getClub_intro() {
		return club_intro;
	}
	public void setClub_intro(String club_intro) {
		this.club_intro = club_intro;
	}
	
	
	
}
