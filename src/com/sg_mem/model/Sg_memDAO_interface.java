package com.sg_mem.model;

import java.util.List;

public interface Sg_memDAO_interface {
	public void insert(Sg_memVO sg_memVO);
	public void update(Sg_memVO sg_memVO);
	public void delete(String sg_no, String mem_no);
	public Sg_memVO findByPk(String sg_no, String mem_no);
	public List<Sg_memVO> getAll();

}
