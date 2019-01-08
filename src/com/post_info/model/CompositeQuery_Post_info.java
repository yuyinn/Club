package com.post_info.model;

import java.util.Map;
import java.util.Set;

public class CompositeQuery_Post_info {
	public static String get_aCondition_For_Oracle(String columnName, String value) {

		String aCondition = null;

		if ("post_no".equals(columnName) || "club_no".equals(columnName)|| "mem_no".equals(columnName)
		|| "post_topic".equals(columnName)|| "club_content".equals(columnName)) 
			aCondition = "post_info."+columnName + " like '%" + value + "%'";
		else if ("post_date".equals(columnName))                        
			aCondition = "to_char(" + columnName + ",'yyyy-mm-dd')='" + value + "'";
		else if("keyword".equals(columnName)) //關鍵字查詢
			aCondition = "post_info.post_info_name" + " like '%" + value + "%'";

			
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

