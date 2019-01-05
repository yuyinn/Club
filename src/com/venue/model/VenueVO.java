package com.venue.model;

import java.io.Serializable;
import java.util.Arrays;

public class VenueVO implements Serializable , Cloneable{
	
	private String v_no;
	private String v_name;
	private String v_weburl;
	private String v_parktype;
	private String v_introduction;
	private String vt_no;
	private String v_inout;
	private Integer reg_no; 
	private String v_address;
	private String v_phoneno;
	private Double v_lat;
	private Double v_long;
	//private String v_public_transport;
	private String v_fitall;
	private String v_fitinter;
	private String open_state;
	private String open_time;
	private String openday_mon;
	private String openday_tue;
	private String openday_wed;
	private String openday_thu;
	private String openday_fri;
	private String openday_sat;
	private String openday_sun;
	private byte[] v_photo1;
	private String v_photo1_ext;
	private byte[] v_photo2;
	private String v_photo2_ext;
	private String v_photo1_url;
	private String v_photo2_url;
	private String v_display = "顯示";
	
	public VenueVO() {
		
	}
	
	public String getV_no() {
		return v_no;
	}
	public void setV_no(String v_no) {
		this.v_no = v_no;
	}
	public String getV_name() {
		return v_name;
	}
	public void setV_name(String v_name) {
		this.v_name = v_name;
	}
	public String getV_weburl() {
		return v_weburl;
	}
	public void setV_weburl(String v_weburl) {
		this.v_weburl = v_weburl;
	}
	public String getV_parktype() {
		return v_parktype;
	}
	public void setV_parktype(String v_parktype) {
		this.v_parktype = v_parktype;
	}
	public String getV_introduction() {
		return v_introduction;
	}
	public void setV_introduction(String v_introduction) {
		this.v_introduction = v_introduction;
	}
	public String getVt_no() {
		return vt_no;
	}
	public void setVt_no(String vt_no) {
		this.vt_no = vt_no;
	}
	public String getV_inout() {
		return v_inout;
	}
	public void setV_inout(String v_inout) {
		this.v_inout = v_inout;
	}
	public Integer getReg_no() {
		return reg_no;
	}
	public void setReg_no(Integer reg_no) {
		this.reg_no = reg_no;
	}
	public String getV_address() {
		return v_address;
	}
	public void setV_address(String v_address) {
		this.v_address = v_address;
	}
	public String getV_phoneno() {
		return v_phoneno;
	}
	public void setV_phoneno(String v_phoneno) {
		this.v_phoneno = v_phoneno;
	}
	public Double getV_lat() {
		return v_lat;
	}
	public void setV_lat(Double v_lat) {
		this.v_lat = v_lat;
	}
	public Double getV_long() {
		return v_long;
	}
	public void setV_long(Double v_long) {
		this.v_long = v_long;
	}
//	public String getV_public_transport() {
//		return v_public_transport;
//	}
//	public void setV_public_transport(String v_public_transport) {
//		this.v_public_transport = v_public_transport;
//	}
	public String getV_fitall() {
		return v_fitall;
	}
	public void setV_fitall(String v_fitall) {
		this.v_fitall = v_fitall;
	}
	public String getV_fitinter() {
		return v_fitinter;
	}
	public void setV_fitinter(String v_fitinter) {
		this.v_fitinter = v_fitinter;
	}
	public String getOpen_state() {
		return open_state;
	}
	public void setOpen_state(String open_state) {
		this.open_state = open_state;
	}
	public String getOpen_time() {
		return open_time;
	}
	public void setOpen_time(String open_time) {
		this.open_time = open_time;
	}
	public String getOpenday_mon() {
		return openday_mon;
	}
	public void setOpenday_mon(String openday_mon) {
		this.openday_mon = openday_mon;
	}
	public String getOpenday_tue() {
		return openday_tue;
	}
	public void setOpenday_tue(String openday_tue) {
		this.openday_tue = openday_tue;
	}
	public String getOpenday_wed() {
		return openday_wed;
	}
	public void setOpenday_wed(String openday_wed) {
		this.openday_wed = openday_wed;
	}
	public String getOpenday_thu() {
		return openday_thu;
	}
	public void setOpenday_thu(String openday_thu) {
		this.openday_thu = openday_thu;
	}
	public String getOpenday_fri() {
		return openday_fri;
	}
	public void setOpenday_fri(String openday_fri) {
		this.openday_fri = openday_fri;
	}
	public String getOpenday_sat() {
		return openday_sat;
	}
	public void setOpenday_sat(String openday_sat) {
		this.openday_sat = openday_sat;
	}
	public String getOpenday_sun() {
		return openday_sun;
	}
	public void setOpenday_sun(String openday_sun) {
		this.openday_sun = openday_sun;
	}
	public byte[] getV_photo1() {
		return v_photo1;
	}
	public void setV_photo1(byte[] v_photo1) {
		this.v_photo1 = v_photo1;
	}
	public String getV_photo1_ext() {
		return v_photo1_ext;
	}
	public void setV_photo1_ext(String v_photo1_ext) {
		this.v_photo1_ext = v_photo1_ext;
	}
	public byte[] getV_photo2() {
		return v_photo2;
	}
	public void setV_photo2(byte[] v_photo2) {
		this.v_photo2 = v_photo2;
	}
	public String getV_photo2_ext() {
		return v_photo2_ext;
	}
	public void setV_photo2_ext(String v_photo2_ext) {
		this.v_photo2_ext = v_photo2_ext;
	}
	public String getV_photo1_url() {
		return v_photo1_url;
	}

	public void setV_photo1_url(String v_photo1_url) {
		this.v_photo1_url = v_photo1_url;
	}

	public String getV_photo2_url() {
		return v_photo2_url;
	}

	public void setV_photo2_url(String v_photo2_url) {
		this.v_photo2_url = v_photo2_url;
	}

	public String getV_display() {
		return v_display;
	}

	public void setV_display(String v_display) {
		this.v_display = v_display;
	}

	@Override
	public String toString() {
		return "VenueVO [v_no=" + v_no + ", v_name=" + v_name + ", v_weburl=" + v_weburl + ", v_parktype=" + v_parktype
				+ ", v_introduction=" + v_introduction + ", vt_no=" + vt_no + ", v_inout=" + v_inout + ", reg_no="
				+ reg_no + ", v_address=" + v_address + ", v_phoneno=" + v_phoneno + ", v_lat=" + v_lat + ", v_long="
				+ v_long + ", v_fitall=" + v_fitall + ", v_fitinter=" + v_fitinter + ", open_state=" + open_state
				+ ", open_time=" + open_time + ", openday_mon=" + openday_mon + ", openday_tue=" + openday_tue
				+ ", openday_wed=" + openday_wed + ", openday_thu=" + openday_thu + ", openday_fri=" + openday_fri
				+ ", openday_sat=" + openday_sat + ", openday_sun=" + openday_sun + ", v_photo1="
				+ Arrays.toString(v_photo1) + ", v_photo1_ext=" + v_photo1_ext + ", v_photo2="
				+ Arrays.toString(v_photo2) + ", v_photo2_ext=" + v_photo2_ext + ", v_photo1_url=" + v_photo1_url
				+ ", v_photo2_url=" + v_photo2_url + ", v_display=" + v_display + "]";
	}

	
	
	
	
	
	
}
