<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.club.model.*"%>
<%@ page import="com.post_info.model.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%
	Post_infoService post_infoSvc = new Post_infoService();
	List<Post_infoVO> list = post_infoSvc.getAll();
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
		<script src="https://cdn.ckeditor.com/ckeditor5/11.2.0/classic/ckeditor.js"></script>
		
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
		
			#postsearch{
    			padding-left: 5px;
    			padding-right: 5px;
    			padding-top: 2px;
    			padding-bottom: 2px;
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
						<a href="<%= request.getContextPath()%>/clubfront.do?actionfront=getOneClubintro&club_no=${clubVO.club_no}" display="none" class="list-group-item">簡介</a>
						<a href="#" class="list-group-item">專屬揪團</a>
						<!---建立貼文------------------------------------------------------------------建立貼文------>
	<% Object object = request.getAttribute("errorMsgs"); %>
		<% if("insert".equals(request.getParameter("action")) && object != null){
			List<String> errorMsgs = (List<String>)object;%>
						<a class="list-group-item list-group-item-action" data-toggle="modal" data-target="#post_infoModalLong" 
			   			   href="#createpost" role="tab" id="myCreatePost">建立貼文</a>
		<%}else {%>
						<a class="list-group-item list-group-item-action" data-toggle="modal" data-target="#post_infoModalLong" 
			               href="#createpost" role="tab">建立貼文</a>
	 	<% }%> 
<!---Modal------------------------------------------------------------------------------------>
<div class="modal fade" id="post_infoModalLong" tabindex="-1" role="dialog" aria-labelledby="post_infoModalLongTitle" aria-hidden="true">
	<div class="modal-dialog  .modal-dialog-centered " role="document">
		<div class="modal-content">
		
				<div class="modal-header">
					<h4 class="modal-title" id="post_infoModalLongTitle">建立貼文</h4>
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
				</div>
				
<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/post_info.do" name="form1" enctype='multipart/form-data'>
				<div class="modal-body ">
					<div class="form-group">
						<label class="post_topic">
							貼文主題
							<input type="text" name="post_topic" id="post_topic" class="form-control"  size="50">
						</label>
				<br>
				<br>
						<label class="post_content" >
							貼文內容
				<br>
							<textarea name="content" id="editor" class="form-control" ></textarea>
						</label>
						
					</div>
					<div class="form-group"  style="display:none" >
						<label class="club_no">社團編號</label>
							<textarea name="club_no"  id="club_no" class="form-control" ROWS=10 ></textarea>
					</div>
					<div class="form-group"  style="display:none" >
						<label class="mem_no">會員編號</label>
							<textarea name="mem_no"  id="mem_no" class="form-control" ROWS=10 ></textarea>
					</div>
					<div class="form-group"  style="display:none" >
						<label class="post_date">發布時間</label>
							<textarea name="post_date"  id="post_date" class="form-control" ROWS=10 ></textarea>
					</div>
					
				</div>
				
				<div class="modal-footer">
						<input type="hidden" name="action" value="insert">
					<button type="button" class="btn btn-secondary" data-dismiss="modal">關閉</button>
					<button type="submit" class="btn btn-primary">建立</button>
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
<!---建立貼文------------------------------------------------------------------建立貼文------->
						<a href="#" class="list-group-item">影音相簿</a>
						<a href="<%= request.getContextPath()%>/clubfront.do?actionfront=getOneClubmanage&club_no=${clubVO.club_no}" display="none" class="list-group-item">社團管理</a>
			
						<a href="<%= request.getContextPath()%>/front-end/club/club_list.jsp" display="none" id="linkBack" class="list-group-item">返回列表</a>
				<br>
						<button type="button" class="btn btn-dark" href="<%= request.getContextPath()%>/clubmemberlist.do?action=dropoutclub&club_no=${clubVO.club_no}">
								退出社團
						</button>
				<br><br>
				
					</div>					
					</div>
				<div class="col-xs-12 col-sm-7">
					
<!---------------------------- 貼文列表 ------------------------------------->

					<div class="card text-center" id="post">
							<div class="card-header">
							</div>
							<br>
  							<div class="card-body">
    							<h5 class="card-title" display="none" class="list-group-item">貼文主題</h5>
    						
    							<p class="card-text">貼文內容</p>
  							</div>
  							<div class="card-footer text-muted">
    						回文
  							</div>
					</div>
					<br>
									
				</div>
					
				<div class="col-xs-12 col-lg-2" id="xx">
					<div>好友列表</div>
				</div>
			</div>
		</div>
		



		
		
		</form>
		<%@ include file="/front-end/CA105G1_footer.file" %>
		<script src="https://code.jquery.com/jquery.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
		<script>
			ClassicEditor
				.create( document.querySelector( '#editor' ) )
				.then( editor => {
					console.log( editor );
				} )
				.catch( error => {
					console.error( error );
				} );
		</script>
	

	</body>
</html>