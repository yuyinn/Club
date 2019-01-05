package com.v_evaluation.model;

public class V_evaluationVO {
	private String mem_no;
	private String v_no;
	private Integer score;
	
	public V_evaluationVO() {
		super();
	}
	
	public V_evaluationVO(String mem_no, String v_no, Integer score) {
		super();
		this.mem_no = mem_no;
		this.v_no = v_no;
		this.score = score;
	}

	public String getMem_no() {
		return mem_no;
	}
	public void setMem_no(String mem_no) {
		this.mem_no = mem_no;
	}
	public String getV_no() {
		return v_no;
	}
	public void setV_no(String v_no) {
		this.v_no = v_no;
	}
	public Integer getScore() {
		return score;
	}
	public void setScore(Integer score) {
		this.score = score;
	}
	
	
	
}
