package com.club.model;

import java.util.List;
import java.util.Map;

public interface ClubDAO_interface {
	public void insert(ClubVO clubVO);
    public void update(ClubVO clubVO);
    public ClubVO findByPrimaryKey(String club_no);
    public List<ClubVO> getAll();
  //萬用複合查詢(傳入參數型態Map)(回傳 List)
    public List<ClubVO> getAll(Map<String, String[]> map);
}
