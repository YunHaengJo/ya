<%@page import="com.Beans.Ya_MemberBean"%>
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

<title>국내 no.1 모텔예약서비스</title>
<style type="text/css">
	.header{
		position : fixed;
		height : 100px;
		/* background: #4d32fc; */
		background : #fc676e;
		z-index: 20;
	}
	.blank{
		height: 100px;
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
	Ya_MemberBean memberBean = (Ya_MemberBean)session.getAttribute("member");
%>
</head>
<body>
	<div class="header">
	<form action="../search/searchControll.jsp?is">
	<input type="hidden" value="word" name="command">
    	<table>
    	<col width="222"/><col width="222"/><col width="222"/>
    	<col width="222"/><col width="222"/><col width="222"/>
    	<col width="222"/><col width="222"/><col width="222"/>
    	<tr>
    		<td></td>
    		<td>
    			<a href="../main/ya_main.jsp">
    			<img src="../img/logo.png" width="200" height="90">
    			</a>
    		</td>
    		<td colspan="4">
    		<div class="input-group input-group-lg">
      		<input type="text" class="form-control" placeholder="숙소/역이름으로 검색하세요" size="80" name="searchWord">
      		<input type="hidden" name="isaddress" value="no">
      		<div class="input-group-btn">
        		<button class="btn btn-default" type="submit"><i class="glyphicon glyphicon-search"></i></button>
     		</div>
    		</div>
    		</td>
    		<td colspan="2">
    		<% 
    		if(session.getAttribute("member")!=null){
    		%>
    			<img src="../img/user.png" width="40px" height="40px"> <%=memberBean.getNickname() + "님  안녕하세요" %><br><br>
    			<a href="../login/ya_loginControl.jsp?command=logout">로그아웃  </a>
    			<a href="../mypage/mypage_Main.jsp">마이페이지</a>
    			<a href="../service/noticeControl.jsp?command=list" >고객센터  </a>
    		<%
    		}else{
    		%>
    			<a href="../login/ya_loginControl.jsp?command=login">로그인  </a>
    			<a href="../login/ya_whoJoin.jsp">회원가입  </a>
    			<a onclick="method()" >고객센터  </a>
    		<%
    		} 
    		%>
    		<script type="text/javascript">
    			function method() {
					alert("로그인 후 이용 가능합니다!");
					location.href="../login/ya_loginControl.jsp?command=login";
				}
    		</script>
    		
    		
    		</td>
    		<td></td>
    	</tr>
    	</table>
  	</form>
	</div>
</body>
</html>