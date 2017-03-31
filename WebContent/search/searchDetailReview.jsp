<%@page import="com.Beans.Ya_ReviewBean"%>
<%@page import="java.util.List"%>
<%@ page pageEncoding="UTF-8" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%
request.setCharacterEncoding("UTF-8");
%>
<%!
public String arrow(int depth){
	String rs = "<img src='../img/arrow.png' width='50px' height='50px'>";
	String nbsp = "&nbsp;&nbsp;&nbsp;&nbsp;"; // 한칸씩 떨어트리는 규격 
	String ts="";
	for(int i=0; i<depth; i++){
		ts += nbsp;
	}
			// 0이라는건 첫번째 글이라는것 // 0이 아니면 답글이니깐 사진을 넣어라 
	return depth == 0 ? "":ts + rs;
}

public String star(int score){
	String star = "";
		if(score<4 && score>=2){
			star = "<img src='../img/pointstar.png' width='30px' height='30px'>&nbsp;"
				 + "<img src='../img/empty.png' width='30px' height='30px'>&nbsp;"
				 + "<img src='../img/empty.png' width='30px' height='30px'>&nbsp;"
				 + "<img src='../img/empty.png' width='30px' height='30px'>&nbsp;"
				 + "<img src='../img/empty.png' width='30px' height='30px'>&nbsp;";
		}else if(score<6 && score>=4){
			star = "<img src='../img/pointstar.png' width='30px' height='30px'>&nbsp;"
					 + "<img src='../img/pointstar.png' width='30px' height='30px'>&nbsp;"
					 + "<img src='../img/empty.png' width='30px' height='30px'>&nbsp;"
					 + "<img src='../img/empty.png' width='30px' height='30px'>&nbsp;"
					 + "<img src='../img/empty.png' width='30px' height='30px'>&nbsp;";
		}else if(score<8&&score>=6){
			star = "<img src='../img/pointstar.png' width='30px' height='30px'>&nbsp;"
					 + "<img src='../img/pointstar.png' width='30px' height='30px'>&nbsp;"
					 + "<img src='../img/pointstar.png' width='30px' height='30px'>&nbsp;"
					 + "<img src='../img/empty.png' width='30px' height='30px'>&nbsp;"
					 + "<img src='../img/empty.png' width='30px' height='30px'>&nbsp;";
		}else if(score<10&&score>=8){
			star = "<img src='../img/pointstar.png' width='30px' height='30px'>&nbsp;"
					 + "<img src='../img/pointstar.png' width='30px' height='30px'>&nbsp;"
					 + "<img src='../img/pointstar.png' width='30px' height='30px'>&nbsp;"
					 + "<img src='../img/pointstar.png' width='30px' height='30px'>&nbsp;"
					 + "<img src='../img/empty.png' width='30px' height='30px'>&nbsp;";
		}else if(score>8&&score<=10){
			star = "<img src='../img/pointstar.png' width='30px' height='30px'>&nbsp;"
					 + "<img src='../img/pointstar.png' width='30px' height='30px'>&nbsp;"
					 + "<img src='../img/pointstar.png' width='30px' height='30px'>&nbsp;"
					 + "<img src='../img/pointstar.png' width='30px' height='30px'>&nbsp;"
					 + "<img src='../img/pointstar.png' width='30px' height='30px'>&nbsp;";
		}
	return star;
}

%>
<%//
 List<Ya_ReviewBean> list = (List<Ya_ReviewBean>)request.getAttribute("list");
String motelName = request.getParameter("motelName");
 
//%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<script type="text/javascript">
</script>
<style>
</style>
</head>
<body>
<h1>리뷰</h1>
<hr>
<div style=" width: 100%; float: left; text-align: left">
<% 
if(list!=null){
	
int cleanscore=0;
int facilityscore=0;
int servicescore=0;
for(int i=0;i<list.size();i++){ 
facilityscore += list.get(i).getFacility();
cleanscore += list.get(i).getClean();
servicescore += list.get(i).getService();
} 
%>
평균 : <%=star((facilityscore+cleanscore+servicescore)/(list.size()*3)) %>&nbsp;&nbsp;&nbsp;
시설점수 : <%=star(facilityscore/list.size()) %>&nbsp;&nbsp;&nbsp;
청결점수 : <%=star(cleanscore/list.size()) %>&nbsp;&nbsp;&nbsp;
서비스점수 : <%=star(servicescore/list.size()) %>&nbsp;&nbsp;&nbsp;
<hr><hr>
</div>

<%
for (int i=0; i<list.size(); i++){ %>
<%--원본글 --%>
<%if(list.get(i).getDepth()==0){ %>
<div style=" width: 80%; float: left; text-align: left">
시설점수 : <%=star(list.get(i).getFacility()) %>
청결점수 : <%=star(list.get(i).getClean()) %>
서비스점수 : <%=star(list.get(i).getService()) %>
<br>
닉네임 : <%=list.get(i).getNickname() %><br><br>
내용 : <%=list.get(i).getContent() %><br>
날짜 : <%=list.get(i).getUpload_dt() %><br>
<hr>
</div>

<br>
<%--답글 --%>

<%}if(list.get(i).getDepth()>0){ %>
<div style="background-color:lightgray; float: left; width: 80%; margin: auto; text-align: left">
<%=arrow(list.get(i).getDepth()) %>
<%=motelName %>사장님의 답글 <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;내용 : <%=list.get(i).getContent() %><br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;날짜 : <%=list.get(i).getUpload_dt() %><br>
</div>
<br><br>
<%
	}
}
%>

<table style="width: 50%; margin: auto;">
		<col width="222"/><col width="222"/><col width="222"/>
    	<col width="222"/><col width="222"/><col width="222"/>
    	<col width="222"/><col width="222"/><col width="222"/>
    <tr>
    	<td colspan="9" align="center">
    	
    	<%
    	String str = " ";
    	int pageCount = list.get(0).getTot_cnt()%4 > 0 ? (list.get(0).getTot_cnt()/4)+1 : (list.get(0).getTot_cnt()/4); 
    	for(int i=0; i<pageCount;i++){
    	%>
    	<a href="javascript:;" onclick= "location.href='searchControll.jsp?command=detailAf&type=review&pageNum=<%=i+1 %>&motel_num=<%=list.get(0).getMotel_num() %>'" >
    	<font size="5">
    	<%=i+1 %><%=str %>
    	<%} %>
    	</font>
    	</a>
    	</td>
    </tr>
	
	
	</table>
	<%
	
	}else{ %>
	
	
	<div style="width: 100%; height: 700px; text-align: center; margin-top: 400px;">
	<h1>리뷰가 없습니다.</h1>
	</div>
	
	<%
	}
	%>
</body>
</html>