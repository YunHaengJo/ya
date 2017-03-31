<%@page import="com.Dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	MemberDao memberDao = MemberDao.getInstance();
	String str = "";
	String email = request.getParameter("email");
	if(email.equals("")){
		str = "blank";
		out.println(str);
	}else{
		if(!memberDao.do_idValidation(email)){
			str = "false";
			out.println(str);
		}else{
			str = "true";
			out.println(str);
		}
	}
	
%>