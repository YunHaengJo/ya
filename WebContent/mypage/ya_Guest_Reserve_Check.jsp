<%@page import="com.google.gson.Gson"%>
<%@page import="com.Beans.Ya_ReserveBean"%>
<%@page import="com.Beans.Ya_MemberBean"%>
<%@page import="com.Dao.MemberDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.Dao.ReserveDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	Ya_MemberBean member = (Ya_MemberBean)session.getAttribute("member");
	String email = member.getEmail();

	String date1 = request.getParameter("date1");
	//System.out.println("date1==========================" + date1);
	String date2 = request.getParameter("date2");
	//System.out.println("date2==========================" + date2);
	String pageNum = request.getParameter("pageNum");
	int page_num = Integer.parseInt(pageNum);
	
	ReserveDao dao = ReserveDao.getInstance();
	
	ArrayList<Ya_ReserveBean> bean_list = dao.do_guest_getlist(page_num, 3, email, date1, date2);
	//System.out.println("리스트에서 가져오는 totcnt = " + bean_list.get(0).getTot_cnt());
	Gson gson = new Gson();
	
	String result = gson.toJson(bean_list);
	out.println(result);
	
	
%>