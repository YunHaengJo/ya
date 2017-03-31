<%@page import="java.util.HashMap"%>
<%@page import="com.Dao.MyPageDao"%>
<%@page import="com.Beans.Ya_ReserveBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	ArrayList<Ya_ReserveBean> bean_list = (ArrayList<Ya_ReserveBean>)request.getAttribute("bean_list");
	String email = request.getParameter("email");
	
	MyPageDao mpdao = MyPageDao.getInstance();
	HashMap<String,Integer> map = new HashMap<String,Integer>();
	map = mpdao.do_count_member_state(email);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<div>
<center>
<table border="1">
<col width="200"/><col width="500"/>
	<tr>
		<td height="50" style="text-align: center;"><h4><b>내포인트</b></h4></td>
		<td height="50" style="text-align: right; padding-right: 100px"><%=map.get("point")==null?0:map.get("point") %> 원</td>
	</tr>
</table>
</center>
</div>

<div style="padding-top: 30px">
<center>
<table border="1" bordercolor="#000000">
<col width="200"/><col width="200"/><col width="100"/><col width="200"/>
	<tr bgcolor="#808000" height="30">
		<th style="text-align: center;"><b>일자</b></th>
		<th style="text-align: center;"><b>상세정보</b></th>
		<th style="text-align: center;"><b>구분</b></th>
		<th style="text-align: center;"><b>포인트</b></th>
	</tr>
<%
	if(bean_list != null || bean_list.size() !=0){
		for(int i=0;i<bean_list.size();i++){
			Ya_ReserveBean bean = new Ya_ReserveBean();
			bean = bean_list.get(i);
			if(bean.getState() ==0){
				if(bean.getPoint() != 0){
			%>
				<tr height="30">
					<td><%=bean.getUse_dt() %></td>
					<td><%=bean.getMt_name() %></td>
					<td>차감</td>
					<td><%=bean.getPoint() %></td>
				</tr>
				<%} %>
			<%}else if(bean.getState() ==1){
				if(bean.getPoint() != 0){
					%>
						<tr height="30">
							<td><%=bean.getUse_dt() %></td>
							<td><%=bean.getMt_name() %></td>
							<td>차감</td>
							<td><%=bean.getPoint()%></td>
						</tr>
				<%} 
				if(bean.getPrice()-bean.getPoint() != 0){
				%>
					<tr height="30">
						<td><%=bean.getUse_dt() %></td>
						<td><%=bean.getMt_name() %></td>
						<td>지급</td>
						<td><%=(bean.getPrice()-bean.getPoint())/10%></td>
					</tr>
			<%	} %>
			<%}else if(bean.getState() ==2){	
			if(bean.getPoint() != 0){
			%>
				<tr height="30">
					<td><%=bean.getUse_dt() %></td>
					<td><%=bean.getMt_name() %></td>
					<td>지급</td>
					<td><%=bean.getPoint() %></td>
				</tr>
				<tr height="30">
					<td><%=bean.getUse_dt() %></td>
					<td><%=bean.getMt_name() %></td>
					<td>차감</td>
					<td><%=bean.getPoint() %></td>
				</tr>
				<%} %>
<%		}
	}
	}
%>
</table>
</center>
</div>
<div>
<center>
<table style="width: 50%; margin: auto;">
	<col width="222"/><col width="222"/><col width="222"/>
   	<col width="222"/><col width="222"/><col width="222"/>
   	<col width="222"/><col width="222"/><col width="222"/>
    <tr>
    	<td colspan="9" align="center">
    	<%
    	String str = " ";
    	int pageCount = 0;
    	if(bean_list.size()!=0){
    		pageCount = bean_list.get(0).getTot_cnt()%5 > 0 ? (bean_list.get(0).getTot_cnt()/5)+1 : (bean_list.get(0).getTot_cnt()/5); 
    	}else{
    		pageCount = 1;
    	}
    	for(int i=0; i<pageCount;i++){
    	%>
    	<a href="javascript:;" onclick= "location.href='mypage_Control.jsp?command=guestpointlist&value=after&pageNum=<%=i+1 %>&email=<%=email%>'" >
    	<font size="3">
    	<%=i+1 %><%=str %>
    	<%} %>
    	</font>
    	</a>
    	</td>
    </tr>

	</table>
</center>
</div>
	
</body>
</html>