<%@page import="com.Beans.Ya_MotelBean"%>
<%@page import="java.util.Calendar"%>
<%@ page pageEncoding="UTF-8" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%
request.setCharacterEncoding("UTF-8");
%>
<%!//
//%>
<%//
Calendar cal = Calendar.getInstance();
int tyear = cal.get(Calendar.YEAR);
int tmonth = cal.get(Calendar.MONTH)+1;
int tday = cal.get(Calendar.DATE);
String ddate = "";
if(tmonth<10){
	if(tday<10){
		ddate = tyear+"-0"+tmonth+"-0"+tday;
	}
	ddate = tyear+"-0"+tmonth+"-"+tday;
}else{
	if(tday<10){
		ddate = tyear+"-"+tmonth+"-0"+tday;
	}
	ddate = tyear+"-"+tmonth+"-"+tday;
}



Ya_MotelBean dto = (Ya_MotelBean)request.getAttribute("dto");
//%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script type="text/javascript">
	
$(document).ready(function(){
    $('#date').change(function(){
       date = $('#date').val();
       $('#datee').text(date+ ' 객실 정보 입니다. ');
       //reset();
      // alert($('#date').val());
   });
});  


function p_reser(){
	//일반실 
/* 	location.href="searchControll.jsp?command=reser&name="
			+$("#reserName").val()+"&point="+$("#reserPoint").val()
			+"&use_date="+$('#date').val()+"&price="+$("#norpri").val()
			+"&email="+$("#roomtype").val() +"&roomtype="+$("#noroomtype").val(); */
	
	document.getElementById('frm').submit();
}


 function payment(){	
	
	 <%if(session.getAttribute("member")!=null){%>
	
	 if ($('#norpri').is(":checked") && !$('#prepri').is(":checked") && $("#nomCnt1").val()>0) //일반실
	{
		$("#roomtype").val("일반실");
		$("#price").val($('#norpri').val());
		window.open('payment.jsp?date='+$('#date').val()+'&check='+$('#norpri').val(), '결제창', 
		'width=500, height=800, left=700, top=100, toolbar=no,location=no,directories=no,status=no,menubar=no,resizable=no,scrollbars=no,copyhistory=no' )
		
	}else if($('#prepri').is(":checked") && !$('#norpri').is(":checked") && $("#preCnt1").val()>0){ //특실
		$("#roomtype").val("특실");
		$("#price").val($('#prepri').val());
		window.open('payment.jsp?date='+$('#date').val()+'&check='+$('#prepri').val(), '결제창', 
		'width=600, height=800, left=700, top=100, toolbar=no,location=no,directories=no,status=no,menubar=no,resizable=no,scrollbars=no,copyhistory=no' )
	}else if( $("#preCnt1").val()<=0 ||  $("#nomCnt1").val()<=0){
		alert("예약가능한 방이없습니다.");
	}else{
		alert("방을 제대로 골라주세요.");
	}
	 <%}else{%>
	 alert("로그인이 필요합니다.")
	 <%}%>

} 
 function photo(num){	
	
	window.open('detailPhoto.jsp?motelNum='+$('#motelNum').val()+'&str=No&type='+num, '사진보기', 
	'width=1500,height=800,left=0, top=0, toolbar=no,location=no,directories=no,status=no,menubar=no,resizable=no,scrollbars=no,copyhistory=no' )

} 



//p_id : 부모창의 id 값
//c_val : 부모창에 전달 하려는 값

//opener.document.getElementById("p_id").value = "c_val"; //일반적인 방법

//$("#p_id", opener.document).val("c_val"); //jquery 이용


	
</script>


<style>
</style>
</head>
<body>
<h1>객실정보</h1>
<hr>
<form action="searchControll.jsp" id="frm">
<input type="hidden" value="reser" name="command">
<table  style="width: 100%">
	<tr>
	<td style="text-align: right;"><p id="datee"><%=ddate %> 객실 정보 입니다.</p> </td>
	</tr> 
</table>
<br>
<table style="width: 100%">

