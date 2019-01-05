package com.memberlist.model;


public class MemberlistVO implements java.io.Serializable{
	
	private static final long serialVersionUID = 88L;
	private String mem_no;
	private String mem_name;
	private String mem_nick;
	private String mem_account;
	private String mem_pswd;
	private String mem_email;
	private String mem_phone;
	private String mem_emgc;
	private String mem_emgcphone;
	private String mem_status;
	private String mem_card;
	private String mem_expiry;
	private byte[] mem_pic;
	private String mem_pickind;
	
	public MemberlistVO() {};
	//for insert
	public MemberlistVO(String mem_name,String mem_account,String mem_pswd,
			String mem_email,String mem_phone) {
		setMem_name(mem_name);
		setMem_account(mem_account);
		setMem_pswd(mem_pswd);
		setMem_email(mem_email);
		setMem_phone(mem_phone);
	}
	//for update privacy
	public MemberlistVO(String mem_no,String mem_name,String mem_nick,
			String mem_email,String mem_phone,String mem_emgc, String mem_emgcphone) {
		setMem_no(mem_no);
		setMem_name(mem_name);
		setMem_nick(mem_nick);
		setMem_email(mem_email);
		setMem_phone(mem_phone);
		setMem_emgc(mem_emgc);
		setMem_emgcphone(mem_emgcphone);
	}
	//for update craditcard
	public MemberlistVO(String mem_no,String mem_card, String mem_expiry) {
		setMem_no(mem_no);
		setMem_card(mem_card);
		setMem_expiry(mem_expiry);
	}
	//for update password
	public MemberlistVO(String mem_no, String mem_password) {
		setMem_no(mem_no);
		setMem_pswd(mem_password);
	}
	//fore update picture
	public MemberlistVO(String mem_no, byte[] mem_pic,String mem_pickind) {
		setMem_no(mem_no);
		setMem_pic(mem_pic);
		setMem_pickind(mem_pickind);
	}
	
	public String getMem_no() {
		return mem_no;
	}
	public void setMem_no(String mem_no) {
		this.mem_no = mem_no;
	}
	public String getMem_name() {
		return mem_name;
	}
	public void setMem_name(String mem_name) {
		this.mem_name = mem_name;
	}
	public String getMem_nick() {
		return mem_nick;
	}
	public void setMem_nick(String mem_nick) {
		this.mem_nick = mem_nick;
	}
	public String getMem_account() {
		return mem_account;
	}
	public void setMem_account(String mem_account) {
		this.mem_account = mem_account;
	}
	public String getMem_pswd() {
		return mem_pswd;
	}
	public void setMem_pswd(String mem_pswd) {
		this.mem_pswd = mem_pswd;
	}
	public String getMem_email() {
		return mem_email;
	}
	public void setMem_email(String mem_email) {
		this.mem_email = mem_email;
	}
	public String getMem_phone() {
		return mem_phone;
	}
	public void setMem_phone(String mem_phone) {
		this.mem_phone = mem_phone;
	}
	public String getMem_emgc() {
		return mem_emgc;
	}
	public void setMem_emgc(String mem_emgc) {
		this.mem_emgc = mem_emgc;
	}
	public String getMem_emgcphone() {
		return mem_emgcphone;
	}
	public void setMem_emgcphone(String mem_emgcphone) {
		this.mem_emgcphone = mem_emgcphone;
	}
	public String getMem_status() {
		return mem_status;
	}
	public void setMem_status(String mem_status) {
		this.mem_status = mem_status;
	}
	public String getMem_card() {
		return mem_card;
	}
	public void setMem_card(String mem_card) {
		this.mem_card = mem_card;
	}
	public String getMem_expiry() {
		return mem_expiry;
	}
	public void setMem_expiry(String mem_expiry) {
		this.mem_expiry = mem_expiry;
	}
	public byte[] getMem_pic() {
		return mem_pic;
	}
	public void setMem_pic(byte[] mem_pic) {
		this.mem_pic = mem_pic;
	}
	public String getMem_pickind() {
		return mem_pickind;
	}
	public void setMem_pickind(String mem_pickind) {
		this.mem_pickind = mem_pickind;
	}
	
	

}
