<%@page import="com.Dao.PointDao"%>
<%@page import="java.io.IOException"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="com.Dao.ReserveDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int seq = Integer.parseInt(request.getParameter("seq"));
	int price = Integer.parseInt(request.getParameter("price"));
	int point = Integer.parseInt(request.getParameter("point"));
	
	point = price - point;
	point = (point/10);
	
	ReserveDao reservedao = ReserveDao.getInstance();
	PointDao pointdao = PointDao.getInstance();
	String resultJson;
	boolean flag1 = reservedao.do_access_reserve(seq);
	boolean  f1ag2 = false;
	if(flag1){
		f1ag2 = pointdao.do_add_point(seq, point, "승인");
	}
	
			//reservedao.do_add_point(seq);
	Gson gson = new Gson();
	
	resultJson = "{\"flag1\":\""+flag1
    		+"\",\"flag2\":\""+f1ag2+"\"}";

	
	String result = gson.toJson(resultJson);
	out.println(result);
%>