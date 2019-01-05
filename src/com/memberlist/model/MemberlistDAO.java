package com.memberlist.model;

import java.sql.*;
import java.util.*;
import javax.naming.*;
import javax.sql.*;

import com.sg_info.model.Sg_infoVO;
import com.sg_mem.model.Sg_memVO;

public class MemberlistDAO implements MemberlistDAO_interface{

	public MemberlistDAO() {
	}
	private static DataSource ds = null;
	static {
		
			Context ctx;
			try {
				ctx = new InitialContext();
				ds = (DataSource)ctx.lookup("java:comp/env/jdbc/CA105G1DB");
			} catch (NamingException e) {
				e.printStackTrace();
			}
	}
	
	private static final String INSERT_STMT = 
			"INSERT INTO MEMBERLIST (MEM_NO,MEM_NAME,MEM_ACCOUNT,MEM_PSWD,MEM_EMAIL,MEM_PHONE)"
			+ "VALUES ('M'||LPAD(TO_CHAR(member_seq.NEXTVAL),3,'0'),?,?,?,?,?)";		
	private static final String UPDATE_PRIVACY =
			"UPDATE MEMBERLIST SET MEM_NAME=?,MEM_NICK=?,MEM_EMAIL=?"
			+ ",MEM_PHONE=?,MEM_EMGC=?,MEM_EMGCPHONE=? WHERE MEM_NO=?";
	private static final String UPDATE_STATUS =
			"UPDATE MEMBERLIST SET MEM_STATUS = ? WHERE MEM_NO = ?";
	private static final String UPDATE_PASSWORD = 
			"UPDATE MEMBERLIST SET MEM_PSWD = ? WHERE MEM_NO = ?";
	private static final String UPDATE_PICTURE =
			"UPDATE MEMBERLIST SET MEM_PIC=?, MEM_PICKIND=? WHERE MEM_NO = ?";
	private static final String UPDATE_CRADITCARD = 
			"UPDATE MEMBERLIST SET MEM_CARD = ?, MEM_EXPIRY = ? WHERE MEM_NO = ?";
	private static final String GET_ALL_STMT = 
			"SELECT * FROM Memberlist";
	private static final String GET_ONE_STMT = 
			"SELECT * FROM Memberlist WHERE MEM_NO = ? ";
	private static final String GET_ONE_STMT_FROM_ACCOUNT = 
			"SELECT * FROM Memberlist WHERE MEM_ACCOUNT = ? ";
	private static final String GET_MEM_SG = 
			"SELECT * FROM SG_INFO WHERE MEM_NO = ?";
	private static final String GET_MEM_SG_PARTICIPATE = 
			"SELECT * FROM SG_MEM WHERE MEM_NO = ?";
	
		
	
