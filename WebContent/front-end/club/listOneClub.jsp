<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.club.model.*"%>

<%
  ClubVO clubVO = (ClubVO) request.getAttribute("clubVO"); 
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
		</style>
	</head>

	<!--data-toggle="collapse" href="#collapseExample" aria-expanded="false" aria-controls="collapseExample" -->

	<body>
<!-- <!-----fb like-----> 
<!-- 	<div id="fb-root"></div> -->
<!-- <script>(function(d, s, id) { -->
//   var js, fjs = d.getElementsByTagName(s)[0];
//   if (d.getElementById(id)) return;
//   js = d.createElement(s); js.id = id;
//   js.src = 'https://connect.facebook.net/zh_TW/sdk.js#xfbml=1&version=v3.2&appId=527693351057321&autoLogAppEvents=1';
//   fjs.parentNode.insertBefore(js, fjs);
<!-- }(document, 'script', 'facebook-jssdk'));</script> -->
<!-- <!-----fb like-----> 


	

	<%@ include file="/front-end/CA105G1_header.file" %>
	
		<div class="container-fluid">
		
			<div class="row">
<!-- 					<div class="row"> -->
						<div class="col-xs-12 col-lg-2">
							<div class="list-group active">
<!---------------------------------------------------建立社團------------------------------------------------------------------>
							<a href="#" class="list-group-item" data-toggle="modal" data-target="#clubModalLong">建立社團</a>
<!-------------- Modal ------------>
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
      <div class="modal-body">
						<br>
						<br>
						<div class="form-group">
								<img src="/CA105G1/img/no-image.PNG" id="photo" width="40%">
								<input type="file" id="photo" name="photo"><br>				
						</div>
						<br>
						<br>

						<div class="form-group">
							<label class="club_name" >社團名稱</label>
							<input type="text" name="club_name" id="club_name" class="form-control">
						</div>
						<br>
						<br>
				<jsp:useBean id="sportSvc" scope="page" class="com.sport.model.SportService" />
						<div class="form-group">
							<label class="sport" >運動項目</label>
							<select name="sport" id="sport" class="form-control">
								<c:forEach var="sportVO" items="${sportSvc.all}">
								<option value="${sportVO.sp_no}" ${(clubVO.sp_no==sportVO.sp_no)?'selected':'' } >${sportVO.sp_name}
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

<!------------ Modal ------------>
<!-----------------------------------------------------建立社團------------------------------------------------------------------>
							<a href="#" class="list-group-item">社團管理</a>
							<a href="#" class="list-group-item">影音相簿</a>
							<a href="#" class="list-group-item">文章</a>
							<a href="<%= request.getContextPath()%>/front-end/club/club_list.jsp" display="none" id="linkBack">回到社團列表</a>
							</div>
						</div>
						
		<div class="container">
 			<div class="col-xs-12 col-sm-9"> 
				<div class="container">
<!-- 					<img src="https://api.fnkr.net/testimg/350x200/00CED1/FFF/?text=img+placeholder" class="img-reponsive" width=50%>	 -->
				
				</div>
				
					
				
<!-----fb like--->
<!-- <div class="fb-like" data-href="https://developers.facebook.com/docs/plugins/" data-layout="button" data-action="like" data-size="large" data-show-faces="false" data-share="false"></div> -->
<!-----fb like--->
			</div>
		</div>
		
						</div>
					</div>
				</div>
			</div>
		</div>

		
		
		</form>
		<%@ include file="/front-end/CA105G1_footer.file" %>
		<script src="https://code.jquery.com/jquery.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
	</body>
</html>