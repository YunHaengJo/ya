<%@page import="com.Beans.Ya_MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	Ya_MemberBean memberBean = new Ya_MemberBean();
	memberBean = (Ya_MemberBean)session.getAttribute("member");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">

</style>
</head>
<body>
<!-- GuestLogin  -->
	<div class="container" style="width: 605px;">
		<h3>회원정보수정</h3>

		<form name="myForm" method="post" action="../login/ya_loginControl.jsp?command=update">
			<input type="hidden" id="email" name="email" value="<%=memberBean.getEmail() %>">
			<div class="input-group">
				<span class="input-group-addon"><i
					class="glyphicon glyphicon-envelope"></i></span> 
					<input id="email1" type="text" class="form-control" name="email1" placeholder="<%=memberBean.getEmail() %>"
					style="width: 605px; height: 50px" readonly="readonly">			
			</div>
			<p></p>
			<div class="input-group">
				<span class="input-group-addon"><i
					class="glyphicon glyphicon-lock"></i></span> <input id="password"
					type="password" class="form-control" name="password"
					placeholder="영문,숫자포함 6~20자" style="width: 605px; height: 50px">
			</div>
			<p></p>
			<div class="input-group">
				<span class="input-group-addon"><i
					class="glyphicon glyphicon-lock"></i></span> <input id="passwordCk"
					type="password" class="form-control" name="passwordCk"
					placeholder="비밀번호 확인" style="width: 605px; height: 50px">
			</div>
			<p></p>
			<div class="input-group">
				<span class="input-group-addon"><i
					class="glyphicon glyphicon-user"></i></span> <input id="nickname"
					type="text" class="form-control" name="nickname"
					placeholder="<%=memberBean.getNickname() %>" style="width: 605px; height: 50px" readonly="readonly">
			</div>
			<p></p>
			<div class="input-group">
					<input type="submit" class="btn btn-info" value="수정"
						style="background-color: #ff6b6b; font-size: 30px; width: 645px; height: 50px; border: 0; outline: 0">
				<br>
			</div>			
		</form>
		<br>
	</div>
</body>
</html>