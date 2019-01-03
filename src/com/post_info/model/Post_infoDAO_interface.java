package com.post_info.model;

import java.util.List;
import java.util.Map;

public interface Post_infoDAO_interface {
	public void insert(Post_infoVO post_infoVO);
    public void update(Post_infoVO post_infoVO);
    public void delete(String post_no);
    public Post_infoVO findByPrimaryKey(String post_no);
    public List<Post_infoVO> getAll();
    
    
	public List<Post_infoVO> getAll(Map<String, String[]> map);
}
