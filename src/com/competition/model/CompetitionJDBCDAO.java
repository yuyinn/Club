package com.competition.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

public class CompetitionJDBCDAO implements CompetitionDAO_interface{
		
	private static final String DRIVER = "oracle.jdbc.driver.OracleDriver";
	private static final String URL = "jdbc:oracle:thin:@localhost:1521:xe";
	private static final String USER = "CA105G1";
	private static final String PASSWORD = "123456";
	
	private static final String INSERT_SQL = 
			"INSERT INTO competition( "
			+ "comp_no , comp_name , comp_startdate , comp_enddate , comp_cont) "
			+ "VALUES "
			+ "('C'||LPAD(TO_CHAR(competition_seq.NEXTVAL),3,'0'),?,?,?,?)";
	
	private static final String UPDATE_SQL = 
			"UPDATE competition "
			+ "SET comp_name=?, "
			+ "comp_startdate=?, "
			+ "comp_enddate=?, "
			+ "comp_cont=?"
			+ "WHERE comp_no=?";
	
	private static final String DELETE_BY_PK_SQL = 
			"DELETE FROM competition where comp_no=?";

	private static final String GET_ALL_SQL = 
			"SELECT * FROM competition ORDER BY comp_startdate ASC";
	
	private static final String FIND_BY_PK_SQL = 
			"SELECT * FROM competition where comp_no=?";
	
	private static final String GET_LIST_BY_STARTDATE =
			"SELECT * FROM competition where comp_startdate >= ?";

