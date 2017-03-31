<%@page import="com.Beans.Ya_MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	Ya_MemberBean membean = (Ya_MemberBean)session.getAttribute("member");
	String nickname = membean.getNickname();
	
	int motel_num = Integer.parseInt(request.getParameter("command"));
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<title>Insert title here</title>
</head>
<body>

<script type="text/javascript">
$(document).ready(function(){
	var fac_score = 0;
	var ser_score = 0;
	var clean_score = 0;
	var contents = null;
	////////////////////시설//////////////////////////
	$('#fac1').click(function(){
		$('#fac1').attr('src','../img/fullstar.PNG');
		$('#fac2').attr('src','../img/empstar.PNG');
		$('#fac3').attr('src','../img/empstar.PNG');
		$('#fac4').attr('src','../img/empstar.PNG');
		$('#fac5').attr('src','../img/empstar.PNG');
		fac_score = 2;
		$('#fac_score').text(fac_score);
	});
	$('#fac2').click(function(){
		$('#fac1').attr('src','../img/fullstar.PNG');
		$('#fac2').attr('src','../img/fullstar.PNG');
		$('#fac3').attr('src','../img/empstar.PNG');
		$('#fac4').attr('src','../img/empstar.PNG');
		$('#fac5').attr('src','../img/empstar.PNG');
		fac_score = 4;
		$('#fac_score').text(fac_score);
	});
	$('#fac3').click(function(){
		$('#fac1').attr('src','../img/fullstar.PNG');
		$('#fac2').attr('src','../img/fullstar.PNG');
		$('#fac3').attr('src','../img/fullstar.PNG');
		$('#fac4').attr('src','../img/empstar.PNG');
		$('#fac5').attr('src','../img/empstar.PNG');
		fac_score = 6;
		$('#fac_score').text(fac_score);
	});
	$('#fac4').click(function(){
		$('#fac1').attr('src','../img/fullstar.PNG');
		$('#fac2').attr('src','../img/fullstar.PNG');
		$('#fac3').attr('src','../img/fullstar.PNG');
		$('#fac4').attr('src','../img/fullstar.PNG');
		$('#fac5').attr('src','../img/empstar.PNG');
		fac_score = 8;
		$('#fac_score').text(fac_score);
	});
	$('#fac5').click(function(){
		$('#fac1').attr('src','../img/fullstar.PNG');
		$('#fac2').attr('src','../img/fullstar.PNG');
		$('#fac3').attr('src','../img/fullstar.PNG');
		$('#fac4').attr('src','../img/fullstar.PNG');
		$('#fac5').attr('src','../img/fullstar.PNG');
		fac_score = 10;
		$('#fac_score').text(fac_score);
	});
	////////////////////서비스///////////////////////////
	$('#ser1').click(function(){
		$('#ser1').attr('src','../img/fullstar.PNG');
		$('#ser2').attr('src','../img/empstar.PNG');
		$('#ser3').attr('src','../img/empstar.PNG');
		$('#ser4').attr('src','../img/empstar.PNG');
		$('#ser5').attr('src','../img/empstar.PNG');
		ser_score = 2;
		$('#ser_score').text(ser_score);
	});
	$('#ser2').click(function(){
		$('#ser1').attr('src','../img/fullstar.PNG');
		$('#ser2').attr('src','../img/fullstar.PNG');
		$('#ser3').attr('src','../img/empstar.PNG');
		$('#ser4').attr('src','../img/empstar.PNG');
		$('#ser5').attr('src','../img/empstar.PNG');
		ser_score = 4;
		$('#ser_score').text(ser_score);
	});
	$('#ser3').click(function(){
		$('#ser1').attr('src','../img/fullstar.PNG');
		$('#ser2').attr('src','../img/fullstar.PNG');
		$('#ser3').attr('src','../img/fullstar.PNG');
		$('#ser4').attr('src','../img/empstar.PNG');
		$('#ser5').attr('src','../img/empstar.PNG');
		ser_score = 6;
		$('#ser_score').text(ser_score);
	});
	$('#ser4').click(function(){
		$('#ser1').attr('src','../img/fullstar.PNG');
		$('#ser2').attr('src','../img/fullstar.PNG');
		$('#ser3').attr('src','../img/fullstar.PNG');
		$('#ser4').attr('src','../img/fullstar.PNG');
		$('#ser5').attr('src','../img/empstar.PNG');
		ser_score = 8;
		$('#ser_score').text(ser_score);
	});
	$('#ser5').click(function(){
		$('#ser1').attr('src','../img/fullstar.PNG');
		$('#ser2').attr('src','../img/fullstar.PNG');
		$('#ser3').attr('src','../img/fullstar.PNG');
		$('#ser4').attr('src','../img/fullstar.PNG');
		$('#ser5').attr('src','../img/fullstar.PNG');
		ser_score = 10;
		$('#ser_score').text(ser_score);
	});
	////////////////////청결///////////////////////////
	$('#clean1').click(function(){
		$('#clean1').attr('src','../img/fullstar.PNG');
		$('#clean2').attr('src','../img/empstar.PNG');
		$('#clean3').attr('src','../img/empstar.PNG');
		$('#clean4').attr('src','../img/empstar.PNG');
		$('#clean5').attr('src','../img/empstar.PNG');
		clean_score = 2;
		$('#clean_score').text(clean_score);
	});
	$('#clean2').click(function(){
		$('#clean1').attr('src','../img/fullstar.PNG');
		$('#clean2').attr('src','../img/fullstar.PNG');
		$('#clean3').attr('src','../img/empstar.PNG');
		$('#clean4').attr('src','../img/empstar.PNG');
		$('#clean5').attr('src','../img/empstar.PNG');
		clean_score = 4;
		$('#clean_score').text(clean_score);
	});
	$('#clean3').click(function(){
		$('#clean1').attr('src','../img/fullstar.PNG');
		$('#clean2').attr('src','../img/fullstar.PNG');
		$('#clean3').attr('src','../img/fullstar.PNG');
		$('#clean4').attr('src','../img/empstar.PNG');
		$('#clean5').attr('src','../img/empstar.PNG');
		clean_score = 6;
		$('#clean_score').text(clean_score);
	});
	$('#clean4').click(function(){
		$('#clean1').attr('src','../img/fullstar.PNG');
		$('#clean2').attr('src','../img/fullstar.PNG');
		$('#clean3').attr('src','../img/fullstar.PNG');
		$('#clean4').attr('src','../img/fullstar.PNG');
		$('#clean5').attr('src','../img/empstar.PNG');
		clean_score = 8;
		$('#clean_score').text(clean_score);
	});
	$('#clean5').click(function(){
		$('#clean1').attr('src','../img/fullstar.PNG');
		$('#clean2').attr('src','../img/fullstar.PNG');
		$('#clean3').attr('src','../img/fullstar.PNG');
		$('#clean4').attr('src','../img/fullstar.PNG');
		$('#clean5').attr('src','../img/fullstar.PNG');
		clean_score = 10;
		$('#clean_score').text(clean_score);
	});
	///////////////////write/////////////////
	$('#writebtn').click(function(){
		//alert(fac_score);alert(ser_score);alert(clean_score);
		contents = $('#contents').val();
		//alert(contents);
		
		$.ajax({
			type:"POST",
			url:"../mypage/ya_Guest_Review_Write_Check.jsp?command=<%=motel_num%>",
			dataType:"html",
			data:{
				"fac_score":	fac_score,
				"ser_score":	ser_score,
				"clean_score":	clean_score,
				"contents":		contents
			},
			success:function(data){
				console.log("success\t"+data);
				var flag = $.parseJSON(data);
				//var pay_dt = flag.pay_dt;
				console.log("complete="+flag);
				window.close();
			},
			complete : function(data) {
		        // 통신이 실패했어도 완료가 되었을 때 이 함수를 타게 된다.
	        	console.log("complete"+data);
	        },           
	        error:function(){
	        }
		});	 
	});
	///////////////////close////////////////
	$('#canclebtn').click(function(){
		//self.opener = self;
		window.close();
	});
});
</script>

