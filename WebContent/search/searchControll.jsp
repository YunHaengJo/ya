<%@page import="com.Beans.Ya_ImgBean"%>
<%@page import="com.Dao.PointDao"%>
<%@page import="com.Beans.Ya_ZzimBean"%>
<%@page import="com.Dao.ZzimDao"%>
<%@page import="com.Beans.Ya_MemberBean"%>
<%@page import="com.Beans.Ya_ReserveBean"%>
<%@page import="com.Dao.ReserveDao"%>
<%@page import="com.Beans.Ya_ReviewBean"%>
<%@page import="java.util.List"%>
<%@page import="com.Dao.MotelDao"%>
<%@page import="com.Beans.Ya_MotelBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.Dao.SearchPageDao"%>
<%@ page pageEncoding="UTF-8" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%
request.setCharacterEncoding("UTF-8");
%>
<%!//
//%>
<%//
//%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<script>
</script>
<style>
</style>
</head>
<body>
<%
	String command = request.getParameter("command");

	if(command.equals("detailAf")){
		String type = request.getParameter("type");
		String motelNum = request.getParameter("motel_num");
		int motel_num = Integer.parseInt(motelNum);
	
		MotelDao dao = MotelDao.getInstance();
	
		Ya_MotelBean dto = (Ya_MotelBean)dao.do_detail(motel_num);

		request.setAttribute("dto", dao.do_detail(motel_num));
	
		if(type.equals("room")) pageContext.forward("searchDetail.jsp?contentsDiv=room");
		else if(type.equals("pay")) pageContext.forward("searchDetail.jsp?contentsDiv=pay");
		else if(type.equals("review")){
			String pageNum = (request.getParameter("pageNum")==null || request.getParameter("pageNum")=="")?"1":request.getParameter("pageNum");
			int page_Num = Integer.parseInt(pageNum);
			
			List<Ya_ReviewBean> list =  dao.do_detail_review(page_Num,4 ,motel_num);
			if(list.size()==0){
				pageContext.forward("searchDetail.jsp?contentsDiv=review");
			
				 }else{
			request.setAttribute("list", list);
			
			pageContext.forward("searchDetail.jsp?contentsDiv=review");
				 }
		}
	
	}else if(command.equals("detail")){
		String motelNum = request.getParameter("motel_num");
		int motel_num = Integer.parseInt(motelNum);
		
		MotelDao dao = MotelDao.getInstance();
		
		Ya_MotelBean dto = (Ya_MotelBean)dao.do_detail(motel_num);
	
		request.setAttribute("dto", dao.do_detail(motel_num));
				
		pageContext.forward("searchDetail.jsp?contentsDiv=room");
		
		
	}else if(command.equals("word")){
		String searchWord = request.getParameter("searchWord");
		String type =(request.getParameter("type")==null || request.getParameter("type")=="")?"BASIC":request.getParameter("type");
		String pageNum = (request.getParameter("pageNum")==null || request.getParameter("pageNum")=="")?"1":request.getParameter("pageNum");
		int page_Num = Integer.parseInt(pageNum);
		
		String isaddress = request.getParameter("isaddress");
		
		session.setAttribute("word",searchWord);
		session.setAttribute("type",type);

		SearchPageDao dao = SearchPageDao.getInstance();
		
		 if(type.equals("STAR")){
			if(isaddress.equals("ok")){
				ArrayList<Object> list = dao.do_address_search(page_Num, 12, "STAR", searchWord);
				
				if(list.size()==0){
					pageContext.forward("searchPage.jsp");
					
				}else{
				request.setAttribute("list", list);
				pageContext.forward("searchPage.jsp");	
				}
			}else{
				ArrayList<Object> list = dao.do_search(page_Num, 12, "STAR", searchWord);
				
				 if(list.size()==0){
				pageContext.forward("searchPage.jsp");
			
				 }else{
				request.setAttribute("list", list);
				pageContext.forward("searchPage.jsp");
		
				 }
			}
			 
		}else if(type.equals("PAY")){
			if(isaddress.equals("ok")){
				ArrayList<Object> list = dao.do_address_search(page_Num, 12, "PAY", searchWord);
				
				if(list.size()==0){
					pageContext.forward("searchPage.jsp");
					
				}else{
				request.setAttribute("list", list);
				pageContext.forward("searchPage.jsp");	
				}
			}else{
			
				ArrayList<Object> list = dao.do_search(page_Num, 12, "PAY", searchWord);
		 
				if(list.size()==0){
					pageContext.forward("searchPage.jsp");
				}else{
					request.setAttribute("list", list);
					pageContext.forward("searchPage.jsp");
				 }	
			}
		}else if(type.equals("REVIEW")){
			if(isaddress.equals("ok")){
				ArrayList<Object> list = dao.do_address_search(page_Num, 12, "REVIEW", searchWord);
				
				if(list.size()==0){
					pageContext.forward("searchPage.jsp");
					
				}else{
				request.setAttribute("list", list);
				pageContext.forward("searchPage.jsp");	
				}
			}else{	
				ArrayList<Object> list = dao.do_search(page_Num, 12, "REVIEW", searchWord);
				 if(list.size()==0){
					pageContext.forward("searchPage.jsp");
				 }else{
					request.setAttribute("list", list);
					pageContext.forward("searchPage.jsp");	
				 }
			}
		}else if(type.equals("BASIC")){
			if(isaddress.equals("ok")){
				ArrayList<Object> list = dao.do_address_search(page_Num, 12, "BASIC", searchWord);
				
				if(list.size()==0){
					pageContext.forward("searchPage.jsp");
					
				}else{
				request.setAttribute("list", list);
				pageContext.forward("searchPage.jsp");	
				}
			}else{
				ArrayList<Object> list = dao.do_search(page_Num, 12, "BASIC", searchWord);
				 if(list.size()==0){
					pageContext.forward("searchPage.jsp");
				}else{
					request.setAttribute("list", list);
					pageContext.forward("searchPage.jsp");	
				}
			}
		}
	}else if(command.equals("ZZIM")){
		ZzimDao dao = ZzimDao.getInstance();
		String motelNum = request.getParameter("motelNum");
		String email = request.getParameter("email");
		Ya_ZzimBean zzimdto = new  Ya_ZzimBean();
		zzimdto.setMotel_num(Integer.parseInt(motelNum));
		zzimdto.setEmail(email);
		dao.do_insert(zzimdto);
		
		pageContext.forward("searchControll.jsp?command=detail&motel_num="+motelNum);
	}else if(command.equals("ZZIMdelete")){
		ZzimDao dao = ZzimDao.getInstance();
		String motelNum = request.getParameter("motelNum");
		String email = request.getParameter("email");
		Ya_ZzimBean zzimdto = new  Ya_ZzimBean();
		zzimdto.setMotel_num(Integer.parseInt(motelNum));
		zzimdto.setEmail(email);
		dao.do_delete(zzimdto);
		
		pageContext.forward("searchControll.jsp?command=detail&motel_num="+motelNum);
	}
	
	////////////////////////////////////////////////////// 결제 후
	else if(command.equals("reser")){
		String name = request.getParameter("reserName");
		String use_date = request.getParameter("date");
		String price = request.getParameter("price");
		String motelNum = request.getParameter("motelNum");
		String reserPoint = request.getParameter("reserPoint");
		String roomtype = request.getParameter("roomtype");
		String email = "";
		if(session.getAttribute("member")!=null){ 
		Ya_MemberBean memberBean = (Ya_MemberBean)session.getAttribute("member"); 
		email = memberBean.getEmail();
		}
		
		ReserveDao dao = ReserveDao.getInstance();
		Ya_ReserveBean dto = new Ya_ReserveBean();
		dto.setEmail(email);
		dto.setName(name);
		dto.setMotel_num(Integer.parseInt(motelNum));
		dto.setUse_dt(use_date);
		dto.setPoint(Integer.parseInt(reserPoint));
		dto.setPrice(Integer.parseInt(price));
		dto.setRoom_type(roomtype);
		if(dao.do_insert(dto)){
			PointDao podao = PointDao.getInstance();
			System.out.println("예약시 날짜랑 이메일 "+ use_date + email);
			int seq = dao.do_search_seq(use_date,email);
			System.out.println("예약시 seq" + seq);
			
			podao.do_add_point(seq, Integer.parseInt(reserPoint), "사용");	
		}
			
		pageContext.forward("searchControll.jsp?command=detail&motel_num="+motelNum);
		
	}

	
	
	
%>
</body>
</html>