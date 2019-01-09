<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.club.model.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%
	ClubService clubSvc = new ClubService();
	List<ClubVO> list = clubSvc.getAll();
	pageContext.setAttribute("list", list);
	

	//ClubVO clubVO = (ClubVO)request.getAttribute("clubVO");
	
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
		
			
/* 			#clubphoto{ */
/* 			max-width:600px;  */
/* myimg:expression(onload=function(){  */
/* this.style.width=(this.offsetWidth > 600)?"600px":"auto"}); */
/* 			} */
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
						<a href="<%= request.getContextPath()%>/clubfront.do?actionfront=getOneClubintro&club_no=${clubVO.club_no}" display="none" id="linkBack" class="list-group-item">簡介</a>
						<a href="#" class="list-group-item">成員</a>
<!---建立社團--------------------------------------------------------------------------------->
					<% Object object = request.getAttribute("errorMsgs"); %>
					<% if("insert".equals(request.getParameter("actionfront")) && object != null){
							List<String> errorMsgs = (List<String>)object;%>
							<a class="list-group-item list-group-item-actionfront" data-toggle="modal" data-target="#clubModalLong" 
			 				href="#createclub" role="tab" id="myCreateClud">建立社團</a>
					<% }else {%>
							<a class="list-group-item list-group-item-actionfront" data-toggle="modal" data-target="#clubModalLong" 
			 				href="#createclub" role="tab">建立社團</a>
					<% }%>
<%-- 	<c:if test="${param.actionfront=='insert' && errorMsgs!=null}"> --%>
<!-- 		<a class="list-group-item list-group-item-actionfront" data-toggle="modal" data-target="#clubModalLong" -->
<!-- 		href="#createclub" role="tab" id="myCreateClud">建立社團</a> -->
<%-- 	</c:if> --%>
<%-- 	<c:if test="${!(param.actionfront=='insert' && errorMsgs!=null)}"> --%>
<!-- 		<a class="list-group-item list-group-item-actionfront" data-toggle="modal" data-target="#clubModalLong" -->
<!-- 		href="#createclub" role="tab" >建立社團</a> -->
<%-- 	</c:if> --%>
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
								
							<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/clubfront.do" name="form1" enctype='multipart/form-data'>
							
								<div class="modal-body ">
								<br> <br>
									<div class="form-group">
										<img src="/CA105G1/img/no-image.PNG" id="photo" > 
										<input type="file" id="photo" name="photo" ><br>
									</div>
								<br>
								<br>
									<div class="form-group">
										<label class="club_name">社團名稱</label>
										<input type="text" name="club_name" id="club_name" class="form-control" >
									</div>
								<br>
								<br>
						<jsp:useBean id="sportSvc" scope="page" class="com.sport.model.SportService" />
									<div class="form-group">
									<label class="sport">運動項目</label> 
										<select name="sport" id="sport" class="form-control">
								<c:forEach var="sportVO" items="${sportSvc.all}">
										<option value="${sportVO.sp_no}" ${(clubVO.sp_no==sportVO.sp_no)?'selected':'' }>${sportVO.sp_name}
								</c:forEach>
										</select>
									</div>
								<br>
								<br>
									<div class="form-group">
									<label class="club_intro">社團簡介</label>
										<textarea name="club_intro" id="club_intro" class="form-control" ROWS=10 ></textarea>
									</div>
								<br>
								<br>
									<div class="form-group"  style="display:none" >
									<label class="photo_ext">圖片副檔名</label>
										<textarea name="photo_ext" value="jpg" id="photo_ext" class="form-control" ROWS=10 ></textarea>
									</div>
									<div class="form-group"  style="display:none" >
			<!-- 					<label class="club_status">社團狀態</label> -->
			<!-- 					<textarea name="club_status" value="正常" id="club_status" class="form-control" ROWS=10 ></textarea> -->
									<input type="hidden" name="club_status" value="正常" />
									</div>
								</div>
								
								<div class="modal-footer">
									<input type="hidden" name="actionfront" value="insert">
									<button type="button" class="btn btn-secondary" data-dismiss="modal">關閉</button>
									<button type="submit" class="btn btn-primary">送出</button>
								</div>
							</FORM>
							
							<%-- 錯誤表列 --%>
							<c:if test="${not empty errorMsgs}">
								<font style="color:red">請修正以下錯誤:</font>
							<ul>
							<c:forEach var="message" items="${errorMsgs}">
							<li style="color:red">${message}</li>
							</c:forEach>
							</ul>
							</c:if>
					</div>
				</div>
			</div>
<!---Modal------------------------------------------------------------------------------------>
<!---建立社團-----------------------------------------------------------------------------建立社團--->
				<a href="#" class="list-group-item">文章列表</a>
				<a href="#" class="list-group-item">影音相簿</a>
				<a href="#" class="list-group-item">社團管理</a>
				<a href="<%= request.getContextPath()%>/front-end/club/club_list.jsp" display="none" id="linkBack" class="list-group-item">返回列表</a>
				<br>
				<button type="button" class="btn btn-dark" href="<%= request.getContextPath()%>/clubmemberlist.do?action=dropoutclub&club_no=${clubVO.club_no}">
					退出社團
				</button>
				<br><br>
				
					</div>					
					</div>
				<div class="col-xs-12 col-sm-7">

					<table class="table table-hover">
						<thead>
  							<tr>
  								<th>社團加入申請</th>
  							</tr>
  						</thead>
  						<tbody>
	    					<tr>
	      						<td>會員名稱</td>
	      						<td>
	      							<input type="hidden" name="club_no" value="<%=request.getAttribute("club_no")%>"/>
	      							<input type="hidden" name="mem_no" value="${clubmemberlistVO.mem_no}"/>
	      							<button class="btn btn-primary" type="submit" name="action" value="addintoclub">加入</button>
	      						</td>
	      						<td>
	      							<button class="btn btn-primary" type="submit" name="action" value="dropoutclub">拒絕</button>
	      						</td>
	    					</tr>
  						</tbody>
					</table>

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