package com.venuetype.model;

import java.util.List;

public class VenueTypeService {
	
	private VenueTypeDAO_interface venueTypeDAO = null;
	
	public VenueTypeService() {
		this.venueTypeDAO = new VenueTypeDAO();
	}
	
	public List<VenueTypeVO> getAll(){
		return venueTypeDAO.getAll();
	}
	
	public boolean isVenueType(String functionList, String vt_name) {
		return venueTypeDAO.isVenueType(functionList, vt_name);
	}

}
