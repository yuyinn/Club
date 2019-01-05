package com.sg_mem.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class Sg_memJDBCDAO implements Sg_memDAO_interface{
	private static final String driver = "oracle.jdbc.driver.OracleDriver";
	private static final String url = "jdbc:oracle:thin:@localhost:1521:xe";
	private static final String user = "CA105G1";
	private static final String psw = "123456";
	
	private static final String insertStmt = 
			"INSERT INTO sg_mem VALUES(?,?,default)";
	private static final String updateStatus =
			"UPDATE sg_mem SET ch_status=? where sg_no=? and mem_no=?";
	private static final String deleteStmt =
			"DELETE FROM sg_mem WHERE sg_no=? and mem_no=?";
	private static final String findByPkStmt =
			"SELECT * FROM sg_mem WHERE sg_no=? and mem_no=?";
	private static final String getAllStmt =
			"SELECT * FROM sg_mem ORDER BY sg_no";
	
	//連線池版
//	private static DataSource ds = null;
//	
//	static {
//		try {
//			Context ctx = new javax.naming.InitialContext();
//			ds = (DataSource)ctx.lookup("java:comp/env/jdbc/TestDB");
//		} catch (NamingException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//	}
	
	//JDBC版
	static {
		try {
			Class.forName(driver);
		}catch(ClassNotFoundException ce) {
			ce.printStackTrace();
		}
	}

	@Override
	public void insert(Sg_memVO sg_memVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			//連線池版
//		con = ds.getConnection();
			//JDBC版
			con = DriverManager.getConnection(url, user, psw);
			pstmt = con.prepareStatement(insertStmt);
			
			pstmt.setString(1, sg_memVO.getSg_no());
			pstmt.setString(2, sg_memVO.getMem_no());
			
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if(con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
	}

	@Override
	public void update(Sg_memVO sg_memVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			//連線池版
//		con = ds.getConnection();
			//JDBC版
			con = DriverManager.getConnection(url, user, psw);
			pstmt = con.prepareStatement(updateStatus);
			
			pstmt.setString(1, sg_memVO.getCh_status());
			pstmt.setString(2, sg_memVO.getSg_no());
			pstmt.setString(3, sg_memVO.getMem_no());
			
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if(con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		
	}

	@Override
	public void delete(String sg_no, String mem_no) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			//連線池版
//		con = ds.getConnection();
			//JDBC版
			con = DriverManager.getConnection(url, user, psw);
			pstmt = con.prepareStatement(deleteStmt);
			
			pstmt.setString(1, sg_no);
			pstmt.setString(2, mem_no);
			
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if(con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		
	}

	@Override
	public Sg_memVO findByPk(String sg_no, String mem_no) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Sg_memVO vo = null;
		
		try {
			//連線池版
//		con = ds.getConnection();
			//JDBC版
			con = DriverManager.getConnection(url, user, psw);
			pstmt = con.prepareStatement(findByPkStmt);
			
			pstmt.setString(1, sg_no);
			pstmt.setString(2, mem_no);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				vo = new Sg_memVO();
				vo.setSg_no(rs.getString("sg_no"));
				vo.setMem_no(rs.getString("mem_no"));
				vo.setCh_status(rs.getString("ch_status"));
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			if(rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if(con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return vo;
	}

	@Override
	public List<Sg_memVO> getAll() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Sg_memVO vo = null;
		List<Sg_memVO> list = new ArrayList<Sg_memVO>();;
		
		try {
			//連線池版
//		con = ds.getConnection();
			//JDBC版
			con = DriverManager.getConnection(url, user, psw);
			pstmt = con.prepareStatement(getAllStmt);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				vo = new Sg_memVO();
				vo.setSg_no(rs.getString("sg_no"));
				vo.setMem_no(rs.getString("mem_no"));
				vo.setCh_status(rs.getString("ch_status"));
				
				list.add(vo);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			if(rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if(con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return list;
	}

}
