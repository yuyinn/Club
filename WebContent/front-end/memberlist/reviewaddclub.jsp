<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.club.model.*"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%
	ClubService clubSvc = new ClubService();
	List<ClubVO> list = clubSvc.getAll();
	pageContext.setAttribute("list", list);
//  ClubVO clubVO = (ClubVO) request.getAttribute("clubVO");

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

</head>
<body>
<%@ include file="/front-end/club_basic.jsp" %>

<div class="card" >
			<div>
				<img class="img-responsive card-img-top" src="https://api.fnkr.net/testimg/350x200/00CED1/FFF/?text=img+placeholder" width="10%">
			</div>
			<div class="card-body">
				<h4 class="card-title">審核待加入的會員</h4>
				<p class="card-text">會員XXXX</p>
			<div class="row" >
				<a href='<%=request.getContextPath()%>/front-end/club/listOneClub.jsp' class="btn btn-primary">加入</a>
				<a href='<%=request.getContextPath()%>/front-end/club/listOneClub.jsp' class="btn btn-primary">拒絕</a>
			</div>
			<br>
			<br>
			</div>
</div>
	


	<script src="https://code.jquery.com/jquery.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
	
</script> 
	
	
</body>
</html>