package importImgIntoDB;

public class KeyInWord {
	
	//set folder path
	private String divPath = "D:\\image\\test_photo";
	
	//set table name in DB
	private String tableName = "test_photo";
	
	//set primary key coln name
	private String primaryKeyColnName = "pic_no";
	
	//set picture coln name
	private String pictureColnName = "pic";
	
	//set picture extension coln name
	private String pic_extensionColName= "pic_ext";
	
	public KeyInWord(){
		
	}

	public KeyInWord(String divPath, String tableName, 
			String primaryKeyColnName, String pictureColnName,
			String pic_extensionColName) {
		super();
		this.divPath = divPath;
		this.tableName = tableName;
		this.primaryKeyColnName = primaryKeyColnName;
		this.pictureColnName = pictureColnName;
		this.pic_extensionColName = pic_extensionColName;
	}

	public String getDivPath() {
		return divPath;
	}

	public void setDivPath(String divPath) {
		this.divPath = divPath;
	}

	public String getTableName() {
		return tableName;
	}

	public void setTableName(String tableName) {
		this.tableName = tableName;
	}

	public String getPrimaryKeyColnName() {
		return primaryKeyColnName;
	}

	public void setPrimaryKeyColnName(String primaryKeyColnName) {
		this.primaryKeyColnName = primaryKeyColnName;
	}

	public String getPictureColnName() {
		return pictureColnName;
	}

	public void setPictureColnName(String pictureColnName) {
		this.pictureColnName = pictureColnName;
	}

	public String getPic_extensionColName() {
		return pic_extensionColName;
	}

	public void setPic_extensionColName(String pic_extensionColName) {
		this.pic_extensionColName = pic_extensionColName;
	}
	
	
	
}
