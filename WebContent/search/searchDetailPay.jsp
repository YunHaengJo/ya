<%@page import="com.Beans.Ya_MotelBean"%>
<%@ page pageEncoding="UTF-8" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%
request.setCharacterEncoding("UTF-8");
%>
<%!//
//%>
<%//
Ya_MotelBean dto = (Ya_MotelBean)request.getAttribute("dto");

//%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<script>
</script>
<style>
th{
	background: lightgray;
}
</style>
</head>
<body>
<br><br>
<h1>요금및시간</h1>
<br>
<p>숙박 이용요금</p>

<br><br>

<table border="1" style="width: 100%; text-align: center" >
	<tr>
		<th height="150" style="text-align: center"><h3>구분</h3></th>
		<th height="150" style="text-align: center"><h3>요금</h3></th>
		<th height="150" style="text-align: center"><h3>입실시간</h3></th>
		<th height="150" style="text-align: center"><h3>퇴실시간</h3></th>
	</tr>
	
	<tr>
		<td height="100"><h3>일반실</h3></td>
		<td height="100"><h3><%=dto.getNormal_pri() %> 원</h3></td>
		<td rowspan="2" height="100"><h3><%=dto.getCheck_in() %> : 00</h3></td>
		<td rowspan="2" height="100"><h3><%=dto.getCheck_out() %> : 00 </h3></td>
	</tr>
	
	<tr>
		<td height="100"><h3>특실</h3></td>
		<td height="100"><h3><%=dto.getPremium_pri() %> 원</h3></td>
		
	</tr>

</table>


</body>
</html>