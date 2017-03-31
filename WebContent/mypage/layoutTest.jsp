<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%	
	//Contents영역 
	String contentsDiv = request.getParameter("contentsDiv");
	String contents = "";
	if(contentsDiv==null) contents = "mypage_Main.jsp";
	else if(contentsDiv=="") contents = "../mini/mini_form.jsp";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<center>
		<table border=1 bordercolor=black width="900" height="700">
			<!-- Top -->
			<tr>
				<td colspan="2" height="80" align="center">
					<font face="맑은 고딕" size="15">야하자</font>
				</td>
			</tr>
			<!-- //Top -->
			
			<!-- Left & Contents-->
			<tr>
				<!-- Menu -->
				<td width="200" valign="top"></td>
				<!-- //Menu -->
				
				<!-- Contents -->
				<td width="700" height="570" valign="top">
					<jsp:include page="<%=contents %>"></jsp:include>
				</td>
				<!-- //Contents -->
			</tr>
			<!-- //Left & Contents -->
			
			<!-- Bottom -->	
			<tr>
				<td colspan="2" height="50" align="center">Copyright HIB.co.</td>
			</tr>
			<!-- //Bottom -->
		</table>
	</center>
</body>
</html>