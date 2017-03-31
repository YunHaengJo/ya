<%@page import="com.Beans.Ya_ReserveBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
Calendar cal = Calendar.getInstance();
int tyear = cal.get(Calendar.YEAR);
int tmonth = cal.get(Calendar.MONTH)+1;
int tday = cal.get(Calendar.DATE);
String todaydate = "";

if(tmonth<10){
	if(tday<10){
		todaydate = tyear+"-0"+tmonth+"-0"+tday;
	}else{
		todaydate = tyear+"-0"+tmonth+"-"+tday;
	}
}else{
	if(tday<10){
		todaydate = tyear+"-"+tmonth+"-0"+tday;
	}else{
		todaydate = tyear+"-"+tmonth+"-"+tday;
	}
}
System.out.println(todaydate);
ArrayList<Ya_ReserveBean> reservelist = new ArrayList<Ya_ReserveBean>();
reservelist = (ArrayList<Ya_ReserveBean>)request.getAttribute("reservelist");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<title>Insert title here</title>
</head>
<body>
<script type="text/javascript">
function choice(choicevalue,seqNum,point,price){
	if(choicevalue==0){
		// 확인으로 변경
		var seq = seqNum;
		//alert("예약확인으로!"+seq);
		$.ajax({
			type:"POST",
			url:"../mypage/ya_Host_Reserve_Admission.jsp",
			dataType:"html",
			data:{
				"seq":	seq,
				"point": point,
				"price": price
			},
			success:function(data){
				console.log("success\t"+data);
				var flag1 = $.parseJSON(data);
				var flag2 = $.parseJSON(data);
				//var pay_dt = flag.pay_dt;
				if(!flag1){
					console.log("해당회원의 상태가 갱신되어 승인이 취소되었습니다.");
				}
				console.log("complete="+flag1 + flag2);
				page(1);
			},
			complete : function(data) {
		        // 통신이 실패했어도 완료가 되었을 때 이 함수를 타게 된다.
	        	console.log("complete"+data);
	        },           
	        error:function(){
	        }
		});	 
	}
}

