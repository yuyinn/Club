package com.memberlist.controller;

import java.io.IOException;

import javax.servlet.*;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.memberlist.model.*;
import java.util.*;


public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Login() {
        super();
    }

	protected void doGet(HttpServletRequest req, HttpServletResponse res) 
			throws ServletException, IOException {
		doPost(req,res);
	
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) 
			throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		
		/*************接受請求參數**************/
		String account = req.getParameter("account");
		String password = req.getParameter("password");
		String button = req.getParameter("button");
		HttpSession session = req.getSession();
		MemberlistService service = new MemberlistService();
		Map<String,String> errorMsgs = new LinkedHashMap<String,String>();
		req.setAttribute("errorMsgs", errorMsgs);
		/********確定按鈕是登入還是註冊***********/
		/****註冊跳轉****/
		if("register".equals(button)) {
			req.setAttribute("account", account);
			req.setAttribute("password", password);
			String url ="RegisterMem_page.jsp";
			res.sendRedirect(url);
			return;
		}
		/****三次不存在帳號輸入****/
		/****錯誤驗證 帳號密碼是否有空值****/
		if(account==null||(account.trim()).length()==0) {
			res.sendRedirect("RegisterMem_page.jsp");
			return;
		}
		/*************開始查詢資料**************/
		if(errorMsgs.isEmpty()){
			String mem_no = null;
			try{
				mem_no = service.getOneMemByAccount(account);
			}catch(RuntimeException re) {
				System.out.println(re.getMessage());
				log(re.getMessage());
			}
			
			if(mem_no==null) {
				errorMsgs.put("account", "帳號不存在,請重新輸入");
			}
			else {
				/****密碼空白****/
				if(password==null||(password.trim()).length()==0) {
					errorMsgs.put("password","密碼欄位不得空白");
				}else {
					MemberlistVO memberlistVO = service.getOneMem(mem_no);
					if(password.equals(memberlistVO.getMem_pswd())){
						session.setAttribute("mem_no", mem_no);
					}else {
						errorMsgs.put("password","輸入的密碼有誤");
					}
				}
			}
			if(!errorMsgs.isEmpty()) {
				RequestDispatcher error = req.getRequestDispatcher("Login.jsp");
				error.forward(req, res);
			}else {
				session.setAttribute("MemberlistVO", service.getOneMem(mem_no));
				try{
					String location = (String) session.getAttribute("location");
					if(location!=null) {
						session.removeAttribute("location");
						res.sendRedirect(location);
						return;
					}
				}catch(Exception e) {
					e.printStackTrace();
				}
				res.sendRedirect("Member_page.jsp");
			}
		}
	}
}
