<%@page import="com.Beans.Ya_ReviewBean"%>
<%@page import="com.Dao.ReviewDao"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Locale"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.Beans.Ya_MemberBean"%>
<%@page import="com.Beans.Ya_MotelBean"%>
<%@page import="com.Dao.MemberDao"%>
<%@page import="com.Beans.Ya_ZzimBean"%>
<%@page import="com.Dao.ZzimDao"%>
<%@page import="com.Dao.ReserveDao"%>
<%@page import="com.Beans.Ya_ReserveBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.Dao.PointDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
	String command = request.getParameter("command");
	String value = request.getParameter("value");
	Ya_MemberBean memberBean = (Ya_MemberBean)session.getAttribute("member");
	  
	if(command.equals("guestzzimlist")){
		String email = request.getParameter("email");
		int pageSize = 6;
		System.out.println(value);
		
		if(value.equals("init")){
			int pageNum = 1;
			ZzimDao zzimDao = ZzimDao.getInstance();
			ArrayList<Ya_ZzimBean> list = zzimDao.do_getzzimlist(pageNum, pageSize, "", email);
			System.out.println("사이즈를 알아보자! : " + list.size());
			System.out.println("사이즈를 알아보자! : " + email);
			request.setAttribute("zzimlist", list);
		}else if(value.equals("after")){
			int pageNum = Integer.parseInt(request.getParameter("pageNum"));
			ZzimDao zzimDao = ZzimDao.getInstance();
			ArrayList<Ya_ZzimBean> list = new ArrayList<Ya_ZzimBean>();
			list = zzimDao.do_getzzimlist(pageNum, pageSize, "", email);
			request.setAttribute("zzimlist", list);			
		}
		pageContext.forward("mypage_Main.jsp?contentsDiv=guestzzimlist");
	
	}else if(command.equals("hostreviewlist")){
		int motelNum = memberBean.getMotel_num();
		String page_size = "1";	//페이지 사이즈 변경!!
		int pageSize = Integer.parseInt(page_size);
		System.out.println(value);
		
		if(value.equals("init")){
			int pageNum = 1;
			ReviewDao reviewDao = ReviewDao.getInstance();
			ArrayList<Ya_ReviewBean> list = reviewDao.do_search(pageNum, pageSize, motelNum);
			System.out.println("사이즈를 알아보자! : " + list.size());
			request.setAttribute("reviewlist", list);
			request.setAttribute("pageSize", pageSize);
		}else if(value.equals("after")){
			int pageNum = request.getParameter("pageNum") == "" || request.getParameter("pageNum") == null ? 1 : Integer.parseInt(request.getParameter("pageNum"));
			ReviewDao reviewDao = ReviewDao.getInstance();
			ArrayList<Ya_ReviewBean> list = reviewDao.do_search(pageNum, pageSize, motelNum);
			System.out.println("사이즈를 알아보자! : " + list.size());
			request.setAttribute("reviewlist", list);
			request.setAttribute("pageSize", pageSize);
		}
		pageContext.forward("mypage_Main.jsp?contentsDiv=hostreviewlist");
	}else if(command.equals("guestpointlist")){
		
		String email = request.getParameter("email");
		int pageSize = 5;
		
		if(value.equals("init")){
			int pageNum = 1;
			PointDao pdao = PointDao.getInstance();
			ArrayList<Ya_ReserveBean> bean_list = new ArrayList<Ya_ReserveBean>();
			bean_list = pdao.do_getpointlist(pageNum, pageSize, email);
			request.setAttribute("bean_list", bean_list);
		}else if(value.equals("after")){
			int pageNum = Integer.parseInt(request.getParameter("pageNum"));
			PointDao pdao = PointDao.getInstance();
			ArrayList<Ya_ReserveBean> bean_list = new ArrayList<Ya_ReserveBean>();
			bean_list = pdao.do_getpointlist(pageNum, pageSize, email);
			request.setAttribute("bean_list", bean_list);
		}
		pageContext.forward("mypage_Main.jsp?contentsDiv=guestpointlist");
	}else if(command.equals("guestreservelist")){
		pageContext.forward("mypage_Main.jsp?contentsDiv=guestreservelist");
	}else if(command.equals("guestmemupdate")){
		pageContext.forward("mypage_Main.jsp?contentsDiv=guestmemupdate");
	}else if(command.equals("hostmotelupdate")){
		pageContext.forward("mypage_Main.jsp?contentsDiv=hostmotelupdate");
	}else if(command.equals("hostreservelist")){
		String email = request.getParameter("email");
		int pageSize = 5;
		int m_num = memberBean.getMotel_num();
		if(value.equals("init")){
			SimpleDateFormat formatter = new SimpleDateFormat ( "yyyy/MM/dd", Locale.KOREA );
			Date currentTime = new Date();
			Date yestTime = new Date();
			yestTime.setTime(new Date().getTime() - (1 * 24 * 60 * 60 * 1000));

			String dTime = formatter.format ( currentTime );
			String yTime = formatter.format ( yestTime );
			
			int pageNum = 1;
			ReserveDao reserveDao = ReserveDao.getInstance();
			ArrayList<Ya_ReserveBean> reservelist = new ArrayList<Ya_ReserveBean>();
			reservelist = reserveDao.do_host_getlist(pageNum, pageSize, m_num, yTime, dTime);
			System.out.println("예약내역 : " + reservelist.size());
			request.setAttribute("reservelist", reservelist);
		}else if(value.equals("after")){
			int pageNum = Integer.parseInt(request.getParameter("pageNum"));
			String date1 = request.getParameter("date1");
			String date2 = request.getParameter("date2");
			ReserveDao reserveDao = ReserveDao.getInstance();
			ArrayList<Ya_ReserveBean> reservelist = new ArrayList<Ya_ReserveBean>();
			reservelist = reserveDao.do_host_getlist(pageNum, pageSize, m_num, date1, date2);
			request.setAttribute("reservelist", reservelist);
		}
		pageContext.forward("mypage_Main.jsp?contentsDiv=hostreservelist");
	}else if(command.equals("hostreviewlist")){
		pageContext.forward("mypage_Main.jsp?contentsDiv=hostreviewlist");
	}else if(command.equals("adminAdmission")){
		MemberDao dao = MemberDao.getInstance();
		
		String pageNumStr = (request.getParameter("pageNum")==null||request.getParameter("pageNum")=="")?"1":request.getParameter("pageNum");
		String search_div = (request.getParameter("search_div")==null||request.getParameter("search_div")=="")?"":request.getParameter("search_div");
		String search_word =(request.getParameter("search_word")==null||request.getParameter("search_word")=="")?"":request.getParameter("search_word");
		
		
		int pageNum = Integer.parseInt(pageNumStr);
		String pageSize = "1";	//페이지 사이즈 변경!!
		int page_Size = Integer.parseInt(pageSize);
		
		System.out.println(search_div);
		System.out.println(search_word);
		System.out.println(pageNum);
		
		ArrayList<Object> list = dao.do_search_notIsOk(pageNum, page_Size, search_div, search_word);
		
		if(list.size()==0){
			
			System.out.println("걸린거임 ");
			pageContext.forward("mypage_Main.jsp?contentsDiv=adminAdmission");
			
		}else{
			request.setAttribute("list", list);
			request.setAttribute("pageNum", pageNumStr);
			request.setAttribute("pageSize", pageSize);
			request.setAttribute("search_div", search_div);
			request.setAttribute("search_word", search_word);
			
			pageContext.forward("mypage_Main.jsp?contentsDiv=adminAdmission");
		}
	}else if(command.equals("detail")){
		MemberDao dao = MemberDao.getInstance();
		
		String email = request.getParameter("email");
		
		int seq = dao.search_motelNum(email);
		
		//System.out.println("중요포인트ㅡ으으으으 : " + email);
		
		Ya_MotelBean motel = (Ya_MotelBean)dao.do_detail(seq);
		
		request.setAttribute("motel", motel);
		
		pageContext.forward("mypage_Main.jsp?contentsDiv=detail");
	}else if(command.equals("access")){
		MemberDao dao = MemberDao.getInstance();
		String m = request.getParameter("email");
		System.out.println("들어온 이메일 : " + m);
		
		if(dao.do_admin_access(m)){
			System.out.println("승인성공!!");
			pageContext.forward("mypage_Control.jsp?command=adminAdmission");
		}
	}else if(command.equals("reviewAnswer")){
		int seq = Integer.parseInt(request.getParameter("seq"));
		int motel_num = Integer.parseInt(request.getParameter("motel_num"));
		String nickname = request.getParameter("nickname");
		String reply = request.getParameter("reply");
		int clean = Integer.parseInt(request.getParameter("clean"));
		int facility = Integer.parseInt(request.getParameter("facility"));
		int service = Integer.parseInt(request.getParameter("service"));
		
		System.out.println("씨이큐~~~ : " + seq);
		System.out.println("모텔넘~~~ : " + motel_num);
		System.out.println("닉네엠~~~ : " + nickname);
		System.out.println("컨텐츠~~~ : " + reply);
		System.out.println("청결점수~ : " + clean);
		System.out.println("시설점수~~~ : " + facility);
		System.out.println("서비스점수~~~ : " + service);
		
		
		Ya_ReviewBean bean = new Ya_ReviewBean();
		bean.setSeq(seq);
		bean.setMotel_num(motel_num);
		bean.setNickname(nickname);
		bean.setContent(reply);
		bean.setClean(clean);
		bean.setFacility(facility);
		bean.setService(service);
		
		ReviewDao dao = ReviewDao.getInstance();
		
		dao.do_upsert(bean);
		
		pageContext.forward("mypage_Control.jsp?command=hostreviewlist&value=after");
	}
%>

</body>
</html>









