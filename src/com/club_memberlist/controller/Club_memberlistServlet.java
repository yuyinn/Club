package com.club_memberlist.controller;

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

import com.club_memberlist.model.Club_memberlistService;
import com.club_memberlist.model.Club_memberlistVO;

@MultipartConfig(fileSizeThreshold=1024*1024, maxFileSize=5*1024*1024, maxRequestSize=5*5*1024*1024)
public class Club_memberlistServlet extends HttpServlet{
	private static final long serialVersionUID = 1L;
	
	private static final String REVIEWADDCLUB_PATH = "/front-end/club_memberlist/reviewaddclub.jsp";
	private static final String CLUBLIST_PATH = "/front-end/club/club_list.jsp";
	private static final String CLUBPAGE_PATH = "/front-end/club/club_page.jsp";
	
	
	
	public Club_memberlistServlet(){
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
		System.out.println("Club_memberListServlet--- action : "+action);

//社團成員活動權限
if ("privilege".equals(action)) { 
	
	List<String> errorMsgs = new LinkedList<String>();
	req.setAttribute("errorMsgs", errorMsgs);
	String requestURL = req.getParameter("requestURL");

	try {
		/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
		
		String club_no = req.getParameter("club_no");
		String mem_no =  req.getParameter("mem_no");

		String cmem_status = req.getParameter("cmem_status").trim();
		if ("禁言中".equals(cmem_status)){
			errorMsgs.add("請詢問社團管理員");
			if("待審核".equals(cmem_status)||"已退出".equals(cmem_status)) {
				errorMsgs.add("請加入社團");
			}
		}else{
			cmem_status=null;
			if(cmem_status.trim().length() == 0) {
				errorMsgs.add("社團成員狀態請勿空白");
			}
		}

		String cmem_class = req.getParameter("cmem_class").trim();
		if ("一般成員".equals(cmem_status)){
			errorMsgs.add("您無社團管理權限");
		}
		
		
		Club_memberlistVO club_memberlistVO = new Club_memberlistVO();
		
		club_memberlistVO.setClub_no(club_no);
		club_memberlistVO.setMem_no(mem_no);
		club_memberlistVO.setCmem_status(cmem_status);
		club_memberlistVO.setCmem_class(cmem_class);
		

		// Send the use back to the form, if there were errors
		if (!errorMsgs.isEmpty()) {
			req.setAttribute("club_memberlistVO", club_memberlistVO); 
			RequestDispatcher failureView = req
					.getRequestDispatcher(CLUBPAGE_PATH);
			failureView.forward(req, res);
			return; //程式中斷
		}
		
		/***************************2.開始修改資料*****************************************/
		Club_memberlistService club_memberlistSvc = new Club_memberlistService();
		club_memberlistVO = club_memberlistSvc.privilege(club_no, mem_no, cmem_status, cmem_class);
		
		/***************************3.修改完成,準備轉交(Send the Success view)*************/

		req.setAttribute("Club_memberlistVO", club_memberlistVO);
		String url = requestURL;
		RequestDispatcher successView = req.getRequestDispatcher(url);   // 修改成功後,轉交回送出修改的來源網頁
		successView.forward(req, res);
	

		/***************************其他可能的錯誤處理*************************************/
	} catch (Exception e) {
		errorMsgs.add("修改資料失敗:"+e.getMessage());
		RequestDispatcher failureView = req
				.getRequestDispatcher(CLUBPAGE_PATH);
		failureView.forward(req, res);
	}
}

//加入社團
if ("addintoclub".equals(action)) { 
	
	List<String> errorMsgs = new LinkedList<String>();
	req.setAttribute("errorMsgs", errorMsgs);
	String requestURL = req.getParameter("requestURL");
	try {
		/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
		
		String club_no = req.getParameter("club_no");
		String mem_no = req.getParameter("mem_no");
		
		
		/***************************2.開始修改資料*****************************************/
		Club_memberlistVO club_memberlistVO = new Club_memberlistVO();
		
		club_memberlistVO.setClub_no(club_no);
		club_memberlistVO.setMem_no(mem_no);
		//club_memberlistVO.setCmem_status("一般會員");
		//在這設定初始狀態
		
		Club_memberlistService club_memberlistSvc = new Club_memberlistService();
		club_memberlistVO = club_memberlistSvc.addintoclub(club_no, mem_no);
		
		/***************************3.修改完成,準備轉交(Send the Success view)*************/

		req.setAttribute("Club_memberlistVO", club_memberlistVO);
		String url = requestURL;
		url = url.substring(1,url.length());
		url = url.substring(url.indexOf("/"),url.length());
		System.out.println("url : "+url);
		RequestDispatcher successView = req.getRequestDispatcher(url);   // 修改成功後,轉交回送出修改的來源網頁
		successView.forward(req, res);
	

		/***************************其他可能的錯誤處理*************************************/
	} catch (Exception e) {
		errorMsgs.add("修改資料失敗:"+e.getMessage());
		RequestDispatcher failureView = req
				.getRequestDispatcher(REVIEWADDCLUB_PATH);
		failureView.forward(req, res);
	}
}

//退出社團
if ("dropoutclub".equals(action)) { 
	
	List<String> errorMsgs = new LinkedList<String>();
	req.setAttribute("errorMsgs", errorMsgs);
	String requestURL = req.getParameter("requestURL");

	try {
		/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
		
		String club_no = req.getParameter("club_no");
		String mem_no = req.getParameter("mem_no");
		String cmem_status = req.getParameter("cmem_status");
		
	
		Club_memberlistVO club_memberlistVO = new Club_memberlistVO();
		
		club_memberlistVO.setClub_no(club_no);
		club_memberlistVO.setMem_no(mem_no);
		club_memberlistVO.setCmem_status(cmem_status);
		

		// Send the use back to the form, if there were errors
		if (!errorMsgs.isEmpty()) {
			req.setAttribute("club_memberlistVO", club_memberlistVO); 
			RequestDispatcher failureView = req
					.getRequestDispatcher(CLUBLIST_PATH);
			failureView.forward(req, res);
			return; //程式中斷
		}
		
		/***************************2.開始修改資料*****************************************/
		Club_memberlistService club_memberlistSvc = new Club_memberlistService();
		club_memberlistVO = club_memberlistSvc.addintoclub(club_no, mem_no);
		
		/***************************3.修改完成,準備轉交(Send the Success view)*************/

		req.setAttribute("Club_memberlistVO", club_memberlistVO);
		String url = requestURL;
		RequestDispatcher successView = req.getRequestDispatcher(url);   // 修改成功後,轉交回送出修改的來源網頁
		successView.forward(req, res);
	

		/***************************其他可能的錯誤處理*************************************/
	} catch (Exception e) {
		errorMsgs.add("修改資料失敗:"+e.getMessage());
		RequestDispatcher failureView = req
				.getRequestDispatcher(CLUBLIST_PATH);
		failureView.forward(req, res);
	}
}
//顯示社團成員列表
if ("cmem_list".equals(action)) { 
	
	List<String> errorMsgs = new LinkedList<String>();
	req.setAttribute("errorMsgs", errorMsgs);
	String requestURL = req.getParameter("requestURL");

	try {
		/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
		
		String club_no = req.getParameter("club_no");
		String mem_no =  req.getParameter("mem_no");
		
		
		Club_memberlistVO club_memberlistVO = new Club_memberlistVO();
		
		club_memberlistVO.setClub_no(club_no);
		club_memberlistVO.setMem_no(mem_no);
		
		/***************************2.開始修改資料*****************************************/
		Club_memberlistService club_memberlistSvc = new Club_memberlistService();
		club_memberlistVO = club_memberlistSvc.getOneClubmemberlist(club_no, mem_no);
		
		/***************************3.修改完成,準備轉交(Send the Success view)*************/

		req.setAttribute("Club_memberlistVO", club_memberlistVO);
		String url = requestURL;
		RequestDispatcher successView = req.getRequestDispatcher(url);   // 修改成功後,轉交回送出修改的來源網頁
		successView.forward(req, res);
	
		/***************************其他可能的錯誤處理*************************************/
	} catch (Exception e) {
		errorMsgs.add("修改資料失敗:"+e.getMessage());
		RequestDispatcher failureView = req
				.getRequestDispatcher(CLUBPAGE_PATH);
		failureView.forward(req, res);
	}
}


if ("Clubmemberlist_CompositeQuery".equals(action)) { // 來自select_page.jsp的複合查詢請求
	List<String> errorMsgs = new LinkedList<String>();
	// Store this set in the request scope, in case we need to
	// send the ErrorPage view.
	req.setAttribute("errorMsgs", errorMsgs);

	try {
		
		/***************************1.將輸入資料轉為Map**********************************/ 
		//採用Map<String,String[]> getParameterMap()的方法 
		//注意:an immutable java.util.Map 
		Map<String, String[]> map = req.getParameterMap();
		
		/***************************2.開始複合查詢***************************************/
		Club_memberlistService club_memberlistSvc = new Club_memberlistService();
		List<Club_memberlistVO> list  = club_memberlistSvc.getAll(map);
		
		/***************************3.查詢完成,準備轉交(Send the Success view)************/
		req.setAttribute("listClubmemberlist_ByCompositeQuery", list); // 資料庫取出的list物件,存入request
		RequestDispatcher successView = req.getRequestDispatcher("/club_memberlistSvc/ClubmemberlistQuery_Clubmemberlist.jsp"); // 成功轉交listEmps_ByCompositeQuery.jsp
		successView.forward(req, res);
		
		/***************************其他可能的錯誤處理**********************************/
	} catch (Exception e) {
		errorMsgs.add(e.getMessage());
		RequestDispatcher failureView = req
				.getRequestDispatcher("/select_page.jsp");
		failureView.forward(req, res);
	}
}

		
	}
}

