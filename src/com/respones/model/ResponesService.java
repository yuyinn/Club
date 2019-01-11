package com.respones.model;

import java.sql.Timestamp;
import java.util.List;

public class ResponesService {
	private ResponesDAO_interface dao;
	
	public ResponesService() {
		dao = new ResponesDAO(); 
	}
	
	public ResponesVO addRespones(String post_no,String mem_no,String res_content,Timestamp res_date) {
		
		ResponesVO responesVO = new ResponesVO();
		
		responesVO.setPost_no(post_no);
		responesVO.setMem_no(mem_no);
		responesVO.setRes_content(res_content);
		responesVO.setRes_date(res_date);
		dao.insert(responesVO);
		
		return responesVO;
		
	}
	
	//回覆文章
	public ResponesVO updateRespones(String res_content,Timestamp res_date) {
		
		ResponesVO responesVO = new ResponesVO();
		responesVO.setRes_content(res_content);
		responesVO.setRes_date(res_date);
		dao.update(responesVO);
		
		return responesVO;
		
	}
	
	public ResponesVO getOneRespones(String res_no) {
		return dao.findByPrimaryKey(res_no);
	}
	
	public List<ResponesVO> getAll(){
		return dao.getAll();
	}
	
}
