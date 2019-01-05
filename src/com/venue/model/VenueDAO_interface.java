package com.venue.model;

import java.util.List;
import java.util.Map;

public interface VenueDAO_interface {

	public void insert(VenueVO venueVO);
	public void update(VenueVO venueVO);
	public void delete(String v_no);
	public VenueVO findByPrimaryKey(String v_no);
	public List<VenueVO> getAll();
	public List<VenueVO> getAll(Map<String, String[]> map);
	
}
