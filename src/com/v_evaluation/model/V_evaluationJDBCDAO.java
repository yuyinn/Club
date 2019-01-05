package com.v_evaluation.model;

import java.util.ArrayList;
import java.util.List;

import java.sql.*;

public class V_evaluationJDBCDAO implements V_evaluationDAO_interface{
	
//	private static DataSource ds = null;
//	static {
//		try {
//			Context ctx = new InitialContext();
//			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/CA105G1");
//		} catch (NamingException e) {
//			e.printStackTrace();
//		}
//	}
	
	private static final String DRIVER = "oracle.jdbc.driver.OracleDriver";
	private static final String URL = "jdbc:oracle:thin:@localhost:1521:xe";
	private static final String USER = "CA105G1";
	private static final String PASSWORD = "123456";
	
	static { //預先載入驅動程式
		try {
			Class.forName(DRIVER);
		} catch (ClassNotFoundException ce) {
			ce.printStackTrace();
		}
	}
	
	private static final String INSERT_STMT = "INSERT INTO v_evaluation (mem_no,v_no,score) VALUES (?, ?, ?)";
	private static final String GET_ALL_STMT = "SELECT * FROM v_evaluation";
	private static final String GET_ONE = "SELECT * FROM v_evaluation WHERE mem_no = ? AND v_no = ?";
	private static final String UPDATE = "UPDATE v_evaluation set score=? WHERE mem_no = ? AND　v_no = ?";
	private static final String DELETE = "DELETE FROM v_evaluation WHERE mem_no= ? AND v_no= ?";
	
	
	@Override
	public void insert(V_evaluationVO veVO) {
		
		Connection con = null;
		PreparedStatement psmt = null;

		try {

			con = DriverManager.getConnection(URL, USER, PASSWORD);
			psmt = con.prepareStatement(INSERT_STMT);
			
			psmt.setString(1, veVO.getMem_no());
			psmt.setString(2, veVO.getV_no());
			psmt.setInt(3, veVO.getScore());
			
			psmt.executeUpdate();
			
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
		} finally {
			if (psmt != null) {
				try {
					psmt.close();
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
	public void update(V_evaluationVO veVO) {
		
		Connection con = null;
		PreparedStatement psmt = null;

		try {

			con = DriverManager.getConnection(URL, USER, PASSWORD);
			psmt = con.prepareStatement(UPDATE);
			
			psmt.setInt(1, veVO.getScore());
			psmt.setString(2, veVO.getMem_no());
			psmt.setString(3, veVO.getV_no());
			
			psmt.executeUpdate();
			
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
		} finally {
			if (psmt != null) {
				try {
					psmt.close();
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
	public void delete(String mem_no ,String v_no) {
		
		Connection con = null;
		PreparedStatement psmt = null;

		try {

			con = DriverManager.getConnection(URL, USER, PASSWORD);
			psmt = con.prepareStatement(DELETE);
			
			psmt.setString(1, mem_no);
			psmt.setString(2, v_no);
			
			psmt.executeUpdate();
			
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
		} finally {
			if (psmt != null) {
				try {
					psmt.close();
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
	public V_evaluationVO findByPrimaryKey(String mem_no, String v_no) {
		
		V_evaluationVO veVO = null;
		Connection con = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		try {

			con = DriverManager.getConnection(URL, USER, PASSWORD);
			psmt = con.prepareStatement(GET_ONE);
			
			psmt.setString(1, mem_no);
			psmt.setString(2, v_no);
			
			rs = psmt.executeQuery();
			
			while (rs.next()) {
				veVO = new V_evaluationVO();
				veVO.setMem_no(rs.getString("mem_no"));
				veVO.setV_no(rs.getString("v_no"));
				veVO.setScore(rs.getInt("score"));
			}
			
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
		} finally {
			
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			
			if (psmt != null) {
				try {
					psmt.close();
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
		
		return veVO;
	}

	@Override
	public List<V_evaluationVO> getAll() {
		
		List<V_evaluationVO> list = new ArrayList<V_evaluationVO>();
		V_evaluationVO veVO = null;
		
		Connection con = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		try {

			con = DriverManager.getConnection(URL, USER, PASSWORD);
			psmt = con.prepareStatement(GET_ALL_STMT);
			rs = psmt.executeQuery();
			
			while (rs.next()) {
				veVO = new V_evaluationVO();
				veVO.setMem_no(rs.getString("mem_no"));
				veVO.setV_no(rs.getString("v_no"));
				veVO.setScore(rs.getInt("score"));
				list.add(veVO);
			}
			
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
		} finally {
			
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			
			if (psmt != null) {
				try {
					psmt.close();
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
	public static void main(String[] args) {
		
		V_evaluationDAO_interface vei  = new V_evaluationJDBCDAO();
		
//		vei.insert(new V_evaluationVO("M005","V000002", 3));
//		vei.insert(new VEVO("M002","V000003", 2));
//		vei.update(new VEVO("M001","V000002", 4));
//		vei.delete("M001", "V000001");
//		
//		
//		V_evaluationVO ve = vei.findByPrimaryKey("M002", "V000002");
//		System.out.println(ve.getScore());
//		
//		System.out.println("========================");
		
		List<V_evaluationVO> veVO = vei.getAll();
		
		for (V_evaluationVO x : veVO) {
			System.out.println(x.getMem_no() + " " + x.getV_no() + " " + x.getScore());
		}
		
	}
	
	
}


