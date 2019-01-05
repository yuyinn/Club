package com.venuetype.model;

import java.util.*;

public interface VenueTypeDAO_interface {
	
	public void insert(VenueTypeVO vtVO);
	public void update(VenueTypeVO vtVO);
	public void delete(String vt_no);
    public VenueTypeVO findByPrimaryKey(String vt_no);
	public List<VenueTypeVO> getAll();
	
	public boolean isVenueType(String funcList, String vt_name);
	
	
	
//	萬用複合查詢(傳入參數型態Map)(回傳 List)
//  public List<VTVO> getAll(Map<String, String[]> map); 

}
