<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.club.model.*"%>

<%
  ClubVO clubVO = (ClubVO) request.getAttribute("clubVO"); //EmpServlet.java (Concroller) 存入req的empVO物件 (包括幫忙取出的empVO, 也包括輸入資料錯誤時的empVO物件)
%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>社團資料修改 - update_club_input.jsp</title>

<style>
  table#table-1 {
	background-color: #CCCCFF;
    border: 2px solid black;
    text-align: center;
  }
  table#table-1 h4 {
    color: red;
    display: block;
    margin-bottom: 1px;
  }
  h4 {
    color: blue;
    display: inline;
  }
</style>

<style>
  table {
	width: 600px;
	background-color: white;
	margin-top: 1px;
	margin-bottom: 1px;
  }
  table, th, td {
  	width: 500px;
    border: 0px solid #CCCCFF;
  }
  th, td {
    padding: 1px;
  }
</style>

</head>
<body bgcolor='white'>

<table id="table-1">
	<tr><td>
		 <h3>社團資料修改 - update_club_input.jsp</h3>
		 <h4><a href="front-end/club/select_page.jsp"><img src="front-end/club/images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>

<h3>資料修改:</h3>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/club.do" name="form1" enctype='multipart/form-data'>
<table>
<!--  -->
	<tr>
		<td>社團編號:</td>
		<td><input type="TEXT" name="club_no" size="45"	value="<%=clubVO.getClub_no()%>" /></td>
	</tr>
	<tr>
		<td>運動項目編號:</td>
		<td><input type="TEXT" name="sp_no" size="45"	value="<%=clubVO.getSp_no()%>" /></td>
	</tr>
<!-- ----------------------------------------------------------------------------------------------------- -->
	<tr>
		<td>照片:</td>
		<td><input type="FILE" name="photo" size="45"	id="file01" /></td>
	</tr>
	<tr >
		<td>照片預覽圖:</td>
		<td><img src="<%=request.getContextPath()%>/clubImg.do?club_no=${clubVO.club_no}"  width="70%"/></td>
	</tr>
<!-- ----------------------------------------------------------------------------------------------------- -->
	<tr>
		<td>照片副檔名:</td>
		<td><input type="TEXT" name="photo_ext" size="45"	value="<%=clubVO.getPhoto_ext()%>" /></td>
	</tr>
	<tr>
		<td>社團狀態:</td>
		<td><input type="TEXT" name="club_status" size="45"	value="<%=clubVO.getClub_status()%>" /></td>
	</tr>
	<tr>
		<td>社團名稱:</td>
		<td><input type="TEXT" name="club_name" size="45" value="<%=clubVO.getClub_name()%>" /></td>
	</tr>
	
	<tr>
		<td>社團簡介:</td>
		<td><input type="TEXT" name="club_intro" size="45" value="<%=clubVO.getClub_intro()%>" /></td>
	</tr>
	
</table>
<br>
<input type="hidden" name="action" value="update">
<input type="hidden" name="club_no" value="<%=clubVO.getClub_no()%>">
<input type="submit" value="送出修改"></FORM>
</body>



</html>