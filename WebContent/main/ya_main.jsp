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
		background: #fc676e;
		z-index: 20;
	}
	.foot{
		height : 200px;
		background: #3f3e3e;
	}
	.blank{
		height: 100px;
	}	
	.popular{
		height: 450px; 
		margin-bottom: 20px;
		padding-bottom: 20px;
	}
	table,tr,td{
		text-align: center;	
		/* border: 1px solid black; */
	}
	img:hover{
		/* opacity: 0.5; */
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
</head>
<body>
<%
	MainDao mainDao = MainDao.getInstance();
	ArrayList<Object> list = mainDao.do_search(0,0,"","");
%>
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
	 
<!-- 지역별 업소 -->
	<div id="carousel">
	<h3><span class="glyphicon glyphicon-search"></span> 지역별 업소</h3><hr>
       <div class="hideLeft">
       	<a href="../search/searchControll.jsp?command=word&searchWord=부산&type=address">
        <img src="../img/busan.jpg" onmouseover = "this.src = '../img/busanAf.png';" onmouseout="this.src='../img/busan.jpg';">

        </a>
      </div>

      <div class="prevLeftSecond">
      	<a href="../search/searchControll.jsp?command=word&searchWord=경기&type=BASIC&isaddress=ok">
        <img src="../img/kyungki.jpg" onmouseover = "this.src = '../img/kyungkiAf.png';" onmouseout="this.src='../img/kyungki.jpg';">

        </a>
      </div>

      <div class="prev">
      	<a href="../search/searchControll.jsp?command=word&searchWord=인천&type=BASIC&isaddress=ok">
        <img src="../img/incheon.jpg" onmouseover = "this.src = '../img/incheonAf.png';" onmouseout="this.src='../img/incheon.jpg';">

        </a>
      </div>

      <div class="selected">
      	<a href="../search/searchControll.jsp?command=word&searchWord=서울&type=BASIC&isaddress=ok">
        <img src="../img/map.png">
        <p>내주변</p>
        </a>
      </div>

      <div class="next">
      	<a href="../search/searchControll.jsp?command=word&searchWord=서울&type=BASIC&isaddress=ok">
        <img src="../img/seoul.jpg" onmouseover = "this.src = '../img/seoulAf.png';" onmouseout="this.src='../img/seoul.jpg';">

        </a>
      </div>

      <div class="nextRightSecond">
      	<a href="../search/searchControll.jsp?command=word&searchWord=대구&type=BASIC&isaddress=ok">
        <img src="../img/daegu.jpg" onmouseover = "this.src = '../img/daeguAf.png';" onmouseout="this.src='../img/daegu.jpg';">

        </a>
      </div>

      <div class="hideRight">
      	<a href="../search/searchControll.jsp?command=word&searchWord=대전&type=BASIC&isaddress=ok">
        <img src="../img/daejeon.jpg" onmouseover = "this.src = '../img/daejeonAf.png';" onmouseout="this.src='../img/daejeon.jpg';">

        </a>
      </div>

    </div>

    <div class="buttons">
      <button id="prev">Prev</button>
      <button id="next">Next</button>
    </div>

  <script type="text/javascript">
  function moveToSelected(element) {

	  if (element == "next") {
	    var selected = $(".selected").next();
	  } else if (element == "prev") {
	    var selected = $(".selected").prev();
	  } else {
	    var selected = element;
	  }

	  var next = $(selected).next();
	  var prev = $(selected).prev();
	  var prevSecond = $(prev).prev();
	  var nextSecond = $(next).next();

	  $(selected).removeClass().addClass("selected");

	  $(prev).removeClass().addClass("prev");
	  $(next).removeClass().addClass("next");

	  $(nextSecond).removeClass().addClass("nextRightSecond");
	  $(prevSecond).removeClass().addClass("prevLeftSecond");

	  $(nextSecond).nextAll().removeClass().addClass('hideRight');
	  $(prevSecond).prevAll().removeClass().addClass('hideLeft');

	}

	// Eventos teclado
	$(document).keydown(function(e) {
	    switch(e.which) {
	        case 37: // left
	        moveToSelected('prev');
	        break;

	        case 39: // right
	        moveToSelected('next');
	        break;

	        default: return;
	    }
	    e.preventDefault();
	});

	$('#carousel div').click(function() {
	  moveToSelected($(this));
	});

	$('#prev').click(function() {
	  moveToSelected('prev');
	});

	$('#next').click(function() {
	  moveToSelected('next');
	});
	</script>
	 
<!-- 이달의 업소 -->	
	<div class="popular" >
	<table>
		<col width="222"/><col width="222"/><col width="222"/>
    	<col width="222"/><col width="222"/><col width="222"/>
    	<col width="222"/><col width="222"/><col width="222"/>
    	<tr>
    		<td colspan="9"> </td>
    	</tr>
    	<tr>
    		<td colspan="9"><h3><span class="glyphicon glyphicon-thumbs-up"></span> 이달의 인기 업소</h3></td>
    	</tr>
    	<tr>
    		<td colspan="9"><br><hr></td>
    	</tr>
    	<tr>
    		<td colspan="2"></td>
    		<td style="background-color: #fff7d8;">1위</td>
    		<td style="background-color: #fff7d8;">2위</td>
    		<td style="background-color: #fff7d8;">3위</td>
    		<td style="background-color: #fff7d8;">4위</td>
    		<td style="background-color: #fff7d8;">5위</td>
    		<td colspan="2"></td>
    	</tr>
    	<tr>
    		<td></td>
    		<td rowspan="2"></td>
    		<%
    			for(int i = 0; i < list.size(); ++i){
    				Ya_MotelBean motelBean = (Ya_MotelBean)list.get(i);
    				List<Ya_ImgBean> imgs = motelBean.getImgs();
    				System.out.println(imgs.get(0).getImg_name());
    		%>
 
    		<td style="background-color: #fffbea; padding: 10px;"><img onerror="this.src='../img/noImg.gif'" src="<%=(imgs.get(0)).getImg_name()%>" width="180" height="160" onclick="location.href='../search/searchControll.jsp?command=detail&motel_num=<%=motelBean.getMotel_num()%>'"></td>
    		
    		<%
    			}
    		%>
    		<td rowspan="2"></td>
 			<td></td>
    	</tr>
    	<tr>
    		<td colspan="9"></td>
    	</tr>
    	<tr>
    		<td colspan="2"></td>
    		<%
    			for(int i = 0; i < list.size(); ++i){
    				Ya_MotelBean motelBean = (Ya_MotelBean)list.get(i);
    		%>
    		<td style="background-color: #fff7d8; padding: 10px;"><%=motelBean.getName() %></td>
    		<%
    			}
    		%>
    	</tr>
    	
	</table>
	</div>
	
	<center>
	<div id="testMap" style=" border:1px solid #000; width:1000px; height:400px; margin:150px;"></div>
	</center>
	
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
        size: new nhn.api.map.Size(1000, 400)
    });
	</script>
<!--Foot -->
	<jsp:include page="../super/superFoot.jsp"></jsp:include>
</body>
</html>