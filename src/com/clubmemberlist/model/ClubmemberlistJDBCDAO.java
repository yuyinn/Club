package com.clubmemberlist.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.club.model.ClubVO;


public class ClubmemberlistJDBCDAO implements ClubmemberlistDAO_interface{
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String userid = "CA105G1";
	String passwd = "123456";
	
	private static final String INSERT_STMT = 
			"INSERT INTO CLUB_MEMBERLIST (club_no,mem_no,cmem_status,cmem_class,SILENCE_TIME) VALUES (?, ?, ?, ?, ?)";
		private static final String GET_ALL_STMT = 
			"SELECT club_no,mem_no,cmem_status,cmem_class,SILENCE_TIME FROM CLUB_MEMBERLIST order by club_no";
		private static final String GET_ONE_STMT = 
			"SELECT club_no,mem_no,cmem_status,cmem_class,SILENCE_TIME FROM CLUB_MEMBERLIST where club_no = ? AND mem_no = ?";
		private static final String DELETE = 
			"DELETE FROM CLUB_MEMBERLIST where club_no = ? AND mem_no = ?";
		private static final String UPDATE = 
			"UPDATE CLUB_MEMBERLIST set cmem_status = ?,cmem_class = ?,SILENCE_TIME = ? where club_no = ? AND mem_no = ?";
	
		
	@Override
	public void insert(ClubmemberlistVO clubmemberlistVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(INSERT_STMT);
			
			pstmt.setString(1, clubmemberlistVO.getClub_no());
			pstmt.setString(2, clubmemberlistVO.getMem_no());
			pstmt.setString(3, clubmemberlistVO.getCmem_status());
			pstmt.setString(4, clubmemberlistVO.getCmem_class());
			pstmt.setTimestamp(5, clubmemberlistVO.getSilence_time());
			
			pstmt.executeUpdate();
			
			
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
		}catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
		}finally {
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
		
	}

	@Override
	public void update(ClubmemberlistVO clubmemberlistVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATE);
			
			pstmt.setString(1, clubmemberlistVO.getCmem_status());
			pstmt.setString(2, clubmemberlistVO.getCmem_class());
			pstmt.setTimestamp(3, clubmemberlistVO.getSilence_time());
			pstmt.setString(4, clubmemberlistVO.getClub_no());
			pstmt.setString(5, clubmemberlistVO.getMem_no());
			
			pstmt.executeUpdate();
			
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
		}finally {
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
		
	}

	@Override
	public void delete(String club_no, String mem_no) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(DELETE);
			
			pstmt.setString(1, club_no);
			pstmt.setString(2, mem_no);
			
			pstmt.executeUpdate();
			
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
		}finally {
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
		
	}

	@Override
	public ClubmemberlistVO findByPrimaryKey(String club_no, String mem_no) {
		ClubmemberlistVO clubmemberlistVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ONE_STMT);
			
			pstmt.setString(1, club_no);
			pstmt.setString(2, mem_no);
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				clubmemberlistVO = new ClubmemberlistVO();
				clubmemberlistVO.setClub_no(rs.getString("club_no"));
				clubmemberlistVO.setMem_no(rs.getString("mem_no"));
				clubmemberlistVO.setCmem_status(rs.getString("cmem_status"));
				clubmemberlistVO.setCmem_class(rs.getString("cmem_class"));
				clubmemberlistVO.setSilence_time(rs.getTimestamp("Silence_time"));
			}
						
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
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
		return clubmemberlistVO;
	}

	@Override
	public List<ClubmemberlistVO> getAll() {
		List<ClubmemberlistVO> list = new ArrayList<ClubmemberlistVO>();
		ClubmemberlistVO clubmemberlistVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				clubmemberlistVO = new ClubmemberlistVO();
				clubmemberlistVO.setClub_no(rs.getString("club_no"));
				clubmemberlistVO.setMem_no(rs.getString("mem_no"));
				clubmemberlistVO.setCmem_status(rs.getString("cmem_status"));
				clubmemberlistVO.setCmem_class(rs.getString("cmem_class"));
				clubmemberlistVO.setSilence_time(rs.getTimestamp("Silence_time"));
				
				list.add(clubmemberlistVO);
			}
		} catch (ClassNotFoundException e) {	
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
		}finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace();
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
	
	
	public static void main(String[] args) {
		ClubmemberlistJDBCDAO dao = new ClubmemberlistJDBCDAO();
		
		//新增(要先去ClubJDBCDAO按新增)
//		ClubmemberlistVO clubmemberlistVO1 = new ClubmemberlistVO();
//		clubmemberlistVO1.setClub_no("C0008");
//		clubmemberlistVO1.setMem_no("M017");
//		clubmemberlistVO1.setCmem_status("正常");
//		clubmemberlistVO1.setCmem_class("管理員");
//		clubmemberlistVO1.setSilence_time(java.sql.Timestamp.valueOf("2018-12-11 12:30:00"));
//		dao.insert(clubmemberlistVO1);
//		
		//修改
//		ClubmemberlistVO clubmemberlistVO2 = new ClubmemberlistVO();
//		clubmemberlistVO2.setClub_no("C0008");
//		clubmemberlistVO2.setMem_no("M017");
//		clubmemberlistVO2.setCmem_status("封鎖");
//		clubmemberlistVO2.setCmem_class("管理員");
//		clubmemberlistVO2.setSilence_time(java.sql.Timestamp.valueOf("2018-12-21 18:30:00"));
//		dao.update(clubmemberlistVO2);
		
		//刪除
//		dao.delete("C0008","M017");
		
		
//		//查詢
//		ClubmemberlistVO clubmemberlistVO3 = dao.findByPrimaryKey("C0001","M003");
//		System.out.println(clubmemberlistVO3.getClub_no()+ ",");
//		System.out.println(clubmemberlistVO3.getMem_no() + ",");
//		System.out.println(clubmemberlistVO3.getCmem_status() + ",");
//		System.out.println(clubmemberlistVO3.getCmem_class()+ ",");
//		System.out.println(clubmemberlistVO3.getSilence_time()+ ",");
//		System.out.println("------------------------------");

//		//查詢
//		List<ClubmemberlistVO> list = dao.getAll();
//		for (ClubmemberlistVO aClub : list) {
//			System.out.println(aClub.getClub_no()+ ",");
//			System.out.println(aClub.getMem_no()+ ",");
//			System.out.println(aClub.getCmem_status()+ ",");
//			System.out.println(aClub.getCmem_class()+ ",");
//			System.out.println(aClub.getSilence_time()+ ",");
//			System.out.println();
//		}
	}

}
