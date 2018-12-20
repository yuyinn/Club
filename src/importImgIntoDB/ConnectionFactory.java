package importImgIntoDB;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectionFactory {

	private static String sUrl;
	private static String sUser;
	private static String sPsw;
	private String url;
	private String user;
	private String psw;
	
	public ConnectionFactory(String url,String user,String psw){
		this.url = url;
		this.user = user;
		this.psw = psw;
		sUrl = url;
		sUser = user;
		sPsw = psw;
	}
	public ConnectionFactory(){
		this.url = sUrl;
		this.user = sUser;
		this.psw = sPsw;
	}
	
	public Connection getConnection() {
		Connection con = null;
		try {
			con = DriverManager.getConnection(url, user, psw);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			
		}
		return con;		
	}
	
	
	
}
