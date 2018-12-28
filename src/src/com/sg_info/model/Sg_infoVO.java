package com.sg_info.model;

import java.io.Serializable;
import java.sql.Timestamp;

public class Sg_infoVO implements Serializable{

	private String sg_no;
	private String mem_no;
	private String sg_name;
	private Timestamp sg_date;
	private Timestamp apl_start;
	private Timestamp apl_end;
	private Integer sg_fee;
	private byte[] sg_pic;
	private String sg_pic_ext;
	private String sg_per;
	private String sport_no;
	private String venue_no;
	private Integer sg_maxno;
	private Integer sg_minno;
	private Integer sg_ttlapl;
	private Integer sg_chkno;
	private String sg_extrainfo;
	private String sg_status;
	private Double loc_start_lat;
	private Double loc_start_lng;
	private Double loc_end_lat;
	private Double loc_end_lng;
	
	public Sg_infoVO() {
		super();
	}

	public String getSg_no() {
		return sg_no;
	}

	public void setSg_no(String sg_no) {
		this.sg_no = sg_no;
	}

	public String getMem_no() {
		return mem_no;
	}

	public void setMem_no(String mem_no) {
		this.mem_no = mem_no;
	}

	public String getSg_name() {
		return sg_name;
	}

	public void setSg_name(String sg_name) {
		this.sg_name = sg_name;
	}

	public Timestamp getSg_date() {
		return sg_date;
	}

	public void setSg_date(Timestamp sg_date) {
		this.sg_date = sg_date;
	}

	public Timestamp getApl_start() {
		return apl_start;
	}

	public void setApl_start(Timestamp apl_start) {
		this.apl_start = apl_start;
	}

	public Timestamp getApl_end() {
		return apl_end;
	}

	public void setApl_end(Timestamp apl_end) {
		this.apl_end = apl_end;
	}

	public Integer getSg_fee() {
		return sg_fee;
	}

	public void setSg_fee(Integer sg_fee) {
		this.sg_fee = sg_fee;
	}

	public byte[] getSg_pic() {
		return sg_pic;
	}

	public void setSg_pic(byte[] sg_pic) {
		this.sg_pic = sg_pic;
	}

	public String getSg_pic_ext() {
		return sg_pic_ext;
	}

	public void setSg_pic_ext(String sg_pic_ext) {
		this.sg_pic_ext = sg_pic_ext;
	}

	public String getSg_per() {
		return sg_per;
	}

	public void setSg_per(String sg_per) {
		this.sg_per = sg_per;
	}

	public String getSport_no() {
		return sport_no;
	}

	public void setSport_no(String sport_no) {
		this.sport_no = sport_no;
	}

	public String getVenue_no() {
		return venue_no;
	}

	public void setVenue_no(String venue_no) {
		this.venue_no = venue_no;
	}

	public Integer getSg_maxno() {
		return sg_maxno;
	}

	public void setSg_maxno(Integer sg_maxno) {
		this.sg_maxno = sg_maxno;
	}

	public Integer getSg_minno() {
		return sg_minno;
	}

	public void setSg_minno(Integer sg_minno) {
		this.sg_minno = sg_minno;
	}

	public Integer getSg_ttlapl() {
		return sg_ttlapl;
	}

	public void setSg_ttlapl(Integer sg_ttlapl) {
		this.sg_ttlapl = sg_ttlapl;
	}

	public Integer getSg_chkno() {
		return sg_chkno;
	}

	public void setSg_chkno(Integer sg_chkno) {
		this.sg_chkno = sg_chkno;
	}

	public String getSg_extrainfo() {
		return sg_extrainfo;
	}

	public void setSg_extrainfo(String sg_extrainfo) {
		this.sg_extrainfo = sg_extrainfo;
	}

	public String getSg_status() {
		return sg_status;
	}

	public void setSg_status(String sg_status) {
		this.sg_status = sg_status;
	}

	public Double getLoc_start_lat() {
		return loc_start_lat;
	}

	public void setLoc_start_lat(Double loc_start_lat) {
		this.loc_start_lat = loc_start_lat;
	}

	public Double getLoc_start_lng() {
		return loc_start_lng;
	}

	public void setLoc_start_lng(Double loc_start_lng) {
		this.loc_start_lng = loc_start_lng;
	}

	public Double getLoc_end_lat() {
		return loc_end_lat;
	}

	public void setLoc_end_lat(Double loc_end_lat) {
		this.loc_end_lat = loc_end_lat;
	}

	public Double getLoc_end_lng() {
		return loc_end_lng;
	}

	public void setLoc_end_lng(Double loc_end_lng) {
		this.loc_end_lng = loc_end_lng;
	};
	
}
