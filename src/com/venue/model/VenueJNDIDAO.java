package com.venue.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.naming.NamingException;
import javax.sql.DataSource;



public class VenueJNDIDAO implements VenueDAO_interface {

	private static DataSource dataSource = null;
	static {
		try {
			javax.naming.Context context = new javax.naming.InitialContext();
			dataSource = (DataSource)context.lookup(com.util.lang.Util.JNDI_DATABASE_NAME);
		}catch (NamingException e) {
			e.printStackTrace();
		}
	}

	private static final String INSERT=""
			+ "INSERT INTO venue "
			+ "(v_no, v_name, v_weburl, v_parktype, v_introduction, "
			+ " vt_no, v_inout, reg_no, v_address, v_phoneno, v_lat, v_long, "
			+ " v_fitall, v_fitinter, "
			+ " open_state, open_time, "
			+ " openday_mon, openday_tue, openday_wed, openday_thu, "
			+ " openday_fri, openday_sat, openday_sun, "
			+ " v_photo1, v_photo1_ext, "
			+ " v_photo2, v_photo2_ext,"
			+ " v_photo1_url, v_photo2_url, v_display) "
			+ " VALUES ('V'||LPAD(venue_seq.NEXTVAL,6,'0'), ?, ?, ?, ?, "
			+ " ?, ?, ?, ?, ?, ?, ?, "
			+ " ?, ?, "
			+ " ?, ?, "
			+ " ?, ?, ?, ?, "
			+ " ?, ?, ?, "
			+ " ?, ?,"
			+ " ?, ?,"
			+ " ?, ?, ?)"
			+ "";
	private static final String GET_ALL_STMT=""
			+ "SELECT "
			+ " v_no, v_name, v_weburl, v_parktype, v_introduction, "
			+ " vt_no, v_inout, reg_no, v_address, v_phoneno, v_lat, v_long, "
			+ " v_fitall, v_fitinter, "
			+ " open_state, open_time, "
			+ " openday_mon, openday_tue, openday_wed, openday_thu, "
			+ " openday_fri, openday_sat, openday_sun, "
			+ " v_photo1, v_photo1_ext, "
			+ " v_photo2, v_photo2_ext,"
			+ " v_photo1_url, v_photo2_url ,v_display "
			+ " FROM venue ORDER BY v_no ASC";
	
	private static final String GET_ONE_STMT=""
			+ "SELECT "
			+ " v_no, v_name, v_weburl, v_parktype, v_introduction, "
			+ " vt_no, v_inout, reg_no, v_address, v_phoneno, v_lat, v_long, "
			+ " v_fitall, v_fitinter, "
			+ " open_state, open_time, "
			+ " openday_mon, openday_tue, openday_wed, openday_thu, "
			+ " openday_fri, openday_sat, openday_sun, "
			+ " v_photo1, v_photo1_ext, "
			+ " v_photo2, v_photo2_ext,"
			+ " v_photo1_url, v_photo2_url, v_display "
			+ " FROM venue where v_no=? ";
	
	private static final String DELETE=""
			+ "DELETE FROM venue WHERE v_no=?";
	
	private static final String UPDATE=""
			+ "UPDATE venue SET "
			+ " v_name=?, v_weburl=?, v_parktype=?, v_introduction=?, "
			+ " vt_no=?, v_inout=?, reg_no=?, v_address=?, v_phoneno=?, v_lat=?, v_long=?, "
			+ " v_fitall=?, v_fitinter=?,"
			+ " open_state=?, open_time=?, "
			+ " openday_mon=?, openday_tue=?, , openday_wed=?, openday_thu=?, "
			+ "	openday_fri=?, openday_sat=?, openday_sun=?, "
			+ " v_photo1=?, v_photo1_ext=?, v_photo2=?, v_photo2_ext=?, "
			+ " v_photo1_url=?, v_photo2_url=?, v_display=? "
			+ " WHERE v_no=?";
	
	
	
