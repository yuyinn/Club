<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.competition.model.*"%>

<%
  CompetitionVO competitionVO = (CompetitionVO) request.getAttribute("competitionVO"); //EmpServlet.java (Concroller) 存入req的empVO物件 (包括幫忙取出的empVO, 也包括輸入資料錯誤時的empVO物件)
%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>賽事資料修改 - update_competition_input.jsp</title>

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
		 <h3>賽事資料修改 - update_competition_input.jsp</h3>
		 <h4><a href="back-end/competition/select_page.jsp"><img src="back-end/competition/images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
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

<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/competition.do" name="form1" enctype='multipart/form-data'>
<table>
<!--  -->
	<tr>
		<td>賽事編號:</td>
		<td><input type="TEXT" name="comp_no" size="45"	value="<%=competitionVO.getComp_no()%>" /></td>
	</tr>
	<tr>
		<td>賽事名稱:</td>
		<td><input type="TEXT" name="comp_name" size="45" value="<%=competitionVO.getComp_name()%>" /></td>
	</tr>
	<tr>
		<td>賽事開始日期:</td>
		<td><input type="TEXT" name="comp_startdate" size="45" value="<%=competitionVO.getComp_startdate()%>" /></td>
	</tr>
	<tr>
		<td>賽事結束日期:</td>
		<td><input type="TEXT" name="comp_enddate" size="45" value="<%=competitionVO.getComp_enddate()%>" /></td>
	</tr>
	<tr>
		<td>賽事簡章:</td>
		<td><input type="TEXT" name="comp_cont" size="45" value="<%=competitionVO.getComp_cont()%>" /></td>
	</tr>
	
</table>
<br>
<input type="hidden" name="action" value="update">
<input type="hidden" name="Comp_no" value="<%=competitionVO.getComp_no()%>">
<input type="submit" value="送出修改"></FORM>
<script src="https://code.jquery.com/jquery.js"></script>	
	
<script type="text/javascript"> 

</script>
</body>



</html>