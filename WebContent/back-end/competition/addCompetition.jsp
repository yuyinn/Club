<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.competition.model.*"%>

<%
  CompetitionVO competitionVO = (CompetitionVO) request.getAttribute("competitionVO");
%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>賽事資料新增 - addCompetition.jsp</title>

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
		 <h3>賽事資料新增 - addCompetition.jsp</h3></td><td>
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

<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/competition.do" name="form1" enctype='multipart/form-data'>
<table>

	<tr>
		<td>賽事名稱:</td>
		<td><input type="TEXT" name="comp_name" size="45"
			 value="<%= (competitionVO==null)? "" : competitionVO.getComp_name()%>" /></td>
	</tr>
	
	<tr>
		<td>賽事開始日期:</td>
		<td><input type="TEXT" name="comp_startdate" size="45"
			 value="<%= (competitionVO==null)? "" : competitionVO.getComp_startdate()%>" /></td>
	</tr>
	<tr>
		<td>賽事結束日期:</td>
		<td><input type="TEXT" name="comp_enddate" size="45"
			 value="<%= (competitionVO==null)? "" : competitionVO.getComp_startdate()%>" /></td>
	</tr>
	<tr>
		<td>賽事簡章:</td>
		<td><input type="TEXT" name="comp_content" size="45"
			 value="<%= (competitionVO==null)? "" : competitionVO.getComp_cont()%>" /></td>
	</tr>
	

	

</table>
<br>
<input type="hidden" name="action" value="insert">
<input type="submit" value="送出新增"></FORM>
</body>
</html>

