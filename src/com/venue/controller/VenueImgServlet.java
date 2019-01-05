package com.venue.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.venue.model.VenueService;

@MultipartConfig(fileSizeThreshold=1024*1024,maxFileSize=5*1024*1024,maxRequestSize=5*5*1024*1024)
public class VenueImgServlet extends HttpServlet {
       
    public VenueImgServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String v_no = request.getParameter("v_no");
		VenueService venueService = new VenueService();
		byte[] photo = venueService.getOneVenue(v_no).getV_photo1();
		
		response.setContentType("image/*");
		response.setContentLength(photo.length);
		ServletOutputStream outputStream = response.getOutputStream();
		outputStream.write(photo);
		outputStream.close();
	}

}
