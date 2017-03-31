<%@page import="com.Beans.Ya_MemberBean"%>
<%@page import="com.Beans.Ya_ZzimBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	ArrayList<Ya_ZzimBean> list = (ArrayList<Ya_ZzimBean>)request.getAttribute("zzimlist"); 
	Ya_MemberBean memberBean =(Ya_MemberBean)session.getAttribute("member");
%>
<style>
<!--
table {
border-spacing: 10px;
border-collapse: separate;
}

-->
</style>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	if(list!=null && !(list.size()==0)){
%>
	<center>
		<table>
			<col width="150px" />
			<col width="150px" />
			<col width="150px" />
			<col width="150px" />
			<col width="150px" />
			<col width="150px" />
			<tr>
				<td colspan="2" style="border-bottom: 1px solid black"><h3><%=memberBean.getNickname()%>
						님 의 찜내역
					</h3></td>
				<td colspan="3" style="border-bottom: 1px solid black"></td>
				<td style="border-bottom: 1px solid black"><h3><%=list.get(0).getTot_cnt()%>개
					</h3></td>
			</tr>
			<tr>
				<td colspan="6" style="padding-bottom: 10px"></td>
			</tr>
			<tr>
				<%
					for (int i = 0; i < list.size(); ++i) {
				%>
				<td style="border-left: 1px solid #ffc4b7; border-bottom: 1px solid #ffc4b7; border-top: 1px solid #ffc4b7 "><a href="../search/searchControll.jsp?command=detail&motel_num=<%=list.get(i).getMotel_num() %>"><img src="<%=list.get(i).getImg_name()%>" width="180px"
					height="180px"></a></td>
				<td style="text-align: left; border-right: 1px solid #ffc4b7; border-bottom: 1px solid #ffc4b7; border-top: 1px solid #ffc4b7 "><%=list.get(i).getName()%><br>
				<br> <%=list.get(i).getAddress()%><br> 일반실 : <%=list.get(i).getNormal_pri()%>원
					<br> 특 실 : <%=list.get(i).getPremium_pri()%>원</td>
				<%
					if ((i+1) % 3 == 0)
								break;
						}
				%>
			<tr>
				<td colspan="6" style="padding-bottom: 10px"></td>
			</tr>
			</tr>
			<%
				if (list.size() > 3) {
			%>
			<tr>
				<%
					for (int i = 3; i < list.size(); ++i) {
				%>
				<td style="border-left: 1px solid #ffc4b7; border-bottom: 1px solid #ffc4b7; border-top: 1px solid #ffc4b7 "><a href="../search/searchControll.jsp?command=detail&motel_num=<%=list.get(i).getMotel_num() %>"><img src="<%=list.get(i).getImg_name()%>" width="180px"
					height="180px"></a></td>
				<td style="text-align: left; border-right: 1px solid #ffc4b7; border-bottom: 1px solid #ffc4b7; border-top: 1px solid #ffc4b7 "><%=list.get(i).getName()%><br>
				<br> <%=list.get(i).getAddress()%><br> 일반실 : <%=list.get(i).getNormal_pri()%>원
					<br> 특 실 : <%=list.get(i).getPremium_pri()%>원</td>
				<%
					if ((i+1) % 3 == 0)
								break;
						}
				%>
			</tr>
			<%
				}
			%>
		</table>
		<%
			int count = (int)Math.ceil(list.get(0).getTot_cnt() / 6);
				for (int i = 0; i <= count; ++i) {
		%>
		<a
			href="mypage_Control.jsp?command=guestzzimlist&email=<%=memberBean.getEmail()%>&value=after&pageNum=<%= i+1%>"><%=i+1 %></a>
		<%
		}	
	%>
	</center>
<%
	}else{
%>

<center>
		<table>
			<col width="150px" /><col width="150px" /><col width="150px" />
			<col width="150px" /><col width="150px" /><col width="150px" />
			<tr>
				<td colspan="2"><h3><%=memberBean.getNickname()%>님 의 찜내역	</h3></td>
				<td colspan="3"></td>
				<td><h3>0개</h3></td>
			</tr>
			<tr>
				<td colspan="6"><h4>찜한 내역이 없습니다.</h4></td>
			</tr>
		</table>
	</center>
	
	<%
	}
	%>
</body>
</html>