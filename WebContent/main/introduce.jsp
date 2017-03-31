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
<title>팀소개</title>
<style type="text/css">
.header {
	position: fixed;
	height: 100px;
	background: #fc676e;
}

.foot {
	height: 200px;
	background: #3f3e3e;
}

.blank {
	height: 100px;
}

table, tr, td {
	text-align: center;
	/* border: 1px solid black */
}

img:hover {
	opacity: 0.5;
}

ul.tab {
	list-style-type: none;
	margin: 0;
	padding: 0;
	overflow: hidden;
	border: 1px solid #ccc;
	background-color: #f1f1f1;
}

/* Float the list items side by side */
ul.tab li {
	float: left;
}

/* Style the links inside the list items */
ul.tab li a {
	display: inline-block;
	color: black;
	text-align: center;
	padding: 14px 16px;
	text-decoration: none;
	transition: 0.3s;
	font-size: 17px;
}

/* Change background color of links on hover */
ul.tab li a:hover {
	background-color: #ddd;
}

/* Create an active/current tablink class */
ul.tab li a:focus, .active {
	background-color: #ccc;
}

/* Style the tab content */
.tabcontent {
	display: none;
	padding: 6px 12px;
	border: 1px solid #ccc;
	border-top: none;
}

.myText {
	color: rgb(203, 52, 160);
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
	<!-- 입력 -->
	<div style="padding-left: 200px; padding-right: 200px; padding-top: 200px; padding-bottom: 200px">
	<center>
	<ul class="tab">
		<li><a href="javascript:void(0)" class="tablinks"
			onclick="openCity(event, 'Main')">한번 더 해요</a></li>
		<li><a href="javascript:void(0)" class="tablinks"
			onclick="openCity(event, 'London')">조윤행</a></li>
		<li><a href="javascript:void(0)" class="tablinks"
			onclick="openCity(event, 'Paris')">김영재</a></li>
		<li><a href="javascript:void(0)" class="tablinks"
			onclick="openCity(event, 'Tokyo')">배한주</a></li>
		<li><a href="javascript:void(0)" class="tablinks"
			onclick="openCity(event, 'Seoul')">황인배</a></li>
	</ul>
	<div id="Main" class="tabcontent">
		<br><br>
		<h3>한번 더 해요</h3>
		<div class="myText">
		<br><br>
		한번 더 해요는 가격경쟁으로 숙박업체가 더 나은 서비스와 저렴한 가격을 제공할 수 있도록 숙박업체 통합 시스템을 구축하기 위한 팀입니다.
		<br><br>
		   
		야하자는 위치기반 좋은숙소 추천, 예약, 적립까지 가능한 숙박O2O 서비스입니다.
		<br>
		야하자는 고객이 편하고 즐겁게 쉴 수 있는 최적의 장소정보를 제공함으로써
		<br>
		고객만족의 가치를 실현함은 물론 지역 산업발전에 이바지함에 긍지를 가지고
		<br>
		오늘도 더 나은 서비스를 위한 진화를 멈추지 않겠습니다.
		<br><br>
		<p>2017/02/02 - 02/21</p>
		<br><br>
		</div>
	</div>
	
	<div id="London" class="tabcontent">
		<br><br>
		<h3>조윤행</h3>
		<br><br>
		<div class="myText">
		<br><br>
		메인페이지, 위치, 사진 업로드를 담당하였습니다.
		<br><br>
		   
		야하자는 위치기반 좋은숙소 추천, 예약, 적립까지 가능한 숙박O2O 서비스입니다.
		<br>
		야하자는 고객이 편하고 즐겁게 쉴 수 있는 최적의 장소정보를 제공함으로써
		<br>
		고객만족의 가치를 실현함은 물론 지역 산업발전에 이바지함에 긍지를 가지고
		<br>
		오늘도 더 나은 서비스를 위한 진화를 멈추지 않겠습니다.
		<br><br>
		<p>2017/02/02 - 02/21</p>
		<br><br>
		</div>
		<br><br>
	</div>

	<div id="Paris" class="tabcontent">
		<br><br>
		<h3>김영재</h3>
		<br><br>
		<p>그는 진짜 크다</p>
		<br><br>
	</div>

	<div id="Tokyo" class="tabcontent">
		<br><br>
		<h3>배한주</h3>
		<br><br>
		<p>그는 곧 생일이다</p>
		<br><br>
	</div>
	<div id="Seoul" class="tabcontent">
		<br><br>
		<h3>황인배</h3>
		<br><br>
		<p>그는 술쟁이다</p>
		<br><br>
	</div>
	</center>
	</div>
	<script>
		openCity(event,'Main');
		function openCity(evt, cityName) {
			var i, tabcontent, tablinks;
			tabcontent = document.getElementsByClassName("tabcontent");
			for (i = 0; i < tabcontent.length; i++) {
				tabcontent[i].style.display = "none";
			}
			tablinks = document.getElementsByClassName("tablinks");
			for (i = 0; i < tablinks.length; i++) {
				tablinks[i].className = tablinks[i].className.replace(
						" active", "");
			}
			document.getElementById(cityName).style.display = "block";
			evt.currentTarget.className += " active";
		}
	</script>

	<!--Foot -->
	<jsp:include page="../super/superFoot.jsp"></jsp:include>
</body>
</html>