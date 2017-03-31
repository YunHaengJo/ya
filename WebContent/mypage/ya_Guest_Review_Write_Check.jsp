<%@page import="com.google.gson.Gson"%>
<%@page import="com.Beans.Ya_ReviewBean"%>
<%@page import="com.Dao.ReviewDao"%>
<%@page import="com.Beans.Ya_MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	Ya_MemberBean member = (Ya_MemberBean)session.getAttribute("member");
	String nickname = member.getNickname();

	int fac_score = Integer.parseInt(request.getParameter("fac_score"));
	int ser_score = Integer.parseInt(request.getParameter("ser_score"));
	int clean_score = Integer.parseInt(request.getParameter("clean_score"));
	String contents = request.getParameter("contents");
	int motel_num = Integer.parseInt(request.getParameter("command"));
	
	
	ReviewDao reviewdao = ReviewDao.getInstance();
	Ya_ReviewBean reviewbean = new Ya_ReviewBean(motel_num, nickname, fac_score, ser_score,	clean_score, contents);
	boolean flag = reviewdao.do_insert(reviewbean);
	
	Gson gson = new Gson();
	
	String result = gson.toJson(flag);
	out.println(result);
	
	
%>