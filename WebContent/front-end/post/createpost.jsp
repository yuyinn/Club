<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.club.model.*"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
		<title>Title Page</title>
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
		<!--[if lt IE 9]>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/html5shiv/3.7.3/html5shiv.min.js"></script>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/respond.js/1.4.2/respond.min.js"></script>
		<![endif]-->
		<script src="https://cdn.ckeditor.com/ckeditor5/11.2.0/classic/ckeditor.js"></script>
		<style type="text/css">
		
		</style>
	</head>
	<body>
		
		<div class="card text-center">
  			<div class="card-header">
   				<h3>建立貼文</h3>
  			</div>
  			<div class="card-body">
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
					<textarea name="content" id="editor" class="form-control" >This is some sample content.</textarea>
					</label>
				</div>
    			
  			</div>
  			<div class="card-footer text-muted">
  				<input type="hidden" name="action" value="insert">
   				<button type="submit" class="btn btn-primary">發佈</button>
  			</div>
			</div>

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
		<script type="text/javascript">
			function autogrow(textarea){
				var adjustedHeight=textarea.clientHeight;=adjustedHeight=Math.max(textarea.scrollHeight,adjustedHeight);
					if (adjustedHeight>textarea.clientHeight){
						textarea.style.height=adjustedHeight+'px';
					}
			}
		</script>
	</body>
</html>	