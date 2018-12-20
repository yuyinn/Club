package com.respones_like.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.post_like.model.Post_likeJDBCDAO;


public class Respones_likeJDBCDAO implements Respones_likeDAO_interface {
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String userid = "CA105G1";
	String passwd = "123456";
	
	private static final String INSERT_STMT = 
			"INSERT INTO respones_like (res_no,mem_no,like_type) VALUES (?, ?, ?)";
		private static final String GET_ALL_STMT = 
			"SELECT res_no,mem_no,like_type FROM respones_like order by res_no ";
		private static final String GET_ONE_STMT = 
			"SELECT res_no,mem_no,like_type FROM respones_like where res_no = ? AND mem_no = ?";
		private static final String DELETE = 
			"DELETE FROM respones_like where res_no = ? AND mem_no = ?";
		private static final String UPDATE = 
			"UPDATE respones_like set  like_type=? where res_no = ? AND mem_no = ?";
		@Override
		public void insert(Respones_likeVO respones_likeVO) {
			Connection con = null;
			PreparedStatement pstmt = null;
			
			try {
				Class.forName(driver);
				con = DriverManager.getConnection(url, userid, passwd);
				pstmt = con.prepareStatement(INSERT_STMT);
				
				pstmt.setString(1, respones_likeVO.getRes_no());
				pstmt.setString(2, respones_likeVO.getMem_no());
				pstmt.setString(3, respones_likeVO.getLike_type());

				
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
		public void update(Respones_likeVO respones_likeVO) {
			Connection con = null;
			PreparedStatement pstmt = null;
			
			try {
				Class.forName(driver);
				con = DriverManager.getConnection(url, userid, passwd);
				pstmt = con.prepareStatement(UPDATE);
				
				pstmt.setString(1, respones_likeVO.getLike_type());
				pstmt.setString(2, respones_likeVO.getRes_no());
				pstmt.setString(3, respones_likeVO.getMem_no());
				
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
		public void delete(String res_no,String mem_no) {
			Connection con = null;
			PreparedStatement pstmt = null;
			
			try {
				Class.forName(driver);
				con = DriverManager.getConnection(url, userid, passwd);
				pstmt = con.prepareStatement(DELETE);
				
				pstmt.setString(1, res_no);
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
		public Respones_likeVO findByPrimaryKey(String res_no,String mem_no) {
			Respones_likeVO Respones_likeVO = null;
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ONE_STMT);
			
			pstmt.setString(1, res_no);
			pstmt.setString(2, mem_no);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Respones_likeVO = new Respones_likeVO();
				Respones_likeVO.setRes_no(rs.getString("res_no"));
				Respones_likeVO.setMem_no(rs.getString("mem_no"));
				Respones_likeVO.setLike_type(rs.getString("like_type"));
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
			return Respones_likeVO;
		}
		@Override
		public List<Respones_likeVO> getAll() {
			List<Respones_likeVO> list = new ArrayList<Respones_likeVO>();
			Respones_likeVO Respones_likeVO = null;
			
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				Respones_likeVO = new Respones_likeVO();
				Respones_likeVO.setRes_no(rs.getString("res_no"));
				Respones_likeVO.setMem_no(rs.getString("mem_no"));
				Respones_likeVO.setLike_type(rs.getString("like_type"));
				
				list.add(Respones_likeVO);
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
		Respones_likeJDBCDAO dao = new Respones_likeJDBCDAO(); 
			
		//新增
//		Respones_likeVO Respones_likeVO1 = new Respones_likeVO();
//		Respones_likeVO1.setRes_no("R0002");
//		Respones_likeVO1.setMem_no("M002");
//		Respones_likeVO1.setLike_type("");
//		dao.insert(Respones_likeVO1);
//		
//		//修改
//		Respones_likeVO Respones_likeVO2 = new Respones_likeVO();
//		Respones_likeVO2.setRes_no("R0002");
//		Respones_likeVO2.setMem_no("M005");
//		Respones_likeVO2.setLike_type("");
//		dao.update(Respones_likeVO2);
//
//		//刪除
//		dao.delete("R0002","M005");
//		
//		//查詢
//		Respones_likeVO Respones_likeVO3 = dao.findByPrimaryKey("R0001","M003");
//		System.out.println(Respones_likeVO3.getRes_no()+ ",");
//		System.out.println(Respones_likeVO3.getMem_no()+ ",");
//		System.out.println(Respones_likeVO3.getLike_type()+ ",");
//		System.out.println("------------------------------");

//		//查詢
//		List<Respones_likeVO> list = dao.getAll();
//		for (Respones_likeVO aPost_like : list) {
//			System.out.println(aPost_like.getRes_no()+ ",");
//			System.out.println(aPost_like.getMem_no()+ ",");
//			System.out.println(aPost_like.getLike_type()+ ",");
//			System.out.println();
//		}
	}
}
