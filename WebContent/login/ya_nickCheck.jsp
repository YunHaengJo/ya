<%@page import="com.Dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	MemberDao memberDao = MemberDao.getInstance();
	String str = "";
	String nickname = request.getParameter("nickname");
	if(nickname.equals("")){
		str = "blank";
		out.println(str);
	}else{
		if(!memberDao.do_nicknameValidation(nickname)){
			str = "false";
			out.println(str);
		}else{
			str = "true";
			out.println(str);
		}
	}	
%>