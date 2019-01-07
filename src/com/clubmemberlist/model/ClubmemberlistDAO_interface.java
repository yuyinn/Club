package com.clubmemberlist.model;

import java.util.List;
import java.util.Map;

import com.club.model.ClubVO;

public interface ClubmemberlistDAO_interface {
	public void insert(ClubmemberlistVO clubmemberlistVO);
    public void update(ClubmemberlistVO clubmemberlistVO);
//    public void delete(String club_no,String mem_no);
    public ClubmemberlistVO findByPrimaryKey(String club_no,String mem_no);
    public List<ClubmemberlistVO> getAll();
  
    public List<ClubmemberlistVO> getAll(Map<String, String[]> map);

    
	
}
