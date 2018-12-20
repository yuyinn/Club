package com.respones.model;

import java.util.List;


public interface ResponesDAO_interface {
	public void insert(ResponesVO responesVO);
    public void update(ResponesVO responesVO);
    public void delete(String res_no);
    public ResponesVO findByPrimaryKey(String res_no);
    public List<ResponesVO> getAll();
}
