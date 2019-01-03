package com.club.controller;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.club.model.ClubService;
import com.club.model.ClubVO;


@MultipartConfig(fileSizeThreshold=1024*1024, maxFileSize=5*1024*1024, maxRequestSize=5*5*1024*1024)
public class ClubfrontServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	public ClubfrontServlet(){
		super();
	}
	
	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		String actionfront = req.getParameter("actionfront");
		System.out.println(actionfront);
		
if ("getOne_For_Display".equals(actionfront)) { 

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String str = req.getParameter("club_no");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入社團編號");
				}
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("front-end/club/clublist.jsp");
					failureView.forward(req, res);
					return;
				}
				
				String club_no = null;
				try {
					club_no = new String(str);
				} catch (Exception e) {
					errorMsgs.add("社團編號格式不正確");
				}
				
				
				
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("front-end/club/clublist.jsp");
					failureView.forward(req, res);
					return;
				}
				
				
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("front-end/club/clublist.jsp");
					failureView.forward(req, res);
					return;
				}
				/***************************2.開始查詢資料*****************************************/
				ClubService clubSvc = new ClubService();
				ClubVO clubVO = clubSvc.getOneClub(club_no);
				if (clubVO == null) {
					errorMsgs.add("查無資料");
				}
				
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("front-end/club/clublist.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				req.setAttribute("clubVO", clubVO); 
				String url = "front-end/club/listOneClub.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); 
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("front-end/club/select_page.jsp");
				failureView.forward(req, res);
			}
		}
		
		
if ("getOne_For_Update".equals(actionfront)) { 

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/***************************1.接收請求參數****************************************/
				String club_no = req.getParameter("club_no");
				
				/***************************2.開始查詢資料****************************************/
				ClubService clubSvc = new ClubService();
				ClubVO clubVO = clubSvc.getOneClub(club_no);
								
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("clubVO", clubVO);       
				String url = "front-end/club/update_club_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("front-end/club/listAllClub.jsp");
				failureView.forward(req, res);
			}
		}
		
		
if ("update".equals(actionfront)) { // 來自update_emp_input.jsp的請求
			
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			String requestURL = req.getParameter("requestURL");
		
			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String club_no =req.getParameter("club_no");
				
				String sp_no = req.getParameter("sp_no");
				String sp_noReg = "^[(A-Z0-9_)]{5,7}$";
				if (sp_no == null || sp_no.trim().length() == 0) {
					errorMsgs.add("運動項目編號: 請勿空白");
				} else if(!sp_no.trim().matches(sp_noReg)) { //以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("運動項目編號: 只能是英文字母、數字和_ , 且長度必需在5到7之間");
	            }
				
				
				byte[] photo = null;
				Part part = req.getPart("photo");
				if (getFileNameFromPart(part) != null) {
					InputStream in = part.getInputStream();
					photo = new byte[in.available()];
					in.read(photo);
				}else {
					InputStream is = getServletContext().getResourceAsStream("/img/no-image.PNG");
					photo = new byte[is.available()];
					is.read(photo);
					is.close();
				}
				
				
//				byte[] photo = null;
//				Part part = req.getPart("photo");
//				if(getFileNameFromPart(part) != null) {
//					InputStream in = part.getInputStream();
//					photo = new byte[in.available()];
//					in.read(photo);
//				}else {
//					File file = new File("images/C0007.jpg");
//					FileInputStream is = new FileInputStream(file);
//					photo = new byte[is.available()];
//					is.read(photo);
//				}
				
				

				String club_name = req.getParameter("club_name").trim();
				if (club_name == null || club_name.trim().length() == 0) {
					errorMsgs.add("社團名稱請勿空白");
				}	

				String club_intro = req.getParameter("club_intro").trim();
				if (club_intro == null || club_intro.trim().length() == 0) {
					errorMsgs.add("社團簡介請勿空白");
				}	
				
				String photo_ext = req.getParameter("photo_ext").trim();
				String club_status = req.getParameter("cliub_status").trim();
				
				ClubVO clubVO = new ClubVO();
				clubVO.setClub_no(club_no);
				clubVO.setSp_no(sp_no);
				clubVO.setPhoto(photo);
				clubVO.setPhoto_ext(photo_ext);
				clubVO.setClub_status(club_status);
				clubVO.setClub_name(club_name);
				clubVO.setClub_intro(club_intro);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("clubVO", clubVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/club/update_club_input.jsp");
					failureView.forward(req, res);
					return; //程式中斷
				}
				
				/***************************2.開始修改資料*****************************************/
				ClubService clubSvc = new ClubService();
				clubVO = clubSvc.updateClub(club_no, sp_no,photo, photo_ext, club_status, club_name,club_intro);
				
				/***************************3.修改完成,準備轉交(Send the Success view)*************/
				req.setAttribute("ClubVo", clubVO);
				
				String url = requestURL;
				RequestDispatcher successView = req.getRequestDispatcher(url);   // 修改成功後,轉交回送出修改的來源網頁
				successView.forward(req, res);
			

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("front-end/club/update_club_input.jsp");
				failureView.forward(req, res);
			}
		}

