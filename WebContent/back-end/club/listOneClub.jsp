<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ page import="com.club.model.*"%>
<%-- �����Ƚm�߱ĥ� Script ���g�k���� --%>

<%
  ClubVO clubVO = (ClubVO) request.getAttribute("clubVO"); //EmpServlet.java(Concroller), �s�Jreq��empVO����
%>

<html>
<head>
<title>���θ�� - listOneClub.jsp</title>

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

<h4>�����Ƚm�߱ĥ� Script ���g�k����:</h4>
<table id="table-1">
	<tr><td>
		 <h3>���θ�� - ListOneClub.jsp</h3>
		 <h4><a href="front-end/club/select_page.jsp"><img src="images/back1.gif" width="100" height="32" border="0">�^����</a></h4>
	</td></tr>
</table>

<table>
	<tr>
		<th>���νs��</th>
		<th>�B�ʶ��ؽs��</th>
		<th>�Ϥ�</th>
		<th>�Ϥ����ɦW</th>
		<th>���Ϊ��A</th>
		<th>���ΦW��</th>
		<th>����²��</th>
	</tr>
	<tr>
		<td><%=clubVO.getClub_no()%></td>
		<td><%=clubVO.getSp_no()%></td>
		<td><img src="<%=request.getContextPath()%>/clubImg.do?club_no=${clubVO.club_no}"  width="70%"/></td>
		<td>${clubVO.photo_ext}</td>
		<td>${clubVO.club_status}</td>
		<td>${clubVO.club_name}</td> 
		<td>${clubVO.club_intro}</td>
	</tr>
</table>

</body>
</html>