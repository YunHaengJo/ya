<%@page import="com.Beans.Ya_ZzimBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.Dao.ZzimDao"%>
<%@page import="com.Beans.Ya_MemberBean"%>
<%@page import="com.Beans.Ya_MotelBean"%>
<%@ page pageEncoding="UTF-8" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%
request.setCharacterEncoding("UTF-8");
%>
<%!//
//%>
<%//
String contents = "";
String contentsDiv = request.getParameter("contentsDiv");
System.out.println(contentsDiv);
Ya_MotelBean dto = (Ya_MotelBean)request.getAttribute("dto");

if(contentsDiv==null) contents = "searchDetailRoom.jsp";
else if(contentsDiv.equals("room")) contents = "searchDetailRoom.jsp";
else if(contentsDiv.equals("pay")) contents = "searchDetailPay.jsp";
else if(contentsDiv.equals("review")) contents = "searchDetailReview.jsp?motelName="+dto.getName();



//%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<!-- prevent IE6 flickering -->
<script type="text/javascript">
    try {
        document.execCommand('BackgroundImageCache', false, true);
    } catch (e) {
    }
    
    function no_log(){
    	alert("로그인 해주세요.");
    }
</script>

<title>Insert title here</title>
<style type="text/css">
	.header{
		position : fixed;
		height : 100px;
		background: #fc676e;
	}
	.foot{
		height : 200px;
		background: #3f3e3e;
	}
	.blank{
		height: 100px;
	}	.location{
		padding-top : 50px;
		height: 300px;
	}
	.popular{
		height: 300px;
	}
	table,tr,td{
		text-align: center;
		/* border: 1px solid black */
	}
	img:hover{
		opacity: 0.5;
	}
	
	.tabl{
		width: 60%;
		height: 100px;
		margin: auto;
		text-align: center;
	}
	
	.tabl01{
		width: 80%;
		height: 100px;
		margin: auto;
		text-align: center;
	}
	.btn3:hover{
		background-color: #ffd8f3;
		color: white;
	}
	.btn3:ACTIVE {
		background-color: #bababa;
		color: white;
	}
	
</style>
</head>
<body>
<!-- Top -->
	<jsp:include page="../super/superTop.jsp"></jsp:include>
<!-- 빈곳   -->	
	<div class="blank">
	<table>
		<col width="222"/><col width="222"/><col width="222"/>
    	<col width="222"/><col width="222"/><col width="222"/>
    	<col width="222"/><col width="222"/><col width="222"/>
    	<tr>
    		<td></td>
    		<td colspan="7">________</td>
    		<td></td>
    	</tr>
	</table>
	</div>
<%-- 콘텐트 --%>	
	
<br>
	<table class="tabl01" border="1" >
		<col width="222" /><col width="222" /><col width="222" />
		<col width="222" /><col width="222" /><col width="222" />
		<col width="222" /><col width="222" /><col width="222" />
    	<tr>
    		
    		<td height="400" align="center" colspan="4">
    		
    		<% 
    		// 찜 내역
    		if(session.getAttribute("member")!=null){ 
    			Ya_MemberBean memdt = (Ya_MemberBean)session.getAttribute("member");
    			ZzimDao dao = ZzimDao.getInstance();
    			ArrayList<Ya_ZzimBean> list = dao.logZzim(memdt.getEmail());
    		%>	
    			<a id="zzimlink" href="searchControll.jsp?command=ZZIM&motelNum=<%=dto.getMotel_num() %>&email=<%=memdt.getEmail()%>">
        		<img id="zzimimg" alt="사진이 없습니다." src="../img/ZZIM1.PNG" width="100px" height="140px">
        		</a>
        		
        		<input type="hidden" id="motelNum" value="<%=dto.getMotel_num() %>">
        		<input type="hidden" id="email" value="<%=memdt.getEmail()%>">
    			
    		<%	
    			for(int i =0; i<list.size();i++){
    				if(list.get(i).getMotel_num()==dto.getMotel_num()){
    		%>
    		<script type="text/javascript">
    			
    		$("#zzimlink").attr("href","searchControll.jsp?command=ZZIMdelete&motelNum="+$("#motelNum").val()+"&email="+$("#email").val())
    		$("#zzimimg").attr("src", "../img/ZZIM.PNG")
    		
    		</script>
    		
    		<% 		
    		}    	
    		  } // for 문 %>
    		
    			
    			
    		<%	}else{ // 로그인 안했을 때 
    		%>
    			<a href="javascript:;" onclick=no_log()>
        		<img alt="사진이 없습니다." src="../img/ZZIM1.PNG" width="100px" height="140px" >
        		</a>
    		<% } %>
    		
    		<p><font face="맑은 고딕" size="15"><%=dto.getName() %></font></p>
    		<p><img src="../img/address.png" width="20px" height="20px"> 주소 : <%=dto.getAddress() %></p>
    		<p><img src="../img/mobile.png" width="20px" height="20px"> 연락처 : <%=dto.getPhone() %></p>
    		</td>
    		
    		<td colspan="5">
    		
			<div id="testMap" style=" width:1000px; height:400px;"></div>
	
    		</td>
    		
    	</tr>    	
	</table>	
	
	<table class="tabl01" border="1">
		<col width="222" /><col width="222" /><col width="222" />
		<col width="222" /><col width="222" /><col width="222" />
		<col width="222" /><col width="222" /><col width="222" />
		<tr>
			<td class="btn3" colspan="3" height="80" style="cursor:pointer" 
			onclick="location.href='searchControll.jsp?command=detailAf&type=room&motel_num=<%=dto.getMotel_num() %>'" >객실정보</td>
			<td class="btn3" colspan="3" height="80" style="cursor:pointer" 
			onclick="location.href='searchControll.jsp?command=detailAf&type=pay&motel_num=<%=dto.getMotel_num() %>'" >요금 및 시간</td>
			<td class="btn3" colspan="3" height="80" style="cursor:pointer" 
			onclick="location.href='searchControll.jsp?command=detailAf&type=review&motel_num=<%=dto.getMotel_num() %>'" >리뷰</td>
		</tr>
		
		<tr>
			<td colspan="9" height="750" valign="top">
				<jsp:include page="<%=contents %>"></jsp:include>
			</td>
		</tr>
	</table>
	
	
	<br>
	<script type="text/javascript">
    var oPoint = new nhn.api.map.LatLng(37.5552462,126.935164);
    nhn.api.map.setDefaultPoint('LatLng');
    oMap = new nhn.api.map.Map('testMap', {
        point: oPoint,
        zoom: 14,
        enableWheelZoom: true,
        enableDragPan: true,
        enableDblClickZoom: false,
        mapMode: 0,
        activateTrafficMap: false,
        activateBicycleMap: false, 
        minMaxLevel: [1, 14],
        size: new nhn.api.map.Size(900, 400)
    });
	</script>
	
<!--Foot -->
	<jsp:include page="../super/superFoot.jsp"></jsp:include>
</body>
</html>