	static {
		try {
			Class.forName(DRIVER);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	
	@Override
	public void insert(CompetitionVO competitionVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = DriverManager.getConnection(URL, USER, PASSWORD);
			
			String[] cols = {"comp_no"};
			
			pstmt = con.prepareStatement(INSERT_SQL, cols);
			pstmt.setString(1, competitionVO.getComp_name());
			pstmt.setTimestamp(2, competitionVO.getComp_startdate());
			pstmt.setTimestamp(3, competitionVO.getComp_enddate());
			pstmt.setString(4, competitionVO.getComp_cont());
			
			if(pstmt.executeUpdate()==1) {
				System.out.println("---成功輸入---");
			}else {
				System.out.println("---輸入失敗---");
			}
			
			rs = pstmt.getGeneratedKeys();
			ResultSetMetaData resultSetMetaData = rs.getMetaData();
			int columnCount = resultSetMetaData.getColumnCount();
			if(rs.next()) {
				do {
					for(int i = 1; i<=columnCount ; i++) {
						competitionVO.setComp_no(rs.getString(i));
						System.out.println("自增主鍵值 = " + competitionVO.getComp_no() +"(剛新增成功的comp_no)");
					}
				} while(rs.next());
			} else {
				System.out.println("NO KEYS WERE GENERATED.");
			}
		} catch (SQLException e) {
			throw new RuntimeException("A database error occured. "+e.getMessage());
		} finally {
			if(rs!=null) {
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if(pstmt!=null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}			
			if(con!=null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}		
	}

	@Override
	public void update(CompetitionVO competitionVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = DriverManager.getConnection(URL, USER, PASSWORD);
			
			pstmt = con.prepareStatement(UPDATE_SQL);
			pstmt.setString(1, competitionVO.getComp_name());
			pstmt.setTimestamp(2, competitionVO.getComp_startdate());
			pstmt.setTimestamp(3, competitionVO.getComp_enddate());
			pstmt.setString(4, competitionVO.getComp_cont());
			pstmt.setString(5, competitionVO.getComp_no());
			if(pstmt.executeUpdate()==1) {
				System.out.println(competitionVO.getComp_no()+" : 成功更新一筆");
				System.out.println(competitionVO);
			}else {
				System.out.println(competitionVO.getComp_no()+" : 更新失敗");
			}
		} catch (SQLException e) {
			throw new RuntimeException("A database error occured. "+e.getMessage());
		} finally {
			if(pstmt!=null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}			
			if(con!=null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}		
	}

	@Override
	public void delete(String comp_no) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = DriverManager.getConnection(URL, USER, PASSWORD);

			pstmt = con.prepareStatement(DELETE_BY_PK_SQL);
			pstmt.setString(1, comp_no);
			if(pstmt.executeUpdate()==1) {
				System.out.println("---成功刪除---編號 : "+comp_no);
			}else {
				System.out.println("---刪除失敗---編號 : "+comp_no);
			}
			
		} catch (SQLException e) {
			throw new RuntimeException("A database error occured. "+e.getMessage());
		} finally {
			if(pstmt!=null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}			
			if(con!=null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}		
	}

	@Override
	public CompetitionVO findByPrimaryKey(String comp_no) {
		CompetitionVO competitionVO = null;
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		try {
			connection = DriverManager.getConnection(URL, USER, PASSWORD);
			preparedStatement = connection.prepareStatement(FIND_BY_PK_SQL);
			preparedStatement.setString(1, comp_no);
			resultSet = preparedStatement.executeQuery();
			
			if(resultSet.next()) {
				competitionVO = new CompetitionVO();
				competitionVO.setComp_no(resultSet.getString("comp_no"));
				competitionVO.setComp_name(resultSet.getString("comp_name"));
				competitionVO.setComp_startdate(resultSet.getTimestamp("comp_startdate"));
				competitionVO.setComp_enddate(resultSet.getTimestamp("comp_enddate"));
				competitionVO.setComp_cont(resultSet.getString("comp_cont"));
			}
		} catch (SQLException e) {
			throw new RuntimeException("A database error occured. "+e.getMessage());
		} finally {
			if(resultSet!=null) {
				try {
					resultSet.close();
				}catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if(preparedStatement!=null) {
				try {
					preparedStatement.close();
				}catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if(connection!=null) {
				try {
					connection.close();
				}catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return competitionVO;
	}

	@Override
	public List<CompetitionVO> getCompetitionByStartDate(Timestamp timestamp) {
		List<CompetitionVO> list = new ArrayList<>();
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		try {
			connection = DriverManager.getConnection(URL, USER, PASSWORD);
			preparedStatement = connection.prepareStatement(GET_LIST_BY_STARTDATE);
			preparedStatement.setTimestamp(1, timestamp);
			resultSet = preparedStatement.executeQuery();
			list = collectCompetitionVO(resultSet);
		} catch (SQLException e) {
			throw new RuntimeException("A database error occured. "+e.getMessage());
		} finally {
			if(resultSet!=null) {
				try {
					resultSet.close();
				}catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if(preparedStatement!=null) {
				try {
					preparedStatement.close();
				}catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if(connection!=null) {
				try {
					connection.close();
				}catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return list;
	}

	@Override
	public List<CompetitionVO> getAll() {
		List<CompetitionVO> list = new ArrayList<>();
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		try {
			connection = DriverManager.getConnection(URL, USER, PASSWORD);
			preparedStatement = connection.prepareStatement(GET_ALL_SQL);
			resultSet = preparedStatement.executeQuery();
			list = collectCompetitionVO(resultSet);
		} catch (SQLException e) {
			throw new RuntimeException("A database error occured. "+e.getMessage());
		} finally {
			if(resultSet!=null) {
				try {
					resultSet.close();
				}catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if(preparedStatement!=null) {
				try {
					preparedStatement.close();
				}catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if(connection!=null) {
				try {
					connection.close();
				}catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return list;
	}
	
	private List<CompetitionVO> collectCompetitionVO(ResultSet resultSet) throws SQLException{
		List<CompetitionVO> list = new ArrayList<>();
		while(resultSet.next()) {
			CompetitionVO competitionVO = new CompetitionVO();
			competitionVO.setComp_no(resultSet.getString("comp_no"));
			competitionVO.setComp_name(resultSet.getString("comp_name"));
			competitionVO.setComp_startdate(resultSet.getTimestamp("comp_startdate"));
			competitionVO.setComp_enddate(resultSet.getTimestamp("comp_enddate"));
			competitionVO.setComp_cont(resultSet.getString("comp_cont"));
			list.add(competitionVO);
		}
		return list;
	}
	
	
	public static void main(String[] args) {
		CompetitionJDBCDAO dao = new CompetitionJDBCDAO();
		
		CompetitionVO competitionVO = new CompetitionVO();
		competitionVO.setComp_cont("FFFFFFFFFFFFFFFFFFFFF");
		competitionVO.setComp_name("test");
		///////// 字串 轉成 Timestamp 物件
		String s="2012-01-02 13:12:21";
		competitionVO.setComp_startdate(java.sql.Timestamp.valueOf(s));
		//////////////
		long xxx = Calendar.getInstance().getTime().getTime();
		competitionVO.setComp_enddate(new java.sql.Timestamp(xxx));
	dao.insert(competitionVO);
		competitionVO.setComp_cont("更新過後DDDDDDDDDDDDDDDDDDDDDDDDDDD");
		competitionVO.setComp_name("標題更新 test");
	dao.update(competitionVO);
		
	//dao.delete(competitionVO.getComp_no());
	
		CompetitionVO competitionVO2 = dao.findByPrimaryKey("c002".toUpperCase());
		System.out.println(competitionVO2);
		
List<CompetitionVO> list = dao.getAll();
		
		System.out.println(list.size());
		
		if(list.size()>0) {
			for(CompetitionVO x : list) {
				System.out.println(x);
			}
		}else {
			System.out.println("there are no data from this table, Newstype");
		}
		
		
		List<CompetitionVO> list2 = dao.getCompetitionByStartDate(java.sql.Timestamp.valueOf("2018-12-01 13:12:21"));
		
		System.out.println(list2.size());

		if(list2.size()>0) {
			for(CompetitionVO x : list2) {
				System.out.println(x+"-----");
			}
		}else {
			System.out.println("there are no data from this table, Newstype");
		}
		
	}	
}
