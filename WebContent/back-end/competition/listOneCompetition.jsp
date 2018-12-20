<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ page import="com.competition.model.*"%>
<%-- 此頁暫練習採用 Script 的寫法取值 --%>

<%
  CompetitionVO competitionVO = (CompetitionVO) request.getAttribute("competitionVO"); //EmpServlet.java(Concroller), 存入req的empVO物件
%>

<html>
<head>
<title>賽事資料 - listOneCompetiton.jsp</title>

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
	width: 700px;
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

<h4>此頁暫練習採用 Script 的寫法取值:</h4>
<table id="table-1">
	<tr><td>
		 <h3>賽事資料 - ListOneCompetition.jsp</h3>
		 <h4><a href="back-end/competition/select_page.jsp"><img src="back-end/competition/images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>

<table>
	<tr>
		<th>賽事編號</th>
		<th>賽事名稱</th>
		<th>賽事開始日期</th>
		<th>賽事結束日期</th>
		<th>賽事簡章</th>
	</tr>
	<tr>
		<td>${competitionVO.comp_no}</td>
		<td>${competitionVO.comp_name}</td>
		<td>${competitionVO.comp_startdate}</td>
		<td>${competitionVO.comp_enddate}</td> 
		<td>${competitionVO.comp_cont}</td>
	</tr>
</table>

</body>
</html>