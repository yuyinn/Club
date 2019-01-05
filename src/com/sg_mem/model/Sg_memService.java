package com.sg_mem.model;

import java.util.List;

public class Sg_memService {
	private Sg_memDAO_interface dao = null;
	
	public Sg_memService() {
		dao = new Sg_memDAO();
	}
	
	public Sg_memVO insertSg_mem(String sg_no, String mem_no) {
		Sg_memVO vo = new Sg_memVO();
		
		vo.setSg_no(sg_no);
		vo.setMem_no(mem_no);
		
		dao.insert(vo);
		return vo;
	}
	
	public Sg_memVO updateSg_mem(String sg_no, String mem_no, String ch_status) {
		Sg_memVO vo = new Sg_memVO();
		
		vo.setSg_no(sg_no);
		vo.setMem_no(mem_no);
		vo.setCh_status(ch_status);
		
		dao.insert(vo);
		return vo;
	}
	
	public void deleteSg_mem(String sg_no, String mem_no) {
		dao.delete(sg_no, mem_no);
	}
	
	public Sg_memVO getByPk(String sg_no, String mem_no) {
		return dao.findByPk(sg_no, mem_no);
	}
	
	public List<Sg_memVO> getAll() {
		return dao.getAll();
	}
	
}
