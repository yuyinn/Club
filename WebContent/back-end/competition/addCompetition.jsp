<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.competition.model.*"%>

<%
  CompetitionVO competitionVO = (CompetitionVO) request.getAttribute("competitionVO");
%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>�ɨƸ�Ʒs�W - addCompetition.jsp</title>

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
		 <h3>�ɨƸ�Ʒs�W - addCompetition.jsp</h3></td><td>
		 <h4><a href="select_page.jsp">�^����</a></h4>
	</td></tr>
</table>

<h3>��Ʒs�W:</h3>

<%-- ���~��C --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">�Эץ��H�U���~:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/competition.do" name="form1" enctype='multipart/form-data'>
<table>

	<tr>
		<td>�ɨƦW��:</td>
		<td><input type="TEXT" name="comp_name" size="45"
			 value="<%= (competitionVO==null)? "" : competitionVO.getComp_name()%>" /></td>
	</tr>
	
	<tr>
		<td>�ɨƶ}�l���:</td>
		<td><input type="TEXT" name="comp_startdate" size="45"
			 value="<%= (competitionVO==null)? "" : competitionVO.getComp_startdate()%>" /></td>
	</tr>
	<tr>
		<td>�ɨƵ������:</td>
		<td><input type="TEXT" name="comp_enddate" size="45"
			 value="<%= (competitionVO==null)? "" : competitionVO.getComp_startdate()%>" /></td>
	</tr>
	<tr>
		<td>�ɨ�²��:</td>
		<td><input type="TEXT" name="comp_content" size="45"
			 value="<%= (competitionVO==null)? "" : competitionVO.getComp_cont()%>" /></td>
	</tr>
	

	

</table>
<br>
<input type="hidden" name="action" value="insert">
<input type="submit" value="�e�X�s�W"></FORM>
</body>
</html>

