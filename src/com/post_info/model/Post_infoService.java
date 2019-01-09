package com.post_info.model;

import java.sql.Timestamp;
import java.util.List;
import java.util.Map;


public class Post_infoService {
	
	private Post_infoDAO_interface dao;
	
	public Post_infoService() {
		dao = new Post_infoDAO();
	}
	
	//新增貼文
	public Post_infoVO addPost_info(String club_no,String mem_no,String post_topic,
			String post_content,Timestamp post_date) {
		Post_infoVO post_infoVO = new Post_infoVO();
		
		post_infoVO.setClub_no(club_no);
		post_infoVO.setMem_no(mem_no);
		post_infoVO.setPost_topic(post_topic);
		post_infoVO.setPost_content(post_content);
		post_infoVO.setPost_date(post_date);
		dao.insert(post_infoVO);
		
		return post_infoVO;
	}
	
	//修改貼文(貼文編號、社團編號、會員編號、發布時間不能修改)
	public Post_infoVO updatePost_info(String post_topic,String post_content) {
		Post_infoVO post_infoVO = new Post_infoVO();
		
		post_infoVO.setPost_topic(post_topic);
		post_infoVO.setPost_content(post_content);
		dao.update(post_infoVO);
		
		return post_infoVO;
		
	}
	
	public Post_infoVO getOnePost_info(String post_no) {
		return dao.findByPrimaryKey(post_no);
	}
	
	public List<Post_infoVO> getAll(){
		return dao.getAll();
	}
	
	public List<Post_infoVO> getAll(Map<String, String[]> map) {
		return dao.getAll(map);
	}

	
}
