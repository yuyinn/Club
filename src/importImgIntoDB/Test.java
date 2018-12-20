package importImgIntoDB;

import java.io.File;

public class Test {
	public static void main(String[] args) {
		File file = new File("C:\\Users\\Java\\Pictures\\水豚\\000.jpeg");
		System.out.println(file.getName());
		String str = file.getName();
		String str2 = str.substring(0, str.lastIndexOf("."));
		System.out.println(str2);
		
		
	}
}
