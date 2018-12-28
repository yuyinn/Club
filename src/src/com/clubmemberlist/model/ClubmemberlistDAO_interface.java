package com.clubmemberlist.model;

import java.util.List;

import com.club.model.ClubVO;

public interface ClubmemberlistDAO_interface {
	public void insert(ClubmemberlistVO clubmemberlistVO);
    public void update(ClubmemberlistVO clubmemberlistVO);
    public void delete(String club_no,String mem_no);
    public ClubmemberlistVO findByPrimaryKey(String club_no,String mem_no);
    public List<ClubmemberlistVO> getAll();
}
