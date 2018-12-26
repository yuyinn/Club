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
	width: 100%
}

.card {
	width: 35rem
}
.myflex{
	display:inline-flex
	
}
</style>


</head>
<body>
	<a href="#" class="btn btn-success">創建社團</a>
	<div class="container">
		<div class="row">
			<div class="panel panel-info">
				<div class="panel-heading">
					<h1 class="panel-title">社團列表</h1>
				</div>
				
				<div class="col-xs-12 col-sm-12">
				<br>
				<br>
					<c:forEach var="clubVO" items="${list}">
						<div class="myflex">
							<table class="table table-hover">
								<br>
								<div class="card" >
									<img class="card-img-top"
										src="<%=request.getContextPath()%>/clubImg.do?club_no=${clubVO.club_no} "
										alt="Card image cap">
									<div class="card-body">
										<h4 class="card-title">${clubVO.club_name}</h4>
										<p class="card-text">${clubVO.club_intro}</p>
										<a href="#" class="btn btn-primary">加入</a>
									</div>
								</div>  
							</table>
						</div>
					</c:forEach>
				</div>
			</div>
		</div>
	</div>


	<script src="https://code.jquery.com/jquery.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>