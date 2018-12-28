package com.respones_like.model;

import java.util.List;

public interface Respones_likeDAO_interface {
	public void insert(Respones_likeVO respones_likeVO);
    public void update(Respones_likeVO respones_likeVO);
    public void delete(String res_no,String mem_no);
    public Respones_likeVO findByPrimaryKey(String res_no,String mem_no);
    public List<Respones_likeVO> getAll();
}