<tr>
	<td width="100px" height="100px"></td>
	<td colspan="2" width="300px" height="100px">
	<img src="../img/calendar.png" width="150px" height="150px"><br><br>
	<input type="date" value="<%=ddate %>" min="<%=ddate %>" id="date" name="date">
	</td>
	<td width="200px" height="100px"></td>
	
	<td colspan="2" width="300px" height="100px" id="reser" onclick="payment()" align="center" style="cursor:pointer"">
	
		<font face="맑은 고딕" size="10" style="text-align: center; background-color: #ff87b3; color: white;">예약하기</font>
	
	</td>
	<td width="100px" height="100px"></td>
</tr>
<tr>
	<td colspan="7" height="60px"></td>
</tr>
<tr>
	<td width="100px" height="300px"></td>
	<td colspan="2" width="300px" height="300px">
	<%--일반실 사진 --%>
	<%for(int i=0;i<dto.getImgs().size();i++){ 
		if(dto.getImgs().get(i).getImg_auth()==1){
	%>
	<div onclick="photo(123)" >
	<img src ="<%=dto.getImgs().get(i).getImg_name() %>" width="300px" height="300px" onerror="this.src='../img/noImg.gif'" /> 
	</div>
	<%
		break;
		}
	}
	%>
	
	</td>
	<td width="200px" height="100px"></td>
	<td colspan="2" width="300px" height="300px">
	<%--특실 사진 --%>
	<%for(int i=0;i<dto.getImgs().size();i++){ 
		if(dto.getImgs().get(i).getImg_auth()==2){
	%>
	<div onclick="photo(789)" >
	<img src ="<%=dto.getImgs().get(i).getImg_name() %>" width="300px" height="300px" onerror="this.src='../img/noImg.gif'" >
	</div>
	<%
		break;
		}
	}
	%>
	</td>
	<td width="100px" height="300px"></td>
</tr>
<tr>
	<td width="100px" height="150px"></td>
	<td colspan="2" width="300px" height="150px">
	<input type="hidden" id="nomCnt" value="<%=dto.getNormal_cnt() %>">
	<input type="hidden" id="nomCnt1" value="">
	<p id="noroomCn"></p>
	<p>일반실 <%=dto.getNormal_pri() %></p>  
	
	<input type="checkbox" value="<%=dto.getNormal_pri() %>" id="norpri">
	</td>
	<td width="200px" height="100px"></td>
	<td colspan="2" width="300px" height="150px">
	<input type="hidden" id="preCnt" value="<%=dto.getPremium_cnt() %>">
	<input type="hidden" id="preCnt1" value="">
	<p id="prroomCn"></p>
	<p>특실 가격 <%=dto.getPremium_pri() %></p>  
	
	<input type="checkbox" value="<%=dto.getPremium_pri() %>" id="prepri">
	</td>
	<td width="100px" height="150px"></td>
</tr>
<input type="hidden" value="" id="roomtype" name="roomtype">
<input type="hidden" name="reserName" id="reserName" value="">
<input type="hidden" name="reserPoint" id="reserPoint" value="">
<input type="hidden" value="<%=dto.getMotel_num()%>" id="motelNum" name="motelNum">
<input type="hidden" value="" name="price" id="price">

</table>
</form>

<script type="text/javascript">

function reset(){
var nomCnt = $('#nomCnt').val();
var preCnt = $("#preCnt").val();
var date = $('#date').val();
var motelNum = $("#motelNum").val();

$.ajax({
    type:"POST",
    url:"roomCount.jsp",
    dataType:"html",
    data:{
        "date":  date,
        "nomCnt":  nomCnt,
        "motelNum" : motelNum,
        "preCnt" : preCnt
    },
    success:function(data){
    	var roomCn = $.parseJSON(data);
    	var noroomCnt = roomCn.noroomCnt;
    	var preroomCnt = roomCn.preroomCnt;
		//alert(noroomCnt);
		//alert(preroomCnt);
		$("#noroomCn").text('예약가능한 방 : '+noroomCnt);
		$("#prroomCn").text('예약가능한 방 : '+preroomCnt);
		$("#nomCnt1").val(noroomCnt);
		$("#preCnt1").val(preroomCnt);
        	
    },
    complete : function(data) {
       // 통신이 실패했어도 완료가 되었을 때 이 함수를 타게 된다.
    	console.log("complete"+data);
    },           
    error:function(){
    }
});
}
reset();
</script>



</body>
</html>