package com.memberlist.model;

import java.sql.*;
import java.util.*;

import com.sg_info.model.Sg_infoVO;
import com.sg_mem.model.Sg_memVO;

public class MemberlistJDBCDAO implements MemberlistDAO_interface  {

	public MemberlistJDBCDAO(){

	}
	
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@10.37.129.3:1521:XE";
	String user = "AARON";
	String password = "123456";
	
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
			"UPDATE MEMBERLIST SET MEM_PIC, MEM_PICKIND WHERE MEM_NO = ?";
	private static final String UPDATE_CRADITCARD = 
			"UPDATE MEMBERLIST SET MEM_CARD = ?, MEM_EXPIRY = ? WHERE MEM_NO = ?";
	private static final String GET_ALL_STMT = 
			"SELECT * FROM Memberlist";
	private static final String GET_ONE_STMT = 
			"SELECT * FROM Memberlist where MEM_NO = ? ";
	
	
		
	
	@Override
	public void insert(MemberlistVO memberlist) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			pstmt = con.prepareStatement(INSERT_STMT);
			pstmt.setString(1, memberlist.getMem_name());
			pstmt.setString(2, memberlist.getMem_account());
			pstmt.setString(3, memberlist.getMem_pswd());
			pstmt.setString(4, memberlist.getMem_email());
			pstmt.setString(5, memberlist.getMem_phone());
			
			pstmt.executeUpdate();
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load the database driver. "
														+e.getMessage());
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
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
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
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load the database driver. "
														+e.getMessage());
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
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			pstmt = con.prepareStatement(UPDATE_STATUS);
			
			pstmt.setString(1, mem_status);
			pstmt.setString(2, mem_no);
			
			pstmt.executeUpdate();
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load the database driver. "
														+e.getMessage());
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
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			pstmt = con.prepareStatement(UPDATE_PASSWORD);
			
			pstmt.setString(1, memberlist.getMem_pswd());
			pstmt.setString(2, memberlist.getMem_no());
			
			pstmt.executeUpdate();
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load the database driver. "
														+e.getMessage());
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
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			pstmt = con.prepareStatement(UPDATE_PICTURE);
			
			pstmt.setBytes(1, memberlist.getMem_pic());
			pstmt.setString(2, memberlist.getMem_pickind());
			pstmt.setString(3, memberlist.getMem_no());
			
			pstmt.executeUpdate();
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load the database driver. "
														+e.getMessage());
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
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			pstmt = con.prepareStatement(UPDATE_CRADITCARD);
			
			pstmt.setString(1, memberlist.getMem_card());
			pstmt.setString(2, memberlist.getMem_expiry());
			pstmt.setString(3, memberlist.getMem_no());
			
			pstmt.executeUpdate();
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load the database driver. "
														+e.getMessage());
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
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			pstmt = con.prepareStatement(GET_ONE_STMT);
			pstmt.setString(1, memno);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				memberlist = new MemberlistVO();
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
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load the database driver. "
														+e.getMessage());
		} catch (SQLException se) {
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
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
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
		}catch(ClassNotFoundException e) {
				throw new RuntimeException("Couldn't load the database driver. "
															+e.getMessage());
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
		MemberlistVO memberlist = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String mem_no = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			pstmt = con.prepareStatement(GET_ONE_STMT);
			pstmt.setString(1, account);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				memberlist = new MemberlistVO();
				memberlist.setMem_no(rs.getString("mem_no"));
			}
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load the database driver. "
														+e.getMessage());
		} catch (SQLException se) {
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
		return  mem_no;
	}
	
	

	public static void main(String[] args) {
		MemberlistJDBCDAO memlist = new MemberlistJDBCDAO();
		MemberlistVO memcreate = new MemberlistVO("ICHIRO","a029","123456",
										"s9821100@gm.pu.edu.tw","0937351931");
		memlist.insert(memcreate);
		System.out.println("A member created successful.");
		
		MemberlistVO memupdatepivacy = new MemberlistVO("M029","ICHIRO","Baseball man"
										,"s9821100@gm.pu.edu.tw","0937351931","大崛彩","0937351931");
		memlist.updatePrivacy(memupdatepivacy);
		System.out.println("A member privacy updated successful.");
		
		MemberlistVO memberupdatepassword = new MemberlistVO("M029", "12345678");
		memlist.updatePassword(memberupdatepassword);
		System.out.println("A member password updated successful.");
		
//		WARNING
//		
		MemberlistVO memberudatecraditcard = new MemberlistVO("M029", "1234567887654321","2021-01");
		memlist.updateCraditcard(memberudatecraditcard);
		memlist.updateStatus("M029", "正式會員");
		System.out.println("A member status updated successful");
		
		
		
		MemberlistVO findmem = memlist.findByPrimaryKey("M029");
		
			System.out.println("Name : "+findmem.getMem_name());
			System.out.println("Account : "+findmem.getMem_account());
			System.out.println("Nickname : "+findmem.getMem_nick());
			System.out.println("Email : "+findmem.getMem_email());
			System.out.println("Phone : "+findmem.getMem_phone());
			System.out.println("Status : "+findmem.getMem_status());
		
		List<MemberlistVO> list = memlist.getAll();
		for(MemberlistVO show : list) {
			System.out.println(show.getMem_name());
		}
	}

	@Override
	public List<Sg_infoVO> findSgByMem(String mem_no) {
		return null;
	}

	@Override
	public List<Sg_memVO> findPartByMem(String mem_no) {
		// TODO Auto-generated method stub
		return null;
	}

	
}
