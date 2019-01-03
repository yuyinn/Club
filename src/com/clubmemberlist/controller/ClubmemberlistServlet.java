package com.clubmemberlist.controller;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
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


import com.clubmemberlist.model.ClubmemberlistService;
import com.clubmemberlist.model.ClubmemberlistVO;

@MultipartConfig(fileSizeThreshold=1024*1024, maxFileSize=5*1024*1024, maxRequestSize=5*5*1024*1024)
public class ClubmemberlistServlet extends HttpServlet{
	private static final long serialVersionUID = 1L;
	
	public ClubmemberlistServlet(){
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
		
if ("getOne_For_Display".equals(action)) { 

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String str = req.getParameter("club_no");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入社團編號");
				}
				
				String str2 = req.getParameter("mem_no");
				if (str2 == null || (str2.trim()).length() == 0) {
					errorMsgs.add("請輸入會員編號");
				}
				
				
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/clubmemberlist/select_page.jsp");
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
							.getRequestDispatcher("/clubmemberlist/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/clubmemberlist/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				/***************************2.開始查詢資料*****************************************/
				ClubmemberlistService clubmemberlistSvc = new ClubmemberlistService();
				ClubmemberlistVO clubmemberlistVO = clubmemberlistSvc.getOneClubmemberlist(club_no);
				if (clubmemberlistVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/post__infoinfo/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				req.setAttribute("clubmemberlistVO", clubmemberlistVO); 
				String url = "/clubmemberlist/listOneClubmemberlist.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); 
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/clubmemberlist/select_page.jsp");
				failureView.forward(req, res);
			}
		}
		
		
if ("getOne_For_Update".equals(action)) { // 來自listAllEmp.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/***************************1.接收請求參數****************************************/
				String club_no = req.getParameter("club_no");
				
				/***************************2.開始查詢資料****************************************/
				ClubmemberlistService clubmemberlistSvc = new ClubmemberlistService();
				ClubmemberlistVO clubmemberlistVO = clubmemberlistSvc.getOneClubmemberlist(club_no);
								
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("clubmemberlistVO", clubmemberlistVO);         // 資料庫取出的empVO物件,存入req
				String url = "/clubmemberlist/update_clubmemberlist_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_emp_input.jsp
				successView.forward(req, res);
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/clubmemberlist/listAllClubmemberlist.jsp");
				failureView.forward(req, res);
			}
		}
		
		
if ("update".equals(action)) { // 來自update_emp_input.jsp的請求
			
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			String requestURL = req.getParameter("requestURL");
		
			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String club_no =req.getParameter("club_no");
				
				String club_no = req.getParameter("club_no");
				String club_noReg = "^[(A-Z0-9_)]{5,7}$";
				if (club_no == null || club_no.trim().length() == 0) {
					errorMsgs.add("社團編號: 請勿空白");
				} else if(!club_no.trim().matches(club_noReg)) { 
					errorMsgs.add("社團編號: 只能是英文字母、數字和_ , 且長度必需在5到7之間");
	            }
				
				String mem_no = req.getParameter("mem_no").trim();
				if (mem_no == null || mem_no.trim().length() == 0) {
					errorMsgs.add("會員編號請勿空白");
				}
				
				String post_topic = req.getParameter("post_topic").trim();
				if (post_topic == null || post_topic.trim().length() == 0) {
					errorMsgs.add("貼文主題請勿空白");
				}	
				

				String post_content = req.getParameter("post_content").trim();
				if (post_content == null || post_content.trim().length() == 0) {
					errorMsgs.add("貼文內容請勿空白");
				}	

				
				
				Timestamp post_date = null;
				try {
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm");
					Date date = sdf.parse(req.getParameter("post_date").trim());
					post_date= new Timestamp(date.getTime());
					
				} catch (IllegalArgumentException e) {
					post_date=new Timestamp(System.currentTimeMillis());
					errorMsgs.add("請輸入時間!");
				}

				ClubmemberlistVO clubmemberlistVO = new ClubmemberlistVO();
				clubmemberlistVO.setPost_no(club_no);
				clubmemberlistVO.setClub_no(club_no);
				clubmemberlistVO.setMem_no(mem_no);
				clubmemberlistVO.setPost_topic(post_topic);
				clubmemberlistVO.setPost_content(post_content);
				clubmemberlistVO.setPost_date(post_date);
				

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("clubmemberlistVO", clubmemberlistVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/clubmemberlist/update_clubmemberlist_input.jsp");
					failureView.forward(req, res);
					return; //程式中斷
				}
				
				/***************************2.開始修改資料*****************************************/
				ClubmemberlistService clubmemberlistSvc = new ClubmemberlistService();
				clubmemberlistVO = clubmemberlistSvc.updateClubmemberlist(club_no, club_no, mem_no, post_topic, post_content,post_date);
				
				/***************************3.修改完成,準備轉交(Send the Success view)*************/

				req.setAttribute("ClubmemberlistVO", clubmemberlistVO);
				String url = requestURL;
				RequestDispatcher successView = req.getRequestDispatcher(url);   // 修改成功後,轉交回送出修改的來源網頁
				successView.forward(req, res);
			

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("front-end/clubmemberlist/update_clubmemberlist_input.jsp");
				failureView.forward(req, res);
			}
		}

