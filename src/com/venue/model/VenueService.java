package com.venue.model;

import java.util.List;
import java.util.Map;

public class VenueService {
	
	private VenueDAO_interface venueDAO;
	
	public VenueService() {
		venueDAO = new VenueDAO();
	}
	
	public List<VenueVO> getAll(Map<String, String[]> map){
		return venueDAO.getAll(map);
	}
	
	public List<VenueVO> getAll(){
		return venueDAO.getAll();
	}
	
	public VenueVO getOneVenue(String v_no) {
		return venueDAO.findByPrimaryKey(v_no);
	}
	
	public void deleteVenue(String v_no) {
		venueDAO.delete(v_no);
	}
	
	public void addVenue(VenueVO venueVO) {
		venueDAO.insert(venueVO);
	}
	
	public void addVenue(String v_name, String v_patktype, String v_introduction,
		 String vt_no, String v_weburl, String v_inout,
		 Integer reg_no, String v_address, String v_phoneno,
		 Double v_lat, Double v_long,
		 String v_fitall, String v_fitinter,
		 String open_state, String open_time,
		 String openday_mon, String openday_tue, String openday_wed, String openday_thu,
		 String openday_fri, String openday_sat, String openday_sun,
		 byte[] v_photo1, String v_photo1_ext,
		 byte[] v_photo2, String v_photo2_ext, String v_photo1_url, String v_photo2_url) {

		VenueVO venueVO = new VenueVO();
		
		venueVO.setV_name(v_name);
		venueVO.setV_weburl(v_weburl);
		venueVO.setV_parktype(v_patktype);
		venueVO.setV_introduction(v_introduction);
		venueVO.setVt_no(vt_no);
		venueVO.setV_inout(v_inout);
		venueVO.setReg_no(reg_no);
		venueVO.setV_address(v_address);
		venueVO.setV_phoneno(v_phoneno);
		venueVO.setV_lat(v_lat);
		venueVO.setV_long(v_long);
//		venueVO.setV_public_transport(v_public_transport);
		venueVO.setV_fitall(v_fitall);
		venueVO.setV_fitinter(v_fitinter);
		venueVO.setOpen_state(open_state);
		venueVO.setOpen_time(open_time);
		venueVO.setOpenday_mon(openday_mon);
		venueVO.setOpenday_tue(openday_tue);
		venueVO.setOpenday_wed(openday_wed);
		venueVO.setOpenday_thu(openday_thu);
		venueVO.setOpenday_fri(openday_fri);
		venueVO.setOpenday_sat(openday_sat);
		venueVO.setOpenday_sun(openday_sun);
		venueVO.setV_photo1(v_photo1);
		venueVO.setV_photo1_ext(v_photo1_ext);
		venueVO.setV_photo2(v_photo2);
		venueVO.setV_photo2_ext(v_photo2_ext);
		venueVO.setV_photo1_url(v_photo1_url);
		venueVO.setV_photo2_url(v_photo2_url);
		venueDAO.insert(venueVO);
		
	}
	
	public void updateVenue(
		 String v_no, String v_name, String v_patktype, String v_introduction, 
		 String vt_no, String v_weburl, String v_inout,
		 Integer reg_no, String v_address, String v_phoneno,
		 Double v_lat, Double v_long, 
		 String v_fitall, String v_fitinter,
		 String open_state, String open_time,
		 String openday_mon, String openday_tue, String openday_wed, String openday_thu,
		 String openday_fri, String openday_sat, String openday_sun,
		 byte[] v_photo1, String v_photo1_ext,
		 byte[] v_photo2, String v_photo2_ext,
		 String v_photo1_url, String v_photo2_url) {
		
		VenueVO venueVO = new VenueVO();
		
		venueVO.setV_no(v_no);
		venueVO.setV_name(v_name);
		venueVO.setV_weburl(v_weburl);
		venueVO.setV_parktype(v_patktype);
		venueVO.setV_introduction(v_introduction);
		venueVO.setVt_no(vt_no);
		venueVO.setV_inout(v_inout);
		venueVO.setReg_no(reg_no);
		venueVO.setV_address(v_address);
		venueVO.setV_phoneno(v_phoneno);
		venueVO.setV_lat(v_lat);
		venueVO.setV_long(v_long);
//		venueVO.setV_public_transport(v_public_transport);
		venueVO.setV_fitall(v_fitall);
		venueVO.setV_fitinter(v_fitinter);
		venueVO.setOpen_state(open_state);
		venueVO.setOpen_time(open_time);
		venueVO.setOpenday_mon(openday_mon);
		venueVO.setOpenday_tue(openday_tue);
		venueVO.setOpenday_wed(openday_wed);
		venueVO.setOpenday_thu(openday_thu);
		venueVO.setOpenday_fri(openday_fri);
		venueVO.setOpenday_sat(openday_sat);
		venueVO.setOpenday_sun(openday_sun);
		venueVO.setV_photo1(v_photo1);
		venueVO.setV_photo1_ext(v_photo1_ext);
		venueVO.setV_photo2(v_photo2);
		venueVO.setV_photo2_ext(v_photo2_ext);
		venueVO.setV_photo1_url(v_photo1_url);
		venueVO.setV_photo2_url(v_photo2_url);
		venueDAO.update(venueVO);		
	}
	
}