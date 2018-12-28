package com.sport.model;

import java.io.Serializable;

public class SportVO  implements Serializable{
	
	private String sp_no;
	private String sp_name;
	
	public SportVO() {
		super();
	}

	public String getSp_no() {
		return sp_no;
	}

	public void setSp_no(String sp_no) {
		this.sp_no = sp_no;
	}

	public String getSp_name() {
		return sp_name;
	}

	public void setSp_name(String sp_name) {
		this.sp_name = sp_name;
	}
	
	
}
