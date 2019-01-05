package com.memberlist.model;

import java.util.*;

import com.sg_info.model.Sg_infoVO;
import com.sg_mem.model.Sg_memVO;

public class MemberlistService {

	private MemberlistDAO_interface dao;
	public MemberlistService() {
		dao = new MemberlistDAO();
	}
	
	public MemberlistVO addmemberlist(String mem_name,String mem_account,String mem_pswd,
			String mem_email,String mem_phone) {
		
		MemberlistVO memberlistVO = new MemberlistVO(mem_name,mem_account,mem_pswd,
				mem_email,mem_phone);
		dao.insert(memberlistVO);
		
		return memberlistVO;
	}
	
	public MemberlistVO renewPrivacy(String mem_no,String mem_name,String mem_nick,
			String mem_email,String mem_phone,String mem_emgc, String mem_emgcphone) {
		
		MemberlistVO memberlistVO = new MemberlistVO(mem_no,mem_name,mem_nick,
				mem_email,mem_phone,mem_emgc,mem_emgcphone);
		dao.updatePrivacy(memberlistVO);
		
		return memberlistVO;
	}
	
	public MemberlistVO renewCard(String mem_no,String mem_card, String mem_expiry) {
		
		MemberlistVO memberlistVO = new MemberlistVO(mem_no,mem_card,mem_expiry);
		dao.updateCraditcard(memberlistVO);
		
		return memberlistVO;
	}
	
	public MemberlistVO renewPassword(String mem_no, String mem_password) {
		
		MemberlistVO memberlistVO = new MemberlistVO(mem_no,mem_password);
		dao.updatePassword(memberlistVO);
		
		return memberlistVO;
	}
	
	public MemberlistVO renewPicture(String mem_no, byte[] mem_pic,String mem_pickind) {
		MemberlistVO memberlistVO = new MemberlistVO(mem_no,mem_pic,mem_pickind);
		dao.updatePicture(memberlistVO);
		
		return memberlistVO;
	}
	
	public void changeStatus(String mem_no, String mem_status) {
		dao.updateStatus(mem_no, mem_status);
	}
	
	public MemberlistVO getOneMem(String mem_no) {	
		return dao.findByPrimaryKey(mem_no);
	}
	
	public List<Sg_infoVO> getSgHostByMem(String mem_no) {
		return dao.findSgByMem(mem_no);
	}
	
	public List<Sg_memVO> getSgPartByMem(String mem_no) {
		return dao.findPartByMem(mem_no);
	}
	
	public String getOneMemByAccount(String account) {
		return dao.findByAccount(account);
	}
	
	public List<MemberlistVO> getAllMem(){
		return dao.getAll();
	}
	
}
