<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.club.model.*"%>
<%@ page import="com.sport.model.*"%>
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
<style type="text/css">
			
			textarea {
  			resize : none; 
			}

			.modal-footer{
			display:flex;
   			align-items:center;
    		justify-content:center; 
			}
		</style>
	</head>

	<!--data-toggle="collapse" href="#collapseExample" aria-expanded="false" aria-controls="collapseExample" -->

	<body>
	
	<%@ include file="/front-end/CA105G1_header.file" %>
		<div class="container-fluid">
			<div class="row">
				<div class="col-xs-12 col-lg-2">
					<div class="list-group active">
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
				<a href="#" class="list-group-item">社團管理</a>
				<a href="#" class="list-group-item">影音相簿</a>
				<a href="#" class="list-group-item">文章</a>
				<a href="<%= request.getContextPath()%>/front-end/club/club_list.jsp" display="none" id="linkBack">回到社團列表</a>
					</div>
				</div>
				<div class="card" >
			<div>
				<img class="img-responsive card-img-top" src="https://api.fnkr.net/testimg/350x200/00CED1/FFF/?text=img+placeholder" width="10%">
			</div>
			<jsp:useBean id="memberlistSvc" scope="page" class="com.memberlist.model.memberlistService" />
		<div class="card-body">
				<h4 class="card-title" name="mem_name" id="mem_name">
					<c:forEach var="memberlistVO" items="${memberlistSvc.all}">
							<option value="${memberlistVO.sp_no}" ${(clubmemberlistVO.mem_no==memberlistVO.mem_no)?'selected':'' }>${memberlistVO.mem_name}
					</c:forEach>
				</h4>
			<div class="row" >
				<a href='<%=request.getContextPath()%>/front-end/club/listOneClub.jsp' class="btn btn-primary">加入</a>
				<a href='<%=request.getContextPath()%>/front-end/club/listOneClub.jsp' class="btn btn-primary">拒絕</a>
			</div>
			<br>
			<br>
		</div>
</div>
			</div>
		</div>
		



		
		
		</form>
		<%@ include file="/front-end/CA105G1_footer.file" %>
	<script src="https://code.jquery.com/jquery.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
	
</script> 
	
	
</body>
</html>