if ("insert".equals(actionfront)) { 
	System.out.println("哈囉我在這");
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
//				String club_no = req.getParameter("club_no").trim();
				
				String sp_no = req.getParameter("sport");
				String sp_noReg = "^[(A-Z0-9_)]{5,7}$";
				if (sp_no == null || sp_no.trim().length() == 0) {
					errorMsgs.add("運動項目編號: 請勿空白");
				} else if(!sp_no.trim().matches(sp_noReg)) { //以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("運動項目編號: 只能是英文字母、數字和_ , 且長度必需在5到7之間");
	            }
				
				byte[] photo = null;
				Part part = req.getPart("photo");
				if (getFileNameFromPart(part) != null) {
					InputStream in = part.getInputStream();
					photo = new byte[in.available()];
					in.read(photo);
				}else {
					InputStream is = getServletContext().getResourceAsStream("/img/no-image.PNG");
					photo = new byte[is.available()];
					is.read(photo);
					is.close();
				}
				
				
				String club_status = req.getParameter("club_status").trim();
				if (club_status == null || club_status.trim().length() == 0) {
					errorMsgs.add("社團狀態請勿空白");
				}	
				
				
				String club_name = req.getParameter("club_name").trim();
				if (club_name == null || club_name.trim().length() == 0) {
					errorMsgs.add("社團名稱請勿空白");
				}	
				
				String club_intro = req.getParameter("club_intro").trim();
				if (club_intro == null || club_intro.trim().length() == 0) {
					errorMsgs.add("社團簡介請勿空白");
				}	
				
				String photo_ext = req.getParameter("photo_ext").trim();
				
				
				
				
	
				ClubVO clubVO = new ClubVO();
				clubVO.setSp_no(sp_no);
				clubVO.setPhoto(photo);
				clubVO.setPhoto_ext(photo_ext);
				clubVO.setClub_status(club_status);
				clubVO.setClub_name(club_name);
				clubVO.setClub_intro(club_intro);
				
				
				
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
//					req.setAttribute("clubVO", clubVO);// 含有輸入格式錯誤的empVO物件,也存入req
					
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/club/club_list.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.開始新增資料***************************************/
				ClubService clubSvc = new ClubService();
				clubSvc.addClub(sp_no,photo,photo_ext, club_status, club_name, club_intro);
				
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
				String url = "/front-end/club/club_home.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
				successView.forward(req, res);				
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				e.printStackTrace();
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/club/club_list.jsp");
				failureView.forward(req, res);
			}
		}
		
	}
	

//	public String getFileNameFromPart(Part part) {
//		String header = part.getHeader("content-disposition");
//		System.out.println("header=" + header); // 測試用
//		String filename = new File(header.substring(header.lastIndexOf("=") + 2, header.length() - 1)).getName();
//		System.out.println("filename=" + filename); // 測試用
//		if (filename.length() == 0) {
//			return null;
//		}
//		return filename;
//	}
	public String getFileNameFromPart(Part part) {
		String header = part.getHeader("content-disposition");
//		System.out.println("header=" + header); // 測試用
		String filename = new File(header.substring(header.lastIndexOf("=") + 2, header.length() - 1)).getName();
//		System.out.println("filename=" + filename); // 測試用
		if (filename.length() == 0) {
			return null;
		}
		return filename;
	}
}
