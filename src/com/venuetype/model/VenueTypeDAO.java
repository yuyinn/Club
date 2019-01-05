package com.venuetype.model;

import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import java.sql.*;

public class VenueTypeDAO implements VenueTypeDAO_interface{
	
	private static DataSource ds = null;
	
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup(com.util.lang.Util.JNDI_DATABASE_NAME);
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	
	private static final String INSERT_STMT = 
			"INSERT INTO venuetype (vt_no,vt_name) VALUES (?, ?)";
		private static final String GET_ALL_STMT = 
			"SELECT vt_no,vt_name FROM venuetype ORDER BY vt_no";
		private static final String GET_ONE_STMT = 
			"SELECT vt_no,vt_name FROM venuetype WHERE vt_no = ?";
		private static final String DELETE = 
			"DELETE FROM venuetype WHERE vt_no = ?";
		private static final String UPDATE = 
			"UPDATE venuetype SET vt_name = ? WHERE vt_no = ?";
		
	@Override
	public void insert(VenueTypeVO vtVO) {
		
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setString(1, vtVO.getVt_no());
			pstmt.setString(2, vtVO.getVt_name());

			pstmt.executeUpdate();

			// Handle any SQL errors
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
	public void update(VenueTypeVO vtVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setString(1, vtVO.getVt_name());
			pstmt.setString(2, vtVO.getVt_no());

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
	public void delete(String vt_no) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);

			pstmt.setString(1, vt_no);

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
	public VenueTypeVO findByPrimaryKey(String vt_no) {
		
		VenueTypeVO vtVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setString(1, vt_no);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// vtVo 也稱為 Domain objects
				vtVO = new VenueTypeVO();
				vtVO.setVt_no(rs.getString("vt_no"));
				vtVO.setVt_name(rs.getString("vt_name"));
			}

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
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
		return vtVO;
		
	}

	@Override
	public List<VenueTypeVO> getAll() {
		
		List<VenueTypeVO> list = new ArrayList<VenueTypeVO>();
		VenueTypeVO vtVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// vtVO 也稱為 Domain objects
				vtVO = new VenueTypeVO();
				vtVO.setVt_no(rs.getString("vt_no"));
				vtVO.setVt_name(rs.getString("vt_name"));
				list.add(vtVO); // Store the row in the list
			}

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
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
	
	private static final String IS_VENUETYPE_SQL = ""
			+ " SELECT vt_no, vt_name FROM "
			+ " (SELECT vt_no, vt_name FROM venuetype WHERE vt_name=?) "
			+ " WHERE ? LIKE '%'||?||'%'";
	
	@Override
	public boolean isVenueType(String funcList, String vt_name) {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		VenueTypeVO venueTypeVO = null;
		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(IS_VENUETYPE_SQL);
			preparedStatement.setString(1, vt_name);
			preparedStatement.setString(2, funcList);
			preparedStatement.setString(3, vt_name);
			resultSet = preparedStatement.executeQuery();
			venueTypeVO = new VenueTypeVO();
			if(resultSet.next()) {
				venueTypeVO.setVt_no(resultSet.getString("vt_no"));
				venueTypeVO.setVt_name(resultSet.getString("vt_name"));
			}
			
		}catch (SQLException e) {
			throw new RuntimeException("A database error occured. " + e.getMessage());
		}finally {
			if(resultSet!=null) {
				try {
					resultSet.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if(preparedStatement!=null) {
				try {
					preparedStatement.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if(connection!=null) {
				try {
					connection.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}		
		return vt_name.equals(venueTypeVO.getVt_name());
	}
	
}
