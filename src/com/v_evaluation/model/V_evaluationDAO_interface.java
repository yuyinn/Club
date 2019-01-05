package com.v_evaluation.model;

import java.util.*;

public interface V_evaluationDAO_interface {
	
	public void insert(V_evaluationVO veVO);
	public void update(V_evaluationVO veVO);
	public void delete(String mem_no, String v_no);
    public V_evaluationVO findByPrimaryKey(String mem_no, String v_no);
	public List<V_evaluationVO> getAll();
//	萬用複合查詢(傳入參數型態Map)(回傳 List)
//  public List<VTVO> getAll(Map<String, String[]> map); 

}
