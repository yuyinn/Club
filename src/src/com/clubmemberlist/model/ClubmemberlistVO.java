package com.clubmemberlist.model;

import java.sql.Timestamp;

public class ClubmemberlistVO implements java.io.Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private String club_no;
	private String mem_no;
	private String cmem_status;
	private String cmem_class;
	private Timestamp silence_time;
	
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
	public String getCmem_status() {
		return cmem_status;
	}
	public void setCmem_status(String cmem_status) {
		this.cmem_status = cmem_status;
	}
	public String getCmem_class() {
		return cmem_class;
	}
	public void setCmem_class(String cmem_class) {
		this.cmem_class = cmem_class;
	}
	public Timestamp getSilence_time() {
		return silence_time;
	}
	public void setSilence_time(Timestamp silence_time) {
		this.silence_time = silence_time;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}	

}