	@Override
	public void insert(MemberlistVO memberlist) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);
			pstmt.setString(1, memberlist.getMem_name());
			pstmt.setString(2, memberlist.getMem_account());
			pstmt.setString(3, memberlist.getMem_pswd());
			pstmt.setString(4, memberlist.getMem_email());
			pstmt.setString(5, memberlist.getMem_phone());
			
			pstmt.executeUpdate();
		} catch (SQLException se) {
			throw new RuntimeException("Database errors occured. "
														+se.getMessage());
		} finally {
			if(pstmt!=null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
			if(con!=null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
		}
	}

	@Override
	public void updatePrivacy(MemberlistVO memberlist) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_PRIVACY);
			System.out.println(memberlist.getMem_emgcphone());
			pstmt.setString(1, memberlist.getMem_name());
			pstmt.setString(2, memberlist.getMem_nick());
			pstmt.setString(3, memberlist.getMem_email());
			pstmt.setString(4, memberlist.getMem_phone());
			pstmt.setString(5, memberlist.getMem_emgc());
			pstmt.setString(6, memberlist.getMem_emgcphone());
			pstmt.setString(7, memberlist.getMem_no());
			
			pstmt.executeUpdate();
		} catch (SQLException se) {
			throw new RuntimeException("Database errors occured. "
														+se.getMessage());
		} finally {
			if(pstmt!=null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
			if(con!=null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
		}
	}
	
	@Override
	public void updateStatus(String mem_no, String mem_status) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_STATUS);
			
			pstmt.setString(1, mem_status);
			pstmt.setString(2, mem_no);
			
			pstmt.executeUpdate();
		} catch (SQLException se) {
			throw new RuntimeException("Database errors occured" 
														+se.getMessage());
		} finally {
			if(pstmt!=null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
			if(con!=null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
		}
		
	}


	@Override
	public void updatePassword(MemberlistVO memberlist) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_PASSWORD);
			
			pstmt.setString(1, memberlist.getMem_pswd());
			pstmt.setString(2, memberlist.getMem_no());
			
			pstmt.executeUpdate();
		} catch (SQLException se) {
			throw new RuntimeException("Database errors occured. "
														+se.getMessage());
		} finally {
			if(pstmt!=null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
			if(con!=null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
		}		
	}


	@Override
	public void updatePicture(MemberlistVO memberlist) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_PICTURE);
			
			pstmt.setBytes(1, memberlist.getMem_pic());
			pstmt.setString(2, memberlist.getMem_pickind());
			pstmt.setString(3, memberlist.getMem_no());
			
			pstmt.executeUpdate();
		} catch (SQLException se) {
			throw new RuntimeException("Database errors occured. "
														+se.getMessage());
		} finally {
			if(pstmt!=null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
			if(con!=null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
		}		
	}

	@Override
	public void updateCraditcard(MemberlistVO memberlist) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_CRADITCARD);
			
			pstmt.setString(1, memberlist.getMem_card());
			pstmt.setString(2, memberlist.getMem_expiry());
			pstmt.setString(3, memberlist.getMem_no());
			
			pstmt.executeUpdate();
		} catch (SQLException se) {
			throw new RuntimeException("Database errors occured. "
														+se.getMessage());
		} finally {
			if(pstmt!=null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
			if(con!=null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
		}
	}
	
	
	
	@Override
	public MemberlistVO findByPrimaryKey(String memno) {
		MemberlistVO memberlist = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);
			pstmt.setString(1, memno);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				memberlist = new MemberlistVO();
				memberlist.setMem_no(memno);
				memberlist.setMem_name(rs.getString("mem_name"));
				memberlist.setMem_nick(rs.getString("mem_nick"));
				memberlist.setMem_account(rs.getString("mem_account"));
				memberlist.setMem_pswd(rs.getString("mem_pswd"));
				memberlist.setMem_email(rs.getString("mem_email"));
				memberlist.setMem_phone(rs.getString("mem_phone"));
				memberlist.setMem_emgc(rs.getString("mem_emgc"));
				memberlist.setMem_emgcphone(rs.getString("mem_emgcphone"));
				memberlist.setMem_status(rs.getString("mem_status"));
				memberlist.setMem_card(rs.getString("mem_card"));
				memberlist.setMem_expiry(rs.getString("mem_expiry"));
				memberlist.setMem_pic(rs.getBytes("mem_pic"));
				memberlist.setMem_pickind(rs.getString("mem_pickind"));
			}
		} catch (SQLException se) {
			throw new RuntimeException("Database errors occured. "
														+se.getMessage());
		} finally {
			
			if(rs!=null) {
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
			if(pstmt!=null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
			if(con!=null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return  memberlist;
	}

	@Override
	public List<MemberlistVO> getAll() {
		List<MemberlistVO> list = new ArrayList<MemberlistVO>();
		MemberlistVO mem = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				mem = new MemberlistVO();
				mem.setMem_no(rs.getString("mem_no"));
				mem.setMem_name(rs.getString("mem_name"));
				mem.setMem_nick(rs.getString("mem_nick"));
				mem.setMem_account(rs.getString("mem_account"));
				mem.setMem_pswd(rs.getString("mem_pswd"));
				mem.setMem_email(rs.getString("mem_email"));
				mem.setMem_phone(rs.getString("mem_phone"));
				mem.setMem_emgc(rs.getString("mem_emgc"));
				mem.setMem_emgcphone(rs.getString("mem_emgcphone"));
				mem.setMem_status(rs.getString("mem_status"));
				mem.setMem_card(rs.getString("mem_card"));
				mem.setMem_expiry(rs.getString("mem_expiry"));
				mem.setMem_pic(rs.getBytes("mem_pic"));
				mem.setMem_pickind(rs.getString("mem_pickind"));
				list.add(mem);
			}
		}catch(SQLException se) {
				throw new RuntimeException("Database errors occured. "
															+se.getMessage());
		}finally {
			if(rs!=null) {
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
			if(pstmt!=null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
			if(con!=null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return list;
	}
	
	@Override
	public String findByAccount(String account) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String mem_no = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT_FROM_ACCOUNT);
			pstmt.setString(1, account);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				mem_no = rs.getString("mem_no");
			}
		} catch (SQLException se) {
			throw new RuntimeException("Database errors occured. "
														+se.getMessage());
		} finally {
			
			if(rs!=null) {
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
			if(pstmt!=null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
			if(con!=null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return  mem_no;
	}

	@Override
	public List<Sg_infoVO> findSgByMem(String mem_no) {
		List<Sg_infoVO> list = new ArrayList<Sg_infoVO>();
		Sg_infoVO vo = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_MEM_SG);
			pstmt.setString(1, mem_no);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				vo = new Sg_infoVO();
				vo.setSg_no(rs.getString("sg_no"));
				vo.setMem_no(rs.getString("mem_no"));
				vo.setSg_name(rs.getString("sg_name"));
				vo.setSg_date(rs.getTimestamp("sg_date"));
				vo.setApl_start(rs.getTimestamp("apl_start"));
				vo.setApl_end(rs.getTimestamp("apl_end"));
				vo.setSg_fee(rs.getInt("sg_fee"));
				vo.setSg_pic(rs.getBytes("sg_pic"));
				vo.setSg_pic_ext(rs.getString("sg_pic_ext"));
				vo.setSg_per(rs.getString("sg_per"));
				vo.setSp_no(rs.getString("sp_no"));
				vo.setV_no(rs.getString("v_no"));
				vo.setSg_maxno(rs.getInt("sg_maxno"));
				vo.setSg_minno(rs.getInt("sg_minno"));
				vo.setSg_ttlapl(rs.getInt("sg_ttlapl"));
				vo.setSg_chkno(rs.getInt("sg_chkno"));
				vo.setSg_extrainfo(rs.getString("sg_extrainfo"));
				vo.setSg_status(rs.getString("sg_status"));
				vo.setLoc_start(rs.getString("loc_start"));
				vo.setLoc_end(rs.getString("loc_end"));

				list.add(vo);
			}
			
		} catch (SQLException e) {
			throw new RuntimeException("Database errors occured. "
					+e.getMessage());
		}finally {
			if(rs!=null) {
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
			if(pstmt!=null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
			if(con!=null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return list;
	}

	@Override
	public List<Sg_memVO> findPartByMem(String mem_no) {
		List<Sg_memVO> list = new ArrayList<>();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Sg_memVO vo = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_MEM_SG_PARTICIPATE);
			pstmt.setString(1, mem_no);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				vo = new Sg_memVO();
				vo.setSg_no(rs.getString("sg_no"));
				vo.setMem_no(mem_no);
				vo.setCh_status(rs.getString("ch_status"));
				list.add(vo);
			}
			
		} catch (SQLException e) {
			throw new RuntimeException("Database errors occured. "
					+e.getMessage());
		}finally {
			if(rs!=null) {
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
			if(pstmt!=null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
			if(con!=null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return list;
	}
	
	
	
}
