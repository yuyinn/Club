package com.sg_msg.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class Sg_msgDAO implements Sg_msgDAO_interface{
	private static final String driver = "oracle.jdbc.driver.OracleDriver";
	private static final String url = "jdbc:oracle:thin:@localhost:1521:xe";
	private static final String user = "CA105G1";
	private static final String psw = "123456";
	
	private static final String insertStmt = 
			"INSERT INTO sg_msg VALUES('MSG' || LPAD(SG_MSG_SEQ.nextval, 3, 0),?,?,?,?)";
	private static final String updateContent =
			"UPDATE sg_msg SET msg_cont=? where msg_no=?";
	private static final String deleteStmt =
			"DELETE FROM sg_msg WHERE msg_no=?";
	private static final String findByPkStmt =
			"SELECT * FROM sg_msg WHERE msg_no=?";
	private static final String getAllStmt =
			"SELECT * FROM sg_msg ORDER BY msg_no";
	
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
	public void insert(Sg_msgVO sg_msgVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			//連線池版
//		con = ds.getConnection();
			//JDBC版
			con = DriverManager.getConnection(url, user, psw);
			pstmt = con.prepareStatement(insertStmt);
			
			pstmt.setString(1, sg_msgVO.getSg_no());
			pstmt.setString(2, sg_msgVO.getMem_no());
			pstmt.setString(3, sg_msgVO.getMsg_cont());
			pstmt.setTimestamp(4, sg_msgVO.getMsg_time());
			
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
	public void update(Sg_msgVO sg_msgVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			//連線池版
//			con = ds.getConnection();
			//JDBC版
			con = DriverManager.getConnection(url, user, psw);
			pstmt = con.prepareStatement(updateContent);
			
			pstmt.setString(1, sg_msgVO.getMsg_cont());
			pstmt.setString(2, sg_msgVO.getMsg_no());
			
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if(con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		
	}

	@Override
	public void delete(String msg_no) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			//連線池版
//			con = ds.getConnection();
			//JDBC版
			con = DriverManager.getConnection(url, user, psw);
			pstmt = con.prepareStatement(deleteStmt);
			
			pstmt.setString(1, msg_no);
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if(con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
	}

	@Override
	public Sg_msgVO findByPk(String msg_no) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Sg_msgVO vo = null;
		
		try {
			//連線池版
//			con = ds.getConnection();
			//JDBC版
			con = DriverManager.getConnection(url, user, psw);
			pstmt = con.prepareStatement(findByPkStmt);
			
			pstmt.setString(1, msg_no);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				vo = new Sg_msgVO();
				vo.setMsg_no(msg_no);
				vo.setSg_no(rs.getString("sg_no"));
				vo.setMem_no(rs.getString("mem_no"));
				vo.setMsg_cont(rs.getString("msg_cont"));
				vo.setMsg_time(rs.getTimestamp("msg_time"));
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
	public List<Sg_msgVO> getAll() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Sg_msgVO vo = null;
		List<Sg_msgVO> list = new ArrayList<Sg_msgVO>();
		
		try {
			con = DriverManager.getConnection(url, user, psw);
			pstmt = con.prepareStatement(getAllStmt);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				vo = new Sg_msgVO();
				vo.setMsg_no(rs.getString("msg_no"));
				vo.setSg_no(rs.getString("sg_no"));
				vo.setMem_no(rs.getString("mem_no"));
				vo.setMsg_cont(rs.getString("msg_cont"));
				vo.setMsg_time(rs.getTimestamp("msg_time"));
				
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
