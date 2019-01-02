<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.club.model.*"%>

<%
  ClubVO clubVO = (ClubVO) request.getAttribute("clubVO");
%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>���θ�Ʒs�W - addClub.jsp</title>

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
		 <h3>���θ�Ʒs�W - addClub.jsp</h3></td><td>
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

<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/club.do" name="form1" enctype='multipart/form-data'>
<table>

	<tr>
		<td>�B�ʶ��ؽs��:</td>
		<td>
		<select name="sp_no">
		<option value="SP001" ${(sportVO.sp_no=='�βy')?'selected':''}>�βy</option>
		<option value="SP002" ${(sportVO.sp_no=='�Ʋy')?'selected':''}>�Ʋy</option>
		<option value="SP003" ${(sportVO.sp_no=='�x�y')?'selected':''}>�x�y</option>
		<option value="SP004" ${(sportVO.sp_no=='���y')?'selected':''}>���y</option>
		<option value="SP005" ${(sportVO.sp_no=='�вy')?'selected':''}>�вy</option>
		<option value="SP006" ${(sportVO.sp_no=='�C�]')?'selected':''}>�C�]</option>
		<option value="SP007" ${(sportVO.sp_no=='�ۦ樮')?'selected':''}>�ۦ樮</option>
		</select>
		</td>
	</tr>
	
	<tr>
		<td>�Ӥ�:</td>
		<td><input type="FILE" name="photo" size="45"
			 value="<%= (clubVO==null)? "" : clubVO.getPhoto()%>" /></td>
	</tr>
	<tr>
		<td>�Ӥ����ɦW:</td>
		<td><input type="TEXT" name="photo_ext" size="45"
			 value="<%= (clubVO==null)? "" : clubVO.getPhoto_ext()%>" /></td>
	</tr>
	<tr>
		<td>���Ϊ��A:</td>
		<td>
		<select name="club_status">
		<option value="���`" ${(clubVO.club_status=='���`')?'selected':''}>���`</option>
		<option value="����" ${(clubVO.club_status=='����')?'selected':''}>����</option>
		</select>
		</td>
	</tr>
	<tr>
		<td>���ΦW��:</td>
		<td><input type="TEXT" name="club_name" size="45"
			 value="<%= (clubVO==null)? "" : clubVO.getClub_name()%>" /></td>
	</tr>
	<tr>
		<td>����²��:</td>
		<td><input type="TEXT" name="club_intro" size="45"
			 value="<%= (clubVO==null)? "" : clubVO.getClub_intro()%>" /></td>
	</tr>
	

	

</table>
<br>
<input type="hidden" name="action" value="insert">
<input type="submit" value="�e�X�s�W"></FORM>
</body>
</html>

