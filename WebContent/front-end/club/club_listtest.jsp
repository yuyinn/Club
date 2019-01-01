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
/* .card-text{ */
/* 	height:8rem; */
/* } */
 .card-img-top {  
  	width: 100%; 
 }  

.CARD {  
  	WIDTH: 35rem;
	padding-left:20px; 
	padding-right:20px; 
  	margin-left:20px;
  	margin-right:15px
  	display:flex;
  	
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
/* .img-responsive.card-img-top{ */
/* 	width:300px; */
/* 	height:200px; */
/* } */
</style>


</head>
<body>
<%@ include file="/front-end/CA105G1_header.file" %>
<br>



	<div class="container-fulid">
		<div class="row">
			<div class="col-xs-12 col-lg-2">
				<div class="panel-group" id="accordion2" role="tablist" aria-multiselectable="true">
					<div class="panel panel-default">						
				<div id="aaa" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="panel1">
							<div class="list-group" id="myList" role="tablist">
								<a class="list-group-item list-group-item-action" data-toggle="list" href="#myclub" role="tab">我的社團</a>
<!---建立社團--------------------------------------------------------------------------------->
								<a class="list-group-item list-group-item-action" data-toggle="modal" data-target="#clubModalLong"
								   href="#createclub" role="tab">建立社團</a>
<!---Modal------------------------------------------------------------------------------------>
								<div class="modal fade" id="clubModalLong" tabindex="-1" role="dialog" aria-labelledby="clubModalLongTitle" aria-hidden="true">
									<div class="modal-dialog  .modal-dialog-centered " role="document">
										<div class="modal-content">
											<div class="modal-header">
												<h4 class="modal-title" id="clubModalLongTitle">建立社團</h4>
												<button type="button" class="close" data-dismiss="modal" aria-label="Close">
													<span aria-hidden="true">&times;</span>
												</button>
											</div>
											<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/club.do" name="form1" enctype='multipart/form-data'>
												<div class="modal-body ">
													<br> <br>
													<div class="form-group">
														<img src="/CA105G1/img/no-image.PNG" id="photo" > 
														<input type="file" id="photo" name="photo"><br>
													</div>
													<br> <br>

													<div class="form-group">
														<label class="club_name">社團名稱</label> <input type="text" name="club_name" id="club_name" class="form-control">
													</div>
													<br> <br>
													<jsp:useBean id="sportSvc" scope="page"
														class="com.sport.model.SportService" />
													<div class="form-group">
														<label class="sport">運動項目</label> <select name="sport" id="sport" class="form-control">
															<c:forEach var="sportVO" items="${sportSvc.all}">
																<option value="${sportVO.sp_no}"
																	${(clubVO.sp_no==sportVO.sp_no)?'selected':'' }>${sportVO.sp_name}
															</c:forEach>
														</select>
													</div>
													<br> <br>

													<div class="form-group">
														<label class="club_intro">社團簡介</label>
														<textarea name="club_intro" id="club_intro" class="form-control" ROWS=10></textarea>
													</div>
													<br> <br>
												</div>
												<div class="modal-footer">
													<input type="hidden" name="action" value="insert">
													<button type="button" class="btn btn-secondary" data-dismiss="modal">關閉</button>
													<button type="submit" class="btn btn-primary">送出</button>
												</div>
											</FORM>
										</div>
									</div>
								</div>
<!---Modal------------------------------------------------------------------------------------>
<!---建立社團--------------------------------------------------------------------------------->
								<a class="list-group-item list-group-item-action " data-toggle="list" href="#searchclub" role="tab">搜尋社團</a>
				      	<form method="post" action="<%= request.getContextPath()%>/club/club.do">
				      		<div class="table-responsive">
					      		<table class="table table-hover text-center" align="center">
					      			<thead >
					      			<!-------- 運動種類查詢 --------->
						      			<tr>
						      				<th>運動種類</th>
					      				</tr>
					      				<tr>
						      				<th>
						      					<jsp:useBean id="sportSvc" scope="page" class="com.sport.model.SportService" />
						      					<select size="1" name="sp_no" class="text-center">
						      						<option value="">請選擇運動種類
													<c:forEach var="sportVO" items="${sportSvc.all}" > 
														<option value="${sportVO.sp_no}" ${(clubVO.sp_no==sportVO.sp_no)?'selected':'' } >${sportVO.sp_name}
													</c:forEach>   
												</select>
						      				</th>
						      			</tr>
					      			<!-------- 關鍵字查詢 --------->
						      			<tr>
						      				<th>關鍵字</th>
					      				<tr>
					      				</tr>
						      				<th>
						      					<input name="keyword" id="keyword" type="text" class="text-center" placeholder="請輸入關鍵字">
						      				</th>
						      			</tr>
					      			<!-------- 送出查詢 --------->
						      			<tr>
						      				<input type="hidden" name="action" value="sg_infoCompositeQuery">
						      				<td><input type="submit" value="送出查詢" class="btn btn-primary"></td>
						      			</tr>
						      			
					      			</thead >
					      		</table>
				      		</div>
				      	</form>
				
							</div>
						</div>
						</div>
					</div>
				</div>
				
				<div class="col-xs-12 col-lg-9">
			    		<c:forEach var="clubVO" items="${list}">
								<div class="col-xs-12 col-sm-4">
										<div class="container_1" style="padding:15px,20px,15px,20px">
										<div class="card" >
											<div>
											<img class="img-responsive card-img-top" src="<%=request.getContextPath()%>/clubImg.do?club_no=${clubVO.club_no}">
											</div>
											<div class="card-body">
												<h4 class="card-title">${clubVO.club_name}</h4>
												<p class="card-text">${clubVO.club_intro}</p>
												<div class="row" >
												<a href="#" class="btn btn-primary">加入</a>
												</div>
												<br> <br>
											</div>
										</div>
									</div>
								</div>
						</c:forEach>
				</div>
	</div>
<%@ include file="/front-end/CA105G1_footer.file" %>
	<script src="https://code.jquery.com/jquery.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>