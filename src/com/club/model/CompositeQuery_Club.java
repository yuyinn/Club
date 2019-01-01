package com.club.model;

import java.util.Map;
import java.util.Set;

public class CompositeQuery_Club {
	public static String get_aCondition_For_Oracle(String columnName, String value) {

		String aCondition = null;

		if ("club_no".equals(columnName) || "sp_no".equals(columnName)) // 用於sg_info有的欄位
			aCondition = "club."+columnName + " like '%" + value + "%'";
//		else if("reg_no".equals(columnName))  // 用於venue有的欄位
//			aCondition = "venue."+columnName + " like '%" + value + "%'";
		else if("keyword".equals(columnName)) //關鍵字查詢
			aCondition = "club.club_name" + " like '%" + value + "%'";
//		else if("keyword".equals(columnName)) //關鍵字查詢
//			aCondition = "club.intro" + " like '%" + value + "%'";
			
		return aCondition + " ";
	}

	public static String get_WhereCondition(Map<String, String[]> map) {
		Set<String> keys = map.keySet();
		StringBuffer whereCondition = new StringBuffer();
		int count = 0;
		for (String key : keys) {
			String value = map.get(key)[0];
			if (value != null && value.trim().length() != 0	&& !"action".equals(key)) {
				count++;
				String aCondition = get_aCondition_For_Oracle(key, value.trim());

				if (count == 1)
					whereCondition.append(" where " + aCondition);
				else
					whereCondition.append(" and " + aCondition);

				System.out.println("有送出查詢資料的欄位數count = " + count);
			}
		}
		
		return whereCondition.toString();
	}

}

