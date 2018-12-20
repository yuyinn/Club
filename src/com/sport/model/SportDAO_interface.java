package com.sport.model;

import java.util.List;

public interface SportDAO_interface {
	public void insert(SportVO sportVO);
	public void update(SportVO sportVO);
	public void delete(String sp_no);
	public SportVO findByPk(String sp_no);
	public List<SportVO> getAll();
}
