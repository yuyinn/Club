package com.post_info.model;

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


public class Post_infoDAO  implements Post_infoDAO_interface{
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
			"INSERT INTO post_info (post_no,club_no,mem_no,post_topic,post_content,post_date) VALUES (('P'||LPAD(to_char(post_info_seq.NEXTVAL), 4, '0')), ?, ?, ?, ?, ?)";
		private static final String GET_ALL_STMT = 
			"SELECT post_no,club_no,mem_no,post_topic,post_content,post_date FROM post_info order by post_no";
		private static final String GET_ONE_STMT = 
			"SELECT post_no,club_no,mem_no,post_topic,post_content,post_date FROM post_info where post_no = ?";
		private static final String UPDATE = 
			"UPDATE post_info set post_no=?, club_no=?, mem_no=?, post_topic=?, post_content=?, post_date=? where post_no = ?";
		private static final String DELETE = 
			"DELETE FROM post_info where post_no = ?";
		
		@Override
		public void insert(Post_infoVO post_infoVO) {
			Connection con = null;
			PreparedStatement pstmt = null;
			
			try {
				con = ds.getConnection();
				pstmt = con.prepareStatement(INSERT_STMT);
				
				
				pstmt.setString (1, post_infoVO.getClub_no());
				pstmt.setString(2, post_infoVO.getMem_no());
				pstmt.setString(3, post_infoVO.getPost_topic());
				pstmt.setString(4, post_infoVO.getPost_content());
				pstmt.setTimestamp(5, post_infoVO.getPost_date());
				
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
		public void update(Post_infoVO post_infoVO) {
			Connection con = null;
			PreparedStatement pstmt = null;
			
			try {
				con = ds.getConnection();
				pstmt = con.prepareStatement(UPDATE);
				
				pstmt.setString(1, post_infoVO.getPost_no());
				pstmt.setString (2, post_infoVO.getClub_no());
				pstmt.setString(3, post_infoVO.getMem_no());
				pstmt.setString(4, post_infoVO.getPost_topic());
				pstmt.setString(5, post_infoVO.getPost_content());
				pstmt.setTimestamp(6, post_infoVO.getPost_date());
				
				
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
		public Post_infoVO findByPrimaryKey(String post_no) {

			Post_infoVO post_infoVO = null;
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try {
				con = ds.getConnection();
				pstmt = con.prepareStatement(GET_ONE_STMT);
				pstmt.setString(1, post_no);
				
				rs = pstmt.executeQuery();
				
				while (rs.next()) {
					post_infoVO = new Post_infoVO();
					post_infoVO.setPost_no(rs.getString("post_no"));
					post_infoVO.setClub_no(rs.getString("club_no"));
					post_infoVO.setMem_no(rs.getString("mem_no"));
					post_infoVO.setPost_topic(rs.getString("post_topic"));
					post_infoVO.setPost_content(rs.getString("post_content"));
					post_infoVO.setPost_date(rs.getTimestamp("post_date"));
					
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
			return post_infoVO;
		}
		
		
		@Override
		public List<Post_infoVO> getAll() {
			List<Post_infoVO> list = new ArrayList<Post_infoVO>();
			Post_infoVO post_infoVO = null;
			
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try {
				con = ds.getConnection();
				pstmt = con.prepareStatement(GET_ALL_STMT);
				rs = pstmt.executeQuery();
				while(rs.next()) {
					post_infoVO = new Post_infoVO();
					post_infoVO.setPost_no(rs.getString("post_no"));
					post_infoVO.setClub_no(rs.getString("club_no"));
					post_infoVO.setMem_no(rs.getString("mem_no"));
					post_infoVO.setPost_topic(rs.getString("post_topic"));
					post_infoVO.setPost_content(rs.getString("post_content"));
					post_infoVO.setPost_date(rs.getTimestamp("post_date"));
					
					list.add(post_infoVO);
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
		public void delete(String post_no) {
			Connection con = null;
			PreparedStatement pstmt = null;

			try {

				con = ds.getConnection();
				pstmt = con.prepareStatement(DELETE);

				pstmt.setString(1, post_no);

				pstmt.executeUpdate();

				// Handle any driver errors
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
		public List<Post_infoVO> getAll(Map<String, String[]> map) {
			List<Post_infoVO> list = new ArrayList<Post_infoVO>();
			Post_infoVO post_infoVO = null;
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
		
			try {
				
				con = ds.getConnection();
				String finalSQL = "select * from post_info "
			          + CompositeQuery_Post_info.get_WhereCondition(map)
			          + "order by post_no";
				pstmt = con.prepareStatement(finalSQL);
				System.out.println("●●finalSQL(by DAO) = "+finalSQL);
				rs = pstmt.executeQuery();
		
				while(rs.next()) {
					post_infoVO = new Post_infoVO();
					post_infoVO.setPost_no(rs.getString("post_no"));
					post_infoVO.setClub_no(rs.getString("club_no"));
					post_infoVO.setMem_no(rs.getString("mem_no"));
					post_infoVO.setPost_topic(rs.getString("post_topic"));
					post_infoVO.setPost_content(rs.getString("post_content"));
					post_infoVO.setPost_date(rs.getTimestamp("post_date"));
					
					list.add(post_infoVO);
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
			return list;
		}


}
		
		
	

