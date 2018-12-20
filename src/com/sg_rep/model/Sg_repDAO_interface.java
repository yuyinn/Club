package com.sg_rep.model;

import java.util.List;

public interface Sg_repDAO_interface {
	public void insert(Sg_repVO sg_repVO);
	public void update(Sg_repVO sg_repVO);
	public void delete(String rep_no);
	public Sg_repVO findByPk(String rep_no);
	public List<Sg_repVO> getAll();
}
