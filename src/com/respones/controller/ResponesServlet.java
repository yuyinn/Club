package com.respones.controller;

import java.io.IOException;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.respones.model.ResponesService;
import com.respones.model.ResponesVO;

@MultipartConfig(fileSizeThreshold=1024*1024, maxFileSize=5*1024*1024, maxRequestSize=5*5*1024*1024)
public class ResponesServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	public ResponesServlet() {
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
		System.out.println(action);
		
		if("update".equals(action)){
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			String requestURL = req.getParameter("requestURL");
			
			
			/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
			String res_no = req.getParameter("res_no");
			
			String post_no = req.getParameter("post_no");
			if(post_no == null || post_no.trim().length() == 0) {
				errorMsgs.add("貼文編號:請勿空白");
			}
			
			String mem_no = req.getParameter("mem_no");
			if(mem_no == null || mem_no.trim().length() == 0) {
				errorMsgs.add("會員編號:請勿空白");
			}
			
			String res_content = req.getParameter("res_content");
			if(res_content == null || res_content.trim().length() == 0) {
				errorMsgs.add("回文內容:請勿空白");
			}
			
			Timestamp res_date = null;
			try {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm");
				Date date = sdf.parse(req.getParameter("res_date").trim());
				res_date= new Timestamp(date.getTime());
				
			} catch (IllegalArgumentException e) {
				res_date=new Timestamp(System.currentTimeMillis());
				errorMsgs.add("請輸入時間!");
			} 
			
			
			ResponesVO responesVO = new ResponesVO();
			responesVO.setRes_no(res_no);
			responesVO.setPost_no(post_no);
			responesVO.setMem_no(mem_no);
			responesVO.setRes_content(res_content);
			responesVO.setRes_date(res_date);
			
			if (!errorMsgs.isEmpty()) {
				req.setAttribute("responesVO", responesVO); 
				RequestDispatcher failureView = req
						.getRequestDispatcher("/respones/update_respones_input.jsp");
				failureView.forward(req, res);
				return; //程式中斷
			}
			
			/***************************2.開始修改資料*****************************************/
			ResponesService responesSvc = new ResponesService();
			responesVO = responesSvc.updateRespones(res_no, post_no, mem_no, res_content, res_date);
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
	
	
	
}