	@Override
	public void insert(VenueVO venueVO) {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		try {
			connection = dataSource.getConnection();
			String[] cols = {"v_no"};	
			preparedStatement = connection.prepareStatement(INSERT,cols);
			preparedStatement.setString(1, venueVO.getV_name());
			preparedStatement.setString(2, venueVO.getV_weburl());
			preparedStatement.setString(3, venueVO.getV_parktype());
			preparedStatement.setString(4, venueVO.getV_introduction());
			preparedStatement.setString(5, venueVO.getVt_no());
			preparedStatement.setString(6, venueVO.getV_inout());
			preparedStatement.setInt(7, venueVO.getReg_no());
			preparedStatement.setString(8, venueVO.getV_address());
			preparedStatement.setString(9, venueVO.getV_phoneno());
			preparedStatement.setDouble(10, venueVO.getV_lat());
			preparedStatement.setDouble(11, venueVO.getV_long());
			//preparedStatement.setString(12, venueVO.getV_public_transport());
			preparedStatement.setString(12, venueVO.getV_fitall());
			preparedStatement.setString(13, venueVO.getV_fitinter());
			preparedStatement.setString(14, venueVO.getOpen_state());
			preparedStatement.setString(15, venueVO.getOpen_time());
			preparedStatement.setString(16, venueVO.getOpenday_mon());
			preparedStatement.setString(17, venueVO.getOpenday_tue());
			preparedStatement.setString(18, venueVO.getOpenday_wed());
			preparedStatement.setString(19, venueVO.getOpenday_thu());
			preparedStatement.setString(20, venueVO.getOpenday_fri());
			preparedStatement.setString(21, venueVO.getOpenday_sat());
			preparedStatement.setString(22, venueVO.getOpenday_sun());
			preparedStatement.setBytes(23, venueVO.getV_photo1());
			preparedStatement.setString(24, venueVO.getV_photo1_ext());
			preparedStatement.setBytes(25, venueVO.getV_photo2());
			preparedStatement.setString(26, venueVO.getV_photo2_ext());
			preparedStatement.setString(27, venueVO.getV_photo1_url());
			preparedStatement.setString(28, venueVO.getV_photo2_url());
			preparedStatement.setString(29, venueVO.getV_display());
			preparedStatement.executeUpdate();
			
			resultSet = preparedStatement.getGeneratedKeys();
			ResultSetMetaData resultSetMetaData = resultSet.getMetaData();
			int columnCount = resultSetMetaData.getColumnCount();
			if(resultSet.next()) {
				do {
					for(int i = 1 ; i <= columnCount ; i++) {
						venueVO.setV_no(resultSet.getString(i));
					}
				}while(resultSet.next());
			}
		}catch(SQLException e) {
			throw new RuntimeException("A database error occured. "+e.getMessage());
		}finally {
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
	}

	@Override
	public void update(VenueVO venueVO) {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		try {
			connection = dataSource.getConnection();
			preparedStatement = connection.prepareStatement(UPDATE);
			preparedStatement.setString(1, venueVO.getV_name());
			preparedStatement.setString(2, venueVO.getV_weburl());
			preparedStatement.setString(3, venueVO.getV_parktype());
			preparedStatement.setString(4, venueVO.getV_introduction());
			preparedStatement.setString(5, venueVO.getVt_no());
			preparedStatement.setString(6, venueVO.getV_inout());
			preparedStatement.setInt(7, venueVO.getReg_no());
			preparedStatement.setString(8, venueVO.getV_address());
			preparedStatement.setString(9, venueVO.getV_phoneno());
			preparedStatement.setDouble(10, venueVO.getV_lat());
			preparedStatement.setDouble(11, venueVO.getV_long());
//			preparedStatement.setString(12, venueVO.getV_public_transport());
			preparedStatement.setString(12, venueVO.getV_fitall());
			preparedStatement.setString(13, venueVO.getV_fitinter());
			preparedStatement.setString(14, venueVO.getOpen_state());
			preparedStatement.setString(15, venueVO.getOpen_time());
			preparedStatement.setString(16, venueVO.getOpenday_mon());
			preparedStatement.setString(17, venueVO.getOpenday_tue());
			preparedStatement.setString(18, venueVO.getOpenday_wed());
			preparedStatement.setString(19, venueVO.getOpenday_thu());
			preparedStatement.setString(20, venueVO.getOpenday_fri());
			preparedStatement.setString(21, venueVO.getOpenday_sat());
			preparedStatement.setString(22, venueVO.getOpenday_sun());
			preparedStatement.setBytes(23, venueVO.getV_photo1());
			preparedStatement.setString(24, venueVO.getV_photo1_ext());
			preparedStatement.setBytes(25, venueVO.getV_photo2());
			preparedStatement.setString(26, venueVO.getV_photo2_ext());
			preparedStatement.setString(27, venueVO.getV_photo1_url());
			preparedStatement.setString(28, venueVO.getV_photo2_url());
			preparedStatement.setString(29, venueVO.getV_display());
			preparedStatement.setString(30, venueVO.getV_no());
			
			preparedStatement.executeUpdate();
			
		}catch (SQLException e) {
			throw new RuntimeException("A database error occured. "+e.getMessage());
		}finally {
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
		
		
		
		
	}

	@Override
	public void delete(String v_no) {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		try {
			connection = dataSource.getConnection();
			preparedStatement = connection.prepareStatement(DELETE);
			preparedStatement.setString(1, v_no);
			
			preparedStatement.executeUpdate();
			
		}catch(SQLException e) {
			throw new RuntimeException("A database error occured. "+e.getMessage());
		}finally {
			if( preparedStatement != null) {
				try {
					preparedStatement.close();
				}catch (SQLException e) {
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
	}

	@Override
	public VenueVO findByPrimaryKey(String v_no) {
		VenueVO venueVO = null;
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		try {
			connection = dataSource.getConnection();
			preparedStatement = connection.prepareStatement(GET_ONE_STMT);
			System.out.println("GET_ONE_STMT : "+GET_ONE_STMT);
			preparedStatement.setString(1, v_no);
			resultSet = preparedStatement.executeQuery();
			if(resultSet.next()) {
				venueVO = new VenueVO();
				venueVO.setV_no(resultSet.getString("V_NO"));
				venueVO.setV_name(resultSet.getString("V_NAME"));
				venueVO.setV_weburl(resultSet.getString("V_WEBURL"));
				venueVO.setV_parktype(resultSet.getString("V_PARKTYPE"));
				venueVO.setV_introduction(resultSet.getString("V_INTRODUCTION"));
				venueVO.setVt_no(resultSet.getString("VT_NO"));
				venueVO.setV_inout(resultSet.getString("V_INOUT"));
				venueVO.setReg_no(resultSet.getInt("REG_NO"));
				venueVO.setV_address(resultSet.getString("V_ADDRESS"));
				venueVO.setV_phoneno(resultSet.getString("V_PHONENO"));
				venueVO.setV_lat(resultSet.getDouble("V_LAT"));
				venueVO.setV_long(resultSet.getDouble("V_LONG"));
				//venueVO.setV_public_transport();
				venueVO.setV_fitall(resultSet.getString("V_FITALL"));
				venueVO.setV_fitinter(resultSet.getString("V_FITINTER"));
				venueVO.setOpen_state(resultSet.getString("OPEN_STATE"));
				venueVO.setOpen_time(resultSet.getString("OPEN_TIME"));
				venueVO.setOpenday_mon(resultSet.getString("OPENDAY_MON"));
				venueVO.setOpenday_tue(resultSet.getString("OPENDAY_TUE"));
				venueVO.setOpenday_wed(resultSet.getString("OPENDAY_WED"));
				venueVO.setOpenday_thu(resultSet.getString("OPENDAY_THU"));
				venueVO.setOpenday_fri(resultSet.getString("OPENDAY_FRI"));
				venueVO.setOpenday_sat(resultSet.getString("OPENDAY_SAT"));
				venueVO.setOpenday_sun(resultSet.getString("OPENDAY_SUN"));
				venueVO.setV_photo1(resultSet.getBytes("V_PHOTO1"));
				venueVO.setV_photo1_ext(resultSet.getString("V_PHOTO1_EXT"));
				venueVO.setV_photo2(resultSet.getBytes("V_PHOTO2"));
				venueVO.setV_photo2_ext(resultSet.getString("V_PHOTO2_EXT"));
				venueVO.setV_photo1_url(resultSet.getString("V_PHOTO1_URL"));
				venueVO.setV_photo2_url(resultSet.getString("V_PHOTO2_URL"));
				venueVO.setV_display(resultSet.getString("V_DISPLAY"));
			}
			
		}catch (SQLException e) {
			throw new RuntimeException("A database error occured. "+e.getMessage());
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
		return venueVO;
	}

	@Override
	public List<VenueVO> getAll() {
		List<VenueVO> list = new ArrayList<>();
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		try {
			connection = dataSource.getConnection();
			preparedStatement = connection.prepareStatement(GET_ALL_STMT);
			resultSet = preparedStatement.executeQuery();
			list = collectVenueVO(resultSet);
			
		}catch (SQLException e) {
			list = new ArrayList<>();
			throw new RuntimeException("A database error occured. "+e.getMessage());
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
		return list;
	}
	
	private List<VenueVO> collectVenueVO(ResultSet resultSet) throws SQLException {
		List<VenueVO> list = new ArrayList<>();
		while(resultSet.next()) {
			VenueVO venueVO = new VenueVO();
			venueVO.setV_no(resultSet.getString("V_NO"));
			venueVO.setV_name(resultSet.getString("V_NAME"));
			venueVO.setV_weburl(resultSet.getString("V_WEBURL"));
			venueVO.setV_parktype(resultSet.getString("V_PARKTYPE"));
			venueVO.setV_introduction(resultSet.getString("V_INTRODUCTION"));
			venueVO.setVt_no(resultSet.getString("VT_NO"));
			venueVO.setV_inout(resultSet.getString("V_INOUT"));
			venueVO.setReg_no(resultSet.getInt("REG_NO"));
			venueVO.setV_address(resultSet.getString("V_ADDRESS"));
			venueVO.setV_phoneno(resultSet.getString("V_PHONENO"));
			venueVO.setV_lat(resultSet.getDouble("V_LAT"));
			venueVO.setV_long(resultSet.getDouble("V_LONG"));
			//venueVO.setV_public_transport();
			venueVO.setV_fitall(resultSet.getString("V_FITALL"));
			venueVO.setV_fitinter(resultSet.getString("V_FITINTER"));
			venueVO.setOpen_state(resultSet.getString("OPEN_STATE"));
			venueVO.setOpen_time(resultSet.getString("OPEN_TIME"));
			venueVO.setOpenday_mon(resultSet.getString("OPENDAY_MON"));
			venueVO.setOpenday_tue(resultSet.getString("OPENDAY_TUE"));
			venueVO.setOpenday_wed(resultSet.getString("OPENDAY_WED"));
			venueVO.setOpenday_thu(resultSet.getString("OPENDAY_THU"));
			venueVO.setOpenday_fri(resultSet.getString("OPENDAY_FRI"));
			venueVO.setOpenday_sat(resultSet.getString("OPENDAY_SAT"));
			venueVO.setOpenday_sun(resultSet.getString("OPENDAY_SUN"));
			venueVO.setV_photo1(resultSet.getBytes("V_PHOTO1"));
			venueVO.setV_photo1_ext(resultSet.getString("V_PHOTO1_EXT"));
			venueVO.setV_photo2(resultSet.getBytes("V_PHOTO2"));
			venueVO.setV_photo2_ext(resultSet.getString("V_PHOTO2_EXT"));
			venueVO.setV_photo1_url(resultSet.getString("V_PHOTO1_URL"));
			venueVO.setV_photo2_url(resultSet.getString("V_PHOTO2_URL"));
			venueVO.setV_display(resultSet.getString("V_DISPLAY"));
			list.add(venueVO);
		}
		return list;
	}
	
	@Override
	public List<VenueVO> getAll(Map<String, String[]> map) {
		List<VenueVO> list = new ArrayList<VenueVO>();
		
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		try {
			connection = dataSource.getConnection();
			String finalSQL = "Select * from venue "
					+ Util_JDBC_CompositeQuery_Venue.get_WhereCondition(map)
					+ " order by v_no";
			
			preparedStatement = connection.prepareStatement(finalSQL);
			System.out.println("+++FinalSQL(by JDBCDAO) = "+finalSQL);
			resultSet = preparedStatement.executeQuery();
			list = collectVenueVO(resultSet);
			
			
		}catch (SQLException e) {
			list = new ArrayList<>();
			throw new RuntimeException("A database error occured. "+e.getMessage());
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
		return list;
	}
	
}