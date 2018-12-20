package importImgIntoDB;

import java.io.File;
import java.util.HashMap;
import java.util.Map;

public class mainAllimageIntoDB {
	
	private static final String DRIVER = "oracle.jdbc.driver.OracleDriver";
	private static final String URL = "jdbc:oracle:thin:@localhost:1521:xe";
	// pls. set your user in DB
	private static final String USER = "CA105G1";
	// pls. set your password
	private static final String PASSWORD = "123456";
	
	public static void main(String[] args) {
		
		// 請設定pull到本地端的路徑，如--->C:\Users\wenshock\git\SPORTGO\InitDB\image
		String rootPath = "C:\\Users\\Java\\git\\SPORTGO\\InitDB\\InitDB\\image";
		
		File file = new File(rootPath);
		if(!file.isDirectory()) {
			System.out.println("There are no directory");
			return;
		}
		
		Map<String, String[]> map = new HashMap<>();
		// 01-memberlist table image {primaryKeyColnName,pictureColnName,pic_extensionColName}
		String[] memberListContent = {"MEM_NO","MEM_PIC","MEM_PICKIND"}; 
		map.put("MEMBERLIST", memberListContent);
		
		// 08-sg_info table image {primaryKeyColnName,pictureColnName,pic_extensionColName}
		String[] sg_info_Content = {"SG_NO","SG_PIC","SG_PIC_EXT"}; 
		map.put("SG_INFO", sg_info_Content);
				
		// 14-club table image {primaryKeyColnName,pictureColnName,pic_extensionColName}
		String[] club_Content = {"CLUB_NO","PHOTO","PHOTO_EXT"}; 
		map.put("CLUB", club_Content);
		
		// 16-multimedia table image {primaryKeyColnName,pictureColnName,pic_extensionColName}
		String[] multimedia_Content = {"MEDIA_NO","MEDIA_CONTENT","FILE_EXTEMSION"}; 
		map.put("MULTIMEDIA", multimedia_Content);
				
		// 23-product table image {primaryKeyColnName,pictureColnName,pic_extensionColName}
		String[] product_Content = {"PRO_NO","PRO_PIC","PRO_PIC_EXT"}; 
		map.put("PRODUCT", product_Content);
		
		// 31-news table image {primaryKeyColnName,pictureColnName,pic_extensionColName}
		String[] news_Content = {"NEWS_NO","NEWS_PICTURE","PIC_EXTENSION"}; 
		map.put("NEWS", news_Content);
		
		
		String[] divArray = file.list();
		for(int i = 0 ; i < divArray.length ; i++) {
			File subFile = new File(rootPath+"\\"+divArray[i]);
			System.out.println(subFile.getName());
			if(subFile.isDirectory()) {
				if(map.get(subFile.getName())==null) {
					break;
				}
				String divPath = rootPath+"\\"+subFile.getName();
				String primaryKeyColnName = map.get(subFile.getName())[0];
				String pictureColnName = map.get(subFile.getName())[1];
				String pic_extensionColName = map.get(subFile.getName())[2];
				KeyInWord inputName = new KeyInWord(divPath,subFile.getName(),
						primaryKeyColnName,pictureColnName,pic_extensionColName);
				ForOneTable forOneTable = new ForOneTable(inputName);
				 forOneTable.setDRIVER(DRIVER)
							.setURL(URL)
							.setUSER(USER)
							.setPASSWORD(PASSWORD)
							.doSomeThing();
			}
		}
	}
}
