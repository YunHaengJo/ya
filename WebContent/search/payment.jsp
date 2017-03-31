<%@page import="com.Dao.MemberDao"%>
<%@page import="com.Beans.Ya_MemberBean"%>
<%@ page pageEncoding="UTF-8" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%
request.setCharacterEncoding("UTF-8");
%>
<%!//
//%>
<%//
String date = request.getParameter("date");
String roomType = request.getParameter("check");
//%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script type="text/javascript">




//떄려박아

$(document).ready(function(){
$("#Btn").click(function() {
		   
	   $("#totPay").attr("value",Number($("#onPa").val())-Number($("#usePoint").val()));
	   
	   
	});
	
$("#pamen").click(function(){
	var animal = $(':input[name=chk_info]:radio:checked').val();

    if($('#naid').val()==null || $('#naid').val()==""){
    	alert("이름을 입력해주세요");
    }else{
	        	
	if( animal ){
    	alert(animal+"카드로 결제 되었습니다.")
       	$("#reserName", opener.document).val($("#naid").val());
    	$("#reserPoint", opener.document).val($("#popo").val());
    	
    	//opener.document.getElementById("reserName").value = "c_val";
    	//opener.document.getElementById("reserPoint").value = "c_val";
    	
    	opener.location.href="javascript:p_reser();";
    	self.close();
    	
    }else{
        alert("카드사를 선택해주세요");
        
    }  
    }
    
});
	
});

$(function() {
    $("#popo").keyup(function(){
    	    	
    	if(Number($("#hid").val())<Number($("#popo").val())){
    		$("#usePoint").attr("value",$("#popo").val());
    		alert("사용가능한 포인트보다 큽니다.");
    		$("#Btn").focus();
    		$("#usePoint").attr("value","0");
    		$(this).val('0');
    		
    		
    	} 
    	if( Number($("#onPa").val())<Number($("#popo").val()) ){
    		$("#usePoint").attr("value",$("#popo").val());
    		alert("결제금액보다 포인트보다 큽니다.");
    		$("#Btn").focus();
    		$("#usePoint").attr("value","0");
    		$(this).val('0');
    		}
    		
    	$("#usePoint").attr("value",$("#popo").val());
    	
        	
    });
   
  
    
});


</script>
<style>
</style>
</head>
<body>

<h1>예약</h1>
<hr>
<p>날짜 : <input type="text" value=<%=date %> readonly="readonly"></p>
<p>예약자이름 : <input type="text" id="naid"></p>
<p>메일 주소 : <input type="text"
<% if(session.getAttribute("member")!=null){ 
	Ya_MemberBean memberBean = (Ya_MemberBean)session.getAttribute("member"); 
		 %>
 value = <%=memberBean.getEmail() %> readonly="readonly"
<%
}
%>
></p>
<hr>
<p>포인트 할인 : <input type="text" value="0" id="popo" ><button id="Btn">포인트 사용하기</button></p>
<div>   ※사용할 포인트를 입력해주세요 
<br>
		사용가능한 포인트 : <% 
		if(session.getAttribute("member")!=null){ 
			Ya_MemberBean memberBean = (Ya_MemberBean)session.getAttribute("member"); 
			MemberDao dao = MemberDao.getInstance();
			int point = dao.do_search_point(memberBean.getEmail());
		%> 
	<input type="hidden" id="hid" value="<%=point %>">
	<%=point %>포인트
	<%
	}
     %>
</div>
<hr>
<p> 총 주문 금액 : <input type="number" id= "onPa" value="<%=roomType%>" readonly="readonly"></p>
<p> 총 할인 금액 : <input type="text" id="usePoint" value="0" readonly="readonly"></p>
<p> 총 결제 금액 : <input type="number" id="totPay" value="<%=roomType%>" readonly="readonly"></p>
<br>
<hr>
<p> <h2>카드결제</h2> </p>
<h3><input type="radio" name="chk_info" value="신한">신한 &nbsp;&nbsp;
<input type="radio" name="chk_info" value="현대">현대 &nbsp;&nbsp;
<input type="radio" name="chk_info" value="하나">하나 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type="radio" name="chk_info" value="외환">외환 &nbsp;&nbsp;
<input type="radio" name="chk_info" value="KB국민">KB국민 &nbsp;&nbsp;<br>
<input type="radio" name="chk_info" value="비씨">비씨 &nbsp;&nbsp;
<input type="radio" name="chk_info" value="롯데">롯데 &nbsp;&nbsp;
<input type="radio" name="chk_info" value="NH채움">NH채움 &nbsp;&nbsp;
<input type="radio" name="chk_info" value="삼성">삼성 &nbsp;&nbsp;
<input type="radio" name="chk_info" value="씨티">씨티</h3> &nbsp;&nbsp;
<br><br>

<button id="pamen"><font size="30">결제하기</font></button>


</body>
</html>