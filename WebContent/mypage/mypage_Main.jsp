<%@page import="com.Beans.Ya_ReviewBean"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.Beans.Ya_ZzimBean"%>
<%@page import="com.Dao.ZzimDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.Beans.Ya_MemberBean"%>
<%@page import="com.Dao.MyPageDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%	
	String email = "";
	int auth = 0; 
	
	Ya_MemberBean memberBean = (Ya_MemberBean)session.getAttribute("member");
	email = memberBean.getEmail();
	auth = memberBean.getAuth();
	
	MyPageDao mpdao = MyPageDao.getInstance();
	HashMap<String,Integer> map = new HashMap<String,Integer>();
	map = mpdao.do_count_member_state(email);

	String contents = "";
	String contentsDiv = request.getParameter("contentsDiv");
	System.out.println(contentsDiv);
	if(contentsDiv==null) contents = "mypage_Control.jsp?command=guestzzimlist&value=init&email="+email;
	else if(contentsDiv.equals("guestzzimlist")){
		contents = "../mypage/ya_Guest_Zzim.jsp";
		ArrayList<Ya_ZzimBean> list = new ArrayList<Ya_ZzimBean>();
		list = (ArrayList<Ya_ZzimBean>)request.getAttribute("zzimlist");
		request.setAttribute("zzimlist", list);		
	}
	else if(contentsDiv.equals("guestpointlist")) contents = "../mypage/ya_Guest_Point.jsp";
	else if(contentsDiv.equals("guestreservelist")) contents = "../mypage/ya_Guest_Reserve.jsp";
	else if(contentsDiv.equals("guestmemupdate")) contents = "../mypage/ya_Guest_MemUpdate.jsp";
	else if(contentsDiv.equals("hostmotelupdate")) contents = "../mypage/ya_Host_MotelUpdate.jsp";
	else if(contentsDiv.equals("hostreservelist")) contents = "../mypage/ya_Host_Reserve.jsp";
	else if(contentsDiv.equals("hostreviewlist")){
		contents = "../mypage/ya_Host_Review.jsp";
		ArrayList<Ya_ReviewBean> list = new ArrayList<Ya_ReviewBean>();
		list = (ArrayList<Ya_ReviewBean>)request.getAttribute("reviewlist");
		request.setAttribute("reviewlist", list);
	}
	else if(contentsDiv.equals("adminAdmission")) {
		ArrayList<Object> list = (ArrayList<Object>)request.getAttribute("list");
		String pageNum = request.getParameter("pageNum");
		String pageSize = request.getParameter("pageSize");
		String search_div = request.getParameter("search_div");
		String search_word = request.getParameter("search_word");
		
		request.setAttribute("list", list);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("pageSize", pageSize);
		request.setAttribute("search_div", search_div);
		request.setAttribute("search_word", search_word);
		contents = "../mypage/ya_Admin_Admission.jsp";
	}else if(contentsDiv.equals("detail")) contents = "../mypage/ya_Admin_Detail.jsp";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script type="text/javascript" src="http://openapi.map.naver.com/openapi/v2/maps.js?clientId=xAmZfYgSTz_6UArTCRhz"></script>
<!-- prevent IE6 flickering -->
<script type="text/javascript">
    try {
        document.execCommand('BackgroundImageCache', false, true);
    } catch (e) {
    }
</script>

<title>MyPage</title>
<style type="text/css">
	.header{
		position : fixed;
		height : 100px;
		background: #fc676e;
		z-index: 10;
	}
	.foot{
		height : 200px;
		background: #3f3e3e;
	}
	.blank{
		height: 100px;
	}	
	.location{
		padding-top : 50px;
		height: 300px;
	}
	.popular{
		height: 300px;
	}
	table,tr,td{
		text-align: center;
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
<!-- mypageMain -->	
	<div class="mypage" >
	<center>
	<table width="1300" height="900">
		<tr>
	<!-- Left -->
			<td rowspan="2" width="300" height="900" valign="top">
		<!-- menu -->
				<div style="padding: 30px">
				<p><h1>마이페이지</h1></p>
				</div>
		<!-- //menu -->
				<p><hr></p>
		<!-- guest_menu -->			
				<div name="guest_menu" align="left" style="padding-left: 50px">
				<p style="padding: 5px">
					<a href="mypage_Control.jsp?command=guestzzimlist&email=<%=email%>&value=init"><h2>찜</h2></a>
				</p>
				<p style="padding: 5px">
					<a href="mypage_Control.jsp?command=guestpointlist&email=<%=email%>&value=init"><h2>포인트</h2></a>
				</p>
				<p style="padding: 5px">
					<a href="mypage_Control.jsp?command=guestreservelist"><h2>예약내역</h2></a>
				</p>
				<p style="padding: 5px">
					<a href="../mypage/mypage_Control.jsp?command=guestmemupdate"><h2>회원정보수정</h2></a>
				</p>
				</div>
				<%
	            if(auth==2){
	            %>
	            <div name="admin_menu" align="left" style="padding-left: 50px">
	            <p style="padding: 5px">
	               <a href="mypage_Control.jsp?command=adminAdmission"><h2>회원 승인하기</h2></a>
	            </p>
	            </div>
	            <%
	            }
	            %>
				<%
				if(auth==1){
				%>
		<!-- //guest_menu -->
				<p><hr></p>
		<!-- host_menu -->			
				<div name="host_menu" align="left" style="padding-left: 50px">
				<p style="padding: 5px">
					<a href="mypage_Control.jsp?command=hostmotelupdate"><h2>모텔정보수정</h2></a>
				</p>
				<p style="padding: 5px">
					<a href="mypage_Control.jsp?command=hostreservelist&value=init"><h2>예약확인</h2></a>
				</p>
				<p style="padding: 5px">
					<a href="mypage_Control.jsp?command=hostreviewlist&value=init"><h2>리뷰관리</h2></a>
				</p>
				</div>
				<%
				}
				%>
		<!-- //host_menu -->
			</td>
	<!-- //Left -->
	<!-- Top -->
			<td width="1000" height="120">
				<table>
					<tr>
						<td width="250" height="150">
							<img alt="" src="../img/couple.png" width="100" height="100">
						</td>
						<td width="250" height="150">
							<h3><img alt="" src="../img/love.png" width="80" height="80"></h3><br>
							<p name="zzim_count"><%=map.get("zzim")==null?0:map.get("zzim") %>개 </p>
						</td>
						<td width="250" height="150">
							<h3><img alt="" src="../img/point.png" width="80" height="80"></h3><br>
							<p name="point_sum"><%=map.get("point")==null?0:map.get("point") %>원 </p>
						</td>
						<td width="250" height="150">
							<h3><img alt="" src="../img/list.png" width="80" height="80"></h3><br>
							<p name="reserve_count"><%=map.get("reserve")==null?0:map.get("reserve") %>개 </p>
						</td>
					</tr>
				</table>
			</td>
	<!-- //Top -->
		</tr>
		<tr>
	<!-- Contents -->
			<td width="1000" height="750" valign="top" style="padding-top: 50px" bgcolor="#f3f3f3">
				<jsp:include page="<%=contents %>"></jsp:include>
			</td>
	<!-- //Contents -->
		</tr>
	</table>
	</center>
	</div>
<!--Foot -->
	<jsp:include page="../super/superFoot.jsp"></jsp:include>
</body>
</html>