if ("insert".equals(action)) { // 來自addEmp.jsp的請求  
			
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
//				String club_no = req.getParameter("club_no").trim();
				
				String club_no = req.getParameter("club_no");
				String club_noReg = "^[(A-Z0-9_)]{5,7}$";
				if (club_no == null || club_no.trim().length() == 0) {
					errorMsgs.add("社團編號: 請勿空白");
				} else if(!club_no.trim().matches(club_noReg)) { 
					errorMsgs.add("社團編號: 只能是英文字母、數字和_ , 且長度必需在5到7之間");
	            }
				
				String mem_no = req.getParameter("mem_no").trim();
				if (mem_no == null || mem_no.trim().length() == 0) {
					errorMsgs.add("會員編號請勿空白");
				}
				
				String post_topic = req.getParameter("post_topic").trim();
				if (post_topic == null || post_topic.trim().length() == 0) {
					errorMsgs.add("貼文主題請勿空白");
				}	
				

				String post_content = req.getParameter("post_content").trim();
				if (post_content == null || post_content.trim().length() == 0) {
					errorMsgs.add("貼文內容請勿空白");
				}	

				
				
				Timestamp post_date = null;
				try {
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm");
					Date date = sdf.parse(req.getParameter("post_date").trim());
					post_date= new Timestamp(date.getTime());
					
				} catch (IllegalArgumentException e) {
					post_date=new Timestamp(System.currentTimeMillis());
					errorMsgs.add("請輸入時間!");
				}

				ClubmemberlistVO clubmemberlistVO = new ClubmemberlistVO();

				clubmemberlistVO.setClub_no(club_no);
				clubmemberlistVO.setMem_no(mem_no);
				clubmemberlistVO.setPost_topic(post_topic);
				clubmemberlistVO.setPost_content(post_content);
				clubmemberlistVO.setPost_date(post_date);
				
				System.out.println(clubmemberlistVO+"test");
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("clubmemberlistVO", clubmemberlistVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/clubmemberlist/clubmemberlist_list.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.開始新增資料***************************************/
				ClubmemberlistService clubmemberlistSvc = new ClubmemberlistService();
				clubmemberlistVO = clubmemberlistSvc.addClubmemberlist(club_no, mem_no, post_topic, post_content,post_date);
				
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
				String url = "/clubmemberlist/clubmemberlist_home.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
				successView.forward(req, res);				
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/clubmemberlist/clubmemberlist_list.jsp");
				failureView.forward(req, res);
			}
		}
		
	}
}

