<%@page import="com.Beans.Ya_MotelBean"%>
<%@page import="com.Dao.MotelDao"%>
<%@page import="com.Beans.Ya_MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%
	Ya_MemberBean memberBean = (Ya_MemberBean)session.getAttribute("member");
	MotelDao motelDao = MotelDao.getInstance();
	
	Ya_MotelBean motelBean = new Ya_MotelBean();
	motelBean = (Ya_MotelBean)motelDao.do_detail(memberBean.getMotel_num());
	
	String filename = motelBean.getImgs().get(0).getImg_name();
	
	filename = filename.substring(19, filename.length());
%>
<script type="text/javascript">
$(document).on('click', '.browse', function(){
	  var file = $(this).parent().parent().parent().find('.file');
	  file.trigger('click');
	});
$(document).on('change', '.file', function(){
	 $(this).parent().find('.form-control').val($(this).val().replace(/C:\\fakepath\\/i, ''));
});
</script>
<title>Insert title here</title>
</head>
<body>
<h3> 모텔정보수정 </h3>
<div class="container" style="width: 605px">
	  <form name="myForm" method="post" enctype="multipart/form-data" action="../login/ya_loginControl.jsp?command=motelupdate">
	    <div class="input-group">
	      <span class="input-group-addon"><i class="glyphicon glyphicon-home"></i></span>
	      <input id="motel" type="text" class="form-control" name="motel" style="width: 605px; height: 50px" value="<%=motelBean.getName() %>">
	    </div>
	    <p></p>
	    <div class="input-group">
	      <span class="input-group-addon"><i class="glyphicon glyphicon-map-marker"></i></span>
	      <input id="address" type="text" class="form-control" name="address" style="width: 500px; height: 50px" value="<%=motelBean.getAddress() %>" readonly="readonly">
	      <span class="input-group-addon" style="background-color: #9eaabc"><input type="button" class="form-control" name="addressCk" value="우편검색" style="background-color: #9eaabc; border: 0; outline: 0"></span>
	    </div>
	    <p></p>
	    <div class="input-group">
	      <span class="input-group-addon"><i class="glyphicon glyphicon-phone"></i></span>
	      <input id="phone" type="text" class="form-control" name="phone" style="width: 605px; height: 50px" value="<%=motelBean.getPhone() %>">
	    </div>
	    <p></p>
	    <div class="input-group">
	      <span class="input-group-addon"><i class="glyphicon glyphicon-time"></i></span>
	      <select name="checkIn" id="checkIn" class="form-control" style="width: 150px; height: 50px">
	      	<option value="-1">CheckIn</option>
	      	<option value="18" selected="selected">18:00</option>
	      	<option value="19">19:00</option>
	      	<option value="20">20:00</option>
	      	<option value="21">21:00</option>
	      	<option value="22">22:00</option>
	      	<option value="23">23:00</option>
	      </select>
	      <span class="input-group-addon"><i class="glyphicon glyphicon-time"></i></span>
	      <select name="checkOut" id="checkOut" class="form-control" style="width: 150px; height: 50px">
	      	<option value="-1">checkOut</option>
	      	<option value="9">09:00</option>
	      	<option value="10">10:00</option>
	      	<option value="11" selected="selected">11:00</option>
	      	<option value="12">12:00</option>
	      	<option value="13">13:00</option>
	      	<option value="14">14:00</option>
	      </select> 
	    </div>
	    <p></p>
	    <div class="input-group">
	      <span class="input-group-addon"><i class="glyphicon glyphicon-usd"></i></span>
	      <select name="normalPrice" id="normalPrice" class="form-control" style="width: 150px; height: 50px">
	      	<option value="-1">일반실 가격</option>
	      	<option value="40000" selected="selected">40000</option>
	      	<option value="50000">50000</option>
	      	<option value="60000">60000</option>
	      	<option value="70000">70000</option>
	      	<option value="80000">80000</option>
	      	<option value="90000">90000</option>
	      </select>
	      <span class="input-group-addon"><i class="glyphicon glyphicon-usd"></i></span>
	      <select name="premiumPrice" id="premiumPrice" class="form-control" style="width: 150px; height: 50px">
	      	<option value="-1">특실 가격</option>
	      	<option value="60000" selected="selected">60000</option>
	      	<option value="70000">70000</option>
	      	<option value="80000">80000</option>
	      	<option value="90000">90000</option>
	      	<option value="100000">100000</option>
	      	<option value="110000">110000</option>
	      </select> 
	    </div>
	    <p></p>
	    <div class="input-group">
	      <span class="input-group-addon"><i class="glyphicon glyphicon-th-large"></i></span>
	      <select name="normalCnt" id="normalCnt" class="form-control" style="width: 150px; height: 50px">
	      	<option value="-1">일반실 방 수</option>
	      	<option value="1">1</option>
	      	<option value="2">2</option>
	      	<option value="3" selected="selected">3</option>
	      </select>
	      <span class="input-group-addon"><i class="glyphicon glyphicon-th-large"></i></span>
	      <select name="premiumCnt" id="premiumCnt" class="form-control" style="width: 150px; height: 50px">
	      	<option value="-1">특실 방 수</option>
	      	<option value="0" selected="selected">0</option>
	      	<option value="1">1</option>
	      	<option value="2">2</option>
	      	<option value="3">3</option>
	      </select> 
	    </div>
	    <p></p>
	    <div class="input-group">
	      <span class="input-group-addon"><i class="glyphicon glyphicon-th-large"></i></span>
	      <select name="normalImgCnt" id="normalImgCnt" class="form-control" style="width: 150px; height: 50px">
	      	<option value="-1">일반실 사진 수</option>
	      	<option value="1">1</option>
	      	<option value="2">2</option>
	      	<option value="3" selected="selected">3</option>
	      </select>
	      <span class="input-group-addon"><i class="glyphicon glyphicon-th-large"></i></span>
	      <select name="premiumImgCnt" id="premiumImgCnt" class="form-control" style="width: 150px; height: 50px">
	      	<option value="-1">특실 사진 수</option>
	      	<option value="0" selected="selected">0</option>
	      	<option value="1">1</option>
	      	<option value="2">2</option>
	      	<option value="3">3</option>
	      </select> 
	    </div>
	    <p></p>
			<div class="form-group">
				<input type="file" name="mainimg" id="mainimg" class="file" style="visibility: hidden;">
				<div class="input-group col-xs-15">
					<span class="input-group-addon">
					<i class="glyphicon glyphicon-picture"></i>
					</span> 
						<input type="text" class="form-control input-lg" disabled value="<%=filename %>" style="width: 500px;">
						<span class="input-group-btn">
						<button class="browse btn btn-primary input-lg" type="button">
							<i class="glyphicon glyphicon-search"></i> Browse
						</button>
					</span>
				</div>
			</div>
			<p></p>
	    <div id="imgTable1" class="input-group">
	    </div>
	    <p></p>
	     <div id="imgTable2" class="input-group">
	    </div>
		<br>
	    <div class="input-group">
	     <input type="submit" class="btn btn-info" value="수정"
						style="background-color: #ff6b6b; font-size: 30px; width: 605px; height: 50px; border: 0; outline: 0">
	    </div>
	    <br>
	  </form>
	  <br>
	</div>
</body>
</html>