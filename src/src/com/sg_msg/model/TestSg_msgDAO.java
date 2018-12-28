package com.sg_msg.model;

import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

public class TestSg_msgDAO {
	public static void main(String[] args) {
		Sg_msgDAO dao = new Sg_msgDAO();
		Sg_msgVO vo = new Sg_msgVO();
		List<Sg_msgVO> list = new ArrayList<Sg_msgVO>();
		
		vo.setSg_no("S008");
		vo.setMem_no("M008");
		vo.setMsg_cont("今晚打老虎");
		
		java.util.Date date = new java.util.Date(); //得到當下時間
		long time = date.getTime(); //傳換成毫秒
		Timestamp ts = new Timestamp(time); //轉換成timestamp物件
		vo.setMsg_time(ts);  
		dao.insert(vo);
		
		DateFormat df = new SimpleDateFormat("yyy-MM-dd HH:mm:ss");  //建立格式
		
		Sg_msgVO vo2 = new Sg_msgVO();
		vo2 = dao.findByPk("MSG016");
		System.out.println(vo2.getMsg_no());
		System.out.println(vo2.getSg_no());
		System.out.println(vo2.getMem_no());
		System.out.println(vo2.getMsg_cont());
		System.out.println(df.format(vo2.getMsg_time())); //將timestamp物件套用格式並轉成String
//		System.out.println("---------------------");
//		
//		Sg_msgVO vo22 = new Sg_msgVO();
//		vo22.setMsg_no("MSG016");
//		vo22.setSg_no("S002");
//		vo22.setMem_no("M002");
//		vo22.setMsg_cont("今晚打老虎22222222222222222222");
//		dao.update(vo22);
//		
//		
//		list = dao.getAll();
//		for(Sg_msgVO vo3 : list) {
//			System.out.println(vo3.getMsg_cont());
//			System.out.println("---------------------");
//		}
		
		
		
		
//		dao.delete("MSG012");
		
	}
}
