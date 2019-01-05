package com.sg_mem.model;

import java.util.ArrayList;
import java.util.List;

public class TestSg_memDAO {
	public static void main(String[] args) {
		Sg_memJDBCDAO dao = new Sg_memJDBCDAO();
		
		//INSERT測試
		Sg_memVO vo = new Sg_memVO();
		vo.setSg_no("S012");
		vo.setMem_no("M012");
		
		dao.insert(vo);
		
		
		
		//UPDATE測試
		Sg_memVO vo2 = new Sg_memVO();
		vo2.setCh_status("已報到");
		vo2.setSg_no("S012");
		vo2.setMem_no("M012");
		
		dao.update(vo2);
		
		
		//DELETE測試
		dao.delete("S012", "M012");
		
		
		
		//GETALL測試
		List<Sg_memVO> list = new ArrayList<Sg_memVO>();
		
		list = dao.getAll();
		for(Sg_memVO vo4: list) {
			System.out.println(vo4.getSg_no());
			System.out.println(vo4.getMem_no());
			System.out.println(vo4.getCh_status());
			System.out.println("------------------------");
		}
		
		
		//FINDBYPK測試
		Sg_memVO vo5 = new Sg_memVO();
		vo = dao.findByPk("S002", "M002");
		System.out.println(vo5.getSg_no());
		System.out.println(vo5.getMem_no());
		System.out.println(vo5.getCh_status());
		System.out.println("------------------------");
		
	}
}
