package com.sport.model;

import java.util.List;

import com.club.model.ClubVO;

public class SportService {
	private SportDAO_interface dao;
	
	public SportService() {
		dao = new SportDAO();
	}
	
	public SportVO addSport(String sp_no,String sp_name) {
		SportVO sportVO = new SportVO();
		sportVO.setSp_no(sp_no);
		sportVO.setSp_name(sp_name);
		dao.insert(sportVO);
		
		return sportVO;
	}
	
	public SportVO updateSport(String sp_no,String sp_name) {
		SportVO sportVO = new SportVO();
		sportVO.setSp_no(sp_no);
		sportVO.setSp_name(sp_name);
		dao.update(sportVO);
		
		return sportVO;
	}
	
	public SportVO getOneClub(String sp_no) {
		return dao.findByPk(sp_no);
	}
	
	public List<SportVO> getAll(){
		return dao.getAll();
	}
	
}
