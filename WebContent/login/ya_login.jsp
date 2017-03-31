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

<!-- prevent IE6 flickering -->
<script type="text/javascript">
    try {
        document.execCommand('BackgroundImageCache', false, true);
    } catch (e) {
    }
</script>

<title>Insert title here</title>
<style type="text/css">
	.header{
		position : fixed;
		height : 100px;
		background: #fc676e;
	}
	.foot{
		height : 200px;
		background: #3f3e3e;
	}
	.blank{
		height: 100px;
	}	.location{
		padding-top : 50px;
		height: 300px;
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
	.checkbox-wrap { cursor: pointer; }
	.checkbox-wrap .check-icon  { display: inline-block; width: 18px; height: 18px; background: url(../img/unchecked.png) left center no-repeat; vertical-align: middle; transition-duration: .3s; }
	.checkbox-wrap input[type=checkbox] { display: none; }
	.checkbox-wrap input[type=checkbox]:checked + .check-icon { background-image: url(../img/checked.png)
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
	 
	
<!-- 로그인 -->	

	<div class="container" style="padding-top: 200px; padding-bottom: 200px; padding-left: 330px; padding-right: 330px">
	  <h3>로그인</h3>
	  
	  <form action="ya_loginAfter.jsp?type=login" method="post" name="myForm" id="myForm">
	    <div class="input-group">
	      <span class="input-group-addon"><i class="glyphicon glyphicon-envelope"></i></span>
	      <input id="email" type="text" class="form-control" name="email" placeholder="Email" style="width: 500px; height: 50px">
	    </div>
	    <div class="input-group">
	      <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
	      <input id="password" type="password" class="form-control" name="password" placeholder="Password" style="width: 500px; height: 50px">
	    </div>
	    <div class="input-group">
	    <input type="checkbox" id="cb_saveId" />
		<label for="checkbox1" name="checkbox1_lbl" >이메일 저장</label>
		</div>
		<br>
	    <div class="input-group">
	    <input type="button" onclick="mySubmit(1)" class="btn btn-info" value="LOGIN" style="background-color: #ff6b6b; font-size: 30px; width: 538px; height: 50px; border: 0; outline: 0">
	    </div>
	    <br>
	    <a href="ya_findPassword.jsp"><span class="glyphicon glyphicon-search"></span>비밀번호를 잊어버리셨나요?</a>
	    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	    <a href="ya_whoJoin.jsp"><span class="glyphicon glyphicon-envelope"></span>야하자 이메일로 회원가입</a> 
	  </form>
	  <br>
	</div>
	<script type="text/javascript">

 ///////////////////////////////////////////////
 (function init(){

  // 쿠키값을 가져온다.

  var cookie_email = getLogin();

  if(cookie_email != "") {

   document.getElementById("email").value = cookie_email;
   cb_saveId.checked = true;
  }

 })()//생성자초럼 호출하지 않아도 바로 실행된다
 // 로그인 버튼 클릭시

 function mySubmit(index) {
  
   console.log("mySubmit="+index); 
  if(index==1){
   if(cb_saveId.checked == true){
    saveLogin(document.getElementById("email").value);
   }else{
    saveLogin("");
   }
  }
  if(index==2){
   document.myForm.action='join.html';
  }
  console.log("document.myForm.action="+document.myForm.action.value);
  
  document.myForm.submit();
 }

 function saveLogin(email) {

  if(email != "") {

  // useremail 쿠키에 email 값을 7일간 저장

  setSave("useremail", email, 7);

  }else{

  // useremail 쿠키 삭제

  setSave("useremail", email, -1);

  }

 }

 function setSave(name, value, expiredays) {

  var today = new Date();

  today.setDate( today.getDate() + expiredays );

  document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + today.toGMTString() + ";"

 }

 function getLogin() {

  // useremail 쿠키에서 email 값을 가져온다.

  var cook = document.cookie + ";";

  var idx = cook.indexOf("useremail", 0);

  var val = "";



  if(idx != -1) {

  cook = cook.substring(idx, cook.length);

  begin = cook.indexOf("=", 0) + 1;

  end = cook.indexOf(";", begin);

  val = unescape(cook.substring(begin, end));

  }

  return val;

 }

</script>
<!--Foot -->
	<jsp:include page="../super/superFoot.jsp"></jsp:include>
</body>
</body>
</html>