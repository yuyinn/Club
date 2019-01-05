package com.venue.model;

import java.util.List;
import java.util.Map;

public class Util_Check_Venue_Parameter {
	
	public static Map<String, String[]> checkVenueMap(Map<String, String[]> map, List<String> errorMsgs) {
		map = checkVenueV_no(map, errorMsgs);
		return map;
	}
	public static Map<String, String[]> checkVenueV_no(Map<String, String[]> map, List<String> errorMsgs) {
		String key_v_no = "v_no";
		if(map.containsKey(key_v_no)) {
			String v_no = map.get(key_v_no)[0];
			String v_noReg = "^[V][0-9]{6}$";
			if(v_no == null || v_no.trim().length()==0) {
				//map.remove(key_v_no);
			}else if(!v_no.trim().matches(v_noReg)) {
				errorMsgs.add("查無此編號---場地編號，格式不符，如:V000001");
				map.remove(key_v_no);
			}
		}
		return map;
	}
}