function page(page){
	var date1 = $('#date1').val();
	var date2 = $('#date2').val();
	var pageNum = page;
	//console.log(date1);
	//console.log(date2);
    
	$.ajax({
        type:"POST",
        url:"ya_Host_Reserve_Check.jsp",
        dataType:"html",
        data:{
            "date1":  date1,
            "date2":  date2,
            "pageNum" : pageNum
        },
        success:function(data){
        	//console.log("success\t"+data);						// 데이터 잘 받는지 확인(결과 리스트를 배열처럼 받음)
        	var beanData = $.parseJSON(data);
        	//console.log("complete="+beanData[0].seq);			// 데이터(리스트인데 배열처럼 받은걸 확인) 잘 받는지 모텔 이름 확인
        	
        	if(beanData.length!=0){
            	$('#reservetable tr').slice(1).remove(); 			//원래 뿌렸던거 지움 
            	//console.log("length="+beanData.length);
            	for(var i=0;i<beanData.length;i++){
            		var pay_dt = beanData[i].pay_dt;
            		var use_dt = beanData[i].use_dt;
            		var name = beanData[i].name;
            		var roomtype = beanData[i].room_type;
            		var price = beanData[i].price;
            		var state = beanData[i].state;
            		var totCnt = beanData[i].tot_cnt;
            		var seq = beanData[i].seq;
            		var point = beanData[i].point;
            		var choicevalue;
            		//console.log("test="+beanData[i].name);	// 데이터 잘 받는지 모텔 이름 확인
            		//console.log("test="+beanData[i].state);
            		if(state==0){
            			state="대기";
            			choicevalue="0"
            		}else if(state==1){
            			state="확인";
            			choicevalue="1"
            		}else if(state==2){
            			state="취소";
            			choicevalue="2"
            		} 
            		
            		$('#reservetable').append('<tr height="30"><td style="border-bottom: 1px solid black;">'+pay_dt+'</td><td style="border-bottom: 1px solid black;">'+use_dt+'</td><td style="border-bottom: 1px solid black;">'+name+'</td><td style="border-bottom: 1px solid black;">'+roomtype+'</td><td style="border-bottom: 1px solid black;">'+price+'</td><td style="border-bottom: 1px solid black;"><button type="button" id="reservechoice" onclick="choice('+ choicevalue +','+seq+','+point+',' +price+');">'+state+'</button></td></tr>'); 
            	}
            	$("#reservetable").append('<tr height="20"><td colspan="6" ></td></tr>');
                       	
            	// 페이징 숫자 처리 부분 
            	var pageCount = 0; 
            	
            	if(totCnt%5>0){
            		pageCount=Math.floor(totCnt/5)+1;
            	}else{
            		pageCount=Math.floor(totCnt/5);
            	}
            	//alert("pageCount"+pageCount);
            	
				var str = "";
    			for(i=0;i<pageCount;i++){
    				str += "<a href='javascript:;' onclick='page("+(i+1)+")' >"+(i+1)+"</a> ";	
    			}
    			//alert("str"+str);
           	
            	$("#reservetable").append('<tr height="20"><td colspan="6" >'+
            			       str     			
            			+'</td></tr>');
        	}else{
        		$('#reservetable tr').slice(1).remove();
        		$("#reservetable").append('<tr height="20"><td colspan="6" >내역이없습니다.</td></tr>');
        		return;
        	}
        },
        complete : function(data) {
           // 통신이 실패했어도 완료가 되었을 때 이 함수를 타게 된다.
        	console.log("complete"+data);
        },           
        error:function(){
        }
	});
}
$(document).ready(function(){
    $('#date1').change(function(){
    	var date1 = $('#date1').val();
    	var date2 = $('#date2').val();
    	//alert(date);
    	
    	$("#date2").attr( 'min', date1 );
    	//$("#date1").attr( 'max', date2 );
    	//var dd = "min='"+date+"'";
    	//alert(dd);
	}); 
	
    $('#searchbtn').click(function(){
    	page(1);
    });  
    
    
	$('#week').click(function(){
    	var now = new Date();
        var year= now.getFullYear();
        var mon = (now.getMonth()+1)>9 ? ''+(now.getMonth()+1) : '0'+(now.getMonth()+1);
        var day = now.getDate()>9 ? ''+now.getDate() : '0'+now.getDate();
                
        var chan_val = year + '-' + mon + '-' + day;
        $('#date2').val(chan_val);
        //alert($('#date2').val());
        ///////////////////////////날짜일주일빼기///////////////////
		var selectDate = $('#date2').val().split("-");
		var changeDate = new Date();
		changeDate.setFullYear(selectDate[0], selectDate[1]-1, selectDate[2]-7);

		var y = changeDate.getFullYear();
		var m = changeDate.getMonth() + 1;
		var d = changeDate.getDate();
		if(m < 10) { m = "0" + m; }
		if(d < 10) { d = "0" + d; }

		var resultDate = y + "-" + m + "-" + d;
		$("#date1").val(resultDate);
	});
	$('#month').click(function(){
    	var now = new Date();
        var year= now.getFullYear();
        var mon = (now.getMonth()+1)>9 ? ''+(now.getMonth()+1) : '0'+(now.getMonth()+1);
        var day = now.getDate()>9 ? ''+now.getDate() : '0'+now.getDate();
                
        var chan_val = year + '-' + mon + '-' + day;
        $('#date2').val(chan_val);
        //alert($('#date2').val());
        ///////////////////////////날짜한달빼기///////////////////
		var selectDate = $('#date2').val().split("-");
		var changeDate = new Date();
		changeDate.setFullYear(selectDate[0], selectDate[1]-2, selectDate[2]);

		var y = changeDate.getFullYear();
		var m = changeDate.getMonth() + 1;
		var d = changeDate.getDate();
		if(m < 10) { m = "0" + m; }
		if(d < 10) { d = "0" + d; }

		var resultDate = y + "-" + m + "-" + d;
		$("#date1").val(resultDate);
	});
	$('#3month').click(function(){
    	var now = new Date();
        var year= now.getFullYear();
        var mon = (now.getMonth()+1)>9 ? ''+(now.getMonth()+1) : '0'+(now.getMonth()+1);
        var day = now.getDate()>9 ? ''+now.getDate() : '0'+now.getDate();
                
        var chan_val = year + '-' + mon + '-' + day;
        $('#date2').val(chan_val);
        //alert($('#date2').val());
        ///////////////////////////날짜세달빼기///////////////////
		var selectDate = $('#date2').val().split("-");
		var changeDate = new Date();
		changeDate.setFullYear(selectDate[0], selectDate[1]-4, selectDate[2]);

		var y = changeDate.getFullYear();
		var m = changeDate.getMonth() + 1;
		var d = changeDate.getDate();
		if(m < 10) { m = "0" + m; }
		if(d < 10) { d = "0" + d; }

		var resultDate = y + "-" + m + "-" + d;
		$("#date1").val(resultDate);
	});
});
</script>

<div>
<center>
<table >
<col width="200"/><col width="150"/><col width="350"/>
	<tr>
		<td height="50" style="text-align: center; " ><h4><b>예약내역</b></h4></td>
		<td height="50" style="text-align: center; border-right-color: #f3f3f3;">예약기간조회</td>
		<td height="50" style="text-align: center;">
			<form>
				<button type="button" name="week" id="week">1주일</button>
				<button type="button" name="month" id="month">1개월</button>
				<button type="button" name="3month" id="3month">3개월</button><br>
				<input type="date" name="date1" id="date1" value="<%=todaydate %>" max="<%=todaydate%>" />
				~
				<input type="date" name="date2" id="date2" value="<%=todaydate %>" min="<%=todaydate%>" />
				<button type="button" name="searchbtn" id="searchbtn">조회</button>
			</form>
		</td>
	</tr>
</table>
</center>
</div>



<div style="padding-top: 30px">
<center>
<table bordercolor="#000000" id="reservetable">
<col width="100"/><col width="100"/><col width="200"/>
<col width="100"/><col width="100"/><col width="100"/>
	<tr bgcolor="#808000" height="30" id="headertr">
		<th style="text-align: center;"><b>예약일자</b></th>
		<th style="text-align: center;"><b>사용일자</b></th>
		<th style="text-align: center;"><b>예약자</b></th>
		<th style="text-align: center;"><b>방종류</b></th>
		<th style="text-align: center;"><b>총 결제금액</b></th>
		<th style="text-align: center;"><b>승인여부</b></th>
	</tr>
	
 	<tr height="30">
 		<td colspan="6">날짜를 선택해주세요</td>
 	</tr>
 	
</table>
</center>
</div>
<div>
<center>
<table style="width: 50%; margin: auto;" id="pagingtable">
	<col width="100"/><col width="100"/><col width="200"/>
	<col width="100"/><col width="100"/><col width="100"/>
 	
	
	</table>
</center>
</div>

</body>
</html>