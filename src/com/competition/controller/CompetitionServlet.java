package com.competition.controller;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
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
import com.competition.model.CompetitionService;
import com.competition.model.CompetitionVO;

@MultipartConfig
public class CompetitionServlet extends HttpServlet{
	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);
	}
	
	public void doPost(HttpServletRequest req, HttpServletResponse res, String comp_startdateStr)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
if ("getOne_For_Display".equals(action)) {
			
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String str = req.getParameter("comp_no");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入賽事編號");
				}
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("back-end/competition/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				String comp_no = null;
				try {
					comp_no = new String(str);
				} catch (Exception e) {
					errorMsgs.add("賽事編號格式不正確");
				}
				
				
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("back-end/competition/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("back-end/competition/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
			
				/***************************2.開始查詢資料*****************************************/
				CompetitionService competitionSvc = new CompetitionService();
				CompetitionVO competitionVO = competitionSvc.getOneCompetition(comp_no);
				if (competitionVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("back-end/competition/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				req.setAttribute("competitionVO", competitionVO); // 資料庫取出的empVO物件,存入req
				String url = "back-end/competition/listOneCompetition.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneEmp.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("back-end/competition/select_page.jsp");
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
			String comp_no = req.getParameter("comp_no");
			
			/***************************2.開始查詢資料****************************************/
			CompetitionService competitionSvc = new CompetitionService();
			CompetitionVO competitionVO = competitionSvc.getOneCompetition(comp_no);
							
			/***************************3.查詢完成,準備轉交(Send the Success view)************/
			req.setAttribute("competitionVO", competitionVO);         // 資料庫取出的empVO物件,存入req
			String url = "back-end/competition/update_competition_input.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_emp_input.jsp
			successView.forward(req, res);
			/***************************其他可能的錯誤處理**********************************/
		} catch (Exception e) {
			errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
			RequestDispatcher failureView = req
					.getRequestDispatcher("back-end/competition/listAllEmp.jsp");
			failureView.forward(req, res);
		}
	}
	

if ("update".equals(action)) { // 來自update_emp_input.jsp的請求
	
		List<String> errorMsgs = new LinkedList<String>();
		req.setAttribute("errorMsgs", errorMsgs);
		try {
			/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
			String comp_no =req.getParameter("comp_no");			
			
			String comp_name = req.getParameter("comp_name").trim();
			if (comp_name == null || comp_name.trim().length() == 0) {
				errorMsgs.add("賽事名稱請勿空白");
			}
			
//*			java.sql.Date comp_startdate = null;
//			try {
//				comp_startdate = java.sql.Date.valueOf(req.getParameter("comp_startdate").trim());
//			} catch (IllegalArgumentException e) {
//				comp_startdate=new java.sql.Date(System.currentTimeMillis());
//				errorMsgs.add("請輸入賽事開始日期!");
//			}
//			
//			java.sql.Timestamp dToTimestamp = new java.sql.Timestamp(new java.util.Date().getTime()); 
//		 	java.util.Date tspToDate = new java.util.Date(new java.sql.Timestamp(System.currentTimeMillis()).getTime());
			
			java.sql.Date comp_startdate = null;
			java.sql.Timestamp cs = new java.sql.Timestamp(new java.sql.Date(System.currentTimeMillis()).getTime());
			
			
			
			
			String comp_cont = req.getParameter("comp_cont").trim();
			if (comp_cont == null || comp_cont.trim().length() == 0) {
				errorMsgs.add("賽事簡章請勿空白");
			}	
			

			CompetitionVO competitionVO = new CompetitionVO();
			competitionVO.setComp_no(comp_no);
			competitionVO.setComp_name(comp_name);
			competitionVO.setComp_startdate(comp_startdate);
			competitionVO.setComp_enddate(comp_enddate);
			competitionVO.setComp_cont(comp_cont);
			// Send the use back to the form, if there were errors
			if (!errorMsgs.isEmpty()) {
				req.setAttribute("competitionVO", competitionVO); // 含有輸入格式錯誤的empVO物件,也存入req
				RequestDispatcher failureView = req
						.getRequestDispatcher("back-end/competition/update_competition_input.jsp");
				failureView.forward(req, res);
				return; //程式中斷
			}
			
			/***************************2.開始修改資料*****************************************/
			CompetitionService competitionSvc = new CompetitionService();
			competitionVO = competitionSvc.updateCompetition(comp_no, comp_name,comp_startdate, comp_enddate, comp_cont);
			
			/***************************3.修改完成,準備轉交(Send the Success view)*************/
			req.setAttribute("competitionVO", competitionVO); // 資料庫update成功後,正確的的empVO物件,存入req
			String url = "back-end/competition/listOnecompetition.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneEmp.jsp
			successView.forward(req, res);

			/***************************其他可能的錯誤處理*************************************/
		} catch (Exception e) {
			errorMsgs.add("修改資料失敗:"+e.getMessage());
			RequestDispatcher failureView = req
					.getRequestDispatcher("back-end/competition/update_competition_input.jsp");
			failureView.forward(req, res);
		}
	}


if ("insert".equals(action)) { // 來自addEmp.jsp的請求  
	
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

	try {
		/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
		
		String comp_name = req.getParameter("comp_name");
		if (comp_name == null || comp_name.trim().length() == 0) {
			errorMsgs.add("賽事名稱請勿空白");
		}
		
//*			java.sql.Date comp_startdate = null;
//		try {
//			comp_startdate = java.sql.Date.valueOf(req.getParameter("comp_startdate").trim());
//		} catch (IllegalArgumentException e) {
//			comp_startdate=new java.sql.Date(System.currentTimeMillis());
//			errorMsgs.add("請輸入賽事開始日期!");
//		}
		
		Timestamp comp_startdate = new Timestamp(System.currentTimeMillis());  
		String csStr = "";  
		DateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");  
		comp_startdateStr = null;
		try {  
		csStr = sdf.format(comp_startdate);  
		System.out.println(csStr);
		} catch (Exception e) {  
		    errorMsgs.add("請輸入賽事開始時間");
		} 
		
		
		
		Timestamp comp_enddate = new Timestamp(System.currentTimeMillis());  
		String ceStr = "";  
		DateFormat sdf2 = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");  
		comp_enddate = null;
		try {  
		ceStr = sdf2.format(comp_enddate);  
		System.out.println(ceStr);
		} catch (Exception e) {  
		    errorMsgs.add("請輸入賽事開始時間");
		} 
		
		
		String comp_cont = req.getParameter("comp_cont").trim();
		if (comp_cont == null || comp_cont.trim().length() == 0) {
			errorMsgs.add("賽事簡章請勿空白");
		}	
		

		CompetitionVO competitionVO = new CompetitionVO();
		competitionVO.setComp_name(comp_name);
		competitionVO.setComp_startdate(comp_startdate);
		competitionVO.setComp_enddate(comp_enddate);
		competitionVO.setComp_cont(comp_cont);
		// Send the use back to the form, if there were errors
		if (!errorMsgs.isEmpty()) {
			req.setAttribute("competitionVO", competitionVO); // 含有輸入格式錯誤的empVO物件,也存入req
			RequestDispatcher failureView = req
					.getRequestDispatcher("back-end/competition/update_competition_input.jsp");
			failureView.forward(req, res);
			return; //程式中斷
		}
		
		/***************************2.開始新增資料***************************************/
		CompetitionService competitionSvc = new CompetitionService();
		competitionVO = competitionSvc.addCompetition(comp_name,comp_startdate, comp_enddate, comp_cont);
		
		/***************************3.新增完成,準備轉交(Send the Success view)***********/
		String url = "back-end/competition/listAllCompetition.jsp";
		RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
		successView.forward(req, res);				
		
		/***************************其他可能的錯誤處理**********************************/
	} catch (Exception e) {
		errorMsgs.add(e.getMessage());
		RequestDispatcher failureView = req
				.getRequestDispatcher("back-end/competition/addCompetition.jsp");
		failureView.forward(req, res);
	}
}

}
	
	
	
	
	}

