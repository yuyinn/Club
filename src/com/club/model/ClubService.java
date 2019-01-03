package com.club.model;

import java.util.List;
import java.util.Map;

public class ClubService {

	private ClubDAO_interface dao;
	
	public ClubService() {
		dao = new ClubDAO();
	}
	
	public ClubVO addClub(String sp_no,byte[] photo,String photo_ext,
			String club_status,String club_name,String club_intro) {
		
		ClubVO clubVO = new ClubVO();

		clubVO.setSp_no(sp_no);
		clubVO.setPhoto(photo);
		clubVO.setPhoto_ext(photo_ext);
		clubVO.setClub_status(club_status);
		clubVO.setClub_name(club_name);
		clubVO.setClub_intro(club_intro);
		dao.insert(clubVO);
		
		return clubVO;
	}
	
	public ClubVO updateClub(String club_no,String sp_no,byte[] photo,String photo_ext,
			String club_status,String club_name,String club_intro) {
		
		ClubVO clubVO = new ClubVO();
		
		clubVO.setClub_no(club_no);
		clubVO.setSp_no(sp_no);
		clubVO.setPhoto(photo);
		clubVO.setPhoto_ext(photo_ext);
		clubVO.setClub_status(club_status);
		clubVO.setClub_name(club_name);
		clubVO.setClub_intro(club_intro);
		dao.update(clubVO);
		
		return clubVO;
	}
	
	public ClubVO getOneClub(String club_no) {
		return dao.findByPrimaryKey(club_no);
	}
	
	public List<ClubVO> getAll(){
		return dao.getAll();
	}
	
	public List<ClubVO> getAll(Map<String, String[]> map) {
		return dao.getAll(map);
	}
	
}
