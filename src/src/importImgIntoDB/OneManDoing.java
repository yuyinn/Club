package importImgIntoDB;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class OneManDoing {
	
	private ResultSet rs = null;
	private Statement stmt = null;
	private PreparedStatement pstmt = null;
	private Connection con;
	private String dirPath;
	
	public OneManDoing(Connection con, String dirPath){
		this.con = con;
		this.dirPath= dirPath;
	}
	
	public ResultSet getRs() {
		return rs;
	}

	public Statement getStmt() {
		return stmt;
	}

	public PreparedStatement getPstmt() {
		return pstmt;
	}
	
	public Connection getCon() {
		return this.con;
	}
	
	public void importImgInotoDB(UtilSQL sql) throws SQLException {
		
		File saveDir = new File(dirPath);
		if(!saveDir.exists()) {
			System.out.println("Error! Folder, '"+dirPath+"', doesn't exist!!!");
			return;
		}
		
		String tableName = sql.getTableName();
		List<String> pkList = getAllPrimaryKeyValueInThisTable(tableName);
		int numRow = pkList.size();
		List<File> imgFiles = new ArrayList<>();
		if(saveDir.isDirectory()) {
			File[] imgArray = saveDir.listFiles();
			numRow = numRow > imgArray.length ? imgArray.length : numRow;
			for(int i = 0 ; i<numRow ; i++ ) {
				String str = imgArray[i].getName();
				String str2 = str.substring(0, str.lastIndexOf("."));
				if(pkList.contains(str2));
					imgFiles.add(imgArray[i]);				
			}
		}else {
			System.out.println("idiot, your saveDir, "+saveDir.getName()+", is not directory");
		}
		int i = 0; // record current row number by index
		for(File file : imgFiles) {
			String str = file.getName();
			String pic_ext = str.substring(str.lastIndexOf(".")+1, str.length());
			FileInputStream fis = null;
			BufferedInputStream bis = null;
			byte[] buf = null;
			try {
				fis = new FileInputStream(file);
				bis = new BufferedInputStream(fis);
				
				buf = new byte[bis.available()];
				while(bis.read(buf)!=-1) {
				}
			} catch (FileNotFoundException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			} finally {
				if(bis!= null) {
					try {
						bis.close();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
				if(fis!= null) {
					try {
						fis.close();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			}
			String pic_no = pkList.get(i);
		System.out.println("primary key value = "+pic_no);
			String updateSQL =sql.UpdatePreparedSQL(pic_no);
			pstmt = con.prepareStatement(updateSQL);
			pstmt.setString( 2, pic_ext);
			pstmt.setBytes(1, buf);
			int iii = pstmt.executeUpdate();
		System.out.println("success number : "+iii);
			//initConnection();
			i++;
		}
	}
	
	private List<String> getAllPrimaryKeyValueInThisTable(String tableName) throws SQLException {
		String SQL = "Select * from "+tableName;
		stmt = con.createStatement();
		rs = stmt.executeQuery(SQL);
		List<String> list = new ArrayList<>();
		while(rs.next()) {
			list.add(rs.getString(1));
		}
		//initConnection();
		return list;
	}

//	private void initConnection() {
//		try {
//			this.con.close();
//		} catch (SQLException e) {
//			e.printStackTrace();
//		}
//		try {
//			if(con.isClosed()) {
//				con = new ConnectionFactory().getConnection();
//			}
//		} catch (SQLException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//		
//	}
	
	
	

}
