<%
	response.setHeader("Cache-Control","no-store");   
	response.setHeader("Pragma","no-cache");   
	response.setDateHeader("Expires",0);   
	if (request.getProtocol().equals("HTTP/1.1")) 
         response.setHeader("Cache-Control", "no-cache"); 
%>
<%@page import="com.Beans.Ya_ImgBean"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.Beans.Ya_MotelBean"%>
<%@page import="com.Dao.MainDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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

<title>야하자입니다!!</title>
<style type="text/css">
	.foot{
		height : 220px;
		background: #3f3e3e;
	}
	.blank{
		height: 100px;
	}
	table,tr,td{
		text-align: center;
		/* border: 1px solid black */	
	}
	img:hover{
		opacity: 0.5;
	}
	
	/*여기부터 시작  */
#carousel {
  margin-top : 250px;
  height: 350px;
  top: 50%;
  transform: translateY(-50%);
  overflow: hidden;
}
#carousel div {
  position: absolute;
  transition: transform 1s, left 1s, opacity 1s, z-index 0s;
  opacity: 1;
}
#carousel div img {
  width: 400px;
  transition: width 1s;
}
#carousel div.hideLeft {
  left: 0%;
  opacity: 0;
  transform: translateY(50%) translateX(-50%);
}
#carousel div.hideLeft img {
  width: 200px;
}
#carousel div.hideRight {
  left: 100%;
  opacity: 0;
  transform: translateY(50%) translateX(-50%);
}
#carousel div.hideRight img {
  width: 200px;
}
#carousel div.prev {
  z-index: 5;
  left: 30%;
  transform: translateY(50px) translateX(-50%);
}
#carousel div.prev img {
  width: 300px;
}
#carousel div.prevLeftSecond {
  z-index: 4;
  left: 15%;
  transform: translateY(50%) translateX(-50%);
  opacity: 0.7;
}
#carousel div.prevLeftSecond img {
  width: 200px;
}
#carousel div.selected {
  z-index: 10;
  left: 50%;
  transform: translateY(0px) translateX(-50%);
}
#carousel div.next {
  z-index: 5;
  left: 70%;
  transform: translateY(50px) translateX(-50%);
}
#carousel div.next img {
  width: 300px;
}
#carousel div.nextRightSecond {
  z-index: 4;
  left: 85%;
  transform: translateY(50%) translateX(-50%);
  opacity: 0.7;
}
#carousel div.nextRightSecond img {
  width: 200px;
}
.buttons {
  left: 50%;
  transform: translateX(-50%);
  bottom: 10px;
}

#carousel{
	text-align: center;
}
</style>
<%
	String pageName = "";
%>
</head>
<body>
<!-- Footer -->	
	<div class="foot" style="padding-top: 10px">
		<center>
		
		<p style="color: #d9d9db"> 
		서울특별시 마포구 백범로 18 미화빌딩 3층 F강의장<br>
		developed by<br> 
		조윤행. 김영재. 배한주. 황인배<br>
		<a href="instagram.com/haengtion.24/">instagram.com/haengtion.24/</a>
		</p>
		
		
		<div style="padding-top: 10px">
			<img src="../img/team.png" width="55px" height="55px">
			<img src="../img/document.png" width="55px" height="55px">
			<img src="../img/process.png" width="55px" height="55px">
		</div>
		<div>
		 <a href="../main/introduce.jsp">팀소개 </a>
		 <a href="../main/useAppointment.jsp">이용약관 </a>
		 <a href="http://blog.naver.com/dbsgod5880">제작과정</a>
		 <p style="color: #d9d9db">COPYRIGHT SIST_Fclass_2nd Project FirstTeam</p>
		 </div>
		 </center>
	</div>
</body>
</html>