<div>
<h1 align="center">리뷰</h1><br>
<h3 style="padding-left: 100px"><%=nickname %> 님</h3>
</div>

<div>
<center>
<table border="1">
<col width="200"/><col width="200"/><col width="200"/>
<tr>
	<td style="text-align: center;">
	시설<br>
	<img src="../img/empstar.PNG" id="fac1" width="20px" height="20px"/>
	<img src="../img/empstar.PNG" id="fac2" width="20px" height="20px"/>
	<img src="../img/empstar.PNG" id="fac3" width="20px" height="20px"/>
	<img src="../img/empstar.PNG" id="fac4" width="20px" height="20px"/>
	<img src="../img/empstar.PNG" id="fac5" width="20px" height="20px"/><br>
	<b id="fac_score">0</b>
	</td>
	<td style="text-align: center;">
	서비스<br>
	<img src="../img/empstar.PNG" id="ser1" width="20px" height="20px"/>
	<img src="../img/empstar.PNG" id="ser2" width="20px" height="20px"/>
	<img src="../img/empstar.PNG" id="ser3" width="20px" height="20px"/>
	<img src="../img/empstar.PNG" id="ser4" width="20px" height="20px"/>
	<img src="../img/empstar.PNG" id="ser5" width="20px" height="20px"/><br>
	<b id="ser_score">0</b>
	</td>
	<td style="text-align: center;">
	청결<br>
	<img src="../img/empstar.PNG" id="clean1" width="20px" height="20px"/>
	<img src="../img/empstar.PNG" id="clean2" width="20px" height="20px"/>
	<img src="../img/empstar.PNG" id="clean3" width="20px" height="20px"/>
	<img src="../img/empstar.PNG" id="clean4" width="20px" height="20px"/>
	<img src="../img/empstar.PNG" id="clean5" width="20px" height="20px"/><br>
	<b id="clean_score">0</b>
	</td>
</tr>
</table>
</center>
</div>

<div style="padding-top: 50px">
<center>
<table>
<form>
<input type="textarea" id="contents" style="width: 600px; height: 150px"/>
</form>
</table>
</center>
</div>

<div style="padding-top: 70px">
<center>
<table>
<col width="300"/><col width="300"/>
<tr>
	<td align="center">
		<button type="button" id="writebtn">리뷰 달고 정보를 공유해요^^</button>
	</td>
	<td align="center">
		<button type="button" id="canclebtn">다음에 꼭 리뷰달게요~</button>
	</td>
</tr>
</table>
</center>
</div>

</body>
</html>