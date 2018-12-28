package com.post_like.model;

import java.util.List;

public interface Post_likeDAO_interface {
	public void insert(Post_likeVO post_likeVO);
    public void update(Post_likeVO post_like);
    public void delete(String post_no,String mem_no);
    public Post_likeVO findByPrimaryKey(String post_no,String mem_no);
    public List<Post_likeVO> getAll();
}
