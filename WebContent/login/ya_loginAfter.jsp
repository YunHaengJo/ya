<%@page import="com.Beans.Ya_MemberBean"%>
<%@page import="com.Dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		String type = request.getParameter("type");
		
		MemberDao memberDao = MemberDao.getInstance();
		Ya_MemberBean memberBean =  memberDao.do_login(email, password);
		
		if(type.equals("logout")){
			session.invalidate();
			response.sendRedirect("../main/ya_main.jsp");
		}else{
			if(memberBean!= null){
				if(memberBean.getIs_ok() == 1){
				session.setAttribute("member", memberBean);
				//response.sendRedirect("../super/super.jsp");
				pageContext.forward("../main/ya_main.jsp");
				}else{
		%>
		<script type="text/javascript">
			alert("허가 대기중입니다...");
		</script>
		<% 
					response.sendRedirect("ya_login.jsp");
				}
			}else{
		%>
		<script type="text/javascript">
			alert("ID나 Password를 체크하세요");
		</script>
		<% 
				response.sendRedirect("ya_login.jsp");
			}
		}	
		%>	
</body>
</html>