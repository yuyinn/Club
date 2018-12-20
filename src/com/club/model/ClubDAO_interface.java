package com.club.model;

import java.util.List;

public interface ClubDAO_interface {
	public void insert(ClubVO clubVO);
    public void update(ClubVO clubVO);
    public ClubVO findByPrimaryKey(String club_no);
    public List<ClubVO> getAll();
}
