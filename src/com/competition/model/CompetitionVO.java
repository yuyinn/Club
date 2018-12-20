package com.competition.model;

import java.io.Serializable;
import java.sql.Timestamp;

public class CompetitionVO implements Serializable{
	private static final long serialVersionUID = -4659971941172936503L;

	@Override
	public String toString() {
		return "CompetitionVO ["
				+ "\ncomp_no=" + comp_no + ", "
						+ "\ncomp_name=" + comp_name + ", "
								+ "\ncomp_startdate=" + comp_startdate
				+ ", "
				+ "\ncomp_enddate=" + comp_enddate + ", "
						+ "\ncomp_cont=" + comp_cont + "]";
	}

	private String comp_no;
	private String comp_name;
	private Timestamp comp_startdate;
	private Timestamp comp_enddate;
	private String comp_cont;
	
	public CompetitionVO(){
	}

	public String getComp_no() {
		return comp_no;
	}

	public void setComp_no(String comp_no) {
		this.comp_no = comp_no;
	}

	public String getComp_name() {
		return comp_name;
	}

	public void setComp_name(String comp_name) {
		this.comp_name = comp_name;
	}

	public Timestamp getComp_startdate() {
		return comp_startdate;
	}

	public void setComp_startdate(Timestamp comp_startdate) {
		this.comp_startdate = comp_startdate;
	}

	public Timestamp getComp_enddate() {
		return comp_enddate;
	}

	public void setComp_enddate(Timestamp comp_enddate) {
		this.comp_enddate = comp_enddate;
	}

	public String getComp_cont() {
		return comp_cont;
	}

	public void setComp_cont(String comp_cont) {
		this.comp_cont = comp_cont;
	}

	
	
}
