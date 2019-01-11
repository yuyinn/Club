package com.respones.controller;

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


import com.respones.model.ResponesService;
import com.respones.model.ResponesVO;

@MultipartConfig(fileSizeThreshold=1024*1024, maxFileSize=5*1024*1024, maxRequestSize=5*5*1024*1024)
public class ResponesServlet extends HttpServlet{
	private static final long serialVersionUID = 1L;
	private static final String CLUBPAGE = "/front-end/club/club_page.jsp";
	private static final String POSTPAGE = "/front-end/respones/post_page.jsp";
	
	public ResponesServlet(){
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
				ResponesService responesSvc = new ResponesService();
				
				ResponesVO responesVO = responesSvc.getOneRespones(post_no);
				
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				req.setAttribute("responesVO", responesVO); 
				String url = "/respones/listOneRespones.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); 
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/respones/select_page.jsp");
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
				ResponesService responesSvc = new ResponesService();
				ResponesVO responesVO = responesSvc.getOneRespones(post_no);
								
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("responesVO", responesVO);         // 資料庫取出的empVO物件,存入req
				String url = "/respones/update_respones_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_emp_input.jsp
				successView.forward(req, res);
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/respones/listAllRespones.jsp");
				failureView.forward(req, res);
			}
		}
		
//修改回覆
if ("update".equals(action)) { 
			
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			String requestURL = req.getParameter("requestURL");
		
			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				
				String res_content = req.getParameter("res_content").trim();
				if (res_content == null || res_content.trim().length() == 0) {
					errorMsgs.add("貼文內容請勿空白");
				}	
				
				Timestamp res_date = new Timestamp(System.currentTimeMillis());

				ResponesVO responesVO = new ResponesVO();
				responesVO.setRes_content(res_content);
				responesVO.setRes_date(res_date);
				
				
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher(CLUBPAGE);
					failureView.forward(req, res);
					return;
				}
				/***************************2.開始修改資料*****************************************/
				ResponesService responesSvc = new ResponesService();
				responesVO = responesSvc.updateRespones(res_content,  res_date);
				
				/***************************3.修改完成,準備轉交(Send the Success view)*************/

				req.setAttribute("ResponesVO", responesVO);
				String url = requestURL;
				RequestDispatcher successView = req.getRequestDispatcher(url);   // 修改成功後,轉交回送出修改的來源網頁
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("front-end/respones/update_respones_input.jsp");
				failureView.forward(req, res);
			}
		}

//新增回覆
if ("insert".equals(action)) {
			
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
				String post_no = req.getParameter("post_no");
				
				String mem_no = req.getParameter("mem_no");
				
				
				String res_content = req.getParameter("res_content").trim();
				if (res_content == null || res_content.trim().length() == 0) {
					errorMsgs.add("貼文內容請勿空白");
				}	
				
				Timestamp res_date = new Timestamp(System.currentTimeMillis());
				
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher(CLUBPAGE);
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.開始新增資料***************************************/
				ResponesService responesSvc = new ResponesService();
				ResponesVO responesVO = responesSvc.addRespones(post_no, mem_no, res_content, res_date);
				
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
				req.setAttribute("responesVO", responesVO);
				String url = (POSTPAGE);
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
				successView.forward(req, res);				
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher(CLUBPAGE);
				failureView.forward(req, res);
			}
		}
		
	}
}

