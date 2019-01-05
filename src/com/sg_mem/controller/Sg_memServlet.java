package com.sg_mem.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONException;
import org.json.JSONObject;

import com.sg_mem.model.Sg_memService;

public class Sg_memServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Sg_memServlet() {
        super();
    }

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		PrintWriter pw = res.getWriter();
		
System.out.println("11111");
		if("insert".equals(action)) {
			Map<String, String> errorMsg = new LinkedHashMap<String, String>();
			req.setAttribute("errorMsg", errorMsg);
			
			String sg_no = req.getParameter("sg_no");
			String mem_no = req.getParameter("mem_no");
System.out.println("sg_no="+sg_no);
System.out.println("mem_no="+mem_no);
			
			Sg_memService svc = new Sg_memService();
			svc.insertSg_mem(sg_no, mem_no);
			
			JSONObject obj = new JSONObject();
			try {
				obj.put("answer", "OK!");
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			pw.write(obj.toString());
		}
		
		
		
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
