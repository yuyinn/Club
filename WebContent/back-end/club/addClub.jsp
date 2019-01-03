<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.club.model.*"%>

<%
  ClubVO clubVO = (ClubVO) request.getAttribute("clubVO");
%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>社團資料新增 - addClub.jsp</title>

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
	width: 450px;
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
		 <h3>社團資料新增 - addClub.jsp</h3></td><td>
		 <h4><a href="select_page.jsp">回首頁</a></h4>
	</td></tr>
</table>

<h3>資料新增:</h3>

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

	<td>運動項目編號:</td>
	<td>
	<select name="sp_no">
 	<option>SP001</option>
 	<option>SP002</option>
 	<option>SP003</option>
 	<option>SP004</option>
 	<option>SP005</option>
 	<option>SP006</option>
 	<option>SP007</option>
	</select>
	</td>
	</tr>
	
	<tr>
		<td>照片:</td>
		<td><input type="FILE" name="photo" size="45"
			 value="<%= (clubVO==null)? "" : clubVO.getPhoto()%>" /></td>
	</tr>
	<tr>
		<td>照片副檔名:</td>
		<td><input type="TEXT" name="photo_ext" size="45"
			 value="<%= (clubVO==null)? "" : clubVO.getPhoto_ext()%>" /></td>
	</tr>
	<tr>
		<td>社團狀態:</td>
		<td><input type="TEXT" name="club_status" size="45"
			 value="<%= (clubVO==null)? "" : clubVO.getClub_status()%>" /></td>
	</tr>
	<tr>
		<td>社團名稱:</td>
		<td><input type="TEXT" name="club_name" size="45"
			 value="<%= (clubVO==null)? "" : clubVO.getClub_name()%>" /></td>
	</tr>
	<tr>
		<td>社團簡介:</td>
		<td><input type="TEXT" name="club_intro" size="45"
			 value="<%= (clubVO==null)? "" : clubVO.getClub_intro()%>" /></td>
	</tr>
	

	

</table>
<br>
<input type="hidden" name="action" value="insert">
<input type="submit" value="送出新增"></FORM>
</body>
</html>

