package com.club.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ClubJDBCDAO implements ClubDAO_interface{
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String userid = "CA105G1";
	String passwd = "123456";
	
	private static final String INSERT_STMT = 
			"INSERT INTO club (club_no,sp_no,photo,photo_ext,club_status,club_name,club_intro) VALUES (('C'||LPAD(to_char(club_seq.NEXTVAL), 4, '0')), ?, ?, ?, ?, ?, ?)";
		private static final String GET_ALL_STMT = 
			"SELECT club_no,sp_no,photo,photo_ext,club_status,club_name,club_intro FROM club order by club_no";
		private static final String GET_ONE_STMT = 
			"SELECT club_no,sp_no,photo,photo_ext,club_status,club_name,club_intro FROM club where club_no = ?";
		private static final String UPDATE = 
			"UPDATE club set sp_no=?, photo=?, photo_ext=?, club_status=?, club_name=?, club_intro=? where club_no = ?";

	@Override
	public void insert(ClubVO clubVO)  {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			
			pstmt = con.prepareStatement(INSERT_STMT);
			
			pstmt.setString(1, clubVO.getSp_no());
			pstmt.setBytes (2, clubVO.getPhoto());
			pstmt.setString(3, clubVO.getPhoto_ext());
			pstmt.setString(4, clubVO.getClub_status());
			pstmt.setString(5, clubVO.getClub_name());
			pstmt.setString(6, clubVO.getClub_intro());
			
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
	public void update(ClubVO clubVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATE);
			

			pstmt.setString(1, clubVO.getSp_no());
			pstmt.setBytes (2, clubVO.getPhoto());
			pstmt.setString(3, clubVO.getPhoto_ext());
			pstmt.setString(4, clubVO.getClub_status());
			pstmt.setString(5, clubVO.getClub_name());
			pstmt.setString(6, clubVO.getClub_intro());
			pstmt.setString(7, clubVO.getClub_no());
			
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
	public ClubVO findByPrimaryKey(String club_no) {
		
		ClubVO clubVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
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
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
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
		return list;
	}
	
	public static void main(String[] args) {
		
		ClubJDBCDAO dao = new ClubJDBCDAO();
		
		//新增
//		ClubVO clubVO1 = new ClubVO();
//		clubVO1.setSp_no("SP007");
//		clubVO1.setPhoto(null);//圖片GG
//		clubVO1.setPhoto_ext(null);//圖片GG
//		clubVO1.setClub_status("正常");
//		clubVO1.setClub_name("山頂蜘蛛男");
//		clubVO1.setClub_intro("一騎入魂!");
//		dao.insert(clubVO1);
		
		//修改
//		ClubVO clubVO2 = new ClubVO();
//		clubVO2.setClub_no("C0001");
//		clubVO2.setSp_no("SP002");
//		clubVO2.setPhoto(null);
//		clubVO2.setPhoto_ext(null);
//		clubVO2.setClub_status("正常");
//		clubVO2.setClub_name("跑起來");
//		clubVO2.setClub_intro("跑起來阿肥豬們");
//		dao.update(clubVO2);
		
//		//查詢
//		ClubVO clubVO3 = dao.findByPrimaryKey("C0001");
//		System.out.println(clubVO3.getClub_no()+ ",");
//		System.out.println(clubVO3.getSp_no()+ ",");
//		System.out.println(clubVO3.getPhoto()+ ",");
//		System.out.println(clubVO3.getPhoto_ext()+ ",");
//		System.out.println(clubVO3.getClub_status()+ ",");
//		System.out.println(clubVO3.getClub_name()+ ",");
//		System.out.println(clubVO3.getClub_intro());
//		System.out.println("------------------------------");
//
//		//查詢
//		List<ClubVO> list = dao.getAll();
//		for (ClubVO aClub : list) {
//			System.out.println(aClub.getClub_no()+ ",");
//			System.out.println(aClub.getSp_no()+ ",");
//			System.out.println(aClub.getPhoto()+ ",");
//			System.out.println(aClub.getPhoto_ext()+ ",");
//			System.out.println(aClub.getClub_status()+ ",");
//			System.out.println(aClub.getClub_name()+ ",");
//			System.out.println(aClub.getClub_intro());
//			System.out.println();
//		}
	}
}
