package com.sg_mem.model;

import java.io.Serializable;

public class Sg_memVO implements Serializable{

	private String sg_no;
	private String mem_no;
	private String ch_status;
	
	public Sg_memVO() {
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

	public String getCh_status() {
		return ch_status;
	}

	public void setCh_status(String ch_status) {
		this.ch_status = ch_status;
	}
	
	
}
