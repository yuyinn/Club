package com.club_memberlist.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;



public class Club_memberlistDAO  implements Club_memberlistDAO_interface{
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
			"INSERT INTO club_memberlist (club_no,mem_no,cmem_status,cmem_class,silence_time) VALUES (?, ?, ?, ?, ?)";
		private static final String GET_ALL_STMT = 
			"SELECT club_no,mem_no,cmem_status,cmem_class,silence_time FROM club_memberlist order by club_no, mem_no";
		private static final String GET_ONE_STMT = 
			"SELECT club_no,mem_no,cmem_status,cmem_class,silence_time FROM club_memberlist where club_no=? and mem_no=?";
		private static final String UPDATE = 
			"UPDATE club_memberlist set cmem_status=?, cmem_class=?, silence_time=?  where club_no=? and mem_no=?";
		
		
		@Override
		public void insert(Club_memberlistVO clubmemberlistVO) {
			Connection con = null;
			PreparedStatement pstmt = null;
			
			try {
				con = ds.getConnection();
				pstmt = con.prepareStatement(INSERT_STMT);
				
				pstmt.setString(1, clubmemberlistVO.getClub_no());
				pstmt.setString (2, clubmemberlistVO.getMem_no());
				pstmt.setString(3, clubmemberlistVO.getCmem_status());
				pstmt.setString(4, clubmemberlistVO.getCmem_class());
				pstmt.setTimestamp(5, clubmemberlistVO.getSilence_time());
				
				
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
		public void update(Club_memberlistVO clubmemberlistVO) {
			Connection con = null;
			PreparedStatement pstmt = null;
//			"UPDATE club_memberlist set cmem_status=?, cmem_class=?, silence_time=?  where club_no=? and mem_no=?";
			try {
				con = ds.getConnection();
				pstmt = con.prepareStatement(UPDATE);
				
				pstmt.setString(1, clubmemberlistVO.getCmem_status());
				pstmt.setString(2, clubmemberlistVO.getCmem_class());
				pstmt.setTimestamp(3, clubmemberlistVO.getSilence_time());
				pstmt.setString(4, clubmemberlistVO.getClub_no());
				pstmt.setString (5, clubmemberlistVO.getMem_no());
				
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
		public Club_memberlistVO findByPrimaryKey(String club_no,String mem_no) {

			Club_memberlistVO clubmemberlistVO = null;
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try {
				con = ds.getConnection();
				pstmt = con.prepareStatement(GET_ONE_STMT);
				pstmt.setString(1, club_no);
				pstmt.setString(2, mem_no);
				
				rs = pstmt.executeQuery();
				
				while (rs.next()) {
					clubmemberlistVO = new Club_memberlistVO();
					
					clubmemberlistVO.setClub_no(rs.getString("club_no"));
					clubmemberlistVO.setMem_no(rs.getString("mem_no"));
					clubmemberlistVO.setCmem_status(rs.getString("cmem_status"));
					clubmemberlistVO.setCmem_class(rs.getString("cmem_class"));
					clubmemberlistVO.setSilence_time(rs.getTimestamp("silence_time"));
				
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
			return clubmemberlistVO;
		}
		
		
		@Override
		public List<Club_memberlistVO> getAll() {
			List<Club_memberlistVO> list = new ArrayList<Club_memberlistVO>();
			Club_memberlistVO clubmemberlistVO = null;
			
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try {
				con = ds.getConnection();
				pstmt = con.prepareStatement(GET_ALL_STMT);
				rs = pstmt.executeQuery();
				while(rs.next()) {
					clubmemberlistVO = new Club_memberlistVO();
					clubmemberlistVO.setClub_no(rs.getString("club_no"));
					clubmemberlistVO.setMem_no(rs.getString("mem_no"));
					clubmemberlistVO.setCmem_status(rs.getString("cmem_status"));
					clubmemberlistVO.setCmem_class(rs.getString("cmem_class"));
					clubmemberlistVO.setSilence_time(rs.getTimestamp("silence_time"));
					list.add(clubmemberlistVO);
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


		@Override
		public List<Club_memberlistVO> getAll(Map<String, String[]> map) {
			List<Club_memberlistVO> list = new ArrayList<Club_memberlistVO>();
			Club_memberlistVO clubmemberlistVO = null;
		
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			

			try {
				
				con = ds.getConnection();
				String finalSQL = "select * from emp2 "
			          + CompositeQuery_Clubmemberlist.get_WhereCondition(map)
			          + "order by empno";
				pstmt = con.prepareStatement(finalSQL);
				System.out.println("●●finalSQL(by DAO) = "+finalSQL);
				rs = pstmt.executeQuery();
		
				while (rs.next()) {
					clubmemberlistVO = new Club_memberlistVO();
					clubmemberlistVO.setClub_no(rs.getString("club_no"));
					clubmemberlistVO.setMem_no(rs.getString("mem_no"));
					clubmemberlistVO.setCmem_status(rs.getString("cmem_status"));
					clubmemberlistVO.setCmem_class(rs.getString("cmem_class"));
					clubmemberlistVO.setSilence_time(rs.getTimestamp("silence_time"));
					
					list.add(clubmemberlistVO); // Store the row in the List
				}
		
				// Handle any SQL errors
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
			return list;
		}





	
		

}
		
		
	

