package importImgIntoDB;

import java.sql.SQLException;

public class ForOneTable {
	
	// just for one PK of the DB table
	// you have to set USER, PASSWORD
	// 1) folder path where saving the pictures
	// 2) table name in DB
	// 3) primary key coln name
	// 4) set picture coln name
	// 5) set picture extension coln name
	
	private String DRIVER = "oracle.jdbc.driver.OracleDriver";
	private String URL = "jdbc:oracle:thin:@localhost:1521:xe";
	//set your user in DB
	private String USER = "CA105_WEB";
	//set your password
	private String PASSWORD = "123456";

	public ForOneTable setDRIVER(String DRIVER) {
		this.DRIVER = DRIVER;
		return this;
	}

	public ForOneTable setURL(String URL) {
		this.URL = URL;
		return this;
	}

	public ForOneTable setUSER(String USER) {
		this.USER = USER;
		return this;
	}
	
	public ForOneTable setPASSWORD(String PASSWORD) {
		this.PASSWORD = PASSWORD;
		return this;
	}

	private KeyInWord inputName = null;
	
//	inputName = new KeyInWord(divPath,tableName,
//			primaryKeyColnName,pictureColnName,pic_extensionColName);
	
	public ForOneTable(KeyInWord inputName) {
		this.inputName = inputName;
	}
	
	public void doSomeThing() {
		OneManDoing david = null;
		
		try {
			Class.forName(DRIVER);
			
//			//set folder path
//			String divPath = "D:\\image\\test_photo";
//			//set table name in DB
//			String tableName = "test_photo";
//			//set primary key coln name
//			String primaryKeyColnName = "pic_no";
//			//set picture coln name
//			String pictureColnName = "pic";
//			//set picture extension coln name
//			String pic_extensionColName= "pic_ext";
			
			UtilSQL sql = new UtilSQL(inputName.getTableName(),inputName.getPrimaryKeyColnName(),inputName.getPictureColnName(),inputName.getPic_extensionColName());
			
			david = new OneManDoing(new ConnectionFactory(URL,USER,PASSWORD).getConnection(),inputName.getDivPath());
			david.importImgInotoDB(sql);
			
		}catch(ClassNotFoundException e) {
			e.printStackTrace();
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			if(david!=null) {
				if(david.getRs()!=null) {
					try {
						david.getRs().close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
				if(david.getPstmt()!=null) {
					try {
						david.getPstmt().close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
				if(david.getStmt()!=null) {
					try {
						david.getStmt().close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
				if(david.getCon()!=null) {
					try {
						david.getCon().close();
						if(david.getCon().isClosed()) {
							System.out.println("connectoin is cloesed");
						}else {
							System.out.println("connection is not closed");
						}
						david = null;
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
			}
		}
		
		
	}

}
