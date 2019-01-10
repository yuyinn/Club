<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.club.model.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%
ClubVO clubVO = (ClubVO)request.getAttribute("clubVO");
%>


<html >
	<head>
	 	<meta name="viewport" content="width=device-width, initial-scale=1">
    	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
   		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
		<title>Title Page</title>
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
		<!--[if lt IE 9]>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/html5shiv/3.7.3/html5shiv.min.js"></script>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/respond.js/1.4.2/respond.min.js"></script>
		<![endif]-->
		<style type="text/css">
			
			textarea {
  			resize : none; 
			}

			.modal-footer{
			display:flex;
   			align-items:center;
    		justify-content:center; 
			}
			
			#club_name{
			font-family:Microsoft JhengHei
			}
		</style>
	</head>

	<!--data-toggle="collapse" href="#collapseExample" aria-expanded="false" aria-controls="collapseExample" -->

	<body>
	
	<%@ include file="/front-end/CA105G1_header.file" %>
		<div class="container-fluid">
			<div class="row">
				<div class="col-xs-12 col-lg-2" id="xx1">
					
				</div>
				
					<div class="col-xs-12 col-sm-1" style="margin-right: -;padding-left: 5px;padding-right: 5px;">
					<input type="hidden" name="actionfront" value="getoneclub">
					<h4 id="club_name" class="_19s-" >
					<a href='<%=request.getContextPath()%>/clubfront.do?actionfront=getOneClub&club_no=${clubVO.club_no}' >
						${clubVO.club_name}
					</a>
					</h4>

						<div class="list-group active">
							<a href="#" class="list-group-item">簡介</a>
							<a href="#" class="list-group-item">專屬揪團</a>
							<a href="#" class="list-group-item">建立文章</a>
							<a href="#" class="list-group-item">影音相簿</a>
							<a href="#" class="list-group-item">社團管理</a>
							<a href="<%= request.getContextPath()%>/front-end/club/club_list.jsp" display="none" id="linkBack" class="list-group-item">返回列表</a>
					<br>
							<button type="button" class="btn btn-dark">退出社團</button>
					<br><br>
						</div>					
					</div>
				<div class="col-xs-12 col-sm-7">
					<br>

<%

//   ClubService clubService = new ClubService();
// //   clubVO = clubService.getOneClub("C0001");

// String club_intro = request.getParameter("club_intro");
// clubVO = clubService.getOneClub(request.getParameter("club_no"));

   System.out.print(clubVO);
%>
<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/clubfront.do" name="form2">
<%-- 				<jsp:useBean id="clubSvc" scope="page" class="com.club.model.ClubService" /> --%>
					<div class="card text-center" id="post">
						<h3 class="card-title">關於這個社團</h3>
  							<div class="card-body">
  								<p><%=clubVO.getClub_intro() %></p>
  							</div>
					</div>
</FORM>
				</div>
				<div class="col-xs-12 col-lg-2" id="xx">
					<!-- XXXXXXXXXXXX -->
<!-- 					<div>XXXXXXXXXXXXXXXX</div> -->
				</div>
			</div>
		</div>
		



		
		
		</form>
		<%@ include file="/front-end/CA105G1_footer.file" %>
		<script src="https://code.jquery.com/jquery.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
	</body>
</html>