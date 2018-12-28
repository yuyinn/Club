package com.competition.model;

import java.util.List;

public interface CompetitionDAO_interface {
	
	public void insert(CompetitionVO competitionVO);
    public void update(CompetitionVO competitionVO);
    public void delete(String comp_no);
    public CompetitionVO findByPrimaryKey(String comp_no);
    public List<CompetitionVO> getAll();
    public List<CompetitionVO> getCompetitionByStartDate(java.sql.Timestamp timestamp);
	
}
