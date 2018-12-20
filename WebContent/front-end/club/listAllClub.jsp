<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.club.model.*"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- 此頁練習採用 EL 的寫法取值 --%>

<%
    ClubService clubSvc = new ClubService();
    List<ClubVO> list = clubSvc.getAll();
    pageContext.setAttribute("list",list);
%>


<html>
<head>
<title>所有社團資料 - listAllClub.jsp</title>

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
	width: 800px;
	background-color: white;
	margin-top: 5px;
	margin-bottom: 5px;
  }
  table, th, td {
 
    border: 1px solid #CCCCFF;
  }
  th, td {
    padding: 5px;
    text-align: center;
  }
</style>

</head>
<body bgcolor='white'>

<h4>此頁練習採用 EL 的寫法取值:</h4>
<table id="table-1">
	<tr><td>
		 <h3>所有社團資料 - listAllClub.jsp</h3>
		 <h4><a href="select_page.jsp"><img src="images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<table>
	<tr>
		<th>社團編號</th>
		<th>運動項目編號</th>
		<th>照片</th>
		<th>照片副檔名</th>
		<th>社團狀態</th>
		<th>社團名稱</th>
		<th>社團簡介</th>
		<th>修改</th>
		
	</tr>
	<%@ include file="page1.file" %> 
	<c:forEach var="clubVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
		
		<tr>
			<td>${clubVO.club_no}</td>
			<td>${clubVO.sp_no}</td>
			<td><img src="<%=request.getContextPath()%>/clubImg.do?club_no=${clubVO.club_no}"  width="70%"/></td>
			<td>${clubVO.photo_ext}</td>
			<td>${clubVO.club_status}</td>
			<td>${clubVO.club_name}</td> 
			<td>${clubVO.club_intro}</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/club.do" style="margin-bottom: 0px;">
			     <input type="submit" value="修改">
			     <input type="hidden" name="club_no"  value="${clubVO.club_no}">
			     <input type="hidden" name="action"	value="getOne_For_Update"></FORM>
			</td>
			
		</tr>
	</c:forEach>
</table>
<%@ include file="page2.file" %>

</body>
</html>