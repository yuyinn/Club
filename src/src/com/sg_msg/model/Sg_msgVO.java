package com.sg_msg.model;

import java.io.Serializable;
import java.sql.Timestamp;

public class Sg_msgVO implements Serializable{

	private String msg_no;
	private String sg_no;
	private String mem_no;
	private String msg_cont;
	private Timestamp msg_time;
	
	public Sg_msgVO() {
		super();
	}

	public String getMsg_no() {
		return msg_no;
	}

	public void setMsg_no(String msg_no) {
		this.msg_no = msg_no;
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

	public String getMsg_cont() {
		return msg_cont;
	}

	public void setMsg_cont(String msg_cont) {
		this.msg_cont = msg_cont;
	}

	public Timestamp getMsg_time() {
		return msg_time;
	}

	public void setMsg_time(Timestamp msg_time) {
		this.msg_time = msg_time;
	}
	
}
