package com.post_like.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class Post_likeJDBCDAO implements Post_likeDAO_interface{
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String userid = "CA105G1";
	String passwd = "123456";
	
	private static final String INSERT_STMT = 
			"INSERT INTO post_like (post_no,mem_no,like_type) VALUES (?, ?, ?)";
		private static final String GET_ALL_STMT = 
			"SELECT post_no,mem_no,like_type FROM post_like order by post_no ";
		private static final String GET_ONE_STMT = 
			"SELECT post_no,mem_no,like_type FROM post_like where post_no = ? AND mem_no = ?";
		private static final String DELETE = 
			"DELETE FROM post_like where post_no = ? AND mem_no = ?";
		private static final String UPDATE = 
			"UPDATE post_like set  like_type=? where post_no = ? AND mem_no = ?";
		
		
		
		@Override
		public void insert(Post_likeVO post_likeVO) {
			Connection con = null;
			PreparedStatement pstmt = null;
			
			try {
				Class.forName(driver);
				con = DriverManager.getConnection(url, userid, passwd);
				pstmt = con.prepareStatement(INSERT_STMT);
				
				pstmt.setString(1, post_likeVO.getPost_no());
				pstmt.setString(2, post_likeVO.getMem_no());
				pstmt.setString(3, post_likeVO.getLike_type());

				
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
		public void update(Post_likeVO post_likeVO) {
			Connection con = null;
			PreparedStatement pstmt = null;
			
			try {
				Class.forName(driver);
				con = DriverManager.getConnection(url, userid, passwd);
				pstmt = con.prepareStatement(UPDATE);
				
				pstmt.setString(1, post_likeVO.getLike_type());
				pstmt.setString(2, post_likeVO.getPost_no());
				pstmt.setString(3, post_likeVO.getMem_no());
				
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
		public void delete(String post_no,String mem_no) {
			Connection con = null;
			PreparedStatement pstmt = null;
			
			try {
				Class.forName(driver);
				con = DriverManager.getConnection(url, userid, passwd);
				pstmt = con.prepareStatement(DELETE);
				
				pstmt.setString(1, post_no);
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
		public Post_likeVO findByPrimaryKey(String post_no,String mem_no) {
			Post_likeVO post_likeVO = null;
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ONE_STMT);
			
			pstmt.setString(1, post_no);
			pstmt.setString(2, mem_no);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				post_likeVO = new Post_likeVO();
				post_likeVO.setPost_no(rs.getString("post_no"));
				post_likeVO.setMem_no(rs.getString("mem_no"));
				post_likeVO.setLike_type(rs.getString("like_type"));
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
			return post_likeVO;
		}
		@Override
		public List<Post_likeVO> getAll() {
			List<Post_likeVO> list = new ArrayList<Post_likeVO>();
			Post_likeVO post_likeVO = null;
			
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				post_likeVO = new Post_likeVO();
				post_likeVO.setPost_no(rs.getString("post_no"));
				post_likeVO.setMem_no(rs.getString("mem_no"));
				post_likeVO.setLike_type(rs.getString("like_type"));
				
				list.add(post_likeVO);
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
			Post_likeJDBCDAO dao = new Post_likeJDBCDAO(); 
			
			//新增 (要先在Post_infoJDBCDAO按新增)
//			Post_likeVO post_likeVO1 = new Post_likeVO();
//			post_likeVO1.setPost_no("P0003");
//			post_likeVO1.setMem_no("M002");
//			post_likeVO1.setLike_type("XX");
//			dao.insert(post_likeVO1);
			
			//修改
//			Post_likeVO post_likeVO2 = new Post_likeVO();
//			post_likeVO2.setPost_no("P0002");
//			post_likeVO2.setMem_no("M005");
//			post_likeVO2.setLike_type("");
//			dao.update(post_likeVO2);
//
//			//刪除
//			dao.delete("P0002","M005");
//			
//			//查詢
//			Post_likeVO post_likeVO3 = dao.findByPrimaryKey("P0001","M001");
//			System.out.println(post_likeVO3.getPost_no()+ ",");
//			System.out.println(post_likeVO3.getMem_no()+ ",");
//			System.out.println(post_likeVO3.getLike_type()+ ",");
//			System.out.println("------------------------------");
//			
//			//查詢
//			List<Post_likeVO> list = dao.getAll();
//			for (Post_likeVO aPost_like : list) {
//				System.out.println(aPost_like.getPost_no()+ ",");
//				System.out.println(aPost_like.getMem_no()+ ",");
//				System.out.println(aPost_like.getLike_type()+ ",");
//				System.out.println();
//			}
		}
	
}
