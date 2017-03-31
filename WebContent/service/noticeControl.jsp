<%@page import="javafx.scene.control.Alert"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.Beans.Ya_NoticeBean"%>
<%@page import="java.util.List"%>
<%@page import="com.Dao.NoticeDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%   
response.setHeader("Cache-Control","no-store");   
response.setHeader("Pragma","no-cache");   
response.setDateHeader("Expires",0);   
if (request.getProtocol().equals("HTTP/1.1")) 
        response.setHeader("Cache-Control", "no-cache");
//캐쉬 버리기
%>  
<%
	request.setCharacterEncoding("utf-8");
	String command = request.getParameter("command");
	
	
	NoticeDao dao = NoticeDao.getInstance();
	if(command.equals("list")){
		String pageNumStr = (request.getParameter("pageNum")==null||request.getParameter("pageNum")=="")?"1":request.getParameter("pageNum");
		String search_div = (request.getParameter("search_div")==null||request.getParameter("search_div")=="")?"":request.getParameter("search_div");
		String search_word =(request.getParameter("search_word")==null||request.getParameter("search_word")=="")?"":request.getParameter("search_word");
		
		
		int pageNum = Integer.parseInt(pageNumStr);
		String pageSize = "1";	//페이지 사이즈 변경!!
		int page_Size = Integer.parseInt(pageSize);
		
		System.out.println(search_div);
		System.out.println(search_word);
		System.out.println(pageNum);
		
		ArrayList<Object> list = dao.do_search(pageNum, page_Size, search_div, search_word);
		
		if(list.size()==0){
			
			System.out.println("걸린거임 ");
			pageContext.forward("ya_notice.jsp");
			
		}else{
			request.setAttribute("list", list);
			request.setAttribute("pageNum", pageNumStr);
			request.setAttribute("pageSize", pageSize);
			request.setAttribute("search_div", search_div);
			request.setAttribute("search_word", search_word);
			
			pageContext.forward("ya_notice.jsp");
		}
		
	}else if(command.equals("detail")){
		String seqStr = request.getParameter("seq");
		int seq = Integer.parseInt(seqStr);
		
		Ya_NoticeBean bean = new Ya_NoticeBean();
		
		bean = (Ya_NoticeBean)dao.do_detail(seq);
		
		request.setAttribute("detail", bean);
		
		pageContext.forward("ya_noticeDetail.jsp");
	}else if(command.equals("register")){
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		
		Ya_NoticeBean bean = new Ya_NoticeBean();
		bean.setTitle(title);
		bean.setContent(content);
		
		if(dao.do_insert(bean)){
			pageContext.forward("noticeControl.jsp?command=list");
		}else{
			
			System.out.println("공지실패");
		}
	}else if(command.equals("delete")){
		String seqStr = request.getParameter("seq");
		int seq = Integer.parseInt(seqStr);
		
		Ya_NoticeBean bean = new Ya_NoticeBean();
		bean.setSeq(seq);
		
		System.out.println("순번순번순번-------------:" + seq);
		
		if(dao.do_delete(bean)){
			System.out.println("삭제성공");
		}else{
			System.out.println("삭제실패");
		}
		
		pageContext.forward("noticeControl.jsp?command=list");
	}else if(command.equals("update")){
		String seqStr = request.getParameter("seq");
		int seq = Integer.parseInt(seqStr);
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		
		Ya_NoticeBean bean = new Ya_NoticeBean();
		bean.setSeq(seq);
		bean.setTitle(title);
		bean.setContent(content);
		
		if(dao.do_update(bean)){
			System.out.println("수정성공");
		}else{
			System.out.println("수정실패");
		}
		
		pageContext.forward("noticeControl.jsp?command=list");
	}
%>















