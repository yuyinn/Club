package com.respones.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.club.model.ClubVO;

public class ResponesJDBCDAO implements ResponesDAO_interface {
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String userid = "CA105G1";
	String passwd = "123456";

	private static final String INSERT_STMT = 
			"INSERT INTO respones (res_no, post_no, mem_no, res_content, res_date) VALUES (('R'||LPAD(to_char(respones_seq.NEXTVAL), 4, '0')), ?, ?, ?, ?)";
		private static final String GET_ALL_STMT = 
			"SELECT res_no, post_no, mem_no, res_content, res_date FROM respones order by res_no";
		private static final String GET_ONE_STMT = 
			"SELECT res_no, post_no, mem_no, res_content, res_date FROM respones where res_no = ?";
		private static final String DELETE = 
			"DELETE FROM respones where res_no = ?";
		private static final String UPDATE = 
			"UPDATE respones set post_no=?, mem_no=?, res_content=?, res_date=? where res_no = ?";
			
		@Override
		public void insert(ResponesVO responesVO) {
			Connection con = null;
			PreparedStatement pstmt = null;
			
			try {
				Class.forName(driver);
				con = DriverManager.getConnection(url, userid, passwd);
				pstmt = con.prepareStatement(INSERT_STMT);
				
				pstmt.setString(1, responesVO.getPost_no());
				pstmt.setString(2, responesVO.getMem_no());
				pstmt.setString(3, responesVO.getRes_content());
				pstmt.setTimestamp(4, responesVO.getRes_date());
				
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
		public void update(ResponesVO responesVO) {
			Connection con = null;
			PreparedStatement pstmt = null;
			
			try {
				Class.forName(driver);
				con = DriverManager.getConnection(url, userid, passwd);
				pstmt = con.prepareStatement(UPDATE);
				
				
				pstmt.setString(1, responesVO.getPost_no());
				pstmt.setString(2, responesVO.getMem_no());
				pstmt.setString(3, responesVO.getRes_content());
				pstmt.setTimestamp(4, responesVO.getRes_date());
				pstmt.setString(5, responesVO.getRes_no());
				
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
		public void delete(String res_no) {
			Connection con = null;
			PreparedStatement pstmt = null;
			
			try {
				Class.forName(driver);
				con = DriverManager.getConnection(url, userid, passwd);
				pstmt = con.prepareStatement(DELETE);
				
				pstmt.setString(1, res_no);
				
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
		public ResponesVO findByPrimaryKey(String res_no) {

			ResponesVO responesVO = null;
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try {
				Class.forName(driver);
				con = DriverManager.getConnection(url, userid, passwd);
				pstmt = con.prepareStatement(GET_ONE_STMT);
				
				pstmt.setString(1, res_no);
				
				rs = pstmt.executeQuery();
				
				while (rs.next()) {
					responesVO = new ResponesVO();
					responesVO.setRes_no(rs.getString("res_no"));
					responesVO.setPost_no(rs.getString("post_no"));
					responesVO.setMem_no(rs.getString("mem_no"));
					responesVO.setRes_content(rs.getString("res_content"));
					responesVO.setRes_date(rs.getTimestamp("res_date"));
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
			return responesVO;
		}
		
		@Override
		public List<ResponesVO> getAll() {
			List<ResponesVO> list = new ArrayList<ResponesVO>();
			ResponesVO responesVO = null; 
			
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try {
				Class.forName(driver);
				con = DriverManager.getConnection(url, userid, passwd);
				pstmt = con.prepareStatement(GET_ALL_STMT);
				rs = pstmt.executeQuery();
				
				while (rs.next()) {
					responesVO = new ResponesVO();
					responesVO.setRes_no(rs.getString("res_no"));
					responesVO.setPost_no(rs.getString("post_no"));
					responesVO.setMem_no(rs.getString("mem_no"));
					responesVO.setRes_content(rs.getString("res_content"));
					responesVO.setRes_date(rs.getTimestamp("res_date"));
					
					list.add(responesVO);
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
			
			ResponesJDBCDAO dao = new ResponesJDBCDAO();
			
			//新增
//			ResponesVO responesVO1 = new ResponesVO();
//			
//			responesVO1.setPost_no("P0010");
//			responesVO1.setMem_no("M002");
//			responesVO1.setRes_content("不管他吃了什麼都給我來一點");
//			responesVO1.setRes_date(java.sql.Timestamp.valueOf("2018-11-15 12:30:00"));
//			dao.insert(responesVO1);
			
			//修改
//			ResponesVO responesVO2 = new ResponesVO();
//			responesVO2.setRes_no("R0001");
//			responesVO2.setPost_no("P0001");
//			responesVO2.setMem_no("M003");//M003
//			responesVO2.setRes_content("路邊的妹子不要亂看");
//			responesVO2.setRes_date(java.sql.Timestamp.valueOf("2018-11-30 11:16:23"));
//			dao.update(responesVO2);
			
//			//刪除
//			dao.delete("R0002");
//			
//			//查詢
//			ResponesVO responesVO3 = dao.findByPrimaryKey("R0001");
//			System.out.println(responesVO3.getRes_no()+ ",");
//			System.out.println(responesVO3.getPost_no()+ ",");
//			System.out.println(responesVO3.getMem_no()+ ",");
//			System.out.println(responesVO3.getRes_content()+ ",");
//			System.out.println(responesVO3.getRes_date()+ ",");
//			System.out.println("------------------------------");
			
//			//查詢
//			List<ResponesVO> list = dao.getAll();
//			for (ResponesVO aRespones : list) {
//				System.out.println(aRespones.getRes_no()+ ",");
//				System.out.println(aRespones.getPost_no()+ ",");
//				System.out.println(aRespones.getMem_no()+ ",");
//				System.out.println(aRespones.getRes_content()+ ",");
//				System.out.println(aRespones.getRes_date()+ ",");
//				System.out.println("");
//			}
		}
		@Override
		public List<ResponesVO> getAll(Map<String, String[]> map) {
			// TODO Auto-generated method stub
			return null;
		}
}