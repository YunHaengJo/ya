<%@page import="com.Beans.Ya_MemberBean"%>
<%@page import="com.Beans.Ya_ReserveBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.Dao.ReserveDao"%>
<%@page import="java.util.Calendar"%>
<%@page import="com.Dao.MyPageDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
function choice(choicevalue,seqNum,motel_num){
	if(choicevalue==0){
		// 예약취소
		var seq = seqNum;
		//alert("예약취소"+seq);
		$.ajax({
			type:"POST",
			url:"../mypage/ya_Guest_Reserve_Cancle.jsp",
			dataType:"html",
			data:{
				"seq":	seq
			},
			success:function(data){
				console.log("success\t"+data);
				var flag = $.parseJSON(data);
				//var pay_dt = flag.pay_dt;
				console.log("complete="+flag);
				page(1);
			},
			complete : function(data) {
		        // 통신이 실패했어도 완료가 되었을 때 이 함수를 타게 된다.
	        	console.log("complete"+data);
	        },           
	        error:function(){
	        }
		});	 
	}else if(choicevalue==1){
		// 리뷰달기
		//alert("리뷰달기");
		
		window.open('ya_Guest_Review_Write.jsp?command='+motel_num, '리뷰달기', 'width=800, height=600, left=700, top=100, toolbar=no,location=no,directories=no,status=no,menubar=no,resizable=no,scrollbars=no,copyhistory=no');
		
		/* window.open('ya_Guest_Review_Write.jsp?date='+$('#date').val()+'&check='+$('#prepri').val(), '결제창', 
		'width=600, height=800, left=700, top=100, toolbar=no,location=no,directories=no,status=no,menubar=no,resizable=no,scrollbars=no,copyhistory=no' ) */
	}else if(choicevalue==2){
		//예약취소완료
		alert("예약취소완료상태입니다.");
	}
}

// 실질적으로 예약 내역 뿌리는 부분 
function page(page){
	var date1 = $('#date1').val();
	var date2 = $('#date2').val();
	// 문제없음 
	var pageNum = page;
	//console.log(date1);
	//console.log(date2);
    
	$.ajax({
        type:"POST",
        url:"ya_Guest_Reserve_Check.jsp",
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
            		var motel_num = beanData[i].motel_num;
            		var choicevalue;
            		//console.log("test="+beanData[i].name);	// 데이터 잘 받는지 모텔 이름 확인
            		//console.log("test="+beanData[i].motel_num);
            		if(state==0){
            			state="예약취소";
            			choicevalue="0"
            		}else if(state==1){
            			state="리뷰달기";
            			choicevalue="1"
            		}else if(state==2){
            			state="예약취소완료";
            			choicevalue="2"
            		} 
            		$('#reservetable').append('<tr height="30"><td style="border-bottom: 1px solid black;">'+pay_dt+'</td><td style="border-bottom: 1px solid black;">'+use_dt+'</td><td style="border-bottom: 1px solid black;">'+name+'</td><td style="border-bottom: 1px solid black;">'+roomtype+'</td><td style="border-bottom: 1px solid black;">'+price+'</td><td style="border-bottom: 1px solid black;"><button type="button" id="reservechoice" onclick="choice('+choicevalue+','+seq+','+motel_num+')">'+state+'</button></td></tr>'); 
            	}
            	$("#reservetable").append('<tr height="20"><td colspan="6" ></td></tr>');
                       	
            	// 페이징 숫자 처리 부분 
            	var pageCount = 0; 
            	
            	if(totCnt%3>0){
            		pageCount=Math.floor(totCnt/3)+1;
            	}else{
            		pageCount=Math.floor(totCnt/3);
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
    // 날짜 변경
	$('#date1').change(function(){
    	var date1 = $('#date1').val();
    	var date2 = $('#date2').val();
    	//alert(date);
    	
    	$("#date2").attr( 'min', date1 );
    	//$("#date1").attr( 'max', date2 ); 맥스를 새로 설정할 필요없어서 주석 
    	//var dd = "min='"+date+"'";
    	//alert(dd);
	}); 
	
    
    $('#searchbtn').click(function(){
    	page(1);
    });  
    
    // 일주일 넘기기 
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
	// 한달 넘기기 
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
	// 세달 넘기기 
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
		<th style="text-align: center;"><b>모텔이름</b></th>
		<th style="text-align: center;"><b>방종류</b></th>
		<th style="text-align: center;"><b>총 결제금액</b></th>
		<th style="text-align: center;"><b>상태</b></th>
	</tr>
	<tr height="20">
	<td colspan="6" >날짜를 선택해주세요.</td>
	</tr>
</table>
</center>
</div>
<div>
<center>
<table style="width: 50%; margin: auto;" id="pagingtable">
	<col width="222"/><col width="222"/><col width="222"/>
   	<col width="222"/><col width="222"/><col width="222"/>
   	<col width="222"/><col width="222"/><col width="222"/>
    <%-- <tr>
    	<td colspan="9" align="center">
    	<%
    	String str = " ";
    	int pageCount = 0;
    	if(bean_list.size()!=0){
    		pageCount = bean_list.get(0).getTot_cnt()%5 > 0 ? (bean_list.get(0).getTot_cnt()/5)+1 : (bean_list.get(0).getTot_cnt()/5); 
    	}else{
    		pageCount = 1;
    	}
    	for(int i=0; i<pageCount;i++){
    	%>
    	<a href="javascript:;" onclick= "location.href='mypage_Control.jsp?command=guestpointlist&value=after&pageNum=<%=i+1 %>&email=<%=email%>'" >
    	<font size="3">
    	<%=i+1 %><%=str %>
    	<%} %>
    	</font>
    	</a>
    	</td>
    </tr> --%>
	
	
	</table>
</center>
</div>

</body>
</html>