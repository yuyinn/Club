package com.memberlist.model;

import java.util.*;

import com.sg_info.model.Sg_infoVO;
import com.sg_mem.model.Sg_memVO;

public interface MemberlistDAO_interface {
	public void insert(MemberlistVO memberlist);
	public void updatePrivacy(MemberlistVO memberlist);
	public void updatePicture(MemberlistVO memberlist);
	public void updatePassword(MemberlistVO memberlist);
	public void updateCraditcard(MemberlistVO memberlist);
	public void updateStatus(String mem_no,String mem_status);
	public MemberlistVO findByPrimaryKey(String mem_no);
	public List<Sg_infoVO> findSgByMem(String mem_no);
	public List<Sg_memVO> findPartByMem(String mem_no);
	public String findByAccount(String account);
	public List<MemberlistVO> getAll();
}
