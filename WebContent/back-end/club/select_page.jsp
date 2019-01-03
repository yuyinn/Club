<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>IBM Club: Home</title>

<style>
  table#table-1 {
	width: 450px;
	background-color: #CCCCFF;
	margin-top: 5px;
	margin-bottom: 10px;
    border: 3px ridge Gray;
    height: 80px;
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

</head>
<body bgcolor='white'>

<table id="table-1">
   <tr><td><h3>IBM Club: Home</h3><h4>( MVC )</h4></td></tr>
</table>

<p>This is the Home page for IBM Club: Home</p>

<h3>��Ƭd��:</h3>
	
<%-- ���~��C --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">�Эץ��H�U���~:</font>
	<ul>
	    <c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<ul>
  <li><a href='listAllClub.jsp'>List</a> all Club.  <br><br></li>
  
  
  <li>
    <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/club.do" >
        <b>��J���νs�� (�pC0001):</b>
        <input type="text" name="club_no">
        <input type="hidden" name="action" value="getOne_For_Display">
        <input type="submit" value="�e�X">
    </FORM>
  </li>

  <jsp:useBean id="clubSvc" scope="page" class="com.club.model.ClubService" />
   
  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/club.do" >
       <b>��ܪ��νs��:</b>
       <select size="1" name="club_no">
         <c:forEach var="clubVO" items="${clubSvc.all}" > 
          <option value="${clubVO.club_no}">${clubVO.club_no}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getOne_For_Display">
       <input type="submit" value="�e�X">
    </FORM>
  </li> 
  
   


<h3>���κ޲z</h3>

<ul>
  <li><a href='addClub.jsp'>Add</a> a new Club.</li>
</ul>

</body>
</html>