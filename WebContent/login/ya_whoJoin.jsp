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
	
	.blank{
		height: 100px;
	}
	.location{
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
<!-- host/guest -->	
	<div class="container" style="padding-top: 250px; padding-bottom: 250px; padding-left: 30px; padding-right: 15px">
	  
	  <form>
	  	<p></p>
	    <div style="width: 2000px;">
	    <a href="ya_guestJoin.jsp">
	    	<img src="../img/letter_G_red.png" width="100">
	    	<img src="../img/letter_U_red.png" width="100">
	    	<img src="../img/letter_E_red.png" width="100">
	    	<img src="../img/letter_S_red.png" width="100">
	    	<img src="../img/letter_T_red.png" width="100">
	    </a>
	    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	    <a href="ya_hostJoin.jsp">
	    	<img src="../img/letter_H_blue.png" width="100">
	    	<img src="../img/letter_O_blue.png" width="100">
	    	<img src="../img/letter_S_blue.png" width="100">
	    	<img src="../img/letter_T_blue.png" width="100">
	    </a>   
	    </div>
	  </form>
	  <br>
	</div>
<!--Foot -->
	<jsp:include page="../super/superFoot.jsp"></jsp:include>
</body>
</html>