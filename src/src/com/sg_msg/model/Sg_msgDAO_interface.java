package com.sg_msg.model;

import java.util.List;


public interface Sg_msgDAO_interface {

	public void insert(Sg_msgVO sg_msgVO);
	public void update(Sg_msgVO sg_msgVO);
	public void delete(String msg_no);
	public Sg_msgVO findByPk(String msg_no);
	public List<Sg_msgVO> getAll();
}
