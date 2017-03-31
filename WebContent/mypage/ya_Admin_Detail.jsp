<%@page import="com.Beans.Ya_ImgBean"%>
<%@page import="java.util.List"%>
<%@page import="com.Dao.MemberDao"%>
<%@page import="com.Beans.Ya_MotelBean"%>
<%@page import="com.Dao.MotelDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.Beans.Ya_MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%
ArrayList<Object> list = (ArrayList<Object>)request.getAttribute("list");
String pageNumStr = (request.getAttribute("pageNum")==null||request.getAttribute("pageNum")=="")?"1":(String)request.getAttribute("pageNum");
String pageSizeStr = (request.getAttribute("pageSize")==null||request.getAttribute("pageSize")=="")?"1":(String)request.getAttribute("pageSize");
String search_div = (request.getAttribute("search_div")==null||request.getAttribute("search_div")=="")?"":(String)request.getAttribute("search_div");
String search_word = (request.getAttribute("search_word")==null||request.getAttribute("search_word")=="")?"":(String)request.getAttribute("search_word");
Ya_MemberBean user = (Ya_MemberBean)session.getAttribute("member");


/* System.out.println("리스트으으으으 :  " + list.get(0).toString());
System.out.println("페이지너어어어엄 : " + pageNumStr);
System.out.println("페이지싸이즈으으으 : " + pageSizeStr);
System.out.println("써치다이이이브 : " + search_div);
System.out.println("써치워어어어드 : " + search_word); */
%>
<%
	MotelDao motelDao = MotelDao.getInstance();
	Ya_MotelBean motel = (Ya_MotelBean)request.getAttribute("motel");
	
	MemberDao imgdao = MemberDao.getInstance();
	List<Ya_ImgBean> imglist = imgdao.do_detail_photo(motel.getMotel_num());
%>
</head>
<body>
<table style="border: 0; border-collapse:collapse; margin-top: 22px; width: 1000px; height: 100px; background-color: #ededed">
        <col width="50"><col width="400"><col width="100"><col width="350">
        <tr>
        	<td style="border-bottom: 3px solid #a0a0a0;"></td>
        	<td colspan="4" align="left" valign="center" style="border-bottom: 3px solid #a0a0a0; text-align: left;"><h3><b>회원 승인내역</b></h3></td>
        	<td style="border-bottom: 3px solid #a0a0a0;"></td>
        	<td style="border-bottom: 3px solid #a0a0a0;"></td>
        </tr>
        </table>
        
        <div class="container" style="width: 550px">
	  <form name="myForm" method="post" action="mypage_Control.jsp?command=access">
	    <div class="input-group">
	     <input id="email" type="hidden" name="email" value=<%=motel.getEmail() %>>
	      <span class="input-group-addon"><i class="glyphicon glyphicon-home"></i></span>
	      <input id="motel" type="text" class="form-control" name="motel" style="width: 605px; height: 50px" value="<%=motel.getName() %>" readonly="readonly">
	    </div>
	    <p></p>
	    <div class="input-group">
	      <span class="input-group-addon"><i class="glyphicon glyphicon-map-marker"></i></span>
	      <input id="address" type="text" class="form-control" name="address" style="width: 500px; height: 50px" value="<%=motel.getAddress() %>" readonly="readonly">
	      
	    </div>
	    <p></p>
	    <div class="input-group">
	      <span class="input-group-addon"><i class="glyphicon glyphicon-phone"></i></span>
	      <input id="phone" type="text" class="form-control" name="phone" style="width: 605px; height: 50px" value="<%=motel.getPhone() %>" readonly="readonly">
	    </div>
	    <p></p>
	    <div class="input-group">
	      <span class="input-group-addon"><i class="glyphicon glyphicon-time"></i></span>
	      <input id="phone" type="text" class="form-control" name="checkIn" style="width: 250px; height: 50px" value="<%=motel.getCheck_in() %>" readonly="readonly">
	      																								<%System.out.println(motel.getCheck_in()); %>												
	      <span class="input-group-addon"><i class="glyphicon glyphicon-time"></i></span>
	      <input id="phone" type="text" class="form-control" name="checkOut" style="width: 250px; height: 50px" value="<%=motel.getCheck_out() %>" readonly="readonly">
	    </div>
	    <p></p>
	    <div class="input-group">
	      <span class="input-group-addon"><i class="glyphicon glyphicon-usd"></i></span>
	      <input id="phone" type="text" class="form-control" name="normalPri" style="width: 250px; height: 50px" value="<%=motel.getNormal_pri()%>(일반실)" readonly="readonly">
	      <span class="input-group-addon"><i class="glyphicon glyphicon-usd"></i></span>
	      <input id="phone" type="text" class="form-control" name="normalPri" style="width: 250px; height: 50px" value="<%=motel.getPremium_pri()%>(특실)" readonly="readonly"> 
	    </div>
	    <p></p>
	    <div class="input-group">
	      <span class="input-group-addon"><i class="glyphicon glyphicon-th-large"></i></span>
	      <input id="phone" type="text" class="form-control" name="normalPri" style="width: 250px; height: 50px" value="<%=motel.getPremium_cnt()%>(일반실)" readonly="readonly">
	      <span class="input-group-addon"><i class="glyphicon glyphicon-th-large"></i></span>
	      <input id="phone" type="text" class="form-control" name="premiumPri" style="width: 250px; height: 50px" value="<%=motel.getPremium_cnt() %>(특실)" readonly="readonly">
	    </div>
	    <p></p>
	    <p></p>
			<p></p>
	    <div id="imgTable1" class="input-group">
	    
		   
		    <%
		    System.out.println("승인 리스트 사이즈 사진 사진 사진 " + imglist.size());
		    for(int i =0; i<imglist.size(); i++){
		    	
		    	if(imglist.get(i).getImg_auth() == 0){%>
		    		메인사진<img src="<%=imglist.get(i).getImg_name()%>" alt="이미지없음" width="100px" height="100px">
		    
		    <%	}
		    	
		    	if(imglist.get(i).getImg_auth() == 1){ %>
		    		일반실사진<img src="<%=imglist.get(i).getImg_name()%>" alt="이미지없음" width="100px" height="100px">
		    
		    <% }
		    	
		    	if(imglist.get(i).getImg_auth()==2){ %>
		    		특별실사진<img src="<%=imglist.get(i).getImg_name()%>" alt="이미지없음" width="100px" height="100px">
		    
		    <%}
	    	}
	   	
	    %>
	    </div>
	    <p></p>
	     <div id="imgTable2" class="input-group">
	    </div>
		<br>
	    <div class="input-group">
	     <input type="submit" class="btn btn-info" value="승인"
						style="background-color: #ff6b6b; font-size: 30px; width: 645px; height: 50px; border: 0; outline: 0">
	    </div>
	    <br>
	  </form>
	  <br>
	</div>
</body>
</html>