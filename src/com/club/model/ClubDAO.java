package com.club.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class ClubDAO  implements ClubDAO_interface{
	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/CA105G1");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	
		private static final String INSERT_STMT = 
			"INSERT INTO club (club_no,sp_no,photo,photo_ext,club_status,club_name,club_intro) VALUES (('C'||LPAD(to_char(club_seq.NEXTVAL), 4, '0')), ?, ?, ?, ?, ?, ?)";
		private static final String GET_ALL_STMT = 
			"SELECT club_no,sp_no,photo,photo_ext,club_status,club_name,club_intro FROM club order by club_no";
		private static final String GET_ONE_STMT = 
			"SELECT club_no,sp_no,photo,photo_ext,club_status,club_name,club_intro FROM club where club_no = ?";
		private static final String UPDATE = 
			"UPDATE club set sp_no=?, photo=?, photo_ext=?, club_status=?, club_name=?, club_intro=? where club_no = ?";
		
		
		@Override
		public void insert(ClubVO clubVO) {
			Connection con = null;
			PreparedStatement pstmt = null;
			
			try {
				con = ds.getConnection();
				pstmt = con.prepareStatement(INSERT_STMT);
				
				pstmt.setString(1, clubVO.getSp_no());
				pstmt.setBytes (2, clubVO.getPhoto());
				pstmt.setString(3, clubVO.getPhoto_ext());
				pstmt.setString(4, clubVO.getClub_status());
				pstmt.setString(5, clubVO.getClub_name());
				pstmt.setString(6, clubVO.getClub_intro());
				
				pstmt.executeUpdate();
				
			} catch (SQLException se) {
				throw new RuntimeException("A database error occured. "
						+ se.getMessage());
				// Clean up JDBC resources
			} finally {
				if (pstmt != null) {
					try {
						pstmt.close();
					} catch (SQLException se) {
						se.printStackTrace(System.err);
					}
				}
				if (con != null) {
					try {
						con.close();
					} catch (Exception e) {
						e.printStackTrace(System.err);
					}
				}
			}
		}
		
		
		@Override
		public void update(ClubVO clubVO) {
			Connection con = null;
			PreparedStatement pstmt = null;
			
			try {
				con = ds.getConnection();
				pstmt = con.prepareStatement(UPDATE);
				
				pstmt.setString(1, clubVO.getSp_no());
				pstmt.setBytes (2, clubVO.getPhoto());
				pstmt.setString(3, clubVO.getPhoto_ext());
				pstmt.setString(4, clubVO.getClub_status());
				pstmt.setString(5, clubVO.getClub_name());
				pstmt.setString(6, clubVO.getClub_intro());
				pstmt.setString(7, clubVO.getClub_no());
				
				pstmt.executeUpdate();
			} catch (SQLException se) {
				throw new RuntimeException("A database error occured. "
						+ se.getMessage());
				// Clean up JDBC resources
			} finally {
				if (pstmt != null) {
					try {
						pstmt.close();
					} catch (SQLException se) {
						se.printStackTrace(System.err);
					}
				}
				if (con != null) {
					try {
						con.close();
					} catch (Exception e) {
						e.printStackTrace(System.err);
					}
				}
			}
		}
		
			
		
		@Override
		public ClubVO findByPrimaryKey(String club_no) {

			ClubVO clubVO = null;
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try {
				con = ds.getConnection();
				pstmt = con.prepareStatement(GET_ONE_STMT);
				pstmt.setString(1, club_no);
				
				rs = pstmt.executeQuery();
				
				while (rs.next()) {
					clubVO = new ClubVO();
					clubVO.setClub_no(rs.getString("club_no"));
					clubVO.setSp_no(rs.getString("sp_no"));
					clubVO.setPhoto(rs.getBytes("photo"));
					clubVO.setPhoto_ext(rs.getString("photo_ext"));
					clubVO.setClub_status(rs.getString("club_status"));
					clubVO.setClub_name(rs.getString("club_name"));
					clubVO.setClub_intro(rs.getString("club_intro"));
				
				}
				
			} catch (SQLException se) {
				throw new RuntimeException("A database error occured. "
						+ se.getMessage());
			} finally {
				if (rs != null) {
					try {
						rs.close();
					} catch (SQLException se) {
						se.printStackTrace(System.err);
					}
				}
				if (pstmt != null) {
					try {
						pstmt.close();
					} catch (SQLException se) {
						se.printStackTrace(System.err);
					}
				}
				if (con != null) {
					try {
						con.close();
					} catch (Exception e) {
						e.printStackTrace(System.err);
					}
				}
			}
			return clubVO;
		}
		
		
		@Override
		public List<ClubVO> getAll() {
			List<ClubVO> list = new ArrayList<ClubVO>();
			ClubVO clubVO = null;
			
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try {
				con = ds.getConnection();
				pstmt = con.prepareStatement(GET_ALL_STMT);
				rs = pstmt.executeQuery();
				while(rs.next()) {
					clubVO = new ClubVO();
					clubVO.setClub_no(rs.getString("club_no"));
					clubVO.setSp_no(rs.getString("sp_no"));
					clubVO.setPhoto(rs.getBytes("photo"));
					clubVO.setPhoto_ext(rs.getString("photo_ext"));
					clubVO.setClub_status(rs.getString("club_status"));
					clubVO.setClub_name(rs.getString("club_name"));
					clubVO.setClub_intro(rs.getString("club_intro"));
					list.add(clubVO);
				}
			
			} catch (SQLException se) {
				throw new RuntimeException("A database error occured. "
						+ se.getMessage());
			}finally {
				if (rs != null) {
					try {
						rs.close();
					} catch (SQLException se) {
						se.printStackTrace(System.err);
					}
				}
				if (pstmt != null) {
					try {
						pstmt.close();
					} catch (SQLException se) {
						se.printStackTrace(System.err);
					}
				}
				if (con != null) {
					try {
						con.close();
					} catch (SQLException se) {
						se.printStackTrace(System.err);
					}
				}
			}
			return list;
		}
}
		
		
	

