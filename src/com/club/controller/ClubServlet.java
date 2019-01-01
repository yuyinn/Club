package com.club.controller;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.club.model.ClubService;
import com.club.model.ClubVO;


@MultipartConfig(fileSizeThreshold=1024*1024, maxFileSize=5*1024*1024, maxRequestSize=5*5*1024*1024)
public class ClubServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	public ClubServlet(){
		super();
	}
	
	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
if ("getOne_For_Display".equals(action)) { // 來自select_page.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String str = req.getParameter("club_no");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入社團編號");
				}
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("front-end/club/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				String club_no = null;
				try {
					club_no = new String(str);
				} catch (Exception e) {
					errorMsgs.add("社團編號格式不正確");
				}
				
				
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("front-end/club/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("front-end/club/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				/***************************2.開始查詢資料*****************************************/
				ClubService clubSvc = new ClubService();
				ClubVO clubVO = clubSvc.getOneClub(club_no);
				if (clubVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("front-end/club/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				req.setAttribute("clubVO", clubVO); // 資料庫取出的empVO物件,存入req
				String url = "front-end/club/listOneClub.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneEmp.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("front-end/club/select_page.jsp");
				failureView.forward(req, res);
			}
		}
		
		
if ("getOne_For_Update".equals(action)) { // 來自listAllEmp.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/***************************1.接收請求參數****************************************/
				String club_no = req.getParameter("club_no");
				
				/***************************2.開始查詢資料****************************************/
				ClubService clubSvc = new ClubService();
				ClubVO clubVO = clubSvc.getOneClub(club_no);
								
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("clubVO", clubVO);         // 資料庫取出的empVO物件,存入req
				String url = "front-end/club/update_club_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_emp_input.jsp
				successView.forward(req, res);
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("front-end/club/listAllClub.jsp");
				failureView.forward(req, res);
			}
		}
		
		
if ("update".equals(action)) { // 來自update_emp_input.jsp的請求
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
		
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
				
				
				Part filePart = req.getPart("photo");
				/***如果沒有修改則回到前一頁****/
				if(filePart.getSubmittedFileName().equals("")||filePart.getSubmittedFileName().trim().length()==0) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("front-end/club/listAllClub.jsp");
					failureView.forward(req, res);
					return; //程式中斷
				}
				InputStream fileContent = filePart.getInputStream();
				byte[] photo = readFully(fileContent);
				
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
				
				
				String photo_ext = req.getParameter("photo_ext").trim();
				if (photo_ext == null || photo_ext.trim().length() == 0) {
					errorMsgs.add("照片副檔名請勿空白");
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
							.getRequestDispatcher("front-end/club/update_club_input.jsp");
					failureView.forward(req, res);
					return; //程式中斷
				}
				
				/***************************2.開始修改資料*****************************************/
				ClubService clubSvc = new ClubService();
				clubVO = clubSvc.updateClub(club_no, sp_no,photo, photo_ext, club_status, club_name,club_intro);
				
				/***************************3.修改完成,準備轉交(Send the Success view)*************/
				req.setAttribute("clubVO", clubVO); // 資料庫update成功後,正確的的empVO物件,存入req
				String url = "front-end/club/listOneClub.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneEmp.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("front-end/club/update_club_input.jsp");
				failureView.forward(req, res);
			}
		}

if ("insert".equals(action)) { // 來自addEmp.jsp的請求  
			
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
//				String club_no = req.getParameter("club_no").trim();
				
				String sp_no = req.getParameter("sp_no");
				String sp_noReg = "^[(A-Z0-9_)]{5,7}$";
				if (sp_no == null || sp_no.trim().length() == 0) {
					errorMsgs.add("運動項目編號: 請勿空白");
				} else if(!sp_no.trim().matches(sp_noReg)) { //以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("運動項目編號: 只能是英文字母、數字和_ , 且長度必需在5到7之間");
	            }
				
				Part filePart = req.getPart("photo");
				if(filePart.getSubmittedFileName().equals("")||filePart.getSubmittedFileName().trim().length()==0) {
					errorMsgs.add("照片請勿空白");
				}
				InputStream fileContent = filePart.getInputStream();
				byte[] photo = readFully(fileContent);
				
				String photo_ext = req.getParameter("photo_ext").trim();
				if (photo_ext == null || photo_ext.trim().length() == 0) {
					errorMsgs.add("照片副檔名請勿空白");
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

				ClubVO clubVO = new ClubVO();
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
							.getRequestDispatcher("front-end/club/addClub.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.開始新增資料***************************************/
				ClubService clubSvc = new ClubService();
				clubVO = clubSvc.addClub(sp_no,photo,photo_ext, club_status, club_name, club_intro);
				
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
				String url = "front-end/club/listAllClub.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
				successView.forward(req, res);				
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("front-end/club/addClub.jsp");
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
	public static byte[] readFully(InputStream input) throws IOException
	{
		byte[] buffer = new byte[8192];
		int bytesRead;
		ByteArrayOutputStream output = new ByteArrayOutputStream();
		while ((bytesRead = input.read(buffer)) != -1){
			output.write(buffer,0,bytesRead);
		}
		return output.toByteArray();
	}
}
