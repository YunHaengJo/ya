<%@page import="com.Dao.PointDao"%>
<%@page import="java.io.IOException"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="com.Dao.ReserveDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int seq = Integer.parseInt(request.getParameter("seq"));

	ReserveDao reservedao = ReserveDao.getInstance();
	boolean flag = reservedao.do_update(seq);
	int point = reservedao.do_searchPointCancle(seq);
	PointDao podao = PointDao.getInstance();
	podao.do_add_point(seq, point, "승인");
	
	Gson gson = new Gson();
	
	String result = gson.toJson(flag);
	out.println(result);
%>