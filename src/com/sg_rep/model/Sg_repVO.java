package com.sg_rep.model;

import java.io.Serializable;

public class Sg_repVO implements Serializable{
	
	private String rep_no;
	private String sg_no;
	private String mem_no;
	private String rep_type;
	private String rep_cont;
	private String rep_status;
	
	public Sg_repVO() {
		super();
	}

	public String getRep_no() {
		return rep_no;
	}

	public void setRep_no(String rep_no) {
		this.rep_no = rep_no;
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

	public String getRep_type() {
		return rep_type;
	}

	public void setRep_type(String rep_type) {
		this.rep_type = rep_type;
	}

	public String getRep_cont() {
		return rep_cont;
	}

	public void setRep_cont(String rep_cont) {
		this.rep_cont = rep_cont;
	}

	public String getRep_status() {
		return rep_status;
	}

	public void setRep_status(String rep_status) {
		this.rep_status = rep_status;
	}
	
}
