package com.post_info.controller;

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


import com.post_info.model.Post_infoService;
import com.post_info.model.Post_infoVO;

@MultipartConfig(fileSizeThreshold=1024*1024, maxFileSize=5*1024*1024, maxRequestSize=5*5*1024*1024)
public class Post_infoServlet extends HttpServlet{
	private static final long serialVersionUID = 1L;
	
	public Post_infoServlet(){
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
				String post_no = req.getParameter("post_no");
				
				
				/***************************2.開始查詢資料*****************************************/
				Post_infoService post_infoSvc = new Post_infoService();
				
				Post_infoVO post_infoVO = post_infoSvc.getOnePost_info(post_no);
				
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				req.setAttribute("post_infoVO", post_infoVO); 
				String url = "/post_info/listOnePost_info.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); 
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/post_info/select_page.jsp");
				failureView.forward(req, res);
			}
		}
		
		
if ("getOne_For_Update".equals(action)) { // 來自listAllEmp.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/***************************1.接收請求參數****************************************/
				String post_no = req.getParameter("post_no");
				
				/***************************2.開始查詢資料****************************************/
				Post_infoService post_infoSvc = new Post_infoService();
				Post_infoVO post_infoVO = post_infoSvc.getOnePost_info(post_no);
								
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("post_infoVO", post_infoVO);         // 資料庫取出的empVO物件,存入req
				String url = "/post_info/update_post_info_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_emp_input.jsp
				successView.forward(req, res);
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/post_info/listAllPost_info.jsp");
				failureView.forward(req, res);
			}
		}
		
//修改貼文	
if ("update".equals(action)) { 
			
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			String requestURL = req.getParameter("requestURL");
		
			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				
				String post_topic = req.getParameter("post_topic").trim();
				if (post_topic == null || post_topic.trim().length() == 0) {
					errorMsgs.add("貼文主題請勿空白");
				}	

				String post_content = req.getParameter("post_content").trim();
				if (post_content == null || post_content.trim().length() == 0) {
					errorMsgs.add("貼文內容請勿空白");
				}	

				Post_infoVO post_infoVO = new Post_infoVO();
				post_infoVO.setPost_topic(post_topic);
				post_infoVO.setPost_content(post_content);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("post_infoVO", post_infoVO); 
					RequestDispatcher failureView = req
							.getRequestDispatcher("/post_info/update_post_info_input.jsp");
					failureView.forward(req, res);
					return; //程式中斷
				}
				/***************************2.開始修改資料*****************************************/
				Post_infoService post_infoSvc = new Post_infoService();
				post_infoVO = post_infoSvc.updatePost_info(post_topic, post_content);
				
				/***************************3.修改完成,準備轉交(Send the Success view)*************/

				req.setAttribute("Post_infoVO", post_infoVO);
				String url = requestURL;
				RequestDispatcher successView = req.getRequestDispatcher(url);   // 修改成功後,轉交回送出修改的來源網頁
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("front-end/post_info/update_post_info_input.jsp");
				failureView.forward(req, res);
			}
		}

//新增貼文
if ("insert".equals(action)) {
			
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
				String club_no = req.getParameter("club_no");
				String mem_no = req.getParameter("mem_no").trim();
				
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

				Post_infoVO post_infoVO = new Post_infoVO();

				post_infoVO.setClub_no(club_no);
				post_infoVO.setMem_no(mem_no);
				post_infoVO.setPost_topic(post_topic);
				post_infoVO.setPost_content(post_content);
				post_infoVO.setPost_date(post_date);
				
				System.out.println(post_infoVO+"test");
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("post_infoVO", post_infoVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/post_info/post_info_list.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.開始新增資料***************************************/
				Post_infoService post_infoSvc = new Post_infoService();
				post_infoVO = post_infoSvc.addPost_info(club_no, mem_no, post_topic, post_content,post_date);
				
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
				String url = "/post_info/post_info_home.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
				successView.forward(req, res);				
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/post_info/post_info_list.jsp");
				failureView.forward(req, res);
			}
		}
		
	}
}

