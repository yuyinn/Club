package com.clubmemberlist.model;

import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

public class ClubmemberlistService {

	private ClubmemberlistDAO_interface dao;
	
	public ClubmemberlistService() {
		dao = new ClubmemberlistDAO();
	}
	
	public ClubmemberlistVO addClubmemberlist(String cmem_status,String cmem_class,Timestamp silence_time) {
		
		ClubmemberlistVO clubmemberlistVO = new ClubmemberlistVO();

		
		clubmemberlistVO.setCmem_status(cmem_status);
		clubmemberlistVO.setCmem_class(cmem_class);
		clubmemberlistVO.setSilence_time(silence_time);

		dao.insert(clubmemberlistVO);
		
		return clubmemberlistVO;
	}
	
	public ClubmemberlistVO updateClubmemberlist(String club_no,String mem_no,String cmem_status,String cmem_class,Timestamp silence_time) {
		
		ClubmemberlistVO clubmemberlistVO = new ClubmemberlistVO();
		
		clubmemberlistVO.setClub_no(club_no);
		clubmemberlistVO.setMem_no(mem_no);
		clubmemberlistVO.setCmem_status(cmem_status);
		clubmemberlistVO.setCmem_class(cmem_class);
		clubmemberlistVO.setSilence_time(silence_time);

		dao.update(clubmemberlistVO);
		
		return clubmemberlistVO;
	}
	
	public ClubmemberlistVO getOneClubmemberlist(String club_no,String mem_no) {
		return dao.findByPrimaryKey(club_no, mem_no);
	}
	
	public List<ClubmemberlistVO> getAll(){
		return dao.getAll();
	}
	
	public List<ClubmemberlistVO> getAll(Map<String, String[]> map) {
		return dao.getAll(map);
	}
	
}
