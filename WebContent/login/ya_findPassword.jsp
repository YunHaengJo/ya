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
<!-- 이용약관 -->	
	<div class="container" style="padding-top: 260px; padding-bottom: 260px; padding-left: 330px; padding-right: 330px">
	  <h3>비밀번호 찾기</h3>
	  
	  <form>
	  	<p></p>
	  	가입된 이메일로 계정을 입력하시면, 현재의 비밀번호를 전송해 드립니다.
	    <div class="input-group">
	      <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
	      <input id="email" type="text" class="form-control" name="email" placeholder="Email" style="width: 500px; height: 50px">
	    </div>
	 	<p></p>
	    <div class="input-group">
	    <input type="submit" class="btn btn-info" value="Trasfer" style="background-color: #ffe6ee; font-size: 30px; width: 538px; height: 50px">
	    </div>
	  </form>
	  <br>
	</div>
<!--Foot -->
	<jsp:include page="../super/superFoot.jsp"></jsp:include>
</body>
</html>