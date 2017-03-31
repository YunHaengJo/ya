<%@page import="com.Beans.Ya_QnaBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.Dao.QnaDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	request.setCharacterEncoding("utf-8");
	String command = request.getParameter("command");
	
	QnaDao dao = QnaDao.getInstance();
	System.out.println("command : " + command);
	if(command.equals("memberlist")){
		String email = request.getParameter("email");
		
		 
		
		
		String search_div = (request.getParameter("search_div")==null||request.getParameter("search_div")=="")?"":request.getParameter("search_div");
		String search_word =(request.getParameter("search_word")==null||request.getParameter("search_word")=="")?"":request.getParameter("search_word");
		String pageNumStr = (request.getParameter("pageNum")==null||request.getParameter("pageNum")=="")?"1":request.getParameter("pageNum");
		System.out.println("서치다이브" + search_div);
		System.out.println("서치워드" + search_word);
		
		int pageNum = Integer.parseInt(pageNumStr);
		String pageSize = "4";	//페이지 사이즈 변경!!
		int page_Size = Integer.parseInt(pageSize);
		
		System.out.println(search_div);
		System.out.println(search_word);
		System.out.println(pageNum);
		
		ArrayList<Object> list = dao.do_search(email, pageNum, page_Size, search_div, search_word);
		
		
		
		request.setAttribute("list", list);
		request.setAttribute("pageNum", pageNumStr);
		request.setAttribute("pageSize", pageSize);
		request.setAttribute("search_div", search_div);
		request.setAttribute("search_word", search_word);
		pageContext.forward("ya_memberQnaList.jsp");
	}else if(command.equals("register")){
		String email = request.getParameter("email");
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		
		Ya_QnaBean bean = new Ya_QnaBean();
		bean.setEmail(email);
		bean.setTitle(title);
		bean.setContent(content);
		
		System.out.println("------------------------------email : " + email);
		if(dao.do_insert(bean)){
			pageContext.forward("qnaControl.jsp?command=memberlist");
		}else{
			
			System.out.println("문의실패");
		}
	}else if(command.equals("detail")){
		String seqStr = request.getParameter("seq");
		int seq = Integer.parseInt(seqStr);
		
		Ya_QnaBean bean = new Ya_QnaBean();
		
		bean = (Ya_QnaBean)dao.do_detail(seq);
		
		request.setAttribute("detail", bean);
		
		pageContext.forward("ya_qnaDetail.jsp");
	}else if(command.equals("answer")){
		String seqStr = request.getParameter("seq");
		int seq = Integer.parseInt(seqStr);
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		String email = request.getParameter("email");
		
		Ya_QnaBean bean = new Ya_QnaBean();
		bean.setTitle(title);
		bean.setContent(content);
		bean.setEmail(email);
		
		dao.do_answer(seq, bean);
		
		pageContext.forward("qnaControl.jsp?command=adminlist");
	}else if(command.equals("adminlist")){
		
		String pageNumStr = (request.getParameter("pageNum")==null||request.getParameter("pageNum")=="")?"1":request.getParameter("pageNum");
		
		
		String search_div = (request.getParameter("search_div")==null||request.getParameter("search_div")=="")?"":request.getParameter("search_div");
		String search_word =(request.getParameter("search_word")==null||request.getParameter("search_word")=="")?"":request.getParameter("search_word");
		System.out.println("서치다이브" + search_div);
		System.out.println("서치워드" + search_word);
		
		int pageNum = Integer.parseInt(pageNumStr);
		String pageSize = "4";	//페이지 사이즈 변경!!
		int page_Size = Integer.parseInt(pageSize);
		
		System.out.println(search_div);
		System.out.println(search_word);
		System.out.println(pageNum);
		
		ArrayList<Object> list = dao.do_search(pageNum, page_Size, search_div, search_word);
		
		
		request.setAttribute("list", list);
		request.setAttribute("pageNum", pageNumStr);
		request.setAttribute("pageSize", pageSize);
		request.setAttribute("search_div", search_div);
		request.setAttribute("search_word", search_word);
		pageContext.forward("ya_adminQnaAll.jsp");
	}else if(command.equals("adminnoanswer")){
		
		String pageNumStr = (request.getParameter("pageNum")==null||request.getParameter("pageNum")=="")?"1":request.getParameter("pageNum");
		
		
		String search_div = (request.getParameter("search_div")==null||request.getParameter("search_div")=="")?"":request.getParameter("search_div");
		String search_word =(request.getParameter("search_word")==null||request.getParameter("search_word")=="")?"":request.getParameter("search_word");
		System.out.println("서치다이브" + search_div);
		System.out.println("서치워드" + search_word);
		
		int pageNum = Integer.parseInt(pageNumStr);
		String pageSize = "4";	//페이지 사이즈 변경!!
		int page_Size = Integer.parseInt(pageSize);
		
		System.out.println(search_div);
		System.out.println(search_word);
		System.out.println(pageNum);
		
		ArrayList<Object> list = dao.do_search_notAnswer(pageNum, page_Size, search_div, search_word);
		
		request.setAttribute("list", list);
		request.setAttribute("pageNum", pageNumStr);
		request.setAttribute("pageSize", pageSize);
		request.setAttribute("search_div", search_div);
		request.setAttribute("search_word", search_word);
		pageContext.forward("ya_notanswerList.jsp");
	}else if(command.equals("delete")){
		String seqStr = request.getParameter("seq");
		String email = request.getParameter("email");
		System.out.println("이메일" + email);
		int seq = Integer.parseInt(seqStr);
		
		Ya_QnaBean bean = new Ya_QnaBean();
		bean.setSeq(seq);
		
		System.out.println("순번순번순번-------------:" + seq);
		
		boolean b= dao.do_delete(bean);
		
		
		if(b){
			System.out.println("삭제성공");
		}else{
			System.out.println("삭제실패");
		}
		
		request.setAttribute("email", email);
		pageContext.forward("qnaControl.jsp?command=memberlist");
	}
	
	
%>