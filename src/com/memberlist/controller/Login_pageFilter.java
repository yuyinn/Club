package com.memberlist.controller;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.memberlist.model.MemberlistVO;

public class Login_pageFilter implements Filter {

	ServletContext context = null;
	public Login_pageFilter() {
	}
	
	public void init(FilterConfig Config) throws ServletException {
		context = Config.getServletContext();
	}

	public void destroy() {
		context = null;
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		chain.doFilter(request, response);

		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse res = (HttpServletResponse) response;
		HttpSession session = req.getSession();
		String mem_no = (String) session.getAttribute("mem_no");
		MemberlistVO memberlistVO = (MemberlistVO) session.getAttribute("MemberlistVO");
		if(mem_no!=null||memberlistVO!=null) {
//			String location = (String)session.getAttribute("location");
//			if(location == null) {
				res.sendRedirect(req.getContextPath()+"/front-end/memberlist/Member_page.jsp");
				return;
//			}
//			res.sendRedirect(location);
//			return;	
		}else {
			chain.doFilter(request, response);
		}
	}


}
