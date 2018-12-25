<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.club.model.*"%>

<%
  ClubVO clubVO = (ClubVO) request.getAttribute("clubVO"); 
%>
<html >
	<head>
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
		<div class="container-fluid">
			<div class="row">
				<div class="container">
					<div class="row">
						<div class="col-xs-12 col-sm-4">
							<div class="list-group active">
<!---------------------------------------------------�إߪ���------------------------------------------------------------------>
							<a href="#" class="list-group-item" data-toggle="modal" data-target="#clubModalLong">�إߪ���</a>
<!-------------- Modal ------------>
<div class="modal fade" id="clubModalLong" tabindex="-1" role="dialog" aria-labelledby="clubModalLongTitle" aria-hidden="true">
  <div class="modal-dialog  .modal-dialog-centered " role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title" id="clubModalLongTitle">�إߪ���</h4>
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
							<label class="club_name" >���ΦW��</label>
							<input type="text" name="club_name" id="club_name" class="form-control">
						</div>
						<br>
						<br>
				<jsp:useBean id="sportSvc" scope="page" class="com.sport.model.SportService" />
						<div class="form-group">
							<label class="sport" >�B�ʶ���</label>
							<select name="sport" id="sport" class="form-control">
								<c:forEach var="sportVO" items="${sportSvc.all}">
								<option value="${sportVO.sp_no}" ${(clubVO.sp_no==sportVO.sp_no)?'selected':'' } >${sportVO.sp_name}
			</c:forEach>
							</select>
						</div>
						<br>
						<br>

						<div class="form-group">
							
							<label class="club_intro">����²��</label>
							<textarea name="club_intro" id="club_intro" class="form-control" ROWS=10 ></textarea>	
						</div>
						<br>
						<br>
						

      </div>
      <div class="modal-footer">
      	<input type="hidden" name="action" value="insert">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">����</button>
        <button type="submit" class="btn btn-primary">�e�X</button>
      </div>
      </FORM>
    </div>
  </div>
</div>

<!------------ Modal ------------>
<!-----------------------------------------------------�إߪ���------------------------------------------------------------------>
							<a href="#" class="list-group-item">���κ޲z</a>
							<a href="#" class="list-group-item">�v����ï</a>
							<a href="#" class="list-group-item">�峹</a>
							</div>
						</div>
						<div class="col-xs-12 col-sm-8">
							
						</div>
					</div>
				</div>
			</div>
		</div>
		
		
		</form>
		<script src="https://code.jquery.com/jquery.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
	</body>
</html>