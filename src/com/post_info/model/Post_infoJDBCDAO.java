package com.post_info.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.club.model.ClubJDBCDAO;
import com.club.model.ClubVO;

public class Post_infoJDBCDAO implements Post_infoDAO_interface{
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String userid = "CA105G1";
	String passwd = "123456";
	
	
	private static final String INSERT_STMT = 
			"INSERT INTO post_info (post_no,club_no,mem_no,post_topic,post_content,post_date) VALUES (('P'||LPAD(to_char(post_info_seq.NEXTVAL), 4, '0')), ?, ?, ?, ?, ?)";
		private static final String GET_ALL_STMT = 
			"SELECT post_no,club_no,mem_no,post_topic,post_content,post_date FROM post_info order by post_no";
		private static final String GET_ONE_STMT = 
			"SELECT post_no,club_no,mem_no,post_topic,post_content,post_date FROM post_info where post_no = ?";
		private static final String DELETE = 
			"DELETE FROM post_info where post_no = ?";
		private static final String UPDATE = 
			"UPDATE post_info set club_no=? ,mem_no=? ,post_topic=? ,post_content=? ,post_date=? where post_no = ?";
		@Override
		public void insert(Post_infoVO post_infoVO) {
			Connection con = null;
			PreparedStatement pstmt = null;
			
			try {
				Class.forName(driver);
				con = DriverManager.getConnection(url, userid, passwd);
				pstmt = con.prepareStatement(INSERT_STMT);
				
				
				pstmt.setString(1, post_infoVO.getClub_no());
				pstmt.setString(2, post_infoVO.getMem_no());
				pstmt.setString(3, post_infoVO.getPost_topic());
				pstmt.setString(4, post_infoVO.getPost_content());
				pstmt.setTimestamp(5, post_infoVO.getPost_date());
				
				pstmt.executeUpdate();
				
				
			} catch (ClassNotFoundException e) {
				throw new RuntimeException("Couldn't load database driver. "
						+ e.getMessage());
			}catch (SQLException se) {
				throw new RuntimeException("A database error occured. "
						+ se.getMessage());
			}finally {
				if (pstmt != null) {
					try {
						pstmt.close();
					} catch (SQLException se) {
						se.printStackTrace(System.err);
					}
				}
				if (con != null) {
					try {
						con.close();
					} catch (SQLException se) {
						se.printStackTrace(System.err);
					}
				}
			}
			
		}
		@Override
		public void update(Post_infoVO post_infoVO) {
			Connection con = null;
			PreparedStatement pstmt = null;
			
			try {
				Class.forName(driver);
				con = DriverManager.getConnection(url, userid, passwd);
				pstmt = con.prepareStatement(UPDATE);
				

				pstmt.setString(1, post_infoVO.getClub_no());
				pstmt.setString(2, post_infoVO.getMem_no());
				pstmt.setString(3, post_infoVO.getPost_topic());
				pstmt.setString(4, post_infoVO.getPost_content());
				pstmt.setTimestamp(5, post_infoVO.getPost_date());
				pstmt.setString(6, post_infoVO.getPost_no());
				
				pstmt.executeUpdate();
				
			} catch (ClassNotFoundException e) {
				throw new RuntimeException("Couldn't load database driver. "
						+ e.getMessage());
			} catch (SQLException se) {
				throw new RuntimeException("A database error occured. "
						+ se.getMessage());
			}finally {
				if (pstmt != null) {
					try {
						pstmt.close();
					} catch (SQLException se) {
						se.printStackTrace(System.err);
					}
				}
				if (con != null) {
					try {
						con.close();
					} catch (SQLException se) {
						se.printStackTrace(System.err);
					}
				}
			}			
		}
		
		
		@Override
		public void delete(String post_no) {
			Connection con = null;
			PreparedStatement pstmt = null;
			
			try {
				Class.forName(driver);
				con = DriverManager.getConnection(url, userid, passwd);
				pstmt = con.prepareStatement(DELETE);
				
				pstmt.setString(1, post_no);
				
				pstmt.executeUpdate();
				
			} catch (ClassNotFoundException e) {
				throw new RuntimeException("Couldn't load database driver. "
						+ e.getMessage());
			} catch (SQLException se) {
				throw new RuntimeException("A database error occured. "
						+ se.getMessage());
			}finally {
				if (pstmt != null) {
					try {
						pstmt.close();
					} catch (SQLException se) {
						se.printStackTrace(System.err);
					}
				}
				if (con != null) {
					try {
						con.close();
					} catch (SQLException se) {
						se.printStackTrace(System.err);
					}
				}
			}			
		}
		@Override
		public Post_infoVO findByPrimaryKey(String post_no) {
			Post_infoVO post_infoVO = null;
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try {
				Class.forName(driver);
				con = DriverManager.getConnection(url, userid, passwd);
				pstmt = con.prepareStatement(GET_ONE_STMT);
				
				pstmt.setString(1, post_no);
				
				rs = pstmt.executeQuery();
				
				while (rs.next()) {
					post_infoVO = new Post_infoVO();
					
					post_infoVO.setPost_no(rs.getString("post_no"));
					post_infoVO.setClub_no(rs.getString("club_no"));
					post_infoVO.setMem_no(rs.getString("mem_no"));
					post_infoVO.setPost_topic(rs.getString("post_topic"));
					post_infoVO.setPost_content(rs.getString("post_content"));
					post_infoVO.setPost_date(rs.getTimestamp("post_date"));
				}
							
			} catch (ClassNotFoundException e) {
				throw new RuntimeException("Couldn't load database driver. "
						+ e.getMessage());
			} catch (SQLException se) {
				throw new RuntimeException("A database error occured. "
						+ se.getMessage());
			}finally {
				if (rs != null) {
					try {
						rs.close();
					} catch (SQLException se) {
						se.printStackTrace(System.err);
					}
				}
				if (pstmt != null) {
					try {
						pstmt.close();
					} catch (SQLException se) {
						se.printStackTrace(System.err);
					}
				}
				if (con != null) {
					try {
						con.close();
					} catch (SQLException se) {
						se.printStackTrace(System.err);
					}
				}
			}
			return post_infoVO;
		}
		
		
		@Override
		public List<Post_infoVO> getAll() {
			List<Post_infoVO> list = new ArrayList<Post_infoVO>();
			Post_infoVO post_infoVO = null;
			
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();
				
			while(rs.next()) {
					post_infoVO = new Post_infoVO();
					
					post_infoVO.setPost_no(rs.getString("post_no"));
					post_infoVO.setClub_no(rs.getString("club_no"));
					post_infoVO.setMem_no(rs.getString("mem_no"));
					post_infoVO.setPost_topic(rs.getString("post_topic"));
					post_infoVO.setPost_content(rs.getString("post_content"));
					post_infoVO.setPost_date(rs.getTimestamp("post_date"));
				
					list.add(post_infoVO);
			}
			
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
		}finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
		}
			return list;
	}
		
		public static void main(String[] args) {
			
			Post_infoJDBCDAO dao = new Post_infoJDBCDAO();
			
			//新增
//			Post_infoVO post_infoVO1 = new Post_infoVO();
//			post_infoVO1.setClub_no("C0003");
//			post_infoVO1.setMem_no("M001");
//			post_infoVO1.setPost_topic("閒聊");
//			post_infoVO1.setPost_content("人生中有些東西真的用了就回不去，譬如智慧型手機，譬如棉條！\r\n" + 
//					"\r\n" + "\r\n" + 
//					"我真沒想到這麼久沒發文，第一篇居然寫的是棉條啊！\r\n" + 
//					"\r\n" + 
//					"有在追蹤訓練文的朋友會發現，我並沒有因為生理期暫停訓練，畢竟有人問我說，ㄟ...你是不是更年期了，為什麼都沒有因為生理期休息 (繼凍卵以後，現在討論的是更年期了嗎！)\r\n" + 
//					"\r\n" + 
//					"每個女生身體狀況不太一樣，有些女生生理期時真的很虛弱，動一下就會痛，那課表就休息可能比較好，運動就是為了健康，為了課表執行把自己弄得超不舒服，就失去運動的意義啦\r\n" + 
//					"\r\n" + 
//					"我的話，大概就是初期幾天比較虛弱，不過也沒有虛弱到完全不能動的地步，所以如果我想運動，就一樣會去運動，只是不會勉強自己，如果當天狀況不好做不到課表要求，就自動減量這樣，然後安慰自己，我生理期減量應該的！(超軟爛心態)\r\n" + 
//					"\r\n" + 
//					"但有在運動的女生都知道，衛生棉其實是一個不太適合身體有任何動作的東西，這就是為什麼一堆衛生棉品牌都強打什麼有翅膀不側漏，因為它就是一個超級會側漏的東西啊\r\n" + 
//					"\r\n" + 
//					"重點是如果你在跑步時，那些翅膀真的會摩擦到你紅腫破皮，我本人在人生唯一一次全馬那天就體驗過，大家不用再嘗試了\r\n" + 
//					"\r\n" + 
//					"我身邊每一個用過棉條的女生，都跟棉條相見恨晚，覺得再也回不去了\r\n" + 
//					"\r\n" + 
//					"棉條真的太方便了，不用擔心側漏，不用擔心動來動去，衛生棉擠壓變形，又還你一個乾爽的屁屁\r\n" + 
//					"\r\n" + 
//					"畢竟使用衛生棉時，屁屁一直悶悶濕濕地，真的不是什麼很舒服的狀態\r\n" + 
//					"\r\n" + 
//					"乾爽的屁屁耶！完全是女生夢寐以求的事，這才是真的怎麼動都不怕！\r\n" + 
//					"\r\n" + 
//					"初次使用棉條的女生，推薦大家先嘗試導管式棉條，很容易上手又不弄髒你的手，雖然不太環保，但真的很方便\r\n" + 
//					"\r\n" + 
//					"我自己最喜歡的品牌其實是台灣買不到的Tampax，照片中最右邊的那一支，別人托朋友去美國代買都買精品、運動用品或營養品，我居然託買棉條，真是對不起朋友\r\n" + 
//					"\r\n" + 
//					"照片中間那支是台灣的自有品牌凱娜，左邊的則是蘇菲，其實都不錯，凱娜比較適合我，但有朋友則是比較適合蘇菲\r\n" + 
//					"\r\n" + 
//					"台灣現在棉條品牌比以前多啦，大家可以都嘗試看看，試試哪個牌子比較適合你\r\n" + 
//					"\r\n" + 
//					"我真的超推薦身邊女生嘗試棉條的，會開啟人生的另一種可能，發現生理期原來也可以這麼自在，把這篇文送給我身邊的女生朋友，還有想要對女孩更貼心的男生朋友\r\n" + 
//					"\r\n" );
//			post_infoVO1.setPost_date(java.sql.Timestamp.valueOf("2018-12-08 12:58:00"));
//			dao.insert(post_infoVO1);
			
			//修改
//			Post_infoVO post_infoVO2 = new Post_infoVO();
//			post_infoVO2.setPost_no("P0001");
//			post_infoVO2.setClub_no("C0001");
//			post_infoVO2.setMem_no("M003");
//			post_infoVO2.setPost_topic("飲食營養");
//			post_infoVO2.setPost_content("【飲食補給】你吃對了嗎？ 運動的燃料來源\r\n" + 
//					"人體平常在休息與活動的時候，都需要相對應的能量。這些能量從我們日常攝取的醣類、脂肪、蛋白質而來，這三大類燃料會轉化成各種形式儲存在身體中，當我們運動的時候，就會在體內代謝這些燃料來產生能量。\r\n" + 
//					"碳水化合物\r\n" + 
//					"碳水化合物由碳、氫、氧三種原子所組成，可以提供身體快速獲得的能量形式，1克的醣類約可以產生4大卡的能量。碳水化合物以單醣、雙醣或多醣的形式儲存在體內；最常被提及的單醣就是葡萄糖，是基本的分子；雙醣是由兩個單醣所組成；而多醣則可能是三個單醣組成的小分子，也有可能像肝醣，是數百個甚至數千個葡萄糖分子組成的大分子。\r\n" + 
//					"其中，肝醣是指用來儲存在動物組織中的多醣，儲存於肌肉與肝臟中。運動的時候肌肉細胞會快速分解肝醣成葡萄糖作為肌肉收縮的即時能量來源，肝臟也會分解釋放游離葡萄糖進入血管中，傳送到全身組織。\r\n" + 
//					"對運動所需的能量來說，人體內肝醣的儲存量並不多，可能會在數小時內便消耗殆盡，你也許有過跑馬拉松到後半程突然全身無力，跑也跑不下去的狀況，這種「撞牆」的情形，就是因為體內已無肝醣供應能量，脂肪燃燒又不敷所需。另一方面，也有人為了增進運動表現，而使用所謂的「肝醣超補法」，也就是在比賽前數天先大幅減少碳水化合物的攝取，而後再大量補充，讓身體在短時間內儲備比平常更多的肝醣，但平常若是沒有攝取足夠的醣類食物，會影響體內肝醣的合成，所以對於耐力訓動員來說，平時養成以碳水化合物為主的飲食習慣，對運動時的能量轉換，會有一定程度的幫助。\r\n" + 
//					"\r\n" + 
//					"東方社會的飲食基本上就是以醣類為主，富含醣類的食物有各種水果、米飯、麵食、地瓜、馬鈴薯、芋頭等根莖類。\r\n" + 
//					"\r\n" + 
//					"脂肪\r\n" + 
//					"說也奇妙，脂肪與醣類雖然同樣由碳、氫、氧三大元素組成，但兩者的性質卻有很大差異，脂肪中碳與氧的比例比醣類要大得多，也因此脂肪含有充足的能量，1公克約有9大卡的能量，是醣類或蛋白質的兩倍，是一個良好的能量來源。在長時間的運動中，肝醣消耗完後，也是主要的能量來源。\r\n" + 
//					"運動時，脂肪是以脂肪酸的形式被肌肉利用，產生能量。脂肪酸在體內以三酸甘油脂的型態儲存，脂肪分解後，甘油也可以當作受質來促進肝臟生產葡萄糖。\r\n" + 
//					"富含脂肪的食物有豬油、魚油、酥油、堅果類、芝麻等，要注意的是雖然脂肪的種類很多，但如何選擇「好的脂肪」就很重要，如果你購買食品時會注意包裝上的成分標示，也許會看到反式脂肪、飽和脂肪、不飽和脂肪三個標示；這三種脂肪其實組成的元素都相同，只是化合鍵結的方式不一樣，也因此造成代謝與化學反應的差異，好的脂肪能提供能量、維持正常生理代謝，壞的脂肪則會影響人體代謝，並可能引發慢性疾病。\r\n" + 
//					"反式脂肪對健康有害，是人體不必要的營養素。食用反式脂肪將會提高罹患冠狀動脈病變與心臟病的機率，肝臟也無法代謝反式脂肪，進而產生高血脂或脂肪肝等病症；至於飽和脂肪與不飽和脂肪，各有對身體有益的功能，但若大量食用，身體都難以代謝，而可能引發肥胖或心血管方面的疾病，過猶不及，適量就好。\r\n" + 
//					"\r\n" + 
//					"蛋白質\r\n" + 
//					"蛋白質是由胺基酸的小分子所組成的，人體內至少需要20種不同型態的胺基酸來形成不同的組織、酵素、血蛋白等等。其中九種必須胺基酸，人體無法自行合成，所以必須靠飲食來攝取。\r\n" + 
//					"在運動的時候，主要還是使用醣類與脂肪作為能量來源，除非體內醣類消耗殆盡、脂肪分解不及，否則蛋白質被直接利用的比率相對要少得許多，1公克的蛋白質約有4大卡能量。\r\n" + 
//					"蛋白質既然並非能量主要來源，那它的角色是什麼呢？其實我們的肌肉與組織就是由蛋白質所組成，在訓練或比賽後多少都有消耗、甚至損傷，此時就必須靠蛋白質來修補恢復；另外，你也許有聽過BCAA，一種運動前常攝取的增補劑，它其實是數種組成蛋白質的氨基酸，運動前服用，有助於延緩能量不足或超過負荷時，蛋白質被分解所產生的疲勞現象。\r\n" + 
//					"富含蛋白質的食物有肉類、豆類、蛋類、奶類等，動物性蛋白質通常含有多種氨基酸，而植物性蛋白質通常會缺乏特定的氨基酸，所以素食者要注意蛋白質來源的多樣化，各種豆類和穀類搭配食用，以攝取均衡的營養。\r\n" + 
//					"各位喜愛運動的朋友，可以以平時的運動類型與時間長短，來參考飲食攝取的方向喔！爆發型的運動建議以高醣類食物為主，耐力型的運動除了醣類，還需要脂肪當作能量，而運動完後，攝取足夠的蛋白質以幫助身體修補恢復，不論何種運動，都是必要的。\r\n" + 
//					"\r\n" + 
//					"給身體加加油吧！沒有攝取足夠的能量，是沒有辦法好好運動的！");
//			post_infoVO2.setPost_date(java.sql.Timestamp.valueOf("2018-11-18 12:00:00"));
//			dao.update(post_infoVO2);
			
//			//刪除
//			dao.delete("P0002");
//			
//			
//			//查詢單筆
//			Post_infoVO post_infoVO3 = dao.findByPrimaryKey("P0001");
//			System.out.println(post_infoVO3.getPost_no()+ ",");
//			System.out.println(post_infoVO3.getClub_no()+ ",");
//			System.out.println(post_infoVO3.getMem_no()+ ",");
//			System.out.println(post_infoVO3.getPost_topic()+ ",");
//			System.out.println(post_infoVO3.getPost_content()+ ",");
//			System.out.println(post_infoVO3.getPost_date()+ ",");
//			System.out.println("------------------------------");
//	
//			//查詢多筆
//			List<Post_infoVO> list = dao.getAll();
//			for (Post_infoVO aPost_info : list) {
//			System.out.println(aPost_info.getPost_no()+ ",");
//			System.out.println(aPost_info.getClub_no()+ ",");
//			System.out.println(aPost_info.getMem_no()+ ",");
//			System.out.println(aPost_info.getPost_topic()+ ",");
//			System.out.println(aPost_info.getPost_content()+ ",");
//			System.out.println(aPost_info.getPost_date()+ ",");
//		    System.out.println();
//			}
		}
		
	
	
}
