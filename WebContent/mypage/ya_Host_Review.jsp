<%@page import="com.Dao.ReviewDao"%>
<%@page import="com.Beans.Ya_ReviewBean"%>
<%@page import="com.Beans.Ya_MemberBean"%>
<%@page import="com.Beans.Ya_ZzimBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	ArrayList<Ya_ReviewBean> list = (ArrayList<Ya_ReviewBean>)request.getAttribute("reviewlist");
	Ya_MemberBean memberBean =(Ya_MemberBean)session.getAttribute("member");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">

</style>
<script type="text/javascript">
	function view() {
		document.getElementById("reply").style.display = "block";
		document.getElementById("arrow").style.display = "block";
		document.getElementById("inputBtn").style.display = "block";
	}
	
</script>
</head>
<body>
<%
	ReviewDao reviewdao = ReviewDao.getInstance();
	if(list!=null && !(list.size()==0)){
%>
	<center>
		<%for(int i=0; i<list.size(); ++i) {%>
		<table>
			<col width="130px" />
			<col width="130px" />
			<col width="130px" />
			<col width="130px" />
			<col width="130px" />
			<col width="130px" />
			<tr>
				<td colspan="3" style="border-bottom: 1px solid black"><h3><%=memberBean.getNickname()%>님 의 모텔에 대한 리뷰</h3></td>
				<td colspan="2" style="border-bottom: 1px solid black"></td>
				<td style="border-bottom: 1px solid black"><h3><%=list.get(0).getTot_cnt()%>개
			</tr>
			<tr>
				<td>작성자 </td>
				<td><%=list.get(i).getNickname() %></td>
				<td>작성일</td>
				<td colspan="2"><%=list.get(0).getUpload_dt() %></td>
				<td>
				<%System.out.println("seq : " +list.get(i).getSeq()); %>
				<%if(reviewdao.needAnswer(list.get(i).getSeq())){ %>
				<button type="button" onclick="view()">댓글달기</button>
				<%}%>
				</td>
			</tr>				
			<tr>
				<td style="border-bottom: 1px solid black">시설점수</td>
				<td style="border-bottom: 1px solid black">
					<%
						for(int j = 0; j < list.get(i).getFacility(); ++j){
					%>
					<img alt="" src="../img/star.png" height="10px" width="10px">
					<%
						}
					%>
				</td>
				<td style="border-bottom: 1px solid black">서비스점수</td>
				<td style="border-bottom: 1px solid black">
					<%
						for(int j = 0; j < list.get(i).getService(); ++j){
					%>
					<img alt="" src="../img/star.png" height="10px" width="10px">
					<%
						}
					%>
				</td>
				<td style="border-bottom: 1px solid black">청결점수</td>
				<td style="border-bottom: 1px solid black">
					<%
						for(int j = 0; j < list.get(i).getClean(); ++j){
					%>
					<img alt="" src="../img/star.png" height="10px" width="10px">
					<%
						}
					%>
				</td>
			</tr>
			<tr>
				<td colspan="6" height="100" colspan="2" valign="top" style="border-bottom: 1px solid #a0a0a0; text-align: left;"><%=list.get(i).getContent() %></td>
			</tr>
			<%if(!reviewdao.needAnswer(list.get(i).getSeq())){
				if(list.get(i).getStep() == 0){
					Ya_ReviewBean bean = reviewdao.get_answer(list.get(i).getReference());
			%>
				<tr>
					<td style="border-bottom: 1px solid gray"><img alt="" src="../img/arrow.png" style="display: block;" id="arrow"></td>
					<td style="border-bottom: 1px solid gray">작성자</td>
					<td style="border-bottom: 1px solid gray"><%= bean.getNickname()%></td>
					<td style="border-bottom: 1px solid gray">작성일</td>
					<td style="border-bottom: 1px solid gray"><%= bean.getUpload_dt()%></td>
					<td style="border-bottom: 1px solid gray"></td>	
				</tr>
				<tr>
					<td colspan="6" height="100" colspan="2" valign="top" style="border-bottom: 1px solid #a0a0a0; text-align: left;"><%=bean.getContent() %></td>
				</tr>
			<%}
			}%>
			<tr>
			<form action="mypage_Control.jsp" method="post">
			<input type="hidden" name="command" value="reviewAnswer">
			<input type="hidden" name="seq" value="<%=list.get(i).getSeq() %>">
			<input type="hidden" name="motel_num" value="<%=list.get(i).getMotel_num() %>">
			<input type="hidden" name="nickname" value="<%=memberBean.getNickname() %>">
			<input type="hidden" name="facility" value="<%=list.get(i).getFacility() %>">
			<input type="hidden" name="service" value="<%=list.get(i).getService()%>">
			<input type="hidden" name="clean" value="<%=list.get(i).getClean()%>">
				<td><img alt="" src="../img/arrow.png" style="display: none;" id="arrow"></td>
				<td colspan="4">
					<input type="textarea" id="reply" name="reply" style="display: none; width: 300px; height: 100px"/>
				</td>
				<td>
					<input type="submit" style="display: none;" id="inputBtn" value="입력">
				</td>
			</form>
			</tr>
		</table>
		<%
			int count = (int)Math.ceil(list.get(0).getTot_cnt() / 1);
				for (int k = 0; k < count; ++k) {
		%>
		<a
			href="mypage_Control.jsp?command=hostreviewlist&motelNum=<%=memberBean.getMotel_num()%>&value=after&pageNum=<%= k+1%>"><%=k+1 %></a>
		<%
			}	
		%>
	</center>
<%
		}
	}else{
%>

<center>
		<table>
			<col width="150px" /><col width="150px" /><col width="150px" />
			<col width="150px" /><col width="150px" /><col width="150px" />
			<tr>
				<td colspan="2"><h3><%=memberBean.getNickname()%>님 의 모텔에 대한 리뷰</h3></td>
				<td colspan="3"></td>
				<td><h3>0개</h3></td>
			</tr>
			<tr>
				<td colspan="6"><h4>리뷰가없습니다... 분발하세요</h4></td>
			</tr>
		</table>
	</center>
	
	<%
}
	%>
</body>
</html>