<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.club.model.*"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%
	ClubService clubSvc = new ClubService();
	List<ClubVO> list = clubSvc.getAll();
	pageContext.setAttribute("list", list);
%>

<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
<title>Title Page</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
<!--[if lt IE 9]>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/html5shiv/3.7.3/html5shiv.min.js"></script>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/respond.js/1.4.2/respond.min.js"></script>
		<![endif]-->
<style type="text/css">

.card-img-top {
 	width: 100%; 
 
}

.CARD {  
  	WIDTH: 35rem;
  	padding-left:20px;
  	padding-right:20px;
  	margin-left:20px;
  	margin-right:15px
  	
  }  
 
 .flex{ 
  	display:inline-flex;  
     flex-direction:row; 
    
 } 
	
}
.container{
	background-color:#E6E6FA
}

 #col12{ 
 	padding-left:0px; 
 	padding-right:0px;
 	
 } 
  
</style>


</head>
<body>
<br>



	<div class="container-fulid">
		<ol class="breadcrumb">
			<li>
				<a href="#">首頁</a>
			</li>
			<li class="active">社團列表</li>
		</ol>
	</div>

	<div class="container-fulid">
		<div class="row">

				<div class="col-xs-12 col-lg-2">
					<div class="panel-group" id="accordion2" role="tablist" aria-multiselectable="true">
						<div class="panel panel-default">
							<div class="panel-heading" role="tab" id="panel1">
							<h4 class="panel-title">
							<a href="#aaa" data-parent="#accordion2" data-toggle="collapse" role="button" aria-expanded="true" aria-controls="aaa">
							社團列表
							</a>
								</h4>
								</div>
								<div id="aaa" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="panel1">
								<div class="list-group">
								<a href="#" class="list-group-item">已加入的社團</a>
								<a href="#" class="list-group-item">創建社團</a>
								<a href="#" class="list-group-item">搜尋社團</a>
								</div>
							</div>
						</div>
					</div>
				</div>

				<div class="col-xs-12 col-lg-9">

			    		<c:forEach var="clubVO" items="${list}">
			    		

								<div class="col-xs-12 col-sm-4">
									<div class="row">
										<div class="card" >
											<img class="img-responsive"  width="600" height="auto" class="card-img-top" src="<%=request.getContextPath()%>/clubImg.do?club_no=${clubVO.club_no}">
											<div class="card-body">
												<h4 class="card-title">${clubVO.club_name}</h4>
												<p class="card-text">${clubVO.club_intro}</p>
												<a href="#" class="btn btn-primary">加入</a>
											</div>
										</div>
									</div>
								</div>

						</c:forEach>

		</div>
	</div>

	<script src="https://code.jquery.com/jquery.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>