package com.competition.model;

import java.sql.Timestamp;
import java.util.List;


public class CompetitionService {
	private CompetitionDAO_interface dao;
	
	public CompetitionService() {
		dao = new CompetitionDAO();
	}
	
	public CompetitionVO addCompetition(String comp_name ,Timestamp comp_startdate ,Timestamp comp_enddate ,String comp_cont) {
		
		CompetitionVO competitionVO = new CompetitionVO();
	
		competitionVO.setComp_name(comp_name);
		competitionVO.setComp_startdate(comp_startdate);
		competitionVO.setComp_enddate(comp_enddate);
		competitionVO.setComp_cont(comp_cont);
		dao.insert(competitionVO);
		
		return competitionVO;
	}
	
	public CompetitionVO updateCompetition(String comp_no ,String comp_name ,Timestamp comp_startdate ,Timestamp comp_enddate ,String comp_cont) {
		
		CompetitionVO competitionVO = new CompetitionVO();
		
		competitionVO.setComp_no(comp_no);
		competitionVO.setComp_name(comp_name);
		competitionVO.setComp_startdate(comp_startdate);
		competitionVO.setComp_enddate(comp_enddate);
		competitionVO.setComp_cont(comp_cont);
		dao.update(competitionVO);
		
		return competitionVO;
	}
	
	public CompetitionVO getOneCompetition(String comp_no) {
		return dao.findByPrimaryKey(comp_no);
	}
	
	public List<CompetitionVO> getAll(){
		return dao.getAll();
	}
}
