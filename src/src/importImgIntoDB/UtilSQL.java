package importImgIntoDB;

public class UtilSQL {
	
	private String tableName;
	private String primaryKeyColnName;
	private String pictureColnName;
	private String pic_extensionColName;
	
	public UtilSQL(String tableName, String primaryKeyColnName,String pictureColnName, String pic_extensionColName) {
		this.pic_extensionColName = pic_extensionColName;
		this.pictureColnName =pictureColnName;
		this.tableName = tableName;
		this.primaryKeyColnName = primaryKeyColnName;
	}
	
	public String UpdatePreparedSQL(String primaryKeyValue) {
		//return "update test_photo set pic=?, pic_ext=? where pic_no='"+primaryKeyValue+"'";
		return "update "+this.tableName+" set "+this.pictureColnName+"=?, "+this.pic_extensionColName+"=? where "+this.primaryKeyColnName+"='"+primaryKeyValue+"'";
	}

	public String getTableName() {
		return tableName;
	}

	public void setTableName(String tableName) {
		this.tableName = tableName;
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

	public String getPrimaryKeyColnName() {
		return primaryKeyColnName;
	}

	public void setPrimaryKeyColnName(String primaryKeyColnName) {
		this.primaryKeyColnName = primaryKeyColnName;
	}
	
	
}
